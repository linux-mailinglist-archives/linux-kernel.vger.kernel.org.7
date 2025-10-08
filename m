Return-Path: <linux-kernel+bounces-845920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85563BC6807
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BF714E590A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B777026F29F;
	Wed,  8 Oct 2025 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DAl3M+Wv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EB1C8630
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953084; cv=none; b=NplccKmBPyPgYI+rmeZMyxc/8p4ThPphrt0J6eqGXC33lxj+UD9bvA0pucb3BSw++vSC2Eya6M1st3MOMXv1Y2M67xwQCqE0t8yAF0rgVTgLPPjknTyTAkm3Z03cIjRQ1/E9APnLMtrJDuvrB/cXg9t546hiMJJp7w1nbjDJXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953084; c=relaxed/simple;
	bh=EwqYI5I8zXLhnpiO5kcnc1i+3CNDLApU4a+BS1QMITM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdHQ04HRKCSISR/LvloHEnbVSlHg/43uLgB+kFM0MpFWmW9K4FYAu7wmOL3agi+56+/7pbRCLh2AR3kgGxYdjjNDOhuJGEqfT0RtmTpF2/AsfJe0ywjDkyKb6jGrlBSioS+f8Y262pPmy+3QCVeO7g9942NMYbn/N98T//CSA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DAl3M+Wv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5HTU020541
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 19:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GbQD2xoyny656Xp8A+uK/BNw
	LmiPop5rGNXGtX1WIt8=; b=DAl3M+Wv9sybFMG/fXKte7jvMLe0vRDP3hJS3rcX
	OGBQ4HO0B71DBRYs8Hx5768uJkjvsLZYSVuIRGodfpGM/ZRNU5XhghZ1CUyo1PIC
	166UHoX0b5pypW/OeUGqwlV4yryjSdznsqcIyBDVjnkhnipZQaui/GkDBOTaoYd2
	OI+Kyzs+mOsE3DIKE72l4AxGUGQQWNVRp8ahuHlmbP0cdog2DAcAd8PDkRJXzlFi
	2JA0kHfwuX8V0qItQxScAFp902cMEdsYHUtvPfQmewZ4lgGdizdD7SfELVngF1TT
	yyzckLnOR8Abj32pa7+y+/v/PlBs7nfS6gP7gn8t6p37cw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kge5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:51:21 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-818c83e607bso6069226d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953080; x=1760557880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbQD2xoyny656Xp8A+uK/BNwLmiPop5rGNXGtX1WIt8=;
        b=XcEiygtGTSuZa2V8kJDsldPZYjQaO2917zCJUI9hJ2TrEx3PwNHDX5l/SYT6sztZQg
         G1Ioq/DsBhUhH0zf3isFQ6iDHHh0lFSpBnMFjROZpBTt3v2l/L3NMtk1vodCuhoLHAgI
         hJmat5uiDg/5CvqX3sNe3vU97XWhAS004BwZXxFM7tT88W0UfCLZHk9SGyG9xdBc+9Px
         flQ0rfRJEYtkQ9oS2Gyh0mvMoVFgCHAnsW5exULqzYy9GkVOX7xagnYPvAjd+S9TglnK
         +fPgjHgST8tqvYK+u6m4a7lNcdMnc8eVFMRFvSyA/0H0xO9sQlcqDCUJKwpxI/0RKOQ1
         rUsw==
X-Forwarded-Encrypted: i=1; AJvYcCWQZtVXr3wNlwQi9RmcE4my5XVYj8isgl3aZ7ER2mrlAOUNOGRjrFZ7Me8pzHetm4ICPCtsOzTtu5hCCQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJE1rs/3FPBPvyMDFNU5ak/k4kXrOLQIQrMZnGgMZXeoWG260
	B6y2q3jAQ43fXJSalPT2UqanxhuTqRv3yVWLzUfaLuvj/rpP2F2C9R/L2mbb3oe/Z9krlCsoffo
	ajQmoLCXD9xYEDoF/d82O8TpwaOerNgL4ayutndhllDR23cQX9pLjCc9diX26MjvOzm8=
X-Gm-Gg: ASbGncu0FuVX7YwvvmifwMGNU7o0DfK0OFC/tPwjtKIL1Rlmhu6eyzINFlLe1apcey+
	152y3jQlRf99TjXlrkOTBjCCQnOvMSweN2b74Sk7dtSenIwciATVyz/aTGbDPxlwI0VdNCNT37A
	oOxPiiy3vovCwtVRe2pJNhyO5jKVHCBZKNTY41FmfnqUNVGOrDImRuY9nQiZoyl1rSAKV/7iWJ8
	D7j9OJh5gJGdBGmGjULfZrQTf47IZV7cayAs1QJFk8kliEVktoX/zduXizMF1fcD2vIf5NotoC1
	vQDak3TjE92tbYpi1hhF2d1X/7FtiT37efGqjmPLbnUferhtqkkyyk/hY/8/G0HbfLR/eED6Nh9
	y1SKnsqgLsjOEkb1slmClW7F8eQFR3GiJO4mtWgiRtmeejrumCQdOAxgSpg==
