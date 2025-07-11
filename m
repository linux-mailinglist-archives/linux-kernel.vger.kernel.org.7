Return-Path: <linux-kernel+bounces-727322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B88B0188B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8517BB463D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B3527D786;
	Fri, 11 Jul 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgVQh/tN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32927CB02
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226930; cv=none; b=olLLJ70Ak45nvdCYm5ylKTz/nF3ggsEi20BdK6jFKQvA5WHtm9z0EcIIqqejJNI//OhH4vkpYQlkiRPXRLTwdjEsPtkO/mbRyFGGEhtRKmwoNfBXYcbqBHSK1/zEBARviq+O35QEFfSnIV4dwB7odHexaF5zOk5TfBTERvAVHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226930; c=relaxed/simple;
	bh=M2ee21tTcdsIhrvWz0enz8WOXTUstDicdOJtOioNZJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KK+xZc5jnsmWLaSZm4vebdy0rBCDATmtR1sRgQdm8jNLjQ10rBZtjuGgNamEII3slrWYDEoX7kropLjLwycnE/ZUxW5TLyhl7GUMNub3eCG1rKtVpyBl3+DZZkrcyFz9lyxCCoFgSpNiPyDhw2Fa4+j102MZRXnSOdWy/3Qo3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgVQh/tN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XHTP004092
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DxT8qv3JdcwWqLEg3mZXR/RdYNSUZ8uyVo3R4Z/tvhs=; b=RgVQh/tNjms3uI7z
	63p1hdceWw6IiyfpnHMNR2wEz58iZxlfPrE+fOFFgKbDH+COY5G9CAFC3ZAVeWMI
	ovkQBlzrvMivlOyRcHpXYgMkPvsh7wSiX+KsP+p7o29SYSaNKY5/bt0yfwY2fp+j
	5IKjudO5W2mCLJBHkVWinQ3CQ7o7z0GXKmBot6gvU2h6T/REI1CzNUcPUccspwRR
	mgFAUDfAb99S1Iuv7arMR4hd0iCrfTV5Exe7YkCJjU4sS9HCZnJoL9Ixekmr/eLA
	0sj9wkzwFDOubNnkSe+zCR2C65Wtk1wu5Dww/IzvwpthG4jYBzZezhjmKLo8q219
	2TVGfA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbp05ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:42:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7dfe47423f7so5114485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752226925; x=1752831725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxT8qv3JdcwWqLEg3mZXR/RdYNSUZ8uyVo3R4Z/tvhs=;
        b=iNNVKhDwEmZdrZNOQP4YWrIFJtS87jBhkkiB7XonUx0V8blfIGbmmfo/bGJAXicbPL
         zG2yEiBAp8OFwaKDqi9H6xIEHd7UDXJ2UgvS40Qdw4yo7Lo6mq//EJFk/3TChVIWq+9n
         VFsfd+pdD5/KnZZ0corjLcRogpHq4dtFpLaFAF07VcZl/mB/fP1rULJQz4uX1tIpJvXL
         dm+3/1/wolXv9hP6aNzSWp4T2XyYKsB037MbNwPfIt0VUMViy1/Gvs9oo3ziXJEDzBLU
         XnhxVlCQGf6cnI3N+jvqr6oHswWxmupJdr3pTZaJrC5+7fIiOzZxtyEZWoGEqyjieAhh
         crag==
X-Forwarded-Encrypted: i=1; AJvYcCVRuhnGkipJBysgffeMMzK2d61D5Es6D4nyR9gklHq33qgP5WtxjqUBv8H1E/GHgk+VOV/AeyZjkOPcfy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmOuhfkrCbPmQJJU9u5B1q/VDhhP5808IM67z1t6U65/9JJNl
	NkcD0yfziJZPfSZotlUSOu8cBCPGW8IV/sxIMWhC6VcY1rEE1Y8CddNFDpzRtCj+uycCGqI5gXY
	mLsTKK+3qWB5WvhcJzCnwz7jQMCGb7wNWyodlR1jANgnCfczRx36s0zSePrzRNAH5X1Y=
