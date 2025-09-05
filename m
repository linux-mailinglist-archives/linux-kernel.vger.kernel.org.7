Return-Path: <linux-kernel+bounces-802894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93369B4581B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FF73B1580
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4779935083F;
	Fri,  5 Sep 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJrdYtEt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41420322
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076413; cv=none; b=GtEtLDmBdgrr9q06MAp/rz+aTclmAkdOrJNQv+6XD480ASdz2ZoW6j3armojOOKceK0s6dIgbimtPfnOpVliwjJb/baUkCCBFblfWd77mcGDi+htUK2Yq7fvdguTxtAhPMZv75RV7WfIwScpEeAz1mu3zlQaKC567drJ2jXFqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076413; c=relaxed/simple;
	bh=WdzrylW6D5k/Tf3MlXm009pxRMhKTuh6CF95xa9C5lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHfigLz10TLhfx721glpV4TOQHOozwzT71BFTjXn+FMaBJ3XpO8+5diAtuwoogH89K7K3/aILidJpEcZaTLiT07T6LF09w5UPqfs4XlNXVNpKpVpSxfShSx5oKqw5U7YvWpqHKEGKQeKBatojX2xX0zTrpyYvrPqPIZAKuP8x6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJrdYtEt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857EDpU007551
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 12:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1SB7U/jII62BtLsfK3kvMJLkTFF545hw+zs878TRZ3c=; b=YJrdYtEttXAITCPY
	4qYd8AMnHHfAG/l+5jjnZLO8fLK6foNRQnVcZp67dxmdhGF0v7r/eqgP3l46j1sl
	f5jXTVz8d87UBAyagvT9l4cMu2QYvBRN5g2ECHq9bD8vkEfaGxuIJUri/OKQ+q85
	QtWaRis+ADqBGL6KORlALm3UJHwlYbMylZ+hmz5XPCoCFfcEc49ZdUQm8mstRF2W
	4BSiMS/mdr8nHL41mM7cHXDtjDBjwK/G6kiB/rF21aGgz/90cbrKk82TNLYJFmgy
	/9BIYzY6vn1BDyOuw8brJPIbvKsudX6L/f4iZ9XbZtK1P++x1E5r1SlDlIxMhjM9
	5ZH+Rg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura931f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:46:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso8232331cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076410; x=1757681210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SB7U/jII62BtLsfK3kvMJLkTFF545hw+zs878TRZ3c=;
        b=Rf3R7udL+B5qlowlay6X8hfCbwxGBd1nt9eibu76Beg6m0bVUm8Mdgp4m30DuATZos
         l3N87V4acslegncz8VM4Gz/xbG7k5u5XpOS3V3+Heschtzpi6SRegNn6xb9CRs1qYTMp
         LoyfIbRl39U+TjbJfoiNFH3Zho2vezSqWdS+/X2WC29ojNb9/5DFwk0CseftyOmXG2h9
         Pnu/ZCiGSHu4E/b1cd1wfeY14idyZ0Wrd++PKQ1RYqDaDlWHVfla4ui4n1gUXOFkLPIW
         8aLp0sdhjNHeA7qQu2T7hdu03WypzTuOlONDFznpCfTbmmT+kUInQEupPBL3sxr7lNrP
         KCwA==
X-Forwarded-Encrypted: i=1; AJvYcCUTz/DWD+UVduXee7JHXonDoUNZIlpnclHi7Kf8lM9hEZxx4y8GVUptSsBMqNDjwEZAzvaDEP0h8odz3Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkpDF+lXb0R8gozyQKZ1/EPkkYV6CJvsOAtWvY2UJ9oRbulXl
	vg3Ms8L+Qd5qxvCQUGNRCYJDjyNADBUD4Z/oxYs+gPmFdGQYCleWhI6jbBjnemMBk2QyNpqf2CQ
	APf9I7VgtSTDmlSZcsCD4EO6agHlqkvRSDh0B1lnimJpniAWqe4npZXPpMs+UOOvsFl4=
X-Gm-Gg: ASbGncvMmlJsz4hEy5o4gwmeL70X781FtYHuW3IIDSvvcXY2uEJMz02CDWg4CYvMxog
	CWtwR9zcfLdMVyZQUkXhsfEcvCEnT3Xn4OZvVNqnZpbfcQBh8Pr56OJm+cvYK8Lbo8crwyDM7Gm
	oycNaqRkERc8oU2FE3XsjMlRMJNiQA0ksBexeUX4TbEZ2bxW7EM/Qpl/z/nkqNZ5nzkcWVufigM
	oD70xi+tdTnyK83j/rL863ndZcU3YKTOJgwo1kIrB2nV/2x6gP0UhslEjZ8bocUKPkI6XW56y1m
	MsvaWTFgdOTgyo6hyf/5Flky8611BzOuYIRAocl++xhdJ/xLj2z0t2tq7VjMz1Y2x5RNr0hAPU1
	RS6Yxa/nCzcOdcEKVTzaqVA==
X-Received: by 2002:a05:622a:50a:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5e9b60fa0mr18609691cf.7.1757076410281;
        Fri, 05 Sep 2025 05:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED88BDkAu3hHD2gZnrUFPzTysohw+/x37Lmb3zruLYrQfgSkQsU1HdrPUH85++Pzq/cKzFMg==
X-Received: by 2002:a05:622a:50a:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5e9b60fa0mr18609281cf.7.1757076409449;
        Fri, 05 Sep 2025 05:46:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0cb2cb07sm1727752366b.16.2025.09.05.05.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:46:48 -0700 (PDT)
Message-ID: <055bb10a-21a6-4486-ab0f-07be25712aa5@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wbg_hV2rhiWVOlH1u98U4Fe9vXYtIElq
X-Proofpoint-GUID: wbg_hV2rhiWVOlH1u98U4Fe9vXYtIElq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXwnTsuosTpcSr
 qJxu3zXHUdcb5fncoT1qvBGoh22Jw2f6DyF+DMSGXmLlAhy7L5i7fBWwrTnSUKFwd0ajNIIIgzQ
 TmF+wDrUISOQBsaHqglLNcX8lPCuiJMdZbVDRk6dD1n+3WEFE6cQpqEHLhGxVN9r/EMIs+fujqN
 xy/d2vtggFA+x/krajKc13shxZVzs6FPNHKXXdY8c4dy+l7q9FlISyoXSfEZjIE4znHfBLgwqBU
 iC1XMIiFe2tr++s3zVUf+dp78SlTsg4PGyrzs0PMk9okhSVWv0FowqL9slYyou2cps6QIu532n5
 O1vLL7XocVT4WzGrY8nvhzyjBo9j+SoSB44SzeWS+OxfyX+EwAIa9yt7KzV0mhXWIiHPg8dWf5o
 DBAoDUCR
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68badbbb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3WfgD9H-dY_QjJaUS7MA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> Enable remoteproc subsystems for supported DSPs such as Audio DSP,
> Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> firmware.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 17ba3ee99494..1ae3a2a0f6d9 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -425,6 +425,36 @@ &qupv3_id_2 {
>  	status = "okay";
>  };
>  
> +&remoteproc_adsp {
> +	firmware-name = "qcom/sa8775p/adsp.mbn";

Are the firmwares compatible? The current upload seems to have
been made with Ride boards in mind by +Dmitry

Konrad

