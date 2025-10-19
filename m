Return-Path: <linux-kernel+bounces-859666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02FBEE3C0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C418218970FB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205342E6CAF;
	Sun, 19 Oct 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RX2jYTUD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650F165F16
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760873760; cv=none; b=WuR3uNG9pxaI1eynW04wQJgiTrHKoZRCsZFH2Cu1JrX2QgQJrnK0Chfh0lWeUfqA0d/gtVFokhiXrAr9qy+PbB6Sc5pzn1aLNj2GSFPbMdpz4fKYvlUZIq3+6z/V0en/3h3DKAn2b8I/3xq0VUEoA2/9FHVVlcjBgCdoPhWhtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760873760; c=relaxed/simple;
	bh=LBE7P8iEvXZvQChiXh66aQde+RFGIFlEtmroTpJ6buM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aye3wTjq1ZXckeaZrM53HvNjbxgK7sUrV1mIcRWFlavQDVtXw/hOd2deyxqBhQroWlqgxH4YZgNOICpqPHLp6tBUnfweY2mditmrNyu8fOtcwASwtdV3THNlO57AMxuurboCFAInT+KOsTUDEWmAM1rwbzcVrel0lGRbjqQmGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RX2jYTUD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J9f6ka022014
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LPDtWvwCFPk9Bp0BBoOSzdwmx2o6Q1df26GMvEnG/L0=; b=RX2jYTUDJ8g1QPUi
	AV9J8bYhcdZl5SY5lXDdC2YRhCsPkbneYbHoOZ2EhOHd1ZIH5QtlkMrvYr7JkKjq
	6lSp8uS2AzP0e7zmyH2JnnQGAOVwTxasEFIpusVi0tWqvp4QgIfLBc2XRz0OwKfd
	qzLEucDnmdA3ZlxikJIe7ujJRu7k7sxPjWAK/SkJp8Gnf1XFPsag+blf0MFSemiI
	O6oSJH8fO1o3jJPr1p1EaHOHXiYIAA3LYgwmzH3Xm58RY0z202HN8iSKFZYqN6w0
	lAJqQXytWJ4tyNvTG7dZWr55iZccG3wwwXJOzOeVRzCTv/9QqdYGlGsx6c+EboMC
	XbtWwA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1usaest-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:35:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b60992e3b27so2260681a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760873757; x=1761478557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPDtWvwCFPk9Bp0BBoOSzdwmx2o6Q1df26GMvEnG/L0=;
        b=aQ/++u6/OZq9XDcpX8vGMhu2fLaHWtTEBfGXl6al5lMtekaZ4Xc79PCq1MXBMm4Se9
         dO8EhGRUCq+9dBx5er9VYNETsLJP8pNSH7oQaboIW7oML2tdpuBQtBhadCrApZAvENxl
         X59s48gk4QVlfp/Fn0z92/lDrOR0XWeoqhzmOpVqYXt3QABpOr4LjpE3L442Wr6J6w7w
         M9kr9P05yFeKWSpJs0GOV5MkpREye1L4jeZ6o69WiW+1hLV+P66Lkl0UrjVc3WHHQBXf
         Htdux+L6UZtYmcsoVBeiogwAmRVXEMdp6UzTz/CGB/uWlUKPvW8YS9y1pvWqYC1psh08
         1KdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcAKkQyifVa5344bQaZhxIyodal56h5nzfhU5g1F+Sw78LH8DZDkZkJ7unPLIFEKibeUvdce1X5wpab8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAS8WhXg8f6w1I1072Q7qwi3BgmQACb9BEHXwGxK4WWqx7ih47
	uHxFiNMDQr67Pir8aJP09VIwVklY6DtvIf6bWT9xF7u/lIyP1UP008C/szjPOyI9kIXbBh9wLGm
	ayOA+OmxTJNdQniAghyntDTTpSPpfwcEQ7a99uKsie9yHpoWALX/BxYBRTvCnvMTI8h8=
X-Gm-Gg: ASbGncsOtKUaniKdrIuBiq6YunZ+Xg6Lh+7oIsvwCDmooKaTf4AHazAXAHJ7wokBkKA
	N3z+VpF3Rx39C9zz8r21+/xp5poNiEfXRXQbw5qUIpAVzuGT3S0u/B/A/NpEsPb57nM2EIGSE8+
	CvuiqCpbuAKIiHF2pOYGcy+rFVuJc+B+tq+lxPb/4iCjqzHH4SqELxO2WMupN7JDZcMkYdtQUpl
	uiIX7jm2KW9/rRrJGZeg7b5arHKimK6SHhMg2rvioUo1Jmaxcwo8/f59KBaVnlsBvYwcrK9GUCp
	I2324Rc+lw7AcrsThUpRSkhmSVdgPXKNyzClgvpUy7Dfpjh5h7CxNQuAJFyA5vGH8F3rb+8pVbs
	NHfeelts4TUAZl+8m3+6EuaROlIFDS+F7mN0=
