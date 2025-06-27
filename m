Return-Path: <linux-kernel+bounces-705532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C759AEAAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 01:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6497D4E2439
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 23:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050A02264B4;
	Thu, 26 Jun 2025 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1yy9XhS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE112DDA1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980814; cv=none; b=AZyhU7qyWSctMgtgPnjxP+/33S06Jofo/GAoZtO/K4qokpdi0LjNDYyy9GhFbqaIRDwG283ymn4YldxDxV58oO5D+VeDGLa9gEb30TCaiIsVIoMU9RCPd3TpPdYDRbYoz6JkeNETUlGUt+3vKKmTmdwEzgncqnEO8jJcfCfV77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980814; c=relaxed/simple;
	bh=9DRHyKEn3LgdNudaN2dAIvpVac1tRIy6t8Yc8Bw5peA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUeXoRBM6o9MWXqcRteJkzhzARhcA8FpJRyCM0JC+8mR0u0y6/sLhGrqMJARdAdm5/rZ3ih8+f/oI/oB5+smaeYY/vtiAtmSFJ3pbXv8Hphk+F7Ts0GvRUFQMCgc5CWWDz3sDav4MjAm/1dyPQmz/LcoVAzvbN8c1lvUeV8ocGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1yy9XhS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QKaoMb008315
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 23:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p2pcURoybL3Y8aXTxu2NYraS
	kKyVcrAYks/QDQsGU1k=; b=l1yy9XhSO/vVbL3e3265u9OwW8VX+jhvZgqiDZ/V
	gpfOu//TDT0C1ZxgewWKyfN/LxW3dbLHU+CVG3syHehitFaqGSCnOGX9xYmyBCuw
	6wOfBeSWoyMH8djKRVtN/ELUHTysoKVDeBl41X14/mC7pztTX4dQC44vjLFe2O5h
	6X452Nt4S6FqEDVvnAnHAZLGlmwr7yqK6RW/fgPaKL3aKvirlfrF0gtRdwcc2SXZ
	lU2ZweOrtb9Fp/YrfWOor1/L4x3fx7hOg6XPTrzl8SykgmwyvY8Gpc+RJVUTDqBx
	KrDppIreTE7tQ/ZtSThVyWcySibZeA6A2195E9+uB6edkw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqu9g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 23:33:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7cf6c53390eso114403485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 16:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750980810; x=1751585610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2pcURoybL3Y8aXTxu2NYraSkKyVcrAYks/QDQsGU1k=;
        b=D74bv8/svTehQoam/4Sek5j2keMYUD0LLjgvmNBCizWNqxOmHbVq7aAqBF3rf3b0su
         YuibHo8JrUgPjYbwcizGceFf3J3XewIdds2Btcjk+dIOiB+seJBjUiGc5LGG2YU2qIPY
         c4e2ccsG9Gu163TPBODfK6KlgXU18BHCKmYH/mtN3sr1jaq1+XxNaYvnR6t7BsYKUCCs
         KVQWbMlVHXRRv+4Ij3jFcPApbRkHXApRE0HcgoF+JqXvXB8ceGPXTMA2V307lxfAfVeJ
         kHA3y0X8wUycsJ7odhd/VspXfnMu/CTS0Bl9YdwARX5j4cwUjp+GkpNh70Qgam89PeCK
         DoNw==
X-Forwarded-Encrypted: i=1; AJvYcCWUIk+5VPcDrS5dQz9Qb+uNuXotK3SRApjCpdMqcgXDC2ojQkex8rFH4HeBa93Ly2RQl2qbdJONz2Mbt4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoo8FnyIU1fdNvcGqK16Uvj7zwjz/G0lDd+t91h3oWYky1KNaA
	l6JyWbbhtm54IpFSCUH0fwpQSE+uDIEbUUzDywZPVRCZ42xdyefYNBCU69ZL7h4f/uzXSPpzeGP
	G0xl5FcDAUTp+6yLDtw/pD3/L5dsjswpvwZ4sU3HfcaBe7XBnRehDQa13vvNqqxMloME=
X-Gm-Gg: ASbGncvhah58goQi7klId3mYGIJy+CISL8hyAyvvYrWUP/Vdx35rnSLm4Vn/SvDvqwQ
	NMc2T2YbgJaE/7h85wxxIBKP9nTinDLG98/xK4rQ5csVXNPPwu1UInhLjjTWL4wkg7FPoIK+ynt
	JimKU44HsymECTuPNMVcIlcsn7mAs1oCClb5459oCkfjkggV7AB13h2gUqjQ3ZFgqQHbxDVWbpR
	U0/GIkR9ExVhWqfhqvEGmH7cXl+Na/n40LMPNwZd6ehvrVUyJwi0Z7ltj9YOGR+/iDdYu3w1B5Q
	9KiqqJUg/YsKySjim65aIhJR1QV8JQK9eHyx/sUXbw9MhBmQF2zB/o8xPbic5UyrNanszBxnM8Z
	akJKAFvep2H6NzyZFdEAwWbAwzMxYMn05sS8=
