Return-Path: <linux-kernel+bounces-754094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E37B18DFC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAC41AA1EA2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4731D221277;
	Sat,  2 Aug 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zsuangat"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ECB214209
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754131241; cv=none; b=amXBKrW6hw9Ucc6f+uZIKFcaCXO+mDNXfL1c/p3KLe2l9acLNBPAkXEOJ0MEjYcXQRdloZ/bk+W4AB3stkL25m3kKvrChFk3Bk7Uybgocs7ENZeRMIIEvpKhN4bnV7jPQWUnCOlS+Df0JCIk+8ewWgwOH6ocM5ehgCJHwp9F8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754131241; c=relaxed/simple;
	bh=V5fwEFSvd6iZX7vn1nOUGXoBQVgsda3sPWa8+8IxVEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gF8crcstBSPsmeeS4gIZrLW1atKzTEbfgBEd5O/NG1QVMJYSsK9DC1T1Ta0BwjSuF55oD6x9d0RONQ5xJ/+CPQ/4PszaSLBJJ6hdpfxBjeX5O2wVhMPJUntrB8t8A6hOOqtH7IT4adk/MG13Ht/J1zSm6D0Fg6/1NYK9voKV1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zsuangat; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5725f2ep008607
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 10:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zu+wgBbmPg38lcKPkzJiVr
	U6c5vcWfMV6SwJ1iTuKKQ=; b=ZsuangatO6qj+6HG4GpE4UDl2oB3KlcZ2GL6Pv
	IRY9pcSj7d+ylN5BWf7CCSDZHCh2FuvTCH5n+nTcI1E5L94ZcFAR29KHhTo0eJsL
	om+2TFYMbPWEvoaE8dBiL8wF8IkCyMyAMXJLfDu7+CDOpbGvssnWvC7tuE0yC/K7
	M6+wv9LGBzChwxaZoNA5Q0usM7Td1e3kzfAh+p4L2SkxcMZpno00Il8UUiDlFRRk
	XjvHJ4PRf/ml9WUCP8iYdtYB/xyF3lXErUaHcCVZuOpJti6/ZrxDiRCwZjh58kAf
	7SmH+TT4jyTYcqFYKRHZnH6nM+6UNqx/HknWn4SOqj/xjWwg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899mvrraq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 10:40:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5cd0f8961so302071385a.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 03:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754131237; x=1754736037;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu+wgBbmPg38lcKPkzJiVrU6c5vcWfMV6SwJ1iTuKKQ=;
        b=sNgUonyvnl4cSCL356hnFkopKvIlAxN+y/CUPp4Mpgdf++bNe+aSlkQPzWgFrRvKEd
         vTSYGHlN74hYVSmS5MUYiprf2hD4bnBSsb7cdo8gTIYbXVgp3r3MIbKtcSkkcbSi9vH4
         B9Lui6wI/rbQgnKWgxjD82iAD5dsm9alDFREJSIuW6mz7a9YTSme5lmsEfDej763x5qG
         IB4JdDe2KBze5mwTOIVB7zdWbunccX5w4/IaM9K/QWB/ZGX3SOP337SESFQmR6vqAQPL
         5Z4D8wtugQPOGAAFMwdn7QmSClNworBeVG9UQzpUpsYhsMG2BYG+D13ozyb8v0g2HrVc
         TmGg==
X-Forwarded-Encrypted: i=1; AJvYcCUp4TE0SqbXdtuoUlW7H9smgiU1LHwf0cQhht4Xe2rfwvCfDpblrcFhOnbw2GzJQ2Ly7KqY3tlb7N/FTHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInccI9tqIffWWHNjiOB8J4GnC9v5OPSQCXlroCz/G0WOhBBxB
	jaBZ/GaPcZYe/BDDj6cGJgnMSYf4vB3SRasZs3BuvRt2ihVKbr/8L1R+GCCmvxIhFOnOzzkka0I
	GXmWyhC4e3E2mIZCMRucmExzphZi0rWENnO1Q2qHT+MPdKtwtLkbPj20TOaCqNMZYxN4=
X-Gm-Gg: ASbGncvJmyP4sQnyMqplwOP8m/VfwIuzyO5xbUFhA7m/tfERaeJr+PkWtA0YyEN2Pik
	89U19xGfgsVBFCjokZW8K4Z1tSD36eNhvG36Ln6c0udlaYKozWy6VAC7G9kn6+LD140jaNd5G8X
	m5E4XKu5SRZA/j3DslVbpZUsU4LZLWuBi5U580D66kMRstW1d+2ZeEarh16bmviHPicfsEdaGpv
	BhHQb/e5b+9f/mjHfqA4B+b6nJDg7PQvhSU3LaxOW6hVYc8YPbZwZniANnomywyMpIKRPC86uSp
	m4thezTrV7G0Q91NR70mBzmRl0z9W95CpJfNHk+Qz1132Eo/tFbKni7n2UlANmCWIED7wLie5E9
	LUa7/fz3MGeAv0auT4Hj39ZKANx3pR7fjov7dy9ghJI8+IyBgYyje
X-Received: by 2002:a05:620a:8c3:b0:7d4:49fa:3c59 with SMTP id af79cd13be357-7e696290870mr383575585a.15.1754131237464;
        Sat, 02 Aug 2025 03:40:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo5WUyWXxaVu371UhvAZx0Y/HJm6ZuA6t/pRnQ+dzL5rNQV5KuJVUOj53fEOxRGNJb2YAEHw==
