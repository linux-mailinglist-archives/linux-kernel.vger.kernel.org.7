Return-Path: <linux-kernel+bounces-761101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A53B1F468
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174C017CD10
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089801553AA;
	Sat,  9 Aug 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShIujPF1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B10274B26
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754739836; cv=none; b=PbaKU7pKEM42Dm+xg8kI7ZKMAAm7y2FnP2comFALC5EpzNm4Ld5KINJfO/oC9Wkdf/9VDsry1qTkfHibu9aCWUn5x7SvvFrmV2xGi8+bzHI/18gf+jwFLg7Z6rFtU+ECpt8elE1XaAAw1DXdlWyGE7iZFZoIXQNqfzQeP3N7gx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754739836; c=relaxed/simple;
	bh=SwO5nELXRLBtJc5KwDzdoxO3kOP3CyZAe2nh9etB1hI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZkkJQtLmoN8nIm3ZCI7r9ZQS+K425AHI2eRpAXcB1T3VixYXK2AbrdGGxFeigVc7LtqGiK1RNlZeORk4QlPMnQJ62FbbNXu8fHLpLUalQXaTS3fVcPRbcUv023SvTxcc50qnrfIEVDwAAzCJGOLNglXAo28yAAAAu9LJhpUbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShIujPF1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794CuWc031205
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 11:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dhq7QtFTNob/e68BFvCh2tCGaBjvEnXwpiBGxxMlG8A=; b=ShIujPF1qx23DOVC
	snJMx5DvsRwluCSvPpoXpdLOJGvKZL6pIwCEtcsO7J6QR5Khg9tqnL5oTAxsS5vJ
	WFxjBrXDL7mG9tYg+MvTwd7/Wunz3SA2qQrdTH6Fbn+DltMlwsJDMmoucgCs42Gs
	a+sboUBPdvz+PFVyJvaRY3jkaCm32lYI4CscIG+1U9jT6KUu++Yc97jb7/x8vTvC
	y9dfLJh3z/ZPOnsy8L8fsBBMMzHI634jOlo1qluY+QiQ70IIJc7WzBCYaQ65dOQ8
	l2cdWYxynsyRe+DmsTd+zKFFiDkjYylPMezfL1ihXq39ptyL7a5y52vTdoXH31QW
	S8jF4A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g0g7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 11:43:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0a3557d05so57528441cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 04:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754739832; x=1755344632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhq7QtFTNob/e68BFvCh2tCGaBjvEnXwpiBGxxMlG8A=;
        b=XrX/P8D0NN1EwO5BgW483008cQNgOlPEIt1C8GsCbDxE8GwYGa6u4g2bzZMOW1pB/P
         TqidSClPUEYdm8GvRhK025drIciZdeWLUe5FdLXOkDXDwaYr1yg+v7FERG+lRh1hMmTD
         km3lOu+8pQGb+h+UJkR6PsFRUD3tuqjc6+VILnwqSQjQ7e5Cwn28Kf2JlPHhVlLQ0vkI
         mJbdjZfSrCIPka1nWZP81ugLkEGg9G5uuYDc23tJLgaPDkOHpy/xCaJ21g5/PbVWAFyk
         8M3JRDpYX3WMwRo4bVZUjY7V4F82mCuvKTsZfwxdhPcEphgOKpprzdpEE08mlIE4i6kn
         zR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQc1Jv+QgGDt5o3hEwOPMMx8eCAbEWXzgDRFM8c+mV2S5kgJ9Lwl9Oxr/nZ1djOjfYWNBe93HKJJx3i98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKeO5+E7ocaEpIuU/Pt96HpVyFdhiXwvVLRhI9m69urI9RAQCX
	ar367jbXsHOcENuVbQMpjw0nIWUzs/1ttV0aJQtswVo1wvnntUuztOtatWMCIwmoFFZVG6USWH4
	hh1nRVekRnhJVGiuaFIThHCRXnzs4D/vzyobiYnVr19D+5Apf311T21iF2KwHzrouRG8=
