Return-Path: <linux-kernel+bounces-731797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5BDB059A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0E73B15D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436882DC35D;
	Tue, 15 Jul 2025 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pAR7DWyP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4896F533D6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581680; cv=none; b=bf0AQP3vSciAEPuX3XnXswhprkNbCwwfsnQnkeNPjJPE+KkmsjsQ152Q61c3d1BtalJ3M1gWYAK9QwRAtB0//hajfVGvkkSsL7JFT7S+n7yHhafRRrmgQa6kdGTQS6zBiE1fF/Gy6gvr/PpnODusYaLygQJKUzVLu9Xw0+iHHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581680; c=relaxed/simple;
	bh=DEUhuX/rSVHCfkYolr3lKuCnaiQgl/pNBAkpxnYNR/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dd+BF3DlIc1sWv5rK8HN0OpbV13/ch9772sAG0t1VsSJ5iS01JL+UIUF1B8QN77cTQAyRXRlPWpF2aAYwbo+X7rGB4i3cWC+Riu8j1SMMeh2t6ktd36OJnRXqKyh3K2BuEUyuICjXyyLmGdg6/LAK3Hf6Qyov1qR9GKmnkelN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pAR7DWyP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9aABU013062
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jfw3xvfS4NbEz+jsLHsBmAengRL2X8sb/oc+/LO2vCE=; b=pAR7DWyPBxVpTXT0
	h9YnTblgqYuJIXGydih9tv0twZK8VIO7ntLAd9wbUHTHG+jYowx44+BKRoRKCgO3
	pPJI23mQ/lxWGzkwg6OZNqNr0BLKs8D+91giy10Y3oRWGuh2gpEBsoOBS7eERO7+
	28gwND+lghCCxhf+SeEEA02wgWB5/hyCuR6sBKEjrhioUpZAejuHTgvsgjmB8u1x
	JdOWpBBLhPv00bBpVmAew6PkTmi8guAKTNX5m9gjdSIfb4YngOoUXvkWWtrHKwJM
	QSTViKVoXyUfxepVrVVX19kcpG8Cp4EgUKUP3gNBI0qlRDk9J/tCW4TFVCEzRUH8
	iwezdw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58yjyst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:14:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e33af599bcso95137985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752581677; x=1753186477;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jfw3xvfS4NbEz+jsLHsBmAengRL2X8sb/oc+/LO2vCE=;
        b=H3Ob6G7eFvUI7Zd4TcBIwtCZ+xxZy56eG3I3x0X1yluMyecTi0gR/ea4aRWLAl6FJx
         wGSfUcQvkRJA8Uls+aEay4xCc2VBSHO4d8KjdQhC1IKLN+LBovCM484QHgJZk1eEwcr6
         0AGC+6kcPdl46Mvc69mpMF1yqxQnxfB13KaMEhzG49yKMXtSG3UH2QBZNXDF/iVq4jXX
         1DzTdKF3qn5HRxToZfns0sGJq3Zp5AftU8SPcWtPsiaTsDFZ/bVu3WNKpSVqYK0ZJVM+
         kK2IQP4dgQN5xlnuBWm77qMpu+RYHVYitw33qE2z89TAnmzvJsIqGmfxB5lh2GupFigR
         535Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnk95IPGGcy52j49gsky+4gDBAwqJsTFdVA3GcS7LKQCpFEC19wrP9LmAlMVyy6WXfGKCuZW38RKptPB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCbyY3nQ6OeWh8yZc0lpmYhk/rlz5mKStJgpN8V9eP4uhyggy
	MwN99zYXM+NVrWDwd0t22u54dDCeoCmcGwBQFuzdCulFh2oL/vkMPm/DSXlCgPDPYIsTOcPPe5A
	EfBTlMLvYvwtq4VE/lDPsYoep2TQLh3MY3H5Zeqq0OylMLAeMymIbbm7XEXeiS8fqxs0=
