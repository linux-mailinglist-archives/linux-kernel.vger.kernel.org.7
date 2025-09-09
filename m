Return-Path: <linux-kernel+bounces-808427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C609B4FF97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25238166DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28434F48C;
	Tue,  9 Sep 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5Lk80GW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856F341652
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428582; cv=none; b=cyALkt3tR4mHrTe06nx5609AQ+6tT/7wp0TfwYP5r7Thb6926WvvpN9m8hAUqIkUIk7t02Ww/qkmBnbcz6N3L7euLRqNPRkC7VwTeFncKSkREe+mo+qYtp7MKQcjZ119gBTknqXqrn/JNISe8eijDeNZSgzF1K3AOlASoWSHfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428582; c=relaxed/simple;
	bh=9jWUdz3s9+1KGe/LsfA/w83ocRTktfYLdzg5dq7Bow4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ezjw6UeH8imouttQstHQxQqUeEs9It4kF9SiT2q/GkwlZy4eZEFcZA2AzI//I1A9kioIwBNSijZ6d1a0BQ47OzcJDsSDlNNFsFNZOSPA8RC1xS0b7zGIi2YTxhWxKSyWczwLVOyWBrsFGVMn1bWYFhPsp/rtxnMduQYZM99FFig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f5Lk80GW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899Lnli030101
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uA4qgLx/hsEAq7trbdmyQAHvkr0Ta1iiDba8JlHd7Vg=; b=f5Lk80GWY3cCa4Iy
	3vYu2TIZ3P2d5OzGQ6I2sslL/a4uINzFIiwTDgwu7N19jHjWh8C6jgUU42BQoa+S
	orF73ceuoBtiisBWfRowDB1vqMWrca2uFjsw1VC482p4+XRAl8FGr8YBngc0tRSd
	U4JyFwKDoZva9NgyXwlkgPgtepw7IqWe1dh9u2/JojjUxKp2AtMVij9mfaHcRMWz
	aC8WD6FyQSvsfHejLJFuR5l5bb5dC4F3A+HKL3XDwj1Y0jXsuI+jbe7SsHgHVXzX
	t2l8SbbcJtsfVjiqY10MlUj0RkoIWzdFemtawnzVS/bAQjttcAsSfsxEoqZkwX2J
	CK9COA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8ghvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:36:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-718cb6230afso124179096d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428579; x=1758033379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA4qgLx/hsEAq7trbdmyQAHvkr0Ta1iiDba8JlHd7Vg=;
        b=pZ3Q2hvDqt+RtFJc4UvvXt/zov4ozESVWvtd812VME+A9sE6c/am0hkinKQ0inwbl/
         EJlS/Wy2HNe4jAzHEXyJAtSwJLNu7se92JAQMvK5w8kgysF8lv3iTOtf2GbOD+rF73dX
         YF6OdV4SDMcZbjVBgDcp341jwFfoG73AZwGnRp5xNuxyhjYx2nNuiTfn1amaE4AD/5Q2
         heya3ST+k/RoWufJH8QEqR22O0pWSY2uT40V0yJWnEWUtiMEHgGQMbMeHiptMR9y1jZL
         Q51j2jfpYL1K9E2frCgrxjFqJmDVI/H9frVHLh0RG7S0bgDRa33Jt+IWjstZg9pQqq99
         7+rw==
X-Forwarded-Encrypted: i=1; AJvYcCVH34QPli6nIa91CSJ5fxsb2HRDkXsoaexN1Ctsll1lePadOSgBfBHyKwGKLENTV3yNgzuayxnHOgcgBjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwornoY/egMvDSEeEshjooTZ86Q4gi8SWtgBH9bW2d9148lpsYu
	HXNDfZSDEBuNH7YxshAszEpxPNGUSKeyBCco4loL3GiUXYg7vUFzOUwbs86yYRYbcjWh53TgjTO
	Pd4lD765eXXRBJMLLorkpyc3MPtjiiCsR0QHc8E6pDAvegCBhLEOlEzkO7ZDzaRUgsOk=