X-Gm-Gg: ASbGnct0BokqWk1H6jnuPLYQgAB02W3wawipqHNrUNY/K+A6j9x4Co9POE/+Vqij0l1
	voamC+l69n67KMVDCf6zORhiKXr8pU9tAnCevB6x4bPw2qyVtgSwX1UYNLn4avEPWx0jJdSyoP6
	vtQqaSkFfvWrvfylMc7bY8atDzIRJigK47l8TL/iaEtT9zOw4zENgkwkSYN1SNXxGjSazi3OII+
	ZMLkPchCs50weWidJVZaDGcFjp+XU5e3mu0Zk1UoE9Jvt0CzQxQqFxm3E3BAbV1P7iX6BsYWcjr
	c/suploAE1ZswD85Q9zy+SJxCb5OHq9UBDrO2c0E1woDN/3vgTAp/solNv2gc/s+cWqObA==
X-Received: by 2002:a05:622a:4a10:b0:4af:1a43:6a52 with SMTP id d75a77b69052e-4b0aec78545mr96034851cf.16.1754739832342;
        Sat, 09 Aug 2025 04:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzqs1ndblPPDaYRCzYH6G5/RMWdae2a1I3H1jVxQ9aCs494h/N6aUaTOA+9QAqxW5zPf/3sA==
X-Received: by 2002:a05:622a:4a10:b0:4af:1a43:6a52 with SMTP id d75a77b69052e-4b0aec78545mr96034361cf.16.1754739831696;
        Sat, 09 Aug 2025 04:43:51 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm34291769f8f.28.2025.08.09.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 04:43:50 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Sat, 9 Aug 2025 13:43:49 +0200
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bryan.odonoghue@linaro.org, quic_dikshita@quicinc.com,
        konradybcio@kernel.org, krzk+dt@kernel.org, mchehab@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <aJc0dRkNQLJvF4z1@trex>
References: <to2hrxml3um6iep4fcxhkq7pbibuimfnv4kfwqzlwdkh4osk5f@orjzbuawwgko>
 <aJMMhIqNupwPjCN+@trex>
 <0248afed-b82d-4555-8277-e84aacf153fd@oss.qualcomm.com>
 <aJNTigOMy1JFOxot@trex>
 <fcdd9534-d494-3fdb-dfa7-1d15da6f697a@quicinc.com>
 <aJSvjqfQw3kNrVVH@trex>
 <447caa6d-13d2-2e75-5f33-6df9b2fd6d69@quicinc.com>
 <2yj3er5j72yoa2ltboopx5gvquur7jl3viqnq5qsci2fxjf4ix@7t63vgizfknb>
 <aJcQRLDplbNetNKN@trex>
 <oi7juewvfcgvjm6tedcq246rzyqvx4eambqo36w6byynmbl7sm@i2nztugnzxo5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oi7juewvfcgvjm6tedcq246rzyqvx4eambqo36w6byynmbl7sm@i2nztugnzxo5>
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=68973479 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=MGQ6gT6oETv9xCBFa_IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX1qdb0i2HXbVl
 Yiw1AJi3bPpN5RbZlnip7wiFHuMLYDrjkw5ubtJzncg8rheVrmVfnGQoUXUkJKSxl1/WDpRCjBU
 Vkzj+eEotSEDhgrwFASKgYikFgaxsExzZB2TxxLByJOAY6Eck/nYR4kKMBgUNdNXK0XweX8/6Os
 AVf+/H20P23oz6cj+sloBQ+muOPDHC5lf/Ob4V3K/4m2yfl/4b3F1pv9xmwYbf/MsamvaD+OinK
 v7l/lNpFyH/pRttHrsoOsEUN9eB1WMCovO6fnVxVRuqHu5r4VabNmm6G5Ay/1CjhRQ19KD3wV+R
 fhtqQhtRxQ6Em/lyTHy0GsF3RuxzZyg0HkZDUJmiUrb6g7rkt15nDLpWUdc1E3V0DFlVEAKORGe
 Ly40WFSo
