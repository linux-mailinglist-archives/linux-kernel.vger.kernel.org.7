Return-Path: <linux-kernel+bounces-737417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A984B0AC3C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7387ADAFD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8993222331B;
	Fri, 18 Jul 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bzEXe7ov"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8D1DB95E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878716; cv=none; b=b0NoljvEweMSIOWbe909pAfJfKvVuD7zCgPATQoosbxoi0POUZm91ehUjgsyW4CRcv9z3XqF6h6JbRwZe7Yhg7BiXZ6sdYXjtJ7ZEuyIXL+5Eqgcj2L2iAgIoHkn6OzNTffmzyKRoK+94nukcCJbtUdhACaQIMROOv1mxBVlNXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878716; c=relaxed/simple;
	bh=NNwCzXoPYMOTPaXJKHL13c21dOfYSIJZIh7sHCpA1i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLEa/hWPwDRf6E2wkOic+jRBeiK8qCNTIGJKYJars8D3kgPh1oXfyW2t4E2LHrjYNPB2XKwaHqMDOEkp3I0AVTRrUoImcfmUdlSP2CGs0K1yorJ/qyzxSDTxolTf9cttNPFh783zSO9hplA5n1zUpM4Guz3I1UnHQZSEE7yvP8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bzEXe7ov; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IEbkEE022268
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B8+eKAj/ZD/UM8+YkkMpBzxn
	aUkFdQMdJ+OYNUtinIM=; b=bzEXe7ovXUKg38w86JRFjXP5NLmLXCb4PC6cMEJn
	I6UPqQ88m3n7p1/A1hLs2ukBkq7/sLq4Jd10UX81Gj47IbLJVf7juVZcsMp8D3TG
	F5phU0XdYjBGMT+d/EPYYfLkbb1Cu2Ou7gcAQLwuG+FjQZ5wBHI8+6hm+Wv6EAe7
	+9WM9qT3sBEgwfj7cRmaE0E+FKabrR9ltp52DCuPl+JAYTCrHHpIHkSMecXbKFT+
	Xrz6gxpPjreK1Zx1zwm9pBurtZvoQlyoJdP5A6zEGGQpL1GeNzVqgYHqPAbtLYcD
	M5xYUDpxDx2iQmPf1rjO3yUAu+7xwD/PWc59MUaMS2RxuQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsyd3qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:45:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e33af599bcso428038785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878702; x=1753483502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8+eKAj/ZD/UM8+YkkMpBzxnaUkFdQMdJ+OYNUtinIM=;
        b=wxj04CWEAiKnZX2Eyf+WKJu4U4swxVQQ9u/izd0KCjZCBtD3jKXzOImiVR0+XjT5B5
         sZ6JLmSJTe2F8duGoF0tYFHQnrKL3Zyk4UoY3vyyRC2tigZKFAqH23tRlqGOwAZfuPkJ
         Yq/+q1SmjADKbO1ejXng5KDlGHaaqo/eK6NhyM4A2R3M57upLrH3/Zi8IggvAgxobwiF
         09jYdj85hcSl5abtK8oLR8IRNKAbskrFs+dduf2fCYQMDEUMy95aZx6qtUp3rYpvOy3S
         Tsj+GT3lof4+FjZrscuEZcr17eyjDNoxGri+Tjgf3VSacLiOgA9yjcIKtUDejZSpYtEx
         hGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs9eLJXt1SqJw/5KsIz3kXaqE9br7HuhYCf279gvYTZGnPEWBZodQFg4XacEFxSVDQUYJnmwMVKaBTUpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9tk+ze0Jx228F1Fg2JuCduky1v3XxBnth5NUroNIsdGbXiiHi
	pDzz0yiWA7TSwm2jDIUPSjTP71kXQPXoJovw6eW56ek/wAAeHnNJ+5YEm9cs5y/wFK8mrF5oziM
	z2ncP9a7lZim/1z1ho9miyCCt+0d75wDh0HNgE44xvgfP+QAIvt5OYufmeG5rHR25wcc=
X-Gm-Gg: ASbGncvlKRXyKnATPbaw7V9gb3sUZGU1qJxAua2H/H8p5yk25KnrjoD2IoLHVR8Whre
	l1DR8UyB9YEWJgbPOrC4dtxGxipmBGSuPWRKgfdrYnvSDcy40pc6rSVVLZiWV6fexM3ewJnd6J8
	k47ZYfIMTZi2YfVGTyJEpAp7WteQgncJ2qKiXuX+M8pAbtZV3QaMZSI10KmJ7J0GU8VyniqGub8
	cMzyeyAuc8suYpzUmnIaXvsK4f8IaYgodKedlsijvvdrGP7gB7cRsbDCoqSqrbQyH3Z3sya3g8j
	+wx9kk0oRbmv9F1KKumwCDSU2EL+SfGMxKpk+9RY2+7YEIbJHFtwHdcm9HlBnTIWKcQchzuWSXW
	Rk0kQHz+cD5Tl+BXJB5ygSO+bCUgZah5sakhZsu+15L5oRpP1T7A/
