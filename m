Return-Path: <linux-kernel+bounces-871839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB39C0E76E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17E664F8D49
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE923090CA;
	Mon, 27 Oct 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HboQBENh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D11E32D6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575501; cv=none; b=EmAqP/0wSaW+PQfyhIwCzII/ffpejLFgQN5H6eTtPhyYSZwJF4Om/Pd2sgzxoAzqYmfOAhMoVIq0SLMrM2IjpzrRAm1qEudaGtv2iXwsTw4LHyQdxEH9Dy04i8FYnMAEUDJ2DRhKZRjM9a2FTa9Kxm8zexTtogfE4Y/i+JRdqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575501; c=relaxed/simple;
	bh=jSUdrDctU8ZOWR9YNGP6vXFYmPv/ipEZl8cwDsL57v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHfEDCmgUhjWb1T4WAueP0w6q1csetER+r1tQ+NFHoZWktU3FiVDTGnEu8eNjWO8mJQki8YXugxKEhSjmNdxjGuE8ATeDSo2BN/CPQ8A/Br/mPL2qRFl5thR76HVNgww2ZH/OvC174TBMu7xctCHdG0Dc1lzzN0ukKI+0n0tuk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HboQBENh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R7nka21065061
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mJ/oV+cYqr/8D2B4smGZ5hJY3orMCaMqMjktQtWtFsY=; b=HboQBENhgPMr/GO3
	KmdNGTJ9Ohg/LZ7WrmlLaUJ1JCvHUQdJLIVSHVSujcDan4RpG2JFjE4ASaLyntoF
	lyALKF1wzsRfdCsXEthFIYTl+SNT/qr/VGhOSS0cHrVCr1nKqzol9nLz3u/ZfPV1
	W/SPoDXcMo5DCRy2NShcebybxtmEWI6S74NBwceufZEaZLg+Ne6r0F+Nn6XDKixy
	KLXjj9lGgkTrpEdCN20DGzpiLH+Dfx5RbuZodYnAF+y1y1HIi8ucOzKMhtsacG3I
	Abwqe0eQfytV7QRjo+2ZLYZni44k+YwxK/4/stTPccjc3ulqqW4raWf2wL+/knYg
	Pk61mA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0ps14w21-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:31:38 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-93109260c4fso9727320241.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575497; x=1762180297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ/oV+cYqr/8D2B4smGZ5hJY3orMCaMqMjktQtWtFsY=;
        b=JIZbNBkpwmFAXem8uyyOu/uRIbG5HJeAAMwrNKRanDbvyycU58Tek8ozjPvttc8ujP
         RmzrdtiUwm3FEl82THCcDI2bfYu2R6kVBucc0xzpgZR3byzKAGw87M0ox7x0bHakMZEv
         y6yUERQt70VtGAfy/n+HvcYpphtj+22noUjzC7ba9N91xXRjk0iGsrMpnFIcooLwPNb+
         S/OcZ1eX8QwqhD9STEVSUPZgU8I6do83CTXZvO0AWCRmFexwIun8PBJXjrCXjp/1dyOh
         EWx1m5h3IYDMS67kK0UiF0+CwTVk38kuCHeGQQdZvVAfGHW3g+764RrYRBLBoCxeH0Vv
         XYmA==
X-Forwarded-Encrypted: i=1; AJvYcCV0JeT+wDHeJDMMwQfA6UZK8aC1u5F/nqscRMjb0rVltARgxIRzEAs0CJcxZ13uVnAMT5Jb/GJOtGUHgYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ACPlLVhA21q83MrBGGoosJf+EYjkAih2yKFwd6PBmNdR5bQ3
	tIpDS+0K8MWVYkxX0FddQbic2ogDRtZfgmlDZNG6gXN1FfHIn4Q3a6yphO6NJ+dbduRG8e39bMO
	H2YuFLSht0u/jmWLy9Ik3JWbFlsvZVJrfmLZ62afrudTjOok79yZ7ds0SyxSvBKfACuM=
X-Gm-Gg: ASbGncsbgZ9BUljg3LTHT9U3hcBGFDp5MJaEMj5/1SYBImG/fC1WUXsGQ0hXB1i8LP2
	848Fg1DfgYe5XXclp1pe7GwpUEoXZ+1HKMP/YFa1d69lQuHe+iLlOXth5U9eRnBxt0wnIDpNl9+
	b3i2IdrFZ3B3tXVLp0RBR4hNLDbXYDAvRDcKPweKASZNkDLEAMCn4uKBWBeD9O7ffsNiEfyWv53
	c05J8uhpqX/9KEdPgKoqJmBm+LpvvhhqdN8F9pbbO2o7YRqFuMvPFEJaqzD1r4JCZsIRlAVC+Cw
	9MeNWolpOKFzrEZYG+vHcjZi0K68LqB1dpgFmGAsiPPZoDPDAc6V+QQCGXVRZBWORzUXY3I273A
	U5niU/K7cMF1iG6KCJewzWaTmOlF7FlDsgFiYekN1UjFjAUtIOM6hvy/BCnVyk21iFAfzOBZq/H
	9KhNvwS3o96WbZ
X-Received: by 2002:a05:6102:a4e:b0:5db:383e:7b0d with SMTP id ada2fe7eead31-5db7ca26a5bmr36432137.3.1761575495642;
        Mon, 27 Oct 2025 07:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6nK4YCqAYC+uwXKW/CbSci1wNrGe4DF1/5A/Nyiz2sV3wdxX/7PyT+uiNUI/bSJbJDtpeog==
