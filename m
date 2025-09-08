Return-Path: <linux-kernel+bounces-806657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7D2B49A01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFD34E1998
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2013D2BE02D;
	Mon,  8 Sep 2025 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eVqrTKRB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566E29D272
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359840; cv=none; b=L0t5vGIgTxrWWkohmOPnyE8lahvwBsP2jFJT0z5q15NOFQzfX91Xbi6BrO6E3Bk6cUhuA141L62iidp4taMeav0xcBepHyitD2mGuSbsXQGInB0hdqCzxkt4C2EOo5eSxTOK2x+OwCp5/8MZ8olYeY/Vt2E5FxvTGrdOQTFqWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359840; c=relaxed/simple;
	bh=hFobZUJTfFE70jiuYLP6OG5lQ/kjNoAm0rPhN20c8JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/qSXOJu5N0zA2InUN2POeRxQTMGgiwQFvvCYdrmx/c1uzRUETEZ2cCQAiWMk2m8iYI26+PnKu8KApVXS0+1xyW0k3qtrVv3tO1tyZoMOGHU9IBsnOjP53onz2I8qX+0w7Xerz4/Qw0G+NNShBAJDt4ZFCjC4cby6xnZS4hd1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eVqrTKRB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GKXg7023900
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 19:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WsTaj9aC5GD
	50Hh4uc9YImnv7c9qgszQr9EnvkcFHK0=; b=eVqrTKRBhlWdtP7W72Uxq6NoiIW
	YQ5p6nq/CK9yXaMQQlgEznwtyPAEChT3Cq7Nw+/roK0elBzPbJjkrzDp3xLZk989
	K++0VQvquJXc0CYtc7TXeZQPid3bLSHCXciECvI+EvDEiKyAOOiS0rD/XyThvD0n
	+sXG2RVyKjERFHJB0kzu9fvevv5aX1+qwf8g6LOdS3Eqb0ECxkOuGciKtae6S6EM
	DjDhwp/74ROdDDohVZXEpT7/N4KT7K4o8uWORMNsWH637gFyrpSg8SBfSXu1FKSb
	f423jRqAadm/zn+NpWpiFsZ7QHcz9uHSRU/lIJBjDC71v+sZh0kFohyEbLQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a5n2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 19:30:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24b2b347073so63112905ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359837; x=1757964637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsTaj9aC5GD50Hh4uc9YImnv7c9qgszQr9EnvkcFHK0=;
        b=T9vf37N6kOSMed4Np/mhcVICoruia03ylMM9URcU3qB4VEjLUo71CwXaOAUoJaD9Xp
         r8Oz13Q9bIZeo+ZMK05y4E+P7YVDY31K70XpMR60+k6DBk+F8pvrvNK84A6pPRwNJ1l5
         oaa58BzoWjdcYKS9zhDytE1Fldc02BtK0KbHWYndcGHokHX64STezkO8P4I0yE28/GVn
         5ceAs0bU5r7d8k8MTIE/buE4HAw3daDaW3qVfibYJd1SoDez1bqSddjgIXh0fGUsGLJm
         xpzUQRYS2d8f2FH4LDambuBjQLPFxwTVrskIzdAk/u7sddb7/fz+t7Sugq3d7UJ/ENqR
         ahag==
X-Forwarded-Encrypted: i=1; AJvYcCV4N61EAZCIxF5xN3ibq3+ePH+MA6yePbocQBqDqJ4MEH/2Wj4TxtFbpnbU1RmTJK+72Mhe+FWsa8OzBWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRXkSLFVUYX5Abqjss/3GIMppQkc6YNTkCRte/j62SaCHPR6z
	97yIpZgmezoMEBbzxTGKDR0jzXFB7muUDmg/87JtQUbEcowdSiDrq8UlXEP/aDdVbi7GiFyfVNL
	/NK2aNnROnXyZHloiiQqEzn0Pq+nLwcS47jgEe2V8T2dAy06gviwLJZQ2OGLGhx3MASw=
X-Gm-Gg: ASbGncsYhetqUZ6BZpXH5ITscMYk5vk1r2lXE1vy4FSN3DKAms/8/9sHC3mCaOJd2kI
	OuB3Hexa1gdqvOdOYwSu0ai/NAPHQSp5kxp1QDsHSE5MzJyR0H3YOt4vXMwmBK9QyNLR8nsynlE
	/texaeC/HZBkrmNbaMuVaO6iCV+DctxGrOcpeYW3NaUjZFl7diEpO18XuPYya9HvTUylcLQUOcs
	rEhK0qJm36niInPuhwPhh/KrnWJ1b70Rmmp5bQqt3pP2mTaBs/L2WLAM2cggzlBq2FVlIADxO03
	75ldCrmvp9cRF4a1GrBKzNT84NbfrsqQkzafgZznUFfbl6VZ6vI=
