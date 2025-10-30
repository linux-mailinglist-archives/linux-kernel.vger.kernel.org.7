Return-Path: <linux-kernel+bounces-878264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB6DC2021B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C788F1A2441E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F69933439A;
	Thu, 30 Oct 2025 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cE7pe2jp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FENLG4sR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE82DCC04
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829230; cv=none; b=b1gfiu/sTdSvinM1eisWK9tkd/J9F7Fa2P00JLwOBHGqy+uZhRzc+96FUCuTSB2ru2AKllZN1SoBn6cGhVUQkFAOfbhFzbzu1+pKV153uX1pIyvhhmjWHysGjm/KwWRo+/OAQXgW569BfqT+CdhekW4DKK7uap/zSXa8zDyc3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829230; c=relaxed/simple;
	bh=Uom8V/YfuN/7Nw8amHiJnoa2AsDN4tgm566EKh85FUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTLHR5bVT2dQoK3lP7RVp4sPhENCpbpRQConFiLpkmSFUj+ZP7y1xf6xxMklt1HDdr1gaaaHE9lP3N1CuRN34ZsTlO7E+2U3WtikjTIXXdHBgo1WAdcdN5FJyJGfVpEGyPD9F1t7b2wAjhCs6nYIM/vgJ8Q53bwRBjezY4ZNMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cE7pe2jp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FENLG4sR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7kPLs1697111
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hB4YVQpNrgVLXtIFDYO2m3A6urjOI3oWMSt
	1zsIO0ko=; b=cE7pe2jpFUXafII/UxYCBRZ6JrjSRcQiAbPJefiRgvkAyZLPglT
	n2sWaOlxclAvSPLZsuxDqdnGKmgM4VATern9TmdcfM0FFgCf/XRKy8uR+uGFwMw5
	BBUyY5DgMS8NJQt3FbBJn8pj1ZvmdKPfac5Oj7q/K+CKYU9XVt6wZ2Afd5IIeAwk
	3HwHwWyqXPr4TCHTmT2X61bs0FqhUnj+TWsuHBKySqy94JwW2C7PwLkAGmg4uNDo
	lSRn1TBdgS+fhVbOoQnhyd3IGyeEWd6+RFGCWYLspqw2QUrFprUf1mD9jpvG6nns
	sH5Cq0niP3ElV6wfO1YTCmb5xdEUAGdEIwQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv2bs2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:00:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78117fbda6eso917737b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761829228; x=1762434028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hB4YVQpNrgVLXtIFDYO2m3A6urjOI3oWMSt1zsIO0ko=;
        b=FENLG4sRlFgmd5YPCAIMLigdXKKP/lk2FMcI78rW76pfkFnTiqTrtzNALbfWuBsAE9
         9vf796/cgHVt8AAI/H2Kw39+mVftS6w0QgaCVCzqReArmL5i037iev5liisETaPR1WgS
         de1fy6c5QAiisobUNZvaSfnE64sfaiteuwB+wBHa6edgMtzhIzJFq7N4tj2k5U8Vy6at
         DSnbWmBRtlwVZP8lmbU4pMCZrLlSbit1dVN9X84tkDJnlCJd7vXoDOur1RR7OHuOE+qB
         sfttFE4sFEljYwjXwkGsKSWVDZgvtcDq64NX7EWpiZ6aSXzxtorjiG9hXTHYl/4MBZb7
         ezcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829228; x=1762434028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hB4YVQpNrgVLXtIFDYO2m3A6urjOI3oWMSt1zsIO0ko=;
        b=cE/ZHzF7IFS71c7kfTPmt+1oN4keHugz7uqRdObB7UYJAtvBLrhq1D0I/R25Bop6u9
         wPF7BiSFV8iI1l0cDxDRFkKgHhoYJJyiN14GTQt579cbFXGIeNWjbdRUjMDKYAcEHjHN
         9MS13vUXbztQ42Spwg2F0dqwMK9UQj5CJ/D+ONO+D/16cUGNimG0K1RJ9BHelQ033bSp
         29c2+qUDU3Ajw95IYljPc64r86D/lHq4qF7M7QMQYSO0fIst+HgMB+TXjtURA0vbnmTh
         xrqxxndEL5zxYbacOXutoBrcARnMsm1YCilOGQqrXW8DjMxLXRMef7snSYxoi1RtaTuL
         9BPA==
