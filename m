Return-Path: <linux-kernel+bounces-771936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B28B28D08
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CA35C3A13
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFAC28F51E;
	Sat, 16 Aug 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="civYSYls"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443621CFF4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341403; cv=none; b=DVtHCEdVqdRkjjx7FOtTfR3WXHYlW6hoU6CGks/3avEpLBX2nb0e4/iVRwf2sgoEX0YO2+q0FwJ0s6rRv6JPZp6kGPq65AOu6QZNNEGMiFshFAglhyzar3BjRHzqj5fTJBKpjvHmWmlf0IoPoTKKqti14Hyu8braeJJQbP/RM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341403; c=relaxed/simple;
	bh=doz42PD32C7caXkh5JHONCE2ZOdONZJc6Yx0NMQtnSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7+QjffV66am88JDK9TTDalgiPPV5k8kAmOc1/HffV4fNBgo1VM7KYl7LWc0nqXuL8x2wNDXlLX00Gm4k1hGZZSGHbmQyVBjoofSIabUAPs1PygtNaVO9xF39HPNBKw5VaPwm215virxWI59dxIPFDEYMnay9bgcsGd3hSeAjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=civYSYls; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso15892635e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755341400; x=1755946200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwwivMGnEw2uIFchpfZdnqFMVWS3GjK/zVl2JQuqPm0=;
        b=civYSYlszTqujTcerSF3GMsRE3F3MT5kFJ0r1tByjMyep8shuH1/6RJnLGhhIBw0c0
         mr3l6hNlvx+fzSQEZtcebCmQ/wXvaaE865jU0CvNUuLHzOBlxbJKkSzkI72guOI2+DUx
         kQWjws2D7tdZsYaF/CEcLveD7oFPNiYoFYCiFq2iG7Cpb09mVBYloyRyvMhXGi3HEOe1
         72lskpcYZah4k+yZjn32uMYI3iUTW3VsSsPzrIWXhjWIE62T9A79yb3KKgVIhyqI8Kcz
         jVMj5lEWveAkscVCTrr+P7SQD8nCs5tLfiZ3v4kuFMA0stdhFboeTe3HyRSy5UnpjSD7
         xXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755341400; x=1755946200;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwwivMGnEw2uIFchpfZdnqFMVWS3GjK/zVl2JQuqPm0=;
        b=xLmZqD7I0h1SL4jpp+q5oyf7iuJ2T6NBfmJ9K8XkOnsf5ETVWT7VremhlZ78tIlUAe
         ZQPO5eIt/sY/lhsBE/B5WKjojdmgHkgzHU2NKApWfbzT2uUGB4HkjyUDEiuYWCQg0Gqk
         wGvb5b6LuXQ/cmS0+dkXZRMbnfycbRaYfHauWQtzPxUPzdGSD10ZuEPwQprKPicEzgC+
         97R8MW9Ap4vj0OsoInZIIVIlTFhhFBFGwEp1gcnlwE9SQiy2joXOYL07LZCC25A/IaP5
         TxpU0wvO/qzTbvZLcl3W2u2dhQ18x2oxnz3aXScsFmW0PvB/VJiETKUDyZf7ZLtc1HZB
         MjmA==
X-Forwarded-Encrypted: i=1; AJvYcCXveH+StD+faXF6aMtYYOzJTk9/dilHtYqoWA06Dw127OYOwwHdOfH+u2rxq9fG9YZNgiV90zbBRwalznQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYXR+SrbvVcwoYcj2uogI7BBE0gX/ejF7p03U4xVor52NjPkXQ
	+M8WHXOBeyABAQJzwE5Vl0ASxTTYMJQq3Q+m3Cmg3qfgIM941WCzl6Vn8Lppzj+hyRY=
X-Gm-Gg: ASbGnctZS5pEMJOIJ75TAifP+CTrFnQJiNBvgz7QYgC8AGnV43UBjo0JfLKuY9PSwk6
	0FJAbcLajeeJIiKMeXErPMsSdrtYVqswgDGCMu0BC/bT+5XQaTEkrQQFG4ublKJoA2OgPwq+DfB
	qEt2hBlnZWqmcyZHX1TD5URKMNeZ5WOPTaDPDdaz8NUnRLn1D6Nwu6HgBf1koqqVMfRl0UrLqus
	AVwdtqZdJdRX4310eYCoeNlTv2ooIAAi1WffdfOTqdXcmQBT9/ECVrz8blvwz86bvXGnDStEv3b
	zGT3lhUaTXy4SnAHUYrIqqrfNO6zby2Kfbeixjc1FKG4iI1Ta+IClJwsW4gjBEaAgrA1t5Dn07O
	9vu6NOYi6KylpeJW9rA153cfKaHv+Pf1xYvao+ccWwTcqTtr8paHR1mn74k+He3LC
X-Google-Smtp-Source: AGHT+IE5o1fNVVbU2Hem8lhgp/yOa9qYSWveharYtFOMpSTzQ18tGJVdXt4smsZsAVwuhr9xInUKkg==
X-Received: by 2002:a05:600c:474d:b0:456:1ac8:cac8 with SMTP id 5b1f17b1804b1-45a2180b6aemr48450885e9.15.1755341400420;
        Sat, 16 Aug 2025 03:50:00 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a27fd554bsm12863585e9.13.2025.08.16.03.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 03:49:59 -0700 (PDT)
Message-ID: <d6c26171-8be9-4c15-a105-3d641558032f@linaro.org>
Date: Sat, 16 Aug 2025 11:49:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/24] media: iris: Update vbuf flags before
 v4l2_m2m_buf_done
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>,
 Vedang Nagar <quic_vnagar@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Renjiang Han <quic_renjiang@quicinc.com>,
 Wangao Wang <quic_wangaow@quicinc.com>
References: <20250813-iris-video-encoder-v2-0-c725ff673078@quicinc.com>
 <20250813-iris-video-encoder-v2-7-c725ff673078@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250813-iris-video-encoder-v2-7-c725ff673078@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 10:37, Dikshita Agarwal wrote:
> Update the vbuf flags appropriately in error cases before calling
> v4l2_m2m_buf_done(). Previously, the flag update was skippied in error
> scenario, which could result in incorrect state reporting for buffers.
> 
> Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and firmware response")
> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Tested-by: Vikash Garodia <quic_vgarodia@quicinc.com> # X1E80100
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/iris/iris_buffer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
> index 23cac5d1312913b8dac44347ae66cb80a6a15deb..38548ee4749ea7dd1addf2c9d0677cf5217e3546 100644
> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> @@ -651,6 +651,8 @@ int iris_vb2_buffer_done(struct iris_inst *inst, struct iris_buffer *buf)
>   
>   	vb2 = &vbuf->vb2_buf;
>   
> +	vbuf->flags |= buf->flags;
> +
>   	if (buf->flags & V4L2_BUF_FLAG_ERROR) {
>   		state = VB2_BUF_STATE_ERROR;
>   		vb2_set_plane_payload(vb2, 0, 0);
> @@ -659,8 +661,6 @@ int iris_vb2_buffer_done(struct iris_inst *inst, struct iris_buffer *buf)
>   		return 0;
>   	}
>   
> -	vbuf->flags |= buf->flags;
> -
>   	if (V4L2_TYPE_IS_CAPTURE(type)) {
>   		vb2_set_plane_payload(vb2, 0, buf->data_size);
>   		vbuf->sequence = inst->sequence_cap++;
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

