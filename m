Return-Path: <linux-kernel+bounces-735941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1912DB0959E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065761C45730
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C748D2248B0;
	Thu, 17 Jul 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gB0BQhVr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275D1F4CB2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752783596; cv=none; b=moZi6GkbieRfstvWQlxRtEAK2LQQ3YNBv/IPIKhMJrPUmjlzT5hMFZSU5EobSYokqUmme6hVYyGvaj0A5D58UjUG5J8NDVjvdmkDoOmj1fkkUwrEy3rwz8TwAXLdKK5n4S+Rses2+mfMDQYnB9GJVsTT8VNouptZeBx01exlEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752783596; c=relaxed/simple;
	bh=uGvCYrukNZZwoSmrot74EXpAei0dSrGbyqHHO4K6ryk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7+nhxi1CAgVe5azNqpWIP/tAfPUWkDy9e/tjCO6aYtoqTMBc6QPSpe9juR+vw4/l1aLrFDHtrQKuqJoXuhAn6CQK7XrKF7rvXMeGSZ2jeiT4i09HFiz9J/z23t8l5hyJzwxeJUWPe4+E6PEDzfAVGsPO7SCmtkUT0t67Om9ans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gB0BQhVr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCtQmL032390
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LCO+Uhw1043gLOruw0DQM2a9wT6gHy7vro34jpT9ZAE=; b=gB0BQhVr53dVptpG
	c5ZEn9wfjTI7bMofr2Uf8QxK9+RhKZzbkxDTFICNDy8yxKhghlWf+qgIiPec94lc
	PMncieHe+1InknedaUo3N37fTUUStJuFhuIQS+G/p6rHlYAjpSxCUnwGXiT9UBeN
	URpNpkXM82HUvkaJEpherRh26SSDKLmDlc0V2rnDp7cUfDwfNRbzX7qB+shsaKw6
	80Vn5C1b6DgkDKlVuRVrI6KVoosNWGkrLlH9cgtlsY4mmhQod9qjqSTVQuCzxQ0y
	6sKxghRgEj6JX+Ttk5crGNd5I/MHHnXuNfSfF3vyOwmBhnAVbvaWqw+CEgjHA7+I
	R7JMzA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug3897kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:19:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2ced79f97so24663285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752783592; x=1753388392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCO+Uhw1043gLOruw0DQM2a9wT6gHy7vro34jpT9ZAE=;
        b=F5DY2LNPphKNi5SPK3PYV9YH1FSf/3NKWjkJ2KNEjqWPb65lnyZltXwLK1WpF0f4g7
         EhoJZ2G8GtWAUWqARToy4Zxt4nk+JsMTiCPFrQsFl8uC3N74eR5I4ArFrgwuN7WQLJoJ
         f3T/IvNLRBUN5t50nVlCP7u/E7p8BfezoG//xJPq5kwcUZhf2DIjFV3MLEFB3S8ooozK
         BjfJi/m0/6jJhLb4FadkX4Nllm+4fI8TNAfgU+bNifyZBfTRDGOsU57sjsxPjRETvLg1
         lYW4nHpBFOTg1chUGoNvcyHB0gw98BY1AJYKeBmHSk0T60KJfFfuYIAP5ccJv2bZ/FPR
         vuBA==
X-Forwarded-Encrypted: i=1; AJvYcCVMuVLT/LFQ/uKVfgX3W79Z0GPZ2QI4g480je+bxcqn3JhEr7oPLIS2DqOnKsAJ/axzHNXZ5s5AlbIix6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNlOMLsRspkUNG6gUylwlabUVa6GV5Dr+dmt4ZW43aBR5QTId
	pyuN1x1J/R2qI+O1RvLQsEajPw9L09xwIsTTxDxjdgLz+49AgJmPKJvJghMbKeGBUqoem015n4K
	Rx8B7lVSnaw/rBUGpPLYZklleiEFpnPjw/+wObRGQSqchEjdZ0RgH8Rzt+8Eem9IcQQU=
