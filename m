Return-Path: <linux-kernel+bounces-777011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A5EB2D40C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88F37A6060
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C17266B6F;
	Wed, 20 Aug 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XCFGBTN2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59551494A8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671258; cv=none; b=E6qnnRmmKo4ZyAQsd4HOEIDvYZtJIeNAuXgjUcG3tWmkMJbKeALikLJqS/7Y4SsvblfzDoes5yJBsdjqlIhROTYwIEWD8Eo41++irS/4c69EBR45zDIleEqUCVrvS6mjjRsp7OIiQM6VLiKfQnHWml1qRuDDUioOp2pwlXgof0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671258; c=relaxed/simple;
	bh=yutoOPb0rYP498lWLs9Scfp2OW0gi41bzD2TFy+eBjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDFLCP1+fHYJSBJlwWBK2z4A/4OgwTECI+d1gNyCbORn1lMnepox+st98KXtuEGgS8UkenwqA+im8Fqz54gRD50NPmkdNybOySE4BmnTR6efkcaf2Uu6cHfuUJKILG5KF08DGRZFhO9Krlgs8tR56fMUYQFHLWcQ8r0hBFymCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XCFGBTN2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oXHb002009
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0YWM5S4dm7vSz3gmoQTVjUJYFT5kv0kabSHfWarxYxM=; b=XCFGBTN23/Vp6ulk
	cA1/eLv7ZLhSywt+Wb89npC+Wr4qQopzFDxh3SWtGIyBXbX9mE780j3emx34FDD2
	7An1K03U+tRmtCtL/shMlVDdgzWHaomLSwsYBMXpgulk5MFSVcFl9KMss+eU0bHF
	y52Zda7qOO0Jjzft7aMR/2FXw93epdhrl4b7jxH8b9OV2PrNXFD6mFRfq17snyx4
	7kErxl79pwoE89eiIHhbdCqqUtYtWwbSVzpPTqWLRZi5wfDhm0FbvcrLoX9QiZrl
	tKOn2mpsoA6ScYJ92Xqe6L02NcziB8WicwJvfWAD5bzylnLikpQvhgpY5jfNrB3U
	wcuzKA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528rmnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:27:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e614c60so5420672b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755671254; x=1756276054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YWM5S4dm7vSz3gmoQTVjUJYFT5kv0kabSHfWarxYxM=;
        b=Io9xvm/OT/5v1WZgjvLpVH3v3ymUol/2jHfdD/M2tPyJ9BcnaFPbLGnehJ7+coTLhl
         WXAFarXV3JfGnd74n8sSr++/2c7k0hqRR/t8ol11ox3EgtnT57V2SyMubTknSn7rYYsC
         jY3y2wtt8ESY4D056HK6jTK+g5VBCEKiZMuP05gbRpRCfnTqAdQVKfIqYY+PSC/EliO9
         Zhb0c9Gf2ifI/R83jispGvdxqJP21uMSAmWMyTX1HRPAJlwmoP6uyK4srXusaGGBxeEq
         xBU4G+OjNeM0mrrHvv78xxR75hocohpzO2xGHvZ+A/l1CrdJbkJlDNW9Pqs/soqghlDe
         X9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVB4n43BtV1ixYmQ4fNkcJn9DAvxaUAypozvqKw3lSDeEJHYrzeuMQqycsocGm2kes6YkHS7Qx8WGnQ/pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV6HvwNFiZetbyz5rMAA35XVgRN3qRJNQTuKCh+GmGzvPGmUmU
	uEmiSh6gtKbcLxYe1lZAgnlYs2Ej84o+CsSXl1pE/80E4BLKMckiWyyiFqcDXbOjwprHrEWtAtn
	H+Il6F+IQxc3GnsvB0Q/y1b4pbfdY/yNVaGeamYErKpe08fW4M4kvMvtWA9qR3BEbaH0=
