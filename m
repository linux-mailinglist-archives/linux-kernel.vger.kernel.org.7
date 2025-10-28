Return-Path: <linux-kernel+bounces-873651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6BC1457E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A1C7351E89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979CE3081D0;
	Tue, 28 Oct 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DlOv7JC6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B64306D48
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650775; cv=none; b=od+vJlVZ6nozsp/Pz67o5GGf7BvR5LtytdtT4v31Ykouidzp74XSekDjRxfAAvxUv8w1bMiUKrUrQSsFN9rNODf2FBSi9dpbFWw9XBeKgN3Gm7QlKeYIqJl0xYG6LgbqUFrf1tQtoIhT7jtd1H4uu1e1IhqjaHpctYwvUMQz4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650775; c=relaxed/simple;
	bh=TMHdg4xssurgAGzJGTped+prFtK4pPp0nlsqYxz942Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=al29Cdy7S9mpw14bd2ST73lNjmLVq4mESNMoqZtNbv+QKWVy2d54IAwkNFapBSygH/HBg18p9MGToeE+cf7u2mxnEOJuUrog+fVcPwDRJ1FTAdJ3HLvb8oVvgSZiE4n1RYxd3wYm9slRON+P7OK7rkQW9WR+xhz1TmrLQzE3VP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DlOv7JC6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7dXMh1032911
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8B2Vdprj+TMVjEwrjCneBkNNr8hykOdrPlP1cgMXsQs=; b=DlOv7JC6y5hXJISs
	txBrjwaYdnqVlP5PfmTFB/IJpRmqde81dl57ylJQAhh0Q8JxE0AGS6gmXmpt+/Gs
	sbTJgpdbZzTX48oMcTJIKa79ufnsfAIrRdTJJi2iDSiqCOkZiDxwhGhs0UIos5l6
	0hiOH2sv12dcgIXfdkcO6K9lXPdelZioJ5V5q/j+4e0jN816udFNBAIAhtb5GvBn
	edTzIw12rTqDBjTmU0z0YoAYJW2CB4GlHOH1SWkyH4FMNsNnHRxD/lsc3HqaVLj6
	k2nnMI2AYWQV3+3FYvBTsfkyrk58VT/rgb5J/DGbbbR5d5NFNq5FU/QIojvtb5sS
	h10Xog==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2smurpj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:26:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso13655656a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761650772; x=1762255572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8B2Vdprj+TMVjEwrjCneBkNNr8hykOdrPlP1cgMXsQs=;
        b=aamkx8TKQXJDMALiehFF0T3URHNO+yDUyNF8/OdBC1ZHXWan0fCd5yegsOC6v57gT5
         tJTXDzRYIlckYo08hvYT558HjIjT2131caX8YbO48AvcaqhqN+o/wayQX+RrFmVZen00
         8xaz5i5+1j/EWOKQX1wl6dajQ6xL70V7bV2ZFY6LPeZPayDEUMRJCT7Iwnm2h0hCPh2X
         rkgSK8kusyNgvTvqIf9IaTf4AP3EHcaXbf+bseqxMWGea0Qr3Zh9HNLvYoYx3xlyyJtL
         M6EjkNSDpyncW/nZ1eFYSjJOY0OyP+wMGsI2KRkVn60sw5Jk2EcneAt+S5mwQvYTyoCR
         zN2w==
X-Forwarded-Encrypted: i=1; AJvYcCX2SBCblDCNGt3iZCvYeL98JDy+z9/daXudOpAv79q6F08O1gGenbnMf7HaoyRfw9tfNz2FbCp9vY2KqBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogPA1aSDBtr82J2g61IJCKuMih+fgSGHLAlOtQZnnpfNe7+ck
	f8EBspEJKvOQfHzq3HA+AjUxJPDDHkiM3hmpO0SILE2vL7EQ06PCM1ES8Q/d9rOarFbJtVH3Q+H
	3JiaULrbD9RcIe9qz8Ypuft0gkfiIqb6j650KV1Kwq+DO/2tAbvDim6+ki8AOjtyq5NxQJ+BH6E
	Y=
