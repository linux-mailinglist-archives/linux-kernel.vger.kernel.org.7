Return-Path: <linux-kernel+bounces-762349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18352B20540
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2353F17D0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45338223323;
	Mon, 11 Aug 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sf4jS52C"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C334226CF4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907917; cv=none; b=XN0wcpFJS8ryvqgc5bRWj9YU6/5vyQRroyZWrwNV2ji8+hZM+X+/1xQWBx9LOHj/4oHgCpJzkrpcfMzjFiYxc7M05igCbmfG3Abah9Mi7UpO0pVQE1dMQThVCgC4tQJK6ovqLl8Oh4kDnAZKSkpllUbOxbzvggDfTgkyFdqBZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907917; c=relaxed/simple;
	bh=SWrb84QUiPuoeXvVrcl0ZZRqWXk3rbnLIkVkm7Ug5cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKy5AQPCyQAJmYtMN9Il4su5e3dYTQ7I/I6Y9uMWAWpVN41ZTzECgtD5toORH8FIDU/93N6Ugl0RJaJz3nnw+aiyf/Q23N+wjq3WlbPg48DFJTpnZ+E0UNBr1ANK4fmQzMW6pdLYxVcK0t5Y5/+78RyullVBM309C2flkgEw1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sf4jS52C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459e3926cbbso16998645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754907914; x=1755512714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+20LQ4IAs50782oNhums4Ligk+XhQIG/qWbM6HJON6s=;
        b=Sf4jS52CYLhRCxyF6fC+JIGz5/8GA4CUnYIMYRU4dpsP3iHRLOakCq0tviP3iIBD/n
         VvOuEU0JHbBNq5X54FhWxtNmEgDmxLkmn+j4V6Me336CLjJicIXMLFhgioHoGnHivo7b
         zeckaH52s6F7fKsLy3AVbwS0RNDiqs0fPkOvGPoc5hS1R9QEsJuc4Y8B1EGqzXdcCu3h
         ZhYGyIGb8/gAfcUdbsJIJ0ILT3vnT/nw9co/luOCCVe1fGOFjTrfBTbDyYM0jJnPWDeU
         dwFp9usDeemjkzhvGZptR0ssOOqMim7tJqx42D88LkFp6vEXQMI3BDCLIYA9opRhmsXy
         IwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907914; x=1755512714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+20LQ4IAs50782oNhums4Ligk+XhQIG/qWbM6HJON6s=;
        b=wm4drCCaVDar5EkzS5LBFlONw308UdTRrrWKIV/fIL4nSERVDEZITZxlQK9udQzYju
         GPiNRZfo3ZjZL2BT63uy+UHnjP5YLYZl1kMAavKZSW6Fr5g0ntDawcSarcctbj/r2ENo
         KIQo+1bYGmUtaw2DRbsHoHv4s+2YtxXsNU31/u3QSNSL/P2guLx6cbM19HTb8ZRosSoF
         qhZxXjvTF6gfsd9pc/7jm0AR4a999Hdc/X/EYcgpX7kbRKsbwd1Rmi1DJ4yH8glwsJOB
         q/Gwjmreqo9+/TAXnAZMFrbtZGloBhmvhI7gamlX/n710o9cbknSm/KyHxb78aUDM+/h
         poNA==
X-Forwarded-Encrypted: i=1; AJvYcCWqFwwNd/KZvJPjS3tSpmIK3yoHjOE7jnEFE5mzp7c+17I7k7H+r6kkXQoTy11pHfrNPHm21sgcIFESBtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxba9CAtcMwKBP1O6+kolScHsVuw0v1ZzbquXH5OkdSEIYAktf2
	FnaSXmIt/XrSv4gS88vFDfT/i6Wj/s4QncS3WKc10umFgjE1dfcj+jWZ/JdGcMEkyGE=
