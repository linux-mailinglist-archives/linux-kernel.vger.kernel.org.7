Return-Path: <linux-kernel+bounces-850503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB9BD2FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E34BF34BA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B584C271476;
	Mon, 13 Oct 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cHKE6Szt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4A2367B5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358876; cv=none; b=gFWZEcBHS0wl6FOpnmhkKWftYSsh9d5suLLRwdMl4qcGyqR9vRpHp32poeM4DqqLsMQ4c7b3yDwb0tak1rhUXaNf5DBaq53ACnva1V4hz53so77vEy/JaSSmAXYcLlIZtA6ja4m+n6gHPfUTWMvDJ5KHtkLpQbFce8VcOVPdljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358876; c=relaxed/simple;
	bh=O5IBxsN6ic5oG/r8QyaBfjvgKnYuqZyVcNxtNddUJ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bayw5SKmtfMoZg08XVGF+S5nk3Sgtvq5506Jhju5X1t3vMXoMFlRXM1GCeKHvIL04ukFjeTE36n3uDis2UpJAYvt8+RpiC5BQ4OCZy4Kl/lOz/8oKFZTxVXR2XyMzgO3FZ4XhXwzdZYfE+vvfx2SG7AZEVnxrMcSFmMDg1Ls3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cHKE6Szt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAnMgU021349
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0c/YLYaDMoEGnP2p+UDoLSwW
	bwVJnzjUv4KnwNKCfEY=; b=cHKE6Szt423RB8gknU+LDvdj0Cuw4qswyTZSaxAw
	3Vln1wH/aKoGO3yopYn8nbYnpcw2S5NHX7Sm79VwKwLYqcQLc+ZXI9mJfef7hziV
	AKyPZ2BlBcuN5v238ZNwTY7D5BQ55vFbmhOXJXLfe40w7C6yQPCZFlJkWD+9Scay
	ynngzBZIK4MUfj9Pj6V8NhLYw4l6QgLJ27bWbS19Ao6+8gDR/kWDmmWrjCyZLQJS
	Drz4A2m+5QZP+VC6nw07jEHuiMMqSvOsKt+L4sJGzjlqmM7rq0O7DHaJwuV9FO5I
	WjOXqD+QR0hcatHH0bdFdVzbAjOv4iTSBuOaVcQi0GtIuw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgh64emf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:34:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-883feb13e83so2674737685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358873; x=1760963673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c/YLYaDMoEGnP2p+UDoLSwWbwVJnzjUv4KnwNKCfEY=;
        b=Uv9+i1VHnAnFPJzLEJTJivZOQJ5YdxYP7kr6EK6H7tWe0U5YyLjrYJvE230YY4Wgm7
         tkBgtkyHtd4lY4fYFKSWOpI0hXZKLTK2cmUx+190eRPStj75cXVOSzabKK1je/uJZCDR
         /yUbbqzbQ+AwPTNEKljom0xLADPsEnKn3UFx8ODE8BTisIWn+KofevKKPt1MBCVXMvMt
         YQeWDbPl2N4AU87rgYV+Am0GalNh+hKGH7ae/V/cCgw9LgqaXnMvMr0alPOp03ixiduT
         Ts/J0CK0RbZMwA05McfpOyYSqhEXYCLPknrAgdftLkVMtJWPH90gbVFQmpWoD1kXJKMm
         9ruw==
X-Forwarded-Encrypted: i=1; AJvYcCU9g4CGDpVQX78a9jBTleo67+8UP2YtJvvN76Vp3bAYq78L9kZTSqyHTkQG+mmhhj6Ozl1EyBO4vpJBVnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwZz1sJgOiPTwIR6Rnn+K2HBFJ8cifQPPARfkiqcw3PFJjH3+
	bReJFw3Tqh18wXtVJrS6w3hXp27YfnNFgjPYb6+K1nClW8zhcMyVm6RNPw1OEWXQ1c07OUnMKzW
	EztuVgRTAz5FLl5juXrEf5FzRNfyucOTmLp3R0pOyITmuSdKNN5L1xu4iJR7U7mhe4Mc=
