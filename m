Return-Path: <linux-kernel+bounces-837264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324ABABD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7AF31773D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7023182D;
	Tue, 30 Sep 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ak/DaJwB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B95242D8B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217170; cv=none; b=nqxVoH0hweHqG3Vq2+aGi39KDE/6NRGFCyOPL673TkVVBJFRKQ3Fe0hAuvFxZfI0knEXE74/FyKuS02bS6aSRt/ybONP2BE2GFlYrMAb+3TTb/5Rlpp47OExhoiEQXbQ7h46UAxx8DxffY728AtARr2G5fZxb9v8c0Jm5tXIzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217170; c=relaxed/simple;
	bh=UrXXb74599R8BZwIXkzJxHVqUA8YfSKR3ekHC6kpqv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ty8yE6eHUhOve8YsrKgjtFO+wXeMvSVJdUPG2CSqosPCi3XsKatlNsZ4nvq27tDK+m4aukybA0GM9Hs55CugtDAJCXFb5GrPnxIYVSC4lpXlerglad6+kyHhfrthIAKC6ei3bMqfR7pwPKHvMLCIotq4Iayg8dBVhu4/qgCKYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ak/DaJwB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HXSR014987
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=NJKkBSbx/8tqEG8xyEV6jB7VZnVlHiCHJaTcMaV3vdw=; b=Ak
	/DaJwBmKTwW3xCru1IZ19Bx3qchaFKy4WY9jpPbNbKcGYQGlfHSvI1ZU9YSbT3wT
	jKnXCp3NLSNDeM+BZ8pwNUCAspsTnZ013ZmAumkXntu9a9E4uP/YeCo3GMkMoVcX
	3ujKXRjRN145HCmZjr//WUOyVhVhw3zS9iUCVt12OgRpA0KdnL2zzYuu1X/YMzUU
	OZ8SNVNBNZA/Zu2+fPQC+v8XVuoDRRKh1//bL4vbEP+ZI/rNXFJt59TRICLQ3l+c
	j63z0V475fTu89lVoQYzJnJp1gwlC7MlRVNpsTk+PlYXsH2rvYb3FVgadwqeDuS+
	vyKEUcBKULsUZ5PPUA+w==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr027v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:26:08 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-33450d89acaso9456565fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217167; x=1759821967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJKkBSbx/8tqEG8xyEV6jB7VZnVlHiCHJaTcMaV3vdw=;
        b=VReNB0nVeQzic8CE1cB2JqaHu2m+nSV/SI2XZOtvKNPqINTMPWljXVlhZy1xs/docv
         /XQa9lNShf7YUa+9NSS7I6MIxTY5ds7jRnVGZFkpS8cfmGFEwsBTHX8n82LZ14QZXYfZ
         UVcOpuQT+FgD9iNicodYQgSIc3MJN8JTB/+/qVyauDcwTSJaRNcxNMe1vQY/+df8833h
         KUuuJRb3KJH3Rq0HFwtnxENkHLcOQPl4cL5BAivjAgHH0xtJmTGUNzx75r/jcCbLuaVF
         +9ZzgXJnIVHyVThnLbAiwpWBB+/pNMedK7G9sNIGtGbrkXzImfwER5c2y/In3IWUrpRb
         eB2g==
X-Forwarded-Encrypted: i=1; AJvYcCW+iPzmY3IZ93Y0C+/SoltXU81RwZIGZYfujhOncfwYROQmJuLCsk4lLyER3vlKTza3UL/orPmK02jw3Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+46b9Z1WLayMUa0M+1VnlphvwkRMviUaI/7YVUOoh3D9lyXJ
	BuK/KYymNHosojOGcmnnppjxnWcnadGtPnJ9+PSem/k82bHi8tqw39Ya3Nycvz5qwAo+PfJ3Z/N
	fADECKoUA8oGIJ80f4WmziAYUgeZE8srUhFaMQJKnUvOsdxIf/k1IWuAN7QBt7OFuQ+yFIS6iXd
	ur2DupZwtUDPkla+9PDBdf/JzaVqnSUkGI/irjCCLsuw==
