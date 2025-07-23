Return-Path: <linux-kernel+bounces-742368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B542B0F0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8AB1C837A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A2D2D9EC8;
	Wed, 23 Jul 2025 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UrlxioRj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6D289372
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268909; cv=none; b=qxnI/9pSP1BR2nNHqAfm1ZcT9FW4UWZdy/8Ce2DqRlwt9WPmYl6MAUXGJ1j5j7VUqjutfnhn5msYgDn4C+Ibm6Zre8D5QGH4RbYiL9D4uC9ocElEfjlloYwmu96Lwv9lw7nAgUZx2Py7s8ArlZep6fjS9iLsPuzRp5vsEep6GGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268909; c=relaxed/simple;
	bh=afusP6XF3NlqcMK6WC1ygO/UhXjItlHBhT8/8pOnPy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr+HSXwmeac+OZrgspYbn70gS/3rBcLKtrLOhWw1xJW5VtySuQl9eJIPZUYmzbJd33G74qDWurildRH9N27e2c9bT3Cy7lGVw6jg3rxhHC8CdTnluWprwlaZBIsrkL74lCgefzT9UOzXoykzWaAqJlgzFqOe//D7QLLrhvU/k2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UrlxioRj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9TwtI004801
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hv4tjDdkBfCtIHakQybad2DkErSzaDqc83VYETJQBNA=; b=UrlxioRjE/s6dc72
	Tavgb/7Ta5dEHIc4LWao9G9NtLRE+KHxnwE77SCEfOMklWVwqwHGMy5ecrifbkrA
	LfTAd9Y3owrJIGyYkCc/PXdV8+IOSOxwAcU0ueom/Ydsyft2n+Cj9ciwiZ9dPe6c
	mNjZs6ixQLNH6x7Fb7S0s6kYDscqbWxpTxVIXFWxrBgUffHh9rdRL7PA6R2tom21
	eOvB/7bK/r+F63W+qjxdz3cOHpoRxEHFem/idtdBOV7Jk85HAYZ6Aenyb255hZGj
	5EcIoenfn3P9uVRazVEIJAsciDEpiJmjEdOXhPtpYdS1fDrrXCkS9oYOB4z95FzK
	Y3DmKw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1c7ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:08:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70707a55da1so9973696d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753268906; x=1753873706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hv4tjDdkBfCtIHakQybad2DkErSzaDqc83VYETJQBNA=;
        b=idwsmp0BWF5S0Q+fBJGo38Hqglfy3M+F5bId0nS1nP3XgeVuMP+hN7mLoocvfz9lI+
         bI9JRMQWz7LzTdcSl04YcNb6yDpooqGHFV7FCeF/AzY49OVy7my7zOur2KWmlVCg33Ri
         pR1Sn812/ekTdJwfrr1si7zr9Wg/KUp4kVUeIbEq7grXb0owgqRaRUxCFY9Dy0TuNVY9
         ncZUNUsfZh7wlvpS7pS7ycd9KN2HeTlVbP36Cf34B4htgu//ROONOtKih6GSr6cH9qMk
         y5HGL8Qn1tbMJEfyre2v4tkNkGBj8mO78K3269j6YgS49g5Y/1foti/HnvDbTmVqMYsr
         lDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaK1sJmCSbz570UoM52EoIfXjcU4BXR05TIjPra+V5IRvNToiF1K6ti94vo0wku6qQLvAy85aMgyykpJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZ+QZNchwctEiGLRWOFUNVio30Mq7feJEwm49Dd9ni3+6I81p
	ApTm5dthuH5Iyc4INh77KacVlYPYp59UiLOoIijvD5NFW1nfrj6jFfnCFEHIIfAGEryEAaYJH9i
	eVzlP0SnXmn5TsLzdVvvy8svBJzxF1jIvxju2lbrQebyrkcdiHMQgEXc5CcabnX+Kv5A=
X-Gm-Gg: ASbGncvTV8Z+l52d+rgbJia2ChXAEBpgF9Q9+WIILV1OVFb/8+kDWRGVdjyNiEceEtC
	vNUDiUWctSgmTJCsgY3CWv2JOWiEz0eRc2fR2qQug6navMpLJU40NeQVERIaHTDFg9rXmq+45S1
	48JQ+lNsyA5t9+EhCGsFVnnMjJQxs3MohazCGsYBLaN+H1K4uEwtoIIVYb7OS3bsyk4XALjFFmv
	tQ9xDD7AHL2iZS0ATivKMLKCsuFTVoL/lFVVfawbQogzyw6U2NLCPGcqIL140faXbX/w2xL18Ts
	KfKZtls2pQcoQoSmgwNJXy+g0wCZGO9/h1z/euM9Hjpsg1XGvrFgSebL5PDM87kdRLjZvoLyo2O
	PDk0OoB53nkqwhtk+vb6L+CDOHLqc8FLVfxVZv+rBzA/UYlVw4ewr
