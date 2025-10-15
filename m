Return-Path: <linux-kernel+bounces-855376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7065EBE10B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A1504EB617
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128293195F0;
	Wed, 15 Oct 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="igZQw52Q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40263176EF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571631; cv=none; b=O8l/vRjflgJqEMzv/ulY126tIZP4JyN6IgaUZpi5UpcyllySeUJ47paZCdTqseNbpHOa7HYNQtxzj/wgmBVAyyJlNMnUpoRt4BVY/Lqy8Rp+LAfSlBNoEEeTuNI5l9SRv26VczG6fm11K+AxfI20QrjAfe8298aS/UGrZUmv3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571631; c=relaxed/simple;
	bh=beQrxRG8Gap78fUZcgTM3HujSgKgDdV9r7B3c+djAlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=blMJmvgsROZQ/cx/a//UH70nF6oSccR8hTiuMJs6CyKFwGMZtMohnvM0gBQXrx53yL/Ef94gbhne2YSsbutw3/0lxnCfcemQ5pFWvOAJxkQqBtK5OzzdjwfjRFqPuIIuIDXGmsMrbkzMW7o7Xcm9fBQPauySIjJWlUmc4G01pUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=igZQw52Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJMoJL016069
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3x0IYHbY4tjRVt2udhF3EIVJWGOX/Sl28P39SVnXZ4w=; b=igZQw52Q6CcA/xnU
	oaZbb8ct1lh+XSfgQDiC0bG2RNrlKV+gSDAtRyBF7bHBSliDsvaHamTzqtPVCSSf
	OZ5KEG7jlsLY8nUL3lJ+DTU4cWtyLsLDxhCf5+zZKZKILTA3yXnRdClcfxuaBkRX
	bHDb3PDfTDx/xjIQnEUBp4vIbUxYs53rrINBDhEONsqn5EwthUTci6lMgjHz1RA/
	4irwqgvQrZ3dW7wnaGRrV1qQhJRYUssyFd65tOLne1AfXrr2VANdS7F0upR5CCE8
	C9WCH97+H/Skcu3YfCSXiqufGR3LePWG8q27a0dwtujgVfLh09nW4fOWP1dBWcZa
	HIPSRA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5pd1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:40:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6fc6so2900025ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571627; x=1761176427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3x0IYHbY4tjRVt2udhF3EIVJWGOX/Sl28P39SVnXZ4w=;
        b=BWxK63act8/CePjHCEghKco7T6VlFCmznO+obkScfh5gHptcK6R7JjIJi5k5oVy0zh
         x5gZrvUNtRBabhEHzQg3IB4rv7G3IKZk7xNQ7SMommVAhXqGRowg56uin1uji1GQ9qy1
         2CKNb6n5uHaOU8VmKiAYAKY1hT4UWosM1/FhTVr3/X8sSyJ6VXiEh7EH2+/XjHECcI0J
         6ZiF6q7eidyRpGIS2h4emfV0bUp00XMr6CyZcHEzZiorv1ydZ5tnk9n3OVuP4JAkhPs/
         KSFhUKf6izuBeCDZUBV2uM0zUVYgKeTyNlePZd7wdFCAb+DbaJxQcOGYHTF0BI4uBf4m
         Ckww==
X-Forwarded-Encrypted: i=1; AJvYcCWCXcl4vu0CRDllaJtoLEnkRkju7cne+NwgC3w1BefpsGkOxmBdK6ec2Q996Zha0WMKq6EuoNnZBaj4P9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4sFEqxrad2vBdt+x81sf8LHPbNB5sAKYwElZjoON1O9UL3rDA
	D+fFCDbECLCw6BwZ6YO2JH5xB6qz0rOKI73m4PTShQYZScAf+6LPXJ8gBmUsBqV84Qj5UrpOGQ6
	iVuiWdI0/SbMmmvvdHqUoCq/LQrXbI4JRpoOH43FSItMfs26HvkffrZEcdqlOR/NP2zw=
X-Gm-Gg: ASbGnctJpcCbKZgJNuKWBxesKA3uSiBsv077Phppce9y+GuYW7r6U0cl1ELh4RRGvJ3
	6jMPBEjigVYI8I7xrqCoUSmm897WvAL+Nv/l0xOkJ41TUKHmzHkXinWnPTwlaCs+bcD8wCAWn+N
	nqpNlBSyqORHojp8wTJ6eoMRhMszBJ8fq5aKdlzt9nIMsvPgGTYQn1PKfpEU/MUFd4QbW6h/Wrm
	XOCq5ZTe3/LGOBovQEkRDuD2eK0gFqX8GEL6zY04pv3YPMlDm1O5YRJZJl5bGDUl4nuTwUeIVlf
	TB2MnBMRnVANhl+wvV2e4+ydg48FHyTK5yw48p9JryM1twCx2z2xbPqzUuPvIYck35RslGh+GDH
	IR0H/cS3U54rRq+8rfQkb+bjfvR8ryS0ypiY=
X-Received: by 2002:a17:902:ce0d:b0:26b:da03:60db with SMTP id d9443c01a7336-29027373dabmr426102055ad.13.1760571627521;
        Wed, 15 Oct 2025 16:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH636KnbNowyw/e0DhBDEBumYhJ9OCqLiKg+5Bgl4ES8cb0ngFTq5Arz3CAFiEs69m79TPjWg==
X-Received: by 2002:a17:902:ce0d:b0:26b:da03:60db with SMTP id d9443c01a7336-29027373dabmr426101755ad.13.1760571627089;
        Wed, 15 Oct 2025 16:40:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:26 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251010-ath12k-nuke-wmi_bcn_send_from_host_cmd-v1-1-6f1172b77848@oss.qualcomm.com>
References: <20251010-ath12k-nuke-wmi_bcn_send_from_host_cmd-v1-1-6f1172b77848@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Remove struct
 wmi_bcn_send_from_host_cmd
Message-Id: <176057162643.260563.1781488828218446991.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: yclvV3Y1QKbbK3tDxEszuJ3_Y8KBa5OV
X-Proofpoint-ORIG-GUID: yclvV3Y1QKbbK3tDxEszuJ3_Y8KBa5OV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX8+U/gmGVGMty
 56ONSul/hRSj0e6PvTB3MRDKZIs0B3+gb5v0RmOax4j2O+vp2wVUDbkFVhecl4/qLgb06GzgOJZ
 VmbfT9Lr1gMnnafgj3VE84kzRtt6ezF0Csa1O7GmBDVc1/xP17uOOINzb099eSm40LipbNt8OYW
 6QF7APxLx2E6BmaRtrTkO6TSSdTLKp1MzYTM2Vo4PCoZcQLNrTlrsw2xFQEtrKvM5pPuxZM5T4F
 4rh0vPXdsysEp/eYoWUoN6voXuY1OaFG3xJl/6rJBZ2GbugTxV0dnJyMYKTVLWsjePdjuFfwZN/
 9TrAmZCd5JW6IoItzYMhSy77itgja7wHcHwsKxTveK8fyyvkJzfge4cmANIdJTGRPUc3fvfV6+j
 g96gyfCLDnvyWVjhdUu3yHxJK7txtQ==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f030ec cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-EFR5erphFcivXFsqSgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020


On Fri, 10 Oct 2025 09:47:58 -0700, Jeff Johnson wrote:
> struct wmi_bcn_send_from_host_cmd is unused, so remove it.
> 
> Compile tested only.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: Remove struct wmi_bcn_send_from_host_cmd
      commit: d34a368be24d029544cc97feb87729a9f7984a78

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


