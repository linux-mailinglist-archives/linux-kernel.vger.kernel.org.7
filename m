Return-Path: <linux-kernel+bounces-864632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D80BFB3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949861A02A77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F6316183;
	Wed, 22 Oct 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GvC9fm/Q"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E52882BE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126757; cv=none; b=puzSSH6vcHkXwf8HSBJWvLRtDErTRjvlyYHkVBMWhqcuiKPLZE7Rg9iamsUEJSv8F//+o+1lGa6oM2sJ0CUOXvwtjty6iPAYuewwXKKRXC9RQPsVkOoYqnYR3cnOxGHg0hXaHazy0yV3l+5aC3sQJLC8O9C6DI40L/6HrsMdG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126757; c=relaxed/simple;
	bh=u9O+M5FnnOd2ey7mT49qZhuszTjr6/05cfotPdNQzLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEdP2Lt0Eq+5YCBfaAs34lJXPoIzynkTzQxND5SeZHsyiHT7BvaI6SOk/rrl01n5voryUKVTIl5Qkj+8/GoLso6N+pIgehWC82wh97m3pCp6uCdGEqwddqQd54uuSIRWA864ht5XsfuIFlE/dF+pVgdfyDmvhf4ds42OsdkkwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GvC9fm/Q; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7810289cd4bso6366692b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761126754; x=1761731554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cy2C5yVg52td8J//jTYT9GaB3wcdXgzlUlYOQBGu8zk=;
        b=GvC9fm/QlovHM+2q6yInd62YpqYnF1yDh5jqxn2yjybJsmrfTxy6hRtkiBDqlNv15c
         PO+NCFrHdis69LY/MCu64RNRwJeLoJu+RFrtjhN6b2x0D38nC6Dru19tt6Lk+LzV2sNU
         ZOrtZ8Wrq2PniASx86MGER5Tl9FR7b0RdPhCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126754; x=1761731554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy2C5yVg52td8J//jTYT9GaB3wcdXgzlUlYOQBGu8zk=;
        b=pGqT+dE9z7bie+6PQM/9G04uigpW80EajOE1sSxqjsmKJ71kwQWiZFxjHKbRQLvUL4
         L5mkvXeiCRPzlIw/yEeJmBgzSliP8w2PWeilmqTP2X0C9m3jxsJg/i9GMxfyVHExRc57
         7TWteiXIeVS90qCvYMFG9IqWawQtxOiP+fWcbwbCZjPEsbV4xouAY908GfMTyq5yj11O
         U78GmztQ/ZBpxyvr9o73F86WMDcf349WqRzS73DMhP7/HvO3QC6v1xa6rQIi3tT2SH5X
         RZ+gDWXw3RCmD9TZ1Lf8z2yrMC/poohoJMhK8NgvdUdMLncqhV1fo5Df/zlETzdEUMgS
         SANg==
X-Forwarded-Encrypted: i=1; AJvYcCXuWMSJnB0sjIWfVUT478DPc4NWfd+1n+6xaBJgM+Hs0LIaoer0SJyzOoldR+kprQ4w2Lr2pVBVeC8kTjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzziyRloh0rN1uoQVeKVYlM+dMxhQEp6Bbqg7UAAVSgiHemzZ
	JSJlKzMn/KrGzYE8to4ihFV8xM8SCc+/O881Hbv9HfVg8jPgt5h1eUUoZhuoZBrPbg==
X-Gm-Gg: ASbGncvyy3Ei5sMJbY2IHbjXoqmMBR/3EnCnFTy6MIR1MrS1ixMl/ml2eI8fpYKZOKC
	EfaYIatRdiepHqXPDIOw7PRFjMx1WLBq9Hj1OIYHL/HyX7TgBjmN6PXI8BEO5lE5OGyVjEjcNyt
	makY3boStzUHJDLsejmILX1KWoL3PHHb7Hft7MtcKHE2JOGCh7L37yaE0jIUnf1O33/KjgIuU5q
	eToZ9KMG2mkz034vt10jGuPriop0GyOlmYEu2tM6wTTujmErXzXH+z25IIZn9+C862WGuQRyKQa
	fvbyaau0dXT3CJqxgD94NWIF62o7N4e/mgAV/T6Nt1n8U3jDqhu7AZVaO18JDWLz3Domdr1AK9p
	X93At14MzAYQLioUHJhUGCBF4HO1YEWmaZ2rDjnPzeWCvlv98QnYLxvWjX7ldYPqeTpm5s2crEg
	i1knxa7aUBkVa8+YmQEMyAfi1fA97C4gh2r2A1KIEMNw==
X-Google-Smtp-Source: AGHT+IF/TlX3ycQH/AnoCfYDZr7l7J71NtMoNNV43GbWgsSHyZ2FXA9PMcqteZKDpJHEDLLnhDhrfQ==
X-Received: by 2002:a05:6300:210a:b0:334:9b5d:3885 with SMTP id adf61e73a8af0-334a861747emr28239424637.35.1761126754672;
        Wed, 22 Oct 2025 02:52:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:201d:8:5534:56e9:528e:f9b4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b349b2sm12903519a12.23.2025.10.22.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:52:34 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:52:29 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	laokz <laokz@foxmail.com>, Jiri Kosina <jikos@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Weinan Liu <wnliu@google.com>,
	Fazla Mehrab <a.mehrab@bytedance.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: Re: [PATCH] module: Fix device table module aliases
Message-ID: <20251022095229.GA715916@google.com>
References: <e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org>

On Mon, Oct 20, 2025 at 10:53:40AM -0700, Josh Poimboeuf wrote:
> Commit 6717e8f91db7 ("kbuild: Remove 'kmod_' prefix from
> __KBUILD_MODNAME") inadvertently broke module alias generation for
> modules which rely on MODULE_DEVICE_TABLE().
> 
> It removed the "kmod_" prefix from __KBUILD_MODNAME, which caused
> MODULE_DEVICE_TABLE() to generate a symbol name which no longer matched
> the format expected by handle_moddevtable() in scripts/mod/file2alias.c.
> 
> As a result, modpost failed to find the device tables, leading to
> missing module aliases.
> 
> Fix this by explicitly adding the "kmod_" string within the
> MODULE_DEVICE_TABLE() macro itself, restoring the symbol name to the
> format expected by file2alias.c.
> 
> Fixes: 6717e8f91db7 ("kbuild: Remove 'kmod_' prefix from __KBUILD_MODNAME")
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

