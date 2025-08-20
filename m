Return-Path: <linux-kernel+bounces-778081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B54EB2E122
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341EC1888899
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A42E8B73;
	Wed, 20 Aug 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GuIKBIbS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7EE2E8B6A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703119; cv=none; b=TXRMBYjS7nKTDerXt9zdD0+BVuO8SWgbmbpe331ViovxE2b954M/tP8bCZI3ZlAthGbKLdROeGBy4IriLtGTRutousJgUSnvDxxw/TCPb5HfTLBJiTBeuPlHa4JvVFHAkBNa72OmJsJI9mGk3XCVZueqUBb6q4t057/NeQGRNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703119; c=relaxed/simple;
	bh=DtQjcbMNvcByxf+0zZY1naeHA3tbiB/xArykXaaUpLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeV+wwx5HjbyQk0A2VQggAMrzDA4It+sT+S7iP56ZFWRPYdMZCnrz8XA744/T/+LCPgNxiD7iUFqYn2rzuWobnudrK/RwBpKpIeoHSeVCDoOBpMxmNhclNDl5aYXLxOwhdDP4wkUpHXLGOmcDvn83y2/5jo9NOBgxPxaKLaQ8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GuIKBIbS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFCx0O021529
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hlCeQ88Snci0AxZIyBl3l26zn9aHH0uhjgkXgI9gCMA=; b=GuIKBIbSbDq7X2qG
	Tq2AtzWu4ZvKaJ6q476gogBr4bJL8h91UGpYCiYzEf4JVOqla8AyZd58F6fgMgfK
	563T8OSGnqqxMDTcyRcGEgb2UXRSworDMqXlmnS0rlkjZ9vm9cG2v+sgLQXWC69o
	i4nWQ/exP9Ej9kjTN7IwpZQcRFsmPTKu64ws/P4Qxl3j2PffoMfqXmsz6Phm452q
	B+OKWJV9FFfIRTVe+33/Q6NuVd/kYvMIsTc3dfi9qf5HygcxkJlUcvkJ78G2f7O+
	+Lx0W7H7c5oK+5wsEIISXZLi6A5x7eOQ7QXV0A6I9RGa3rq861auU1095NbqsvdA
	VvUoHg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdg0v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:18:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so1053586a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703110; x=1756307910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlCeQ88Snci0AxZIyBl3l26zn9aHH0uhjgkXgI9gCMA=;
        b=ggsKp3uyJ1RRFq0O0KHpZw9uZCm6HNfJXHvUrWZEFDj9+kwvDmtXEZmDnCSED1HDNX
         nSNkefZF+alBEnb2rf/2BvTeorik72qJXta11xd2UR7NPVARqZVrkyiLVv4lPiVhvHPg
         hUucAP0/yrR9vyjCp58FAYwBFsY/OqWXyn7FO28DFH3I/aXt6uQYXlUB+XpY58sRwlnr
         I9g8vjl9U7CBNx/eX03ZzLz/S7MnfDMxojd8IzLJScC5K1Ka0RCq9LCnzEUIGGzJAn9J
         hrUcTkaBZMljcxkXcLGuIGQxrjMccVm12+v2EpR2Y5skoqhmVYTTYlHUIB2b3rJcu1ES
         RGeg==
X-Forwarded-Encrypted: i=1; AJvYcCXuOB/oxhcYPH+/9wbnWg795g43gOOMQbxPcifBVgh7h3z8n4m3DjqHhbvE3n3ag5Q4VZT9tC51vDt3Z7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbo6mBWM5CFoKU35dtMr/inTZKD08vVpB9edWGxnRvd8P4rwSF
	kOgpYSpc/ZUorOuv5XwxDUb3WabRA39a4sBUEzNrxrZ0l2VgGUbm97Oqu7hY4ylCUSznZvjy5Gy
	4KoBLnZf1jSjZkhmoudUNNeFRaJUdsx96yiOHGrk6eeGpS+XsdgSXj+6Go+R9FleQQiw=
X-Gm-Gg: ASbGncsaCcgTNGIjrOF4FGi8WM3dlTA0ckYqjyPc1r88pcYZCd3Taet79fzt0T41z4e
	hXdBJEOum7gZ4Upaax8nmyXOYuHDcW48P/qDoHxMoa9/WSlzVAu7qu+ZTKTCe5oY+D0fTp2cIJ2
	iWIdbzHA0WWbxTu7uyyP/bqgBTaCotBPKKeTz/qNkBekZHcA0/dIK93aHAwkMREJWTLIWiWRUyX
	uY6/W7NtMuLH+7hNlfpfWEVZ+PVG8tazzt24M/ahC2IdXq8FpncZ8k41UnDMFr5IW3HhqVDvinL
	pv7o6cdTAJEATzzbsKizusqhU+QQ2My6ARZEjX33N9cBc/NfSrCfhAKKyzJjpgqBoDk=
