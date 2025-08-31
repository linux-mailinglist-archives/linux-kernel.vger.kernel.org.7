Return-Path: <linux-kernel+bounces-793581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEF7B3D58D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68A4189884A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FBE243951;
	Sun, 31 Aug 2025 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3BwlCjh"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CA635;
	Sun, 31 Aug 2025 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679096; cv=none; b=LmytB6vw7iVdxBoegTme+B+VG+vCNdDSY/+jfLSz891v7ewQ/2i/ZWrg3bG1h/fA+d3/1+QzFzYpKkTZpoYU8bKQpZQI1+N6vJFehrbi8Zj0EC3HEXUmQzHpTIbcJ4pQarRTua8Exl7pdlC1n34Xnj9efu67wHrbyXV2XqVLXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679096; c=relaxed/simple;
	bh=RMkda/Jb38m/kme5jQQHvri8pN0ikJOWBvKqi1e2Sxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogaZ/eGEOiqHxzHUyh1qO5lqfavxsONBcwWPQcVpaStE3hFlOlZxDjbxECVz5+j5v2p/f1daxahwHLMKYDyLmdnnDwRdhSOoSX7UoWQw+uJyA2JsPgBSXXgfLhyhSTRECEnalpSFje0aDHrh9zMZM14RHasqn7q81okpTv6RtDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3BwlCjh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244582738b5so33403915ad.3;
        Sun, 31 Aug 2025 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756679094; x=1757283894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gb4p/lKFc37ioeYKVlV2yG+4agpnfJ3sVPil6RBb6s=;
        b=h3BwlCjhOlM9Sf8HZQBu0PxFmycCpDz/c5WiOltXsfYAy5BtMImh3fADfG1Bv8GYBI
         mYEn/ltyEu4Xr3jol4GZT3RkPcWA5IzLHUZWG/QoR5u5rRZJva9DWDlW4HDbN1pxs85V
         s+DGIQLpaySJA2q1PDDbWWxyAflH6RsezoqJ8H6vsEHwjeLUV5cQ1XwgedQCF693c3ze
         OP67MkPTTxTQ3AtJEtkQJyUL2ah0X5iBysZhUr6Jsj5LbdzbrNMBdgLrNDzc6GbTjfmu
         jMleOIs5qVo5uiArkDg0lp+yz1qDRryGtfuMr2UTpA7LFfEcU5susr3pROFDqezAImXW
         dfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756679094; x=1757283894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gb4p/lKFc37ioeYKVlV2yG+4agpnfJ3sVPil6RBb6s=;
        b=RAaBfBrpx4/nR5ZLRYyF5mI3p5DJkGLc2+ztHGjuYzL9MBWyYoayW3OEdDF9hS4ODk
         VH/xknz47EltyN9aVIr0BN8n0JI0/ba7zRgTQLrrFAvAvtj21sM6NQt28r431zh37Y8v
         NrGnCaRYmcYKst0+P5FBIxVB/XXHPhEqp8OQGfKOU7lHFiEB7CqCqBEtyrNLnu9M42aQ
         e52L4ZOzVnYkxP84K9CP7sTyTMfpqnH2M9fQeUhhWhK71gO3wEkl1soRe03pSagHM95w
         8VoAtiuc8JptiNQWBbQQ7owmDPIcxTyCBjYGzWb2Zh0yY+N/G8GZrnVGqxyy2TR1vzhp
         Rtug==
X-Forwarded-Encrypted: i=1; AJvYcCW3HO+YYar+MKNAdPhdibvl4NKGSyevISSiOmPKEeRrInLkIEjS5razZN61gki0200zJjirf3RrzZYhajE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9H3f6E3tRwyNNtenjAbsZvo+OfdC0zxbrlFMGTGLcLvkGyln
	shMiC2Sh4rpj0qVruQ+fpOOTPndBmYmCFsoa5Jb+VeOEf7PKEZu+8DwBoWJNag==
X-Gm-Gg: ASbGncuhE2/QyH4JntR4rA/cWKiCZppnPLRQezCGG/nQYxAHnoeKpzICAP1aWuOkq0q
	eMXMx/a5zUNMzzgOSRSI8Qtj1qm5okKenHa9R3sE4MCLZSetAM2b0UWyznHiKX7cttvKR3JjRnm
	ahjmezw8orRg8/MLqUHDOt8edlVvkEBnmB6Gh34ldZJdt/+dtOrslPoDwZWSGlQHeAS7AWZnw9Z
	m5FMfk2+gEC0/rxr/tmS7lcFEwrnC+lmizRwSyMTzyPQQLaG3AVo1ve9xqsJLpyYsvs71Mnopal
	znlaOL8xEC57rNJbUoN1aFKaqamGQrBofVDZWdepOMnHB385VIOjrVL9Vu0FvXonH0d5ljuDfM1
	NHFBZs0ufI/7NV8I4gtthRUXhYPGaiLZwigM=
X-Google-Smtp-Source: AGHT+IF4oH+4C2LitRBYzHXE6fz/7USNknCxcLYjMme9u23Uygu7b93F3c5QA/xOrbZOp7ZlwiDAjA==
X-Received: by 2002:a17:902:f789:b0:249:2789:4110 with SMTP id d9443c01a7336-24944890abfmr75317195ad.10.1756679094266;
        Sun, 31 Aug 2025 15:24:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067df2e9sm83539015ad.152.2025.08.31.15.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 15:24:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Aug 2025 15:24:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6775) Use int type to store negative error
 codes
Message-ID: <aefc0a7e-e697-465a-96bc-0d700f16a3cf@roeck-us.net>
References: <20250830095105.3271-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830095105.3271-1-rongqianfeng@vivo.com>

On Sat, Aug 30, 2025 at 05:51:05PM +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from u32 to int in nct6775_asuswmi_read() to
> store negative error codes or zero;
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but can be confusing. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Applied.

Guenter

