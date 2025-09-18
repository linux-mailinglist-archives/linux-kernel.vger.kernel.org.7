Return-Path: <linux-kernel+bounces-823286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EE1B860B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C873AA7C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865D217733;
	Thu, 18 Sep 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ES7HGXdQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE12EDD6D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213084; cv=none; b=l6HGOdqNvODGkQNaDKIjs/pe4I8DEjCX7wOy6e7KgNTdx//Q5uu8NapXzmVem7EvqWi3Jf7P5S4FEgDHFm4yQCAxmbRzNk3CA8F85Z1txfSpEbTE55xbVxRAnl/era7mZ8KS6g7LbGuTXG37aAi4mb0LfyjeNlLlSX6zdE+t2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213084; c=relaxed/simple;
	bh=qCwN4UWf/qO87rnIbDuNnYXQZL556aOSgTuDK2FYCBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BioM545p1SEdpHofEkZyVbu2HpLJIaYAHkj6h5l2ykXsz+403BzdgubMZ47E/MTUFBHznYc1Rz919MepgJ9CdKfZZlMPGGMaRmF0KDWE05kGmFDaF0Aa/s4blG52T/jMmKY2jPmHgQFP4fHqql346DJrfNtK130heAW42Ogv5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ES7HGXdQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IAYfrx026846
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qCwN4UWf/qO87rnIbDuNnYXQZL556aOSgTuDK2FYCBc=; b=ES7HGXdQdiFxaJtg
	k2xDRMr62o8gqivC38tQpTwBe+ZOt1P2zvyqNsevxfkNhaIBpH4oc2G2/boJue72
	ijz11mbcgLUV+vnu22JUSDW0U2RbLYxVuu1aZm3sLJivpHUSz4t/ARsCpSUjIrN1
	DRqSzYpInBkK3E0aLzlcENMpSNE70PBX0tdVbFH2Gqq6fv4qzRw79kZ+c6I6BA1K
	7pDsUxQEMt90/FdLXUTxhcerWuyvAfd1dJv5fqMIZZqgD6hrFwi07SxJ/nZiKnuF
	M+4LSnv59bV5dlVuf15ToLzlfhcCmUiHWB30F+EnwZV7SpGW4l7yrE+S6s5CoGOb
	jpveqg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt773e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:31:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329b750757aso1013084a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758213081; x=1758817881;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCwN4UWf/qO87rnIbDuNnYXQZL556aOSgTuDK2FYCBc=;
        b=LqlHm/lAVx+E/aMNOqXbxGkvv2ha1wuCPc3GFsf3AVQo1jGtL2hv076buZb6hwYwlo
         rhH1NP/q4dMwnxCu6v9nyMq/2V74XY/wRcLjL4/PhpjdwNY7IavC5kfaYjtuvMlzF2He
         B0a9kgv0nnacpU0PncXxuxoEJd7RBMBvZBr0+rb2OlHQb1WkXnkAWXvYR1v67sCpQpJy
         KHqBxSjVe55tZAh6QmYhrj1RJK+nKJNn9HMb6dTInh3HcmgcPBehJmbPKH6vVBetOQXW
         /Z4EaVbS6o9HjXah3UPKKfS1tteKnG825/IXXHa0FrnaH9JT2TaqMX1rlyxAhLPrtV3u
         /prw==
X-Forwarded-Encrypted: i=1; AJvYcCUrbVrwsbE8xcGxQyMbBcmi/2HPGmZBf7zwVrVB3ywN6YqmO+iNVLJ5wUAaPzZP39EsKlVUZcfit4qLRzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnFm4yAQkrOqZ4EbKs4bxzNqbGn6Qz5SMn5veg4R+Z1uWB5Gb
	nz7ZuINKRnxZAt4PD4MUmRSK93C8/e1OpCsi5jT3GddFhTQ2BKxglrflFZP1sNS6UlRns8VK/sk
	45SvNmxu7I0U7tOWQASHXXR16Y/62ScVGh+Y1goHJFJyBhuKHqfvz+ZySfNaWWnnC4I4=
