Return-Path: <linux-kernel+bounces-840568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73462BB4B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF113A88BF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43926F46E;
	Thu,  2 Oct 2025 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFKkt5dR"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E8262FD9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426078; cv=none; b=j6ZMON8hD1ZiTWweqOwnurTG2athnsxeEK9dPKFCxu6iFxbw7/2SZllsUc/OOFeVZkxTRYtfrvaUSfRgP3U9fXv0mKhaFj4dkX8DxmxHidUnNv7vMs12+yNIFLO2bhNC8oz8sdG+3S9bHqsR7+kDA/tja/+9dyFQpWPwPwqnQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426078; c=relaxed/simple;
	bh=cWzC3kpiFoS7bFlguX/uWdST2iyXc6tjOoVur7QElWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA1EOOaXc8oGRdMZ05H9R4rn5jiDuverN+ukMUOxTiXst3pG44bT0AGR9o9ebgEbikBaILn7UAAvtK+LGpvQvgo6rderzNVrBI6Ewin4hXEmSo6Ywbw28XxhNsgCD/FLhtJaw/KeM0gNbiVudGn+FPZUJPnsx/FgsbJQCPUsPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFKkt5dR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8572d7b2457so150973485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759426075; x=1760030875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTM0UQL/8j7dglCka3v9L9QTEMlq52c4L0JAQ1Z24Bs=;
        b=UFKkt5dRE2vSV2G87hBC3WxGnPx1MawlU9NxW/NYyxeZxLV2V5jKPR/prEJFTnSpWk
         Vd5ct8UmGbOtF74RyXlUV9IT9RSHsRWk8SshJBiZyBUfdBqPkQ5lzIvcNSnJWH1UIaFV
         sYysib3MTvCcqQw+NqHJliCKRdUwl4lspbJ3qG+qycWohIRD2OlydF5tRDANlmEcfdWs
         gRiYW646/gq/9mME0+1RPkaTW5zhVPxvpasxMHYnO4auCf3niRLg81pluLDlO7oUuUjK
         7i44MVZYtsxZ4oezNgJzzDwM1izWv1x9bHbcr6nvom17tdi8Yhr3afgulEk56D6AwY29
         hqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759426075; x=1760030875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTM0UQL/8j7dglCka3v9L9QTEMlq52c4L0JAQ1Z24Bs=;
        b=PG+cUNgy/qCnc364YXAi2H3FLnkTzAamxIY8cqI57uiB0vA7lukqZoMRtxLUxhCQSo
         YvUd/Kv/enw7N4JEMBMg96hU4JmNgXxkirRllkpOjS2UP6QMX8ROQdEdNYobX+9DOY2E
         pUIu+qqycryG+E0tZkGY5zd1o6gwZ9t4zaIHBpetMHBbgJNnenecFgqI2XpTOrExfWe9
         L9hrMfplZj4b9hut8+0NK/XybBIiUg9bx/VbUi5xWkg2XjUzS9Sm+TxZU6EqKJYNlNHh
         2WKe6am2kVUhFnNvM6RQlSz/GMar7KlS7hvSNZZaPD5Qe9hrp9vJiRm+hVwZlExXg9t7
         mElw==
X-Forwarded-Encrypted: i=1; AJvYcCXCX/R2f2D37k3TbxSGfmuZmuf8/DsKnocDKh50GRqLMTzuWKymyEvbU9mCjkRT05ywy1A1Z/IBFmS+wNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyijNuKymCO89E/aGtPss6DEF3bvyW1Aor/8zakYkjKc8dJU5Ef
	6+XSmyq1z/IqA/jejbRc/JnVVl4Vca6XlTPiZBHx2OKeraN/essUZlpl