X-Gm-Gg: ASbGnct7cEnMM4QvjcfTrrforix0MNeff8EKtuERlRbFSCei3RfsG3ALgOQPZCe5Z0o
	Joqi+++flvuafvJz0WQM9f1kk6d3FODtAZjavXRiPDcWY/MkMv1rDGQrpuonKNiVIKdqTvm81Fr
	J6+sNxIIduJMCnX989kDckw4ody20Z2kxPeesuACC5AZVWcUfsdpMiU9qH58DoyGyEsVRRER0Gb
	bs2015la9fX6qEjBwpW+xfY6b9kxYwe289AjmAPitkZkJLsCJl0rKoCEHfYCRRuQ0PmihHRAAuq
	yWbLX80H1xHRGgQ4JKE8pA9/Ypzn8q/LLmIgFlP+fSJmBP0P+cb4P7RpmqqfiOT1BhHrXJ4KOZe
	TNRYyaNMI0y6xliBFOqW9GnvDbsHWrOUiinFL01eRRa71ZyOLg6PT
X-Received: by 2002:a05:620a:44cc:b0:7d2:1953:a410 with SMTP id af79cd13be357-7ddea60f5a4mr2007319185a.17.1752581677216;
        Tue, 15 Jul 2025 05:14:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPBdsY71vp+xrMliT1xr5TakX7NuGQX6TNVLrGNnn8LGe7tYWNBXLw8v3IZLOAETZNjIReLA==
X-Received: by 2002:a05:620a:44cc:b0:7d2:1953:a410 with SMTP id af79cd13be357-7ddea60f5a4mr2007313785a.17.1752581676616;
        Tue, 15 Jul 2025 05:14:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134fcsm18126581fa.15.2025.07.15.05.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 05:14:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: simona@ffwll.ch, andrzej.hajda@intel.com, airlied@gmail.com,
        ian.ray@ge.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
        martyn.welch@collabora.co.uk, mripard@kernel.org,
        neil.armstrong@linaro.org, peter.senna@gmail.com, rfoss@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dixit Ashutosh <ashutosh.dixit@intel.com>
In-Reply-To: <20250715054754.800765-1-andyshrk@163.com>
References: <20250715054754.800765-1-andyshrk@163.com>
Subject: Re: [PATCH] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix a
 compile error due to bridge->detect parameter changes
Message-Id: <175258167425.3629548.5679606306596835842.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 15:14:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExMSBTYWx0ZWRfX6IG8x6U/xb4G
 JH6f+p0IAroIf9Ikd6qrc0qSY7QRnq+bOuNg086Bp7pliHiht0l6UrN3Iuzv325KVDK896hb7yU
 RurRWxeh+p8kNscEZ++gRHe/57pPNncw60xyG50dK9rOUBpD/ofcUPuLKrYZ/nMsOa3Xx18Pca4
 Jba5eYqe03nyozJkIgV87HqH8aAsKDTbC8tjGEzHx8FUg0dimuYCn5NtmuTFT5KA2bm/ROcX/r8
 ej/EXfbF+j5Q/SQbT8MnXuI/4pbZpaoV0B/+7I1cbu8McJPA+cPqiJ5WwubndFh53pu8vaQr0C7
 weVNHj5iL9MrUPaTXEJUsanUj6F4ywMEMrfMK/HDsXdlDfq5GjFtzxKtj08Gzf4fr543gZWP8xI
 9zeHX3O/3jS9h7qZeB8C8RHh+qO66SbKnDU/5YsVizZ1YlnINQOuwgEhWnRICqXIKJza/YMl
X-Proofpoint-GUID: CMzBXaba2fbbhxCAZGBY4z1QDCWzohgx
X-Proofpoint-ORIG-GUID: CMzBXaba2fbbhxCAZGBY4z1QDCWzohgx
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=6876462e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=eKgQYgMGIk0790w6_cYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=994 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150111

On Tue, 15 Jul 2025 13:47:52 +0800, Andy Yan wrote:
> Fix the compile error due to bridge->detect parameter changes.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix a compile error due to bridge->detect parameter changes
      commit: a622663dbf874ae5ae2326a9878ceb410c8a34a4

Best regards,
-- 
With best wishes
Dmitry