X-Received: by 2002:a17:90a:e70f:b0:32f:98da:c397 with SMTP id 98e67ed59e1d1-33bcf8f735emr12159171a91.24.1760873757171;
        Sun, 19 Oct 2025 04:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6CW/q1FylEFNvM8ThCHmkSbr40lr1qt5/loh++GddqpGz+vFWHhoot6iHJZgB6N2Hj63VWg==
X-Received: by 2002:a17:90a:e70f:b0:32f:98da:c397 with SMTP id 98e67ed59e1d1-33bcf8f735emr12159146a91.24.1760873756692;
        Sun, 19 Oct 2025 04:35:56 -0700 (PDT)
Received: from [192.168.1.3] ([122.181.214.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de0c06dsm5025976a91.8.2025.10.19.04.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 04:35:56 -0700 (PDT)
Message-ID: <81367b57-f60c-48a6-8a59-7e160c312686@oss.qualcomm.com>
Date: Sun, 19 Oct 2025 17:05:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Modify USB controller nodes for USB on X1E80100
To: Val Packett <val@packett.cool>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
References: <20251014022121.1850871-1-krishna.kurapati@oss.qualcomm.com>
 <d0c18094-7234-450d-bd9c-e9f545de31e2@packett.cool>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <d0c18094-7234-450d-bd9c-e9f545de31e2@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FJU-mzBsRRl_hToY1QFSYwiPFgF5pNvU
X-Proofpoint-GUID: FJU-mzBsRRl_hToY1QFSYwiPFgF5pNvU
X-Authority-Analysis: v=2.4 cv=XuT3+FF9 c=1 sm=1 tr=0 ts=68f4cd1e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=COzVrc3/y9xyZPF/JXNSAQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uXidzf91Loiht4yY4DUA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNCBTYWx0ZWRfX6AAlhmOE++nN
 o4EgRr7/9BQYTjdl3Y8QtvEdYBheCI/iNys7DsUCcWqjoUdKlQPJJaU1qqgPYQZ4I3f4Xp+2yND
 t1UJ8hAWFGM2BXOLUbxxld9tr4rBxzXqe+SHwYwEcIWAlLyJBM6X0f2ye2ec/308tQOP1UUcCMk
 QAnuyhHtV6im/8J54QSXhjmQaez+v19Ol3fSCf+dU+oNwsjOau1ds4ZB8FiCYyBH8tqg83SQ3oR
 8FFZiPaebv7Yi+YmLBLSeNPs8t+EE1qQYHbj4IIMTF0hL54EiUgtRnNqXFPyjtfpQyB4ENaCz3d
 HILfg8W0KO9AX2yyjL+YdZ6Bc6AadJ5CMIMyESYt60ypB2yIJXCVi6RK3SM8C+lUNuEzQbJTKTl
 NUSpKyrLBNVeOmD8lUWK+Ak2/sZpcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180014



On 10/14/2025 2:30 PM, Val Packett wrote:
> Hi,
> 
> On 10/13/25 11:21 PM, Krishna Kurapati wrote:
>> This series aims to flatten usb dt nodes and use latest bindings.
>> While at it, fix a compile time warning on the HS only controller node.
>>
>> Tests done:
>> 1. On CRD, verified host mode operation of the 3 exposed Type-C ports
>> and enumeration of the Goodix fingerprint sensor on the multiport
>> usb controller.
>>
>> 2. Modified the dr_mode to otg for the first 3 controllers and
>> verified role switching and device mode operation on the 3 exposed
>> Type-C ports.
>>
>> HS only controller was not tested on any platform.
> 
> have you tested suspend-resume?
> 
> The flattened dwc driver seems to break it for me on Latitude 7455, upon 
> trying to resume the screen never comes back up and the system just 
> reboots from zero in a couple seconds instead.
> 
> I've looked at the code and I couldn't find the cause so far, but it is 
> fine with the legacy driver and not fine with this one :(
> 

Hi Val,

  Thanks for reporting this. I did test runtime suspend resume on all 3 
typec ports as mentioned. But I didn't check system suspend case.

  I will try to reproduce the issue, fix it and then resend the patches.

Regards,
Krishna,