X-Received: by 2002:a05:6214:21aa:b0:6fb:35fa:7802 with SMTP id 6a1803df08f44-7070077a62amr36099446d6.36.1753268905615;
        Wed, 23 Jul 2025 04:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwSQWjtXBuA6eHishG2gIiJ2cGaipMd1mJDi68fioFVtFVf/GzaJVerynAxuQtAMxj9KL8+w==
X-Received: by 2002:a05:6214:21aa:b0:6fb:35fa:7802 with SMTP id 6a1803df08f44-7070077a62amr36098166d6.36.1753268904649;
        Wed, 23 Jul 2025 04:08:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d9e89sm18897221fa.88.2025.07.23.04.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:08:22 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:08:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through
 secure calls
Message-ID: <3fogucs66bpupdwbzlhevpglxg423ub2vkn6zouakjtswa4tu3@drhgtfvr6tz7>
References: <20250722-eud_mode_manager_secure_access-v7-1-40e9a4569895@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722-eud_mode_manager_secure_access-v7-1-40e9a4569895@oss.qualcomm.com>
X-Proofpoint-GUID: -XIlBNVGfn1Wf647hjwa5AT7hSD5R9vq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NCBTYWx0ZWRfX1bqs4Q2JQ+A/
 n8FgeFjrP6wiR5V/3eWsPFdNbDsEniHe4FGRbHa2gnHUPDAGyvOTH3FOO+JnSGZrkIjGIF7l3Ub
 zTZcq7FObqU6ozJf5YUSXWNSTWjDvzyvR/BP+mpOZdIhw4aKwr0rTfozMt7Ov8/wKrS57ADyZcq
 CMoQI7E4/S+z0wrpULY7W2TQs3Nknt0EbvYQSKDYT4AzO6FGXTgzsMaZkGKjtE/kk0vPjbK7lwF
 ZgyR8jhzP+41WnpDXLevmXJdwERjy7DXIdTcCHDn8LRyExSl3X5n9FW/DgyqhS/gsxoM9+22JtN
 MmvYMPC/KURx0TmMRTilKZ0PfaFaSNdLaXynEzjJYUD5rp+kA/KjL5hNk2H5i92P3unisdShtie
 inlZOz/VmKI2oa9zAi4KvGCwKadyb59kGbm5yVY31GpSTrAchJbcmw6nTKKqd/QKBS1FUhsC
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=6880c2aa cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=tE-qeLKrG5p5ljmTaQoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -XIlBNVGfn1Wf647hjwa5AT7hSD5R9vq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230094

On Tue, Jul 22, 2025 at 05:01:53PM +0530, Komal Bajaj wrote:
> EUD_MODE_MANAGER2 register is mapped to a memory region that is marked
> as read-only for operating system running at EL1, enforcing access
> restrictions that prohibit direct memory-mapped writes via writel().
> 
> Attempts to write to this region from HLOS can result in silent failures
> or memory access violations, particularly when toggling EUD (Embedded
> USB Debugger) state. To ensure secure register access, modify the driver
> to use qcom_scm_io_writel(), which routes the write operation to Qualcomm
> Secure Channel Monitor (SCM). SCM has the necessary permissions to access
> protected memory regions, enabling reliable control over EUD state.
> 
> SC7280, the only user of EUD is also affected, indicating that this could
> never have worked on a properly fused device.
> 
> Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded USB Debugger(EUD)")
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Changes in v7:
> - Updated the commit message as per Greg's comment
> - Link to v6: https://lore.kernel.org/r/20250721-eud_mode_manager_secure_access-v6-1-fe603325ac04@oss.qualcomm.com
> 
> Changes in v6:
> - Propagating the error code from disable_eud(), per Dmitry's suggestion
> - Link to v5: https://lore.kernel.org/r/20250715-eud_mode_manager_secure_access-v5-1-e769be308d4a@oss.qualcomm.com
> 
> usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through secure calls
> 
> Changes in v5:
> * Changed select QCOM_SCM to depends on QCOM_SCM in Kconfig per Greg's review
> * Link to v4: https://lore.kernel.org/all/20250709065533.25724-1-komal.bajaj@oss.qualcomm.com/
> 
> Changes in v4:
> * Added error logging in disable_eud() for SCM write failures, per Konrad’s suggestion
> * Link to v3: https://lore.kernel.org/all/20250708085208.19089-1-komal.bajaj@oss.qualcomm.com/
> 
> Changes in v3:
> * Moved secure write before normal writes
> * Added error checking in disable_eud()
> * Use ENOMEM error code if platform_get_resource() fails
> * Select QCOM_SCM driver if USB_QCOM_EUD is enabled
> * Link to v2: https://lore.kernel.org/all/20250627125131.27606-1-komal.bajaj@oss.qualcomm.com/
> 
> Changes in v2:
> * Drop separate compatible to be added for secure eud
> * Use secure call to access EUD mode manager register
> * Link to v1: https://lore.kernel.org/all/20240807183205.803847-1-quic_molvera@quicinc.com/
> ---
>  drivers/usb/misc/Kconfig    |  1 +
>  drivers/usb/misc/qcom_eud.c | 33 ++++++++++++++++++++++++---------
>  2 files changed, 25 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

