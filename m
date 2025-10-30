Return-Path: <linux-kernel+bounces-878877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D273C21A62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2F7435052C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EA1374AB5;
	Thu, 30 Oct 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m6mN25O1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fBsl6Q4F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463A374AAC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847280; cv=none; b=LtoU9Q9juF2Pwg14eG7ULCNuR6dlqij6fSIyz/pCUEIoQE0qCXXfpFJnB9JHVItNFOoIbLL8nw2a+OlwR+9j2jOFR5WNIhJyI6DGBVr549bm9qHQtqfXcbBve+DPf3QNtb8vgM/MjveGxGWQzS7cUEZIG9P2odQceM3pMEUJvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847280; c=relaxed/simple;
	bh=Rn9bRqhzSNXcchPQcrH4b0rYlXJqIKlgZkSe44lo8DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgjs47I1E7tZMkfwc34hMwRjBlmoSBpIpH4K5lpqVde8hhJwJdg2QdvEIDUikSl9xb5SIIZX+Pnaa3ots5BiJ58bagh3zQiWjcytkk5QDPnOA3bRmNbgoLFXkcYXfBWUkgo/94k+raNY+vzl6eJlNfiPYI5OkIz16kca5QV9qRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m6mN25O1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fBsl6Q4F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9TuLN1994489
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cXV5bK5NXAnWN8bRl9mITOxX
	zPOm4995onAokhRKwyM=; b=m6mN25O19Y4bcqLCtKcVEF0B/y1gxRwia7ULE0fq
	qYPXfgHrA1nctu1RYAFFx5yrQNs1wM304UEcfyB0cZLP7H1HBTTBecQ+afqCWy0F
	CQPWRKpivCGuX5490S5PjipEM8H0yzqLUns/rYD0f7igFBfUecFUlq/7VbE3cgr9
	VvTC82IB7llKV6mX+EyUnXbBeMajf9O9sc8MzYq7O8ok7IL+OXOAVyZtbqOE6LO1
	cu3ybhDOR8s2uacfCdPvKSB1OKP2E+q1gYKmNt7EOvTFwjwwSv5yM/0PB/e4NHRR
	6ziRF0kQ3Ebah6qHgtIv3ap2ryn8BrZDSLVP0q9lqUqpYw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3wr72s8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:01:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8a4c63182so35073161cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761847277; x=1762452077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXV5bK5NXAnWN8bRl9mITOxXzPOm4995onAokhRKwyM=;
        b=fBsl6Q4FtkIgEl+tFn+9YU2jBrz6cYTiIcMfRS4XUNnmSzXuP3ZjUIZFWn1bJak/4y
         IzRVAzG1EjJbnat9MFuVE3TAANBuHXF934lSvwL00nf8s6lB69pTy8TimlpWaH6b7Hq7
         0QM9sUa1kWpMuYAdMe4R4nbzKOO5GOg5t6OjEpOMyP4JmBT/4e5Q1hxdvY541Ol7A3a/
         UKyKCwMAmBTUSKBW5exg7kwLnIVbjGLdpkTFTxXZnoRF4pYXPpvItsy51uszK0DCNWMJ
         XAEY/9FyJGn/3VX5DYjsr7g6lt45GSin1A9k14KR8raH+ZiSuJiuJLNjc3oOcVs7IJiG
         myxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847277; x=1762452077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXV5bK5NXAnWN8bRl9mITOxXzPOm4995onAokhRKwyM=;
        b=oSY7X9bcnxiQigwLvjT/HuVRIuCY0NqmIQMQ1p1VEnFNyVFWd/U3e4rzqTAznL1CVg
         GEzFq1Vy+TGI409Z+bwQakXa029csImprBend/Wm+rZAr3zt9aJrSvdU9/ly+poOZZS6
         YJzflsU0RmUxTncZnHVSMiDk55esQCiEhHb2xfZ2fN0odvpPFxyCGicqbMTJWOImDB9g
         6ZR+AHmpFaeD4ZzdBB79zOD/GyJoYZc22HRhrS4YQPKlH63EBBdAccnV/GahX9fehfVd
         wMYrxy2uxzBkddDPv0yuh52gDgKXuhTnoH7R8qKoe8hvvGvhbsEwzStsVN7f6vCxlpY0
         wTCA==
