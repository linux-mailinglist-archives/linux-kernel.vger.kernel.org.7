Return-Path: <linux-kernel+bounces-813024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65704B53FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5318A03AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A402F4A;
	Fri, 12 Sep 2025 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fmzof5cE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950714EC62
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640147; cv=none; b=deHl8vlq4feVUva0XPehdwujjF+rykAMlQQ0Mbnpyu8S6M9Hy167OWrjKs3RA2hZGYhYZHXBZwNy6GfZP/MyVVKJAx3uaYi0ZDEFtIaEyu73/q+VAiPsK41eeVy+Wtq3V4a7LBgesZ8kwfUiksp2+UK3RNSnc7zVUEyMDpuDGh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640147; c=relaxed/simple;
	bh=mBPv3yMMYQAv8SWn18U10xx/gHV/3T4mCcLgppUbHqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfpP3UGN3DBgWJ5BFIs4v7P4y22xU1x30IVjqMPhp8ATO9HSFU3F21IOFs/PcTrsUvHFBhM4xW638/m+1+Jz39JgjAJw3kErTKZu7maWs5YdqLTt3QYKzutSRhQNKptaEFM0TH0iIDP5XT0lWucDrwcJcnUxXI4e31kQxE5ksFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fmzof5cE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BIK2Ho006008
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BzTMuuDjSttsP/lC8DaVWg4q
	sEsoHITtFwASx4KsovY=; b=Fmzof5cE0h2EPMjPraJEqiGNDRktmxmJwEfTPGzD
	jVTjtx+XTyCyni4b9+c0wTthD6OSw66uoCjXGWx7dw3GeylX5Tm0lcBw+RIW/C9k
	hZchCguTrYBrRhcH/Mur1RSt1FH9++AiAihjKnnxsDo8zkXurTnypvV4NCQrNKr0
	KAxBXudjKwKbs0RoLNXoYDBQEDKKaiCHMPkD1CL83htE+5Rtc0+tIPNuQJZcQNWz
	ySGI3KyeqluX2CE5xgVuTWifItSnb22isUD4yYHvnhZsH5WTeRTkpOMAgHh5vg98
	NbSZQ72NIkrKUSFfuf1QW4wZorixjik7+cDRIawdsDIvbA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8ahrb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:22:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-767e5b2a74fso4922826d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757640144; x=1758244944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzTMuuDjSttsP/lC8DaVWg4qsEsoHITtFwASx4KsovY=;
        b=tvPkkPxbcwHeA8OPS5X2LfWaUTdq40qH6yOR2CUYI9rTjYTCarFA/J1kIwX0bP0p3V
         iQWjJDIkVpSoDnKNYB4Mx7HQTw0Ui/J9JpyRiCE8kNmOs06EUHN8RK/IQmHxAvg++SJm
         3KBQjVqyr12Lxr0+gDIk8d8OdWxPRH80DIcfxc9EOAZCIVUO1r4DW3gfzxyco1Xso9/i
         G0l+IDG5zEwndAj0tVSqLjky76ufBO71IUpNRz/11dGRrJLoVWBJDP2H0Q+Tz1SNcEZ4
         a8ihQ1Czcycml1XZCRj6wuUc+0oOD5QByeLTZUWowePxzjCTlEjuod+ZVKw1GU0xCcxN
         TbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj/2aybDHpwQUAyaMU9ZhqwGXQS2ZMuSa6NFCS+WRykRpgcrBr5TaZJ/x0Gv2A3opLt2zGZB9qltXehFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPKrN4np2IDUncaKWqcyAS7/B7xGgz+G+TdKuRU/dtNp0c605
	3FxcoBwFzNBRuKW55gdviWUljdL/OYlbFVj2okfFHEs7y3OqkCicknxyloikdfPnC8TlDm41ulI
	qvNsnAR/D6cKXd8TBqCPBAOy3hvSX0up0InhNXuzFV0Ut8kOfj7Z8wCz6rhJLwSBVk+g=
X-Gm-Gg: ASbGnctj7HHNvRwdSsBZf5wI7437iDgekkQol1Tkfo9VNVsKNyaUvHc9QUq3+ur6UkY
	8QxmeAnsMyiIOi1xkZmYlvA3NuUgv64Xm15FgupSVMAH7HH9oypMuSH6KOSeRUrG5fYRwi3Kz3F
	bHGffqvN/iBNJPRYefqmQOB4SvcrJDlupNT2hg4BTKCzpyLYjg0Spuhxhsg7SWTGiRDwPlLB5aW
	aVknp3PDMunya3miiP+XxlWIB979UQLA64OAQNw/RQpA9y3h/HFIhzmYwVNDVRCqyMXpUAQEILg
	R2ikpZsUvbu0EwMBpn1BmCstBkoNJ88vj2lM6msadqqDYzF1eH5CdWhsPfIJ0u5ILfiebCYnZ9T
	+ZUrYr+mMjOpFEig9H/LbUDK0TIxS4+HIjg3dei4vRgXw9ZjRKAAa
