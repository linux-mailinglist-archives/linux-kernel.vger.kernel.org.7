Return-Path: <linux-kernel+bounces-730886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6AB04B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8213A0FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3162028540B;
	Mon, 14 Jul 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QZrwIfyp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7D27979A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534051; cv=none; b=eY03SGQzCDN/4c4lWoSnu2yZmaWGEb0kF0GqsSfh8tnk/1qZdL265vrigMMC8tFN6pZEnXJwSp6uBJM7L4EOrf77Q5mslYbhQtXmLvoM9IuVRIOimXqLmAmWPF9bxaRM4TKfe9ywLgkXFf6+mQTAUEAsN422OcA3oGIHQHXlEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534051; c=relaxed/simple;
	bh=e+0Cmmr4F+K/R2UeN2Bly9ROfgx+WBmlS3RH04i8bz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcSCPqupN1rEdpMMXz3GOfQ6JMj9r120cx4nbjUkvA1/H0bhHARPbUckfhJTmTwm4Fw307/ehRok4POZ45SsI3RivohC6NFI62IJMPpuCvFJZ9e8SPRD9GKssR3cQ8w+0rQWo4VXHpw/Lf6CmTuelwf+1v8ygU5/KFVRVZM93O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QZrwIfyp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EExW63024867
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1NpEqFQILBPEuMCnazZYraXh
	kj5p8G0m5fq3n1OtqTk=; b=QZrwIfypgs2cF/bTIEwT02VNVdPwhEdVQsD2FQmR
	m4B6NfTRZhLE75Fx+uIXpbxxo0bCY9dckW9DLuWYVoSq25QtI3fd/U2N3CQZ714c
	udTF/vgm3Xv5yxrjO9ipCs87hdxZTQpybkCpqgcGQKD0eHn5+gOsoV9GpSwNBCO/
	3FFg5W4MmEXo26yQN7zosVztTe8M8Gz+RMJ5h7TZBZPaHELGfsKVMJxZf8o4QF6p
	qOTb/GDVMlLbNnEiF6rYcg7m4Y8Tz6fiWbBPIPvpMJZYz6Uw5GjphmCuz8fflTVv
	Zcm9UXd8n4FeGiUunpLT8kE6o1q0ma5geqOGhbUaaY4sBQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut61gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:00:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7dabc82916cso892863385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752534048; x=1753138848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NpEqFQILBPEuMCnazZYraXhkj5p8G0m5fq3n1OtqTk=;
        b=Ep2/bE+XWXvI2e2Uk9FlgjdncM984c1hapmsRTWvbRRHs81C8DudXPWU70D6hDDS1E
         Nep0NWZURPPPMViktgzmKrOVAbZTjswrwOi7BZrDdfmlYRMR5oH4OS1p1HVehe84gM90
         wuW7ROfDjbVugoPihoFQdHdtfzbIuwZAmn88KQ1m/9Ptdpre3djeCxr+RRANplgh9VVC
         sVdbbHL2z7uFQ+VfEp+Dna02uTQig5tQRnfX5+P3POkTBSYrTKD08J3SqslTJm3e8X1s
         GjJcz10vvpZmpX984w9YvbDclgor950+yJltD6fmWtawwSYg5/SNdXr4aJmPxb9E2PTn
         7fQw==
X-Forwarded-Encrypted: i=1; AJvYcCV83zBzxO6Oi8MePHPqiyw/dyemaoilkTwHWqntY0peTj8mUy93gTdmBuiR2No/GAZkqgtyWdsbjgzscW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymwRFOpL3jfWYeNp6DYVJcGshMj5OEV/vPn3CK2HplebwGttoZ
	82luGHjwvY5w8eGhx4oNNCeMx0SKMKuJYOpOYv7QVhxrli6CeWlIZ1S96QjAdBnLxGcO8uG4pdF
	bByGtZEiwfFBpDV40XRdUX1I4AqiKJjwYq0UDgfSTlPkMHAkqtCxUbHIa200W+IYaAgo=