X-Gm-Gg: ASbGncvUt7vt2+bpVnszBz2LJ1dvwyoIxEGDF72EmFeqrbBaZ8r1ZsrocJX708j9/2b
	Dc83VRZrVwBLsl4avxbRHLkToVFeV9GNdtHcU9Unaa8bFpHM8INlDz67e8rwK69Q+Fjij7XOeuY
	TQzon10N/TSIN9CeI38gciMB1lyQVxG1et9rfLkzxC3Y8G9/s9Hfnnvw9VQk9tZzMj+mAc6I8Xs
	grxJ88v3aGKoVzwG+2xRMzKWXb0SFub0vgT7i2fKPG9WWqUIhLXBvX76dm9trF38aM+49bmZIvG
	6yj7ayCCxCfN5mUpTQ+FCWDZjAEbfbVAIcStWF9RoDtiluOWtQ/jilD7NdEKmrgYjvHpUQEaZet
	FgFCtfWMf5o6ooE487KHMqg3UB5Tnm+Yc4aHBtIw8SKOlKi7oCjbt
X-Received: by 2002:ad4:5967:0:b0:70d:c6b9:c256 with SMTP id 6a1803df08f44-7394276ff99mr129483756d6.58.1757428578739;
        Tue, 09 Sep 2025 07:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5yengQZlzK1mif7XJLm9HRvGWnVva/ZOv5l3q3bP1SJyzgh4y5P9Co0DzmJNcdBRGugEvQA==
X-Received: by 2002:ad4:5967:0:b0:70d:c6b9:c256 with SMTP id 6a1803df08f44-7394276ff99mr129483176d6.58.1757428578084;
        Tue, 09 Sep 2025 07:36:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424708sm567120e87.8.2025.09.09.07.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:36:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/bridge: write full Audio InfoFrame
Date: Tue,  9 Sep 2025 17:36:13 +0300
Message-ID: <175742856368.1251022.1890059906161498952.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250903-adv7511-audio-infoframe-v1-0-05b24459b9a4@oss.qualcomm.com>
References: <20250903-adv7511-audio-infoframe-v1-0-05b24459b9a4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX6TN9A6JO1aVq
 5UCtU0QBmmxrm925aj7a3jAHVIvxnMh9FQD7zm9q1xLYRY7RhtheUiKrKGvyhzfX06FWNiyfbPI
 xd1DD5rOIn+0PTcVyaIbDEDDHpT0o/jhRrz4mG16vO/rV9Xi+S7xMJyPb08jJMtsfw7ZpRG852E
 2IMhyKwF57Ut2mA/UBOXG1YY7nSJJprDc10lh3pRqcWjfZAkxs6aoPHD0lmKR1am4Snym0gNgVf
 1FQScJ8lAle1QAH9rzR8PpnJOThEh4eGaNp5yf3JNHbkZPCPjKbT/P96JZRr79fels+QbZ+72Qu
 lZywzsP+I5G1XB1PVkHONo9fVRlm+Z85INdu6kW8V7D4gRd3Iu4q+nxD2y0gQfKMbndH932FtLt
 Q8ce+Z1h
X-Proofpoint-ORIG-GUID: P3fAmNbB44_WhnD7qL8WtzD556rL0Hcj
X-Proofpoint-GUID: P3fAmNbB44_WhnD7qL8WtzD556rL0Hcj
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c03b63 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=4_h7anNqbxI5UNtl55AA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Wed, 03 Sep 2025 19:21:27 +0300, Dmitry Baryshkov wrote:
> Instead of writing the first byte of the infoframe (and hoping that the
> rest is default / zeroes) write the full Audio InfoFrame using
> drm_atomic_helper_connector_hdmi_update_audio_infoframe().
> 
> 

Applied to drm-misc-next, thanks!

[1/2] drm/bridge: adv7511: use update latch for AVI infoframes
      commit: 723a170811db366b993437b08f1ca707163f7c84
[2/2] drm/bridge: write full Audio InfoFrame
      commit: f0e7f358e72b10b01361787134ebcbd9e9aa72d9

Best regards,
-- 
With best wishes
Dmitry


