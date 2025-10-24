Return-Path: <linux-kernel+bounces-868348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6033DC05028
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BC9C4EBCF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E5303A0A;
	Fri, 24 Oct 2025 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYi++WMb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA282FDC57
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293771; cv=none; b=o9sKdUY6tIdHJ1SDwSDUVjzs4H73d90cQo/kkbg8kULkBKk0TCqFyYdRaskLjYpYGHq+2gpKByPJFhPEkOQ7iOVR0TGEjm6HuESK/tQyADrSkhbhRqSDxf5YlskmzQ0MgNxHQrGWnJGOGyolXz8hGtFuGC+ohTNvTazKCKreNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293771; c=relaxed/simple;
	bh=gxc6NxuaGmoQ3aacveReooeKLh8kqG5U2uVKhVcqBSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGZHrppEUxmvy9/MP2rsBCSLAHHlm0X8WWy9qtk9L5KBTaT4N3q2Ze7yqHyE63Nt3UhUmNfxjGBi+qX2FniJTRH7qJPAryv5nyvqyqlzisCGwd3slAoQeXjouf4u8fy/YuvD+cuH6SAioKE6qq8aPT6lrm90UCOxhc/nNuWPcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYi++WMb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FLtS017650
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z0nAQ53RpdZhU/fF9OWWdO6pXQTZc4rhlNUi5MRP3Qw=; b=RYi++WMbMt3+m9wk
	0K6Wh/RSQyEjc/3aySXP3rkiv5OUancdRWFNSw+uYGJ8Nog3Z5ei7kgyDgpPxi+e
	pXke2RY/l3rRARFB3tUpvWueX9XHtOgxGe5BNawFacufSbcktGH5M2/cOfaC+v+g
	r+/EoOAX7k1Y562lIyXqoviuz+o+hxB7Hgr8uCuXMwSTVnDzIKwoJY8KKBgRGISM
	VSP5zXGj8uRasNtfUOuUsaa/dqBRcHIgfhVaNflrhczxGhi0OKCAPMkgqAmQtB9B
	Pd2Y4nEtvK43JVBUwYjioDx68WLbsUNzF1rW5Z7CQsK+rYNST3u4h5QgL/tzlL8K
	JOwPig==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49yp6k2jcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:16:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c262c72b5so4203846d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293768; x=1761898568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0nAQ53RpdZhU/fF9OWWdO6pXQTZc4rhlNUi5MRP3Qw=;
        b=lrWvUS/t6ncKyFHiOGX1nR5X/9STHbOYxtqTZx3wJXKT7aI6nIzdYgvSAvBNSUUkjb
         wA8sbnCjRr5odDrEQ9q3dvhtOSWFgBfE3Gl7eLAP+JSBJvBS3NQ2AITwHiJ19qLfHvAc
         jaMs+6kz2ZrRfGMWUpizqkkmkzrUWJ8ACtYxPBjR54EpWfQl+rgxBVnnvfqgv220Rtza
         A1MCHle2N4YnzxqpYcw6qExgyZU1TFB0EDFvtb9EQAwf5WalbqQTf8khP6ENOiiPNfyQ
         i6lep4Jv+oO+ex6gV8ema8y6ozFz0oy3Z2i1Rg5nxbkq9G6pR+fcp9/k5KCF2QWIFNzn
         NPBg==
X-Forwarded-Encrypted: i=1; AJvYcCUqC/JE//avpJaYb6aQmqgjPvj0ona5EqWqt08LvFe3ffXB7BSiX7ytvIROG+6qwNO3dZHIgq+JFOtbYoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVYf4xgWYZK82cCO9vKBsMFsfvUyx5UGP8Vqzt/8UK7Or5WCv
	rZMf7flvGY97mICJK2yKeN0yYi9xwdCbe2ZCZT2FVmfXBsHCHspjpMfhErzP3M25U0mXqvNbX7+
	Vl8xPVE87lFuC7Ghj7xA7Ypz/80KL2SJfovhDGjldeht5tNdafJ+VCrE/Txxz6Slqq2o=
