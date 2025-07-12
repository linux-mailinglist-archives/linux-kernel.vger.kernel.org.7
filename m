Return-Path: <linux-kernel+bounces-728471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFDEB028B2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E7C563280
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA81F416B;
	Sat, 12 Jul 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mK9dcDmu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276713C81B
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281924; cv=none; b=GPxAL7zH2Pi6MN3tN3S9Nsuc0kKyzEC82kgA0oH/3GjY5aW9TN80Ygh20+P/bkaLT4dpe3FUg62DVbY9O03V7fCZD+AtPAJmQE9WyjD8mmSfQGZhAn7dyH3WrH3nhMO67xG8bFXXgEQ6JzfGByuBMb+nyQ9tb9sTVx+tCRN0WWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281924; c=relaxed/simple;
	bh=nIfQUqs4DWyTyQ8X+5Gj4joj1SqszgTJug8d04v5+GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UO/VS7zmAgUloNv9yTX8ICy7ucP3YKbYNYLNovgbgH/nSvNx64lajerJxJTlGyoHu2F9mPOKtrXs2MOLp6SZX8YBn7Dtpvvy+G/YOTRDJsoMT7wt0GMx+eO+PV6QAVKwPPssNfPg6NV5nmvLu4iEhzZWH81kiEv3wy7xgpb9PAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mK9dcDmu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBCWQo007995
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FtDMkE/nYvcymb9V2MvjT6eL01NcAA2GyDnTtlSRCMc=; b=mK9dcDmu/p4ImfHO
	j8vjU+nuAxRlrek/XbbCsHHIB3y61NLTmrvLRPnmWhwYJ54XNozT3d831EvNG04Z
	q0cXIQjTYyffeEAvretA62opuwVgGo44UV3kGvBJYKlxnhF9PSAawiXtPyx6B0Zp
	CivnL3qqMv+BaDIRzUbFWNmp2GunpYvxgTBiudpkKdW5s8jmAFE9wPiRTokDxB2Z
	ifGLzpHzPnQs8t7BKNTMpYapF5Qn+IPsKf4hXfZks1eGqX5PZSuvSM5G9PbXRg+C
	vrA78rMUIzwfEYzo9ZA+WL9B1a+CdppL5rd/hR2v2mNdbdzKyGDz+6IXgLwuBqIh
	t5qKTQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcga6sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b34fa832869so2946651a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281921; x=1752886721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtDMkE/nYvcymb9V2MvjT6eL01NcAA2GyDnTtlSRCMc=;
        b=Esb/ppkxCHC0dlPAYCZ0s53nfC0FeWWGKA8MdIYR+E3H/rjXh7IWAN2AYO4N9wKoZ6
         OD3Fnb3/CgogqnsdsuJwe7fok1tA/rWs8cOSI+iku6Wz8UEi/ivXHTE0Uuu2uNlhV6ce
         J2WdJ9Oojw9BJ1JM3gobk8N8lmZCeFN7OsQ1L3AVcIZpoPjA8bM4QtgRAzjZdV94e35w
         kkTfFTbXk+c5JOi/kMbaPcYco/N9wHeXmxw4/k0afRLVPvPaozXmTwu8FclPTDU0pwg5
         wWFfVTEPSQpRHA0kWEQ3+jypKvi2R7vuaV/5RmNIaONnlB3+rZCUfL+PTg16GqYAVuU7
         26kA==
X-Forwarded-Encrypted: i=1; AJvYcCW8RjbuSBvY5OaD0ZJHAiGqKVGsDQv1l1DE5PSuhGGRUprq0OFrYZ9YMaZFoX5oW+wobfkAWqwDZrg4MEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSmgMo24CDhdsNXZjL4Yvw6HQhNQA6+UDvCeoHo+fBN1hni0M
	reA8tthvkSbs1FtJMKqcdf0fooa8vXdxs72gXLGlck4pn1DjRfcRCkwaX5FOKd0UQ0qTI7kaPGu
	pvaCw2k5uQmrlCzEkeXNKF4mEiprmSADRx36bXXbuqaqXBTQjMugeFiiA4dAZVGyWtgY=