X-Gm-Gg: ASbGncu+FmK3esCAxThjOwlf29wBBO1YQckgI4iQvTktO0uRPCwtrZASvXBuj5xPI32
	/TmqHK/GunEa8pY/vvbF9h70ohn0AojCo/9sZYzwz/L2U2CRy7VRmXqGGSwaLhiil9FHDjrHKx1
	4eU2cRnO5NnlGrhxP1E/tf8+XINk+L7jerHNM3Ln8MhTarbm3VR1TVOMT9qyuI6yVYjxkIFkJ8P
	g/0Z2XeSwtSdkZ6cSx3Gy7OlVfzrgRziGljytcdeSj5sL7cb5vlpEpg3jJG17G2sl9LbBLHMlc1
	bwUaCUEMNaf0MtRjIX7mJ9JINVgi+tVod7T4oudpjaIxUMtme+kFjwB93QYtAUw5ifTHE9akpPi
	mRlsoN8YfQsx/j/Zrv1s0xwCL062f+GkgACU2DSSgFVGIptJv0pBKGOJYXlC0JL80A7acg6s2PX
	P/PT/2C/KEQ5i9zas6i6LfP8e+ERonB1hm6NdAojaBgbkTJXQ=
X-Google-Smtp-Source: AGHT+IEccWf95m9em/uI+dQlqBiU53wpoCpSc5+xQyyCCz3DNyftc7RYyrlZ2VQKH150B9/39RYCLg==
X-Received: by 2002:a05:620a:4542:b0:80b:bb34:371c with SMTP id af79cd13be357-87765c0283amr556367685a.4.1759426074903;
        Thu, 02 Oct 2025 10:27:54 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129f10sm250580785a.9.2025.10.02.10.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:27:54 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 64F31F40069;
	Thu,  2 Oct 2025 13:27:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 02 Oct 2025 13:27:53 -0400
X-ME-Sender: <xms:GbbeaA47QkWtwwPWv6vtzqHqLGFsZJYXwawRT5GZ7ove-YTVfKveog>
    <xme:GbbeaLRKare3YFvYQ8IM-3q6zMpvcmvJN3fBupwOyYuvxHTzciEIpTEH6HTjCtMJz
    Ui03Aoj6wC_x9XxdjVLoZXrwD3h3lyNY_1pwER6F99ybfMZqbhZ>
X-ME-Received: <xmr:GbbeaIkFcpyNXJiJ2YkRCL5cDJkQz13nP_ZUKR3iXf7c09R20thn7hUns-BrtUcx7vb5zVggjK5D7CpuHdVyLFtfmFh1oXW9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhf
    elleeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonh
    grlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghnghep
    pehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepgedupd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopedvgedtjedtudekfeejudesqhhqrdgt
    ohhmpdhrtghpthhtohepsgihuhhnghgthhhulhesshhkrdgtohhmpdhrtghpthhtoheplh
    hirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopegrmhhirhej
    fehilhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhguihdrshhhhihtiheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsshgvghgrlhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgrhgvgh
    hkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnrghr
    ohdqmhhmqdhsihhgsehlihhsthhsrdhlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:GbbeaIKfrjD-eqlOsaEu8oupAwCNL5B3v_jSdUHcY24JYHPWjN5_tQ>
    <xmx:GbbeaOSZC2NlhdVwmqKBdbD4NIwKEaTDKckNg4nutrEqyq1jJ65JtQ>
    <xmx:GbbeaPMPlfhxRayyy1Im8WpdH8DW6D_tTVsqfNIfnjn98KI1eVpWSA>
    <xmx:GbbeaPaxaAKzS_UqYZsc_slWPxKZim7zmb4NsaNtun6TSMRkIYCuOw>
    <xmx:GbbeaDDpRUzAmACJHoEs-WQm9-qedNFlV-mfcoTZk1unrpqOZiNLvsDC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 13:27:52 -0400 (EDT)
Date: Thu, 2 Oct 2025 10:27:51 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Guangbo Cui <2407018371@qq.com>
Cc: byungchul@sk.com, Liam.Howlett@oracle.com, amir73il@gmail.com,
	andi.shyti@kernel.org, andrii@kernel.org, bsegall@google.com,
	gregkh@linuxfoundation.org, linaro-mm-sig@lists.linaro.org,
	link@vivo.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	masahiroy@kernel.org, mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com, max.byungchul.park@gmail.com,
	mcgrof@kernel.org, melissa.srw@gmail.com, mgorman@suse.de,
	mhocko@kernel.org, minchan@kernel.org, oleg@redhat.com,
	paulmck@kernel.org, penberg@kernel.org, peterz@infradead.org,
	petr.pavlu@suse.com, torvalds@linux-foundation.org,
	vincent.guittot@linaro.org, will@kernel.org, yeoreum.yun@arm.com,
	ysk@kzalloc.com, rust-for-linux@vger.kernel.org, ojeda@kernel.org,
	gary@garyguo.net, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, dakr@kernel.org, alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com