X-Received: by 2002:a17:902:e750:b0:234:a139:11fb with SMTP id d9443c01a7336-245ef22704cmr37010715ad.27.1755703110130;
        Wed, 20 Aug 2025 08:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvgrjEM45iEXFzZdFgh90MepofgKG2tYDHkeGY0eIX8zylArW1Zrd7Fk7SrPTDwjAl/RsWbw==
X-Received: by 2002:a17:902:e750:b0:234:a139:11fb with SMTP id d9443c01a7336-245ef22704cmr37010415ad.27.1755703109682;
        Wed, 20 Aug 2025 08:18:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed50352esm29255935ad.128.2025.08.20.08.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:18:28 -0700 (PDT)
Date: Wed, 20 Aug 2025 20:48:22 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 06/11] remoteproc: Move resource table data structure
 to its own header
Message-ID: <20250820151822.6cmowxfsheqxfrnb@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-7-mukesh.ojha@oss.qualcomm.com>
 <aKWDXySSt57tXHVP@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKWDXySSt57tXHVP@linaro.org>
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a5e747 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=r3SgeffVVk19ujrvIvAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: C5JhuxxuhSLIbYggq3UYPRq43MwKa1Nk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX/2bjq0d1gYmi
 7VkdaatSIuI9nt9hJlVza7e4fF11SN2RE6Z6RRnmaR2LG8zGzeD0IVlX0Bg8jHmZtvzclW2pHaf
 ZCbKnubA/wUav1L5RDYysNc7aN1Msog7ScekZbox2dT5ocibFNDfmstbYU+mSFuFEUk3kRgFd0m
 umeWvkru37NpBZMhf8z45o+Tix0dn68iPBVfqL+6Wexj655SrRcrFFCDuLbuXDui/pXI4FraMmu
 mr+DgNTyCRW3NEjPCd4UoufTghnKbu0z8j+m5/Ah+e+m2tQKAIcGM7LymE0wk8Xpc2rFUcb3Qqj
 l8Vr7O3zd82DAAVLXJULhMRejqWu3Z327ysXUO0ayTjp4kftf/f7rnxJhnNpFkEiyJUUj6YgPhv
 zCR+GmSUMB0IAf/tD3r/fTrfFx1e2g==
X-Proofpoint-ORIG-GUID: C5JhuxxuhSLIbYggq3UYPRq43MwKa1Nk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

On Wed, Aug 20, 2025 at 10:12:15AM +0200, Stephan Gerhold wrote:
> On Tue, Aug 19, 2025 at 10:24:41PM +0530, Mukesh Ojha wrote:
> > The resource table data structure has traditionally been associated with
> > the remoteproc framework, where the resource table is included as a
> > section within the remote processor firmware binary. However, it is also
> > possible to obtain the resource table through other means—such as from a
> > reserved memory region populated by the boot firmware, statically
> > maintained driver data, or via a secure SMC call—when it is not embedded
> > in the firmware.
> > 
> > There are multiple Qualcomm remote processors (e.g., Venus, Iris, GPU,
> > etc.) in the upstream kernel that do not use the remoteproc framework to
> > manage their lifecycle for various reasons.
> > 
> > When Linux is running at EL2, similar to the Qualcomm PAS driver
> > (qcom_q6v5_pas.c), client drivers for subsystems like video and GPU may
> > also want to use the resource table SMC call to retrieve and map
> > resources before they are used by the remote processor.
> > 
> 
> All the examples you give here (Venus/Iris, GPU) have some sort of EL2
> support already for older platforms:

Example was taken from perspective of remote processor life-cycle management.
You are right they have worked before in non-secure way for Chrome.

> 
>  - For GPU, we just skip loading the ZAP shader and access the protected
>    registers directly. I would expect the ZAP shader does effectively
>    the same, perhaps with some additional handling for secure mode. Is
>    this even a real remote processor that has a separate IOMMU domain?
> 

I don't think it is the case and think the same that they can skip
loading and Hence, I have not yet added support for it.

Will check internally before doing anything on GPU.

>  - For Venus/Iris, there is code upstream similar to your PATCH 11/11
>    that maps the firmware with the IOMMU (but invokes reset directly
>    using the registers, without using PAS). There is no resource table
>    used for that either, so at least all Venus/Iris versions so far
>    apparently had no need for any mappings aside from the firmware
>    binary.

You are absolutely right

> 
> I understand that you want to continue using PAS for these, but I'm a
> bit confused what kind of mappings we would expect to have in the
> resource table for video and GPU. Could you give an example?

We have some debug hw tracing available for video for lemans, which is
optional However, I believe infra is good to have incase we need some
required resources to be map for Video to work for a SoC.

> 
> Thanks,
> Stephan

-- 
-Mukesh Ojha

