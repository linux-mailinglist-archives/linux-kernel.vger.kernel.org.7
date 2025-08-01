Return-Path: <linux-kernel+bounces-753236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61303B18061
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C88F7A42C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB9C238145;
	Fri,  1 Aug 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LsNwnUEV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8923535C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045208; cv=none; b=cWfakWME9LbnLYnUYdQLkTObd0F1QmKCyk6mFhICpACNQ6vG5H3vNIj5TO7onN++fciymVar8atTpJnvmhttT1SNK0unEi1iMnvJwGY9BwBiUuAFogUTx0y9iqRUS7fVLLJZvSnPS7S0nJH7KyGgY8j9wCZFfRvtZUFKIOpusyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045208; c=relaxed/simple;
	bh=w1+bYMIxI9OSbUv26vLEMczzfyh3ZUtUFRS7nZhDrrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FRAOlMUUUHAK5pk+34uSM0c2CPEs/2AdU3uCP1Aq0yjI6Nc/F7Ug2PVvpudjGIASxWcKKQzg60lxBmmzxfJlVk55J0/qQ5mw9RZV9+UKmR0EBmXYNDhzEjUoM/tJyG9ok4xXiZqYnHegpZatm6xT95iHoogRrUUl5lF/Yj5qiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LsNwnUEV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57190kSW020314
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 10:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4dMhx8coEqKsXCZf5pJZOj
	AWLN0cf9W2YmJUYfYiRfU=; b=LsNwnUEVW62I7ybjbIPmKQ0RWa1gcW345BJvpW
	Tsw05JVAVixkveWqtLqK0GhS8gpk88sm36BfmMPF/gKeeQ7apKjHiFKq/9qQzR/c
	H661C574b/7rwgv/UqykcVp/VKT30plb/bmKr1DqurVn0l9UkgA7aXjyzHEjOlOS
	0k8ngonMTq+n5XwQnFDWPvcCHXTux2V3nmFCU7O0o3T3hcbt1aLK12etvTx0v9Mx
	w5RENV7brrxzdeP4YI1biCYefTuOTsKubijAur67y3+4c/SNOju9ceB8OlMszmi+
	rvzBOlv5wN+kvtabS2YQeSUTVHAAQPiS843HmhckFGx8U90w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1aue6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:46:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab81d016c1so11305701cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 03:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754045205; x=1754650005;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dMhx8coEqKsXCZf5pJZOjAWLN0cf9W2YmJUYfYiRfU=;
        b=TYfYDhK2tVw7fL5j6M0D7ciqZ1RA3T+/zh3NX/s3oKj6a71rI3dy+osp+h3j5bHzip
         Ed6mBYICyYc9nWHIwoe3k9r5fvznq28owE+QlFnu1Zy/CMSE6Y+PK4U0K1mBYyb2rA7H
         La8Sy/zco2V8F9tWE/8Ca9OysPBGqBTI73QN2IL3tBMUUMYO7ZkpqETmaj/WafcBT1eD
         QImB86l9md7NhGL0ch4SmNaVqKNDwIcVayy0Jfj3sMdw9fPENZzY0u2+kWHb6r5W7vU9
         otIEC1Yv1E9DdAcXdTXxbCM9ezoPEUXVvtCjc5sixL72ZjeYzfJscdFXaiU3AoM1LJLk
         hQeg==
X-Forwarded-Encrypted: i=1; AJvYcCV3OOAgDBHMSVqqsVd7mf7L1tEgyiO9aQmRkbv8PflgoILHQzW+dOE3boKN2ntKq3hpfL5khbUM3MdNkPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6NM10sedSvk0X4pa9ySGRbNay9o7GYC+nARNsQyd9BmsfZo5
	LY9/ZMRzQJib1VwgGTcAsX99dcSNSb5CRgbMIDFbBHNqnZcyJkynKtLTmJxKfdUxl59zPOXpy50
	0v8tSd18N6amhXc3O285a73EGoFQPIdMIB65m04XQix9LW88WhVv5W1iF3h5mJd3SVZ0=
X-Gm-Gg: ASbGncspTf7SAxmv6SK1dVCsaBNiPtO9kusgC/NJEAO2X7zoQKkDrcQzDb57NuLxUgj
	2myN6NDrL1DWP8XTONJI2ew7t+Vte+XHvocMlH0IZTxRXXklfzR4cNEg0czDOk3QjORnG0Zeadg
	p1OOy1pG14l+ngR/otpK1qJWBiG+pDJscVuFg7XugxOeuRHe8bCWXnr5WQ01ccZONwubLt9DV6Y
	bSk+ylJ/j7acSczE0h0CIORx9E+vp+XtgCO995iezX/TOITzJLlZyLcoFAAGQa+1E1hAUVtcntM
	MfNHrBNKAOsZTFBJ76stzXC1oIvlaYOZ5NJnFDLUFu9IXjU/TTnrk4psP8rlVd1hNFMEX32ntYZ
	iqpedcH8JgZ2V3feRoiFfl+rMwZl02CWjPTrN2RACLe0OhF53B9Jh
X-Received: by 2002:a05:622a:15cf:b0:4a4:2fad:7cdd with SMTP id d75a77b69052e-4aedb9ce5b4mr180425011cf.24.1754045204783;
        Fri, 01 Aug 2025 03:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg/veUEjYhUB9L3VVRtbJjDdyPawkgWzSRdvHMpIF6nrvUZ+T0kKUmxRc0SR+ylGlKty+1Nw==
X-Received: by 2002:a05:622a:15cf:b0:4a4:2fad:7cdd with SMTP id d75a77b69052e-4aedb9ce5b4mr180424661cf.24.1754045204161;
        Fri, 01 Aug 2025 03:46:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm531862e87.96.2025.08.01.03.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:46:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 13:46:41 +0300