X-Forwarded-Encrypted: i=1; AJvYcCVrT5mPFofKeM6lHkVWW4MXngh+uI9L2HmkhaaIMX+j72QtV7NaRazPxODlavUUDKa4cnlaUZwVdEh5+lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrYyZgLul7kXszj7BVePIpSkPydufrqRdKJyid0dRGtJjjZeZ
	s1hJPG1I6/wEJygFKhFp5cmkAuzuIoWJ8jIwrRKt275LetVbb7IxHGClP/4tXpOX0bTIWU9eSy1
	shAP7lOci/EZwD9HQ/Yn7jSt3puTk4P16QS2o4ORaDl8VVYp8fUFFiJ4Meix5m9KEf64=
X-Gm-Gg: ASbGncuf1YjN3vr7yF98WafFNW8GGZ+kxyEaCxUBcH8Ds1F2DkWA0rrwdLlRggFf4AD
	S4EY2exolx9Hv1ienkI3XILPGAYtkphtrluWTbiLhhx2/HsLcMPCxdq3+GDPqackfqut03VS+tS
	QAK+91LeXy40oy41azZ1KPvDmL5j9flC1u5soMYqzILbBOzxrKzk1yzBKo8Bohk+BlW8CeAVI0/
	zoWUM6Io/CB+Q8xD5Sid5w0eSD+xDAjZ60z9l7QkVjNRoc5x54qIOV4a3H5jylJwkxP41r/v0Wd
	SSRjWZc/kGSt6waUQTEuo+nZ4EE52Ef8a0mIx69rkxgVrfjnJrK9O6ejtXMWy0uMWrHE7Wln+fu
	4XD/wtq7vfXXF05fqhSs4+8UOEYwtVhUrT7y3yaXabVxxn4/s8JJ7e4NozZ7RTff0x1A3ypbBjl
	m5ul8CHvgpJL71
X-Received: by 2002:a05:622a:40f:b0:4e8:a269:ceab with SMTP id d75a77b69052e-4ed30d4ecfamr6635401cf.5.1761847275154;
        Thu, 30 Oct 2025 11:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBsOQjcOvRjMP4pTZJOPkX1Iw2AZufQNpkNP01OrVkZ+/BT71YfbXhtRUq9boF7rgtxSZZrQ==
X-Received: by 2002:a05:622a:40f:b0:4e8:a269:ceab with SMTP id d75a77b69052e-4ed30d4ecfamr6634351cf.5.1761847274420;
        Thu, 30 Oct 2025 11:01:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a1614e1edsm3259121fa.22.2025.10.30.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:01:13 -0700 (PDT)
Date: Thu, 30 Oct 2025 20:01:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
Message-ID: <mlhohop2uifsdo3qxxzmuxbkjo735hdw6xcosvkmsx4eskfufz@5otklefey5k7>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
 <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
 <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
 <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
 <einog245dsbqtx3by2cojyzmyctk2fffpwndwoe24puwqq4fta@cu6iiidxqgr4>
 <0291d0f2-483f-48d8-8c75-f1bbcd1ab18f@oss.qualcomm.com>
 <ehgdx7av3jewowkvtsqrbnsphgxm5hryl6n5otnapi4xneldze@gcwvpssisv2x>
 <aQGHyN19/a/tl0BH@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQGHyN19/a/tl0BH@yuanjiey.ap.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0OCBTYWx0ZWRfX9hYg3us/SYGy
 SGmwrdR/xV1Z1KVMMLPIfA6YGMcRBs0e1Lc64T6+RY9jRSNnbJZKl0rsQv7PwFvALPNhgd1b3z5
 JrrQeEpY6yL48hxjSr54KDsyRVJ/yVMdPtVBI6onJUbY76bJhDSdz5qzQASlcRn3K4usjXGVTgp
 o9en8adfA2V1U/4nKRGijqQlyiOqjE2o4TjCx81PrJpQwmFtFMjiEskUR6fdbZh20i5uQZ1Saze
 pAYHumoCaCuCcT998IX6WNQKd2+tFWSR7kgWxHnTsl01fVsBa/2HkpROgAWRNRFIGvFVNcN/fhG
 n1sFRIjqsrHMgrAWjeEBddCba3QfKbm+aY7f29vmlltE1U4eEklReqaHyleLcIJVWCqLZm/5bME
 KQJSu7HRdRCO9dmvMO667+nilmsAfQ==
