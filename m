Return-Path: <linux-kernel+bounces-897029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610AC51D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3803C4230DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D940C30B52B;
	Wed, 12 Nov 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YSoQI/Oq"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB612FDC3C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945183; cv=none; b=lUlN7Og2zxPc0SnO/iGkYNh8ilz5MF5/LqqkCG8RiOBkZjnid/RLZuO9HLi8++UEau4jCsSvWDiR2/i2x6HiHLajYP8IUQMbBRxnbTSJMiqtLdESJidjRis7oqY85XYMElNFGmERAbQ1bIUhRzkHxg0ztjkjwLlGQng1+UuIye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945183; c=relaxed/simple;
	bh=RKKNWoDjfVSnJcqgTL6qW9E23qmiLCaxV17Yabi8yGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGMapjAWos70wXctYzVUI6CkLi/1PELaXnA+GC2VtoPg4YLCO9WCHmzjG8s8DAAKxPwwARTlaFUh0sWfCso61uY+HBpP+sp/uME1pNX32Sl+W9NXnxvusVVxgj76JBFr/uiOpQJolfEwzR9XO+lcQiApaLnuUpD6tCyycNIq0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YSoQI/Oq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so891730a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762945179; x=1763549979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKmB/v0U6OaQpzZEQIHyIOuIxIUStkLO5pOeBZcstZQ=;
        b=YSoQI/OqqsFwFSABeanOEa03eF8+Nz/D0vwmjfO1vRmfiZU7AnHNfn//CAJhW9MicS
         zFW2Q87WSztVfXltF2p8XDwhfyWqibMq+IDcpjFybbXholkXefYdyErDcPELC+yVi8cu
         kAyq8a1xFivQz92vP3+z54IyVK1L8CQgW1cGZWAahD5R3T3yJtTX1A5RThkxnQ256r2U
         YhHujpztXry13H5gkjXtYN2zHWlpHXmUe+LVf7d5+okgUfOyf7SEwxvNAITIOAfh2ntZ
         2UzGZZ/Gn9+PM9tRVnWMTLAPZecfSm+Lpwq0FPngv3IqYu20LeWpj5DbsikG/IM9IKaI
         VrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762945179; x=1763549979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKmB/v0U6OaQpzZEQIHyIOuIxIUStkLO5pOeBZcstZQ=;
        b=WwQ936w0UwJ+u6NjijXcOuAkBOnAKlkp31q6TBu37kqTVmY6jmYYSbG3+uPrJCT5AA
         y4WKrvfWpMQhszukMR4nPbx1QvNljfwm7aDhfk+32EQ2FTq64TKDszA0+1Eo8Z7V1Kzy
         kQWniqs+rBLYI5V1VczDElMuWLubtcfNiTpucYbcGq8NGH3Vw/V7YDeHU1pbuaYx96K8
         LYgxwLT0kEGxx1FJXrhHggJdlHSiNYyM/VnK4Gkbho/+21RxgREzTMb4+fwOC8fCY2Ul
         8AGomcb0yQtbLpTroJP3gHYIZxL8ueV1lbKApINY64sfbM0qit9+Qk0tefOCQALnHMj7
         iECA==
X-Gm-Message-State: AOJu0YzUS2xXaTGxRtnBtbY6DOKxzXUH07h+8clO0K7jUOJU5LTnuH51
	qefgwcLUb1Q/aWOgSlxTsV5IUBJWfQ2xRkvoVCK7ei0vajl48oYmy3XRNR85TUGSUAhSz43HavB
	c6FEN9mY=
X-Gm-Gg: ASbGncv0fERzmo3EmOec/CSnWBvh9P/nPUfAiit6+hH5alK+mhKLcuV+mSVIRwzX23f
	q8ccHVIjfFrUvRw84yRAh6JHuDVT8Cprgpn13Fi6Z8q8YP3Mx7T+q4UaYK7yxhfJkq5vseYLSqP
	hfsgZwX+yv/26IIV4w1OMg5mI6fGI1QZQ9kKPxie7zsUHQAOEg3FxI5zOReDjdG7Vbdst1SiZt1
	MnULgSs6D7M9oBK7wjnUe5C6nt0W1JpoGxQpcvJ0afWIuSNCRDKrP0/cilOOuD6Tq9wzD+l9w5N
	VPbr6Xkx3i6CtSGQGnE/TtDMRYr+RNHYMqJAT4BxlP/aztE+SAp3oG8yHV2NSVhXx/hHoCrlnb/
	EIrTmcI/kNWBzwlmdHazJ8U082AwlewqM9lWzXZSwV0HrdLagd68K+r/p4xRCFiLvNjhuw9Q9PY
	h0b8E=
X-Google-Smtp-Source: AGHT+IEipHclKChf0WzAkrmFiGLxDkYqcUJfRRyYtobx+l5hb8Ds76X/nWX+u3DdapT2zwngfAXUzg==
X-Received: by 2002:a17:907:6d0b:b0:b70:a9fd:1170 with SMTP id a640c23a62f3a-b7331b5f971mr245620666b.65.1762945179507;
        Wed, 12 Nov 2025 02:59:39 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e54asm1567887266b.34.2025.11.12.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:59:39 -0800 (PST)
Date: Wed, 12 Nov 2025 11:59:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] lib/vsprintf: Check pointer before dereferencing
 in time_and_date()
Message-ID: <aRRomfbo8r8zQpsV@pathway.suse.cz>
References: <20251110132118.4113976-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110132118.4113976-1-andriy.shevchenko@linux.intel.com>

On Mon 2025-11-10 14:21:18, Andy Shevchenko wrote:
> The pointer may be invalid when gets to the printf(). In particular
> the time_and_date() dereferencing it in some cases without checking.
> 
> Move the check from rtc_str() to time_and_date() to cover all cases.
> 
> Fixes: 7daac5b2fdf8 ("lib/vsprintf: Print time64_t in human readable format")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

JFYI, the patch has been comitted into printk/linux.git,
branch for-6.19.

Best Regards,
Petr