X-Received: by 2002:a05:620a:8c3:b0:7d4:49fa:3c59 with SMTP id af79cd13be357-7e696290870mr383572585a.15.1754131237029;
        Sat, 02 Aug 2025 03:40:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ace49sm928030e87.71.2025.08.02.03.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 03:40:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 02 Aug 2025 13:40:35 +0300
Subject: [PATCH] drm/bridge: display-connector: don't set OP_DETECT for
 DisplayPorts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250802-dp-conn-no-detect-v1-1-2748c2b946da@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACLrjWgC/x3MPQqAMAxA4atIZgP9QVCvIg62jZolLa2IULy7x
 fEb3qtQKDMVmLsKmW4uHKVB9x34c5ODkEMzGGUGNSqDIaGPIigRA13kL3ST0uNk3UDWQ+tSpp2
 f/7ms7/sB/Uavb2MAAAA=
X-Change-ID: 20250802-dp-conn-no-detect-b901893b5e3c
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=V5fwEFSvd6iZX7vn1nOUGXoBQVgsda3sPWa8+8IxVEQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBojesjxhI5LE1y0oeOUvU2pvk6ANdl/CkH4FaFn
 0Ute45kT5KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaI3rIwAKCRCLPIo+Aiko
 1cs+CACO7cAgyLFxQc0407yt4axfgDYItBSqQrrMOKTFTpXNQhcEIIfC90mhSmpoxc/38Fm3XHw
 fqowe6NMvNUzZwTXJ8KMUnWE1FvSmMHdMF5i5f4VgqmxAQn8zvzFjBnuHz2GmFdoZvthLG0QzLC
 Elz1LL+mzcAtxwoSMw5L35tIUhtCZuaQxDho3igakcyl5osd6VOYS/8vvbRslEL1RrDZR3iMTCK
 79eHouHtIOvUwF/8zPOubPwnD4pYd15BlDrZWiWehoLxZP78AwVQhIlwNGp2Do78LWvzs3Wr7R3
 6wZkKoLwjQmzQ9n5+uCslf7Ew0/0QnuyxPkIsbKqr1R/oWgc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: JX6TUe55ZzYOVoax52DUz45viKU44BEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA4OSBTYWx0ZWRfX7VMxcnUhdhfB
 7e/VRsytglRRcJlKFZFo3ki4TbqhaadQAsoaPG2pemUPbPEEJsW7UD+D3LXY5DiL1QXT22Hgdbq
 xOQ+mvXo0mp0Ii6f+WLzkW+D9um56qYjBdB6o5Ab6f8P4eN9BeN0VqV/4m0gpKDFlpFJ7MXO1bo
 G954v8pbWHWHVQSIXaX3yER8K4+hv5kNvLcdnQjssNd19aE3H5LiivjR4H2b39Ej8hmhTPDY/2c
 iWUicSqnj3FAvyxXzGvIQb61mD2Wjhe+r6Qzm8nICQHwN4MqWHuNgrJxwmgvvPxD4g+nXFxm73P
 nYxcZ8d1QmJK2kjPdTjJKxvfbLxbaY6xMQHXiWGTsSoGlmTEcUghU18P/NjvpMh/SnnTRiHbZcH
 6us602v1KSmymeZKkeGnSOqkdeCsqAIaK5rPrNqmUvX/HKboJE5Bsy6Bw0+1TkynMPx/eG8F
X-Authority-Analysis: v=2.4 cv=duXbC0g4 c=1 sm=1 tr=0 ts=688deb26 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jZDBt8FwwR466f3IuqAA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: JX6TUe55ZzYOVoax52DUz45viKU44BEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508020089

Detecting the monitor for DisplayPort targets is more complicated than
just reading the HPD pin level: it requires reading the DPCD in order to
check what kind of device is attached to the port and whether there is
an actual display attached.

In order to let DRM framework handle such configurations, disable
DRM_BRIDGE_OP_DETECT for dp-connector devices, letting the actual DP
driver perform detection. This still keeps DRM_BRIDGE_OP_HPD enabled, so
it is valid for the bridge to report HPD events.

Currently inside the kernel there are only two targets which list
hpd-gpios for dp-connector devices: arm64/qcom/qcs6490-rb3gen2 and
arm64/qcom/sa8295p-adp. Both should be fine with this change.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index d7e1c2f8f53cad514ec502d58c1b94d348515b42..e9f16dbc953533c2a2d329ee8fd50c1923a78aac 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -373,7 +373,8 @@ static int display_connector_probe(struct platform_device *pdev)
 	if (conn->bridge.ddc)
 		conn->bridge.ops |= DRM_BRIDGE_OP_EDID
 				 |  DRM_BRIDGE_OP_DETECT;
-	if (conn->hpd_gpio)
+	/* Detecting the monitor requires reading DPCD */
+	if (conn->hpd_gpio && type != DRM_MODE_CONNECTOR_DisplayPort)
 		conn->bridge.ops |= DRM_BRIDGE_OP_DETECT;
 	if (conn->hpd_irq >= 0)
 		conn->bridge.ops |= DRM_BRIDGE_OP_HPD;

---
base-commit: 82928cc1c2b2be16ea6ee9e23799ca182e1cd37c
change-id: 20250802-dp-conn-no-detect-b901893b5e3c

Best regards,
-- 
With best wishes
Dmitry


