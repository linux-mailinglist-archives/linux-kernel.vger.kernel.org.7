Return-Path: <linux-kernel+bounces-808470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5829EB5003C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E364E6545
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A46A353361;
	Tue,  9 Sep 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KguWA7JR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A3352FEC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429550; cv=none; b=lxSjHGdX7zmj02g04MIz2lRAhUFBl3JITe5m47dWObPgTjjCiztcY+onSraM8evZSfT1tHJOLlu0Q9/ILmJU6c+hDXscztmMR3tMfbOmqC5O7Nh8tO0zBM+ooR07917s/7OiC9TD2iu0sgL/m6ADptaJlaxdyvfFTsgInV8KxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429550; c=relaxed/simple;
	bh=Aq2mDEHmgp1SiIn37OLqW93okHrHKspB826EOGNpiU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMJlSjil8WG9N86otwLhgcs5lt0pILv9KH+7wOX00MOFHG8ZckCZJYsIDwtP/2/AGdmBAwIQ/da5LTSZ7KMmZCuGjBOWgSzG63vFRmzztEDuAiaEwrdZZ+V/DOjPAxZ8rVk4hmtzyBnW5QnEjUp4W098xjKU23eSPYdnx+VHJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KguWA7JR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899Lhxj029929
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kdVSeIKuXTDzsb1f8YtSPNgLNA0VYyyck2+ZYEf3zp4=; b=KguWA7JRiHwdSubP
	gIgUX5U8rJR9evqjY/OTKPWycFLytfleVbA3JGx05fJeSXD3vvydeTWKz22i+pBd
	JuYFQbNhLbrnJZnDJjMkqNtTMOxstH+8A92uqWWw3Vs79nIlSufsK50wv/MGonH7
	MNKOUI/ayf5VG0UijxTtaTt7KxTJ5j0IN3FvF4gW2x0GIiL9jffURHxo+WmeMCWb
	p6kbZqrnQj1H3NOT1ARpzJ5mFYj8KZwPyPUaGB0GXAqEv3FIAOc2cDjtp0OnBZXe
	/rMUikho++7PUVS/Ajssxzic3MbohvRDyedLi1TGyRxB6EWqv75/SrFaYrL0OFqX
	Ws/yFg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37w20s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:52:27 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70fa9206690so113501656d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429546; x=1758034346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdVSeIKuXTDzsb1f8YtSPNgLNA0VYyyck2+ZYEf3zp4=;
        b=M4JY2pjQ/pfV3GdHAwQDm8wt9EzeVFVEqVJjDMz1Sxz0gs2bCe1JZzjMMqAs/kRNJB
         mT4xdTMG0QccTNBi47qE2iR5ORGPnUi+QxBTw5XHVbEiaIuL0AzEIq/vgIbeCDlhIXXo
         kfrlTIM7JDuccKeO4qfckdOrUr1669Spo9Un1w7lSmmE0DcLeTmh8q7JjLl1lQrtiXOM
         n30/7dUt/H6oLHyzEiRVTWL2bx3Wl5gY25a+H/bq5yB/1dkapi3SxolZ3kypjZ5IpVVk
         bviHQLYC8/4H2pfT04ZFNBLmOHlHUuuyHAmRz5XHDz/cN3HP9LSho/JGpBLM3j/dTHKz
         1zXg==
X-Forwarded-Encrypted: i=1; AJvYcCXfzZBBgUcE4fBJ+zaaDmVdz/kbNzTClUBlEl4onefKRCcORjZKI/O8EMtVJ1I4+n38SA76GUtPqTRfsoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsAGnD762aQhMCH3NvAJNZlx81Kbtg5SfVsdRw/8G5ec4VvDj
	EfZ0HI6LP8tQAx7LKH00TISFdkHKrx9YgSJ2WEtS4LMh/o1r+/Dq79F6zbca6j6GyVpSyqZ6kcd
	cB3tTvF7oTYHZwRCWCKpDKoIarvOt+r2nZs8aSZrVr8FsEzyy4AxDW2O6JN8w/ypz1AvADBPsQg
	U=
X-Gm-Gg: ASbGncvpUGi8oFalwBdLJ2zy6NWwviyc5dvjUdHS5raHvalGsU3xFciEwTeoPCaAEVG
	YKUejAJYCph0M4fbEr8gfmeNeit94PShHX2VlmrMKcE2di13fCtvdUzSNc48ZYPe/JbyA2HTSzP
	UBjR1OEzpZtV4p8388u3xojsDEa1Uy0oc6Qnov7o0SPoob3FBAkK9VPAH+gwFWIYsmy+XIBp1fC
	z6cSaYOpGv2P1nkQR9IG7yp6L1ZN2vHDdyGyl2GrBXUMJQWeB4WGN/ux7hnCnLGveMwhAaUBBdO
	TBfdxnHXz9Sx8d0W/rYuH84XQZ281qEzX0mB+LtPsU3mNXPKmvltNWuYNMTS7uTeGmt9sIRRUgd
	bmE4IxMmghfOFLCkeSb3YV93A3OE4OebfMLk4XjznL0WR+BIaCf79
