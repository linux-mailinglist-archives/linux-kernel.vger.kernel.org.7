Return-Path: <linux-kernel+bounces-766474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6119B246F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E63C167E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470532F3C2E;
	Wed, 13 Aug 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RRVX5vJ+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2142F3C2B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080092; cv=none; b=DY9qqZvsCa+va+mxgwUhCNaOWJE3FexzTypREwgn/GkZoSw/v0v1GX8SrcavI8++InTTAEh/ZJBXLaJGgy63pTVByyP6ObmMK36f6mVXeNaI8lhNs9l883Qpy4bmHkYqJLr2JkDxGoO5h2WY71wek3TrIT+O5Sa2MB64aaujwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080092; c=relaxed/simple;
	bh=OsF67T9tg31dlx8H+a4WlbXvU1y++zX3+kn0nxjc1eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjgU+jKCC83YLSbFjGLytwtt/EtzM0WG+qEioo1VpO0XrlBu2MTxf3zN34GzZGSrd15SUHvE+lvvQPggLPxsi1hpYK71OsdXlyEtaFQ0v1cAuf6EO6DYNpb8fDIHUS5veBeqgDksVvO7WiCDDFFufysvoNQw2jJ+OrTkaRkvMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RRVX5vJ+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mH5Q001999
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V3s0PLvJMpjYoDhySt4+zfWb5bPPDz2zI2u2zAPEgq4=; b=RRVX5vJ+V1YCOuMP
	oyruepRzotOCuhyBhgCQBRToHZmo5W699iTDOyS1lnQXX7Xe4I4hLmlDOUaqZsz+
	zXcK7y7XPN5YsQbIUbNJaoHVbWtUQ9eXoIyWHhO2n+tRihXPZeD7W+FAltXifDFo
	qDfk3RFxI3/1vehoqkz85Led4if+Scd+p155xFQO6hPrR8Klcy64p3M1V5gum97F
	S3Z6j/otaIRlR8zMwI7cR8hOlbggLmlrOCIN/XHKIx7G3JipgUH1dlGZrDL2aSRi
	QY7o3+uF8iFC1o0QqBauHXMvrlRFZaK+KrtGRy9QkDodea6vx+R49wA9Nl60yXHG
	Z8Edsw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjq70p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:14:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4abc1e8bd11so22298221cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755080089; x=1755684889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3s0PLvJMpjYoDhySt4+zfWb5bPPDz2zI2u2zAPEgq4=;
        b=K0Grcnujb86mHMs1sey4ManDk8WzP7rdUrHCJkNlCCptE49NM7iMOGLhYv1+AIJFEK
         EyVfk0h/XuRsMLiBp7pUh5VdLMoW+Y4Os4ha0p5ge4y9OxUlfrKWie4cm+oFk7gCc/Sa
         azS6ZWMolo0saeZFvlrCbnLFcf+caokY0I2ThdekIfLzyFg5Vi7F0YpC8cIXEhmy9Fmy
         lYqhWv6NmYUIANsijAuXNFOv+sXQPiYCjmvxedPkR5m0CJADV4+uD2Cn+M3wmqQGfLLE
         zkn5zfaWzmhsjNUOlb9iOFw/rlDdK3QlnrEwM9Qa06AAmmApBio3ugULO4AltUsjPiv3
         QNfA==
X-Forwarded-Encrypted: i=1; AJvYcCXD7cHPL1K1lwrzpTE4stYsgpsGbDkgV92jzMyh3daOJu9mj0io++6Ru4/epq/fwNDrIO8ww1l/1ifveb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzaDssTlVm9nD9NxPNkMjZk1hxZiSROCAwI9gyEyPwtPosxjGj
	sTpjRcyy0I1svxPwSdOT4g//8OduwWz8s2N1qX0mJCr/7Saso4SKpuNAsM6PDf9fpTtkTEMYMbh
	fXScr++ditzMtB+/c+4OkwFg7C2J7gq/u4qoHhihce5LxH4mTlpzuec3rCgkL5tvKUEQ=
X-Gm-Gg: ASbGncvJ5YtRShyPAgTCIgUetusL3XklJpBbuR/yNmRRo65rQ7ghK7YzOCXWCVWANLV
	8fR+KhlmOqQSg9+DmR4JkMp18TRrQ9Xocynwxt0rWPo0NAgCfMC18EVqLTjrEsuA3q3Jt/9jMhk
	DKrEOQhekBiyt8A3ViFbfz+h6KQqvA4I45xKOAf2+/35kFtDK/t5ZOF/Tt6k9/1pquSrTrkoeFg
	0CR2bqil2f8y2wubrYdfbZmcMQaGh+xwxPPt5RDf9Se6kAaG+NvO0amALV3YyKzsHd/4DG3PShB
	GD96ybICpmFTppCcv9qgPzA89A19uPcbp7VmoXk91/S3eVgKG59DF/ELqpJhqms/WOnYlcQ7ec0
	2+3ui+rFNUFTXb4RWwg==
X-Received: by 2002:ac8:5981:0:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b0fc6ee4d9mr12739341cf.6.1755080088889;
        Wed, 13 Aug 2025 03:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSQ3fe3ZlGQb36R1gfEPkHT1EiLBXa9LUWcbhpTmHxS0wWwUshYGIF3TJUMp3lqGbEvv9K/A==
X-Received: by 2002:ac8:5981:0:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b0fc6ee4d9mr12739011cf.6.1755080088085;
        Wed, 13 Aug 2025 03:14:48 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbdb4sm21449584a12.52.2025.08.13.03.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:14:47 -0700 (PDT)
Message-ID: <04b1a85f-ded8-4e0e-9e6b-c415ce2bd67f@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 12:14:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] pinctrl: qcom: Add glymur pinctrl driver
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rajendra.nayak@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813065533.3959018-1-pankaj.patil@oss.qualcomm.com>
 <20250813065533.3959018-3-pankaj.patil@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250813065533.3959018-3-pankaj.patil@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX12bFh/41kTB6
 9WFoEsYGFPIFYG6LHhtJErq/A6Z3OdY0NkIAeImKBszAG0CISUBgpiWPAkISOCKXLIvhAMTbXOy
 D2yWwOI8kpG9D9GvLu2BG9N+RkMtErXrOjfOU97bDoa9wn0ZzlFLZdSIgH/dCxXWa5TyUUhowLd
 xcLp0H+Fx9C28rsRq/W7hxz5+0+1J6xgVzS5ODTs0K15g4EjAWx7YhvIJ+6n0UhaJUFv26rjiXa
 m0A5Fj0P5yX6OV7AwYtohuJGRS8XQHmVpZ4TDWAuR5f5k3rgeUtqnl8oFRHo5NDbx0i9qhAJkt8
 3rcbgwt9fo4P7B5AOFoDx+wacdBLm9cKkG8/OSPQKdKU5q6yK41zsfQhnwyhbfKHx1L8z/hwv2j
 nqWyo9uK
X-Proofpoint-GUID: vFCdN6bqk4AqO-9lJ9FKED2ECPFl27lP
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689c6599 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=dckrMdBEC3L-f0dnXJIA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: vFCdN6bqk4AqO-9lJ9FKED2ECPFl27lP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On 8/13/25 8:55 AM, Pankaj Patil wrote:
> Add TLMM pinctrl driver to support pin configuration with pinctrl
> framework for Glymur SoC.
> 
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