X-Received: by 2002:a05:622a:1190:b0:4da:256c:3d42 with SMTP id d75a77b69052e-4e6ead66d3bmr74774871cf.59.1759953080054;
        Wed, 08 Oct 2025 12:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpHn/H4dhV4XbQHYMbUSjn4irkOysXPJz8YXz9MbAxepygkEk7N9h9yieHpzim7GqYVkeTaA==
X-Received: by 2002:a05:622a:1190:b0:4da:256c:3d42 with SMTP id d75a77b69052e-4e6ead66d3bmr74774511cf.59.1759953079206;
        Wed, 08 Oct 2025 12:51:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ac2349fsm296878e87.56.2025.10.08.12.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:51:18 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:51:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        David Heidelberg <david@ixit.cz>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, mark.rutland@arm.com
Subject: Re: [PATCH] arm64: head: set TEXT_OFFSET to the historical value
Message-ID: <obcgfnmgdemf5gtc7gdaj6nzoa2rwxsc6njt4fd2ouwzqj4y7y@ztxwyyoepuud>
References: <20251006-arm64-text-offset-v1-1-bf0e8a27383b@oss.qualcomm.com>
 <aOPLv_-f5sNGtG4e@willie-the-truck>
 <CAMj1kXHhetfN_bY5AAqqfC4=N9yQCO5R_n7H0BMXZ2VXudv5pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHhetfN_bY5AAqqfC4=N9yQCO5R_n7H0BMXZ2VXudv5pQ@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e6c0b9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EArQ5nPrA_zcfZOwlBcA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 62zwNfHSfLIDcXKopecGHPgav8-KB91g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5ZfPUJ4QDvM1
 w3EEJ4e2IUtf+dluPiu6bYf3RTQoANisnV7TYnyeDOkryzP+r08dFupiwV8UcvYPA9uJ2Qt3P+6
 F6SblhDbv/fw3k0A7PhMuPsltaiZCjwJ6BMncb+q68LveWAm7Qjo/qi7IB5rpxdrKpdloi8X/xC
 2Mwz2+5yUxezZ7VeGpcaMVGTlAraA/XFu/tLC7p62YwSmJeVJRkm8YeyDaZZgsT5FBO7tCAqg3O
 iR0ar69Duqmh6IRK9lpxLgRoEO1bg7vaki4LLHorvgqxMolkS9vBMpKgwlolZ2dKJDyNlAy44rw
 yR+oRp/BRDLeR60LWeKrJ/jLMJElzWstE0nDB/SDK9rSL6QE1i9uLrK+7iFoANVaXXEeKIrHScb
 0cvjLf2ee+8A3HnjpywBe6X5hMVJug==
X-Proofpoint-ORIG-GUID: 62zwNfHSfLIDcXKopecGHPgav8-KB91g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Tue, Oct 07, 2025 at 01:46:08AM +0200, Ard Biesheuvel wrote:
> On Mon, 6 Oct 2025 at 16:01, Will Deacon <will@kernel.org> wrote:
> >
> > [+Ard and Mark]
> >
> > On Mon, Oct 06, 2025 at 01:21:04AM +0300, Dmitry Baryshkov wrote:
> > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >
> > > Historically arm64 kernel contained (almost fixed) value of 0x8000 at
> >
> > 0x8000 or 0x80000?
> >
> > > the TEXT_OFFSET. The commit cfa7ede20f13 ("arm64: set TEXT_OFFSET to 0x0
> > > in preparation for removing it entirely") and then commit 120dc60d0bdb
> > > ("arm64: get rid of TEXT_OFFSET") replaced this field with 0.
> >
> > Given that we made the initial change over five years ago, I'm struggling
> > to see why we should start caring about old broken bootloaders _now_.

Well... because support for these devices wasn't upstreamed and so a
similar patch was being kept in the down-upstream kernel.

> >
> > In fact, I'm far more concerned about changing this to a non-zero value
> > and having more recent bootloaders misbehave.

I see.

> >
> > > This caused no problems so far, because nobody seemed to be playing with
> > > the extremely picky Qualcomm bootloader as used on some of Google Pixel
> > > phones. Current attempting to boot the Linux kernel on those devices
> > > will fail to load on those phones with the following message:
> > >
> > > KernelDecompress failed: Invalid Parameter Kernel TextOffset does not match
> > > Error calling BootPrepareAsync Invalid Parameter
> > >
> > > Since the kernel ignores the field, set it to the expected value of
> > > 0x8000, unbreaking boot of upstream kernels on Qualcomm devices.
> >
> > (same typo)
> >
> 
> Just setting the header field and not updating the base address also
> means that the boot breaks without CONFIG_RELOCATABLE, and you will
> get a warning in the kernel log about the load address not being
> aligned to 2 MiB.
> 
> So I don't think this is the right solution.

Since most of the people build the kernel with CONFIG_RELOCATABLE, would
it be better to set it to 0x80000 for relocatable kernels and to 0
otherwise?

> 
> If this is really something that needs to be fixed upstream, we should
> just bring back TEXT_OFFSET in its entirety, but I'm not convinced
> that this is really justified here. As a workaround, you could just
> add 2 MiB - 0x80000 bytes of padding at the start of the image, and
> add your own header (as Will alludes to as well)

Does it mean building a device specific kernel? Or just packing
everything while building the Android boot image?

-- 
With best wishes
Dmitry