X-Forwarded-Encrypted: i=1; AJvYcCX2mHgpUWOgxX000kuZNCfQY9HHZqBa7bAM0qxHWiS7sxT6hEcvRwR/vBQkcAzKmLqj/WIeoMbWxsjvvWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1vzYx7JZ78a0vogvBDs6SulXgHKcaW+02yfjHnqQYyf8/eeF
	xm8/xgWmruakAo/chvy7UXubQzb5McsMn3nlVXkx8gaySWzAWkNt5WM6Gh37/cmkDRjDUm/2AmH
	9ffnJhdRo6OyJM53jNimp1EORopdhDeibDckLgRfqQ08qV2sv89JaqZk5NVSg4nAkOA8=
X-Gm-Gg: ASbGncsgNTkVVPTbfRalQk6YMzZ9a1fn4mXAyoOZTFqjO86k026o5crQp4ntjibgDxL
	TkW9QuWaqilxBAWg3KF9q29Y9nn4451XUc08aEhM+rfUJKTtFigKV2sg0PJUuEXmUM5kzUcrq7v
	FSVT+/q3VhVslR8QNlDKLHgSI20H0SLAv++XJOLhtH1GKIOINEHxb8ifymk/e0rviz48fz356Gv
	IXLt5M1ySe9IWnKpzNwB9MuuYHOFTt48TeBLKiQjV8lOa24YUmxs0XGDOBuoKNZ1kuUeoF9FbAT
	H8VfyMAB5oYwc1VL+F4rQ1EdUFrghHg+O5wmZWlrRyAcigIznl3BzvnunVwkTuu3QG1mvHcbiJr
	sUZ5wLgvqMvehqcdS3dvMb5ZIV8EbCWzlZpmjeniG2GP1j1sgRH8iM+ESwNr+eKMgSg==
X-Received: by 2002:a05:6a00:2d14:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-7a4e59d272bmr8952750b3a.32.1761829227512;
        Thu, 30 Oct 2025 06:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7jPHh0c1uibK0ShPcz0qwGkhJCFIROjLJpHtxaloxQisZrlsEnpM36w+1oNBnie8yyuXrCg==
X-Received: by 2002:a05:6a00:2d14:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-7a4e59d272bmr8952656b3a.32.1761829226853;
        Thu, 30 Oct 2025 06:00:26 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068addsm19078757b3a.44.2025.10.30.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:00:26 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Subject: [PATCH 0/2] wifi: ath10k: clean up structure initialization
Date: Thu, 30 Oct 2025 21:00:21 +0800
Message-ID: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s1pRtFZuY_QfStYbp0F1mFEJZUr4kflU
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=6903616c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=j7ZLb4g6lzcXWYqKbDQA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: s1pRtFZuY_QfStYbp0F1mFEJZUr4kflU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwNSBTYWx0ZWRfX9YMIK2nE2Z2R
 TmP1WWr9fsN2JpNuQHPMdRWTFGQEMdOCpqkhPPRizrvjcP9USE9JZO/+/vAitdz3rJ7yZhxNoZd
 UdoQoFnWLl5cdRmWRIwohoFrjtPANZt4o9v+9vPjau2NRIFC7BOpVd5/Nq259TViD49I7YJSC0u
 fGDiVzBUV2maxLoYFrk0WKh6iy66ylyhkHPr8WGrueCnN9CcDWHYLs0aYqFjCRaycJaxv87UU7W
 n6t2bl+Xv0eWQUf5Y5z2F8DCD/3RLNtm1P6I1YXzFhxPSSaRXiFuF433raMIQT3vt9PT1sCmd8J
 U/QoQRAUt+mSpkuJ3/fZ9/CXFYKXWm8nESMQ83VSMACBr92Qtws+aMfyNHYxGxvbKZMwLTjnJX1
 KRvEhjYMoURP9iBtCCoUsr0t/EuKyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300105

This patchset simplifies structure initialization in ath10k by replacing
explicit memset() calls with zero initializers (`= {}`) for local
variables.

Patch 1 updates the initialization of `pm_qos_request` in
ath10k_download_fw().

Patch 2 updates the initialization of `bmi_target_info` in
ath10k_core_probe_fw().

These changes improve code clarity and efficiency by avoiding unnecessary
runtime memset calls.

Zhongqiu Han (2):
  wifi: ath10k: use = {} to initialize pm_qos_request instead of memset
  wifi: ath10k: use = {} to initialize bmi_target_info instead of memset

 drivers/net/wireless/ath/ath10k/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
2.43.0


