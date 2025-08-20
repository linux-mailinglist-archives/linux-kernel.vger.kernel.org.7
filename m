Return-Path: <linux-kernel+bounces-777240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A209B2D733
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39A23A7A55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C252D9EDF;
	Wed, 20 Aug 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npN1oFyQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C6271470
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680070; cv=none; b=jhIQtkndZkLsLRfVahQiGdRJdyiipbL1egxY8uP36ZsIj7wKLJ2ultcQzrhyushmksjATPq2SCFjzINhW5LOd+FvU8sOMGIUw+73oZIS6aG/jLLfGJRjVAm8WN8/0TFwJ3dWtplIT0qDPrBA9HOJZyMQh2emoChuex2xfTNYfaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680070; c=relaxed/simple;
	bh=xbVBMpbJC84OL2H7l69MUgBetsy+dP2jsa2Y/+6cwCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WxGp4Op6Yb3SvKdVH23li35+PnjRUzDW+2/5Z4SMGcYYTqwhqyeRzSr0luCpdKttlCFhI/mV8VuOzm0GRLjT02kRtAkL9c8pDakHi/EQ825sc8RIT7u1kAeO9hZB9hr8nnkfjby4qege1xsA53g5U/RJvelHeRzgyOhYwkKVacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npN1oFyQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ojvH024584
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=11RILgASqebrtw2UrosgID
	+qYHkhszgpHlOkkTGkunQ=; b=npN1oFyQ+DdVNktnIkKKbNGGVcbQnhgbe7oYnD
	cf27wT4yQOKBqJ7ArC/LaDw1y5AC5SmCT7NtV0xMi8FRsjpW1W18/QogC72rr+CK
	gqe+pE76ceLaRU+D/d1keQ0dkazOePK/N7D2eWBZvY/5tXsemLEZHjSHH5kWgtcy
	Cplp2WpbtqJ+LxxjpaTQ4cmsuqQUMDyjE5/H/Q3Pu9W/key9BzpYATo+BmIQ8v8i
	+E4+AqXznUZs3jnQtJ55qD0L5OBuEIGZw+GVrIy0dhHceYcGTGdzyY197DYiXkng
	EExaQ/TePxRUhewVQK8DYAzjrFYdoK3EM/haj0RAhcr4OXZA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52912wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:54:27 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2eaecf8dso4867774b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755680067; x=1756284867;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11RILgASqebrtw2UrosgID+qYHkhszgpHlOkkTGkunQ=;
        b=Pp7WuhVUZbgTNMGXYTCoZIWP1AQ92aiRGzhHdYwrD6847U6lLVrT9pHNeqZUXmly9P
         aKClrdNyIKg8ar3MhoqoWwXaKHfwXmUz7yDU6kHNqZtst7tEOSDUed7d3DTFOtAH1me4
         GwFjtE/NTZMo9qSjgjWFWxvWy98i/8y4vVxzlE3kuUXhAIB8FDBN9uyN0UcNHDa+1oE6
         dMLuZqv1kBoMwEIZxhN6TSYRidU9prg7d5HWMxX5X7o48JaVpZ+EhZ2ydyiSGOxJ+nBv
         s97B8YoWEv+QMLom4ARMO32SvW56jLF2Qn94FdrdUKZyYea8FVziKvzPi/OqBoHltAn/
         zHcA==
X-Forwarded-Encrypted: i=1; AJvYcCVPHuyNi7SFob3yqzWx9fSoBuGhtzWYSrTkId04V63NJBRaiiSzqFRNua+XYfMNE6SYABHcuzaPw/GqBlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfJGyZNbLrYQQAunX54BUVD6mtwegAjk8hTqchBnfQtYfnISo
	NfoIJWS1ahqewyDYwLgRLWwTzSmYYs/1C9/DWUY8mu/x7+LOULJfyl1Md5DQj/DSIKzItBLDGft
	x26AFXzvDj3QKHi1ZScoCQYhg4w9tjYRSWijraZlrJjIZVeG6WmXdvNItJ1u46nZTBqs=
X-Gm-Gg: ASbGncs2Oww+BLyYZpi905CxRMozcMYY3ZX9JeLI1xT8834zYkebg/cGeM2Ww+lC0c4
	QQyx1AIDiP6uKdHAFypYIxnOc1x5sBO579rJDRB1K3k0zpQdJFulobaY6XWCORet+IGXwmiM89H
	8qY9w5Y1edSJMk9ZgWQz2yUr0drl78FSDtmxErgFWCLpYz9Iw+HZM1IPLYBo5oYj7aNZ+J7OZ63
	4QghVGQkSH+tLYfe3ovvDMyBH3SYJlEQFmBrf1JpLjv+kCMNRWNIEgXI2Dok/tNgGwClVBJF/Yi
	WAkkwGtpbedKmTioqakO3Rmyi3Ek0qM9veWYpZa0cwqitGQ9GHyXU/hTPIKbhvDBmjiMx4bMtmH
	cQnmVdbCcJenYaSnUDguLh54TrRxVuLL5tUshBYhPrlNk8NmBweDj+6NP
