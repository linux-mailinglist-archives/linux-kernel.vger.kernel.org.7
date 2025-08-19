Return-Path: <linux-kernel+bounces-775834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878DBB2C589
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34531962836
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57434573B;
	Tue, 19 Aug 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="OF47WIY9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A12EB870
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609627; cv=none; b=H7IGJQaafoIvG25Ae3j2t/KaYs/67UQWTTR2qBTH4Bw4bLJpV/ZgrSYSJkmyof2hWtm23GSBVQnViAkXRd6Geh8laYUPn66FfhXBqrkEtxzqrxEH9QGm4GCLQrbiQXEo+f+Pbze6e1Lko9rSiO5F5RW565rAioJHlWNWiRAL2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609627; c=relaxed/simple;
	bh=iK+PjU319NF3+63SA/e/ZLM4YA51y7lBBdjgoAhh/gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIz3C8P3ChnfQwkMjI5bOVVMhJ6Z38WA6exItor2sLWB4b2Ion5QHk1xC/Iu08PUCypTNWdSUkWeJR9BDfTK1iNElFldugp2i4y6TmD9j1qhG1lia9NAHR1H38r1mnScomsEvNdBysXPgGv0pzAaX+C2gpRn+9w0UrbeHl6HUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=OF47WIY9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b00a65fso27316425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755609623; x=1756214423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iK+PjU319NF3+63SA/e/ZLM4YA51y7lBBdjgoAhh/gc=;
        b=OF47WIY95Bd3rodEReMTosRNnvV5dmAPo1yOi0C9zAja0OXcgWKoerWwDHT2D/PfXh
         9Smu8yE/8hTyC4edlb4xHAXyfARpr4BV/VW3qq8uELNKVyPOXa+FqSscNkDNDP2rzlL7
         w7sH6CNtSzCI7Fw0YSSPK4jLYGxpWz/GIc3o3+GH12VLGPV+icNuSH5npnr+E7z7A9nL
         0A0k/YW09o0njEAXbqRL8RtKOdR31dkuzuTWByu/VAMu5Jh4j8BA4NCkKHm57ZFL4R4V
         xrQTrN9odW9wINLlkVUR+Edle44pi3W+06edLBqTOUyc26syZLHSXBRcAyBtq7lxjLt5
         jx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609623; x=1756214423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK+PjU319NF3+63SA/e/ZLM4YA51y7lBBdjgoAhh/gc=;
        b=XSn0FjELM1V8fO8rU4ikFmB76h9aScZW8zUS7z5bBIQcHIEzuL7k+wIeOBFZCrsc/C
         YdUuTodpmIoWzIcII0luo4Wbd59U+B8IQplcixl9fbsc6KzytTI1ve2ivnO6Mr7IUR+c
         GCcdXqDXM6Ls6uhhv0L5l4GiggfQvNfNz7VpOJCH4qzk0IpCNJHUJJOQS2Pt5v3izpGb
         xXv1c9LUxxMkU9hoqfBR1MFEU/CZK2SE4tW1j8JohYYjjyRJ/u1nVvygZNTcdXLN5tsC
         5tfwC7Ye/yKBT0w1mHZrrUHcaGaUsrdeO5Pl5eVWt2AbjmD86Tcng1/mxw8/Z0ZiM64R
         fA5w==
X-Forwarded-Encrypted: i=1; AJvYcCUTGyRRiyAArnO7zDsxsSja8hWjKRGvJGH16PFhmR1AYlPVces3Jtu1/IGE8Nibl5P7sJ5mGrpAD1fA1Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWh7C46BkmuaJGvMA6qXQ7YfBXBmMPZxX5Yhs1w3ef6qu13nSQ
	vKB/pQEJPRa0HbivHAC49z3xtDob2Zv5MmhwgP3cyTfd2coOukmyWOFYTGASjKi05wo=
X-Gm-Gg: ASbGncvjZfbUo2cntPnqMLTvyH9q4R8p2KFM/5MtvQZxnU5Abwf343c66ZdUY9GYAk1
	cKj4VBvkKVAHqltXFgYsba0UJmqvokA3sZsxeolJAnixvPVcvzCkCGuH108P0Yc0ZBrnRYzgx2S
	iZixvo8556RGbAWAyeBD8XbkfP6SqrvcW/QeuyWqOmj2lAusY31/N4hbiXloJjvfE0RZ8xD6lle
	wUylicSaV7dkpg4rDqqAGpm+MN+7+ABG0xpD/Em0uLW2gcJpSF2fueBILPn27tU07GljgYEEFiI
	TqyNm3x1e/pyexVYyEhXklv1r9JqdK4PPvV31+ZA6sXkxFvYgmDokdbBHF7Rb1wW8rBEH/ibLMd
	0AExwqYviuWxWcHLq+f0F8Oh7hVbnJC8RcNpekhmt/n2VLtHsxYdztTPW9xM6yoM1e0wGSqXAUR
	oNFgDkmA==
X-Google-Smtp-Source: AGHT+IFAFNd/RoQaRD/TbbBTaHuoGyv0Q+NnN05rjh0d94CuTJBBUxpriDjYGFCYgFp1Qcx/lqW/Hw==
X-Received: by 2002:a05:6000:2204:b0:3c0:4f30:acde with SMTP id ffacd0b85a97d-3c0ed6c4504mr1917448f8f.55.1755609623300;
        Tue, 19 Aug 2025 06:20:23 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1636sm3673176f8f.43.2025.08.19.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:20:22 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:20:20 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: Use devm_kcalloc() for array space
 allocation
Message-ID: <aKR6FAYDrNDhY6Af@aspen.lan>
References: <20250819035804.433615-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819035804.433615-1-rongqianfeng@vivo.com>

On Tue, Aug 19, 2025 at 11:58:03AM +0800, Qianfeng Rong wrote:
> Replace calls of devm_kzalloc() with devm_kcalloc() in led_bl_get_leds()
> and led_bl_parse_levels() for safer memory allocation with built-in
> overflow protection.

>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

I assume you scanned drivers/video/backlight to look for similar code
patterns in other backlight drivers? If you did it would have been
really helpful to say so in this part of the patch (because in it's
absence I had to do that myself).

However, the code changes are fine:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

