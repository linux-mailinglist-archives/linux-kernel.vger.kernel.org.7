Return-Path: <linux-kernel+bounces-862509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D99BF57D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E413B72E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52F2E762D;
	Tue, 21 Oct 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ES1sGkVm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835618F48
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038720; cv=none; b=L31BkSxyYHG/o6tGvtaw5tY5NuH9Ddq9hwVc5E5iaktP/Mst8QUfU79q3Z0Kzlbqbt7+MZgdIQyOhwzKRBWKZHqDdiCFCziYPciPLyoFNu6QTMcpmfP2P5BUXZ4t5EmgIgjxI3neRy1cJ1zCKCaKi95QlFQYZ9KfW5Mdvg4waMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038720; c=relaxed/simple;
	bh=wOmHGZyZKyJNqAdT7tHEp7PbIwkY9sbR/Ea1DPL5/o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQgeWLzcXpthRyXqTZL4m2ueqT8AS+ExFXPBCMEAiv/jVhchqyOTfKzafdVHwDHI6x8F/kecKQMyJRpBzYgDQF+kz1l/NHvGyGtCPUxuj0u+eN1xlFh3DMSuIsHCl3+DkeemfQsDSMWCTENi9Wuts9LiwhR00RSnjyoIOww2JlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ES1sGkVm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8OK6u010821
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7nW2A2/Sdl+uA+0oNeIno2lzJVyfIo1jiDtXonqrUVg=; b=ES1sGkVmOXmoUqoZ
	BOuZXLEhjrmlGaBzUy8AfJwTkfgGwKDnyMlKODA5J+pPwIq6ttrAnb+efE9FZnyl
	AbVrs5C4+eWw/NoYx07MwKlhX9jeYCyR2n9eF9OVUEDyLeC2uWphjjC5EX8iUqi6
	ousMS/JP8RgDJgA19wWwd/aTAi3ghIwwyNyN+Aaz9aciUp5tIjxeqe6VyJEygfY3
	xpFrMyA2irDJMX7PbcTrW8D88xapHmuaVcizKtxcrIa/DifJMDplaWczqRX1G2T1
	H+es4mfT37LmDV75bV9Oww1vYS5wQtm76vnq3DSfHfJ/0LsIoj8dpsNmeF2JKR4X
	yaIfbQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wtgetd7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:25:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c19c8393dso19172296d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038712; x=1761643512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nW2A2/Sdl+uA+0oNeIno2lzJVyfIo1jiDtXonqrUVg=;
        b=k0MuOVhxT2yLVWPxxRpH5XxgMB7oCar3m539fn/BZcPxUdJNpIWxLko9euF55YDNqv
         vUZIZP84LCQRo/fBDzf16bNedQOUtRNhfIiDIPgP6LH2z8VwlZNpzxXedj4DATMlni0V
         F632MYfnyCiYIY3I9cWpDHbfeErngidfiJtmSFm2w9ODf+ZXeZbTlT0A6E1zU971zPNb
         vFjDoJLL0Tzfqk2xTaZWCR4oxwSMYNabzEYAATxd+MjeLFWrD8AnK/A5CJl+Of80W9hW
         sDe57m0AByO2ULBmSMhzEmzQbCbs4MZdlgbLhlvI+GYkt3kThqloTAGWb4a3sUGsQL5A
         EQOw==
X-Forwarded-Encrypted: i=1; AJvYcCU3NukGGeZTg8G80JvSeWmitAwWoiJe0N1yDxJTxgugSs0UJufZOKS0exqRF+LDkYXlswcLfbT+dql1pA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpPzkGM153n4QyUKkI3/MrLyTB9JaB6HOUO++EW8PbeX/2wuN
	HKaM20i2YMu9qF1+fb8kUkXH7/i9AgmWsLPJjUbaSYSLq5A1x74qiwMnIWd2HNDH7FqoqVVUXMe
	SZjqvEruqA5e9C3NYcUi1GEXHhBiYBFgdEjMTv4ml00QCvQ2TZfcubGQv/B2sxIR0dEs=
X-Gm-Gg: ASbGncvxcWUsLweHRBrma8FjSxPfD5bO1w1d5w58wQiBFiDrG2czIP54e2iyxvaCPGc
	JLITjkxlo5zxSV3rQjQw0PLLyxYaPV7pBRmRXbCYA2nYGpUyivxL7O9Z6cZpLF6o9iXal6d99Ed
	EHt7Y4DvYSOdpZURmWeKMLcteowCkVh/b2fGYPIS1H/mLiwnuL6F/016gTtnX4EEpr8WyNLkFir
	pbNUOZPfcec8MctV1Zhz1ROmjqQ7A5XaEtpE8SBX5tNuq+J8VUOKdyjGvluJNJxdW+VEVuny9uu
	Gk8jsV4MwXO6Zfvt+vDpdvSaKiisr8WWpRxX0sywA88SdQtxb6J2jmC37QgsqgbqFSouyu906xn
	qS8Yxj8IUbL3vrco79qqZbIg8qrRj4ym/MAPkX6s/z9v91hVWTx82A6hZ