Subject: [PATCH] drm/bridge: document HDMI CEC callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-drm-hdmi-cec-docs-v1-1-be63e6008d0e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABCbjGgC/x3MQQqAIBBA0avIrBvQyIiuEi1Ex5yFGgoRiHdPW
 r7F/w0qFaYKu2hQ6OHKOQ2oSYANJl2E7IZhlrOWm1ToSsTgIqMliy7binpRRKvxRnsDo7sLeX7
 /53H2/gEsR9OOYwAAAA==
X-Change-ID: 20250801-drm-hdmi-cec-docs-541ee6afa5fa
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2748;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=w1+bYMIxI9OSbUv26vLEMczzfyh3ZUtUFRS7nZhDrrw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBojJsS5Eh73fanAuFTKmyG7sFpTbsGu0bBxRv04
 NIm5bwIJGOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIybEgAKCRCLPIo+Aiko
 1V5VB/9JgdoNwOntE2YPl21WMqNdFFlOHMKpgfyM4CM4XmhAEVu04s4eVg79IuKB1+QRouFFjU/
 R55C5fVVWUIp5vsY40gxe/+qQR9yM0C5/3LU1iNasUm0T+l+YMALKKpr2rF0zU1+aI2rRAMvVKk
 QoGfKv0p0NI+vwRj3LbF+oY18gorWsAF2/A6J4RdZC8Ssy8iAoYHn37Ykjd+FuaO1UGl3LQ5Ux/
 n9vEd2IfCm2niIr/0woxNXre3N+2ECxJ8WPKbIKQCZOjjIMYeTE+WdB/Xcz1ulY4lIId7gTsd/W
 IN1IR59jyAy3nUya5MqPVk6O76aQaEgy/KewgnklbdBM8GV+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: rh21u2KMXeqhbYBwxclkKQuPVWQTufY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3OSBTYWx0ZWRfX1vaUghWx2Rx/
 z8vkpMG/5netG/LrdLl5gU2ZDujeZ9GgYFRF8B+ZCb6OfjPknsOgSp/MSVGPdWLk5atgF2E2R/J
 YxktS1I+aQBaLuIodudEXuOq2yxd24eE/jsyYFfhyByjJxG1KQBk5N2bcb4gkhLEEAOfj8JDdh5
 t63PnWEFV5PRdCdQHnQWwAwG8skYMvwJ1UC7Yf5ltawqgdQQPoUsmHl+62kgKj0A656kfu3gzhV
 WBVJQsXdOEIWXwjH5mJd54vHnHbpkNvD88c+qcUap5661kfksG1LpH17fKirsvin7SSq/8gV2bZ
 HpgAihPZtqKwuRk9c1vLU2M+uvNtZefAvfdb5jYGYht+z6koeVEnWzIT+PD5d4fXLq/Y4AGwWsf
 M4CaVB9ZIDv1Pwih4oelCtcqXz+Np9UayXzH9p5hXjpFVighqqMZkeny3QI1f0Jb7HL9V2Vv
X-Proofpoint-GUID: rh21u2KMXeqhbYBwxclkKQuPVWQTufY9
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688c9b15 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=EUspDBNiAAAA:8
 a=F0gKrZKVUcZZPVP-J9gA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010079

Provide documentation for the drm_bridge callbacks related to the
DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag.

Fixes: a74288c8ded7 ("drm/display: bridge-connector: handle CEC adapters")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/r/20250611140933.1429a1b8@canb.auug.org.au
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/drm/drm_bridge.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 8ed80cad77ec4b40d0aa6159e802a2839d5b8792..b0e6653ee42ecc088f420a9a32cf3b0428737a4a 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -866,13 +866,61 @@ struct drm_bridge_funcs {
 				      struct drm_connector *connector,
 				      bool enable, int direction);
 
+	/**
+	 * @hdmi_cec_init:
+	 *
+	 * Initialize CEC part of the bridge.
+	 *
+	 * This callback is optional, it can be implemented by bridges that
+	 * set the @DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag in their
+	 * &drm_bridge->ops.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
 	int (*hdmi_cec_init)(struct drm_bridge *bridge,
 			     struct drm_connector *connector);
 
+	/**
+	 * @hdmi_cec_enable:
+	 *
+	 * Enable or disable the CEC adapter inside the bridge.
+	 *
+	 * This callback is optional, it can be implemented by bridges that
+	 * set the @DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag in their
+	 * &drm_bridge->ops.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
 	int (*hdmi_cec_enable)(struct drm_bridge *bridge, bool enable);
 
+	/**
+	 * @hdmi_cec_log_addr:
+	 *
+	 * Set the logical address of the CEC adapter inside the bridge.
+	 *
+	 * This callback is optional, it can be implemented by bridges that
+	 * set the @DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag in their
+	 * &drm_bridge->ops.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
 	int (*hdmi_cec_log_addr)(struct drm_bridge *bridge, u8 logical_addr);
 
+	/**
+	 * @hdmi_cec_transmit:
+	 *
+	 * Transmit the message using the CEC adapter inside the bridge.
+	 *
+	 * This callback is optional, it can be implemented by bridges that
+	 * set the @DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag in their
+	 * &drm_bridge->ops.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
 	int (*hdmi_cec_transmit)(struct drm_bridge *bridge, u8 attempts,
 				 u32 signal_free_time, struct cec_msg *msg);
 

---
base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
change-id: 20250801-drm-hdmi-cec-docs-541ee6afa5fa

Best regards,
-- 
With best wishes
Dmitry


