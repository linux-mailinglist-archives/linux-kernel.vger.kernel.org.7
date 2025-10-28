Return-Path: <linux-kernel+bounces-873575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B1C1431B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AC72562FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984C30F7E2;
	Tue, 28 Oct 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="In3PHz1J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0058304BD6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648247; cv=none; b=osTsgKeI1iFgDZpsxfhwa+aK00pABOZcJhfV/fcd7VD//PpBDqaFny62TDIT7Vh9bLq+AsYg7vEJlRNEnVGHQMx+9Umi/9mYDfI0a4+5uo7qSR1GWz3L03mL3CDOcdv2x/6w/j6yzXomI6fwP3fGVyOzEdLJYaGAClB+4H6Tj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648247; c=relaxed/simple;
	bh=GeeaYYIAWxjBOaNlUKtLMdjCRhALVgNgHDnuskwW7V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4+l/B4hvUJwG1BD8wy9bXC/jpqVlSBEDLsTGEd4PCp2/Mp7FWN8MMHgkWiGRo+xTlWw4LfHkphr3ozHdWl6JEo0GdrjU8EeYw0RUxKmYIqsv1Bnw8/UpoHb5/m6DJR6YfNb3qusAoo8U68h/UPWzJnSa6xMWTd8TqxQwovKGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=In3PHz1J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S8j4Kr2881593
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	18D1Tvhsg2h3c4pitUQmQV+w/N7Gc+UGs5zUrp/01x8=; b=In3PHz1Jx7EYAyrO
	mOn0ZnY22pwzTJFXsnIYFx9zPlAzTgOVtoh9cgqrNAT+PtioJ5ylS/CurUmcj/bg
	WveWHmN6itNn4WxQs39kLzGZ386nX5WHOVfirE1m2MiG27/SbV0OGBubSjyILLJq
	on7Wlq/sAQ4a25Zh3gNZmVVr9K3a2GVyom5RrGGCvS4pPP63I8e17PonpXSx/0C8
	oGYaZ7Hi1Kf67OLcLzYSS1fbNRQjNv4lZpvhs6m3kgG1sDkyUIteuedUBUv00l4c
	KXGzZqx7uOba0pj5lSzdiWgsCW5yUhkHyfV7IUts169sm2EJoy3Qc9HxNrlIBc72
	AJEmOg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a29uhbfw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:44:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a264d65dbeso3858113b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648244; x=1762253044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18D1Tvhsg2h3c4pitUQmQV+w/N7Gc+UGs5zUrp/01x8=;
        b=Q6dGJxjeQWE8f5hxnwFNOqZ6Cf0mLpkm33GgWZgFD7XdYC90XpcEhKlPM4sA0UzO8l
         IkybQeQanzVWvzUJWJwS+UwsQDh0sxXkZulZj1jIsNfkFE4xsKqdFbIeaGkIgy5WklI6
         LydDyKGi5jrQmuATBAVDr1WtxOiJdVUllbFiYxVoRwCcfY3RzaUT/ON8jnoPjN/QKjP3
         Nb9sNiZL0PXI0QDpHJEFpXVvlXJheglg+1BumZ2Wr2oIueVszAKPVjTUJjaPCOeLYPXH
         xbcEDHtpNOMY3Hs6gUwQMo8Gt1TwKpWyaRvG8vxVGp2zSuS35Uw28Ik4DUhCTozjttxT
         9UhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvQZdZasSBEkT3STCc6yPne6oDjppxqjmwqn+oD/qWr+KywVJd2rYXDJgZlHyl4Wp7CSP+mAIfdU9Yu0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv/deQC6RL+wKfprHUtfgU3Fsf6R7vokxWarPpvXctJP9v1pnK
	swCRkKtxyVrTPM7AARJkPvFFleOgd4vpwOjWpOB4AqWbXS7GyXPy5QMQ3XXKGyJnbjbGg2LBuvn
	KnyxHP7ikm/zHcf10dwY2lAGtmioQjA0vb+ppPk1S36zn5oIG/0IB1VXp7YcdCXNIx7CmJT39/z
	g=