X-Gm-Gg: ASbGncuoBWyWd90pw1ZaQqywdIUqSsUvENPnL7bRUoCnzQYC8YYlFb1KnxbDig/7HL9
	UvTvzXF3154zRa4SosfoN2gQuZtdGNFB1ODzKlucLFMWUi+nOCradcWup0b2Ils0AzX8VVZ4miR
	SuPSSXDFKpa3ceyMQj89JdRyFTzENnOxfE+yBODgDIwPivRTcz88LckUuHab5hIOOu0IxqEWtlL
	NU7YtSnTEPa9aspQ7r9iuEeTdBbirikfsL/tNqXapxroGhKYEfYAB3w+MZqe9UQvFfk8jYrhN4E
	WjCQsKwNEkUk3K0ghrF1Bp4GdevKYNa8+a1usLvNlXH2nykDS6M3WPRE8ZtD5N0lZiX4oerKov1
	So8nxD9YBHhThP5+rTNx/g0x+ym2iA4Dj1d70QfrFYosMG0TxfPt1
X-Received: by 2002:a05:620a:6545:b0:7e1:f37b:4573 with SMTP id af79cd13be357-7e1f37b49damr780724085a.26.1752534046515;
        Mon, 14 Jul 2025 16:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTrO7EpByqKu8tXqsr6N3T4ZtPO2ul3BlN+85hAiFoRktXmd5xVQeQVO/Gb1MOMi6eUoHs0Q==
X-Received: by 2002:a05:620a:6545:b0:7e1:f37b:4573 with SMTP id af79cd13be357-7e1f37b49damr780720485a.26.1752534046086;
        Mon, 14 Jul 2025 16:00:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b79b6esm2082956e87.230.2025.07.14.16.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 16:00:45 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:00:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>, krzk+dt@kernel.org,
        quic_dikshita@quicinc.com, mchehab@kernel.org, robh@kernel.org,
        conor+dt@kernel.org, konradybcio@kernel.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] media: dt-bindings: venus: Add qcm2290 dt schema
Message-ID: <wmbw55r32ep4feu75mlv4mufdnko6s4t257dus2asi2knae5zg@gkxku4sm56rw>
References: <20250626135931.700937-1-jorge.ramirez@oss.qualcomm.com>
 <20250626135931.700937-2-jorge.ramirez@oss.qualcomm.com>
 <76492de3-c200-535a-aa1b-c617ba6146f1@quicinc.com>
 <aGuOMrjfQBNYAjmF@trex>
 <aGuS1X+RfX38krpf@trex>
 <cce7a38c-a90b-4f9d-b1cd-06dfadef2159@linaro.org>
 <aGuXcWpYWWGb8w8i@trex>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGuXcWpYWWGb8w8i@trex>
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=68758c20 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=QGR8u22Tjq3xk0LboB4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: MoP6oUntBSeYHB6PMU6KHgfdozzcS1FN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE2MSBTYWx0ZWRfX+irn9GNzn+7H
 GTqzogWt7VCl71C6CZioFbAQP0+Y0KIHG2m1d79jjqe3DpwcaoA2BCaOHVU8UshIWpqWYMBpNWi
 SFZeKruxREsas2Zx3QXNatEK26igg1N3fy+KqAuM5zkhDT5OleWkV1W0f+kS+vgo8VjDl8BTCG/
 C1PZGNFP2taFfxKDRgn1jcK8u95UoYZfq7CjNX9oqGOQwXpXboDIinDPGY/oTcLBByS+MstK+ED
 Zfytj0lpXJHM1apQGWWaT/6ZjogiF/GiMSoXQ4buLRET8a+XKma8FMBarOC1x6q4LwSOUQBzDDK
 JVKwoz8iEyZAw8i6a4lSiDJjjv5FRV/Ya6FASBHrZvK7VihHpijYQ+cnuwoou1BHbgosgFYWkJs
 xduHA516x73rO2sBVmhT21o4SsaOK4fRLk3Pa3yeU0dDk+Gs8vY1D8veS4ZJxtAj9dTtlNGx
X-Proofpoint-ORIG-GUID: MoP6oUntBSeYHB6PMU6KHgfdozzcS1FN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=827 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140161

On Mon, Jul 07, 2025 at 11:46:25AM +0200, Jorge Ramirez wrote:
> On 07/07/25 10:29:56, Bryan O'Donoghue wrote:
> > On 07/07/2025 10:26, Jorge Ramirez wrote:
> > > > > > +    maxItems: 5
> > > > > 2 should be good to support non secure usecases. 5 not needed.
> > > > ok
> > > isnt it better to just leave 5 here - thinking of the future support for
> > > secure buffers - and just update the dts?
> > 
> > It should describe the real capabilities of the hardware, not the expected
> > use-cases.
> >
> 
> then five.

Just list all IOMMUs, if we know how to handle them properly.

> 
> > ---
> > bod

-- 
With best wishes
Dmitry

