Return-Path: <linux-kernel+bounces-878230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C6C20122
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87DB84E17B1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7F33F362;
	Thu, 30 Oct 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="REI4QB/c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jq25XWxH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644461369B4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828328; cv=none; b=GSh+QEMypjycSY74sve+uueCvbJJ38S5TsXEHsMAN7aKnUjWvMZ5U79GvuZWZ2BJdj8W3DNlRXoa8C7eoaLiFBxamPtRmzINq+wxPA4zpI5UP7MNDRKOrUR40RDomi+wKMgzjM9h7cPpn4zB1g+GbgHzcpb1Cd/+OyifuzlvSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828328; c=relaxed/simple;
	bh=w7qKQ14XIDlgfkufZlQ+5WqdgI5PlsVE6i0dIrmSX8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMfFjITMO3cnfirRqJ6aqvA/0rthc24LZzkBZKyOrTQGHo/uStSydDKuEWHDajPEQNNnB7oc1BkFWidk6NjHi5eJHwQjK+8zMR5lYlquYkw387rGJSr5DzRxYl81S1B0vF9QZJ6GB7L77OiJn2osr6hf+crsHqzLPMM07Xk4Mis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=REI4QB/c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jq25XWxH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7lgP61697216
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GJ959Ncxv+x72xmSF8Acf2uWX5yesA01ocJ
	f7G1bCUM=; b=REI4QB/csRNEPJG3bLIlQDDPA7ZNTkMI90PV8ueGTjGDmtJ3K0F
	Y4cwJFoZf8pqDyFbx1rtQUji2k8nVDEhh9Gr4LGEnlezh6f6p1bCZy0zr4ZLPpOH
	y9Q92fqAKl3bVKjkj2a2PxP1GozhHqCA1WSnwdUoLEumX8TuxMG8B3QOmCMOIZ7q
	kc9GkhHj9oIMMhCM/POv2kUQp32O2J/E65u8fj49kgFHLAVjn9tp6m111JcFJpmJ
	fxg+/aY2zrCn6ynRUVeDKZhSAmDWSeXAg4Y4nfP8uTtdHyuGQUEXUsPtfGnIGvWL
	/p2GrmelJIbeMmyqHDDj5AVE/3fOJnsYy8w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv2amf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:45:26 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso999857b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761828326; x=1762433126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ959Ncxv+x72xmSF8Acf2uWX5yesA01ocJf7G1bCUM=;
        b=jq25XWxHE9B3DWLksRt76jhC6VCT4MelbHWIrq5arrMt5QKvqk6i/nuD5sI1pbxfRm
         Y/wXmmWVVrUsXOXopJr665jncJVyxNPbqfxJxbVajp4aV0kR4LCgngU3FRVL1DdxWQHu
         alkQqghzxg3RQ6L7av4XZVkmUAVmwrZDJplbixIq5PUfB5JfHXCjQ5k7QcKR2XoEsaNu
         UJNvWJC3GqBmpbmberRO1XWCk1/D7xuozsfucL/5ZU9c3U/jVKWpIqLVvP680tKduMuD
         R8rQKeeucdv/zMqdcIhJ+yFBH80Ion9dp37A44P1+vgHDmGllDHg6G7zg9ySljmt5bc+
         DvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828326; x=1762433126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJ959Ncxv+x72xmSF8Acf2uWX5yesA01ocJf7G1bCUM=;
        b=u497X5d8a+XxiyhSHsH8jpZxDl4gNiSQV2RkWk1+IKAitoQTZ9k+psxPHPDknLL2FD
         MVVEz7CxRj10ny8s37rzYe3mwriCUk2S8I3z5Pn5UkmlP+i7YG45QCcEzio0EC3JHgBn
         OwkcYrR4rcvq8sdJZObqPr0XuD4HPyTx6QGL61TewOjQNxgN8Ecp8J7iDq0/mXLjCmjK
         PoLWapEfhSTdUcCrX9UK23ES9GrI4K9cNkCnBPeqBoQWjRnE96B2UNnAG2Yr5OiB7Eua
         RQeMz4ds41lhQGpP/Y2nRk1ljCBXKRfWK9DCPXsXZCeG9NQQx/9iugOqAeKRZecDlIYN
         Og2g==
