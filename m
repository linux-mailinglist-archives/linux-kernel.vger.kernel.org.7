Return-Path: <linux-kernel+bounces-724872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E1AFF7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06C41753EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DBB28368A;
	Thu, 10 Jul 2025 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E8vGI8pZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6427F18C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120242; cv=none; b=T9pifDdeKN1uc+lV31w3+9mPWGnwHIyLU9UbFpivSK9KsA+exlQtsJVny+/uZ985WC0dgdL1FjTgjn9GGvLvJojsyV59Vgm8yqtlhXwtrnk9iZ7LQlCQj0QMQaoKkBfKkxUfnbnsMNtoEIQtB0bRYstcBO9kyP/8fzu6s0zgpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120242; c=relaxed/simple;
	bh=ozUxJBpccOs7DoeI0f5733XzUV+NBXqqFc/UQAKa34w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1TYHpc5QDc+9H2WuJoJLbUjyl3fjf2/NO81h15f6/v4r1rkAt8kAcv4fwSCke4m0fbumWmWo+yoxzIwhvaiFiV3cPPh0sIvwkOWfuyenaw4btCQrNvs1ZKhgKUrVNFmgZYkaEwthxpEV6ASQ8TjiIBGLgcAN/aWEbwNHa5ZfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E8vGI8pZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A1MqeJ030248
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/cOMMc1XfeBpd6NIV4GqD9lwT/BJE2uXmJIOj8BYXLI=; b=E8vGI8pZtkLdhrOo
	KzABqEIUd5qV/tUd/E2Y0ovyTB1xsbf4MQ8fsyHECHKEaxNepLS4WfyelPYDNbYL
	2WQFzuKuaDpNh1MGtz96nG+ZGrG1lcpBkgEBYQd9RhqdInvjrnUVCJ3p8frpAHME
	E1mTPdd33NYlmrHrqDeg/w5K/KdElqVuDgMutGIbj2glkLa4OAmewUjxgTeD/qUL
	KVILwhlTNV1mHuKPVub57SHRJuXNt1Bfdt3Nsex1quCqvIpQqjGs3Bv/qgk3dpvL
	ntdnB2LG+AAe0G0ikiLFzUQYHQhN44UQ0vz7/vzNgl54cQE0vuRnxaznOkd+ptu9
	KOED0g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg3c7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:03:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so605165a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 21:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752120230; x=1752725030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cOMMc1XfeBpd6NIV4GqD9lwT/BJE2uXmJIOj8BYXLI=;
        b=XvxbRa25f2zhb4TEWhVqgaqf0HS5VJ3xAXtz4rbY0mLKNHZ1AIQWC2P4fz5vCsmzMr
         pIK+FThezPkdKd70066wpWlqiDQBh1bLoe9+inJE657Q6F2RxaLyxOcroHB2/N21X5NV
         /wP162lluwzR1j48+tKNDymWpFW3OWp0VpixTC/aV3hux+bRgE2SMwhc1jrJ88HxeMdX
         Z+SiLOh0L6WHVypwH4ePGrDfG/KeeXLLcE20iP3JV76P4Ku9kVpywlYVEH7XntXLUDf9
         FQaEC0p87lwTqS2Y5SlUy1u/7HyergaevmKruIF3B2Vq9QkOl/e7hWR6ItJq2VtBYUIz
         H0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZxjE8I0jerGBNQw7ZyLDjg3JhqESNiAWau32zymmCezG5lIQRm+9eoa1XLnhx0cVBy/q9zjp+LmeFRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMBYkoCAdsBvNnz2dnj3pAZvDfvz8csHSjv3sg05h1tz2smXT
	tnhSABgcZ6hk6vVRDr02dPuQ22I3Q5N1Mj3LsON1PSNT/ck0SFf3wnYllw9YMlJAs+U4SKtkVDE
	VryWf8IFATwhp7qZpYgvTErTAJEN4VWCOGIRDc7ttDg+NTE/WHHkbQ3lYJtXqYRiqDYM=