X-Gm-Gg: ASbGncsnVplB8DfwOEeC8R2VQ9wPEYTE2wX/PBeQC5mb7FC4pAPWWyQiPGHfabk2FB9
	Z+idmqFu/+A84I0fCLTTfalmDW6n4mXk9jWBm19hLtWWh/SoboS5z7uJ3UIC91niE/pk1Q581Cr
	UG+RpBrJB4Wk0GkrxTabSMdS9lPyJVu2jF+Sfu/ST+RR/0n7Shkv8LVtJa0rA28gC/iJBpfHFYl
	3W5gJG4ppSL9DHhyDBrWFDa6Fxi/ImeTtakTyfqu19SP6yPe/bkanQ7C5DQZ3B3w5QnLAWv+1H4
	KplKW/8m4WoySwHBt6N4CcDKG2ZWZU0UGAoNTvetkNCVuFgAfvD+1iH6lXswknIBvyftjE3NmmJ
	FVLzOwYbY7wz4NmP0+Ksv
X-Received: by 2002:a05:622a:652:b0:48a:80e5:72be with SMTP id d75a77b69052e-4aa35cb1dd9mr12074231cf.2.1752226925469;
        Fri, 11 Jul 2025 02:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ+ry7T+rYf9AJ1NPwASKa3NBXW4kgR6/+yGXRVJ8wsFukrBio5hDeZn/edxK6s4hKKR64tA==
X-Received: by 2002:a05:622a:652:b0:48a:80e5:72be with SMTP id d75a77b69052e-4aa35cb1dd9mr12074091cf.2.1752226924908;
        Fri, 11 Jul 2025 02:42:04 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90a07sm269371866b.6.2025.07.11.02.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 02:42:04 -0700 (PDT)
Message-ID: <e358b93e-cdc2-48f7-b52e-b6560e8e5ff1@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 11:42:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/thermal/qcom/lmh: Fix incorrect error message
To: Sumeet Pawnikar <sumeet4linux@gmail.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250710175426.5789-1-sumeet4linux@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710175426.5789-1-sumeet4linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA2OCBTYWx0ZWRfX4LvhcBb+TARl
 sLEx0kgkormLWkQA6+m38AeVXaBh4nvAt3XXMMIlxc+FWVOkvDnC7YTht5nNDrdGLv3bIWl6DYe
 f8HCPw9wikXZ0XLLprp0WsqhuRbKlGT83AF3EUGV5UKj5ZMcs18Lgu2ZQYmVyAxvKQM+fwrutPq
 YYiCjcF9F1tLFb44sSWHe5gmXsb5J2NaM2/fHijUdZFdjj4QtYoj/MUJMlHy4jecQVVEl8XGh4j
 3g9NVanVhRE8bwwY4zBZnGepUO/tjMwO248EqrlHwJUblrd5kb+1Z5mT/3OkObyB4TpG4AXfkjH
 kQYb/0S6eM6i5YMRwgbvCUL86/FaZ2dsS/GNKmOmWdsBpkyDujlwFkeyZmIjdUlsgm5rq3Khn/B
 bylEZdyEwhWZn/m5pGE2hhO30V5enhEMuk+wQiwlzlHoBvf5Fh+uc3fhkNiu10drsKTyHY+i
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=6870dc6e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=3Ok3IA0u0twTkz7lZ6EA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Bgsx5o_AZ3RjVBUMdzs32VYJCMvzTOY-
X-Proofpoint-GUID: Bgsx5o_AZ3RjVBUMdzs32VYJCMvzTOY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110068

On 7/10/25 7:54 PM, Sumeet Pawnikar wrote:
> It was showing wrong error message as ARM threshold
> thremal trip for setting LOW threshold thermal trip.
> Fix this incorrect error message for setting LOW
> threshold thermal trip.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---

Thanks for noticing

For future patches, please wrap your comment messages at 72
characters, so they look less squished (you don't need to do
anything for this one) 

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