X-Received: by 2002:ad4:4ea3:0:b0:70d:f55f:ef97 with SMTP id 6a1803df08f44-7621c32efaemr64971576d6.1.1757640143660;
        Thu, 11 Sep 2025 18:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa3DVgCbahRQBJw1LnRpwbmCl3+J/uxTrOa/Dcg3ZkKhfb7sCMmlslgoZeHS5Wv7jGebaung==
X-Received: by 2002:ad4:4ea3:0:b0:70d:f55f:ef97 with SMTP id 6a1803df08f44-7621c32efaemr64971436d6.1.1757640143246;
        Thu, 11 Sep 2025 18:22:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1b4920acsm5476141fa.58.2025.09.11.18.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 18:22:21 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:22:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: qcm6490: Introduce Particle Tachyon
Message-ID: <2bc767td7gw4bxts4k4xwhdiv5tgxmpyjwwv6nqeatvncdov6c@u7gfilzxgomp>
References: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
 <2tnzsjw3xy5jct4bcmahcwhjbzlmyxgcx6fzlz5qrzxume2uoy@phpcz6mnydlt>
 <nweaxuma3dkhzcc46ztfhmxxrchgidxjprc2tz5eahle6sxsuy@qvczmexs4qnn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nweaxuma3dkhzcc46ztfhmxxrchgidxjprc2tz5eahle6sxsuy@qvczmexs4qnn>
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c375d1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=7AODkVuKAAAA:8 a=K4zJXCh-jB-3kEFs_x4A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=sRHRY8H3vKB1GfNvUtpx:22
X-Proofpoint-GUID: oqkSo48dkjdwiqbQLln6_A3TjN2tFQR4
X-Proofpoint-ORIG-GUID: oqkSo48dkjdwiqbQLln6_A3TjN2tFQR4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX+uKEbKoqI1db
 kelO/WmodsyOGhr3oT9aenTGdq9vSEnQRDyco7cI5e+NpmfEJ0zPvgo7eOOFkzsnpYYeTuTbOK0
 Wjzdy5jzevLFPZiaGasdxk/eXsZcxYkastvy+U3Dd5DoOq8WEQqS+FAr9NqZLDFTNxfDLNrPsZp
 3aspbT95fDKmPGh3haKs+Sm8TXNdrfWQxFKzvsqxd6M3K4Oma+4zkNC7RDavsdaXBEotPnMlEo4
 UpV1d4BOH5q5Up7lVan/V3FiL3+ES5NLXy+VOYnqutvnrPb88d7qUJyJXpqiiCjWu3obec7lmU5
 NJymM5Zmam5xD7Jh1U2gY6AXaTrq8XI7EInJXfFFpp22BfLBKwLKqRON7UyFmrTFraOl481ia6D
 BsoAr7zU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On Thu, Sep 11, 2025 at 02:19:39PM -0500, Bjorn Andersson wrote:
> On Thu, Sep 11, 2025 at 03:01:35AM +0300, Dmitry Baryshkov wrote:
> > On Wed, Sep 10, 2025 at 06:05:36PM -0500, Bjorn Andersson wrote:
> > > Introduce the Particle Tachyon board (https://www.particle.io/tachyon/),
> > > a single board compute with 5G connectivity and AI accelerator.
> > > 
> > > The boards currently ships with the Android Boot Loader, but replacing
> > > this with abl2esp allows writing a EFI System Parition and OS partitions
> > > to all of LUN0, and a more UEFI boot experience. A prebuilt version of
> > > abl2esp is provided at [1], as abl2esp-v6.elf.
> > > 
> > > With a (very) recent version of QDL, a flash programmer from a Tachyon
> > > software release, and a full distro image, this can be achieved with:
> > > 
> > >   qdl prog_firehose_ddr.elf write abl_a abl2esp-v6.elf write abl_b abl2esp-v6.elf write 0 image.raw
> > > 
> > > The following firmware files are currently used, on top of what's in
> > > linux-firmware already:
> > >   qcom/qcm6490/particle/tachyon/a660_zap.mbn
> > >   qcom/qcm6490/particle/tachyon/adsp.mbn
> > >   qcom/qcm6490/particle/tachyon/cdsp.mbn
> > >   qcom/qcm6490/particle/tachyon/ipa_fws.mbn
> > >   qcom/qcm6490/particle/tachyon/modem.mbn
> > 
> > Is it locked?
> 
> It doesn't look that way.

Then anything preventing us from using the default, non-signed FW?

> 
> > Would it be possible to Particle-signed firmware into linux-firmware?
> 
> That is something that would have to be discussed...

It would be really nice...

-- 
With best wishes
Dmitry

