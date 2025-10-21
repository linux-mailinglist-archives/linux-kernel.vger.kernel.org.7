Return-Path: <linux-kernel+bounces-863758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB1FBF90A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C80404E46FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409AE295DA6;
	Tue, 21 Oct 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8ffH920"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7B2701DA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085448; cv=none; b=mZz31A8iFzZD2QQ+I2DT5eehVqixHwXFrPx88DByLYLvMUf3Vbkb2JQVyz1AC5jBihXtrV8BHKDs4uCoC9Kf4Sk3mTHabFErIZAYhnDJbQ25L4DQ83BOAETpwK9fFJkWEhMmaMYlfT7Fdv/aSdkpLnDwxdMMxnl4oWEwG7oYXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085448; c=relaxed/simple;
	bh=VjKZ+Wz+UTUQ+T+BFxRHjXMJn7immbv/KaLWu1NsK/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BttyW3lXptqWxx4FMSyUhLw+yP2bzxVu4qlc/DNk28S7E6XdfwprQVfDUlqBoTRl3k/z0wgxdW3Xas0igLEFa+REUYVuJe1OKGzNGD9t8g/e0C+dtqsPEC+nWqS8b+JNAVjq8Meq9Fy25LJ6hjqbYwvv3hQHahSDbZTPEG4MNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8ffH920; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEa6x1002484
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lIEwbkRaccnwSfJnrPULJgVj
	h2AzE4jEqLw017t91ks=; b=d8ffH920y81sDXJTooPV8MnGy2hX3Nb3a4bcPr8p
	OZWFwu6r9r9tQxtxajXn+en3N7hLPQENOQg81bu+Ce6JwkSSNrHAwf5f3XZUHnTh
	sg5xcQAIltFt9ir77juHGe7hxEnVWxTsFkKWiRpsSKDRjgfa7ge3hxKCeAsoWjhc
	x4e9fulDcne8w/QxMZ0NvxvsKPPBmXw+N5tUSqBZTh9f/84Y/lMkEgbau5/RQQxr
	NLebsg+uc8oOFpsTnQTHh3nrHQS3+TOpQCmvUWNDpkeGoJY/hARG2LnvbJsRsRQw
	g+sjF2/9M4dD2zqzU5yTiOIoJfLcpRr8HxcLXHyHSpy+gA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w805p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:24:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8984d8833so15742691cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761085444; x=1761690244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIEwbkRaccnwSfJnrPULJgVjh2AzE4jEqLw017t91ks=;
        b=tIRquXd+VOWbDlwo4ObJNrRTCUF02yOm9fjJXRdrMnpIiuuqoDDPSgjiqpaC8Nfa+A
         hav9pxFScP0eE2Kx2WzHEgCiNK5JR0lBO7zqD1zHxwnOii2idgWH1hM0rUZ818A5nmFP
         XVjWNRkDsZxy6jOx/lzRz+2TglncU7iT/2O1gBU2qzHL8+ZFVkSJD7jMYm63ml82S9Yz
         y20AhtIUXMoLvtkOncMK7hpRtptPnlojU66sJHrZt8d2juAttbq2ZidMqiEC1ls7E+pr
         OAqXwOCZI8eM8Kr1Y/7hhkeIyctZt+x5dWoW1Cilu8BkT6Y5kiXr4vVtiPNL1ObmiW8Z
         5SYg==
X-Forwarded-Encrypted: i=1; AJvYcCVnFZXiWQtlOvciAweTG9Ek4LKaBFaPqL1cjQCT6bTz6gMuB9QKNPWBdhJxalWKe55iBp1yOOk3kfjMi/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBMcjHfSu9dI/hZzP5gCCk+WIUFisCrOgxegKO2ev6DDUOX4G
	rmUVRpEbfzy8aj06Ka+pgEWJ9rE7Lz1R5cF/Y9DHu2dQsgGz4ffs7m5Shicvr0J12TxgAS0O+l1
	DlgXj6TXyZEWjPyZXtkfj6j5qRNfT4nGKuCBhOLhlU7TAO46/tc9EkJK0IN96ftCPlb4=
