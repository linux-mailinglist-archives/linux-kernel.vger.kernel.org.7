Return-Path: <linux-kernel+bounces-895876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E66C4F294
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B8A1885B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07049266EE9;
	Tue, 11 Nov 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p82Ek23U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YXZ5vFMm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC195258CD7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880483; cv=none; b=g2mc/5+nz+Yiwn+2Z4TfysCF84nXGxTsdlViJaHYSAwOoveWdLH4KhUSAdMLM6zWrZOQt2vJ4hBPA0Hlakbniux2QZTnqOKQ5M+D0SOup3mJpPbxA/jixZogrBf+PjebwJ7nDa02agFcMfRP7S6P8xpHMUBM0lB1fMCj9Hykgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880483; c=relaxed/simple;
	bh=u2PBf+ScEvsZXo6Nvlx3EH1X8QQScTycOFmTK282ut4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoNR0bVs6PoVz2RNGSPAArUgKqydc5aQIxkkFEYONbu5+QkpwedDJ8dP4aKYE4GJE+/Q0DjLoGLxrETGNhhpR8O4cLT3fkm8BGJk+E1T/3i9TPlu5kRqJfliyKASYW0y9K6666/n7srQaXO4mEuH8XIVyyl4fH1jwq5niP/5+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p82Ek23U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YXZ5vFMm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGYMb1937345
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ys8OzpHvw+YFE6Z0Rh9xp23o
	VtdDuiKWW3cIiRZWe/A=; b=p82Ek23UgaDsT2quw+612l8olAAMG4J9hXMKvu0D
	c2dhGympd9NMvPfdo5aksmh0XbCkooFFHroKr/kUrNpz094UjFoXYNNnWelH3v0g
	LNIf41jaMIJ9GEEbzFTsWWMRjdfTsR4K/gay+s2mmVCsj4/GXwy5DuyzQRBLTX3a
	S8Sh2+v46YNT8JcyXQcEqYwCn+O+y9RHd7TCZuwWnK9fNwdBRasa4PSCdkNkNAUP
	/zzughle3qzaEwV+55BpzKjuRUtoGnbgPK8W234ZjNRuX9GCsQrHsq8/NAijm0w5
	K542kQyRlgWZLY1JOZoCTdFM+XUsqgHAWyewUGlVLQfoiA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abwtja6yf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:01:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295952a4dd6so15441765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762880479; x=1763485279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys8OzpHvw+YFE6Z0Rh9xp23oVtdDuiKWW3cIiRZWe/A=;
        b=YXZ5vFMmUi9n4I7/kjRkj4gkNrsIhsbN6umJ6reIuje2ULvrqvDUUkGgHyaeDhIXjz
         0mqqJ8BFOldIm7Ypw6WJv3w7uR/qDkF4g2kiYD2nesJtRIclXIJiwprtdVf9iefy6Bwz
         kch8SfiHpaEd0Ag8JUuK1bHmBho3H03IBOrj/KREZlmbUVTv0LD87ERulfrB3d6RA88M
         DNyQ9NIZlcQoZF9M6us/kEXqyg7//vt0ovkjZhnSyyXfSKqpjxBZLBLKuqUytOsykU16
         piiu5vZhhgHwwiF20NSYbfRZDMiZax5kYblylViFEXs7mkFjP3i37xuXfSZ3BzTSz+nN
         CASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880479; x=1763485279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ys8OzpHvw+YFE6Z0Rh9xp23oVtdDuiKWW3cIiRZWe/A=;
        b=v4NpAnx93XDWW7Y7JxN7xN1Kv/3IKDXGCx568YmSUPRjDVZlp4iJZj55erhkOkppWX
         UbbQlM0cqNeSzHVNLiwuaJJuHv1yrCh7TkPf+Yl0TUUBNVG0ntIu5mm8Hx31zTzdU5du
         DCYeimx1dnmHED1XqdEvSuzw/1MPJyvIWh8BxuUAme1cJQWWBGj9tjfUTl2Jm1Gsegnz
         PCSQhEDkms6DpzVNfgCFx8Q93gLIP2HeD5W3kN68zYkOMJWWXDXaQkItd1q6T/KACcn0
         uf46cvN7oPqhJKZX0N1w1/hERG7lRBq0U8CpbACathUOKhlzi27qrXwFKwh4TKyNBiW0
         GBWg==
