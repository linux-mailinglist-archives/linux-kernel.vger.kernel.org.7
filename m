Return-Path: <linux-kernel+bounces-846883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C784CBC9543
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8292919E0B06
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E061C2E7F0B;
	Thu,  9 Oct 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1uNZLL8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39EF2E2EF9
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016994; cv=none; b=oVudTkQZCx6AeAxDsDZ0mwvB3vSZYZ6LMY4FbRDiPY+mnECEHBuMsCbBPQop7stTgT7DXX9Zq0ZKJK1+98crr1RePiUu5LMQKzvj3G7CDUHdj6K/2LnKQUa7YlNx9qDAIu0shKbmkoNQkrzGSTMZT0R7QwneuFO3rNmB3hLYrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016994; c=relaxed/simple;
	bh=dzVbdWVRpdCQwe44yn0+dLpxIzypbEGpFZhHd/JbGpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj9M/EQtBa3Ef9IID3YJGUrwo30y8ZsBZ5im9rSfosJfXiFetxFPKh4ZJaa4w1E9tdaXEDQKvJe7PdOBT9ndJXlyoPuA5TFFUAij79pRQBiWYpM8C6xpTYWiZY0k74AARcUU9lXXJwh+Tt/rYeZU5xSS++ZzmuDwu6APxbo3goM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D1uNZLL8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EgTK022541
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 13:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yKk62FEzjFLvqKcTvlSOs87O
	G55ubXymcmIf9wF5OeU=; b=D1uNZLL8jMqNYdJNm8C62LqtYaqi902RqEIc5Thf
	wNQhMaXckERXRtoxlVNKSdDPfLPHWSWvxpjxPGW9cDVEyP7+rbKg5je3BnbmF0DD
	9Zf23kLkFxTMEBkmGQzDWcrjyi2ujaEgWtnT44zfQpllLKS27klBpIiRwI3Fxihh
	IF9ce1iVZ4wASNjWPVfAIulmMO6Xwjr0KkF7pyAHyq5eZU+KyKq3fnzyb5a+ez7v
	iMh98GUOrtyWJkuQJWqX8dFx3glwmDhI2Tn8+Ju6TT7aVE7u4ZLd7vj7tPTJ44e3
	NbMmECT7TkziSAcZbwDvm2Y984/lK6g86S2g4lFwUEcxrQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4sjy51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:36:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d6a82099cfso35070301cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016991; x=1760621791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKk62FEzjFLvqKcTvlSOs87OG55ubXymcmIf9wF5OeU=;
        b=tOOz80g1GzsSNVFzYI8LQ6Cfcl2vj0o0S17t8XFGMRwPZ/QRj9Wz8MxA3Ukfj/xIEp
         Q/ssnYuQj6759Z5myLPz8Dcrhj+EG7o9JPUGDMlVBnyLax47pV5jTM7/4Bjnd4L/UOIO
         FZvhR5FiCiQxVhQFvHyvnYB9yZLsyfVmOyBnk+BRAPmcsmqoXoMLRfHn43gYQOJbgtP5
         hWA19a0o2uWVzdlb+1y0rVL7DcUo5Yh3XCr8Eoy0SeOFnu+f16G7HXqjnRE0dDHEmrdx
         ASYJcEa6QvJBEKUEZ4jSwfvfrQNvwKrsxYpjkUyyKerMpLwU1/TBsDbpW4bHrrwiRXMu
         IXAA==
X-Forwarded-Encrypted: i=1; AJvYcCWgpsGEUWzQu7hqvcXWBSiTLm28D6JLmuGWdinPnBZJNpITLbrAxuEi9KIm5RgnNrQ/KFn7QrHxCxXbeEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd++buZ443VD3YYWg9w0zHBSgeOctoP+IAolA9lmgtmmea67ml
	oPJogpTTelnAHLFWymkIDVPT7XIFFUmhpw6CwR5T4o1WNnnfTg/FKVh16OKoULEG9VokYXY63/D
	0SisVQ5uGIoSBW2L864QMrgYgMcmrNF9jh6DlvFUhkL5HUK3fEf0ra1J6v+YA6WrkHMQ=
