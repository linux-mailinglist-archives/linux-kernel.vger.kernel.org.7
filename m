Return-Path: <linux-kernel+bounces-769705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF97AB27238
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CA33AD4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF3283C83;
	Thu, 14 Aug 2025 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MU9v0qYU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E3281352
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211869; cv=none; b=uCtILDjHE8y/MWXo8fbmtGz4Pq6U3dBRRntT1EU1Fc3rXUm9sy2yCACkYDRCv88rzgYBlJI8EQbPosGH1QEdVl5CDeD5XbEMj2vqOWI24E/dWpocMoZh7ELgsc4tF1cBWnXRmzP8m0Ph4gAmxgrz/ouWd+GOOCjJKSmf37xtgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211869; c=relaxed/simple;
	bh=VsRfvsLbvMPweRFwX9yd1l+oGWIeHLlnNvKbVKtNBMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDZe5Icf7F83thQnzX/Gmkl6C+UhFFg25JwLs0/DDWMepMN/lFSQbbDxu51axRiIVt/Zoj8TfwMSW/+3o1qBm/SGYPdYPdHXolZcWhm+qfRdlp9JwTZ93u8TiRGRmN9v/y6eMN2VSngcVHd0pcw4FiqsMHjSdCY4tFfpWcI26G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MU9v0qYU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHW3EO026997
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=At5mFz1vkSy2faOkC/EtnV9d
	eGFeKo96q35XzSytUj0=; b=MU9v0qYUV+xumib0ODJKcZrNBxxl+lSpjy8TNlgZ
	9v9eV1aYSpbpAPYits6nrach4CQU1KixVp9hLJpHsjZK+TLqDyWYLK0XatS/X99j
	iV/k+fwTaLr10voXU1QcBHyEBAearCgIja/3rEWYtwEchiOQ98/Dg8aA2lzsiH+a
	2poOjUwxiMiLVi/yZ/TLJ94FLK1cxSCwmdzBKQdEOSoO/7vxMN03f6FTwPTj2D8e
	aGB+s8oYduUEOX5pm8XdnI08aq87QrPJdzckw6ErIOG1WRnA9NeC1kif4f/igcE6
	d4B3d6QUGsqPKqNsAfP03KAT3oXupMaFK4WhdJEBquwQCg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjw6cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:51:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e8fc814so1279603b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755211866; x=1755816666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At5mFz1vkSy2faOkC/EtnV9deGFeKo96q35XzSytUj0=;
        b=j8eIKOmW8kW8Z51KAN7gwCTrzRb3negrFYk1phx4aigG1Id79EYJY44YBTbleJkOmP
         WvUYT+P0KuEXJaVVwP8JNy5Cb4vHxbTJ20HgzCr2nxXho2nWHgFcvfhG38Q3pC/TiWKD
         kPpYwdIdWcYlAOMhWnnnC3zpRYVU7lXkaLlWqdfmA7wlnYis1uZS6nEKzYJr8Cc5H7Ra
         ww8CTbWjs/TX961Zh7MsRcrMWP1PCZmDLP02M0mOgcfstG/wRodxKucgGgMPLsal3Hk4
         jB7OzyBRXlc8EUQqTGospKHyiJAN5i1XIm9A0ER8R00oNC1UKmLUJdW3RKbKAXJzVoxn
         TwVw==
X-Forwarded-Encrypted: i=1; AJvYcCVEkmhuwgHqkDni3kAnBHRNvub9S20y2TLdp5X3ifMMXuQ9nNs78p2rYK3iWmP2CaciddkRlRbXaVQZF/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/tvqVesB+kgJ39jcMDiCZ/lRbDNyvlHYn5ZmDRYdTQAR5kYy
	DKO9hvwNOuHGOw3fhN54IEnatgbiEgW7tZIX//iwh0IGKm2b/hoSlhq6aMp6us0At2+wmed/hvV
	xD/JunLa/eC3gd9e0N9nNgvxC5PO0rLvVQZp67TPizYw7EbZpfJHc1zQn8hrg1J6m8jU=
X-Gm-Gg: ASbGncsY8siJXIywMDn9j5XPasxeRZOwAbeQU5DBV3LF2i6fqfw7ShwTTUdEKT0/fx/
	9RAuIju3X+pLPz7i0TuoNvY5qGDA4dldWFYKXVFqoCBr7R/oKVe75nb/UHVP9xuNa0PDzwc7drh
	tgrbKr3naP7pE7WKr5sJev8uzqnN6hs3s4y7yfa/91HBngkUBKMhq6hlb/KpUPvaJKy5VthDBN2
	SYjevyR4lV64/c8Go7a9tzVnqL7F5LsQfre/7Q81Mzt+araOF/xtZD6VdruMHxuLQutcHYO6D+q
	DbGD4kCziVssoLr+XOMJE6+xL+P8+abadYkftbwcPH/+ImvsjypPP7QgJ2aZjIR8fRZjmWYM+3p
	NxDT8msYaBNCLahCwggGNxIQ=
X-Received: by 2002:a05:6a00:a0e:b0:74d:f997:1b45 with SMTP id d2e1a72fcca58-76e31eedebdmr7910293b3a.8.1755211865647;
        Thu, 14 Aug 2025 15:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE82TPNJ3ll/m6MhFabEUR14MGIKrwXTkhR8iXZvn445BnTFS2znQUAA1pHvzWHlQz+zbMePQ==
