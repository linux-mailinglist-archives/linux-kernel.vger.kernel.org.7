Return-Path: <linux-kernel+bounces-762299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF0B2048F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA1C188D333
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AEF222582;
	Mon, 11 Aug 2025 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x26Xvxg4"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEA205AD7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906072; cv=none; b=a8HIsn3iIqK88oqVzBpeAFy6D00bZs8HTFQddZpr3k3vJEiKSgT95Wr/bC9bY+Fg3/AP6+Q2DUDVuKVuuARKMlbcp2dP14gaSvXW3cX561FYSd66NsSpZdHWhp3DtjdjQm6GeoW62O821gDexBhWy624HmV1tD/ftQtNkfpOJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906072; c=relaxed/simple;
	bh=Nr/Zc96NOCXVBYCb5kWDyvXIpmXjObnc67hVK+GSoIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOafqrL4r/9DC2BFNjdqSnXo80mXQw/Q5cDLaHaC6Ztmt3opITEBoPVqfctKXAl5YglCbIHmdjsUpWMItToEBDrJoYz+relWm2hMgj7kxdzyhhw6PesKS04f9zzvty3iGnhQ1VU2P1rp0pPVXyh4SfLOsUJnVu+EzhHDZVEkLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x26Xvxg4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b794a013bcso3559907f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754906069; x=1755510869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SB4vnpXFiG3Tz1CHMP1RECPLWqu2Bxoslj8wFFWj+OA=;
        b=x26Xvxg4P6SxW8hHlwLOsDuJFxZNhLomHiRoZ0E/rp6JeYNCnRjQAhnbMUJzqdqn7R
         NgkS14VdPcHr9ZuKEOl5CzRj6JzErxLQ90WGJqNhfsfq2eWwHD56vIHoe2mwthVn0or5
         p3nXkewtXvXhHTHRnxMJqQrz/9XLwJAsHces9Qay1lbXc378SpCtYSoOqlabxJAq/oRF
         TjxbV/FV5AfonX3T7BYVB9vQtHX1OsNaK3k+BqqodN9xn3Tibt3fhwg8PYLX4Dnc9aBh
         AAL05aOQGJuuKfZerm1O/kE6L0gPLApezhpVbK2COxa8ZqajoefzmFroMnllKmXRvDAj
         F3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906069; x=1755510869;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SB4vnpXFiG3Tz1CHMP1RECPLWqu2Bxoslj8wFFWj+OA=;
        b=nLQUd1vc4yQKMnRksbY+upkV3etFldxFHzxDIRjQF3UdOxOeU8puRwbeWJRTYsq3pr
         i/M1uh9fEmM0j0bzIDjzQR39TidVf/h2gcAvgi4Uh7Qb6iKoLH/TtJDjnD7GfeuG33n9
         ZwICBvp3QvAbR0NFmd2+cYETAtYARhFEEM4ZCSneqoBICfYkZl+6fPSi9fjAai96JYpW
         9aShYoOEcOkbQlDiz9urAV+f3Pl1DOHUmykxRqUGZ75t9V3eJe7TO2WkMNKkwtgQPAzI
         XlRFx/M/W6SZJQurtx7qttH8enaFxKjKNwXg4D20oEB4dugqqj8mVO4SjH9idpKfyhTC
         +dvg==
X-Forwarded-Encrypted: i=1; AJvYcCUsT+wn1PZfohIXt24miy3h6ibjPyW7s8aB6P6pXpFVz/3lRXG3WV1VqIhknwEDteKH63VEyVRC9kmLekQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBT1m/a1fbUPZKTsJ5/cqfnPtfy6vEmSfdF1UCUGUtXa7XXs9
	KCGW41XRu4gSmvGs7deYUy4tKlmXnt3BBNqodoiRZLXp6f8umJBRl1Zoor9Sk2JrTkw=
X-Gm-Gg: ASbGnct8u5zUgjBLg4kkwarf7+8JcApzLL5gYuWpUNTmlMHY6+9rdSWJemzaG/H7tHu
	o6vOKQDVG2vmpJScbQ8bRM+ypxuPBW96aYad1aFr3zSm2gALB0cOfwJ3h2o1a/AltytNbl4LvSV
	mrUOEGOAwAETsTCm4lUTQ0sU/aMMWQi1HAha/WxgQ+6kLBQHBctmtZgfBUFCHprLk0v7zHKtJJI
	OEdN1KgkZ1/dri+2Ffbt9RCNFoWH3401CEmX7dNuC6S3vgEA0ZDArd38fe4jCNbEdp1NEKoaPmY
	rn1bPtV1IKfPHjLq63AZEmHTmjxtm57alePR+JePuNL6Lihhr1Ych7UBS1TWbMtlXk0CG3YADxa
	p8PvEIxBAdofzzEDbDVJOFAtRqFeMpwuSLskTB5ivS4K6c7gHkF4qrnGvEZAb/GdDW2I4JwSMfQ
	==
X-Google-Smtp-Source: AGHT+IFLWaeyYt4QW6TcIL93toOpoOSpJi+FGEvUSeA8yqAuAWz6vKsBb7k0ryhdLbJ41J3PK6Tr+A==
X-Received: by 2002:a05:6000:420e:b0:3b7:dd87:d741 with SMTP id ffacd0b85a97d-3b900b78c90mr9197547f8f.42.1754906068602;
        Mon, 11 Aug 2025 02:54:28 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dcb86d6asm298162405e9.5.2025.08.11.02.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:54:28 -0700 (PDT)
Message-ID: <06d96ac6-8006-4a46-8f55-e1988c0feb1d@linaro.org>
Date: Mon, 11 Aug 2025 10:54:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] media: iris: Fix buffer count reporting in internal
 buffer check
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>,
 Vedang Nagar <quic_vnagar@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-iris-video-encoder-v1-0-b6ce24e273cf@quicinc.com>
 <20250704-iris-video-encoder-v1-1-b6ce24e273cf@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250704-iris-video-encoder-v1-1-b6ce24e273cf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/07/2025 08:53, Dikshita Agarwal wrote:
> Initialize the count variable to zero before counting unreleased
> internal buffers in iris_check_num_queued_internal_buffers().
> This prevents stale values from previous iterations and ensures accurate
> error reporting for each buffer type. Without this initialization, the
> count could accumulate across types, leading to incorrect log messages.
> 
> Fixes: d2abb1ff5a3c ("media: iris: Verify internal buffer release on close")
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vidc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
> index c417e8c31f806e03555cd5e2a662a6efe5d58f3e..8285bdaf9466d4bea0f89a3b1943ed7d6c014b7d 100644
> --- a/drivers/media/platform/qcom/iris/iris_vidc.c
> +++ b/drivers/media/platform/qcom/iris/iris_vidc.c
> @@ -240,6 +240,7 @@ static void iris_check_num_queued_internal_buffers(struct iris_inst *inst, u32 p
>   
>   	for (i = 0; i < internal_buffer_count; i++) {
>   		buffers = &inst->buffers[internal_buf_type[i]];
> +		count = 0;
>   		list_for_each_entry_safe(buf, next, &buffers->list, list)
>   			count++;
>   		if (count)
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