X-Gm-Gg: ASbGncvqP/kXw64m4KBWQk9MsBQb+8CY+JvCHlMtN+B8/9BINkVU4nwFCmldX7ktxQn
	UG/R5n/6vJVv0mEkBD/faQYSeUh3Uz5VH968QUOzjB/pSbytrhPH1tnUO1HxynXkAofJV7sI/uu
	ijEbKuqDQ+Fgfv3UeRkYy7Hg8MMdPceV9jojk6In7QTAmoFxkp9XXG/G9wKW6SnYKA94NcvCC74
	XmrxW6dqBxNdNKA62nsLq8A1DcFgQ/68cT/S3HqtjLWfoWDfEf6iooO5OKtY1n1MjCZ8bSnXcje
	a82Gk/y7hHEge45EZts5VtLUXXwnQG14tDXRe2Y+Ep4YpeETwgY7zwtBMR+nNo3tTvWNSd0mRfP
	f0Pl774Z16Dwg7iCju5u2Dyesg5pGkg/uMwzd+yJZq+Dr+9nPPbV/ofkldw==
X-Received: by 2002:ac8:538d:0:b0:4e6:ee34:2f0d with SMTP id d75a77b69052e-4e6ee342fccmr75785251cf.76.1760016990683;
        Thu, 09 Oct 2025 06:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBayiHdte1PqGG8y5/gMAcwfyHqEEg07Q+fYuVHDzjQ3vhgHJi9sxsB+yLdRrcMItaI5qh3Q==
X-Received: by 2002:ac8:538d:0:b0:4e6:ee34:2f0d with SMTP id d75a77b69052e-4e6ee342fccmr75784741cf.76.1760016990084;
        Thu, 09 Oct 2025 06:36:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ac02026sm1060639e87.20.2025.10.09.06.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:36:28 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:36:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: leqi <le.qi@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
Subject: Re: [PATCH v1 2/2] ASoC: qcom: sc8280xp: Add QCS615 compatible for
Message-ID: <6g6axenrh3bqli4epwmckzuhxrbji7c7kl3deedag2ur6ojubb@6cxo3nvtfuo5>
References: <20251009023341.27277-1-le.qi@oss.qualcomm.com>
 <20251009023341.27277-3-le.qi@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009023341.27277-3-le.qi@oss.qualcomm.com>
X-Proofpoint-GUID: XRnjMfajaLgywY4Bn1qtVB0MbLuVUBCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXyDrOGSAEQ5wI
 DgHdnS9K0K1igvJn2bsc4IFCyxuzk1fwGek0MTbFdlNPeyaRHlcYLlhkMFeaURY1YHY53yoPCE5
 si7zLcIxY5yaUG3FMlj6Rzk+/9mZ9HkGQQ4IzVYCEmilHQ0oElsOTODYXePE3wDipmmcTJuyPFb
 8f7XqbpJe5D0ceB0edKqjsuBMhkmASQAJJFcCopbYt2NdlViCgLDG5eb3r04h1BreLZSsH3yZ5M
 EcCOhXIK9009IGXGcQRtr71kdIshVs5VLqFUT7KZXq1OY+NX3dYUhc/VQbb/1a8DrAp0uYUI0O+
 FuTUy94RaP8EKQTfgYFfMWglZmdgU0OsB3pWATqOFgVqTs7/3p6p331g+miICj5lixQuS5dGt4T
 7hJIai+nn+faTFbr6m49wPwNC0b57A==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e7ba5f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=ZMBecpqfj0tL_UAVglwA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: XRnjMfajaLgywY4Bn1qtVB0MbLuVUBCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 10:33:41AM +0800, leqi wrote:
> Add QCS615 compatible string to the sc8280xp sound card driver
> to enable sound card support on QCS615-based boards.
> 
> Signed-off-by: leqi <le.qi@oss.qualcomm.com>
> ---
>  sound/soc/qcom/sc8280xp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 3cf71cb1766e..1780397e68d4 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -192,6 +192,7 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id snd_sc8280xp_dt_match[] = {
>  	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
> +	{.compatible = "qcom,qcs615-sndcard", "qcs615"},

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

>  	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
>  	{.compatible = "qcom,qcs8275-sndcard", "qcs8300"},
>  	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

