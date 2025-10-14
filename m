Return-Path: <linux-kernel+bounces-852103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E2BD82D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D5A422E43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97B1EEA5F;
	Tue, 14 Oct 2025 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m9OR36hs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A31A5B9D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430426; cv=none; b=ue0qELGZubNp+ukZktD8Oc3OZqJJ/9a1dnaboqJl7ndlDmFABqaAlEIN9Cd6ImPMIlJOh0UNCaQupEzqOxAJoUAAnbxBY2RMA6BqCBa6OAvd3THcpc0eolio4N/YwfoY/X1cg8utg8X7Cx1TA986GPyF+DtBaFaxGRWmg/0AmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430426; c=relaxed/simple;
	bh=zhENmhH3oy7RShG9QBZrzQNtTLxA/XmZK49J+bjpgTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FN3cUeu+6q8/Ff3Qj78snwE7Sfz/pG23b3O8UCPY2cah6f3Ai+4RjL9CBI3bqa/N07+6bWm3uCZM4LBXG1BHnOZY34SLfSWNQtkGfefN2sGauHlCmLoTjwF/a/+Rkv17OB7T583vx0rOmSQlFlaWntnJEgYdaRcJof6JSjp7hxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m9OR36hs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87K2v020009
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qa3kMVrA3jwHDRk9FAb36hjIZ7uv03YTpTJqYiDTaS0=; b=m9OR36hsRo1U6nAY
	vkOtdwzv+w1hhFUAEgBXdYmAJgzVQeOhvFysq3qlDmLY1gQI+egzWeU8VJtOsyjr
	4bTj7BI+BUu29ToFyb9ErTg97W0me9hBBjlXpsGIT0yBFFa1L8gYDY2r9hHL/FTw
	kO/9IRMWwHSbZul1tUBoo6BZpw5mHmxmTl7HB2tD0Bh6tSWZJfAQLxXSl7XNOCC+
	z4SQXMR8jrB1pHUhMW5apbGCh0p7pWQV44033i3bO3r+n8oUSepsDjCr/TDCD6+0
	srDDxbNE07oIOHj6J06HMOIKmn3Twa1B7CDCDpgsOugjD+Kux4DJMUlIs4Yc3m93
	gxRqjg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0bype9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:27:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55443b4114so6799293a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430424; x=1761035224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qa3kMVrA3jwHDRk9FAb36hjIZ7uv03YTpTJqYiDTaS0=;
        b=Mj0azBt7ycXgAt7hoOBaKqBFtXn+GOoF4nXtTrdnxra6w2C/vhXYY5N2B7OksRW2w3
         mXFZPocPEOBlRMvS6hLK6VoOlp8+s+Y1GO30cGmw5Pm7yOEMdiktI1pGEEJvUtvO3PUM
         5XQIzPhWHMg4trlmQWBy7pTd5tvlO7NXdEK/9uUObm3B15z+8+3OoTi8Fvt0jBFh6M1l
         S9e3g10190JZK9lEa+MJ4sOdNMa66b8911Xv+BepnCiWUUXcJYcxASFkn94x1Khtz+nB
         rWwGGwAWB/3RgQ7ZzuDLjMq+RPXDSXrBvzR/EFPCeQ/an1SleV6eb75BCrkXsycvbI97
         7F3A==
X-Forwarded-Encrypted: i=1; AJvYcCXj8/pKCqPRRra9ZpOVZWkvQFuTvKS5zbFQHj89wjAiYLtP9piQTpuv5PRm6UCD0RdxT67PkLec1xe/Ilo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuM50IjYP5VRwzGoSrceWHSrJ0G/gy0R5pMUvUO0nFqYZkJeiP
	wHQanrhYGodT61Xp+oPA8Cjbbm82EXY3Tp9JrzZUeCPjeAvmMvIfZHFxFt4UzwPAInOZDR2yo74
	DDeghMidORJh0kFig5/v3hOyqZ9Q+sEWU2C4wSfH8RlzVPh/xR3VoDBhtGaXRuZlv4xQ=