X-Gm-Gg: ASbGnctD0krywH+DU8cAkvgHqHoNmKxIadc9uLdSvcO7YXBZhaoHnQZo2meV8qaxSjV
	55hZ29g4eDJQIGcWZ5hmPDiWaIouqBW3MS05cnT+2SqnlUZA4Yay7NPsrTL2LOc9m9t674VTjo/
	euDuI30x+9gv3P7o7T3P+u9nPnpETU9K7Qh2cFlZL1bGeIQnBcJnphmnaSos5O/7UgDjFJhAIRE
	lGvz2qawe74jID4B13etXhHUQ+nlb9qRMehwoQv2q3EFC66dHqHEGtTyrtkxuUIdQ3OHJqMYOry
	U4WjVTCAO8A+MUjrdF2R/3Yraw9hSSQHmflyxxIu/yBujtUc2d15tmILYByWFw==
X-Received: by 2002:a17:90b:28c8:b0:312:e49b:c972 with SMTP id 98e67ed59e1d1-31c3c2a215cmr4509252a91.15.1752120229820;
        Wed, 09 Jul 2025 21:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMEy4WkiWJBnP46D179XoWWT5PKzwj8yODTk7jYtdtGjM3aivROH7JHI9Gv85UzbvlH697Lg==
X-Received: by 2002:a17:90b:28c8:b0:312:e49b:c972 with SMTP id 98e67ed59e1d1-31c3c2a215cmr4509218a91.15.1752120229430;
        Wed, 09 Jul 2025 21:03:49 -0700 (PDT)
Received: from [10.152.194.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003faa6sm3947202a91.4.2025.07.09.21.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 21:03:49 -0700 (PDT)
Message-ID: <7aadfaff-f8f3-410f-90db-20b24d4e2c5a@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 09:33:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211: parse attribute to
 update unsolicited probe response template
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>
References: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
 <20250709-update_unsol_bcast_probe_resp-v1-1-d3323ce9a7b5@oss.qualcomm.com>
 <9dd32e266523cc7f5f5fdc3e676216f4a0057615.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <9dd32e266523cc7f5f5fdc3e676216f4a0057615.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=686f3ba6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=_mHSiI0rn1d2AkKRWjQA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: DzEN55j873PyGTD5QHuqZPv_VXtJ1nFw
X-Proofpoint-GUID: DzEN55j873PyGTD5QHuqZPv_VXtJ1nFw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAzMSBTYWx0ZWRfX8nTwgQIp7F7/
 T98815mqz+P5QQiopfCqAKVm8M5n8aBGbr3CArg8zX2dWQJDvXVgoXH1CNEFN3MrkozebvvE4jA
 PKO5y3uYtuJ6BjEga9/R9L4zUCSVVohCZWXfeVYWlcbI7H5gI9sENqsYUBgjum6aJy5FiRbnDRc
 aAxPoFmVYlAW9wewZGN6oFERxMbug+27EMrnq/aLJeyh6cQaGdoDsfHYochgEb/f5UkgPXa0p6I
 lmYdFfGBNPVEuMR153Fq4k6R/Qd1PBVRbTNLnyORj5+7LMo3xSU71cDkaZdbEQoixG2Va5H6kAl
 nj+9OkZob0yZx19nHF1d5AebV6YqeCBvbS4Gkvu6gKHIVFfHYfvoZ09Jkzo3F6nBgRlLWIGWZ7q
 EnljUtxwYKlw4QOkGbw9X6Rq/dMn8eDUKxBuaxtUw/+zXFotZ/3U4OKnCBXIdhI8VWYJPKlT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100031

On 7/9/2025 3:08 PM, Johannes Berg wrote:
> On Wed, 2025-07-09 at 08:05 +0530, Aditya Kumar Singh wrote:
>>
>> +	if (wdev->iftype == NL80211_IFTYPE_AP &&
>> +	    info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
>> +		err = nl80211_parse_unsol_bcast_probe_resp(
>> +			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
>> +			&params.unsol_bcast_probe_resp);
> 
> I don't see why this should be only for AP, not e.g. P2P GO?

Yes, my bad. It should be for both here. Got confused with color_change 
handler. Let me fix this and send next version. Thanks for pointing it out.

-- 
Aditya

