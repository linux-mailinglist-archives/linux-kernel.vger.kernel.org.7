Return-Path: <linux-kernel+bounces-859691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507A5BEE4AE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD07A189DEED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05461223DED;
	Sun, 19 Oct 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="En65Ngbl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF132877D7
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760876071; cv=none; b=TXdxmzvlQ0zOO9KaIIIjjqcYVcMqtTbYOYwIZ8/aS2HOnQWna4JS3DodWQaHJ72m+wocSjp2SRU/bsSV+yI8yCp7TGd/h37Pyva/IJEPOTQXJ1fprgKZ6yjQylyC6NEd4MzEDqnDh9mLxQmH55aRnrMd69IVkwgV/TeRGLi5PLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760876071; c=relaxed/simple;
	bh=ukqOXoH0B8Rm/K0oOmFS3+X11r1F7wE1V9gnidNhdI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULj422a/1BhKPtEjuP8U7ZKuZP1B5xAgtvkckcrwKAlkh1xGGdGP9kYnoCzXmfEeVkDnqjZDVNLMTWmDJ6tXkl4xWECjzAkMZJUFBvC21bKs2+3RHltUExaDp6lq/wuyvoOtEcVwmRgToBiAD97pYi8kuDZxBhe8Es5rf9LOg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=En65Ngbl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JBirDd015520
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	puNPrhTEXrfqnZblxaqGqUil1ruzTr+zCkgmrxJ5Bek=; b=En65NgblGY8NIrNy
	BjKP5KUK4ujMB3MNse92ose8la5TWB9nGsRowsVSqd47vWUpN1okqFrwbLRbe/Pe
	FNXx2CSQ1X00JbGgoIsnH6KHLWY1Qolrujvn/NYfSUhBI4uBbBj3taB/vAEKIjMg
	G+LNq+UP+2K3EqrMaLSzL+a9/fwmXBc2Vc95pgWrtnRnurCCfm6AZnlgQNC/gZv1
	RIiZAK7ux1qSlEfc63GcdYqlW9InQamQsiC4mUnRhK9etJjKT0GL+cHeJx6Kjb/s
	cRb/ARXhJ2FMsgtGx0SoulEaH3RtZW1rxb22UtmhV6SMakH6axSzxO6MljqW6bs8
	EtMyZw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfa9dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:14:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88ea6169a96so545159585a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760876068; x=1761480868;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puNPrhTEXrfqnZblxaqGqUil1ruzTr+zCkgmrxJ5Bek=;
        b=fCeEcYNG02NkpfINt9VkLIs5MeecXszqFI2uHC5vfxzyYimsU3O/wonTN1fwGWVs6a
         OGhg3FuJuEkNh6TyWbQ121W47LwijeID4JPDWiQYyBgotXdWGVHkBuu3nv6HZYtosTZS
         G/37bn6D2u1+41cziOHstcVC/DODwaBcXkoR6lfZDy8ShZ0Cpx90iThjDUeuMFxxnI80
         i3/GAgr3fwc+oVwwiYfUbNIDXFnrZ5RhRVUeJxv0CU1kC+JqN9t1nhuh6WRhy36Qr8GU
         by8epC4XA2jGXQ5uksOYxIJSp4t/4QSWmViLI9MIM42spyH6ipWYJtwciehRzKSTpJR8
         XM1A==
X-Forwarded-Encrypted: i=1; AJvYcCXotnWXg900jDSLvwJwJU5FRJ0uIwfF76rDMy37K5pl9AFmr5XVRx/+iR2kPmnY5BYIktxBu6mdDPriYkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd2lLSSnfpHMTEpLqmf2P2LjJ33q4EppHYfkaW9Lb++kHr8EoU
	NmaShF9u5bcwCXwfIafPLtPEJqCuoGMvI9egMi3/tSZhUBjgJxr9ESTz5DlVhxg/cUXswvZX8a0
	B8LZ7VnnpejR6y4ObNy1xGAy0CW0SxfLxQotMMj9vcpJVE7tePffFnAEdnhfUNurXQas=
X-Gm-Gg: ASbGnctF86475Elia48MIcsMZyVvoDzMZBHZhIxcQN4BqVHB6bT0EgJvNaJ84nHsTq8
	WQN09I4f7vDmFRpG04kYGGubA6X0M4cGhq649PVi8tPV2c5FgKeIQpXvUCcmGTvjEzkBcYWSZDs
	AbcJuOGZ54Q0gl8ob+kyMcqTIXhUCgdhmnGApEvuHjd2FpMhkRs7hRcAbrDYQGf+pvU3V7Lg7Kh
	8sI3L7HpIJfdQvodHW89OPrfw+GLTTtyW45dHJiZFC4/LdEny9n2auXYtFGxfzTfuoZcNdCdzPq
	s3uMBxIOkYKbJWWXSehi6YEN1tRiSSvHnvkbyTBoJWxRO9WaiHa/7b4kD3XzPozbddHg09PDRKO
	ZkY8Uxj7ZHdpO5CJ8/AHBW3EFWGJgViHcFlBVr3VLXYCQ6CzURzuj5Dh9E8F6xkulc9Ry/Q0Ggj
	15nJkFczktq64=
