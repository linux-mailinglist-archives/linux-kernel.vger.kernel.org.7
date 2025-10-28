Return-Path: <linux-kernel+bounces-873109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A465C1320B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E56B189E8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C20286D73;
	Tue, 28 Oct 2025 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1n6JZwd"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050A28751F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632671; cv=none; b=VcJf8aHOoiHh3lVIv4kq7wo2bUmg0p5WGZ6T3www8ZTGxV6IO9JR4f0ioLiGBDa75ILCMETIldtovftz1ettQRYG+0nK/YjzbceymHuAHz0bc0R5ReSfGMNhsewMvnP2SVd5Z36rRDoZ40K5mBil8TjzzPw3tcFgcWbIYJEh1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632671; c=relaxed/simple;
	bh=0uYy3VEBlwctl3AQekMYkBOmduDP+jjiBD7nvoV/WB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3mnko+JWKOaUD43sjLZnSKGNwBTsvgCwseG8JR3z+wsofgbsuHvd+k5IFb3+JlQkYZf3k1ZLWmb/qi+jzBsIDxMNB882drP45jMlL8bpHiiSucr2q8qD8+20pGx+WN36Mt5qgktPXPRgkjZqYBja4JQQH37HRQyqj8awayIuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1n6JZwd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781010ff051so3713241b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761632669; x=1762237469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdmp4Me7wQgWGSINcaaO6DB12X776uykd1AanqKsIrg=;
        b=F1n6JZwd1+cViSIl79XOCKqLOcd8rGP5zauQ4l85cfRHEcFDVgxVKqA9ohaJ+K9gbJ
         o9xgS3pJAltgd16KMYRFR+++9x/mEqcBSw7CeUA/LCN2JEh6tKRJjh+FxGnP6TY32stU
         5c0zlftP87JKM/JWJtfXvu3StXBCxXbGxPw9jhUFPoNgKbjItp+Uh050hMecdjxrTqWm
         d6m3oU40je3x5FBIEhsTucF76x3zeiJC6GUr/6WjSzydUx5yxx2n2RUhn7zo6YWqbmT0
         g1BX5fByYgBZuVJQVDEUt96eMhSjxVCG75SRQYpAqGbyJgmDYpcKYNB15ly8/ne1JZDa
         2E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632669; x=1762237469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdmp4Me7wQgWGSINcaaO6DB12X776uykd1AanqKsIrg=;
        b=kuWDdofnpnGoEWL8wY7DF0JyTs+/sB8LBZ4aSvjP8TPmWkJM+PrcCHwEzBlKluRzsI
         9C7N2J7yZjnWbRN3eyamqhy7a1QGLliapJ8uk4yxbJauU9XF0sx79Gal4CJkTyYXu+3e
         Bv/gjpwYp6BNAj4sSBCC73N3qANsho+ZF4j4NipBSVoDlE2yc3XpGk6yn8UvQ1cvsN0N
         +hY1AGHrDjAjoCvusrL8RVOqTjHMTFsL6wldLFTR62KPudS+UCsBNTqSgL/80wMHPkmd
         4PtdD73BdOEviDCVQDi+Ai+UyJxRTs0UM9HowykPs4/8+0aZw+1ojxBdqm2+Pfq4TY6i
         4pZA==
X-Forwarded-Encrypted: i=1; AJvYcCXoai51gTkdJzrxIZyzVJPNy6Giq8WGOjf5kw0Avbe7x/wCLCeb9T/e21BVGOcXg72+3kTP4J81GmlhO7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/posTqFgJWNEn1f9q7vglSsIvre33I2rR+uAnu7WSpUE5QxWT
	v2BC4N9jafQbOZ4Mr5iP0jZ7TPHsdQCpEPdIdP7lNjEmuAisXJYPJ4GB
