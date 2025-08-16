Return-Path: <linux-kernel+bounces-771971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E7B28D5D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF09A23474
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAFA2C0F98;
	Sat, 16 Aug 2025 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQH53KXK"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83892BD593
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755343294; cv=none; b=M9J6Y39oVBjFebAtQjXY9YYglx6RC1wgl9W2csyDDUhQvU65A73qcIK1SsEWhwgqhdjivrrPPQEtkvTbphxshnG2goDxrX2wEjxumr4V7MecsY9tpxFX/cZI0jm+H9JBLr46wrH1UgSvjJbbIugfCNS2KQkvdlXfErnJjFBgfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755343294; c=relaxed/simple;
	bh=e8/bKiSuQ21FHDTgfooFez7lWBHr4zsQzLoYqAy//FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7WUqOyT7Ng13x+ZBDw8SUO/sHpmG56IjKZo/QWJ09G1/3doVRAG8DGPgMbdVGfB1nN+ltiwvkqQpfDoY8aTGEcScBiQ2EZ1C0HCfo8Ydrd1jwdnrfoZTD+U0CnzpCobsyJecIANd6tRk/bFNFBZm1uTPB9XVw4MZ1c0akon1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQH53KXK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so20100395e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755343291; x=1755948091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGt6rft36yXTfP1TQ0UxXsaJG912+AMVin/TPl3PM4I=;
        b=DQH53KXKRqO9lhGjbAvdpuVGoSh8DkSpDKwkQOvfT8NmVJT/IbVSzRZ6CdsdAXJ4HG
         NTn8Xxjx2kfR0oYBIvQth8YTJdkymXTIKwuGPK0tOwZzwCh02r/4QR/+oUv3kYIumGdb
         aHBBsfkZCfxnFFRup5118vDHttXcf4Ye6i20UyAnDbqnInvwlH37Ve6kJZFESF9lJHNK
         v77OuThf137rX2dmBYi3ZAAxHaSE6zPfpwQNlP9UaVqm15aGwJjHGTVG1BoaMKXdDofj
         McQDnuc/681ptHH5yjSwIf2OgXlJ4ArH+eAszN/rvSLoRqGmcz8zy0GFhB3PQf5sxbVx
         eH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755343291; x=1755948091;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGt6rft36yXTfP1TQ0UxXsaJG912+AMVin/TPl3PM4I=;
        b=uh9VLQTKgxuipVpMruyrVVYPzXlq0qnyLySi8TD58DQ8DhPQ2OWSoCS/uKqAK5MpLg
         AVq2yA5pMbxMQ16b2ztgbrCK7q/9v9g7FXisy1PU795ZjMMUIVHwi1QMdU94i+h6ZoVN
         92+2KKDTKjTW2ioLJqihw362dvs0gkDib4y460PC433WoL2akHv7+7fe2J0iolgxwmlW
         FPxvudWN36+LlE87MyDWTAUn5qG4DEU1g3gIo3tt9jVVCq5U8dl41AHMiHSC19SfhA6V
         SC/ZkefywgroCYoGZ0RtNv86okEQudH4ssLZ9etO2y7NAEKps0fPakVdslNsH7Dn2f8u
         aZcA==
X-Forwarded-Encrypted: i=1; AJvYcCUh5Mzml9eVF579rdWMTqdH2XJSq7jJ3j+HZkO4iBAWq2PHt0NjMjFhN7AizDsmcvH0gTHW+1sl0E/cIS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMophO1BS+tdcXwRj1IRxtp17wmBY1HWq+Qn21ANri49lrX4j
	2Fs5YsUlEm5Pj2AXu6BojRJrcwpE/BKhnhnsTcn14gE0ZqQ5V3xei3rIMSUjuX9/YfY=
X-Gm-Gg: ASbGncvrx/spV1vFRbdicxjv0s9Gd3n7pkuS4UI6oDHqRKnDlrtTP9dPJm1JnyiAv36
	ehcEnQbmxgO5cgGZ6yCAYTIINvwzhqvKOb2BLQdF9FOpVOtS1IwytVyvo6cNkxlhFZGhcQUouuK
	GCH7VWMvZtvM5EfDiQECjfMN6tIg+sp8kvggC0OKhV0AdZQfJCAAHOVASdsMQZkMcTCLhuXSr/d
	LKTLU2PSHkQyStgAdZHUtwGWXdxaN2tFOvh1b7WMgfLrTThQiLmD4xfwFIlCSY5//gffLgGZ9L1
	4R9EdK1Q0gF5oLsurSrO5GSpqTsLwBkarMhlK7N7PfepR2OI2ZVnFTSnIT/owV2Zs2ZHjp4OHCL
	DLN/X+/4RSzocr1izvQRFa8I9WkxdSi8EsPOcM3KezthK3tmShDRw2X2WIwXpsqoE
X-Google-Smtp-Source: AGHT+IFCJzvwwfKnWqviGD3X3ToS1q0H0hKgUffoHpr6Y85vQdUW+rTq2liswwooI6XtG9//DSyZdw==
X-Received: by 2002:a05:600c:4e8d:b0:459:df48:3b19 with SMTP id 5b1f17b1804b1-45a21839db7mr21528315e9.18.1755343291266;
        Sat, 16 Aug 2025 04:21:31 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22210a65sm53193325e9.6.2025.08.16.04.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 04:21:30 -0700 (PDT)
Message-ID: <e4dd20ac-84d8-422a-95a3-4d5c77b875a0@linaro.org>
Date: Sat, 16 Aug 2025 12:21:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/24] media: iris: Add support for video encoder
 device
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
 <20250813-iris-video-encoder-v2-11-c725ff673078@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250813-iris-video-encoder-v2-11-c725ff673078@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 10:38, Dikshita Agarwal wrote:
> +	if (type == DECODER) {
> +		strscpy(vdev->name, "qcom-iris-decoder", sizeof(vdev->name));
> +		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> +		if (ret)
> +			goto err_vdev_release;
> +		core->vdev_dec = vdev;
> +	} else if (type == ENCODER) {
> +		strscpy(vdev->name, "qcom-iris-encoder", sizeof(vdev->name));
> +		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> +		if (ret)
> +			goto err_vdev_release;
> +		core->vdev_enc = vdev;
> +	} else {

A bit of duplicate reduction.

if (type == DECODER) {
	strscpy(vdev->name, "qcom-iris-decoder", sizeof(vdev->name));
	core->vdev_dec = vdev;
} else if (type == ENCODER) {
	strscpy(vdev->name, "qcom-iris-encoder", sizeof(vdev->name));
	core->vdev_enc = vdev;
} else {
	ret = -EINVAL;
	goto err_vdev_release;
}

ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
if (ret)
	goto err_vdev_release;

once done

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

