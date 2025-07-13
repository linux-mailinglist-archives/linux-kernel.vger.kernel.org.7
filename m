Return-Path: <linux-kernel+bounces-729067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C97B03145
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C087A6718
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDC0233701;
	Sun, 13 Jul 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/JUoljg"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DD17C91
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752414720; cv=none; b=BKBvjQ4tsv79Xd86+PR/WyzOTyvM9iM9p97DjL1Syyy2xx0Q+QqvhhVk2iqUxsS6hABHQWMFeyLZNdTmPhORe/saFbpQeRx/Gdgo0s9+OU3Rm7OML5WkTTslzuFXXZr9QROPa7jUC30TKku7R6KyqWqrkOIocD2m/ICappOjTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752414720; c=relaxed/simple;
	bh=H0S/64q059tofG/PAPzrXhW/h7WU4kktGkyAjebJoeU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZJaRcYrAQHifosh7mROYxkuda16KJ14Snk+V/rNmfW49PWtuY2sm5PoKTtloRr6sUzL6QyFmaeVhMPaghfbt8YXUB1LDXy2uMyDmTB0Z5aCd/8O7He0E5iFwzlKUGT9ZL083Ue4tu7iEe7JOd97eWbsdGqTBYzKcek54Y7htmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/JUoljg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso1991562f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752414717; x=1753019517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VSHC3KhteT7nZkNgcxjgFubbkQJHf7yi4kx20sRVEr0=;
        b=M/JUoljgCXBt/mvEvSKQvx/46vM8OFRzwXba7NqpgjVhWC5r44VnIzcSkp1DpsJ7dl
         +z8EVWv5tDkTnW/olVWaGJ5q4MolM+XoLhUvq1x7epWJ48Sue1TKwFQPMc858bx8lXbA
         lrmAZVdk6HNu3Ofu89o4YprEWL2Gpb8b3Z6k1CVSZ9IMXxz7x18Q6VWtYe2tUTYDPxkn
         FA5Ba+cQC9utdG1UJT9IGUBKZoqB1g2m/u0PXgO0nzGjFsbskqNJy1HOGjlNKrvAwqI+
         YhyAw6JX7vDDvXjhsp4e7EC+2NMiXY+yt1mhhLF6jhJ7vhhQaxn9cF/ciHXOoT06jfhK
         /K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752414717; x=1753019517;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSHC3KhteT7nZkNgcxjgFubbkQJHf7yi4kx20sRVEr0=;
        b=RfOeWYSDsozD2gFG3Xgvjom4RnkYbg64Gg4Us50AtkNYcolIHSawaMiLP6kpbjYS8B
         PMtfsWgCxAQ439+WbbdbA3sXocQZAGKRG1tPJPQS1hqkkbqhOk8ZxsKRsA5kDw07GlMz
         oLC2Phaa3Jh2N3x2ZlQkxT/ZGEnZeCuh+Wdq66Ip72003WUSvZ1ULUDZUVm4gtD+nRdP
         pl0PO9rDl2Av8Bjnt7AXeEdlitkZcof5+vW/whr+idkRFCSnQrezzg4dP5tkzsumTXFl
         YEQdTIdbOP4+jYxUs17zFRNszd8Df7P9FSrzlfOrDgxfHdzqg7SoG8TezJZzp9C1W4en
         8g9w==
X-Forwarded-Encrypted: i=1; AJvYcCXAXx5CqK/zRpZ7gN1IkrgmNY0NfvZBxkzMl59un8T497Jh77m5IKGpmPuVU2UmMbmlGaPK7dHcqSHw6OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2FtzvW+d6UoutDYpUpIwN/BiRG5VVy3LU1I93CFrEFFGMHIw
	NwsIcOwGjJ6a1TQ3hyjRWznNHSOAa5lIp4U3oMvOf6WjRpxTE8vqRqCO3j2Y7g==
X-Gm-Gg: ASbGnctGYR3/g13RFJSxNQqeVwNM72OsWGW4CF67NYZ6WZqJB1X7YPm9/RLoWs2e5zP
	DlJ7qCBy4hva6UdRc70TqHJIU5dnz/QcHEH8amZRK0QpAFFzteTQH5ppyjNs6SnEXtrGMOnJAKW
	eLn0Gew48aoQ84VApY2DqY+PUJ8oRVnzNEO2HlrI1XG6UpeOXEqSWC2C4UpSYJtmLMTb57B48Ss
	xQz7tBWBME8rEeR65phMflyil1tucdwxImJiwT0Exqbfogw+h6JkF6P5D4LyC2NdTQa9N9bTA/c
	saowHiv110OIi5LCMdPQVW0ruijoLasUVQMuis8KxEziE/8Pnhlpik4uDs0WaFXz8aU7sOuEHVp
	0uBN27R1dUu6Okx3G9+5SXBiS0z+j1GhMirQGqPnmDtMa7aNPOS6kDXwc4Td41J2fNJ4=
X-Google-Smtp-Source: AGHT+IFIZ4Dh1XCh27ovH4HqYOPnanQQQENN0Fqhp638zpTNKyzmv+4e10tMQG7HUL7nKdchZtMAoA==
X-Received: by 2002:a05:6000:2a86:b0:3a5:5298:ce28 with SMTP id ffacd0b85a97d-3b5f18759a8mr6121982f8f.4.1752414717309;
        Sun, 13 Jul 2025 06:51:57 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d4b5sm9955920f8f.53.2025.07.13.06.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 06:51:56 -0700 (PDT)
Message-ID: <11d29a7e-d36b-42e4-abe0-9f72a478c5c6@gmail.com>
Date: Sun, 13 Jul 2025 15:51:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: of: fix documentation reference
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250609-drm-misc-next-v1-1-a17b11a06940@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20250609-drm-misc-next-v1-1-a17b11a06940@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 09/06/2025 à 15:35, Raphael Gallais-Pou a écrit :
> Documentation/devicetree/bindings/graph.txt content has move directly to
> the dt-schema repo.
>
> Point to the YAML of the official repo instead of the old file.
>
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Hi,

Gentle ping !

Best regards,
Raphaël
> ---
>   drivers/gpu/drm/drm_of.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index d0183dea770308e77f05da364ffe087d53f3be36..4f65ce729a473ec372bd76a60ac11a40ffb5df97 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -55,7 +55,8 @@ EXPORT_SYMBOL(drm_of_crtc_port_mask);
>    * and generate the DRM mask of CRTCs which may be attached to this
>    * encoder.
>    *
> - * See Documentation/devicetree/bindings/graph.txt for the bindings.
> + * See https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml
> + * for the bindings.
>    */
>   uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>   				    struct device_node *port)
> @@ -106,7 +107,9 @@ EXPORT_SYMBOL_GPL(drm_of_component_match_add);
>    * Parse the platform device OF node and bind all the components associated
>    * with the master. Interface ports are added before the encoders in order to
>    * satisfy their .bind requirements
> - * See Documentation/devicetree/bindings/graph.txt for the bindings.
> + *
> + * See https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml
> + * for the bindings.
>    *
>    * Returns zero if successful, or one of the standard error codes if it fails.
>    */
>
> ---
> base-commit: 6f392f37165008cfb3f89d723aa019e372ee79b9
> change-id: 20250609-drm-misc-next-2f4dd8f88bb9
>
> Best regards,


