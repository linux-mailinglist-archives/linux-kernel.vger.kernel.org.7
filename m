Return-Path: <linux-kernel+bounces-873784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B227C14B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFB8E4F3E22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308D732E12B;
	Tue, 28 Oct 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="yVDKtrFY"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D002AD32
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655880; cv=none; b=JE0rIBSs010Gwll38+gvLXBMyav8qRLydyT5H2Ks6b6i7qJ6/7ewGQjujhhArzSX0t3SXJ9BSOfe7n3REyyAd5PMtfISQdEQlSwzGDzviW1atiABsUhVrYXSHRDDHlQTys8NKUG0b1nXzzKZ0dZUJXxOVlJZDP1Z64Wvj5kr3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655880; c=relaxed/simple;
	bh=a2I4ejkEHJFUuiRyo4e3fbDozENBl6FYPGmLOAYLdDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqGd3HCaDt0w81ROgrBHwgXyTa4SfvYBJ7m3QPy41vImXLOX9H4UDSG6cJGuHzpN0FMG/G/oKOHwx3WcSyQsIDFzPbHs65/ehnQWqObhKIi/SnYfBfarUSeovLlq2hfnao2fTGIgAOAuJ69F+jrGm61SFUJQXspbyAHFie5tMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=yVDKtrFY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475dd54d7cdso12275115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761655877; x=1762260677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a2I4ejkEHJFUuiRyo4e3fbDozENBl6FYPGmLOAYLdDw=;
        b=yVDKtrFYAGqCnjcBkWDl1S/xl3a2ReUFD46DZSGwLpI6jbII60zMQ9afV85RHc/8zF
         aYP3gP2dfP8HIjSK3z07yPSIqj/SclmJSP3UfBE9y1k9YK2uqQKIIHcnbqTh1tqjV3xe
         PWFNh660by/rY8ltKnSVwz9SystN+0NUcqLvQv7O31rTqauYfdD1ma36jld5V22Ma/kU
         fjprkLwFbv+X7SILFdfd6aQqkvMCXxR38eELsgxA2q50gRuNDkqEqEMEqcWHVlnI5wh8
         rJo1mT0nhjfDh72Fsm/aWIZULDNFyAneEHmsx7geLC71q/1TlxNjeLQYBuDdOHqVmFr9
         mnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761655877; x=1762260677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2I4ejkEHJFUuiRyo4e3fbDozENBl6FYPGmLOAYLdDw=;
        b=Lip+nXlneFc4yB5i1MDzmtzjI6wwxWocdXXVLOIxnIxjAQhEtMPe3FhFCSfR5CLIjL
         9FEJZUAY61H6H6R8B4nO5U90YmwPMVOZGrYl4gDbrG7Lrng+L4r0ndY4+PKAb/d8EKNV
         0wMxAjjP6x2TdOSdmkUvlHwQ3VciQ6ohuBd2wiPmlYs6PmORXyrdnKyjEpGxzCzjVSQl
         0Mexkh7eot+ZOFXalqka9zuau4wF5zHqcKjZfZVLFPqykFZOhZ7dfV3uebTHsO4+EHGq
         dtGwyvn5Bm5KZLSFh46xp8OV8Laet0JzT7mQvUFIPAdCSTRXJT3oXh+I9+8Qil9OsL0R
         +w2w==
X-Forwarded-Encrypted: i=1; AJvYcCVKF+XOFugksiMG5vuC0n7w2vFQS6uTNwnTfkALfE7vPKRseIpaZL8yby0rIuSD5kcnExDKUqco7RPjZqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbjZ5GcG0u5rmVau/uJWJS/2IKLDd6szmFRvSTVNCXMpHq+zU
	qOtaqDdkFKVHNTSYQuzWrlXnEeYXuo10l99KKymjpIIAFIMX/VPB3nPzZjGaH0jinIg=
X-Gm-Gg: ASbGncuKY+CtOOgtxEqmj+avhZ58p2KMoYcqKg1jK9O32Iq1B11gMzDy6vadH9kt0Ah
	YIPifbOVd6r0gG4ElNcgM088Cla81Yk7NgJaRLWt88Vfjfdw+DdMnKYzmWQY5BV6ag9hq+kDIN1
	8AXre0RvK5dyNDgwiYDGsPbwLNgDQuygTb6mDW5ywSN/rpNmhFMAt6TnsOrTvTY33zeIbl/hc6U
	1HJcsy5QW7pow4BbnnQYZsRPbVxm7McOI46gV5JCg0DPVm3RZ0/SJEcBufKDmv4TvysEp7b0jPl
	hrKeUyyY99JLpAMOc9KhTA9N0gCwBIqQO4jZmDA9j7TrcwGrn1R3nEs8G4N6EFRPIydX9dRvry9
	eHQ6xxqpDtma4B66M+8vLBQ5MikcnaAC8/9q48s2IOKTnYSkdiitUlRcz2yn9MzxOGy2VvOStOS
	VO3brMx2IpvlHNklb37v6VAfxeW+mHmqiOWzoGxzbIS7bqM3rpcJsUROZ1OfE=
X-Google-Smtp-Source: AGHT+IGj17wXVLJVImH23lwqcOG2/t4wVchddocpSe5VZMuncdh0FaPOQTztffjz3tOnEKdIdlVmpA==
X-Received: by 2002:a05:600c:6218:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-4771d043763mr5450425e9.36.1761655876812;
        Tue, 28 Oct 2025 05:51:16 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718ffa42bsm19014515e9.4.2025.10.28.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 05:51:16 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:52:09 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Daniel Thompson <danielt@kernel.org>
Cc: duje.mihanovic@skole.hr, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: ktd2801: depend on GPIOLIB
Message-ID: <aQC8eZhHIueu7Ub8@aspen.lan>
References: <20250411-ktd-fix-v1-1-e7425d273268@skole.hr>
 <aQC1iJlm2jS479_0@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQC1iJlm2jS479_0@aspen.lan>

On Tue, Oct 28, 2025 at 12:22:37PM +0000, Daniel Thompson wrote:
> On Fri, Apr 11, 2025 at 07:22:18PM +0200, Duje Mihanović via B4 Relay wrote:
> > From: Duje Mihanović <duje.mihanovic@skole.hr>
> >
> > The ExpressWire library used by the driver depends on GPIOLIB, and by
> > extension the driver does as well. This is not reflected in the driver's
> > Kconfig entry, potentially causing Kconfig warnings. Fix this by adding
> > the dependency.
> >
> > Link: https://lore.kernel.org/all/5cf231e1-0bba-4595-9441-46acc5255512@infradead.org
> > Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
>
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Ignore this... I opened up my mailbox with the sort order reversed!


Daniel.

