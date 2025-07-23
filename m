Return-Path: <linux-kernel+bounces-742876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 167CCB0F7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF8E1CC0DED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5951F582F;
	Wed, 23 Jul 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kju2Vkh5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A51F3BA2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286657; cv=none; b=lpEFpudTqP4qF8l8BIF0V+xtY2ocOxv5NUdnO6YphYU3D0nWC/+SSJrym0VVUlgtZ//+7GmsHVr4cTPUjmJ2O33dImj4y07KkwcrGeFgtRUoIha52XB09NdCL+eYQ0jUsg/WrOx0nColIrzJRbf1WgRsbR5D1GlFRWxJzLEWzQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286657; c=relaxed/simple;
	bh=KCfstuN77De2m94GHTvsNHvFZ1vdK9nOTEgDVUINVok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fcvxX0ti/1aYvinZXt70SSa5SJWXhJqoQ8qbOmzoPoKb2x3xUXrzn+81wDsnsHZHREH3Jiu0Ue0RGGZfUCaDT5vpUTBNaWsdEd9FjlPVOc3Nk9ZVQURR2D7QjnNHKAQceJMiECXQlIk016iwZWqm91m6ot6sqVYXaJjXceJBXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kju2Vkh5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9G1Xx023226
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1IVq+bSzc+i0gbcHvdWX5X0gFlHkos8QZkR6QJHMwvk=; b=kju2Vkh5qgJixjmy
	0LuCVz/DmtBSHrsGDasQ2Tu4i4rfNXAg2XZijdJlxWiM0RpwLAZbVFKCm8Hoovgd
	WyypJ2Tp2ECJ6/D1ZBIJHVqwaTsrmnVKfxO05S/8LVeJ0NmZJe+U7mjn8HyvKFW5
	WcNqfS5NM8YhZeMkOp0DKg7PAe1X3OEvU2mHfm1mF6KDDKQijF22o/x9jptCNyUh
	BOS1stNXo85wblzZy+glcyioFMYcaFb4KIcBZXUd5gJC3WFcJPxUA5DOEv/iR8ME
	wjI4qeGDb7YbpAdubb2R/ukaMSlVLcn4TxEL7E+S9nP8vhm/uE+yAodgIFoYaY9w
	wTDMiA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3erkqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:04:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e36f4272d4so11513385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753286654; x=1753891454;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IVq+bSzc+i0gbcHvdWX5X0gFlHkos8QZkR6QJHMwvk=;
        b=Ux19UM3Q+pNAVloEqFM5e9oL3rwjJDDuh6ioXkMkDiOVaCnY5FuZP4efVloIBoGJO6
         NP6RVA0/5qagfeYCpgsQsQJPf/G37b67sbIFUo+H+CNdvRZ+yPRcrUk7vnztTmADzZhn
         ASoqA81Za1Ru66HEZ5f6tu6gepmT1adlN1dyIpN52FlDuwbO7Zzk9tcAMa/Yt4oIsWUH
         utPsMtyal/U073BZTKMDmTLfEsZU5MUeHleEqmrd6JuAJjuqK7kh1+wIpd34PkwAdx0n
         vubatLGahdABxzw58Quj8X2EgaLVMmYqynKomhXGOGyX6WhavXDjmPsGP1d/mBCgwnor
         /P9A==
X-Forwarded-Encrypted: i=1; AJvYcCXdazd0xT4rCRRX986JTYzWfWAkOv34ZZx47qMFs+P9hSjyCdC1NIPyog9JB11V0qgOrP7R7DWPUNazRHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgkxza+Mi55zShi4eUUgJiWngbGl2s97Fjctkw6ydp9hv8uyv
	ikMrA3yBAw6mkU42/6Te22gGyQNpOIbaj2DhntXhZIux7FYClyp4WNvIbPyhb+VkWGq1P3nKJvA
	1yXZkx3fIGN7sQt/wWdQJu2zNVD0Bd1wnrGgJrzAvGtuupbwbnT3qgVAtmzClS0RDVT0=