X-Received: by 2002:ad4:5fc5:0:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-72bbf3fb0b1mr158064396d6.9.1757429545929;
        Tue, 09 Sep 2025 07:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+0czZpNTxq9KgOE3QwkI3s44ERVHWu12W7OPI2XDlhVfpfdH+nJD0CIFl4aY+6gycdCccrw==
X-Received: by 2002:ad4:5fc5:0:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-72bbf3fb0b1mr158063976d6.9.1757429545199;
        Tue, 09 Sep 2025 07:52:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c90eb9sm38735781fa.22.2025.09.09.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:52:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:52:03 +0300
Subject: [PATCH v4 05/10] drm/bridge: synopsys/dw-hdmi-qp: declare
 supported infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-drm-limit-infoframes-v4-5-53fd0a65a4a2@oss.qualcomm.com>
References: <20250909-drm-limit-infoframes-v4-0-53fd0a65a4a2@oss.qualcomm.com>
In-Reply-To: <20250909-drm-limit-infoframes-v4-0-53fd0a65a4a2@oss.qualcomm.com>
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
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Liu Ying <victor.liu@nxp.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Daniel Stone <daniels@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Aq2mDEHmgp1SiIn37OLqW93okHrHKspB826EOGNpiU8=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8YBe+mkx4yTHKo7u9dMr8stfj3H6f7aW3MzQnfyHjz6Y
 d670FTJTkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMxI6J/X+ugGhLp7fzDxHn
 IluFvF35U3R8m2zjXqrUcp+8eGctR8zvKoEMv2huvaqa0C7Gmw8y9KayMcf+b54ZxjJ9U0rci6M
 HOQP7WjLUmt1lLnvpam+r5YpQLJ2Xc31u+95Tl7bdPdhbN5ujXq7RXfdt383Ud3UfbCZtXb/O+C
 b34cavM9/O9Z2vF+Dte+1uS2qCitekI3N5K9f3KzX1h4d9U5ALsLZjvPhW3X7rwx1CC3UX998Ov
 5zOOMFx5oavPjJGdaZuJ914O63uJvJ3lNx85rzc8VzqX9ljM6/n2OsfEI+5E7Xhyq7lFyXrIufZ
 Xc6y/mFx495BzWAPF8GyjP+euh73dzUVJq1vuf97SkUoAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: psdzLRvzqwY76Ny114pSmqwpzTFH898e
X-Proofpoint-GUID: psdzLRvzqwY76Ny114pSmqwpzTFH898e
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c03f2b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=vfAEGMZ_7ZOHtlG3iVcA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX8KeW2Hw1sgR/
 uZtXuG+3ES75Pgp8/wbWRpTthnnGug8cU9o0ILVY8zEXYPulXheJmKFm+HBjApC9m3b32wGDjD7
 Yk1B465HAXlJCfrSmlphE+3k8vS4p5DICr/a7isWblhnpuJ3Hs9wjFnI3R5VwCK8yRBvMz2CB8B
 kFvnOzfpOXAXpcCDZ9yTp0wPyZ/QVdGcXg6DX3OVAKijGi4DH/9CCLMwjNoXsTcg39P2MfxnDjv
 eoeELhNcYE6Ckw6AzNaLEPbe6VI4b1LC5FmauKtQ09h2Deq4hYzsv7CB/BEhXC6mjlwzZXwWpdi
 ozpNCmRBmg2nI0JfVmLCvxJUV3nf0OA9to60870TN9+Y4u5MokSIuxidRk8W1oufgDxPyvlDx1z
 BXbxfVKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface. Return -EOPNOTSUPP if the driver is asked to write or clear
the unsupported InfoFrame.

Reviewed-by: Daniel Stone <daniels@collabora.com>
Acked-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 39332c57f2c54296f39e27612544f4fbf923863f..9a195c479bcaf112f67b6a2f085402d0e33896de 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -936,6 +936,7 @@ static int dw_hdmi_qp_bridge_clear_infoframe(struct drm_bridge *bridge,
 		break;
 	default:
 		dev_dbg(hdmi->dev, "Unsupported infoframe type %x\n", type);
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -961,7 +962,7 @@ static int dw_hdmi_qp_bridge_write_infoframe(struct drm_bridge *bridge,
 
 	default:
 		dev_dbg(hdmi->dev, "Unsupported infoframe type %x\n", type);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 }
 
@@ -1084,6 +1085,10 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.vendor = "Synopsys";
 	hdmi->bridge.product = "DW HDMI QP TX";
+	hdmi->bridge.supported_infoframes =
+		DRM_CONNECTOR_INFOFRAME_AUDIO |
+		DRM_CONNECTOR_INFOFRAME_AVI |
+		DRM_CONNECTOR_INFOFRAME_DRM;
 
 	hdmi->bridge.ddc = dw_hdmi_qp_i2c_adapter(hdmi);
 	if (IS_ERR(hdmi->bridge.ddc))

-- 
2.47.3