Subject: Re: [PATCH] rust: bindings: add `rust_helper_wait_for_completion`
 helper function
Message-ID: <aN62F8t493R7UmCT@tardis.local>
References: <20251002081247.51255-37-byungchul@sk.com>
 <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>

On Thu, Oct 02, 2025 at 10:06:17AM +0000, Guangbo Cui wrote:
> > -extern void wait_for_completion(struct completion *);
> > -extern void wait_for_completion_io(struct completion *);
> > -extern int wait_for_completion_interruptible(struct completion *x);
> > -extern int wait_for_completion_killable(struct completion *x);
> > -extern int wait_for_completion_state(struct completion *x, unsigned int state);
> > -extern unsigned long wait_for_completion_timeout(struct completion *x,
> > +extern void __wait_for_completion(struct completion *);
> > +extern void __wait_for_completion_io(struct completion *);
> > +extern int __wait_for_completion_interruptible(struct completion *x);
> > +extern int __wait_for_completion_killable(struct completion *x);
> > +extern int __wait_for_completion_state(struct completion *x, unsigned int state);
> > +extern unsigned long __wait_for_completion_timeout(struct completion *x,
> >  						   unsigned long timeout);
> > -extern unsigned long wait_for_completion_io_timeout(struct completion *x,
> > +extern unsigned long __wait_for_completion_io_timeout(struct completion *x,
> >  						    unsigned long timeout);
> > -extern long wait_for_completion_interruptible_timeout(
> > +extern long __wait_for_completion_interruptible_timeout(
> >  	struct completion *x, unsigned long timeout);
> > -extern long wait_for_completion_killable_timeout(
> > +extern long __wait_for_completion_killable_timeout(
> >  	struct completion *x, unsigned long timeout);
> >  extern bool try_wait_for_completion(struct completion *x);
> >  extern bool completion_done(struct completion *x);
> > @@ -139,4 +134,79 @@ extern void complete(struct completion *);
> >  extern void complete_on_current_cpu(struct completion *x);
> >  extern void complete_all(struct completion *);
> >  
> > +#define wait_for_completion(x)						\
> > +({									\
> > +	sdt_might_sleep_start_timeout(NULL, -1L);			\
> > +	__wait_for_completion(x);					\
> > +	sdt_might_sleep_end();						\
> > +})
> 
> The DEPT patch series changed `wait_for_completion` into a macro.
> Because bindgen cannot handle function-like macros, this caused
> Rust build errors. Add a helper function to fix it.
> 
> ```
> error[E0425]: cannot find function `wait_for_completion` in crate `bindings`
>      --> rust/kernel/sync/completion.rs:110:28
>       |
>   110 |         unsafe { bindings::wait_for_completion(self.as_raw()) };
>       |                            ^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `__wait_for_completion`
>       |
>      ::: /root/linux/rust/bindings/bindings_generated.rs:33440:5
>       |
> 33440 |     pub fn __wait_for_completion(arg1: *mut completion);
>       |     ---------------------------------------------------- similarly named function `__wait_for_completion` defined here
> 
> error: aborting due to 1 previous error
> 
> For more information about this error, try `rustc --explain E0425`.
> ```
> 

I think Danilo already made it clear, please fold this the existing
patch. Moreover, since this patchset doesn't adjust init_completion()
from the Rust side, the result is Rust code will also use the same dept
key for completion, which has to be fixed if dept wants to be in-tree.

Regards,
Boqun

> Signed-off-by: Guangbo Cui <2407018371@qq.com>
> ---
>  rust/helpers/completion.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
> index b2443262a2ae..5bae5e749def 100644
> --- a/rust/helpers/completion.c
> +++ b/rust/helpers/completion.c
> @@ -6,3 +6,8 @@ void rust_helper_init_completion(struct completion *x)
>  {
>  	init_completion(x);
>  }
> +
> +void rust_helper_wait_for_completion(struct completion *x)
> +{
> +	wait_for_completion(x);
> +}
> -- 
> 2.43.0
> 

