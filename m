Return-Path: <linux-kernel+bounces-761005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B44B1F2E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C607A8A1B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9020527A446;
	Sat,  9 Aug 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTh+RC49"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74CE221540
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754724946; cv=none; b=Xn6OTpXaW/polSZ74cmIjhvRSDCXFgReD+582dyCyBDEGiFH24SsRjnkJuVbDaR6FmaWRB1bai7i4M5kXOmjgHTea2T3bJWIpHOmPMqoLpKUgL/tOJd2Br0adJQDMJ2RNLxBMJl8Cz+jEY98q0ffyGjvVDLUpXrm1CI7/lqyUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754724946; c=relaxed/simple;
	bh=E6AUHyZMMF/+zPZS44mF8zqFA4Pv6VLV5G4A7JiW9ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN8Mujp5VimiCauqhZ1iW5MKLK2f4LQx2SVvKHjx463EaUcY1z4OTdChCLjh6MUnDfDzz3T7DYzBfx58d+L90cyi22Hcmf9tismODODPuClFfbR2jTMbCSWbuTzn/9QxhIIoJ5xipDNOhQ0mjAYuwzBQs1BrnMYlDakJ7ZqHNpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZTh+RC49; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793Lnk5012616
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=793ppZWsrIij77Y1OuUluZp4
	P0smE2E/QLjBMEM3Awo=; b=ZTh+RC49HHbXdonFVTRS/yBg5wK6je48hIaNoPuW
	qoHu1xemBHvxwbSXjRFBSrPQqWFyfBAiLgRvly0sP7NgrsnL6ZNUK0c2TOp6grOc
	v1ffoKlsvVfrIBeR36UkTPumPQ0IFiWLd3LJzFXrVfSpHvMUsep1L+Li4GnWvy7H
	d9tIza/J5l/ZE1WRNA3cuxf9MTrbxaxWEuv61WCMAe1x81Nv7Q4GUr1ayRUDw6Zm
	9SWsiE8vXoH0gy59mUvZFyhwFYsdhOvUlD5mbsF2UXgHSOxOFgKIEgd0YsWYYZwJ
	P1shnX4tfyJ3LoZyVk8DblEzJgrTkDh9unHQtS9HRjSQ0Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fgfry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:35:44 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70741fda996so52549206d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754724943; x=1755329743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=793ppZWsrIij77Y1OuUluZp4P0smE2E/QLjBMEM3Awo=;
        b=QjEhewYhR3pqBWPR21jIAQqVPEBzdHaO9RwquHYIKsV63hgydRrKXqiZlU+c5iHEq5
         MFZhKTIZutigNb80j8CXAPaBIhUI9eQv4T8Agg4r1cuNA8fwSxeKD87K0zq1CdUidmQ7
         PZKORtQG8Xd4fcVZqVJfkvof9E3dA+XRdjO5ee6Z35qKEMITaUo5OW7IaokKNkJJkQUY
         wOVOLYESUSwxi9bBx0CxN2suvnEIqFg2vmlXe2JiW1HStPzTCPElyfmMMOgo22Qh1Czt
         SZq6MNhmHik+VdruAwbYUKCxDzu7lEIZFB0gUFrADG9MoQIFBkReJryfNgLWEhNUx8iu
         lyvw==
X-Forwarded-Encrypted: i=1; AJvYcCVjwI5Edy/YNZrmtVnxBmfEm0WOpXSNDV8LyoBpQPKi0Un3EE7RQZJFSvtDxe3rMT5gsaZbddIi96eOIrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnQwtAwlHFNUXZEnER14luzJf3tzd4BR2+2A4VbBTsrtHmtdM
	9Uog0b3NLEJrlBNhCUzkGGzeEG7Fsa+OexsPOn+uUcas7CZNsF5Gcz9KU1qYuHQM6xyYE5Seadu
	3pKM6Mo3CLlcoSsi4H55vpr47ojjxfWbklIz28sLKoS7RxXU8nC0iIzR39LuHC1hWJfdONuAKKd
	4=