X-Received: by 2002:ac8:5985:0:b0:4e8:911a:2af1 with SMTP id d75a77b69052e-4e89d3625e2mr152707201cf.46.1760876067813;
        Sun, 19 Oct 2025 05:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8+CZ0NJ9bBoZZ1GZiXuCbYiL/YP/qmggrLH+uJV7bA2b9ganhGBoaFnRrleOl3gY/Yk+zFA==
X-Received: by 2002:ac8:5985:0:b0:4e8:911a:2af1 with SMTP id d75a77b69052e-4e89d3625e2mr152706601cf.46.1760876067319;
        Sun, 19 Oct 2025 05:14:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deec0b98sm1528227e87.40.2025.10.19.05.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:14:26 -0700 (PDT)
Date: Sun, 19 Oct 2025 15:14:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mahap@quicinc.com, andersson@kernel.org,
        konradybcio@kernel.org, mani@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        vkoul@kernel.org, kishon@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 0/3] Add edp reference clock for lemans
Message-ID: <ql5ps7cv7x6hz3otzz45uv6pbr64x2hdapa66vq2jtnt6l536h@kbktvupxpf4y>
References: <20251013104806.6599-1-quic_riteshk@quicinc.com>
 <7jmk3txdrnit6zn7ufra7davmomggd3graizdu6wqonp3lljza@mfnxt2owpknq>
 <4bd619e7-e9ca-44a8-9d36-10c18d7a8157@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bd619e7-e9ca-44a8-9d36-10c18d7a8157@quicinc.com>
X-Proofpoint-ORIG-GUID: vEbmkMsRLOyNPZz9oJRLIS34PhwM97hj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX2ABlNmIFrz2Z
 Xg2G+yMEtadAgpMFnesOBdP9WdAOlbl03mrKC0gtWPtW5jSWQIb/dsBX10mCrxJGTC8I/B/53mW
 OrYMe/j2MqM0nsQcn3RQGRmeJ39Cdox2smeBKjW9ifABo8u+Esho45keB51yGXFPzBYm8eBSiUj
 mG3cZfE5lExRUrfW2XYauvX6Og8adv9egAZOYfwa14esII/xo6AYYS2aP8nwRTgTjXElvcca2v9
 OKV8D8iNS/+Uj7IwDbOM2TzlUYSthh75poT7qqZmQEd03GG6l4o8bAGjWNnYy/7lbJsdPvZsygK
 ZgaF9Kb/cjzlw9v/w4zHBjebVRFez3pwCe3949JPmbxMEQBoDpWEHVzwDgrFVTW2QC2BfuEQaiv
 xPmBIsq+N4pnxT5JBfRKKUp1UwBW0A==
X-Proofpoint-GUID: vEbmkMsRLOyNPZz9oJRLIS34PhwM97hj
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f4d625 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=FYAu2dUYg65mSESSDlUA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On Wed, Oct 15, 2025 at 02:49:08PM +0530, Ritesh Kumar wrote:
> 
> On 10/13/2025 6:04 PM, Dmitry Baryshkov wrote:
> > On Mon, Oct 13, 2025 at 04:18:03PM +0530, Ritesh Kumar wrote:
> > > On lemans chipset, edp reference clock is being voted by ufs mem phy
> > > (ufs_mem_phy: phy@1d87000). But after commit 77d2fa54a9457
> > > ("scsi: ufs: qcom : Refactor phy_power_on/off calls") edp reference
> > > clock is getting turned off, leading to below phy poweron failure on
> > > lemans edp phy.
> > 
> > How does UFS turn on eDP reference clock?
> 
> In lemans, GCC_EDP_REF_CLKREF_EN is voted as qref clock in ufs_mem_phy.
> 

Ack, please fix other comments.

> 
> ufs_mem_phy: phy@1d87000 {
>     compatible = "qcom,sa8775p-qmp-ufs-phy";
>     reg = <0x0 0x01d87000 0x0 0xe10>;
>     /*
>      * Yes, GCC_EDP_REF_CLKREF_EN is correct in qref. It
>      * enables the CXO clock to eDP *and* UFS PHY.
>      */
>     clocks = <&rpmhcc RPMH_CXO_CLK>,
>              <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
>              <&gcc GCC_EDP_REF_CLKREF_EN>;
>     clock-names = "ref", "ref_aux", "qref";
> 
> > 
> > 

-- 
With best wishes
Dmitry