X-Forwarded-Encrypted: i=1; AJvYcCURI3KGLSyw+zSCqKj6ueFTT40YojobrVTgnLYJxUtBj41RAAQzc8Kb9s2kiOjLIlR9xtLUY61N2bhLel8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKC5foEjgdOIhzhy4LHwn0pb6ERIDHaFGVLEWxf/lI2c4BJOTq
	H3nAKjoOfFktSlfKM5aXegoA+psuf6CcohEqlVJ0gDonrV6QlenEI3MxwQqL++j96eOQZrT5fvq
	dEEyN/K7oZ9DmUeJxkrY5VpGm/CfaAcQhkiGa2p1NQTsxmNwrsPRsuNsqsXMuHUBZeJc=
X-Gm-Gg: ASbGncujQTEv2wrjFV97R6d2gHiTgCy2mXUfCPmwqAIK90jSm2gy+A8z8O/VUw0ln+7
	ZCcnPO14M/pnDG3R35eLeBzvuoHH/lLN5zC0DX1JWW+J3dCdv90HwRYoMPuUM1zPsTkcdczzrgi
	iyjPIzy49R2VcG8kT5zvD0UhU3AlcNkBGFXsSysTIpL6zIVLAh3CtmDK8ucUXGqIAWMtxw01Ak8
	j4M9oU387P4treaM2feaSHdNMg0NSh6sEhh7wMgCg4Xwh2/OmpnKk8D6h0oI3O1CtAr8PUf+8c5
	tXik5YUXPgZAbfRlAsF9s3APrTssnWV0Uba8FCumVcKSse1gI/YW6Ag7IIqDSeE/HIYMheuc1r0
	GP51rKVFMLCgLm6cEsguiNOeMp1mMu6jtGmsdRk6srUaxutYxQV9K+8qCFSL5x+GNaA==
X-Received: by 2002:a05:6a00:84f:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-7a4e4e12a29mr7632474b3a.16.1761828325922;
        Thu, 30 Oct 2025 05:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX+ja8XWkdnMYtwbaI1c6ZXK1XK3OVcW0z/iXNFr5CNSDYSTtFNfIX89htBV5jVHLtckp2iA==
X-Received: by 2002:a05:6a00:84f:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-7a4e4e12a29mr7632435b3a.16.1761828325408;
        Thu, 30 Oct 2025 05:45:25 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414065418sm18931035b3a.41.2025.10.30.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:45:25 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: richardcochran@gmail.com, jonathan.lemon@gmail.com,
        vadim.fedorenko@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] ptp: ocp: Add newline to sysfs attribute output
Date: Thu, 30 Oct 2025 20:45:19 +0800
Message-ID: <20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sztxQ2GzRBNo9PFl4n5HzGlL4Q_uEHfm
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=69035de6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ge1YUZ9DX2Ns1i_QU5kA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: sztxQ2GzRBNo9PFl4n5HzGlL4Q_uEHfm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwMiBTYWx0ZWRfX53DK85JNt+zo
 divvGzsuhTCAJiZQwIFW9RSoMU3Wod7CbvPwbLmBe/thZJ+PRJd0UmENAeV0zNwEGztLUjYYQ49
 ouGvlfqb6kA+CqUkbDCjk1XABDpzN8/ZQiqijhCIZBxhedGC7nL0ow+qhI17ebshHe/TO+hlmT3
 5KSAmfaaKZ4XfdhJm9WbnyCbfj2BM3IMMSxgnfkrXmRwyB15d7tzWssC03M3xR4JdyPKf+PMxhU
 LrVFd1RoCnTFyZocescSbUWDp0jtdybNfUvC991iygJqruKQ+oTYQmtZ+8UP8HevDx+iINyBI1U
 5lt9kp/XW9V/FvDLd9b+zGvHUOpwz9RZZzxxwmksyoZsEOf3kFheEQG9+fi/wrSsZ4TlSX/ROmv
 SMW1QP+gc45xQ6LlyjobsLq6IT0TOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300102

Append a newline character to the sysfs_emit() output in ptp_ocp_tty_show.
This aligns with common kernel conventions and improves readability for
userspace tools that expect newline-terminated values.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index a5c363252986..cdff357456aa 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3430,7 +3430,7 @@ ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 	struct ptp_ocp *bp = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
+	return sysfs_emit(buf, "ttyS%d\n", bp->port[(uintptr_t)ea->var].line);
 }
 
 static umode_t
-- 
2.43.0