X-Received: by 2002:a05:620a:1127:b0:7e3:487b:2a74 with SMTP id af79cd13be357-7e34d9d1edemr985985285a.42.1752878701869;
        Fri, 18 Jul 2025 15:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWAAK0ht/7a4kdVpCySbSDtfrai4FYse/ThX0w2qF3gXv3M878f+tua5mo1f2EiYqVCiVm/w==
X-Received: by 2002:a05:620a:1127:b0:7e3:487b:2a74 with SMTP id af79cd13be357-7e34d9d1edemr985982485a.42.1752878701438;
        Fri, 18 Jul 2025 15:45:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a911b775sm3371171fa.45.2025.07.18.15.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 15:45:00 -0700 (PDT)
Date: Sat, 19 Jul 2025 01:44:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/28] interconnect: qcom: rpmh: make nodes a
 NULL_terminated array
Message-ID: <wi65rrkxd7f6n6nxse3p2bszv3lcko2qtflpbffngupqslcd3s@jvwec7rriqgo>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
 <859be3e3-be14-411d-b5ef-07bdad91a878@kernel.org>
 <efvyk4ojddr3emsdavex4uqrl476sj5hz3ihd6kditdxd373jm@wu2av4fvqc4h>
 <a2b837f8-eb34-4283-8d7c-17031a7a682b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b837f8-eb34-4283-8d7c-17031a7a682b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE4NyBTYWx0ZWRfX14Pd4eD/4E45
 oyWGLdb1rfzZ9iYczK+pAYYVJi3Uj2xDuymzgK2nmzw2XQIAVoZznsN/za+79eepW2FrO1rvaiZ
 wDJ8wdODIyDGHEVwO23zEx2Noukaz4vMp33JfVHvwJFbBCpVmScG0E0fCO84ETRjGwO2BhdjLa0
 GwfHEPF35/GqV/xf/8vnGUrg1RYqHDjwNBSaCJM55kaYCDj1I35GnlMH1jWt7Rp9f3DElJmhTpm
 j3abjauknbbHS/SjtWOZcVdmHzTPc3irZ9ZQvkVO3SbdD+8/6pxHB/VN6UwWBP//ycSZf5aLWW1
 ecwS5DXfpc/UymYK2hf9Fz/z2+KjrdABTUtNFXuiv282mg1lLrK+FQqXc5HINqn3Z0mjhT7rEI5
 FSVqTRqVSUKMDOIMMApuAWF7dahhI3BJMa0VvOY2bYLYgFrV1R5QYabWHcW3DjAEhsqVcbkg
X-Proofpoint-GUID: QG6pUGOAjQBmNR-vuX94sF3DtrgDSxZR
X-Proofpoint-ORIG-GUID: QG6pUGOAjQBmNR-vuX94sF3DtrgDSxZR
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687ace7a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=votViI9Epv9A33Tv9KUA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=559 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180187

On Sat, Jul 19, 2025 at 12:17:47AM +0200, Konrad Dybcio wrote:
> On 7/18/25 7:26 PM, Dmitry Baryshkov wrote:
> > On Fri, Jul 18, 2025 at 04:38:02PM +0300, Georgi Djakov wrote:
> >> Hi Dmitry,
> >>
> >> On 7/4/25 7:35 PM, Dmitry Baryshkov wrote:
> >>> Having the .num_nodes as a separate struct field can provoke errors as
> >>> it is easy to omit it or to put an incorrect value into that field. Turn
> >>> .nodes into a NULL-terminated array, removing a need for a separate
> >>> .num_nodes field.
> >>
> >> I am not entirely convinced that an error in the termination is more
> >> unlikely than an error in the num_nodes. Aren't we trading one kind of
> >> error for another? Also if we omit the num_nodes i expect that just the
> >> QoS of a specific path will fail, but if we miss the NULL - worse things
> >> might happen.
> > 
> > Exactly, that's the point. It is easy to miss num_nodes, while omitting
> > NULL will crash the driver. So the error will be noted during
> > development.
> 
> I really don't wanna step on your development, but again, I don't think

No worries :-)

> this is a good solution.. maybe WARN_ON(!desc->num_nodes) would be better?
> Some static checks?

Another option would be to follow RPM path: move links into external
array and use ARRAY_SIZE. It's still error prone, but it is easier to
spot.

But really... For the array of pointers NULL trailer is the most logical
way of specifying the end of it.

> 
> Konrad

-- 
With best wishes
Dmitry

