Return-Path: <linux-kernel+bounces-744229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0923B109D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29AF1CE094B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645F2BE638;
	Thu, 24 Jul 2025 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M/5S5VVj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164726A1B8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358473; cv=none; b=EG1221qZF5Im76SLsfnGTA2mOK+yIPbC0ViLn+JtU/qqNTESYUGt+bfhl5UctK6WOIaYaodIPZW279wpNTfPtlVQYQfu5ZzIgW6ynZCX2t7RX+nA4kvyEKZ4mGSqetN/MqqTPfU9ivRL7ngdmZzCfHuL5kpteVeOR9of9sIwsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358473; c=relaxed/simple;
	bh=9uu1S1qj04g/juKK/9B5wbVnmOsk3FvMiKkw5w2j0+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOFuch+z3nB7fTwWC30AXOjHPgTwn6tZvBJAFKjWV99HecgCxSDDGuKRbTiqQLagrY/nUFNMR93mN+4h2P2PtgblrboCkEHaK19n3emASLKv0D2dCr3CtLQPTRq/YqpLDvLcP7V2xB4S9WxGIKbQCTuwibsIbpMtceJXv/aBIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M/5S5VVj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9a9fZ005788
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5WrE6w+Y+/lZU3NCVD/cyIQyDMA0J81+VswNVXgVvAE=; b=M/5S5VVjf1KTAqru
	xFleTf90vUOlmPvX/YZNXPtjcgzVwMXKbqFUEL8q+xNpDIhmm6IZ9PUFBBqNKM+A
	0k/UslC5F6JYKuzyi5ptSDvi60GrOoFZqWDeEUe7IrIse5GxHHYTrbrf7At1lt2C
	TUCaONH0Y3jnN3fC4EdsZvXjIWjSuM0Gg2L3cIP3jHzeqtFgVWWTp/EEtwKLJPZP
	CbS4nNYu1kOcPqya5d4D1/dQWJBpYeDPIEyEy/zNaSlQBqaOaSVI0SPl4uI7ayyh
	yDuafSFmHQNy8se5qkHue75vW1zx6sO2noT+nDK0+Xh+/l0VCpJP1mO0TJAwszou
	GWkV4A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qgmmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:01:10 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4f32e552e80so196512137.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358469; x=1753963269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WrE6w+Y+/lZU3NCVD/cyIQyDMA0J81+VswNVXgVvAE=;
        b=P43vKlnDYgzheKYBwWLD9yweF4Eob3FPTHmHGBeHiDhZe5kvNpOPLLa4nDJNQytYQ1
         hm8nWwczKPG69lc9opEWqnftONU557UeVNbWPZexMgIbMqAY9QwEh+irEXm7dK90DU4w
         ojVXxyyhNAfiRLKwHmfAxZnX/yNSGLvH23lLw5J6EGtVk4VZw8IoVYvjliMWUHgSmrpk
         JoT7cdw1oGAnyaVSc1eOal/r5xy4T+rEA8kZ0lF4mV6Z/G0zwxcXCm5Z6Setsee82Ksa
         Z6u1y82JRhbAEmZP/CiwAjBpmcVJItmJmUJ6IsYNxAtLUuOqomtEDs1lU9/oXv1HJ3JG
         9+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAt+iK72nTz0a7JgAuhQeysCq4VGwpLuFWmbMN1DxRwqcIubcRqK0eANlpCg3RCm7q6qpor/6W7XPvuDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOfnVnmBj63fFtcMGDfUxgAxgF9RWKAIgCz/hE499lyuhtgo9k
	NaWmVjnBvSiKAVEzcBCNH+EqEei0+Jg5c8GCFCOARoTr0lKGHLg7mjRs/2sCzU48My65lj1c/A7
	+sB7KHmO1O/ZxTadhB2r+Mzvb+/XUvhLPsmVAw1vyTElCTgJgVoAtGk/wYXyB2PNMVX7dJGd9K0
	c=