X-Received: by 2002:a05:620a:27c1:b0:7d4:3bf1:b1f0 with SMTP id af79cd13be357-7d44398e3e1mr233340085a.18.1750980810086;
        Thu, 26 Jun 2025 16:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIbx430OqgmF+GQnggSARqLbLWDAsCCU6kWI1oFpMQKp6uZB7h+OTCcp2g2ALy/bF+tlAVHw==
X-Received: by 2002:a05:620a:27c1:b0:7d4:3bf1:b1f0 with SMTP id af79cd13be357-7d44398e3e1mr233335285a.18.1750980809603;
        Thu, 26 Jun 2025 16:33:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2b95acsm195077e87.115.2025.06.26.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:33:28 -0700 (PDT)
Date: Fri, 27 Jun 2025 02:33:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] firmware: qcom: scm: add modparam to control
 QSEECOM enablement
Message-ID: <cjinqyqn7qgvdoltoywxa2lq6bjyfrotmon3iv24tqt3bpdlpe@3xb2k42ffegj>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
 <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
 <aF1EDMsw1KQTlteX@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF1EDMsw1KQTlteX@hovoldconsulting.com>
X-Proofpoint-ORIG-GUID: dHtM1_DeH683gV0Xc4o3902Qz5fk9QaA
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685dd8cb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=NVsCH3EOgwMYIqYMOGoA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dHtM1_DeH683gV0Xc4o3902Qz5fk9QaA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMiBTYWx0ZWRfXw9iYHmG21m5i
 a0Cus1NmBShJI3VK6BvDO0J2XBdKm8FXyTgNieNmW38Cui1FjuIyvBgHs3nD02S0Ecx9K/EFUfP
 3OLE7yU6PZl+w+d0xBVy4sVoKhXrExUIvTSi9JgxQREf9QrGpHD/CRIssYRJiCDyhyMvAYcwjEr
 KQMFDYTZN0Pugpvjt6ZoAdnswOnF+WGeKBt4kdJcZ7GWHVUI9zSp63Po9TDGbtlwINeQWFCvh2g
 sR4H3Xmlmd9hEBMogA18SD4UaFq1syRoDWOaBSrwAy08qwrg5hKZyQTS/QEd87Mo+1ayIkToRdf
 9dnm4ILRitelb9ZxIIcy/ujvTUu76TYoE0KZsHv03TGVOIgapIneK3pB8pxLcH3EA1ZiagC5B/Z
 cTN4qWOueyLw0WitEWcpjqerAnxIcf2plRUmlCe7ClP45scQKbEAx7H1ilIFkNATRXjhUvPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260202

On Thu, Jun 26, 2025 at 02:58:52PM +0200, Johan Hovold wrote:
> On Thu, Jun 26, 2025 at 02:08:23PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jun 26, 2025 at 12:11:20PM +0200, Johan Hovold wrote:
> > > On Wed, Jun 25, 2025 at 01:53:25AM +0300, Dmitry Baryshkov wrote:
> > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > 
> > > > In preparation to enabling QSEECOM for the platforms rather than
> > > > individual machines provide a mechanism for the user to override default
> > > > selection. Allow users to use qcom_scm.qseecom modparam.
> > > > 
> > > > Setting it to 'force' will enable QSEECOM even if it disabled or not
> > > > handled by the allowlist.
> > > > 
> > > > Setting it to 'off' will forcibly disable the QSEECOM interface,
> > > > allowing incompatible machines to function.
> > > > 
> > > > Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
> > > > variables read-only.
> > > > 
> > > > All other values mean 'auto', trusting the allowlist in the module.
> > > 
> > > I don't see the need for this. The kernel should just provide sensible
> > > defaults.
> > 
> > It does provide _defaults_. However with the next commit we mass-enable
> > QSEECOM for SoC families, which includes untested WoA devices. If the
> > user observes a misbehaviour of the UEFI vars or any other
> > QSEECOM-related driver on those platforms, it is much easier to let
> > users test and workaround UEFI misbehaviour.
> 
> You basically know by now which machines supports qseecom and which do
> not, right (e.g. UFS storage means non-persistent EFI vars)?
> 
> And it's a pretty bad user experience to have people trying to write
> efivariables when setting up a machine and then spend hours trying to
> debug why they don't persist after a reboot.
> 
> I don't think that's fair to users.

So, is it a user or a developer, trying to port Linux to a new hardware?
Also, R/O implementation makes it obvious, that the variables do not
persist.

> 
> Let whoever brings up a new machine figure this out. It's just one
> entry, no scaling issues, and we get accurate information (unless
> Qualcomm, who sits on the documentation, is willing to provide it
> upfront).

And that's not really scallable. All other parts of a particular device
are described by the DT only (that's especially true on the PMIC GLINK
machines). If we are to support new laptop in e.g. distro kernel, we
need to provide a DT... and a patch for qcom-scm driver. I'd very much
prefer to do it other way around: provide a DT and patch qcom-scm if the
laptop is any way different from other laptops. E.g. we know that all
X1Elite laptops support R/W EFI variables. Except for X1-CRD, which
deserves an entry in the driver.

-- 
With best wishes
Dmitry

