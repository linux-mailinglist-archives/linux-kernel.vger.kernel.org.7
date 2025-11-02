Return-Path: <linux-kernel+bounces-881847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79AC290F8
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC463AAA86
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEC223DF6;
	Sun,  2 Nov 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diRmbeXu"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED2EEBB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762096438; cv=none; b=KnEZkuni2CyeNhx23UV41Co0U66ZaSqaS6Wj68LqsnEfqmGL1UpruCpaygSGAo0ecwpAmprkZ7RV1DKIWZgbBbCfWnGcs59JJ2CrpoESfADHWawbG5KweBYrDZ7B8wRYKdjCa9+0Jmb5sVnkj0yVblQp+lMa1anc2AwAaykeY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762096438; c=relaxed/simple;
	bh=bl/630iDr9/0lx32dS6ZCip6scZkTqK0juBI2IOH9Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVltKUsQQtoPlPgEe910TuO/IqgThJbqD712YvLjgnDj4bZW4833iloKRp++3YaOmMbOeBv038u4xhhbE4kaSTQSjREtWS51f3zWm6DseLQyUhXdBX0itywhFXkwfRcsMWP+AfEYOLW7UyCELuDAHyQzMVSfNopuzEYmyj4bmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diRmbeXu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a226a0798cso3514939b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762096436; x=1762701236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQ96rEK2xyiZuk5MptrQuva29zVxFbypQtCJr8WgS04=;
        b=diRmbeXuPpxw4nPob89YT77jX2e43W0DszS0o99OB+p6jym5mNwHzJV1bM3cS62k7I
         6D/SdiHil0e7Gpfw654Wx78xh5MaooCurg10V7VK3LZF9t+pL7ldLoOxcd0FmqpHzQqx
         KvQuiUJIwBstIZRPR/3Zq34E6UWbGqNyKMgXDYAAYFjneuhIpSoLBzm98GR3xP8OfUiE
         UgS3HQaxP7oy+onWpWKUnxUORSmSii0ge/c2Nk1zSPP4xvU/fbRFJy+B1xnvxd6EJ10m
         r6rbAuBdAkM6yLLLLH2eQQm1/PYNk/x6nYeCaosFlGrpONSTqamRiQUW3gl11R14psCb
         geJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762096436; x=1762701236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ96rEK2xyiZuk5MptrQuva29zVxFbypQtCJr8WgS04=;
        b=bDKaPryyOZZrTeYHz2Fyb64BQgsn22KN/26lSGx/hLhF836YKoilRlrGrPon0twdF4
         JM+PXBA4Ky/lRBP4jziY1DsWbCQU74yE9CsrWJggPWZAie8Lr1T6La4kQLzeq7wO46If
         CaMIsp4cVvk8YNB/jUjcWuj+GRaPWQUGywyRTtRdOrzlNcI4UQ5fptT8UcxgbW/KLB4s
         19Q/XB2e6pa9oPSydkvDWxCC7gPxgVi1Bc2sxAUy7QYjx7JL082PbzWR5jz7bZ327c3W
         wTb+pkdpgqRm8eAfQMQC2tqKDB4V+8B+pw2/GXbCCBOe7XEUTAFI/pF80aks8Cavbwue
         BC9w==
X-Forwarded-Encrypted: i=1; AJvYcCWShDuqxIhn87T3FRJHCZuiPNdeYfnQqxWBrmHRsMo5R8rxeePV3nJsD8/SJi54EI4n9DKj0479x29cK08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXmpdxCN8dXATgFsd/lgw/DcwTGL3uSMZjeYV4j0KnWiGmRJV
	wAx7NZmnGFOGmzEhcGqjBADZOi8BAsJAQer/hGw/LokMcNcXx31/eDA7
X-Gm-Gg: ASbGnctyl00FTK7CQ+fL1bv8zTDP89ZlPh+lZgU9GT0RYN/ZI0MEBnGZZpTt828GX5e
	hkvKEn1VnxtJHwA85xxjcHDn82rC84EBaOVwNss5V/jMfFIHbyGHQpJJYhCh9UbWhwQ6gHLUII1
	zWGH0hKdGoDyLDpNaOyudcTT2fcxABiM1GtyHSO/dbd5/8C4//FHRUQjiLS1sGgNuaKTQdlRxT1
	+a+OrzFDwb4wqaE+j39LKHvQ3XMR2OsvwIbCt056wmQZ8++Qa0q1zUlDvwlHJfhHxUhWSlIxXpZ
	VXafalhUYXFh6pqmOGI5Zehu1Trw9OvgjpGZJz2wPQE1etxLQQdUcI7uKe0QETuDH7/2vCV5zSt
	WZ82/fzmW6GCY23nOKOmRAHsNH/cT8QQ+7bB6Hdof4OhBVyUCcS9+vG4CW5n6HNQ6JOz3D1FEUw
	CABOrhDdXpXjy+NXwbmmHjUVw=
X-Google-Smtp-Source: AGHT+IHmHx0E8ppASVsSFwTxa9r2hNMFtx0sc3Lf3WuBxMBGncC27kjjGIjwdZRARbJZUcJWV5aISg==
X-Received: by 2002:a05:6a20:3ca3:b0:342:6c97:3693 with SMTP id adf61e73a8af0-348cd21a90dmr10207159637.47.1762096435632;
        Sun, 02 Nov 2025 07:13:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db87340esm8103609b3a.63.2025.11.02.07.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 07:13:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Nov 2025 07:13:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
	will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
	scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, nd@arm.com
Subject: Re: [PATCH v8 3/5] arm64: mm: support large block mapping when
 rodata=full
Message-ID: <d08c474d-4b4f-4b75-827b-e7da550a6dee@roeck-us.net>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-4-yang@os.amperecomputing.com>
 <f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net>
 <933a2eff-1e06-451e-9994-757d66f4b985@arm.com>
 <bee6b93d-aa2e-4335-9801-89f02eb3eccc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee6b93d-aa2e-4335-9801-89f02eb3eccc@arm.com>

On Sun, Nov 02, 2025 at 12:11:11PM +0000, Ryan Roberts wrote:
...
> 
> Here's a proposed fix, although I can't get access to a system with BBML2 until 
> tomorrow at the earliest. Guenter, I wonder if you could check that this 
> resolves your issue?

Testing.

Thanks!

Guenter