X-Received: by 2002:a05:6a20:9389:b0:243:755:58b5 with SMTP id adf61e73a8af0-2431ba73584mr3553133637.54.1755680067089;
        Wed, 20 Aug 2025 01:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqdr4ixEHQumfORfUTOCWmF6r5RptPIsSTTUcwk/Feiql/w4YOg/rHr802Ne8ttx0t2841MA==
X-Received: by 2002:a05:6a20:9389:b0:243:755:58b5 with SMTP id adf61e73a8af0-2431ba73584mr3553105637.54.1755680066647;
        Wed, 20 Aug 2025 01:54:26 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e25532b1sm1658263a91.13.2025.08.20.01.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:54:26 -0700 (PDT)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:53:30 +0800
Subject: [PATCH v2] arm64: defconfig: Modularize SX150X GPIO expander
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-modularize-sx150x-gpio-expander-v2-1-e6eba22f0a0f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAqNpWgC/4WNQQ6CMBBFr2K6dsh0YgVdeQ/DorQDNAGKrRCUc
 Hcrce/mJ+8v3ltF5OA4iuthFYFnF50fEtDxIEyrh4bB2cSCkBQWhNB7O3U6uDdDXKTCBZrReeB
 l1IPlAHii3JwrUyl1EckyBq7dshfuZeLWxacPrz04y+/7c8vir3uWgGBII+WEWLO9+Rizx6Q74
 /s+SyPKbds+EKDnStUAAAA=
X-Change-ID: 20250820-modularize-sx150x-gpio-expander-0427c6bcb559
To: Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        xiangxu.yin@oss.qualcomm.com, kernel@oss.qualcomm.com,
        Fange Zhang <fange.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755680063; l=1437;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=xbVBMpbJC84OL2H7l69MUgBetsy+dP2jsa2Y/+6cwCc=;
 b=jn3BkxMQtWkJzSfSvhNQIDRyXaz1dXEFNHqSp4o9g2oveGTDNGTAnsvbh8pOWyaT6tGCLk426
 jcL55gsOAZbAN3mRbybNMHW3XWHP6P8fS9JdMi5Ygx+Hee+gGkDGmYo
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a58d44 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wWMmKHWDNrKRBeep4CkA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: xls7xeumnD_N7srxjDmcu973e3K0Vpqz
X-Proofpoint-GUID: xls7xeumnD_N7srxjDmcu973e3K0Vpqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7Whfn/7+P0DU
 M58Ubo1y+HJW02csgPeRXJa14kNuBZ7p5HfR0NUwETYRnbMYFnInuOzs3mBCjH2MCgaI/vqssdp
 I27g7UXQJyVv3SCFcfN1HUfjVD8a6Po74FlZ3BzS2qVaxp7K5cA8lVrJsdo6yTZR8OESNScb2pG
 eU0p6sKd60QOQmQNZue8xIjsYrT7Mb1NzPlUR6J7QDfHoYHmCutd9T50qg3nJ9iaxf3Ft7QxCuS
 HJ9IT3/vh4S+ggB486M5IwzF/AqHcaz7k+XI2IKg2xArrWjpTq0Hh1y9Wj6pQXW4wGZD+250EL2
 0ZTZcwrbHB7q3Bq4YTERj6rHC2tUDFwZXvbQdluaGqgDJeeyyhKIExyMKK9kyj6XbpufrEW6dXH
 fGNyAhvyybm8r5/lIVY9Hz8IMhQsJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Modularize the SX150X GPIO expander which is equipped on the Qualcomm
QCS615 Ride board to allow the ANX7625 external bridge to function
correctly.

Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
The ANX7625 relies on SX150X-controlled GPIOs for reset and HPD for
the Qualcomm QCS615 Ride board

Please note that this driver has recently been updated from bool to tristate:
https://lore.kernel.org/all/20250818-modularize-sx150x-gpio-expander-v1-1-c2a027200fed@oss.qualcomm.com/
---
Changes in v2:
- Drop patch 1/2, which have already been merged upstream
- Link to v1: https://lore.kernel.org/r/20250818-modularize-sx150x-gpio-expander-v1-0-c2a027200fed@oss.qualcomm.com
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 667c4859ecc3cda9b0a3dae7abdd8587fc4f8dbe..dce4450fa9fa58fab0556a6e84b899a3306b4db3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -598,6 +598,7 @@ CONFIG_PINCTRL_DA9062=m
 CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_RK805=m
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_PINCTRL_SX150X=m
 CONFIG_PINCTRL_OWL=y
 CONFIG_PINCTRL_S700=y
 CONFIG_PINCTRL_S900=y

---
base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
change-id: 20250820-modularize-sx150x-gpio-expander-0427c6bcb559

Best regards,
-- 
Fange Zhang <fange.zhang@oss.qualcomm.com>


