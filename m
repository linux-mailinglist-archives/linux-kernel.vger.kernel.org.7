Return-Path: <linux-kernel+bounces-833052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F43BA1196
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B6E6C1DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2267A31B11A;
	Thu, 25 Sep 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiQkNHlN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21FE319877
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826629; cv=none; b=PDbsQ8EJZUg+m7dLXsHYp+91YX9TTotCM1ECUiM7SOwzdUaAsY4bKWZ1UVsV4mYObFGPtLBD4IXH0DhTCpnxcg10WYQtFwiK4W72bhq/TjNw6T46CkLzckwl9MbJU52DvqAJSZP/MUyiE53TJNBY0ozwaElYQo/5D592VDgaygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826629; c=relaxed/simple;
	bh=ylHBJ6rtlBkpjTgpnnEaMYg7ft/c2V00QWAikEtzBGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAjDBSQo6Q2C227SVLqVH4th/Rr1AKGwmybRMdA+uwyZYkJ26qbvtwMsZYY6eWgYMp8V7By7eXskB/Dl//atijHfvqpXp90ciOB2jR8E6DnrW+4+AEf/GccsEhs0x/SlOto6imnJCNh0qFFGI5wiw83ATGvoDIICQ2s/iQLjm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UiQkNHlN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPbMM023313
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Fx+vqLkK1t4+LrlocVqgFiy8
	Ew3NNGJkgQixYPW2UM0=; b=UiQkNHlNiGCV9w+FDR0EenYDb6YBoXQqEYNTdm4a
	vvTHle28NPFWTOPblbDemqV3NFZlIJELgqt+scdItdet7cYk1G2ugKgJsuS2LwRB
	xjAKpazGaBMb8OQA33H1YeysjSQBGXf53fo2hGxdOn4b4DckB/ZdvFVYhF4YxMCG
	Qwjll6PlvP4mL78ynFoJ/tNMOni1tUCnKMTdBOLzdJ5ABkO97vwngMgMgRzH7M5g
	Vb606AigiqmKq2u6lMim/ui1XTVtg3m5wZzkKBxKSVe2nlWyJRPZKdSw6qgZTTCN
	d8IskO/6GPrHnGKns7gY5A5QR+7qTRIM4GBb+2dOhadE+g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qr2g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:57:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4bf85835856so35785851cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758826626; x=1759431426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx+vqLkK1t4+LrlocVqgFiy8Ew3NNGJkgQixYPW2UM0=;
        b=uUyhWU8K8QFzEBDFDTvu6Rfvkb0+CnTHD7wEaRbKvF3jJajWzGsm3tXWXNnIbIqbjO
         Gcwi0M0Q1LJ6PDQAq/Bg/QFEpgxy1JB0kHcK11gM0eZdh7azJ4by7zCtCKh3Zn0tp2ev
         e/JNjQP4h29DZYvDdsCylwx1rS0eo4BBm2HfVCi9wFtoALt0tM8pdvBCtpU4HIEXsSfB
         TSvUT4CN881qOwA1I6k60vPOfuiZ/nqMLn4CEluwpP4peMqV5sVmGg3WwVmTOU5CjxIx
         GstCHx6cDaRKjDCRxl2+QBup4Nk0UmTQdGtdzo7EWoU0n0YpIiBCwCYmnYmjIpT8MMP4
         uL0g==
X-Forwarded-Encrypted: i=1; AJvYcCUhXZpcIIvaTs9u7Rq1fkheU2TqUxupforcoXkT2EqH7JSlfc6BhcByJ3RRovwIP7I/EyYQsAJZssyRVMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDP2nw6xjAFvNemLc/1t6AvdQ5ORxwi7pYa1rQ7uC6gW0PbkBb
	qZN1hJrW6SO8eHEn34f07uSW56WBf+67l8wn/orHGzl1D5k36UCTUHsEjoKFKZD9dLXiEXHn3Wv
	0k0oZm6njD65tPI2iN3D0VwAfRthTXc77XmbRpM0DXhfVD1r9Y3FyE9+wTNb3Nl0bOnQ=
X-Gm-Gg: ASbGncvPOXE20NWA54T5zJReSpJSBoOHKq9zpZ9cbV4B5cO3LKYMHTWAzBBLSJqAl3J
	5RU64Mdx+Lh+aPIgYVqgcWLhjETqdtugsH6G53R5MW1sjw4u2ebvYBG3BFWEj8ct9Widmkrqpv9
	9gNjepATowVVisPW2RobEySCCABcD5KMFtcP/eugnZJQVrmEYDMm/jUXu9B0KqtFlcVFeYHBYVS
	Oj7LkqWdxgrYIdZnhAazIhdOpovgbKyDj6E4jmOX7AFX2PQZGdPt3yUu+e+loKHRTw1PxK76HZN
	RzwV0FSJV1mOh39II1oohQaW6csU25bgeFBObIjakXe6oWcmfcgyB3qYIn7nP33xOIOzLwB+ZOc
	iOcOmgwq48LH2CY8R3VY2buHW0bELw5068NGJCrlrPO5vGVFkPGsR