X-Gm-Gg: ASbGncsI0u5JaZjoyFekPotyFOp0bLFQY1p6r5Gt9/hVthEATDQvavcP8+38co2qQov
	NSbVB8G5Rihkx24SBP5nEnhyoSvC/c9FnTdvlMCGZH5ygGsMKs8CayfsM/piEM6OQt3bi/bAZJl
	bMcRmOkbLHlgGPsZ5x6iPg24eCc4F4H2JBQLVRFKRMDEemZnmNB7jwVHuRSf9iTpiyhOxTpd8iv
	mPT3keD41zJlQgueWyNa1GgKDD/lJzVKVCfhl95FoO5nShpG9T/tXVHDIwMiiE39utR7Jk5dBoS
	bB9pFnGN57NhjlGNvmkmCCTEhP8usyEbXE3zqLov7ZTOnd0yCNfxdFoD3cdZ/1orC/q3wGyeMzk
	PzzKzX4LECrFz5D5yJ0kXQAK/wQxcEYpX
X-Received: by 2002:a17:90b:5910:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-34027a0246cmr4068029a91.13.1761650772042;
        Tue, 28 Oct 2025 04:26:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3J80E9SZn/8fLf/VbZh1dJliCmOWwxBpWdjHXEwv0oT4A8nyHqgf11gEQ6Qhw4H31wK/7Yw==
X-Received: by 2002:a17:90b:5910:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-34027a0246cmr4067976a91.13.1761650771329;
        Tue, 28 Oct 2025 04:26:11 -0700 (PDT)
Received: from [10.204.100.217] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34028fc5cc5sm1314764a91.0.2025.10.28.04.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:26:10 -0700 (PDT)
Message-ID: <f4c101a6-2baa-dd3a-9931-f777c98c6e5c@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 16:56:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] media: iris: Add support for QC08C format for
 decoder
Content-Language: en-US
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251008-video-iris-ubwc-enable-v2-0-478ba2d96427@oss.qualcomm.com>
 <20251008-video-iris-ubwc-enable-v2-2-478ba2d96427@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251008-video-iris-ubwc-enable-v2-2-478ba2d96427@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BwGWUYG9bznLmPDo6CtkRRKO6I6psTjz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5NiBTYWx0ZWRfX6pefU5itQZZP
 uVWS+NttakPlOGOjHvNnTYf9EHfUIT79uqN973smUl8XtJES2qWnjS2Xru5sAaJvoU0CSqwZjdg
 HjgDBdYneuitNHYkV6ihuY7Wbjb/G69wsmeqgNkZxhD0NoI7tmEuYDjRGFdsL+yd502f4gF1IGY
 ZKEhPx+SOTwCsJRacZKb87ptsY7EvHUmoOpYB6ZQ6++8lQ9J7vUQ+C37/ttISGHFY3HUCvKo2zy
 eHIvSR31cmB4jDDlmpoig1IuQTPm9T2srsshcGwT3JrKnTTyuOyVu/wBgpRnRaXzRxMfOxEg/D/
 mBds8FeKzmClhPNl5ohW3qYz8mv7P9ht6osdFUcpYGb7Wq8peWDrq7KGqOBJFat8qVyTjRMO6eU
 xPzfigR8IeqFgv2V4MGtclBm0BN1RA==
X-Authority-Analysis: v=2.4 cv=IcCKmGqa c=1 sm=1 tr=0 ts=6900a855 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DCFS6Bs2GSZJv8qj3GIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: BwGWUYG9bznLmPDo6CtkRRKO6I6psTjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280096



On 10/8/2025 3:22 PM, Dikshita Agarwal wrote:
> Introduce handling for the QC08C format in the decoder. QC08C format is
> NV12 with UBWC compression. Update format checks and configuration to
> enable decoding of QC08C streams.
> 
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_buffer.c     |  5 +-
>  .../platform/qcom/iris/iris_hfi_gen1_command.c     | 12 +++--
>  .../platform/qcom/iris/iris_hfi_gen2_command.c     |  3 +-
>  drivers/media/platform/qcom/iris/iris_instance.h   |  7 ++-
>  drivers/media/platform/qcom/iris/iris_utils.c      |  3 +-
>  drivers/media/platform/qcom/iris/iris_vdec.c       | 61 ++++++++++++++++++----
>  6 files changed, 72 insertions(+), 19 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

