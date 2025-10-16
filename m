Return-Path: <linux-kernel+bounces-856422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 903CFBE4218
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE795544AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3CB345722;
	Thu, 16 Oct 2025 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CA8PzSRj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48741339B30
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627300; cv=none; b=mrTSE0p6AEZatSo3fBPMgyEuqKhyM6/OUaSXxKmwV7PXJVCv2nhozuSoLlxCm58RvhK5O/fCUN5KhThT8SKtJ3CaPMBEIX2i+T5HZV72+voiOoUvfM7Xteu8bK8YDDIW2w5NRXdZxECBt7EwDLZD2KD6OcpCc4JYohcW+xhvhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627300; c=relaxed/simple;
	bh=G99ZPbE0qrXEWxpI9cnRms8DfqdX68C4eTHKs/UcMD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYIyb0UI+nMr+r/VQ4N3D48achi0aymcsDohuiWg2xdwJ41f2CJ2ZqVs90vvUqx88ovThk1ASkRrsmqcjrjv9ZvIRm4o2WKhVQ12PtjRym3o7wxxzLnmWzuVRGtWWLuRQlM1RhJxJH8S0XfPj+0y20LOCvQt6+ltio0E/iBwotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CA8PzSRj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDLo53023830
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FXyMiKp6Pe+UsoaL5xjvf5aBb6HRAlCgHcOZD/wdeOM=; b=CA8PzSRj4MsKetOp
	iFUrF9KVRsp8LxbZKGn3ZZL5VBCWuTNtrZV5mlGAkOMeQcYDnQXpJew3FjH+fQF8
	FYMKGerxmrMflb9ZnKj7k8gO+basMKX5D04Z/JFXEWJkTKgxrk5kXI3P9U6fktiz
	BMoOqgYkgiKcDIzU3E1tbeCrc8O6+jYCQ5ko4fz2rdQGnt+im4UkTDfIjAjWd7n/
	ybC1e2jaRRbhFitr2xA3vsOc12f3gXRObrkGuBK9IeHiFBuPboM6+6anVyOBwPwd
	CEMkeyVHfYHB+sjfO+nz6DoD7tQY2f7lhRqhNQ1zdZj8QIhNhG2sFN0F3N+Uagmv
	1CMR8w==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49u1h0rauh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:08:18 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-54a7955dc59so493160e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627297; x=1761232097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXyMiKp6Pe+UsoaL5xjvf5aBb6HRAlCgHcOZD/wdeOM=;
        b=pFwUiO0DBfUUaPGPVBzpr/ngVhBxQBnJrGSE3PfNHJUiE6bo9joY3IB/ralh2Jqnb6
         7mFCwUu4dM8IZyeWd20Z+fTMQGk2oFibE/Vz/tZTrF5gWAME9nF50TzW32Hav5j5Eu+8
         2lc+KvCNHPJIxqJHMDBaaftobB7XNBHEP1dTdR3vYX0ztQKISKqKRgRq3dQ0xBSinLU1
         FBZ06411CEEMe0/LNwJ/nxlnP33PUGkvRIx+ACixd8q4GhBs9bRQ3J7Hs36sgSp8Kt0l
         xJV9I/g9FhklBORRO1dlcQVrGg8KWQJqkBoCy9WOq7jhC/tNhP00Lr39ZSKFqSC1ed7+
         nruQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2L6rmvRunwijdNIkABnvpuPnPoOn6BCdQk+VDTX3+ZNDK/ezpB7QVT8/DFg8E5uW9/FHqquKpxRoknzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyedHBc0uNxBP8uw+urfZAUfssA1sQ6SPgKlDsk5O5XJCmlwXQq
	PcpVcoxyvppIg6/KcLt1ypxBitK2H2KLyBfPfFhLxEGMcWmvFVYzFwY/CYnxDg5yT/seXTH60Vv
	AyKcORFEsaaxsCl2jvtMc/WFyuViL/i3kL2KXfYkz/cA8izHYnXuiy4rqiM6r9ZNT+n4=