X-Received: by 2002:a05:6a00:a0e:b0:74d:f997:1b45 with SMTP id d2e1a72fcca58-76e31eedebdmr7910261b3a.8.1755211865187;
        Thu, 14 Aug 2025 15:51:05 -0700 (PDT)
Received: from hu-bjorande-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c61705bd7sm14513362b3a.31.2025.08.14.15.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:51:04 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:51:02 -0700
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>, sboyd@kernel.org,
        mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com,
        taniya.das@oss.qualcomm.com, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
Message-ID: <aJ5l+0Fv7nm2vKuZ@hu-bjorande-lv.qualcomm.com>
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <20250716152017.4070029-8-pankaj.patil@oss.qualcomm.com>
 <28ea2b11-a269-4536-8306-185bf272bd60@kernel.org>
 <2yekmjqihkzsfjr223vepigfj4hfruleigguhrlekp6s7riuxk@ta5kghr2kafi>
 <4559a710-8b4f-4988-b063-40486fe0ffe2@kernel.org>
 <2025081338-backwash-oak-0677@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081338-backwash-oak-0677@gregkh>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX9TFgSWHP5wk7
 QKSkhknAESAZ8s/MNIs7nshxVFKdXl9hbsEpuhegnbT7PBn/tasuckdHACCe3bzQ6kkl9UVQ8O9
 Qsj2v7LPXbrHgL9DVYUFYnraOyu+hEsbl1wrTAE699D4NhLVccVqkD1ITnxZXDdisDIgVOARKcB
 7QnBLd5fXdvKakbq0q5t6AUmUfjFSWrXDYRyPLBXH1P671alt+5YbJv9dOOCEUpsCQFlHNbU/IJ
 awFFTegTZXY+OWPTP4aSTwb+DIcDgcBas46LZO8+s0KW/eZqSRVZS9KfNDRgccmGFgvizgeeZ10
 L3eyeB0LACAiVE0WYpolpHePYdhLTRUWR+ccVgTTpMUpSmiBAFUJg+8M5lMbu1v0j/44mv6Xdgn
 1E/Z4zOE
X-Proofpoint-GUID: o_fAyGOQPX7ufQSwHy0-tNZsett6yxPd
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689e685a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=mDV3o1hIAAAA:8 a=xkPlMqQ6EUx7zbaPWWUA:9
 a=CjuIK1q_8ugA:10 a=JEtk54xxEQEA:10 a=UDyAGHZwfzgA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: o_fAyGOQPX7ufQSwHy0-tNZsett6yxPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-14_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On Wed, Aug 13, 2025 at 06:19:20PM +0200, Greg KH wrote:
> On Sun, Jul 20, 2025 at 02:18:19PM +0200, Krzysztof Kozlowski wrote:
> > On 20/07/2025 05:46, Bjorn Andersson wrote:
> > > On Wed, Jul 16, 2025 at 06:28:15PM +0200, Krzysztof Kozlowski wrote:
> > >> On 16/07/2025 17:20, Pankaj Patil wrote:
> > > [..]
> > >>> diff --git a/drivers/clk/qcom/gcc-glymur.c b/drivers/clk/qcom/gcc-glymur.c
> > >>> new file mode 100644
> > >>> index 000000000000..a1a6da62ed35
> > >>> --- /dev/null
> > >>> +++ b/drivers/clk/qcom/gcc-glymur.c
> > >>> @@ -0,0 +1,8623 @@
> > >>> +// SPDX-License-Identifier: GPL-2.0-only
> > >>> +/*
> > >>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > >>
> > >> Missing date.
> > >>
> > > 
> > > Per updated company guidelines we don't want a year here. Please let us
> > > know if you have any concerns with this.
> > > 
> > I remember the guidelines and they were about publishing your code, not
> > about contributing to open-source projects. And whatever you have
> > internally does not cover us at all. You can have internal guideline
> > saying you need to buy me a beer or I need to buy you a beer. Does not
> > matter.
> > 
> > That above copyright statement without date does not adhere to expected
> > format. Explanation how this should be written:
> > 
> > https://www.gnu.org/licenses/gpl-howto.en.html#copyright-notice
> > 
> > The GPL-2.0 license in the kernel also uses date:
> > 
> > "Copyright (C) <year>  <name of author>    "
> > 
> > There is no option without date in the license or GPL faq. I am not a
> > lawyer, so no clue whether this is what we want, but I also should not
> > be my task to figure out whether different copyright statement is okay
> > or not. It's your burden.
> > 
> > Or drop the Copyright statement complete to avoid any questions.
> 
> Note, we don't take legal advice from the FSF :)
> 
> That being said, any/none of the above is just fine, there's not even a
> requirement for a copyright line at all.  It's up to the author of the
> file as to the format for what they want to do in the end, none of it
> matters to the actual existance of the copyright itself, which is
> implicit with or without a copyright line.
> 

Thank you for your guidance, Greg.

Then we choose to follow the format used in this patch, without the
year, going forward.

Thank you,
Bjorn

> thanks,
> 
> greg "I talk to too many lawyers" k-h

