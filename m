Return-Path: <linux-kernel+bounces-835431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BE8BA7132
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609051758EF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC841946AA;
	Sun, 28 Sep 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEzQj+cH"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D914C98
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067311; cv=none; b=SbFSIri405G5pgTRjXX5ZxxNFovNhhW+k10K9vqGxdqUwWGdOWSCcgfGLJITMabOhTFGTNKayGYkxRcHWAj5lkRdZelxweGAN6KTEDRC4bDc+AlxMl0y8O6rKYhLxPIXwbd1Htk4HOcnM0OcIIY1ts463VII50tqQhUWeV02aRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067311; c=relaxed/simple;
	bh=FmVHxgqG382cC69d8rXWZwYyOOy1DF+PiCiPPNQ66pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf23bX0qYzPcoymHph8QFuoP1VjS2oquNLnCY/Iy29p3QbzNyYv26dr+qrlVHEWm0O/eXWHPcmvZv2QY16ubBqYWaqphMygAmfMzApOYQOnxo8c9Ln+H2ToNcY3ze0y//Maa6+4oHwOlyi4qHATT++TC68mz1CPYcmcB38yC8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEzQj+cH; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b550eff972eso2452656a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759067309; x=1759672109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=My/qHt+y2PHKSiLvEMroRzC1fUumz88ynNlnDjtDWgY=;
        b=DEzQj+cHX+g/RZAa0Cy0TWWfpiP+fpqNL5Zd6z/ZvRNSi5CxqFYUwXEANblazCkSif
         AaaN+Gu5dYqpBiPNCDSdBL6TSPpxhErdWFI1sT6RBJRgVv0KSjkalZETzeUIR9zqGaCE
         5cug8wMPN7uiYJe9COvDu3riVPZAUc6Wx4V4HeKwV0R8cgK5HL7K7OqD5fowt8iDZivf
         qExNjZ8zJqg94jccfsBn0rrrC7C7t3Asd1koK8Qe+Zep+KdmSDpQv8Ek2UE3gPGnHTBa
         xCTm/WhMd0R5orGBdCqidE5Jt3f8NI1GuAj9sxkJwVfX52Lcggd9G/NyaGIgL0BOJrNR
         dwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759067309; x=1759672109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=My/qHt+y2PHKSiLvEMroRzC1fUumz88ynNlnDjtDWgY=;
        b=VPNYS9FSAXm6uKaXsGJzSFu2bitincKbT2CbtkqYLMym5yHMbBlCuPrs3U0yWgPghv
         RmoMxMzq1JYNK/2vFvJM2eCbDugNJZgjaafhK5GtQPrcDUowQ9xqi9Y8VjVLhlYIZx55
         y8weMt67X/SSLUVT3wTv/3A1Y3DwQIe7SiOgz9wFyuK/tREOgLKQZn/x75CEHp8ClTq+
         Pmf+A85abfNOoWEigqtrr7nDeG5QSZI6FZCYByEZY5iTBBQoNIN+sCJvexCxcevceoEC
         RpH7t9+tV+RMkalzJZCtzBGBsczZlmU9Y+GYA33ll71gbgyuKg1kr2zCAJn5heRhiT22
         noUw==
X-Forwarded-Encrypted: i=1; AJvYcCV3rkvjf3CSciFzLMM+bM8qVERZcJ4uKcz6eF8Ym11uba5vvy08IE9eG5ZWCYp2GOzPDZaTkFteP/QbzLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ArhJWBd22UjAn6HS+s558fB6E0kXzNoRUygkMk0wL31yucZq
	bBeCrNVH3bMZkGMhScHCQmr7N2KYUtfOBka9kwYTbj08U1d/Sr4ZN4Ie
X-Gm-Gg: ASbGnctYbEYoXAePrrgm6Jp/wCBA17qNeHRLmLg1Xn+Z+K9u0mP2iHX50MblE4FoBAx
	JE4B46g8xNweRl0ZZFxHlGtfV6ECH15Ao+zU/Ne1FTP5t+kwFRHqWT/MfM10xlcQUsUVIeoQioK
	RPnliF6MjgtBDHG0JVP593orQh2XIJn4sTUsxqw9colVS82SyBB1SEnALKbJBitzeXLU2HpCWTQ
	coLbkNUpoutwgjvbkJmvM0CliqVUoLk6yxBQO0lmyvk5PoLSODtPhu8C/hFIguC66Th3NadKYg5
	A/ntktJajSZSDTqnmS6K4/NMsSfTctugn3R5KwgEOCt2pyL6IjJrUKuMfWXBf4EiBmh1cUkgmEL
	qSSi/lM1LUCwzAjwY4dVNd+jAWoUJiMU=
X-Google-Smtp-Source: AGHT+IGXO/qWicj44HJrAinURMObPmlszOlNOo7L+z4Z78O/CaGZYYN86nJQ0OUnlCNPwKAtiNM4Hw==
X-Received: by 2002:a17:902:f9c6:b0:275:2aac:fef8 with SMTP id d9443c01a7336-27ed4a78d81mr101059275ad.38.1759067309482;
        Sun, 28 Sep 2025 06:48:29 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27edcbd455asm97105605ad.122.2025.09.28.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 06:48:22 -0700 (PDT)
Date: Sun, 28 Sep 2025 10:49:15 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org
Subject: Re: [PATCH v3 1/1] spi: offload: Add offset parameter
Message-ID: <aNk82_gHPDCNDqjV@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1758913065.git.marcelo.schmitt@analog.com>
 <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
 <20250928110052.6fefd6a1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928110052.6fefd6a1@jic23-huawei>

Hi Jonathan,

Yes, current ad4030 series depends on this.
Though, since this updates the SPI subsystem, I separated it from ad4030 set.
I missed that aspect of the devel process. If we need an immutable branch to
make this split series for ad4030 work, then yes, please, I'd like an 
immutable branch with this patch.

On 09/28, Jonathan Cameron wrote:
> On Fri, 26 Sep 2025 16:01:05 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > From: Axel Haslam <ahaslam@baylibre.com>
> > 
> > Add an offset parameter that can be passed in the periodic trigger.
> > This is useful for example when ADC drivers implement a separate periodic
> > signal to trigger conversion and need offload to read the result with
> > some delay. While at it, add some documentation to offload periodic trigger
> > parameters.
> > 
> > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> Hi Axel, Marcelo,
> 
> Is there a build time dependency on this for the ad4030 series?
> I'm assuming this will go via Mark's SPI tree, so this is really a question
> of do we need to ask him for an immutable branch or not.
> 
> I don't think there is such a dependency but just wanted to check!
> 
> Jonathan