X-Gm-Gg: ASbGncsML+300X3AimlAT3ZEqSefjnG1xqnkWyYCH3dpOuSoz/KHHNk9wyLBGzCa1pP
	Ej3EBgouuot3URmstGP7QxT5A4ikJ8lEK6jxnM0db7IVtU+D6KIMusbnBoPsCrPeAs8WfnK1gP6
	8HThQtKZ7K9UFbxLKqme4/k7yzgQPENBUden+9cLDlkcywJ+wJA0PWyVi56sWeGvYKZaZIO+eXZ
	Sh3DhM/L5xrXoLfMWYOEVRL4kAUxmRuMXKBZpfQexMvOMd+i9n38IoYU5qaJ/6+oqzQ82Hs2Ofk
	T8ItdrvkS3G3TajazTpD9BizKquQXK2gNY14SEfv74b2PuGcWp4Bco5fLOG44VFGAfZIjODY
X-Received: by 2002:a17:903:1a06:b0:283:c950:a783 with SMTP id d9443c01a7336-2902741e42amr304903155ad.56.1760430423982;
        Tue, 14 Oct 2025 01:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4KymEWCSSL1ak5fq4W5DDDtZLlkwKkmzNqt1us62ZLuLQRemec+bHRpZJs5pwhQbNJYVfgQ==
X-Received: by 2002:a17:903:1a06:b0:283:c950:a783 with SMTP id d9443c01a7336-2902741e42amr304902915ad.56.1760430423564;
        Tue, 14 Oct 2025 01:27:03 -0700 (PDT)
Received: from [10.206.101.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08d0fsm157151475ad.63.2025.10.14.01.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:27:02 -0700 (PDT)
Message-ID: <e68e3ef4-548b-f487-2f6c-6976b56ff4f6@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 13:56:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/8] media: iris: turn platform caps into constants
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com>
 <20251013-iris-sc7280-v3-1-f3bceb77a250@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251013-iris-sc7280-v3-1-f3bceb77a250@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: F69o1-Nnale6cR8wp9lxGlj7CncInRh_
X-Proofpoint-ORIG-GUID: F69o1-Nnale6cR8wp9lxGlj7CncInRh_
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ee0958 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5Kv_vQZlazJxXpBqwIAA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX++kEPjXkgnIp
 0tjgdaaZJXzwyPuRIdwnHC8l/jdFfL+EbZevkXlzOChPzZhRJLzJWghvNLD48miATgipQIJ/Zm3
 3KSOPTnKRh70TOqTlaY1FazfX57XesN5zNf3SmGKzvXOiGkJlvvs6QpMQMHGyER2FJDe6YGFCqa
 vWlWU5nWlu4BXv1h16lS4uQqn3H8DnBOW7A4aryHKPeUATBkqLvI6JX68LoajipaoaYcp3FzAFr
 dc1W83adFqUjefS9aL3b3G5bKKyMHjdk0ZWV1P2MCjOIjZx562djqts2d1tVVhNrWdhRcc0vP5D
 T2y/r5wWx5Dn0rujyTxMS8TQb1EJ4OKPBrfLn4VC2HsvsFHI5uRpYuAuXdlOwTZIXDSHNLfWjZL
 WuLr9IlkBi2MCsNNITW8aYAlXudn5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022



On 10/13/2025 7:38 AM, Dmitry Baryshkov wrote:
> Make all struct platform_inst_fw_cap instances constant, they are not
> modified at runtime.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_ctrls.c            | 2 +-
>  drivers/media/platform/qcom/iris/iris_platform_common.h  | 4 ++--
>  drivers/media/platform/qcom/iris/iris_platform_gen2.c    | 4 ++--
>  drivers/media/platform/qcom/iris/iris_platform_qcs8300.h | 4 ++--
>  drivers/media/platform/qcom/iris/iris_platform_sm8250.c  | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)


Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

