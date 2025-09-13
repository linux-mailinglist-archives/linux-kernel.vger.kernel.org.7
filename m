Return-Path: <linux-kernel+bounces-815256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A2EB561C8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252041BC46C0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039142F1FD6;
	Sat, 13 Sep 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhGLGWsj"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17E6FC5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776987; cv=none; b=GvglSvwxa7BpUeNbY+D8qa+19vzoNVLcVV/qCI3q4G8sLrNiJ61fcuG/YjKuCeilm6a6sRZR6oMVlAw+Lod/KZLHiZrUDmcQrB3Qk+IEIxk1Ysw8XWwqw30iHDOd2OpLQIqMqehxCZa7lYAJxISCYOKPRf2hKXAAwJsMBXq9wug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776987; c=relaxed/simple;
	bh=1g1d7vi7SmA4P5KNPKKgxt93/R0/R/XgWQ4icZrbp5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mqg9wTB5EqF3mhlsoTp26F3MjaqkQeh3DpwJaErvB5VIPSFAcW1MsEy7QMmKwz7WUbRjdSA2BUZA+VKZv6uZsUyGr+lvt9MQwk1vrXg6HnCJaoBxIB8CkYBqjuvWdIXNTRK0a5JZxHZhMrbJ0eKTkI46R7/DOmSQIABX919gbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhGLGWsj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-778d99112fbso3098016d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757776984; x=1758381784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/TRnZ2sRv5uxQ4sMsYogqX81mwu1+9Krr0oG8ycgcM=;
        b=MhGLGWsjUMQ/jVxixAD4hRcPc7+1/n5zp82lef02c92TBCCuq8MBCGWqRkTXbe6lIq
         Fn9Dm2Yd33SfJxMgyU369KE9JXs9S2aTp/DQscZboSX6vN61C8A8KtgzT9QWhL21ajmE
         Cr1+nKNQRZTPSX91ViEESoJ2PrkCneJVOlS3yNtXkaitLwxdgRTMl7ehE7FWQ8Wt1OrH
         fRUSWGdLOsGJ0Z/fYkCsA8jJf7XbgmH9b4nacl50JRxM34whmsRWB2dYcBPTvdVM/9OB
         rzATk2NB8rd1LBYFSUZLphDYuJlZhrggUuJul6udccCYEumqPrcr6q9Y/zqLINZwgHyu
         rxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757776985; x=1758381785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/TRnZ2sRv5uxQ4sMsYogqX81mwu1+9Krr0oG8ycgcM=;
        b=osv9SJlrG4AVU6fKhEP0ea1FkZDG5SUsAtSnKTFn34ly/6mztDGOH+J0mioSKQQo5p
         RPLCGhGekZ4hq+syB6TA6y7OGl56CTOb+kIzXPYFCiiYV0B8Blu05Fb84w0aCjtw23jF
         zplXtcs/OBMXj9HLFiRRVd7DmZKCJiblHEjmXSHZQhR4rpSPaU5SxG2amGVFBEQJXw63
         ltb5GKYGPYjHb/96NbXzkHK+6ECyqwew8WFUI63BnMHSZtFt9N1KHgIn4mDF0t1nvasX
         yFKX/eydXrxFJBsK0s/+KvRLOUPxdppdzfKD0PFPak0OA19Uk9R8DLN3fT2iJVoLK2kX
         t5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI7DRh85mTrEVehd1UEACj51bUth0zPbYVn6Gia/4TeoHQHqK4Is1eP56aLHZePkWPDjlENrYwuSFu1QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVb2tLaeHvIdXZgRv1AWRbvrzE4IPlyIyzxbEHHq3fHejpI0j4
	4/mbUbnJz6IL13FvdHA2XDAmYs1KmW0jQ4+kq2oHBXOUcOjyZbcZlAXp
X-Gm-Gg: ASbGncvHwBOjU0CcSRgj57xc9oZYMTz2IIhc8AvKSRXoHwzw97oqyfZhle0mpJuB/DH
	0u1Tt3w+MD5k+HifaOgmF/RhO3Qz3qD9cMBGHrD0gvsc0VK25y+TZMdaeG2rG1CxPnKGpOdf1vu
	2KzUWpz1X40bDcStydYT1oBVYAqWLk4107If3563ad6iUY5i/oLpZIRylXVmYM3TFtmw6oZ0oxH
	u/Ovkx67I3r6BSmMyki2Q2ya5ZBOI8nML9H11BGvPBv5OxOR9NlMxet7uZqOGEO7ICKlOtuoLgb
	KvkklsXf/h+GZNaeIyBQZmvO1F/Vs8tyCGR20Q8kYIGq+9cde2p+XSBtQ+1V+e+4X5PbC+NO2Rs
	sQxWQc6fTU8Mtju4dQnVmwv7lK2aVeguqKfx+//qHhpVqDzgvLPWhjjyLt+xMjJCXJbOG3Zh1Dr
	/0IJL1lRwQbHoZGF0XYVRg+sfEti0oaT8mXQ==