X-Received: by 2002:a05:6102:a4e:b0:5db:383e:7b0d with SMTP id ada2fe7eead31-5db7ca26a5bmr36225137.3.1761575493679;
        Mon, 27 Oct 2025 07:31:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41c30sm2381997e87.3.2025.10.27.07.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:31:33 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:31:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] regulator: rpmh-regulator: Fix PMIC5 BOB bypass
 mode handling
Message-ID: <hwsornfn3rv524pzrudgscxffbvexdr5c3ko3th6sdakx6zfdv@sg6awizr6mzw>
References: <7wiionjbjot5psapobmwcflecyu7pz3pzc44c3horsvjfj6yfp@f2iig6hyb5a6>
 <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
 <on4zcfs5qdaekc7teo2iq6vpw7o2mp6yiqjkbznxo7wcxgutj3@nb35f55fkugv>
 <61c299af-c4f8-47a0-8803-306c08792b17@oss.qualcomm.com>
 <xlki5jwurnixdxaph5mtxg7sfks2cww3xbswgtf6dbn2z72o2r@smx5hxo6obxj>
 <c3fac2a3-dc89-440a-9958-f2e904c42f5a@sirena.org.uk>
 <7wiionjbjot5psapobmwcflecyu7pz3pzc44c3horsvjfj6yfp@f2iig6hyb5a6>
 <20251024080358.rkebbvg7louwbo6k@hu-kamalw-hyd.qualcomm.com>
 <20251024080358.rkebbvg7louwbo6k@hu-kamalw-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024080358.rkebbvg7louwbo6k@hu-kamalw-hyd.qualcomm.com>
 <20251024080358.rkebbvg7louwbo6k@hu-kamalw-hyd.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ju78bc4C c=1 sm=1 tr=0 ts=68ff824a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=MjDJoloGj8gcxCzJeMkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: To2g3zhsmKaDruEkUVT58aB75pXkQiAP
X-Proofpoint-GUID: To2g3zhsmKaDruEkUVT58aB75pXkQiAP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEzNCBTYWx0ZWRfX+JSJvbxofb1M
 kSMwT9t5qtYbEX7nSfv25RkmGM1KxIeNMG/5G4mdYoOpBuPS+VZCB0KUgiEdX7XGC2DJw3gw6CE
 VT1uIgTAgVS5bzJ1tyhhp2rT2GI0hScl0e7PPWzAFnCyl/GDUfoM5kCDXZ79Ei5sPaUXSh2MpLm
 RfDsgPKh7m5bWNO4Iivi3zvHg3LsADXbaaqqQyMv9sFC/Z/UyJ8m+L3FXY5H5lPonb/Hq8957YV
 Rx2kWNufDga4lOmLOEM57QgJLby709TTvAk/NbGwbvftEmknfF3Igb+ZwViGxt/xbrCqE3BP/XO
 XEmAulr1U3JYBsQY9ayS7rYEJL3Z73SH4rF1B+U0UmnW/tgPWVqscZ8V9fXes1+j/k7Wv7kEv1P
 70SHMq/0QfA6NxVz1w6nmN1tCtaZdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270134

On Fri, Oct 24, 2025 at 01:33:58PM +0530, Kamal Wadhwa wrote:
> On Thu, Oct 23, 2025 at 02:37:07PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Oct 22, 2025 at 04:15:51PM +0100, Mark Brown wrote:
> > > On Wed, Oct 22, 2025 at 06:11:46PM +0300, Dmitry Baryshkov wrote:
> > > > On Wed, Oct 22, 2025 at 04:58:15PM +0200, Konrad Dybcio wrote:
> > > > > On 10/22/25 12:23 AM, Dmitry Baryshkov wrote:
> > > > > > On Wed, Oct 22, 2025 at 02:38:53AM +0530, Kamal Wadhwa wrote:
> > > 
> > > > > >> Currently, when `rpmh_regulator_set_mode_bypass()` helper function
> > > > > >> is called to set bypass mode, it sends PMIC4's BOB bypass mode
> > > > > >> value for even if its a PMIC5 BOB.
> > > 
> > > > > > The universe will end, the Sun will explode and Ragnarök will be upon
> > > > > > us. Please describe the issue, why sending bypass value is bad.
> > > 
> > > > > I think you misread, it sends the magic value which corresponds
> > > > > to BYPASS, but one that worked for the previous generation
> > > 
> > > > I just wanted to point out that the commit message makes a statement
> > > > that it sends some value. It should document, why the sent value is bad.
> > > 
> > > It seems fairly clear to me from the above that the driver is sending
> > > the value for the wrong device type which is something so obviously
> > > wrong I'm not sure it requires further explanation.
> > 
> > Okay. I'm sorry if I'm overreacting.
> > 
> > The bypass_supported field still needs to go away in my opinion.
> 
> @Dmitry - one way to avoid it is if i re-use `.pmic_bypass_mode` and
> keep it  `= -EINVAL` for the checking if the bypass mode is not
> supported? and drop the `.bypass_supported`.

You don't need .bypass_supported because the regulators that don't
support bypass don't have .set_bypass callback in their ops and as such
it is impossible to get the vreg->bypassed flag to be set.

> But do note that currently only BOB type regulator supports bypass
> mode, and this above change will also require modifying all of the
> existing (and future) configs for regulator types that do not support
> bypass control.

[...]

> 
> while in the current patch i dont need to touch any of these above
> structures and just add new property and define it whereever
> `bypass_supported` is set to true.
> 
> i.e just change these 2 bob nodes only.
> 
> static const struct rpmh_vreg_hw_data pmic5_bob = {
> static const struct rpmh_vreg_hw_data pmic4_bob = {
> 
> Please suggest, if we can do this in a better way.

Don't change any of the nodes, the necessary changes are already in
place. Just fix the value being programmed for PMIC5.

-- 
With best wishes
Dmitry

