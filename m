Return-Path: <linux-kernel+bounces-743176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F9B0FB79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845931887114
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D7232386;
	Wed, 23 Jul 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lWRprqyk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3D22A1D4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302514; cv=none; b=ONDnS/nTYHE3Any0WuzEehpUUNPvh712Ew4bW6KsuifBjk8pzIr2UwZO2XGS9AH0zbYz5fbYM4RXggH7vkxCiHGedVf/ftlprbIp+mZa3+mfDf5KkrHKBSsc3yRZ60QQ+vQRm3HwJBvcLjnFZkhNwBk/CKbnoBg0696VVefs5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302514; c=relaxed/simple;
	bh=PdFs9Ar+XFr5veBMSdS8XtU2Y2/xk3F20fQwPwQyMYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afGnJ2CQO7Gn5FRo3Tqy3h7JgvruQN64CFNC2mCcvUR8Wd1L1hSDEXdW6/p0l6WO0JaL4Km1Q1hBvuipFaSOgt+9Q1NE8nhRK2oV/sfIww9pjSV5wMstsDcFAk9P7XXJqXFsxOKu5SU+7TqktsguJmWzMdB1Mh084hvZt9qJ3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lWRprqyk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHBdwL020122
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fQlGpsNQCbK1gjPImdLDa8PKdhHdOTCgiKm
	ZdGjhm48=; b=lWRprqykiY3dNoJHCUDUIwgJjbf1PQBoUiRCpySgHHpmhBXAiLq
	nEUHtjsHFTqhcG17+u03DD89DwkcL6OBRQW9qQTzf4Fc4f709XF7nCC1CHWFkn4e
	432y9D52/PQ9zHewR9SrYaJXwKuJIWtazzjK8HjyeaYl7ZE1cqwouS0hrHjcbBtT
	TYIOirFTwKWnCXrAgGKYFCR3ZAg22mt/X/e3M4C3z1mt+FdrhkFsVGG9ZUAYf5VW
	b99JQeqzPRYxXvOFieUhbR+/Wzg3cViQwhB8ulU0H+coEqLERF28n1HkzpvhTuEP
	c9TmQ9VFHKTTfIqtugwNQW+39zKou0BI6Xg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3es9e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2c37558eccso178229a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302511; x=1753907311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQlGpsNQCbK1gjPImdLDa8PKdhHdOTCgiKmZdGjhm48=;
        b=MbezPX5hF5/Ov1/bzRdJsVx/RtpuNoYTosHsud3l5ydBOlqM7rUae62VpC2YchsOrN
         fO9im+df9f4IrJvX3+LWfQjr4maUKKNf5uv8z5WRhNmbQlwg/vxx4KvZLZu9FGu0tExp
         zMSWTcltJc7AON3chUXwQrvFeYlFEorTfWEchQNjLVbd7Xz2wQyeKwMv+ZBPGX76aKhN
         0bz74tnxWChigWw8bUMZ/LL9LzHJuD0G5+uwcYLP7UkfVnH6xZTXlzhLkO7L2z9hd1ST
         sqzR1C91gnz1Ne5mjGdqA2+H/OUtFaAplknwQZLV3bCpGLJCrMiDDVyO6VZmxkGu1L//
         1bfw==
X-Forwarded-Encrypted: i=1; AJvYcCX4uS2EfRUVoZeHGbY+ULOTwd+EMOzLTTTuiUg76IWRdcXM1iiEBpQfvgIIIRoHBdhIq9RKtAGVQip15vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrSnDpM69+XQjLG3GaV+ceYNF15qbRANqsNxJJCGTj37rCeNY
	fpMZUDHIHLOUfCfELi7+59HLAqTavAEcjQfuFtCj2ziwPuhgTPtK+Ml1YECr+UYCIvx172hM7HL
	W+UJbZLbzdJWNbCg0wgL973JwSHKUGPCqikzwQpevH+WFhZWxDvsIr+zMCcVpP3aB0H0IkPJRe2
	M=
X-Gm-Gg: ASbGnctrfXp6TIv12i+5Q1FPKjkZbbPrHVUxNUKd5iUhy3O6LbK2/rAVbZGoKhO0Ms6
	nqS97Yc8UT+Mase39hXLFc5dBjZ2+uw6Gq7ewh7811FFf4a/qvMNyQ4dbrWkBWPQxLHiaZYEaia
	H7eqzxNslgeUjUIsun37Hd83JPyswAayNjsOvVNOBUhYW1gGpJ98XlGfdiIKbS2+1h/lVkitpee
	u/JCu5qKQb4bpCnCkPlkguZiRbRtzWz5gIjL2S99P6/7sbJXVVqOtNMFo+ZXsR5kdpZ+1ZTmEmj
	dlG+n3Tk7DKjejC16LOXhQtAMuzaPBXTxR7qo6V+CEGKxh4PJ78=
X-Received: by 2002:a17:90b:5448:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-31e506ef502mr5027758a91.5.1753302510490;
        Wed, 23 Jul 2025 13:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY+35JICM9OLufVbYH7sIKIs/Pmj3SRnQsimqXzP4nhKSKMC/sT77ExrMVchp76VtVysP5aQ==
X-Received: by 2002:a17:90b:5448:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-31e506ef502mr5027735a91.5.1753302509999;
        Wed, 23 Jul 2025 13:28:29 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51b93862sm2307868a91.34.2025.07.23.13.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:28:29 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/2] drm/msm: Defer fd_install()
Date: Wed, 23 Jul 2025 13:28:21 -0700
Message-ID: <20250723202825.18902-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q1Gd7cl59CWR7SrD253Eh5M6lbnGN4LV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE3NCBTYWx0ZWRfX2C2pkDi49G7m
 WA53W9f8mvSo57bqHNqTWDMaIQFA6JQve459mIicQF4vnAfHEa2GxlvqtOATXp3oD1MQdzZS3P8
 v7n/5RCxV/TFeGBj3CaTg5fpUO0mSrZvEZZACPgpjkx582vWEVu/6LPUk2ysjoCpcTAOmobHX6w
 3RvxleON3gV0/s1INNRDwrqQTJ+TB8CzXvUoip457+mxcy2YtMSBBL3cvRCdODWmM2ZwnanLJR1
 xWB51iYYxe4JL/k7gvda2gSHRqMXmbFilNaxINYFj8DLtZ6BcIPI1PXHxT8NQ/6JAgAPMNLS7Yk
 d3TEnDI2OJDfiaqsRpwQ4JMXYcfon3mxF5+3UtI/6K1eAbdEGG/Ssw2GeYqpUZDWrl1q00hxEtw
 UIlMKorFIibNQ1b3QGUbXOSEsgct2oZY+O9p0jokU0L5enLbJ85dPy2xsbrrIaW8e05igq9S
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=688145ef cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=jOvuQKYuLspqWEp0sh4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: q1Gd7cl59CWR7SrD253Eh5M6lbnGN4LV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230174

The first patch fixes an issue that Dan Carpenter reported in
https://lore.kernel.org/all/55953f27-0762-4ef2-8dda-3208b34a5c75@sabinyo.mountain/
and the second fixes the same issue in the more recently introduced
VM_BIND ioctl.

Rob Clark (2):
  drm/msm: Defer fd_install in SUBMIT ioctl
  drm/msm: Defer fd_install in VM_BIND ioctl

 drivers/gpu/drm/msm/msm_gem_submit.c | 14 +++++++-------
 drivers/gpu/drm/msm/msm_gem_vma.c    | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.50.1