X-Received: by 2002:a05:622a:4c7:b0:4e8:9bf5:5ecd with SMTP id d75a77b69052e-4ea1168541bmr18751931cf.1.1761038711959;
        Tue, 21 Oct 2025 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk59Wq45eSmY+tGWqEQNxDk//11cZC7q1beswb65jhbWLCg1ETbu+zF69qDRXnYYMyGb4j9A==
X-Received: by 2002:a05:622a:4c7:b0:4e8:9bf5:5ecd with SMTP id d75a77b69052e-4ea1168541bmr18751761cf.1.1761038711453;
        Tue, 21 Oct 2025 02:25:11 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb03671csm1014961166b.38.2025.10.21.02.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:25:10 -0700 (PDT)
Message-ID: <5569198e-5548-48f7-b64e-b7574ea59691@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 11:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backlight: qcom-wled: fix unbalanced ovp irq enable
To: foss@joelselvaraj.com, Lee Jones <lee@kernel.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021-qcom-wled-fix-unbalanced-ovp-irq-enable-v1-1-edd304d165a5@joelselvaraj.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021-qcom-wled-fix-unbalanced-ovp-irq-enable-v1-1-edd304d165a5@joelselvaraj.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rKuSNOS1rcfW7getGiR28PJGPJiHAaCU
X-Authority-Analysis: v=2.4 cv=JeaxbEKV c=1 sm=1 tr=0 ts=68f7517d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WFa1dZBpAAAA:8 a=6r-yMKpJyw27a2n3RXYA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=MZguhEFr_PtxzKXayD1K:22
X-Proofpoint-GUID: rKuSNOS1rcfW7getGiR28PJGPJiHAaCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1NCBTYWx0ZWRfXxQCZ+OmtPU7l
 25M2i9sjkCf0/T0v9kH2u7V6w30H/TdKbLfVGz6as9d+4quI8uX95uSczsPL2Y1OAfBfFtX6h81
 ufwukdPl3nwstKGR86FuXPhYYY4qVIgCepbbUpQJ+OEqZpGUYM6fKm4C+z/eo3o0mbM/+xUUyZY
 +oopbsaWVDm/WiHIPG575K8trcjys7JBWyz2rNFJGIlsfGTbFoH838gXBCPKYVICm+fZBjXWkfW
 luqNm0tJQealfBCBZsTC5mJWPlTdi+9j9USv1wPs0Pg9R0PGRuNSvpz+6I4c/1jMPD7pjo17AVN
 3DbMePquP6NaK6CwCfxQMc2N71DNTIwgyhmFCTiLTFdMGNzWtmWuhuemFBWQpIJTAF0UlfXM2M4
 q/GBOfLKyjgsIsKbMvZgzASjxhY6aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200154

On 10/21/25 9:33 AM, Joel Selvaraj via B4 Relay wrote:
> From: Joel Selvaraj <foss@joelselvaraj.com>
> 
> In Xiaomi Poco F1 and at least few other devices, the qcom wled driver
> triggers unbalanced ovp irq enable warning like the following during
> boot up.
> 
> [    1.151677] ------------[ cut here ]------------
> [    1.151680] Unbalanced enable for IRQ 176
> [    1.151693] WARNING: CPU: 0 PID: 160 at kernel/irq/manage.c:774 __enable_irq+0x50/0x80
> [    1.151710] Modules linked in:
> [    1.151717] CPU: 0 PID: 160 Comm: kworker/0:11 Not tainted 5.17.0-sdm845 #4
> [    1.151724] Hardware name: Xiaomi Pocophone F1 (DT)
> [    1.151728] Workqueue: events wled_ovp_work
> ...<snip>...
> [    1.151833] Call trace:
> [    1.151836]  __enable_irq+0x50/0x80
> [    1.151841]  enable_irq+0x48/0xa0
> [    1.151846]  wled_ovp_work+0x18/0x24
> [    1.151850]  process_one_work+0x1d0/0x350
> [    1.151858]  worker_thread+0x13c/0x460
> [    1.151862]  kthread+0x110/0x114
> [    1.151868]  ret_from_fork+0x10/0x20
> [    1.151876] ---[ end trace 0000000000000000 ]---
> 
> Fix it by storing and checking the state of ovp irq before enabling and
> disabling it.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> ---
> I am not entirely sure if this is the ideal fix. But this patch provides
> an okayish stopgap solution till we can properly fix it. I am open to 
> try a different approach if there is any suggestion.
> ---
>  drivers/video/backlight/qcom-wled.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index a63bb42c8f8b0333cd6d0ddc5bda93916da3fef3..36e2fe5c5fa37cfb8750254a75eff612741983c8 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -197,6 +197,7 @@ struct wled {
>  	bool disabled_by_short;
>  	bool has_short_detect;
>  	bool cabc_disabled;
> +	bool ovp_irq_disabled;

This is generally "..irq_enabled"

>  	int short_irq;
>  	int ovp_irq;
>  
> @@ -294,7 +295,10 @@ static void wled_ovp_work(struct work_struct *work)
>  {
>  	struct wled *wled = container_of(work,
>  					 struct wled, ovp_work.work);
> -	enable_irq(wled->ovp_irq);
> +	if (wled->ovp_irq_disabled) {
> +		enable_irq(wled->ovp_irq);
> +		wled->ovp_irq_disabled = false;

You can also create a short wrapper like ovp_irq_enable() that would do
it internally (making it harder to overlook assigning this variable)

Konrad

