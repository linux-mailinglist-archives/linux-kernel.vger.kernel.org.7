Return-Path: <linux-kernel+bounces-800942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D440FB43DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A3D7A7982
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F7303C87;
	Thu,  4 Sep 2025 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HvZD2U9R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B172D8771
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994612; cv=none; b=EVNRiB97rInFOphX0lPJ5eG47/R+lL4fI4AdQ6yZJzU54qtiERqx3f97ETWYWQrHOXGeKFi7sq0i3QrzkBJ6Hu4l+TpzNWvRLYagYDmzja+4HsLCmc/J4ptFe+yGaNUw6i8xvEPjEaJQahXoylaStyf284rKTANGrGUR78dA6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994612; c=relaxed/simple;
	bh=ArO34LFWAHT6cgbIIgrLmpPjzc7jkLJhhCwhm9njkJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYQRZ0oBdx64ZTagJPBQhUQqun66CR8HjBW949arCMQcz3ZT7TMlAuBAsebpl18mM7X1wAMCIdXv8b6deNTlC9rINykW6pgJWQpr3sZ/4Vk6GQ3zIam4IkKBdsYap+FvMf7frnENukYmRrvKKqkzjI0I2wS2ExFTYD550SIkzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HvZD2U9R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XHar022433
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 14:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YWpJrvw9vwWJVOBOCwWHiQEXh4D7P2GkFtskOHhXN7Y=; b=HvZD2U9R+UWFBATU
	91D05jhpzqp6KNdXE7VUfdWfkq4yof3ZGyKHqzdB0+LNdIQiaIUn0Hel4LsbAc8X
	wzH5F5WZFsmmB8W7sCXmF+GIpiJetOBAsigKfR44f6Ps5XN8d8DOjw3mqX5vqXd+
	IWlCXfrhw4+15tMhAVRmOhCdCoFjGgLyCXnPY2YseUL73dbEZNI9oyLQu51UX4pS
	8XfI5pNBsqMp2vym9bISUg2YH9AMmk/ZTWvOmrh9YqtA3LMb9BiEws8fsIGcoyyj
	dTKdWI5DHaGx5PYXjxAS8gBVcatA/18h+Y07O69Scy2mxFL9dHiDMKlYhK8XEkEA
	qGWCkA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk97hx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:03:30 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-52dd4f1374dso55090137.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756994609; x=1757599409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWpJrvw9vwWJVOBOCwWHiQEXh4D7P2GkFtskOHhXN7Y=;
        b=fpG1UQIYrGoEdMddaKWWydQ8Knx9KpGHIuujifxfJZfk0TQllbw3mjR+DkT6z5G0kl
         Un4DvIAaoOzWo4p6R98Y6GNgH5gbKqc9sUhdYVCQPPd05zQWsc494pIX7K4j5A7fl4gT
         mO9oLajNu0D97aePCgXreOjyOjkDQoHv7PmEQ8o+or1WsePlN/Zarj8fAN9msDzOIIiV
         3M7LgRKtVW50GY7TepSma5IUu5l9aT/pB4THpUpp6JjhYySQ9AH5hPoHmA7oVShXnArn
         0wv9IornWpMePJDR2xQggYFAIC/qv5gAJB67Ilu8h3Hf4odKlI8YfhXtDyPxxSYtxEB2
         fOPA==
X-Forwarded-Encrypted: i=1; AJvYcCVSK0UdywOkQIEmbL+zSfEQ3gyGczej5HicVEC1fmYCzanqEMoO8ygMNnh8wHw+uu7Xb+/R8Ro6c3YSjfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwQEC7Etnlxl6xGTB3Q8yLYTGsPYimRzmZCxL0z+/VE10KAJk
	y3AVP3vus4SH5X43fL6b3odNFjtmxQClZREgPNuptgw8TmW9Ke/rXAsdALB/WcpYRUWd6Z4eGNU
	b6lht/QioiLhmEWhuC/MCzl/ceBsEBpHhsUtbCD9K0/q0I89Sc5qHx/is6LDm4JdfC/8=
X-Gm-Gg: ASbGncsx84V96kOkCopcBiAtlAwxr3BycuahSbSq8QsSMyfyFfi7BBcYKA0uPScu/no
	8DRDBoTwNPrM/Q7uYm6L4plb7LzDAYqzwo0wcNpa1SZHen/0cQZz0AcqGqkIbxuRH6JKGqogaVk
	5jPSi41GFPN44CEAb91Hk+rMjjpngZtnQNtGWjuV64HtGXHyz9++0rYfEn/7FVRI1459NkZA5UI
	a0FLfrD6mOQZury75MlxSDrCFcqJQoatzgAIySByqB8L0Ri9cmfqaIfJL3paW2OZkgNRABK1aj3
	Nx25MceRc/wRhbvIJAVlL8muVEr6e+5ZN7dZsoIy6fUJB6FG07IZwaR+7tuOgb3lmfskTWPmWKH
	ODnxD4mLpNZtXD4C7rqWFRA==
X-Received: by 2002:a05:6122:530d:10b0:545:eb6c:c6cd with SMTP id 71dfb90a1353d-545eb6ccd07mr149557e0c.0.1756994608506;
        Thu, 04 Sep 2025 07:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEemEW1KVZ+XfsmWOhxU5sZGSGNKVct6j7eGnjkrqmieGlIosDSRswoXL29fuGAJkdSjSxbYg==
X-Received: by 2002:a05:6122:530d:10b0:545:eb6c:c6cd with SMTP id 71dfb90a1353d-545eb6ccd07mr149338e0c.0.1756994605943;
        Thu, 04 Sep 2025 07:03:25 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62069b79e1asm848778a12.26.2025.09.04.07.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:03:24 -0700 (PDT)
Message-ID: <2c5d97b4-762a-4bbc-b85e-53bc59aaa4c9@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:03:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-enchilada: Add notification LED
To: David Heidelberg <david@ixit.cz>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Antonio Rische <nt8r@protonmail.com>
References: <20250904-enchilada-led-v1-1-dcf936ea7795@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-enchilada-led-v1-1-dcf936ea7795@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xidQcl2_bIEMP_dNaS10YopWBVcDvbSc
X-Proofpoint-ORIG-GUID: xidQcl2_bIEMP_dNaS10YopWBVcDvbSc
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b99c32 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8
 a=sMes0nJH1TucWEBAg2MA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX4BKCchtQErF3
 fSPtnCtjr2BPTlB4h9PP3/qGfCtucdbD3ktNdMoSTlt7i7CHYCXCXx+pRJP2dPPd6TWI5OPZEh+
 nwYX3yKpesGw9PrcTmbXb+jOwKHk+A894BSX8ou9tdS8UZIbR2+SBtblXZ1eRABUi4GfNWLzzfs
 gDJATz3cX/vP4j6/JQ63d3RYDs4+4y5Dqc6wk39+Tu7Wht2PxodndlYPDJkqtgthbDRAtAGoGpm
 qpVkM90VEoKZSBZyFkxSP/HC20nrPtcVL0kD6I+UzaVqnFV2M+V/scxdUwzA2yn03otLfyntB3x
 TJzHvi3jzBDgulCO9a0wTqIdErqgYgFokouKEzV4rsTvsCHAYKFDQY69fngKzGjXkjtJRMKnKzp
 a0Y0xP56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/4/25 3:54 PM, David Heidelberg wrote:
> From: Antonio Rische <nt8r@protonmail.com>
> 
> Add the notification LED for the device.
> The R/G/B channels are controlled by the PMI8998 LPG.
> 
> Signed-off-by: Antonio Rische <nt8r@protonmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

