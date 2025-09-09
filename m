Return-Path: <linux-kernel+bounces-807483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A8DB4A4F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D33D64E01C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7440C181CFA;
	Tue,  9 Sep 2025 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="eRl5oNlG"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34ED78C9C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405863; cv=none; b=OWh2ObW5BWyjVGGec74du/kRL6/v9OWgKeX8dib7MdzvR+NMWFeeN7ues1NjLCyJdVSZEuhyAZfXA08iuJrcQRXE64PXEnnFLe8zg0t3K1yp7np+zH4TWE+j56cCXJN0c9uGBhBNIsKMq4UT3jku2bdAnUuxyQyajJIskAIH79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405863; c=relaxed/simple;
	bh=gLOMaEsuJA0HYtH4T+21SsJSkxWFyyduYR5LltFmgRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzHY0NWu017VdwfE2g1CC40uU+AdWnYGWQbtUjRUtGz4YRv4IWRHAVEi1Z7HWEKUM/eVz6Uklq8rj0RfGGSfsfyrvUj4y0PpW5FqfVt+GRqrcH4Hy1XR5UfSxO2Cv9NE6smzVOTPTMyelRPyj9dQQSYrEFj+bGE5PN5YYl3/xDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=eRl5oNlG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3e7428c4cbdso1401594f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1757405860; x=1758010660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bIhnKcS3S70H3FZzFxNSCh5KKC75qWJ8QzD4ToSAuU=;
        b=eRl5oNlGFJ2M1J7njBpaPoVKSvBnPkYoolPV1E9bvC6MF23h1ncDf9peUP96oacM3B
         VJqJs2nXX88qrQuwjUPdt6oFm0Kt1TLYhu6YbcgBdajvzX0QRbf5r2RpoJLYITrk6Zp+
         /WYTpLbMo1Vhs0L+StrvVOFmoylwTqjqAdaumYiY4XlwUP2ANOiP8s3PV1PqiAJcVqeE
         0isTsXyw7hGvawHMQoaASc2JGiPiKcmt0e10oQkR1/8S3kurUXcX2Uds1RPWTw64ZPaM
         lMHYgYndJO6rel8dkJCByHHBV+GUIzaDB6t+cD4DEkaLJbqfXdFK4LoMbxRzZPfXqjeV
         RACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405860; x=1758010660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bIhnKcS3S70H3FZzFxNSCh5KKC75qWJ8QzD4ToSAuU=;
        b=dB9aSR5OvmM6LvZEUVatfdj+oJqDsAG84dLf10C61hi6gCdEOfFZJgpEbwToa3CEy3
         AT1HKUchxllu1926nMe+P6ptDk7nI+BcBrtuuFdTwUtYM4het9MS5tydGJIHM03KndEv
         GiOEcGjD5cBBPuQyvDJNIPRFS8SuF1oNgN+K6AkmefZL9H+fKz9xTJs1RWRQ3vIi4Zu9
         Y75jN4meFiOw5lLIDJYeB9AhZPrH/SrZ2CsSkhK/ov8FoGp5QtIT6ftHcyOdnRisKiRG
         3o0e7TerOe4+kDct6hfvR4dXQbWeikuub6ttB7JsFSzPb6kZCzRI3SAarcswgZCaR4/w
         mq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2IPNlRFGLLiA1vNROllQrchAlkPr/KM1tschzOUehjCeJOyplkLZUxhe0AIhyOUdRFVrAUup0lj5LcVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXCsflmFq360SN/o8enKewksNlQMnHl28TgdQuhUBy2bXPBUK
	cCG//BqJsEuYHidTXvyIeEL54gEmDQaLhCNo8IqLy4aWcDSrqN/Rf0QjrakSTHiX2h0=
X-Gm-Gg: ASbGncsBvGngZSntxCNgjauc8xbT9PSEHtNzRfwYOsam4WVWEmIgks8k341fxB/qvx+
	uys3S8Lrtp7HIz0QNOS42qbzeLFOvkXwk4jTzuF9POR2ssk9AX47k8WpK04gP2Yb7g4cyWNGTxb
	UUhZtbAik1OvkLr+O12SLReDW6B1ejMF/CDm4NY6J25diyCvf6fsgW0SGnDf/goRQ4w5AANEPHN
	enXZXHBkj/4jn/EpTeu4MmhSC36anCWzAmou56lByV2kwRDx5tviGDsEpAS2FjMNMDFaSK0DM1P
	4x5+ksnjPk2kBEL5tRwpWN44Ow+XmGgdcGuw5/SiNc2cvYaay76p0UrQ6sPCMASbP45XVzbgV58
	azNRoAuTBKiT4mEGHiEJkxExL7l0H1Rntvnw=
X-Google-Smtp-Source: AGHT+IGk/HS1vx4EfCGI4dFGwAuLXmkcrlGKuUZjVSXZ43a4gop7RXKKeI1Ok/7F2vR2eAlPxii3Yg==
X-Received: by 2002:a05:6000:178a:b0:3d8:3eca:a97d with SMTP id ffacd0b85a97d-3e6289efdafmr9689272f8f.11.1757405859678;
        Tue, 09 Sep 2025 01:17:39 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238851sm1551187f8f.29.2025.09.09.01.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:17:39 -0700 (PDT)
Message-ID: <4005498b-d866-4e41-a8a4-d8228b2062e7@ursulin.net>
Date: Tue, 9 Sep 2025 09:17:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace kzalloc + copy_from_user with
 memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250908211559.519892-1-thorsten.blum@linux.dev>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250908211559.519892-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/09/2025 22:15, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify ta_if_load_debugfs_write() and
> ta_if_invoke_debugfs_write().
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index 38face981c3e..6e8aad91bcd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -171,13 +171,9 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
>   
>   	copy_pos += sizeof(uint32_t);
>   
> -	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
> -	if (!ta_bin)
> -		return -ENOMEM;
> -	if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
> -		ret = -EFAULT;
> -		goto err_free_bin;
> -	}
> +	ta_bin = memdup_user(&buf[copy_pos], ta_bin_len);
> +	if (IS_ERR(ta_bin))
> +		return PTR_ERR(ta_bin);
>   
>   	/* Set TA context and functions */
>   	set_ta_context_funcs(psp, ta_type, &context);
> @@ -327,13 +323,9 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
>   		return -EFAULT;
>   	copy_pos += sizeof(uint32_t);
>   
> -	shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
> -	if (!shared_buf)
> -		return -ENOMEM;
> -	if (copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf_len)) {
> -		ret = -EFAULT;
> -		goto err_free_shared_buf;
> -	}
> +	shared_buf = memdup_user(&buf[copy_pos], shared_buf_len);
> +	if (IS_ERR(shared_buf))
> +		return PTR_ERR(shared_buf);
>   
>   	set_ta_context_funcs(psp, ta_type, &context);
>   

More complete than the one I sent in June^1.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I had some other in that series, not sure if you caught those.

Regards,

Tvrtko

1)
https://lore.kernel.org/amd-gfx/20250612104430.41169-1-tvrtko.ursulin@igalia.com/