X-Received: by 2002:ac8:7d50:0:b0:4c8:5c17:6e45 with SMTP id d75a77b69052e-4dacd2449cdmr45034261cf.20.1758826625376;
        Thu, 25 Sep 2025 11:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1xeppu8xxZGxzC1p3RKdEq4xRw2e+trGwopGxSR+ad446eBQvH1WxLgENVQj54Ul3RzWCtA==
X-Received: by 2002:ac8:7d50:0:b0:4c8:5c17:6e45 with SMTP id d75a77b69052e-4dacd2449cdmr45033951cf.20.1758826624772;
        Thu, 25 Sep 2025 11:57:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139f990asm995397e87.38.2025.09.25.11.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:57:04 -0700 (PDT)
Date: Thu, 25 Sep 2025 21:57:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: Re: [PATCH 14/24] arm64: dts: qcom: Update the pmh0110.dtsi for
 Glymur
Message-ID: <mzoctelzfp6h2ezzkc3j7gnghsaf67flxqlvfhtlpdfxtddsvi@zqihmnygvdjk>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-14-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPdQH2jXcEY6ZpkmixvUt26SqdzYgDAiJ3RHMG7xkPyi_A@mail.gmail.com>
 <lcbcjpoazpwbltedkiqlw4l3aomwvi3qsfwvmwghb6uf5wvnme@kh7qdpunfuwr>
 <CAJKOXPcyhDdFW_u4YQLiHYj8gM7wYB-LOmB_PJs+5OOgn8WZFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPcyhDdFW_u4YQLiHYj8gM7wYB-LOmB_PJs+5OOgn8WZFw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: kg4oXDp70Zg-40bS9TsD_2AeSlqev1_J
X-Authority-Analysis: v=2.4 cv=bJ0b4f+Z c=1 sm=1 tr=0 ts=68d59083 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=zo-Yedng5-Uof10tyqQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX6SKWlPXzxlJa
 O9nV4V13u1QJ0QC6A52g79Or3BwIMFsAMxmmzEfY22pMYgL6xdW9pB/f0Qaq5f6WtD6VHjaTg6P
 iK5mBEl5eklq3VSelvDQaG7iy/mtXxxXdQDDUMS0fvCO5FzrqQZ2BzTiq2+7Ilms2trVOTt39Go
 XY92hOo1lZ451S9bduUtv5PklO6lFCDhZacrIlEyVL9FbfrTqiW4J5YAr69h6a3poOfksbZ5wVa
 bprf3AzfuEjQYMIqbujjGQmOVctj5+mrJ1AmBunhRrN5rlKltUeKlxAnnP8xFGOZ5g7ndW8ZqHo
 3X0NXZg0iTbYZ2Eg40yxRTa7T8Pf10cE8b44T1wXrnFBhWqmwTz+2v4glq25PHV3uevyzNffgnH
 aJFt0JHDUvQ4JpssWvyFofQsNUCOqA==
X-Proofpoint-GUID: kg4oXDp70Zg-40bS9TsD_2AeSlqev1_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 10:34:52PM +0900, Krzysztof Kozlowski wrote:
> On Thu, 25 Sept 2025 at 22:14, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 05:08:54PM +0900, Krzysztof Kozlowski wrote:
> > > On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
> > > <pankaj.patil@oss.qualcomm.com> wrote:
> > > >
> > > > From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > > >
> > > > Add multiple instance of PMH0110 DT node, one for each assigned
> > > > SID for this PMIC on the spmi_bus0 and spmi_bus1 on the Glymur
> > > > CRD.
> > > >
> > > > Take care to avoid compilation issue with the existing nodes by
> > > > gaurding each PMH0110 nodes with `#ifdef` for its corresponding
> > > > SID macro. So that only the nodes which have the their SID macro
> > > > defined are the only ones picked for compilation.
> > > >
> > > > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > > > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/pmh0110.dtsi | 66 ++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/pmh0110.dtsi b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > > > index b99c33cba8860f1852231db33a127646c08c1e23..4a5c66e5c9fbc35cedb67601f4568844dc41fbea 100644
> > > > --- a/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > > > @@ -7,6 +7,8 @@
> > > >  #include <dt-bindings/spmi/spmi.h>
> > > >
> > > >  &spmi_bus0 {
> > > > +
> > > > +#ifdef PMH0110_D_E0_SID
> > >
> > > NAK
> > >
> > > I already explained on IRC in great details why.
> >
> > A short summary or a link to a channel / date would be nice in order to
> > include other people into the discussion.
> >
> 
> Of course but:
> 1. You were there so maybe you remember the arguments, and:
> 2. I'm offline, using phone, not having laptop, replying during my
> personal time off just before merge window so any emergency time
> should be spent on important matters instead these two huge patch
> bombs adding such usage I already said: NO, don't do this.


Well, If I'm asking, it means I don't rememebr the discussion. And I
defeinitely didn't know that you are spending your personal vacation
time in ML. And if the discussion was with some other people, then
somebody else can drop the response to the question.

-- 
With best wishes
Dmitry