X-Gm-Gg: ASbGncva21f60X/0TQkUTIHwxvXlWtJGXZKlWZUQymtiZeK7icIbY2QnFsv+xBLRzPS
	PGua3yFHww4WLoHCctIhixduFPvLpbjFzKL3unKe5NT3+jLOJMueF1rPJUVZFD7UhXtCbgN0NBo
	IvHbnhTOot3UP/QmRh0E5II7QNinSBuQOkzQbj9Uct1NYZCQn13WiLOZuPc0GU4AnMbyzAbb82V
	SvDduadinAHwtNSSZ+mAbaMvAIOS52PRdGZ/IcLdc91ldcgEvHtI3zHZtgeklX2M1GXuNok2IFt
	ODPzLNynRsTnRBANHF/aHI6rMvBAlFTaV1ICxwOPYyS1IB/N6INxGp8vwTG0uALauWNvPeJlgv6
	3z99J7ChxMdqtFTJbajnS/owK2pw=
X-Google-Smtp-Source: AGHT+IFgXH02O/YQvZLqP0OZQeahzbzE8tZ9VkaKNzJgbDPsZVvgFU+YvPp6zt7EljlXrttQ/pHNqg==
X-Received: by 2002:a05:600c:8207:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-459f4fc40e3mr132304345e9.31.1754907913809;
        Mon, 11 Aug 2025 03:25:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583f9fcsm243685145e9.4.2025.08.11.03.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:25:13 -0700 (PDT)
Message-ID: <de68756d-7ef4-484f-8eb0-26a88ed41cad@linaro.org>
Date: Mon, 11 Aug 2025 11:25:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight-etm4x: Conditionally access register
 TRCEXTINSELR
To: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20250811-trcextinselr_issue-v1-1-ed78f3215502@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250811-trcextinselr_issue-v1-1-ed78f3215502@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2025 10:57 am, Yuanfang Zhang wrote:
> The TRCEXTINSELR is only implemented if TRCIDR5.NUMEXTINSEL > 0.
> To avoid invalid accesses, introduce a check on numextinsel
> (derived from TRCIDR5[11:9]) before reading or writing to this register.
> 

Looks like this should have a fixes: tag.

> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 ++++++++---
>   drivers/hwtracing/coresight/coresight-etm4x.h      |  2 ++
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 42e5d37403addc6ec81f2e3184522d67d1677c04..8a9c4caceff0165e4fce7ac4250f3e16ccc1d34e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -528,7 +528,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
>   		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
>   	}
> -	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
> +	if (drvdata->numextinsel)
> +		etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>   		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
>   		etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
> @@ -1423,6 +1424,7 @@ static void etm4_init_arch_data(void *info)
>   	etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
>   	/* NUMEXTIN, bits[8:0] number of external inputs implemented */
>   	drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
> +	drvdata->numextinsel = FIELD_GET(TRCIDR5_NUMEXTINSEL_MASK, etmidr5);
>   	/* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
>   	drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
>   	/* ATBTRIG, bit[22] implementation can support ATB triggers? */
> @@ -1852,7 +1854,9 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
>   		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
>   		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
>   	}
> -	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
> +
> +	if (drvdata->nrseqstate)

Shouldn't this be "if (drvdata->numextinsel)"? Or it needs a comment 
saying why it's different to the others.

Otherwise looks ok.

> +		state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
>   
>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>   		state->trccntrldvr[i] = etm4x_read32(csa, TRCCNTRLDVRn(i));
> @@ -1984,7 +1988,8 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>   		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
>   		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
>   	}
> -	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
> +	if (drvdata->numextinsel)
> +		etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
>   
>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>   		etm4x_relaxed_write32(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index ac649515054d905fa365203bd35f1d839b03292f..823914fefa90a36a328b652b0dc3828b9bddd990 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -162,6 +162,7 @@
>   #define TRCIDR4_NUMVMIDC_MASK			GENMASK(31, 28)
>   
>   #define TRCIDR5_NUMEXTIN_MASK			GENMASK(8, 0)
> +#define TRCIDR5_NUMEXTINSEL_MASK               GENMASK(11, 9)
>   #define TRCIDR5_TRACEIDSIZE_MASK		GENMASK(21, 16)
>   #define TRCIDR5_ATBTRIG				BIT(22)
>   #define TRCIDR5_LPOVERRIDE			BIT(23)
> @@ -999,6 +1000,7 @@ struct etmv4_drvdata {
>   	u8				nr_cntr;
>   	u8				nr_ext_inp;
>   	u8				numcidc;
> +	u8				numextinsel;
>   	u8				numvmidc;
>   	u8				nrseqstate;
>   	u8				nr_event;
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250811-trcextinselr_issue-f267afa0e5ed
> 
> Best regards,