X-Gm-Gg: ASbGncs3ScWfb+kSWXi6Eh2WHTYXRTrJsM9s2yZqi+SOJluayP6S0A7XtHj+ZA6jAuY
	wlj90MQDBLpKTqxkoujRwFcRo6o5AHOtWrWwqhfrOZ2FG1QJXJqpsc8E0ItJdO9lSMU3B4Bx5Vc
	1C+LpwVEvyo5zRdZ1AyXBiD9Wt9BDnF6GQksNYO0v3Og/LXIepDesiyyPeFO+hEiHYqEH+2ib+y
	VufFA9Y7C9MT1RKcvAyH0IgbH2z/Pfq1ghZHfCidH2Mxk7ZV97WSbFBZuMWkEJHqBMB0hpqmB4Y
	ZGtlqshozQf5wVStIDeLnQMqR9tuf4mxaAKqHvfY930dladelJB816esI6pijz+6dPmvEdBonpk
	2ffW2jqb6Eb7IfYz/vTKajiiO70uMdpoBs9gk1cn4PVHREmcPRU7A
X-Received: by 2002:ad4:5aa8:0:b0:707:6977:aa9f with SMTP id 6a1803df08f44-7099a374e7amr75943726d6.36.1754724943150;
        Sat, 09 Aug 2025 00:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+V3FN8kp+AjaeE6KYwRPxZyM6Hct2o3VLDBaJ/JP9bICpHavNGCU00WGCKhqaasJHXQECEQ==
X-Received: by 2002:ad4:5aa8:0:b0:707:6977:aa9f with SMTP id 6a1803df08f44-7099a374e7amr75943476d6.36.1754724942748;
        Sat, 09 Aug 2025 00:35:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9904csm3407575e87.112.2025.08.09.00.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:35:40 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:35:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] interconnect: qcom: sa8775p: enable QoS configuration
Message-ID: <sdp4moiiii5zjz7m7ysds3je4h66biuusilc4fx4bq2j4dw7ur@5d3c6gkk6wb7>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-3-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808140300.14784-3-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-GUID: DRjWHjh6-HeHsHt7zV_yBswRg-Fieq4V
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6896fa51 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=t2WmfeA6w6qF_8Xn0-8A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX1ZBe6p8LWlRA
 cHH97gil4BDLxyCgOpRlLfM6NNqb/JCLWAKILX0fXxPZi6FS7XFvwXAscPqhZjd08W8zluKuY7h
 7N8GLvpng1D2hNZAkD9T0Q/1BXbx38uL5RstbIqj1F6UfKOJWVZj/ulw3EiHsUgxfoy2bLmSfge
 ncuEv7owNFdyJslIMX/orc1bUhyYIAHKVnXvFe2Mey8cyyZZMXTSRf7HI5+1+nuNdSmyDnztXGZ
 hnAQ6U+u239H4t6U+K1JYRqZDIBSCxbjskEBAqGsVuzn1wqA5YlxmZxZ9itmmCQyDK0jQKC/qFs
 vV0th6cfPe74omIZac5sF1GXkoD0sHBf2etindXge8QZtzRMWms+/fPlfoZfWJ39jdAEg9PnBNF
 G8Rx5Ubm
X-Proofpoint-ORIG-GUID: DRjWHjh6-HeHsHt7zV_yBswRg-Fieq4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On Fri, Aug 08, 2025 at 07:32:59PM +0530, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefined
> priority and urgency forwarding.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/sa8775p.c | 439 ++++++++++++++++++++++++++++
>  1 file changed, 439 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
> index 04b4abbf4487..5bf27dbe818d 100644
> --- a/drivers/interconnect/qcom/sa8775p.c
> +++ b/drivers/interconnect/qcom/sa8775p.c
> @@ -213,6 +213,13 @@ static struct qcom_icc_node qxm_qup3 = {
>  	.name = "qxm_qup3",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {

Please follow the design on milos / sar2130p / sm8650 and add a separate
struct instance outside of qcom_icc_node.

LGTM otherwise

> +		.num_ports = 1,
> +		.port_offsets = { 0x11000 },
> +		.prio_fwd_disable = 1,
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
>  };

-- 
With best wishes
Dmitry