X-Gm-Gg: ASbGnctwHv23l1vMU42d7XJVW9lK2Ka0y0SHQD7uMMVpFYE8DxH3g/5s42wPdbaUFhS
	fFBKG6mUKSOaGtto2YUrnzjHe0CO6RItiCxXXJXeCmqVR+TqDHf30UE+CxdUKkUGvHvvaaNZDho
	nO8LnPLKyK70rMkbt31M0aVUBJQZkdEoyq/Q9wxKfnh2yEq79oEzdMUY8c2FeSD/g8LzaGYxWo3
	Ol0hcKImSS4wzaUb5zghpfLtrVm8xKHKfWZSHclM7tlAsZ1Sz92MngvLeVBTz9h3bPGh0zHcJHc
	blxuvqUlNpsZcXyp4OCBK1B/lqTOiTJtgDDcY3vQqRS6Rp3JbfZSZj8l7XmWcQ+U+clTlrih47v
	VGi0ZHQtfmwxx7Psgw0BlVyxDSrROYjqfKEG94iYE1EfYdV6dWQ0vsTikq75FJwKgZo0RBPGSye
	8FQbETEEQaRGAZIYM2QejX8/eACbMvVdblrTOdTQ1nI10klku8Lkdm9Q==
X-Google-Smtp-Source: AGHT+IGv+D4wp24FT68CnJLR5oLyMpLV/E78aYjMLl1V6sgXD7UwHIdmxv8JaQ7oQ0PzT0e74dyMKQ==
X-Received: by 2002:a05:6a21:9989:b0:334:8239:56c9 with SMTP id adf61e73a8af0-344d3e45ee7mr3169929637.49.1761632668919;
        Mon, 27 Oct 2025 23:24:28 -0700 (PDT)
Received: from ?IPV6:2600:8802:702:7400:1c69:7897:d90:375b? ([2600:8802:702:7400:1c69:7897:d90:375b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128e41a2esm9174084a12.22.2025.10.27.23.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 23:24:28 -0700 (PDT)
Message-ID: <49308ca0-ebd1-4915-9ef4-0a5e31793da4@gmail.com>
Date: Mon, 27 Oct 2025 23:24:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: drop dpu_hw_dsc_destroy() prototype
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251027-dpu-drop-dsc-destroy-v1-1-968128de4bf6@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jesszhan0024@gmail.com>
In-Reply-To: <20251027-dpu-drop-dsc-destroy-v1-1-968128de4bf6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2025 6:35 AM, Dmitry Baryshkov wrote:
> The commit a106ed98af68 ("drm/msm/dpu: use devres-managed allocation for
> HW blocks") dropped all dpu_hw_foo_destroy() functions, but the
> prototype for dpu_hw_dsc_destroy() was omitted. Drop it now to clean up
> the header.
> 
> Fixes: a106ed98af68 ("drm/msm/dpu: use devres-managed allocation for HW blocks")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jesszhan0024@gmail.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
> index b7013c9822d23238eb5411a5e284bb072ecc3395..cc7cc6f6f7cda639b30bad7632c6e73aacedfcb8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
> @@ -71,12 +71,6 @@ struct dpu_hw_dsc *dpu_hw_dsc_init_1_2(struct drm_device *dev,
>   				       const struct dpu_dsc_cfg *cfg,
>   				       void __iomem *addr);
>   
> -/**
> - * dpu_hw_dsc_destroy - destroys dsc driver context
> - * @dsc:   Pointer to dsc driver context returned by dpu_hw_dsc_init
> - */
> -void dpu_hw_dsc_destroy(struct dpu_hw_dsc *dsc);
> -
>   static inline struct dpu_hw_dsc *to_dpu_hw_dsc(struct dpu_hw_blk *hw)
>   {
>   	return container_of(hw, struct dpu_hw_dsc, base);
> 
> ---
> base-commit: fe45352cd106ae41b5ad3f0066c2e54dbb2dfd70
> change-id: 20251027-dpu-drop-dsc-destroy-a1265a9b8d99
> 
> Best regards,