X-Authority-Analysis: v=2.4 cv=P+Y3RyAu c=1 sm=1 tr=0 ts=6903a7ed cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=dW72lhU0GKDYo0j8srIA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: xoBCXwkn384dZv4sWBDmQDXMlxOt7619
X-Proofpoint-GUID: xoBCXwkn384dZv4sWBDmQDXMlxOt7619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300148

On Wed, Oct 29, 2025 at 11:19:36AM +0800, yuanjiey wrote:
> On Mon, Oct 27, 2025 at 03:29:40PM +0200, Dmitry Baryshkov wrote:
> > On Mon, Oct 27, 2025 at 02:20:26PM +0100, Konrad Dybcio wrote:
> > > On 10/27/25 2:14 PM, Dmitry Baryshkov wrote:
> > > > On Fri, Oct 24, 2025 at 11:27:53AM +0800, yuanjiey wrote:
> > > >> On Thu, Oct 23, 2025 at 02:02:45PM +0200, Konrad Dybcio wrote:
> > > >>> On 10/23/25 1:48 PM, Dmitry Baryshkov wrote:
> > > >>>> On Thu, Oct 23, 2025 at 03:53:50PM +0800, yuanjie yang wrote:
> > > >>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > >>>>>
> > > >>>>> Add DSI PHY support for the Kaanapali platform.
> > > >>>>>
> > > >>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > >>>>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > >>>>> ---
> > > >>>
> > > >>> [...]
> > > >>>
> > > >>>>> +	.io_start = { 0x9ac1000, 0xae97000 },
> > > >>>>
> > > >>>> These two addresses are very strange. Would you care to explain? Other
> > > >>>> than that there is no difference from SM8750 entry.
> > > >>>
> > > >>> They're correct.
> > > >>> Although they correspond to DSI_0 and DSI_2..
> > > >>>
> > > >>> Yuanjie, none of the DSI patches mention that v2.10.0 is packed with
> > > >>> new features. Please provide some more context and how that impacts
> > > >>> the hw description.
> > > >>
> > > >> Thanks for your reminder.
> > > >>
> > > >> Correct here:
> > > >> io_start = { 0x9ac1000, 0x9ac4000 }  DSI_Phy0 DSI_phy1
> > > >>
> > > >> And v2.10.0 no clearly meaningful changes compared to v2.9.0.
> > > >> just some register address change.
> > > > 
> > > > Addition of DSI2 is a meaningful change, which needs to be handled both
> > > > in the core and in the DSI / DSI PHY drivers.
> > > 
> > > DSI2 was introduced in 8750 already, but it was done without any
> > > fanfare..
> > > 
> > > I see a diagram that shows an XBAR with inputs from DSI0 and DSI2,
> > > and an output to DSI0_PHY (same thing on kaanapali - meaning this
> > > patch is potentially wrong and should ref DSI1_PHY instead?)
> > 
> Yes, I check ipcata Doc, I see DSI0\DSI0_PHY DSI1\DSI1_PHY DSI2\DSI2_PHY in Kaanapali, 
> addition of DSI2\DSI2_PHY compared to SM8650.
> 
> look like I should add: config io_start = {DSI0_PHY, DSI1_PHY, DSI2_PHY},

I see DSI0, DSI1, DSI2, but DSI0_PHY and DSI1_PHY.

-- 
With best wishes
Dmitry