X-Gm-Gg: ASbGncv/9zQEkbkvPuRMu6NKs9Zi8LZE5g4uRZkH5kk//4BLBzKAXVbTy9o2S0S2dzo
	kPUbuxqXYAl78eFLo+rBlX4YoIPVEYS7YKxf87ytXGYqzPtCh+EK1MJohwnSJfMWJtoYm1LzE1k
	/F2JsCIgIDDCXoHrYnxwn9RZOwX7br/jVHBZ3v6iGzrPNeuJ04OYwOC8H8eOA/1xq05vN2YqoXK
	q7/XNNy4vg092DHEelbede9atOch55Y1xqKYcV6NQ/K/ak/27KQ+An72/DGMHVISj4M3BDRRn+X
	2AsY9As+zvilQ18e9cLzAo87w8Nap2voDlWBe19UrhGb0XQENfstJrt8ykBdecfa+5ByDKuy6Vu
	FryjA7xOlheoE8kM79Qs+ijwBhebCMnvji6MMvfUbl15Y7Bvm1vwS
X-Received: by 2002:a05:6102:5a99:b0:4e9:968b:4414 with SMTP id ada2fe7eead31-4fa1521851fmr2754339137.22.1753358467138;
        Thu, 24 Jul 2025 05:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETM2Dk540eywCV0gAGXNNbz9noJyr0KH7DW1dRdy4yZ58LU0VXkl2WQyJmUeGaYGW1uVpMTA==
X-Received: by 2002:a05:6102:5a99:b0:4e9:968b:4414 with SMTP id ada2fe7eead31-4fa1521851fmr2753800137.22.1753358464426;
        Thu, 24 Jul 2025 05:01:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53b2288csm325180e87.23.2025.07.24.05.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:01:03 -0700 (PDT)
Date: Thu, 24 Jul 2025 15:01:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@quicinc.com
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
Message-ID: <tpervpypkne6lasl3fn3v52xutl3zfuytalo3cveoe4us63rrb@p2w4cvt2jf7a>
References: <konkbi4hvd7qc4rhokwrymzqntroy7gijk3ndwv5rluswdrykp@xsafrtrjzmuq>
 <10c90fee-ce7f-4034-9028-4252f19cb67f@quicinc.com>
 <CAA8EJpoLLDXFQk-ViuaioKrECzMV0aUrcOj4v+Ufs4oHY53mrw@mail.gmail.com>
 <064d3eed-c2ea-4b41-85b2-d2a5a922f8c7@quicinc.com>
 <ehgjdszjr34xppmkrkicb4pnq326nor26tqu2ekop6ew2j3y3h@pm45aiipzuc5>
 <48c73675-a73f-46f1-81a9-f701a2cf00a5@quicinc.com>
 <c1ebdaf1-92bb-4f73-bca9-35246d7c10e1@oss.qualcomm.com>
 <ca83b841-aea0-4233-93fe-02a7b5985af4@quicinc.com>
 <1a0a5178-fcf0-49b6-8e4c-1393c0f4f229@oss.qualcomm.com>
 <22848e2e-bd7d-486c-b481-c624d230d327@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22848e2e-bd7d-486c-b481-c624d230d327@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MCBTYWx0ZWRfX0JjfRaYX2ui4
 Od9n2XYEiN25tAgdDLndE8BO69kDu18yIznLPQFgY1ANQif7qnbBvNeBR0PBYRvgbHhxvnhIZAq
 vP3GJ9H6m6CmQZQnBnAxqEClX3TVQ3Ubo9DUJn2n5FGFmfos6kmLtwNP+o86uziHplMPvhsba/9
 tvpgn/NdvFLmtf5qM34TbXA4mQQg1hC4n8qfm23z9KPQc68oyqRxuhxx03KlhCKAGtfyYtuGYnX
 4/L3rKU1GkixWfE+8WTeIbX8qCzgMaypuVXlaoSlK/WW2wktPzQtTPzIh6H0Hn56SCEDG8akwLY
 8dWpsOKdMGT5fk3Zp4p/yrU55eiGU6JIoTczXhL22yWEP1UO3pUdPSXojijw0HW4RxtWZzSOfkq
 l+sxuFSKYs3I30udUCVbFEHzLZ9bFlyWJgszS8m55Xuug4FAp2HRA7JJ6jMgxXzH3ln8Y5sI