X-Gm-Gg: ASbGncsqvmTyKN1oTE0JzJHaExYf0LLe0SZs6Epbu25v9MyBGvrEKmsInJ17gE2o4WG
	rvf82fU3Rtvd99dBnfAN9aZ29LPWSg1fuBW+SZbAvL/Ny9ivQTsKMOQ93NgJ12ejBELcbUWtRhr
	yN99RlJGRiXKgMgfNiGzrDXUoUtWCr3qVeobnb5vxSwB9evFLGu1GH+i5z2S0mv3nxsnS8nLJJn
	XQaZYoRpixCIhSFYhNo7zK4QS2YeF4uvzTrSuqHsUCpGStDtmTI+jsuEQy30Zdkz4a93kCBDuZ7
	BWW8ytBuAQvnLVsM1POSG56TTSBGO1WH5Eet0maQ35AL1+YeKxdn0KkdraGk+K79yST0VFLhuvn
	ZAvmOPYL/7HzZvnE0TSYuEvPv
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr9571437a91.15.1758213080973;
        Thu, 18 Sep 2025 09:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Bzu9IzjWAIb1ykdrkuMpLZlLBm0S0xGZhC2cExjcG46jsKIRUC4NyJocWI+6wpsHTHQ7Yg==
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr9571379a91.15.1758213080410;
        Thu, 18 Sep 2025 09:31:20 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff447060sm2685889a12.53.2025.09.18.09.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:31:19 -0700 (PDT)
Message-ID: <e8d283aa-fb73-45d6-a89a-54ff31f205c8@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 09:31:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] wifi: ath12k: enforce CPU-endian format for all
 QMI
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
 <20250918085406.2049559-5-alexander.wilhelm@westermo.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250918085406.2049559-5-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: T-EYp_03SOHIgUz-qdbK4qpwefwgdav_
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cc33d9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=msdzb5vn4zVyWyR8mUoA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3pmCzYbUXMCu
 E/UmTbNs6JljbumlMi9TkGhigbXYLwyeBCThFIgAsSo7x/voyoehlbWkTbPE2xEzzcJwNzVdFQ7
 DU5kAhLUooxcezy7OfENIUKBCwV3jW3yFUuDZTh5vbw8kRDBcXCmfnImIBDOfiImz/zeUekDiFF
 j1Tenis4DVkWum5Nr9rEuvoHjjE0tAkh9WhedLFzb0/V+EedJW46CqfbWFhOKTI7uzyUTYK2uP+
 9RmRAlyEfWh67+tsT4tTeHG0s9ZYcFTZzU11hm+OEpr61gsGT/78DUBOy5NEQjvAIiAYp1jCtya
 7ojGoVVuw9tST5z6XA8cT13eNDv2CRibxS8c0uO1MAD+mLLXW2+20BkqOhhcf3AYjPmFSRahcEb
 iDhYrU+r
X-Proofpoint-ORIG-GUID: T-EYp_03SOHIgUz-qdbK4qpwefwgdav_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/18/2025 1:53 AM, Alexander Wilhelm wrote:
> Due to internal endianness handling within the QMI subsystem, all QMI
> requests and responses must now be provided in CPU byte order. Replace all
> QMI-related data types with CPU-endian types and add the necessary
> conversions to ensure correct interpretation across architectures.

I think you can break this out into a separate patch, but reword in a manner
that doesn't indicate any dependency upon your series (it can be a predecessor)

You can do that by noting:
1) currently (before your series) the QMI interface only works on LE systems
because of how it encodes and decodes the data
2) however almost all QMI data structures did NOT use endianess-specific types
for the data structures
3) the ath12k structs being modified are exceptions
4) the QMI interfaces are being modified to support BE, and that modification
requires the QMI data structures to actually be in CPU order
5) So change the two ath12k QMI struct which currently use endianess-specific
types
6) This change will work correctly with existing kernels (which only support
LE) and will also work on future kernels where BE support is added.

Then I can take this patch separately from the QMI changes.

/jeff