X-Gm-Gg: ASbGnctTwB2SHAeK+45qbjF4U9PLqVIK5CRZJdQUzCCA94mPbDAz3pWOsHzfz1KXfIZ
	wVTlVJlQzdm0MCIgoe9WuPKzLNIb+CHwbJnMyAlIgCfQ/dd7oC8eeC4ddIO6Uvy+hhXfyeiQI2G
	32OEv6B/3U1k8IRap6RMk8nGSzcdGTQVvmWC9yzGdKWOkSBbVxHCuXPMJwdvouTboUQuB6r3P+r
	QU/5DC0ZjxDhZzqb19nTaWOQiUqTrH9/n5R0mTCrlZ6m7+j/sYG3ABbKE2YspUxNX5OBOtOprL/
	ziE4AH+gJXSbH8wBsKZF5vZdIOjBxvfhC4s=
X-Received: by 2002:a05:6214:1c86:b0:6fa:c81a:6231 with SMTP id 6a1803df08f44-707006aa843mr42537696d6.8.1753286653606;
        Wed, 23 Jul 2025 09:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhZaSVPPcM0H02S0SyrGlN2YH/RRRuvuVz7tS54TmJPI+kAWBGLQw4aW0+GxosM+D8oehJNQ==
X-Received: by 2002:a05:6214:1c86:b0:6fa:c81a:6231 with SMTP id 6a1803df08f44-707006aa843mr42536996d6.8.1753286652887;
        Wed, 23 Jul 2025 09:04:12 -0700 (PDT)
Received: from [192.168.1.17] ([61.2.112.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bc2dasm64468956d6.12.2025.07.23.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:04:12 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/4] pci: qcom: drop unrelated clock and
 add link_down reset for sa8775p
Message-Id: <175328664500.29282.12330427204137280127.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 21:34:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: RRJzt0LyS8liT86NvWQ65m5T78tVjiet
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEzOCBTYWx0ZWRfX7KF9Z1HXowaP
 50o6qgeVXNnli+KJyvB4K08K3w4j0eqmMaU4GbI3mdLxanpt+6K0Ru/Iwr6AzoU0k1/rstEcwgN
 fiKh6zL2GDnaKpfSLfiMOYdCMyZPm+fTVfwl+kz8wuMVNzCRGB+DW6he9aiPWYMbt0yXzWQTSdc
 gcJ+i4zZzyqZqbt3M/Z2QYtUXp5jX445nAGZNR8LcEuYhbFo3Q58t2d4DgwCGX4RVZivSJ7T+6N
 MLmd0xkT7KaSzrvEyjJnd6CP2UWwjSNVTRUrJudI5JtXVKpi+pzMHAWmkMVu8qlyliGr64vQoBV
 ouFgJTyp7G0y/a/KOGXRK3Pg7W0SWNcfRkd8l8TREchVfzrvkUTQIFz5dTgeQ3QBXuZOW4gozeU
 PuWAYAYSSoQUNEHzy3sybM1rNckaVcDv7Hso24FcsB9meyX7rHsOeutvL7S9ZyASvMt+hPaY
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=688107ff cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=L2vWZV9GmkZVUxua0bORKQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=AxdmJqN1ex9b-t5leqYA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: RRJzt0LyS8liT86NvWQ65m5T78tVjiet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=843 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230138


On Fri, 18 Jul 2025 16:17:14 +0800, Ziyue Zhang wrote:
> This series drop gcc_aux_clock in pcie phy, the pcie aux clock should
> be gcc_phy_aux_clock. And sa8775p platform support link_down reset in
> hardware, so add it for both pcie0 and pcie1 to provide a better user
> experience.
> 
> Have follwing changes:
>   - Update pcie phy bindings for sa8775p.
>   - Document link_down reset.
>   - Remove aux clock from pcie phy.
>   - Add link_down reset for pcie.
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document link_down reset
      commit: 10e7298dc0f14c52d9b5c52fb52558f567815b7c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


