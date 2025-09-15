Return-Path: <linux-kernel+bounces-817612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8FFB58480
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A64C3D66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7292C3756;
	Mon, 15 Sep 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hct3YM5V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407A26AD9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960573; cv=none; b=e7+mVmsyefQ869XSz5rAMWUsEkCF+45TbTyOSYuV+RgBC76F6m0Jx+A0vYJWm4IE8yAkXA/NMX4iB12ZBx4Dlrh+E/sT8CstENYPtIAd4fUp2yaG1FI/sjW4BsjJ/ybhDDHovqxGRpceB/ik+Jdo78XA8GIaGQHbF9gi5wQMtqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960573; c=relaxed/simple;
	bh=gKyS5sTdyjU2bT+xqX3t7C5k8OZgyBBrIG5tqYiW1p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVNTa8T8UIDpU6TXLTDf/AOXBAA3RiCtXcm86doCqikQLbbxmpqaz7dOLcXIdYBQhfihpEJlbjKRhOGK/w3QVFjyyZixLroKur5uM59/Lpb88EoJBTrHAunSv0zT3DLEJEABHIuXaUDD0qAi/46tmj5yXsJMW5wglJrPPK2zDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hct3YM5V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEUUUl005778
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F1LjIqAwbyBFY61E2h7fViEwka8RdZtiySWmXgTI3a8=; b=hct3YM5VCcVXNXsm
	JNY1lgpvsscIGnVixGxMLCvDrkhKt9qGRTGAM9LmAP7OU0I6uH9BKx/svAepFs4x
	gk3TQWQFnHaFKeMZw6i29fMtTmBummUwei5QiW1UpabMCTTKzcUNRels/Q56xoYI
	88+6YHTa7s7+RhjG5fbBSLK6fVzkU0oj5Ktvn12BdJfAb70MWQQsFd7W3Z+i646E
	aqeDuItCY7OXWCjW7RjFhZxlgYlvN92LtMzWuRRw9I/f6y0jDvUJNDKUFHZK6QH+
	XQv+NptwYm4OgjT5VD226EtbH3U/N6v3K++W+VMvg5iUdh9CjhfvU90Oga6RZZae
	BDJxRw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snnvsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:22:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5ee6cd9a3so95774811cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960570; x=1758565370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1LjIqAwbyBFY61E2h7fViEwka8RdZtiySWmXgTI3a8=;
        b=mAD5DiUA/Uoln2v1wjVyznCn1uj4AP46M9MFW4iY/QWRWO8bBZ6V64DCVDU3wiNlda
         7qPGNySEVQNOtuspY2p6tXw3nsv8UHyAHK3FfSGmN8j0suuiPEoqqt7ZGTW7ZHRzl9uY
         0BfT6UBQAvHczvW2C5k2T0dEutmbu/Wamw0naaT3xDiAbzrwdhG5sc63Uhr481XJL0kM
         hM5zCmCbhXBoQkuiRahFG8tNP3sE9OYosGgiCB5RjV+bnFE3OM0b0auY9sCAoD6k+3nW
         Kl4CR5LF4tJCZRuZUSGdBSJgTl3biiptE5hCFzPKKDa2y219QIGo0honvppkfD+tc8Z0
         wLNg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ENX8x4OEykNT982jhVX2UviBHFjK3Beuy6PWJUl2uBekdfhiIQKwBeeImbair0Cbd9hswOlTanVmIGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevoPspokB1sSPvJTBbSf8L6r9Wwmw6CkR2Ws8CsvOfEiScCek
	sxpUzNyofTn5b3sCOj8m0XjSEULo3KBEvwvD7+DCbx5H1tawd/vv/o8avAOpksQ0z+xkXPNEe1W
	Kt32vnweG4lvc/R+Glm7wORbhiv24yADknxZVA92F9cWH8NYjjnUa9TU8Vk6dLjjkNLg=
X-Gm-Gg: ASbGncsO/ozEgJXLmi6nwo/qGaZS21E2p5l5t6li9LmeD5NtMlGC1G8mPywCZkIn/Bs
	CiIcJrNiErX4WJNo06UpZ2pk6PhoDtw7sBaWDPBvxMQjt1GW7txzWGwHVZLNqWWPDA8hdmQR/my
	hfNs1chs5x1VJwt/D2EAAImbwHrUaD+eM/Neg2Yd81/h+/TaLYigSPJka4GtbA4c/B82ycAtZwo
	zA0wiqQOH2o//STKvN9bieNA3EiuGs+eU14tNBopN8CQ9Avv8Q5io4MdHu+ZkJlKgP1o+tSRTmP
	wJT/G7LGaQI/rOkMcoHNPpBmSoEUVn8PagG5kmUBejoqWAfEqRfN0DWUzT7PSzUisesa+jgrLom
	Nz0tvU9RFfK6kzrtaa5HjC/ov7berPQg/pbQNK8W6XYbUxToF7KbW
X-Received: by 2002:a05:622a:2448:b0:4b5:ea1f:77ec with SMTP id d75a77b69052e-4b77cf3fd63mr188714991cf.0.1757960569959;
        Mon, 15 Sep 2025 11:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAuVVuM0n9l3Cg1YMA/er5S/o95KrZuuWZTRloeO1lERKI/EYVWxGvd6dsy0z2sc5Sm5CG7w==
X-Received: by 2002:a05:622a:2448:b0:4b5:ea1f:77ec with SMTP id d75a77b69052e-4b77cf3fd63mr188714401cf.0.1757960569240;
        Mon, 15 Sep 2025 11:22:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330d2csm1333852e87.58.2025.09.15.11.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:22:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:22:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v6 2/3] drm: panel: nt36672a: Add support for novatek
 nt35596s panel