X-Proofpoint-GUID: BvUqK0U7fREQ8mDRIVGMATYpnrJGKNOF
X-Proofpoint-ORIG-GUID: BvUqK0U7fREQ8mDRIVGMATYpnrJGKNOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 09/08/25 12:22:39, Dmitry Baryshkov wrote:
> On Sat, Aug 09, 2025 at 11:09:24AM +0200, Jorge Ramirez wrote:
> > On 09/08/25 11:18:21, Dmitry Baryshkov wrote:
> > > On Thu, Aug 07, 2025 at 10:05:10PM +0530, Vikash Garodia wrote:
> > > > 
> > > > 
> > > > On 8/7/2025 7:22 PM, Jorge Ramirez wrote:
> > > > > On 07/08/25 16:36:41, Vikash Garodia wrote:
> > > > >>
> > > > >>> It was agreed that this complexity was not necessary and that we should
> > > > >>> just drop <6.0.55 firmware support (which would in any case only include
> > > > >>> video decode).
> > > > >>>
> > > > >>> And so on v8, I removed the above.
> > > > >>>
> > > > >>> Now I have v9 ready to post it, but Dmitry is asking why cant we have
> > > > >>> the v7 functionality so I am waiting for direction.
> > > > >>
> > > > >> the issue is in firmware for both encoder and decoder. Didn't like the idea of
> > > > >> driver carrying the hack for a firmware issue. Just because, for encoder, we are
> > > > >> unable to hack it in driver, we are ok to have it enabled in a newer version of
> > > > >> the firmware, we can follow the same for decoders as well.
> > > > > 
> > > > > if that is the only reason please do explain what do you mean by hack.
> > > > 
> > > > I meant that the EOS handling was not needed in driver after fixing it in
> > > > firmware, isn't it ? Was trying to avoid carrying this in driver.
> > > > 
> > > > I tend to agree with the comment made by Dmitry in another thread to have decode
> > > > enabled with existing firmware, no option but to support the *already* published
> > > > bins.
> > > > 
> > > > Having said that, these limitation of having a separate EOS dummy buffer is well
> > > > sorted out in gen2 HFI which have an explicit DRAIN cmd for it. Hope this
> > > > motivates you to migrate to iris soon for AR50LITE variants :)
> > > 
> > > Migrating to Iris won't bring gen2 HFI. Think about users which have
> > > OEM-fused hardware. For them it's not possible to switch firmware from
> > > gen1 to gen2. Thus, if the SoC has been released using gen1 HFI, we
> > > should think twice before upgrading it to gen2.
> > >
> > 
> > As I understand it now after the thread, any driver developer working on
> > new features should not be constrained by users with OEM-fused hardware.
> > 
> > Since only the OEM can provide signed firmware updates, it is their
> > responsibility—not ours—to figure out how to deliver those updates if
> > they want their users to benefit from new features (or new fixes).
> 
> The OEMs might go bankrupt, might stop supporting hardware, might not be
> bound by EU laws, etc. If the platform was shipped with gen1 HFI and we
> suddently provide gen2 HFI, the driver must support both firmware
> interfaces for that platform.

sure, that is backwards compatibility

> 
> > The EU Cyber Resilience Act supports this view by placing the update
> > obligation on manufacturers (at least that is what I understand it, let
> > me know if you understand it differently)
> > 
> > Breaking backward compatibility is something we must avoid of
> > course. However, guaranteeing compatibility between old firmwares
> > (whether signed or not) and _new_ features is a separate matter...
> 
> Anyway, the kernel is provided separately from the firmware. If we
> supported a particular firmware set, we can not break that.
> 
> AR50_LITE is a corner case, as we have been shipping the firmware, but
> there was no corresponding open-source driver for that platform.

right

> 
> -- 
> With best wishes
> Dmitry