X-Gm-Gg: ASbGncsQZfeOqWVGFtpcXSNQdh/YpQMokHcgoOXnViPqLVYC0MJQ9grh2N/fla0BzxR
	GoPczjB3vGkSyhV2wm+8fHSsBZMQVEMZrgD6cHAIG++Er2N7EFSqE4X4yvil2+zCXNVhSk/RjuN
	gH9Ibk/e2g+GDsb2kls2kA+yFDwZ8WpdNDiXqSWO84XIluqNF+4lhJRorzR9hAXhPftEbCxZ9C1
	kAyleMZhv7zSBqiKsQtr/bug5DD30CcPruQxaKKaV6ZisATvDh7eBj4RA63IpgMn5whs2WLChSg
	HedhJ8JHY3pjnrgVWIxpHX1KYq+t12S5JoXZ8yiOxJqzAAYeIMHNuwV8I6K3yv2C7Crq3Esvfth
	zaPzqyXBcC3AmqUk7wzwV48sY9je7SfPMbuU3kGcqJoeV4CaG1lk+jUVg
X-Received: by 2002:a05:622a:60d:b0:4e8:9ed2:790f with SMTP id d75a77b69052e-4ea1177d7a5mr113240721cf.10.1761293767626;
        Fri, 24 Oct 2025 01:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqWq0FM45W/CaXbxQcmVEVnt3Jm/2MAAbDo4P1ICuvT3VveOwZ0ajbZdmoXWa5jmDngYDjtg==
X-Received: by 2002:a05:622a:60d:b0:4e8:9ed2:790f with SMTP id d75a77b69052e-4ea1177d7a5mr113240481cf.10.1761293767170;
        Fri, 24 Oct 2025 01:16:07 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d513199dbsm477760066b.36.2025.10.24.01.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:16:06 -0700 (PDT)
Message-ID: <f90c16f1-6991-4968-978b-1d69d7b13d85@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 10:16:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sdm630: Add missing vote clock
 and GDSC to lpass_smmu
To: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251023-qcom-sdm660-cdsp-adsp-dts-v2-0-895ffe50ab5f@mainlining.org>
 <20251023-qcom-sdm660-cdsp-adsp-dts-v2-2-895ffe50ab5f@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251023-qcom-sdm660-cdsp-adsp-dts-v2-2-895ffe50ab5f@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEzMSBTYWx0ZWRfX4h5il+8LYGz1
 DgBQ+a8RqSXy7Atg42/ltEmge3XNIItS5UzR7Vv+c+yfajV3jICIok/9yl5RWvD66DTss7Qh1ap
 uX75DqWLXck/h/22yF2C9wz052E5IFuT+h8RdvpJwp6aAD8bgtGR+CZDTrT/UAydzfcZRoR9bDK
 M/9gmf2Zog2+gBQ7LLQyNav/eVz/Q3Du28D7M5d21MD244j2oSK8SuhJrlttoa8TK5A1Vd7XRsi
 rPwh/1JNRFwH3JH8aHPmGwVlUwZL+RZqQRWjPR5hUnobE0sku6MTy3rT+JZ9CXxM3ypDlXqpKBc
 FpSdDPbBAkFsVVUU3GyZJKdTdZVMbTcjwkU3Phvco2OQEogO5os9qsZ0wiTrxPlvXOlotDr1Xep
 zllbfyMFemcYmaTF4fRndslZu/51dw==
X-Proofpoint-GUID: jbG7d9auokRX-l7EAuE0Z7hrpG473gSd
X-Authority-Analysis: v=2.4 cv=bL8b4f+Z c=1 sm=1 tr=0 ts=68fb35c9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=I8aIJtlCLNSO61fVdIAA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: jbG7d9auokRX-l7EAuE0Z7hrpG473gSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230131

On 10/23/25 9:52 PM, Nickolay Goppen wrote:
> Add missing vote clock and GDSC to lpass_smmu node to allow FastRPC
> services to probe properly.
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---

"to make sure the requires resources are enabled before
attempting to access the hardware"

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

