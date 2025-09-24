Return-Path: <linux-kernel+bounces-830228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD506B991DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768292A3854
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3462D8DB9;
	Wed, 24 Sep 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jai9rjcH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E92D8785
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705964; cv=none; b=sBglO+DJVnh4sWA6hsLwST9zDWggRtmQbdoaTjHdOEbGsoyBVzSDL1gTKcqLk6zmV5vrVNFiA0oL1FrjOGRKO0FVGnWmem5F8v2Z7q4+foNK7MSAw6YWasu6MODcBmrW2YhMenXXvQes8sKP0XUgnlzjnw58kxL0ki5oauIxn3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705964; c=relaxed/simple;
	bh=kGACjza4kLFIuoVjadheB4VrqhuF9hGSAnViyIKI53o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQH/vIUFTVCBfHJtXRyKE9lHNkRBBoasqiMJ62+D7wS2dCHIrTKW4W/LEKEWxoP8KdkIWh+zNrkbNxxGTY8Zj7ywjesTj4redN8OBem9l0aB97Q2ta1B3nhYswXl8lAM+w0V/G+OUwU6Ip37jpvYT+yb0GowbPLWniQBpJUfWco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jai9rjcH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iIJP019934
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/iVQMdHaKcnbaZ6S3hoE/B2b2HZTKVXu/iQm4DA6Owg=; b=Jai9rjcHmdFpIyPn
	GhFb/ev+IBXZBXDdtGjtVRQErQQOqFxcHrsAiQqchlgk5reYMWNOMQk0bCc9b264
	a05jyel7Ju6AmLesjrIkUcGS01cKPUtpdEppUa2vEQkI3OwaJbrAAyVHahI/h3Ym
	xdgkzuQ5EOITT12S1J1OJ2f55cIpwBehHSy88/TUd+J6GQtAnY5Iig3JAWCL7eUy
	MC9j4CakhgXYUeOdojpdRthM3lHzsfKZBP0uemm+tvmLwDaP6FcwTaLjfxMRFTp0
	Zdawoyf8aDDILJSmnEIJImils6X8kMGu9Cf6nULT22uVKTbRVjqcw78rNR2obYqt
	DWIYIw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdvxqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:26:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4cd5464cb0bso7180041cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705960; x=1759310760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iVQMdHaKcnbaZ6S3hoE/B2b2HZTKVXu/iQm4DA6Owg=;
        b=cKijcu8TeXBYBDOGnB1IootTx9ydnD8YuBfzyVWAG34e9d3Qfq7lhyb2AqazmcPitS
         EH5BTOIia83sYM1vym23wSgQa6UURdA97JhrUC3mTHPGP/jPFFXzKySU6JRs4xTHS6w/
         S10JdzbEpc/BjQdpEYNZbiQl9Li/ohfPqeFhDnErlCZIHawnGGNtYA07azXfM17N7gDi
         KBVCcA54DBPoco5u3yI/i1i5wNumOtw42UMgl/YmtWJJ+7abVtPn+ac6yQQG7ebgEkNq
         wQF0vBrbYtl18FhXNhVSMM+LYZVQoPZhbG0Xb6fEj6Sw1BEzbP7/sVl2RsWxqXMsAUpR
         jeBg==
X-Forwarded-Encrypted: i=1; AJvYcCUlRu2Wgd6+3TdnPcQx50JfrSsg1/X4dUfGdZQa5uYZiMlfMBweMrnqiWp4YizHYx4VC6yhKUmCyhKqFrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtM8JhoK5//X6Su8w4LkEoijtbjsKENFX0lFGoqSpzz/hbulRc
	s4pf5bfzjGF37OLDEQkhUJ1cCT36EWT7RM+DCV1EwuE9ZWRMJ6Sdk0TFnqA3P64+FvygrbpQpz1
	UTDdq4EKM4rlRt0rGJR2MKCz2LCmNyXirNMyUeHh/wBeNgieIIRBAM9RydgUbLvW7c64=
X-Gm-Gg: ASbGnctngLk/4xpWwuFdx3p2tiDAx9QrO47GZq2YFdHCt95IRkxJzfT+G46jHS8Juju
	4Y1J2TMd9Uogb219nXO86tQsLipl2ZlebwCCuMpMa9l3y9kN0dRTws+Nxee49F+XE/7M+oyu1tq
	ZSH4zhFCVb2gD/lHSXoUPw7QVZgUWcm27C86OFrZ/07ze6LLYsbeh001jDyFFJeQWT72quhyb3D
	IL4fAKpxZ/wYUMidjVatMu2Q6M705+gU9wvDA2prHr6yVTCoEqkjLqbfgOYuWX1m6DITPLYevRV
	6LnjlEZQ0UnTRPjHnOrunqOwI8KOqaykJFK175Z3+4pXCFtlPvbPnqsm8q2tOYwxTg7qf3nUxVN
	tRK8sCmFe60aFPKIOftdz8w==
X-Received: by 2002:ac8:7dd0:0:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4d36feee39fmr44886631cf.8.1758705959653;
        Wed, 24 Sep 2025 02:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9jltynsPceOPKBs258SdQflImCClEP7oCDtLUeJd2HIiXbb4/Fq4DcND9VXplQIu2TahAkQ==
X-Received: by 2002:ac8:7dd0:0:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4d36feee39fmr44886531cf.8.1758705959191;
        Wed, 24 Sep 2025 02:25:59 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm786252166b.111.2025.09.24.02.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 02:25:58 -0700 (PDT)
Message-ID: <9455818f-3f6f-4985-8389-fccc7852b569@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 11:25:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc: Update the halt check flags for pipe
 clocks
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250924-glymur_gcc_usb_fixes-v1-1-a90568723e64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-glymur_gcc_usb_fixes-v1-1-a90568723e64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4sfRs4pA7fsO92CobGol4nwTt6pizjMb
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d3b929 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=yrTspkcuTgY8Q9LkLrEA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 4sfRs4pA7fsO92CobGol4nwTt6pizjMb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX48IhDF86tGHv
 lPFuaSe08yXUnebPH2dMFXIN9PrmJVnCMewe/D2bZleyqpZxR0wguvVef7CTNroRE+CWS1yMTks
 m36gLJYYZg8sPyMkap8g3Q7ssC4WysVrcqblG4qCoF0IebqXveNri1OTIOmGWBfxYK6ZROqr9gs
 hrpF9A1bp52SksRaKq+uLzuhb5PNhzrSIU7H4No4r6Lm5LRM+yasZSKDIV+V6RZQtktjZeK3luC
 /Se9d+5GAmfRKttJaycOuXLqGrBOVYXcNdWajsUZU75CSoWIZIBdyRyvfe9EcssiOApX0fBrAXY
 nxFwrqfEUQzjfjfSckLbYZOXRa6qNP0szpJu1i8JGXWvzw2UfpdMC4A8P21PPqUWxSYFT5aAAvL
 f14JouJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/24/25 9:17 AM, Taniya Das wrote:
> The pipe clocks for PCIE and USB are externally sourced and the should
> not be polled by the clock driver. Update the halt_check flags to 'SKIP'
> to disable polling for these clocks.

"This helps avoid xxx is stuck at 'off' warnings, which are benign,
since all consumers of the PHYs must initialize a given instance before
performing any operations"

> 
> Fixes: efe504300a17 ("clk: qcom: gcc: Add support for Global Clock Controller")
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

The patch subject must say 'gcc-glymur: instead of just 'gcc:'

Otherwise LGTM, I've been carrying a similar fix on x1e, as it
(obviously) turned out to be necessary for the usecase

With that fixed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