X-Gm-Gg: ASbGncsKgKBRaFiLRCmyIhwwYl+HklbewxgQBGw42ubVIpo19JDlG1noaaV9Okyp+Ta
	ynPa2FdDbCE4ii1lJ+jg8lxz4bZW2JGDYOkPnOp8b39wykxC+O36/v/1/N856mEZc69M6TAVe9s
	moKtuSD0B1RQ2Sku00fnOlTa7zqQgg/z9F8GEm4WDYQSIEzesA1F6lc6/GWg1yUWouVTmifsZOW
	o58zeX8PBs5NJxkpUq0xI7Ew3qYXiGHyTP/9mu+uWJ4vEH+aniAgsoc65aRL35hntVZnFRquVf7
	Q4FNNBufndbJv+w/ql4K5kT3+odLfA9brlc2NfQQ73qOys1qhxuu4ljth7TodOq8GpDNfUClCIq
	NA+OFUGSXWwMikaBfN1fLa4E76w3NojUjCzwJ5AvlcdEYtiOu+8eo
X-Received: by 2002:ac8:5d46:0:b0:4ce:9cdc:6f2f with SMTP id d75a77b69052e-4e72122afacmr71752611cf.13.1760358873401;
        Mon, 13 Oct 2025 05:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNbh12YwL4Iy4NRipEsFChMHtKqDe+smfm+D7B0YFilvKsxmQIYfhkB/7L1zjAmITtmN+oiA==
X-Received: by 2002:ac8:5d46:0:b0:4ce:9cdc:6f2f with SMTP id d75a77b69052e-4e72122afacmr71751921cf.13.1760358872891;
        Mon, 13 Oct 2025 05:34:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f862asm4116608e87.27.2025.10.13.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:34:32 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:34:30 +0300
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
Message-ID: <7jmk3txdrnit6zn7ufra7davmomggd3graizdu6wqonp3lljza@mfnxt2owpknq>
References: <20251013104806.6599-1-quic_riteshk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013104806.6599-1-quic_riteshk@quicinc.com>
X-Authority-Analysis: v=2.4 cv=H/zWAuYi c=1 sm=1 tr=0 ts=68ecf1da cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=sf-Njp88EExxdhEklOUA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNiBTYWx0ZWRfX9U+PWJO5SjdA
 sg5aolZlTTCg4UeMI+Nxv/XV8GJdsIRdVWeH+ux+qjBGexgt6LcWClF+mx5uMWct8PWA0/ModsE
 Pk3zKq289qRgtQ6Xu28WEHh8aHY2eBvHgveG0O5GVEma+sLCI3hGB+esXqFB1DKIIrcbeaDy4K5
 6jDzjulMJ9VYiKsjltZkaNLJ80XobRjylRWwlt3VsWHPnsnSP3zJPY/f0fjQBmY+/kC8Eu3wEtK
 /vlnFQ5As6s97dQ//iTOfcKE0itEo/S+QrwCBGMsyK4Nm8x7dF1xTz27jO++PsVuDogfGCZIq3I
 Z4dMbvNzEdADsdeSuYwv4YqvNILeJoNtLQAG5uFamsWpQEqKtiYDwVuk7OJnER+rFb+Nj1UqHwn
 WeSg05QK3Vnq92BhKATxAt1jc6n4kQ==
X-Proofpoint-ORIG-GUID: ULS8OOx-w5kjvoEr1oIlMTjhTgN6T-AP
X-Proofpoint-GUID: ULS8OOx-w5kjvoEr1oIlMTjhTgN6T-AP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110026

On Mon, Oct 13, 2025 at 04:18:03PM +0530, Ritesh Kumar wrote:
> On lemans chipset, edp reference clock is being voted by ufs mem phy
> (ufs_mem_phy: phy@1d87000). But after commit 77d2fa54a9457
> ("scsi: ufs: qcom : Refactor phy_power_on/off calls") edp reference
> clock is getting turned off, leading to below phy poweron failure on
> lemans edp phy.

How does UFS turn on eDP reference clock?


-- 
With best wishes
Dmitry