X-Gm-Gg: ASbGncuj878+tXZkOXTVoG+ZniVXpGv2HBuejecgbiPNC5/dWEL9Q32jajQsOj9jg9j
	YIk6YcVQW0ltM+ey/chpiY7OVcuwVmm3+RXpWSEcrw+j6+EabAt3a0/D2M0/8o8Bn0/8Ug2D84X
	fawSoWgg3iMrEGWfobp8iMxFbIxYOALX9pKlyzo25MdBueH5ipu3eVMFOZBHano4UZlj5DAZyHT
	wf7h3c0uzEfk7jGRjepsJ5aOB/1AKjnIpjv9kKn+R1cGIQoUHKJSkGNIB8BhEB9f3vABtswi2Ez
	XwRpKydaPZ8dRFIi4wsARXqcW29OOEYUUm0Z4B1oi+hPYPj5fjiY8Re5feUFc1/MtOyJkNyyrZg
	XqCUDjfjgOBK2vw7PLCSM88Ih6FjvioGS9KMKCjFhnSlNmR0AFVz+GVPsU6dbDxxDviht2GCniP
	JO/1+SvY/cpl4=
X-Received: by 2002:a05:622a:130d:b0:4e8:9692:edc3 with SMTP id d75a77b69052e-4e89d3e6fcemr230204051cf.78.1761085443943;
        Tue, 21 Oct 2025 15:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO2dilNu+3Zu/5DJhOTiCUiS3fXKtfJ77ro3v5QwU8FFufub12ZqYiI70pcMuWzlO7TRAAug==
X-Received: by 2002:a05:622a:130d:b0:4e8:9692:edc3 with SMTP id d75a77b69052e-4e89d3e6fcemr230203811cf.78.1761085443542;
        Tue, 21 Oct 2025 15:24:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591eb14a5d7sm1234007e87.53.2025.10.21.15.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 15:24:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:23:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] regulator: rpmh-regulator: Fix PMIC5 BOB bypass
 mode handling
Message-ID: <te5ubj3byqxfp7mivsmwpcfjdjb4sds5cjhybmibjiexjehswp@zbppl7syod24>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Z128Wn6Hbh54VTDKLfRop6PJRKOiXAJe
X-Proofpoint-GUID: Z128Wn6Hbh54VTDKLfRop6PJRKOiXAJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX2y86rf4dQ7a6
 2Pae2I8KEjsG9Kan4lbjoNU8bfZ4nlmntfNq7IGtxe+eWb+cT5uOg4mpKcdJZGGiDWYJdNX86rl
 LmORqDkIBC7kHWilwd3yPYMQZBTTMqWpW/JxzbY+xUuBGwriZGHOq1XTGzSbyoSXVgntCegfKM2
 j67qfUMMlkRrBIpoq6tfs4l+DAqFZMs9q7UlsEGyKEW7R5jnAHbTm6cpD8H3hROpuNP+X50I3Jp
 zOSBKLmIPpMWiMX3R9QYXhGguOSEH6iwiNCnTQoYxFpd417FMjkvURN7ZEXdAyJzILjwqJ5v9tu
 62BULoFaNcAe//jYk35G2V7YcZoK3iX0QGXhR/5Z1KOAQTtgB1vOTdyg1U+S+iqLG7fJxbob8g1
 K6eino8YemNi+1LmBCmtcLVtdOWXuw==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f80805 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=pnqgtF6Cvftx_ToyVugA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On Wed, Oct 22, 2025 at 02:38:53AM +0530, Kamal Wadhwa wrote:
> Currently, when `rpmh_regulator_set_mode_bypass()` helper function
> is called to set bypass mode, it sends PMIC4's BOB bypass mode
> value for even if its a PMIC5 BOB.
> 
> To fix this, introduce new hw_data parameters:
>  - `bypass_supported` to check if bypass is supported.
>  - `pmic_bypass_mode` to store bypass mode value.
> 
> Use these 2 parameters to send correct PMIC bypass mode that
> corresponds to PMIC4/5 BOB regulators from the helper function.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Also missing the Fixes tag.

> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry

