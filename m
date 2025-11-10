Return-Path: <linux-kernel+bounces-892709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B1C45A99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83684E9877
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CCF1C860A;
	Mon, 10 Nov 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XY3ljPL/"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286621CC64
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767087; cv=none; b=T5MKIgpXtFU7S8ukcC/6sLVKe1+jqRQ/vdgHVpbyE7qdKf8MYqQxQGthIRhjdfiBtr7HtJSykUNZWhPlvNP1tAL4mvAtPtcUmraF0wTIH/pbG6PwPQb7iqM60rVJnvO3idCQ5PfUEm3enp8XK/PAms723ra2ySOaYgBGE/73H+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767087; c=relaxed/simple;
	bh=m/QU9kQD+zT8DY4zIk3dOkJ1ZJpquGhCSedUwO/1RWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaapHo4gzF4+vSXYQYyYZcTPx80lySTIri2N8O1GV1ZYH1l7mpCTcJolVlRAPMnva7Jc7+JxrrWswPttQevzeNp9ritaUYR/1/12GaAzh8ARDOtSZlSAwGtt/lvS7cfc3vBkldAdoSD7DNDarW476qeN5cDV4EdMCDhMEEWt1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XY3ljPL/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so2389436a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767084; x=1763371884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amfX240/D0izGpL77kjzwIZmsTrj0WyJRpbOWOmEfmw=;
        b=XY3ljPL/xz1PQLkTjPFNbhtiMBR5eX9KKnZQv5AyRYFMxUWJ6VLil4Y1DxchnMjhll
         Z6Thdyt6ZTKoDRU8m+7LF+v+WIZLu0MNuQ+l7vb9kgrYO+2Raz37L9sl14Yg4kLBmTS6
         Xqc7RBHzOECH85qlwdkAKDh1VsrPu01H5K8zYypoBFUTUJjNqq9RUk7rvb/uORuRgdhJ
         0/fPp+EhkZOnkdvs7O+pN7NtttOAw9/OHDyR3QZcKp6ry65UbYDMTaUkguZWzSwRVRNO
         Q4o5zW9ZpgYFS5tnZiekPs94bXeFh4EAh2ZxSQLhxeY6yOrZgeAADEccH0blVkqIDSY8
         cLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767084; x=1763371884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amfX240/D0izGpL77kjzwIZmsTrj0WyJRpbOWOmEfmw=;
        b=gut7gWC38akgbo7zk3vjgp4Lmd5020J453LirtCZp+zaKytIwMTo91qUfQGWo63Y5e
         HpDvRSt3IFG/3YnwEUtFX3plykRnjoiZ1YXilJfG463uYjvHI9S/1IeTqEUdYDx4XRYa
         Jk3NvjHvoYh2oeNTvSjBWEbS1rpVzGtXgsnaqWjnYnHTLLHgw7BJz6XjOwHNy5viwBel
         9LDIvYvtwoRuQTfD+Cs8XnHijB3BMfmHt3+nmh4fwpM0QLEggDSrCRlLEmrzFSKoE7+g
         BmYtWnu6dizP+7UFSisUv814AsAen9pHeE8RapLUeqMcxnxUHhEJy/JkGFW1+jGm/RVo
         gw5w==
X-Forwarded-Encrypted: i=1; AJvYcCUtf/qknHaewQGCypnzE7RLRY0g0BfaKc0ROWWTybt1j/pk7QAlXGzNVxKnCauUaU25CwjoKW1MeReKLW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2bxBd4IeilE3KGCYrueRRWIhDTPMBMO3YAv5jSX219igOMxk
	BDibcRCh87cco3bYj5izXW/bkQDe81blaCh16dzHiFHhr4A4PnGSkrdIfGikDIPGMxw=
X-Gm-Gg: ASbGncsEODpz3kYZ12yCruiBnYENqIaH7K6AM5/EmOw+bAYNIo1RJzCV99654fNzrUS
	z5FVIud/eyUal/bJmEYeptmlGijkhXo9hV8QpczGTlRFndDZZJQ2YWc6NueyuhYKrJ/gC/L/BRC
	XI4QI3K76WhGcUlOymQ82qhQBex6a1rjYAs+jldwKeDv30DNqWyg7GfrhPjDJZ0nt4AN+kv9Hc6
	I5GID/PirzmYXEg/zuMP7Qnv/z3ar0i8KOmL1z4PqL5YlP1zQXNE8tIV5/4gAj5esQWxhAyPsXk
	RJJNVp8FK7DHSb+uBiNFH2Efc/vokLu+fuAH7gmqF1WykYnSTbvzYecPsa+ppihnGCI4++FcABS
	uhGZ8TJnxOSPBbsd99/CNzvdSP5T73KfOsCGc1MYY/GGziL6wPJtUGLUdFOUGKnspfbP6tXIwAR
	wJZpY+9y0BrPRl4g==
X-Google-Smtp-Source: AGHT+IE/txm/8jWMiSkfFFCpyrIegQ7dxW+BtDPga3eQ9vjewsDB6p7h+vXBqAcuv9gNMfcv8ZCOVw==
X-Received: by 2002:a05:6402:278e:b0:640:976f:13b0 with SMTP id 4fb4d7f45d1cf-6415dc11776mr5564134a12.12.1762767084330;
        Mon, 10 Nov 2025 01:31:24 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64184b6c7e4sm3018332a12.24.2025.11.10.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:31:23 -0800 (PST)
Date: Mon, 10 Nov 2025 10:31:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for
 BPF triggers
Message-ID: <aRGw6sSyoJiyXb8i@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-4-roman.gushchin@linux.dev>

On Mon 27-10-25 16:21:57, Roman Gushchin wrote:
> Currently there is a hard-coded list of possible oom constraints:
> NONE, CPUSET, MEMORY_POLICY & MEMCG. Add a new one: CONSTRAINT_BPF.
> Also, add an ability to specify a custom constraint name
> when calling bpf_out_of_memory(). If an empty string is passed
> as an argument, CONSTRAINT_BPF is displayed.

Constrain is meant to define the scope of the oom handler but to me it
seems like you want to specify the oom handler and (ab)using scope for
that. In other words it still makes sense to distinguesh memcg, global,
mempolicy wide OOMs with global vs. bpf handler, right?

-- 
Michal Hocko
SUSE Labs