X-Forwarded-Encrypted: i=1; AJvYcCXkjy5jn53tqHGdqe1PWMwgdgd/TsVMJb8cmA+oEHi1/Ky/BBaxx3cftf3DDyvtFq7ua5II8CRCeNKvHik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/BX2h5Gb9GThDNRPDlT1wxN9AZoFbmlBmYmcSMmpwm9QkJGy
	li23gIjh2XydAFSrotvY+eMsgrREDCf90wSFl0LS6jieyJTod/fAssUq5MhIZG9NQ/+tk425Ez0
	W/HI+yRPWsw5wvNsXxdpMw3EKGiCs6UShFmm628hBfGxfXbbf9iuoi5JquCdcm/TiQkA=
X-Gm-Gg: ASbGncvYEbgbSj4nD7rkBUGTBn7xB7LooOY9rvxV1KEAlV98jnJ99EGK9CjxgAk08SD
	6oJ2xOIIhraJTSbCvDg0dc8NceDtwu+kIiwJpFwMemDR+nNv/OEydfAUtnts6MT7YI+/iAQB/uV
	D8pByXeGjRTB2y+Lt+t9EbUo2CrjXVXPsYrQtnA1KlwlgvIAmKBiNp003vLvjQHKYI0j+QX2Tzh
	tYp5h0TJHtzRqVtCHGiBpR+E6tkYYy8/+SmLyA5QTLvEYSTZQCZVMDVOvNEJnC6z9BgjUIx/7l1
	XYdVghEbdTgSCL76ME1OABa52UQjRENVatdQuDnzxFH+N6GQ84U071jYxSr9IH6qd81kvrEEgWH
	dCua6GtysvSH+8Zf83+oXZaQy/4CxBRmd
X-Received: by 2002:a17:902:f785:b0:297:dd99:ff13 with SMTP id d9443c01a7336-29840842ef6mr57045265ad.17.1762880479114;
        Tue, 11 Nov 2025 09:01:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeS7Nfn0Fkkhq93axawBwW1Zllh161FgmCKufOMOr8fIgtNOiUp1YWsMAVxcanb8fNr9z3/A==
X-Received: by 2002:a17:902:f785:b0:297:dd99:ff13 with SMTP id d9443c01a7336-29840842ef6mr57044415ad.17.1762880478419;
        Tue, 11 Nov 2025 09:01:18 -0800 (PST)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd0eb9sm2244495ad.96.2025.11.11.09.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:01:18 -0800 (PST)
Date: Tue, 11 Nov 2025 22:31:10 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        hrishabh.rajput@oss.qualcomm.com,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 1/2] firmware: qcom: scm: Register gunyah watchdog
 device
Message-ID: <b7ed3445-d004-4c15-b8f8-b2f92a621471@quicinc.com>
References: <20251107-gunyah_watchdog-v5-0-4c6e3fb6eb17@oss.qualcomm.com>
 <20251107-gunyah_watchdog-v5-1-4c6e3fb6eb17@oss.qualcomm.com>
 <hbxtbaoavlsw7pbmg3cfkbyx4nacjfiikckhqgpvlggbh6hu5b@jyporqecfzni>
 <263d1390-eff5-4846-b2c2-31f96fc3248e@quicinc.com>
 <3794bb0e-5e2c-4d5e-8d81-d302fa36677c@quicinc.com>
 <rt777beinysf5nuy57frn7okwglsl77xqikmvobao32bznhnkf@mzg243ddzlpl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rt777beinysf5nuy57frn7okwglsl77xqikmvobao32bznhnkf@mzg243ddzlpl>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEzOCBTYWx0ZWRfX0yVUf3KfJ0GU
 NZYzF0H45if6j/URufGESYMDhNIcvmU1pjGyPwexa+d3Ffu4o3SFlHbo1CBaAtLfN/rKLdDZvKE
 2m2uGb0HYsinn68LKmF4VJcsCjJH5s2fCjcYTUu+KsoWnGIlXlJcjLo9KHeAu4k8rpOPYSfEDej
 W8KQqCSvw84Qe2CsvwFh2nZi1ZRXSzOUi2roAYTHz7l4Tv6QxxXdsvMaYWSAw8E2llijTKM69mG
 yR2/n8y4P3wXOx6rdBUebZ6dBC98xyj/epZzOCXZvb9tVMDd5nqFCkexPx7mY1k2pdeEJMc5ws7
 etgrBVHYzXvyOWqIggfdT8miluf1ypJRHAITbVNeoVyJ9lvlwZE2PBN+RqmWkQF1LqNSuotgOTj
 UZF9sUMoNgf/0C+U01JkGohjVOmqbQ==