X-Gm-Gg: ASbGncuMl4VpBsWvU0X97CGmXI0fEsYr5PmdLTtwHJvcps7QvE4ILqfCZiJlWEvqH2h
	cFlpjmstwrZiO7ClxApXyreBZbkry5ztX6txKJtW6acwRnmvtQ903pPSOQWvdyr3CkewsCAdgZw
	IjkjCJazCui/hfRkIjdKgQsNeeJRoQTqd4WK+Y4A6kowygqs0EOjxDzaN+t+E/7CD4U8Jh5PFu/
	r2bgpT6fydpU7i8jBw8m8N1cFrCeuHOGpnFxIeKg3FfKeEUFh1q2dpN/JsJgWpkGmRyFCoDYT2D
	eXTaGEG/82nWEZHeal6xflWMs+YrczEGh9Xz7UaoSMNKMACSUe2Yt/CgK2KhvFm1hcKfPI9xGv+
	WLvZ5Y/e/YUzirYqojwGGNq9a+9wZJY1M
X-Received: by 2002:a05:6a00:17a5:b0:76e:885a:c344 with SMTP id d2e1a72fcca58-76e8dd4cb80mr2579632b3a.26.1755671254284;
        Tue, 19 Aug 2025 23:27:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmS791N0ixCzI5dRAxbIiWf0iE1fLD86Phx2bw91vneJ+muUr6Yon5CmZn6QVf8jfjkBKoJg==
X-Received: by 2002:a05:6a00:17a5:b0:76e:885a:c344 with SMTP id d2e1a72fcca58-76e8dd4cb80mr2579594b3a.26.1755671253812;
        Tue, 19 Aug 2025 23:27:33 -0700 (PDT)
Received: from [10.133.33.73] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4fa868sm4294504b3a.64.2025.08.19.23.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 23:27:33 -0700 (PDT)
Message-ID: <baa85e52-f275-4d29-b3a9-2880664434f9@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 14:27:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] coresight-tnoc: Add support for Interconnect TNOC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com>
 <aba6bf1d-5974-4003-9ae2-62033ddf87c5@kernel.org>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <aba6bf1d-5974-4003-9ae2-62033ddf87c5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a56ad7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=T5-8DVSjhCRqEL8X1fcA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 3LmvFF4CN5o6ylEhu6koO3GyTWrVqRFJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+VOe76pB63iX
 AnJLKklKlqTuQM0uhYCIvzXTWQwK+uM1j0iR7jWgy9j00oGu5huNEh8YgRRU1cOUdI45OiO4+Yb
 jiePf5jPJvmMy5M7eSrqBT5M8xI3GVsRnq6vvDJuYyUOxqkXOfTIwsgkmob+HSv/DFDYL120Ua9
 Cga62Mj++VcoDMqefVGJ4NJsgZjRcOxB+H+lHK3aGnumPCHDJ+htwptqEg5nBVYhdxESJzPyuRN
 xvyHUGv3swxKDL2kS0louC0359D8VXyLJ1aAFqn6fRHQLevgxjcFKf3K8ywmAiPQ6SPriWYU6Yy
 rEy/p4K4MmL8AUpvFLVpoaWBMWXSR02khs5/uyfEsMs7AuiBEdNTAUp4iJL5xs96kF91yr2ZuTE
 ygNtWqJrXAEL4iqNtDHGMFkEgeXT5A==
X-Proofpoint-ORIG-GUID: 3LmvFF4CN5o6ylEhu6koO3GyTWrVqRFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/19/2025 7:30 PM, Krzysztof Kozlowski wrote:
> On 19/08/2025 12:27, Yuanfang Zhang wrote:
>> This patch series adds support for the Qualcomm CoreSight Interconnect TNOC
>> (Trace Network On Chip) block, which acts as a CoreSight graph link forwarding
>> trace data from subsystems to the Aggregator TNOC. Unlike the Aggregator TNOC,
>> this block does not support aggregation or ATID assignment.
>>
>> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Refactor the dt-binding file.
> 
> Everything is rafactor. What changed specifically?
> 
> Or you just ignored prevous feedback and did other changes?
> 
The feedback has not been ignored, i will update the detail in next patch.
> 
> 
> Best regards,
> Krzysztof