X-Gm-Gg: ASbGnct22q/cPhVxwS6JM0zpw8N+mtcw6/b35zT100WwrLvaxtg4CxYK5XJ/j0SpWeU
	cY0jLXJkoxQfTfKcaUtEiLRIszWO1JMw9k+Iq35NFcHQE3A+iufWdBAgsmt3GwhifKOWqDlNdm3
	AtVTESNPYUJcymNP7OcgxQ0NFpzL/SW7SkapgDU1mqts387Wf9W8nM5LfoVqef17sr/9uDUNSwU
	FlH83X51nt5onWntRHnR89P5458sbgKp+bNBhCgLB9C+Oty8aefOa/ZFEAwvV+aahTfC3R8P7QR
	i7FEqMStQkjguD3mcc+9t6fHP6xE7PJyIsVvTqu3YXE1ar7L5ubGYVuA2OTcZpjDIkBDdxUMIrG
	yTvNOWVOZxt7YuEnnOzXHJHv/
X-Received: by 2002:a17:90a:e7d0:b0:312:dbcd:b94f with SMTP id 98e67ed59e1d1-31c4d4cf62dmr6563738a91.11.1752281921317;
        Fri, 11 Jul 2025 17:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkmyvyut/CURZ5YzbZaUOdCU1WWcrvWnhSu6oPk2z13iP/0OOjcK8+xnbnEI46xI8fV/XCXQ==
X-Received: by 2002:a17:90a:e7d0:b0:312:dbcd:b94f with SMTP id 98e67ed59e1d1-31c4d4cf62dmr6563680a91.11.1752281920613;
        Fri, 11 Jul 2025 17:58:40 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:39 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:14 -0700
Subject: [PATCH 09/19] drm/msm/dp: Replace ST_DISPLAY_OFF with power_on in
 atomic_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-9-33cbac823f34@oss.qualcomm.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
In-Reply-To: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1734;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=czxDsq22LT+pLoYLzhxwBsQa28JP07lsZiCICURAXyo=;
 b=XhpMkCEr08Yom6OH/qj4yFXw2PuaeopNT+hn2CIYsc/UvIaRDghEcO05XoTOrr/0rliS3F66p
 QxV+5b5f5q+BLyFCJzJrnez36qE+LlI4Akf6ai4ujGbBP5Cx23+BH7W
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=6871b342 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=c02wphsZB3Yn0AVd1wgA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0AjLaSybFG9wtNdTDK_BngDdbUbvL_ux
X-Proofpoint-GUID: 0AjLaSybFG9wtNdTDK_BngDdbUbvL_ux
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX1rbjlMNY7bt6
 C8G0gwPQh5+gsM9zqSVRqxmJUZv5zrNfCHujqhNn8CopF1oR9rfH1AP61n4iSBFnSnnlRmiWgQo
 Ec49UVAwBoHe7tcjwn3kItDrXd+uFdcYYJU5fT+QhrVHVk2YnChks3dp0/Uic77FKrqfmVKsOhH
 P+u2rilVv1Vkoe7thzVhg2Z0+mM/t6UYnZ+9H0VkPO9Mhpdd+eeq2o2/IaC/PUgTdfiBpiFR5Mx
 mFwHPkpQTykgTvBrGdGj+a344g57d/oJ5w+hdQoJbXwrv7RvV25Vpm72fvQBeea7iBqO9KMvMhc
 nMycMhZizUq5U8BnV0KL2xUtDa2ZbeyIgEDdx1gUWJpvZGFzbDZxLQAg0ffMsIm+TcJKr1GfAY2
 N9QLLtb0SG5fB7G73o4eDFKl6CO2aTlKzzHtx0Ond5nanM+zkUP0p9kgqPzQ3Ikl15S3XOEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

ST_DISPLAY_OFF check in msm_dp_bridge_atomic_enable() is used to check
that if the display was disabled while still hotplugged, phy needs
to be re-initialized.

This can be replaced with a different check as it just means the DP cable
is connected but without display being powered on. Replace the
ST_DISPLAY_OFF check with a combination of connected and
power_on checks.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 98f5274f123e..6535c1cccf84 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1564,7 +1564,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
 	int rc = 0;
 	struct msm_dp_display_private *msm_dp_display;
-	u32 hpd_state;
 	bool force_link_train = false;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
@@ -1585,7 +1584,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	}
 
-	hpd_state = msm_dp_display->hpd_state;
 	if (!dp->connected) {
 		mutex_unlock(&msm_dp_display->event_mutex);
 		return;
@@ -1598,9 +1596,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	}
 
-	hpd_state =  msm_dp_display->hpd_state;
-
-	if (hpd_state == ST_DISPLAY_OFF) {
+	if (dp->connected && !dp->power_on) {
 		msm_dp_display_host_phy_init(msm_dp_display);
 		force_link_train = true;
 	}

-- 
2.50.1