X-Gm-Gg: ASbGncvqEAfzw/6S9BvyYEtVp2+DWRBSqQmq5T8Hgyeqs7S+CyvkHWxZxJEhKidG7tZ
	bceD+AX6abdE46KReNGPpBoOROa4Cm8oLdISaL1yiOKMG/2f2FriZH8+6Oj6sDwIl7M9xi6yujX
	kbJFlXAY48CduTIvO4hNmCl6TZd/UVKzSRuN8j996a6H8cRoEcjcQ8uoSdtD+2jeWRb1tdDiyGs
	aX2MyRcoiVbiFbdtAqBEPqrOS7fsvNGO65UN+Sdet5x84BJr+/y1GJq/oIwCm24SixmgRxfaYV7
	clQ97u5fpixkkb6Jx1VvNtfQ91Rb1cQQgjQI3ch1Mz6N4jeKnT3FtgLy+cK6USrXHleP0xJZYnM
	K/NEEHnOfBvNTZ/a9NORj47y7FhDQxGg=
X-Received: by 2002:a05:6a20:431f:b0:2dd:5de9:537d with SMTP id adf61e73a8af0-344cf47453dmr3622888637.0.1761648244088;
        Tue, 28 Oct 2025 03:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv0M4w0uW2ohoIR2GHVf4JumJDZiUUaI5rrLa/broLDpgfzcIyJB09BzOHTB5iQW4PvotWtg==
X-Received: by 2002:a05:6a20:431f:b0:2dd:5de9:537d with SMTP id adf61e73a8af0-344cf47453dmr3622857637.0.1761648243587;
        Tue, 28 Oct 2025 03:44:03 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdb1fsm10094723a12.2.2025.10.28.03.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 03:44:02 -0700 (PDT)
Message-ID: <7b7f9642-2bcc-1cb3-8926-fa129456172a@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 16:13:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: venus: drop bogus probe deferrals
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Bryan ODonoghue <bod@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251017055809.8037-1-johan@kernel.org>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251017055809.8037-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ILQi--arO8yFh02mJcxRMh-SHQfHqIjA
X-Proofpoint-GUID: ILQi--arO8yFh02mJcxRMh-SHQfHqIjA
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=69009e75 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HlSd1kt9n31nswzQv1QA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5MCBTYWx0ZWRfX9+7EMxvZjTK9
 6gRyu0Q4GxAkg7Ls66YvutaCQ5oAdLwWFC9CjY1gC3ttifVpdyrkpZ4bSpivYQpWED8Ig4iAVAw
 k6DZpw67M/9E8BEjLXAsGiIBWeCEy5kqHldvClbWzT3TIRwvZrka07VL5J6N5pS7mka1XGpTInm
 shSMTpDh0O9g61DP3cQySuOkvUj6URc8kC0SIDVspHdZuyCPr+3h97au0Y9TnTqC++xBKXD4Pv3
 yLBlbwejL2AXVwyuA4nPCrodGMBS+xhVEesZpNSgGlmMPhSccPbOJwmjYTNOcK/OtiLDfgFlft4
 avLWwP7RsvQmseEymZHtaDMPIPbEYiFPkv+ckPfCVB4WD6R5EUf4IREh86wDd9K18xR2dOFp2KU
 hyR+MKfj7KVH0yBoRIIiE+lgg27dgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280090



On 10/17/2025 11:28 AM, Johan Hovold wrote:
> The encoder and decoder platform devices are registered by the venus
> driver as children of the venus device, but even if someone were to mess
> this up no amount of probe deferring is going to conjure up a parent.
> 
> Relatedly, the venus driver sets its driver data before registering the
> child devices and if this ever breaks we want to learn about it by
> failing probe.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 5 +----
>  drivers/media/platform/qcom/venus/venc.c | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 55c27345b7d8..2d822ad86dce 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1778,12 +1778,9 @@ static int vdec_probe(struct platform_device *pdev)
>  	struct venus_core *core;
>  	int ret;
>  
> -	if (!dev->parent)
> -		return -EPROBE_DEFER;
> -
>  	core = dev_get_drvdata(dev->parent);
>  	if (!core)
> -		return -EPROBE_DEFER;
> +		return -EINVAL;
>  
>  	platform_set_drvdata(pdev, core);
>  
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index fba07557a399..f1abd2bdce6b 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1560,12 +1560,9 @@ static int venc_probe(struct platform_device *pdev)
>  	struct venus_core *core;
>  	int ret;
>  
> -	if (!dev->parent)
> -		return -EPROBE_DEFER;
> -
>  	core = dev_get_drvdata(dev->parent);
>  	if (!core)
> -		return -EPROBE_DEFER;
> +		return -EINVAL;
>  
>  	platform_set_drvdata(pdev, core);
>  

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