X-Gm-Gg: ASbGncvdYlMRuQjG07Yb5AdlJnDKnwrKjsZtAsXoz69VBc/+0EBwAuZiyYj+4qM2BNn
	AiDTEfuemKc0F9aE9sN1i4rYW7uTKBcEOuV8FUbleDvVysJnO2tF/2r19xGQ97QsOwIt0HWNj/v
	Yh0fOhw0maI2PiXHJ8E8aiGmH8Guv/2NSu+ic/O1tTzpZOdQHeAcWeM4xK81KyUe8ba3OKX07P/
	lnHbjSTZ43JeiE9jfqRJNyP6Z6PD+XKj68rwmapHD8+abjHStPhmteOiSZf29wdAYiOAFFO8oqQ
	7JiH1VeAjJLWhwngHGa7fk4pzT4NydaNf58UXYT4M8fV7aqTw62E1+9zOQB9rcDAmTFSGEhevBD
	efJo24NAcP62P0ODt9shAi3xUug==
X-Received: by 2002:a05:6123:2e6:b0:554:b927:dd96 with SMTP id 71dfb90a1353d-5564eca468fmr356752e0c.0.1760627297061;
        Thu, 16 Oct 2025 08:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPWieiWFaaKyulx2rok1ilSzb8mCz8kPrQASfSURizbtH1xNaE0Q4mMvEcDFXidP9X2/I5HQ==
X-Received: by 2002:a05:6123:2e6:b0:554:b927:dd96 with SMTP id 71dfb90a1353d-5564eca468fmr356696e0c.0.1760627296637;
        Thu, 16 Oct 2025 08:08:16 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42704141cc3sm1877857f8f.9.2025.10.16.08.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 08:08:16 -0700 (PDT)
Message-ID: <b0d9cec5-1162-476b-8438-8239e1458927@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 16:08:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: sound: qcom,sm8250: add QRB2210 and RB1
 soundcards
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
 <20251007-qrb2210-qcm2290-sndcard-v1-1-8222141bca79@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251007-qrb2210-qcm2290-sndcard-v1-1-8222141bca79@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=esXSD4pX c=1 sm=1 tr=0 ts=68f10a62 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=7YHmJdMxG_e0k3IJONEA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BzbtPCiHVhvtygqZlLnnyaTS3471Y1Au
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5OSBTYWx0ZWRfX/MMKJ408WMbZ
 OmgES8F+za8S7MxuIY8QX333J3u9xs7KP+rMPHJ+8roYgs5p5EKAf994P0sVDwKsblbFUluPXIE
 eC4Ge2XmnxX7mnCPGtc/fB/m0oVzAXNVyrwTo4KoehXwsS1tXjIc6Nvk98CvDu+pilywXSG1XYb
 vNuDT1bw0XHNOCuYAT+slihn+I5tlAYVZd6oXDdbfT91/IdrzWqhtTFzb5zQpScw7rchyuBBhci
 lsjuGWBLit2q4lPeQ/6dwcfB6Ip0dMflQPnukz719np6IObMin9EC1QdWMWE0YjVrdoBCL79qch
 8dvSVcSmDrk90/O3IDeyJivpixfkvguNmyhqonW9WGReyJNworhrl4iWg/WNf5MSqkUdeB3uh5O
 RBXU8OC+bRH1Z1VDZzwnp/ZV6t3acQ==
X-Proofpoint-ORIG-GUID: BzbtPCiHVhvtygqZlLnnyaTS3471Y1Au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510160099



On 10/7/25 2:26 AM, Alexey Klimov wrote:
> Add soundcard compatible for QRB2210 (QCM2290) platforms.
> While at this, also add QRB2210 RB1 entry which is set to be
> compatible with QRB2210 soundcard.
> 
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> index 8ac91625dce5ccba5c5f31748c36296b12fac1a6..c29e59d0e8043fe2617b969be216525b493458c4 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> @@ -21,6 +21,10 @@ properties:
>                - lenovo,yoga-c630-sndcard
>                - qcom,db845c-sndcard
>            - const: qcom,sdm845-sndcard
> +      - items:
> +          - enum:
> +              - qcom,qrb2210-rb1-sndcard
I don't think you need rb1 specific compatible here, unless there this
is totally different to what the base compatible can provide.

--srini> +          - const: qcom,qrb2210-sndcard
>        - items:
>            - enum:
>                - qcom,sm8550-sndcard
> @@ -37,6 +41,7 @@ properties:
>            - qcom,qcs8275-sndcard
>            - qcom,qcs9075-sndcard
>            - qcom,qcs9100-sndcard
> +          - qcom,qrb2210-sndcard
>            - qcom,qrb4210-rb2-sndcard
>            - qcom,qrb5165-rb5-sndcard
>            - qcom,sc7180-qdsp6-sndcard
> 