X-Proofpoint-ORIG-GUID: ibkwC7Y2yAgTsbXxpjk0DAZbcgKhPlHS
X-Proofpoint-GUID: ibkwC7Y2yAgTsbXxpjk0DAZbcgKhPlHS
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=68822086 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=6h7372fjVO4yHBa2uBUA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=-aSRE8QhW-JAV6biHavz:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240090

On Thu, Jul 24, 2025 at 04:45:38PM +0530, Sarthak Garg wrote:
> 
> 
> On 5/21/2025 9:11 PM, Dmitry Baryshkov wrote:
> > On 21/05/2025 18:36, Sarthak Garg wrote:
> > > 
> > > 
> > > On 5/21/2025 8:19 PM, Dmitry Baryshkov wrote:
> > > > On 21/05/2025 17:35, Sarthak Garg wrote:
> > > > > 
> > > > > 
> > > > > On 5/21/2025 6:25 PM, Dmitry Baryshkov wrote:
> > > > > > On Wed, May 21, 2025 at 12:46:49PM +0530, Sarthak Garg wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 11/15/2024 6:53 PM, Dmitry Baryshkov wrote:
> > > > > > > > On Fri, 15 Nov 2024 at 12:23, Sarthak Garg
> > > > > > > > <quic_sartgarg@quicinc.com> wrote:
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > On 11/4/2024 4:19 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
> > > > > > > > > > > Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
> > > > > > > > > > > This enables runtime PM for eMMC/SD card.
> > > > > > > > > > 
> > > > > > > > > > Could you please mention, which
> > > > > > > > > > platforms were tested with this patch?
> > > > > > > > > > Note, upstream kernel supports a lot of
> > > > > > > > > > platforms, including MSM8974, I
> > > > > > > > > > think the oldest one, which uses SDHCI.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > This was tested with qdu1000 platform.
> > > > > > > > 
> > > > > > > > Are you sure that it won't break other platforms?
> > > > > > > > 
> > > > > > > 
> > > > > > > Thanks for your valuable comment.
> > > > > > > I am not sure about the older platforms so to avoid issues on older
> > > > > > > platforms we can enable this for all SDCC version 5.0 targets ?
> > > > > > 
> > > > > > No, there are still a lot of platforms. Either explain why this is
> > > > > > required for all v5 platforms (and won't break those) or
> > > > > > find some other
> > > > > > way, e.g. limit the change to QDU1000, explaining why it is _not_
> > > > > > applicable to other platforms.
> > > > > > 
> > > > > 
> > > > > Thanks for your comment.
> > > > 
> > > > No need to.
> > > >  >> I agree with your concern but for me also its not possible
> > > > to test on
> > > > > all the platforms.
> > > > 
> > > > Sure.
> > > > >> Lets say if I want to enable this caps for QDU1000 for which it has
> > > > > been tested and on any other upcoming target after testing,
> > > > > then how can I proceed to enable?
> > > > 
> > > > Let's start from the beginning: why do you want to enable it on QDU1000?
> > > > 
> > > 
> > > QDU1000 is one latest available target where we have enabled this
> > > and tested. This has been enabled to save power.
> > 
> > Isn't it a powered device? How much power is the save? Is it worth it?
> > 
> 
> Sorry I just did basic sanity on QDU1000 device to confirm its not breaking
> any eMMC functionality and we have also tested SD card on SM8550 as well.
> For power no's we have stared internal discussions and based on target
> available for power profiling with eMMC device we will come back.

So, again, _why_ do we want to enable it? If you haven't measured the
actual power savings, then it's obviously not a primary reason.

As for the v5 targets only, they start from SDM845. Have you tested it?
Does it bring any actual benefits?

-- 
With best wishes
Dmitry