X-Gm-Gg: ASbGncvS4oH3hQTvwVsv+SmVyauaJmcKsGX1Hdn9XA1unVuhO1qf0q+NY7Wgzv1ejrW
	02wO3D7yoPC3G8s56Z3Y3oljrBAofgvIvr9QOGZFjVrd1RWuqdpdU6kh3KVbA5/Sti/SQ0p/bB5
	Mjhisk6vAHW19zpTwpKqhxe6qEeNNJH5PR1d6d6I3x07JcwT4nFj+M7Ks=
X-Received: by 2002:a05:6870:e08f:b0:31a:70c0:d498 with SMTP id 586e51a60fabf-38cadf744d7mr1709956fac.2.1759217166931;
        Tue, 30 Sep 2025 00:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpcV7QCeOoB82oAsfyshYDoFlRPDZXQ5WvKfJlIGOQR9mFN5O4/G07y/zEQHyHa3AJYBNUcaNtfqPGXVCGfxk=
X-Received: by 2002:a05:6870:e08f:b0:31a:70c0:d498 with SMTP id
 586e51a60fabf-38cadf744d7mr1709930fac.2.1759217166525; Tue, 30 Sep 2025
 00:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-3-73530b0700ed@oss.qualcomm.com> <xsgnpvswvkyuxiviv4uyb6pxbpi646fut6dy54kpyfisqrxycz@tyfox3zdi26e>
In-Reply-To: <xsgnpvswvkyuxiviv4uyb6pxbpi646fut6dy54kpyfisqrxycz@tyfox3zdi26e>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 00:25:55 -0700
X-Gm-Features: AS18NWACYkWNYimh8t14gY4Dmrp_AbVsBXT_pDvjcLAcFBgJJlOrGd5Fr1oHJ8o
Message-ID: <CACSVV011=_szCPbdm6YA8aJjm76r_BZP9QFeOzcAGCvqUUTebg@mail.gmail.com>
Subject: Re: [PATCH 03/17] drm/msm/adreno: Common-ize PIPE definitions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Tuc5DdHXjiMHiMzNozsgHzfVyS9lRjob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfXzZNcCBEyrV39
 MOkWHn3NCYR5XOdY+aV/F2m3r6vuaZyiAjhCMzf+w9YwT490MhJKpwrPhLqy62xzQc/UX6MV3fh
 wHmyaOKGoc4zqECfj09Tje647nRCHLoY7IyoyVaAW32YQeC4m8I/xp9X/3wImtoAUr05P1w/ppe
 oYDX74fizCcYJVOtwx9YvLF5YuOmJmbSxsj/tHQ29+efAhGf8o3ig8eZnPLGRDTjb0t+aYp8Ej/
 B+C1+3ITSg+4rtnsByRgV0BfBWYqjBKn9lhsxB9gSPZNAfK1BwGF865SIISAxquY13paxQurp0y
 hw097mS1dM/BQhx6x+llegUOwW8AFTYFmNOeN96JUxBMIJYq5HSNVD8Gvcu0bLUjzoKzB/5oBT8
 p7q4sKvLMnSZPOhTwmeA2dFHsGyo0w==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68db8610 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=2l_kmpBevnkUXydlazsA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: Tuc5DdHXjiMHiMzNozsgHzfVyS9lRjob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

On Tue, Sep 30, 2025 at 12:05=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Sep 30, 2025 at 11:18:08AM +0530, Akhil P Oommen wrote:
> > PIPE enum definitions are backward compatible. So move its definition
> > to adreno_common.xml.
>
> What do you mean here by 'backward compatible'. Are they going to be
> used on a6xx? a5xx? If not, then why do we need to move them?

Newer gen's introduce pipe enums which do not exist on older gens, but
the numeric values do not conflict.  Ie. each gen is a superset of the
previous.

BR,
-R

> >
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  10 +-
> >  .../gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h  | 412 +++++++++----=
-----
> >  .../gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h  | 324 +++++++------=
--
> >  .../gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h  | 462 ++++++++++---=
--------
> >  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   4 +-
> >  .../gpu/drm/msm/registers/adreno/a7xx_enums.xml    |   7 -
> >  .../gpu/drm/msm/registers/adreno/adreno_common.xml |  11 +
> >  7 files changed, 617 insertions(+), 613 deletions(-)
> >
>
> --
> With best wishes
> Dmitry