X-Received: by 2002:a17:903:19ee:b0:24c:bdf5:d74b with SMTP id d9443c01a7336-2516dfcd7c5mr124311835ad.19.1757359837100;
        Mon, 08 Sep 2025 12:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnE8HmdaJ0DQoZXF+EtTS9roT6QVEtH1gZOT81nijuJgDxG0dijPNgZrPVtA0NPjF7Ux7yew==
X-Received: by 2002:a17:903:19ee:b0:24c:bdf5:d74b with SMTP id d9443c01a7336-2516dfcd7c5mr124311505ad.19.1757359836629;
        Mon, 08 Sep 2025 12:30:36 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c3110sm134810835ad.120.2025.09.08.12.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:30:36 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] drm/msm/registers: Generate _HI/LO builders for reg64
Date: Mon,  8 Sep 2025 12:30:07 -0700
Message-ID: <20250908193021.605012-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
References: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68bf2ede cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=QI1G1A81GPnZtfO3aA0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: cD8T_ZMH-UgFFhGLTorK3sBoQYlmkRJG
X-Proofpoint-ORIG-GUID: cD8T_ZMH-UgFFhGLTorK3sBoQYlmkRJG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX061aRsM/2y6u
 x40A4xXEk9HT28Dqu10RZ4kE7PHEp9xXGlY/cEM5+skCNZb0nVnadvmh7VDtnCl/fIfPb/0/I5F
 REDZNRPLdNSE173zULA2VvPT+B0AcLcB2bGwLCuyzVMNm65Iiv80TKGV2YJBsxeVOa1ZB79kDfr
 Z7VhwwyrYbqqYfRxhZiQVCCULJwsefHde9/Hq3gr/VAdOwNNi+PIajeN1oK5Rde2mQLGhWpr982
 y6UJtn9SMGATpUiIMGW5OjtcLFSOAMJxMRfdMlrqnRxeqeZL57+YpHW4R5oKE3JljjaHzjAIYGG
 CcINwp6Ba+4fSl0YSs2QwLLQk7/67XNkx1bqyk862E5PDB3aKW7h+ox1QPJetqRlHF+GUq+kD15
 2ZBN8amP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

The upstream mesa copy of the GPU regs has shifted more things to reg64
instead of seperate 32b HI/LO reg32's.  This works better with the "new-
style" c++ builders that mesa has been migrating to for a6xx+ (to better
handle register shuffling between gens), but it leaves the C builders
with missing _HI/LO builders.

So handle the special case of reg64, automatically generating the
missing _HI/LO builders.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/registers/gen_header.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/registers/gen_header.py b/drivers/gpu/drm/msm/registers/gen_header.py
index 16239b754804..1d603dadfabd 100644
--- a/drivers/gpu/drm/msm/registers/gen_header.py
+++ b/drivers/gpu/drm/msm/registers/gen_header.py
@@ -161,6 +161,7 @@ class Bitset(object):
 	def __init__(self, name, template):
 		self.name = name
 		self.inline = False
+		self.reg = None
 		if template:
 			self.fields = template.fields[:]
 		else:
@@ -266,6 +267,11 @@ class Bitset(object):
 	def dump(self, is_deprecated, prefix=None):
 		if prefix is None:
 			prefix = self.name
+		if self.reg and self.reg.bit_size == 64:
+			print("static inline uint32_t %s_LO(uint32_t val)\n{" % prefix)
+			print("\treturn val;\n}")
+			print("static inline uint32_t %s_HI(uint32_t val)\n{" % prefix)
+			print("\treturn val;\n}")
 		for f in self.fields:
 			if f.name:
 				name = prefix + "_" + f.name
@@ -645,6 +651,7 @@ class Parser(object):
 
 		self.current_reg = Reg(attrs, self.prefix(variant), self.current_array, bit_size)
 		self.current_reg.bitset = self.current_bitset
+		self.current_bitset.reg = self.current_reg
 
 		if len(self.stack) == 1:
 			self.file.append(self.current_reg)
-- 
2.51.0