X-Proofpoint-GUID: nNEViKi_3OW4xLvQFRdpziZiTQYddwZ3
X-Proofpoint-ORIG-GUID: nNEViKi_3OW4xLvQFRdpziZiTQYddwZ3
X-Authority-Analysis: v=2.4 cv=UI3Q3Sfy c=1 sm=1 tr=0 ts=69136be0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uhQQHbFWYvhsl2siKBsA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110138

On Tue, Nov 11, 2025 at 10:38:27AM -0600, Bjorn Andersson wrote:
> On Tue, Nov 11, 2025 at 10:51:43AM +0530, Pavan Kondeti wrote:
> > On Mon, Nov 10, 2025 at 09:43:53AM +0530, Pavan Kondeti wrote:
> > > On Sat, Nov 08, 2025 at 07:26:46PM +0200, Dmitry Baryshkov wrote:
> > > > > +static void qcom_scm_gunyah_wdt_free(void *data)
> > > > > +{
> > > > > +	struct platform_device *gunyah_wdt_dev = data;
> > > > > +
> > > > > +	platform_device_unregister(gunyah_wdt_dev);
> > > > > +}
> > > > > +
> > > > > +static void qcom_scm_gunyah_wdt_init(struct qcom_scm *scm)
> > > > > +{
> > > > > +	struct platform_device *gunyah_wdt_dev;
> > > > > +	struct device_node *np;
> > > > > +	bool of_wdt_available;
> > > > > +	int i;
> > > > > +	uuid_t gunyah_uuid = UUID_INIT(0xc1d58fcd, 0xa453, 0x5fdb, 0x92, 0x65,
> > > > 
> > > > static const?
> > > > 
> > > > > +				       0xce, 0x36, 0x67, 0x3d, 0x5f, 0x14);
> > > > > +	static const char * const of_wdt_compatible[] = {
> > > > > +		"qcom,kpss-wdt",
> > > > > +		"arm,sbsa-gwdt",
> > > > > +	};
> > > > > +
> > > > > +	/* Bail out if we are not running under Gunyah */
> > > > > +	if (!arm_smccc_hypervisor_has_uuid(&gunyah_uuid))
> > > > > +		return;
> > > > 
> > > > This rquires 'select HAVE_ARM_SMCCC_DISCOVERY'
> > > > 
> > > 
> > > Probably `depends on HAVE_ARM_SMCCC_DISCOVERY` is correct here.
> > > 
> > 
> > Dmitry / Bjorn,
> > 
> > We are debating on this internally on how to resolve this dependency
> > 
> > - QCOM_SCM depends on HAVE_ARM_SMCCC_DISCOVERY which means restricting
> >   QCOM_SCM compilation than what it is today.
> 
> What does that imply? What is the actual impact? (Do I need to go read
> the dependency tree myself?)

Actually, I misunderstood how QCOM_SCM driver is enabled. It is being
selected by other drivers which needs functionality provided by QCOM_SCM
driver. So adding HAVE_ARM_SMCCC_DISCOVERY dependency does not make much
sense. Sorry, I should have done my homework properly. I was carried
away with `select` vs `depends on` approach. 

> 
> > 
> > - Adding #ifdefry around arm_smccc_hypervisor_has_uuid usage in qcom scm driver 
> > 
> > - Adding stub for `arm_smccc_hypervisor_has_uuid()` which is not done
> >   for any of the functions defined in drivers/firmware/smccc/smccc.c
> > 
> > We are trending towards the first option above. Please let us know if
> > you think otherwise.
> 
> What is this trend driven by? Is it coin toss or is there a reason? My
> gut feeling is trending towards one of the latter two options...

Thanks, we are going with #ifdefry around the new code that is added by
this patch.

> 
> But you're effectively asking us to go research these three options,
> determine the pros/cons and then tell you what we think, at which point I
> presume you will tell us what you think about each option.
> 
> It would be better if you made a suggestion and told us why you think
> this is the best choice - then we can either agree with your reasoning,
> or choose to ask more questions or do some research.
> 

Understood. I will keep this in mind while presenting choices from now
onwards.

Thanks,
Pavan