Message-ID: <ylo6kh6wqzpedoibc52qjbb3fbmiofclfjj2zog7sufn4rqyvf@jxcxjft56czl>
References: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
 <20250913-nt35596s-v6-2-b5deb05e04af@ixit.cz>
 <xi65tabv4sgblzmw52wxci5wsrdahshvos5we5wko4kfcfyozp@y3vw5gt3elwv>
 <ad1764a3-12b3-4c30-9b79-313d9c1d37eb@ixit.cz>
 <a5zz3piadpmi4atnnafa5bfz32da4nioob7xsmqtyhgpjpqz5c@zzoa72rgwaet>
 <4a718ca8-cc40-4642-9f88-b654a90045cf@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a718ca8-cc40-4642-9f88-b654a90045cf@ixit.cz>
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c8597b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=Vt2AcnKqAAAA:8 a=e5mUnYsNAAAA:8
 a=pGLkceISAAAA:8 a=QX4gbG5DAAAA:8 a=KKAkSRfTAAAA:8 a=wCpFDx9_YxCViFKvQc0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=v10HlyRyNeVhbzM4Lqgd:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8LvAz2EDJIcz7rfv4VKdyLQ_iVfj30EU
X-Proofpoint-GUID: 8LvAz2EDJIcz7rfv4VKdyLQ_iVfj30EU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX3dAjiGpaqL9S
 kL2ivDM4B6cpTwSqhXC1QKY+g6GEzMqAing7LQ1Yaqq04+Z/w+OKPhfmrXEXvxNIKCPoCxrys7Z
 A0TFXSAUuqMY1X5EJHAu8xppg0GjwlGM8YRUV9aP8/OumMI2bprYjk6B3Hy8d25MenUZLeFnCPN
 BPFNZdzlmAf6ai9aLzjT5xytAnPMfFCteMCB49Axt6N/n8uCSzE/mEB9sw6LUqWTgU8jnVXFPIT
 juNn0Xb5vXBdJ3Epxl1ZL67Mgy8HOP18bDjNPjkpUQ9dq+K//9ziLwz94SNMgS07kmj6jVSdWJt
 jwf1k0BAjCw3AoRm08zEKaKWEbXqZXjbpDADwsv+nUS28J6SgeHZMpK18CDkW8cTq8l8NpCZHtR
 CrOplEyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On Mon, Sep 15, 2025 at 05:06:51PM +0200, David Heidelberg wrote:
> 
> On 15/09/2025 13:11, Dmitry Baryshkov wrote:
> > On Mon, Sep 15, 2025 at 12:11:49PM +0200, David Heidelberg wrote:
> > > On 15/09/2025 03:29, Dmitry Baryshkov wrote:
> > > > On Sat, Sep 13, 2025 at 09:19:48PM +0200, David Heidelberg via B4 Relay wrote:
> > > > > From: Molly Sophia <mollysophia379@gmail.com>
> > > > > 
> > > > > Novatek NT35596s is a generic DSI IC that drives command and video mode
> > > > > panels.
> > > > > Currently add support for the LCD panel from JDI connected with this IC,
> > > > > as found on Xiaomi Mi Mix 2S phones.
> > > > 
> > > > Why are you adding it to the existing driver rather than adding a new
> > > > one?
> > > 
> > > Hello, originally it started as a standalone driver (see v2 patchset), but
> > > got merged due to similarities.
> > 
> > I'm not sure, you had to get rid of the two command sets. On the other
> > hand, adding a new module will add a lot of boilerplate. Let's keep it
> > as is. Please add some notes to the commit message.
> 
> Ok, I found out in the meantime that Alexey is working on refactoring
> nt36672a, so we’ll coordinate. I’ll likely need to rebase this changeset on
> top of the refactored nt36672a, or possibly move it into a separate driver.
> 
> See https://github.com/sdm660-mainline/linux/pull/114/commits

I think it fits even more after refactoring. I hope Alexey will post the
refacrorings soon.

> 
> > 
> > > 
> > > v2 patchset:
> > > https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg404290.html
> > > 
> > > If it's desired, I can switch it back to the standalone driver.
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
> > > > > Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> > > > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > > > ---
> > > > >    drivers/gpu/drm/panel/Kconfig                  |   7 +-
> > > > >    drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 225 ++++++++++++++++++++++++-
> > > > >    2 files changed, 222 insertions(+), 10 deletions(-)
> > > > > 
> > > > >    MODULE_AUTHOR("Sumit Semwal <sumit.semwal@linaro.org>");
> > > > > -MODULE_DESCRIPTION("NOVATEK NT36672A based MIPI-DSI LCD panel driver");
> > > > > +MODULE_AUTHOR("Molly Sophia <mollysophia379@gmail.com>");
> > > > 
> > > > ??
> > > 
> > > What's wrong with it?
> > 
> > I thought that the module can have only one MODULE_AUTHOR declaration, I
> > was wrong. This is fine.
> 
> Yeah, it's not usual to have more than one.
> 
> > 
> > > 
> > > David
> > > 
> > > > 
> > > > > +MODULE_DESCRIPTION("NOVATEK NT36672A/NT35596S based MIPI-DSI LCD panel driver");
> > > > >    MODULE_LICENSE("GPL");
> > > > > 
> > > > > -- 
> > > > > 2.51.0
> > > > > 
> > > > > 
> > > > 
> > > 
> > > -- 
> > > David Heidelberg
> > > 
> > 
> 
> -- 
> David Heidelberg
> 

-- 
With best wishes
Dmitry