X-Gm-Gg: ASbGncvcHdEeFBeBY8dFQ3PAYiBf97qL4sYiWswtUNdi/4GLQKhJShvYqL9uNPnxEug
	qj+57yDn13vRsRE5s0fYXyR+giQ8tI01+eFRDcqIxfEt8lLntpaezy+ZKUEw/KMv4Nfg+dM80dH
	+f3IgbYLwk6zoqvO+uBW8WgKtEAx2JZOVVP+5889WiUuk//IZbFDDg7CuYmwLBmIpUVbROtWelg
	Qu2xT+6xcT1IyUiubPP+edQpZ6SzVhEhT8bWkzIofUh2s2Hv+mmgPKXxN7csYzj1OevAKXOcRIB
	e0ILNW3oAIWVQ+6VJjBzOE4uWPPyXh548dqNEla5cLK2iXx71boB3zHNOyZLw54pL5bBs3j00vR
	J86KnjIO9H90R2jkQ7Xda
X-Received: by 2002:a05:620a:7001:b0:7e3:3996:f491 with SMTP id af79cd13be357-7e342a5f37emr494234885a.1.1752783592652;
        Thu, 17 Jul 2025 13:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNmxt5o2S/+vAadYSwZx0yX5RUb51pFNWBZpzZIibY18kUapm01ygu3TXq/XZeIrZu1uZPPQ==
X-Received: by 2002:a05:620a:7001:b0:7e3:3996:f491 with SMTP id af79cd13be357-7e342a5f37emr494232585a.1.1752783592100;
        Thu, 17 Jul 2025 13:19:52 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8266992sm1405498466b.82.2025.07.17.13.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:19:51 -0700 (PDT)
Message-ID: <1ca25402-8f57-468c-b4d5-7b52f526ab28@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:19:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: add initial support for Samsung
 Galaxy S22
To: Violet <violet@atl.tools>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250716231710.99983-1-violet@atl.tools>
 <20250716231710.99983-3-violet@atl.tools>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250716231710.99983-3-violet@atl.tools>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3OCBTYWx0ZWRfX01b14aqDi8rQ
 GsguqYO12Kqf8PnX0QI9sLArj6YdBKl85Q5xFdlF7GiiYI6DgKT5ThncYpCGgjQDcb4t/Rj2/Wn
 JXXtTKghtESeLFI2Nm3QbABqfTTc8F3St++hjBkhFTgLflt30a4EwjEo1iseC0WX/5UNhftXQlP
 3njkg0TT0RTLgKWCrD3EDrGltRiDhfB0HBMk2Zza7lxpxdJu8q3PlL1zP0DbmNShVvwxemU/eDn
 PXGztVb0R0D3y3PMKm93y9gmOYQMeH33Op0hC0IbwjwiAndykoU1i3kMaVihNWHo/2jFSRalhUb
 flwGC9Jf7LmASkQ/p8sCKI0juwaJC3z2DP9hQoLlm8nv4qJmoXW1isSkrkcXEz06UnjBoE3UWl8
 O5yQ43f78U8Qdq7aoUJ4c3/i0mjKRU7sEab5LjYZ+4iPIPEsQ+ajJjYsz6/Qy++PTDGeJNYb
X-Proofpoint-GUID: AMZMtf4DtIJAaQyk-dJR7yNEoBZjnEm2
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68795ae9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Pfut3a2_zQbZhcqyhhUA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: AMZMtf4DtIJAaQyk-dJR7yNEoBZjnEm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170178

On 7/17/25 1:17 AM, Violet wrote:
> Add new device support for the Samsung Galaxy S22 (SM-S901E) phone
> 
> What works:
> - SimpleFB
> - USB
> 
> Signed-off-by: Violet <violet@atl.tools>
> ---

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <36 4>, <50 1>;

Do you know what these are connected to?

We tend to document it, see e.g. x1-crd.dtsi

> +};
> +
> +&usb_1 {
> +	/* USB 2.0 only */
> +	qcom,select-utmi-as-pipe-clk;

Is that a hardware limitation? I thought these phones had the necessary
pins connected (for DeX)..

> +	status = "okay";

A newline before 'status' is good practice, file-wide

Konrad