X-Google-Smtp-Source: AGHT+IGgB/zljEWOm+CWAoBvJiHO14i0pvdl1uKBmo87/U7zbUsK3Rj3ElDMaHyhBh+avm+k2/T/VQ==
X-Received: by 2002:a05:6214:b6a:b0:77a:29ba:1b68 with SMTP id 6a1803df08f44-77a2a15a977mr7984936d6.63.1757776984572;
        Sat, 13 Sep 2025 08:23:04 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-76ea4229bdesm22431436d6.45.2025.09.13.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 08:23:04 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 92F72F40068;
	Sat, 13 Sep 2025 11:23:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 13 Sep 2025 11:23:02 -0400
X-ME-Sender: <xms:VozFaD-dxD-vGV4fXChW-RQ3Cjl_WRoEnpNXwOUe_NXnW3iUbUyAkQ>
    <xme:VozFaKW9keWLMV51Dk1wGgddnNj5bnKtPYMPTFBoXd2z2of419x2WcXrtsBJvAZaB
    X-_0Ct-vgNgcT_PTA>
X-ME-Received: <xmr:VozFaHCzLat2TmnO5Ln71DUb4AyL7So0wHyqm29cuAK_JQMazrR5BRtCWWCfJqlJgcR8CiIeOiY9LfhMW4JP5ll-1cuJrYWp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefvddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepfeffudehveduteeuffeutdetieeftdelfeelveffffevteeffedtteehteegkeeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpdhgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehovgdqkhgsuhhilhgu
    qdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvlhhlvgesfigvrg
    hthhgvrhgvugdqshhtvggvlhdruggvvhdprhgtphhtthhopegsohhquhhnsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:VozFaPEC80WePesmQQeGFj9qho7EdDzxIoooO0p1nVtv5M1sPpK7kQ>
    <xmx:VozFaI6tFEmL4vkxd2_ZtKQn9HjUtqx1URnYA6hHMNOgbLbk-bgXhA>
    <xmx:VozFaFmySUj-NdHxOud9k1PHJkBXlvL4Sn0GoGhqU4wx3F4OJQiX9Q>
    <xmx:VozFaD7nHcZWWAg4kgj6kgmKWrsCddWNE9JPKL8ptc7VVpccS5bnag>
    <xmx:VozFaGQBw4W0a4NeAmHpC7kQiC9Eh2FEquYgzP8pFZqyqfiReDrvY0_q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 11:23:02 -0400 (EDT)
Date: Sat, 13 Sep 2025 08:23:01 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: Re: [tip:locking/core 1/13] error[E0425]: cannot find function
 `atomic_add` in crate `bindings`
Message-ID: <aMWMVQiZxE_mv7va@tardis.local>
References: <202509131610.IPwv7fy3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509131610.IPwv7fy3-lkp@intel.com>

Hi Peter,

On Sat, Sep 13, 2025 at 04:00:27PM +0200, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> head:   502ae97746ab6d7b7b48d54b6a85a11815f390d0
> commit: eb57133305f61b612252382d0c1478bba7f57b67 [1/13] rust: sync: Add basic atomic operation mapping framework

I think we are missing this patch:

	https://lore.kernel.org/rust-for-linux/20250905044141.77868-2-boqun.feng@gmail.com/

in locking/core. It should be applied before all atomic patches.

Regards,
Boqun

> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250913/202509131610.IPwv7fy3-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250913/202509131610.IPwv7fy3-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509131610.IPwv7fy3-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> error[E0425]: cannot find function `atomic_read_acquire` in crate `bindings`
>    --> rust/kernel/sync/atomic/internal.rs:124:37
>    |
>    124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
>    |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
>    ...
>    201 | / declare_and_impl_atomic_methods!(
>    202 | |     /// Basic atomic operations
>    203 | |     pub trait AtomicBasicOps {
>    204 | |         /// Atomic read (load).
>    ...   |
>    216 | | );
>    | |_- in this macro invocation
>    |
>    = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
> --
[...]

