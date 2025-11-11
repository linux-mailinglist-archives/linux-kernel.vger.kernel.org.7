Return-Path: <linux-kernel+bounces-894792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4065CC4C1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40E774F1297
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4252E9EAE;
	Tue, 11 Nov 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQEIGOcl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MaCMfFJ0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50F31BC80
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845643; cv=none; b=lIkAS0PTlJDOoGCdM5xkSi6QgY5l52/Gv9ob8Oxsz5SGzMN6bvnnBoElhXVxGIbEAEjkHcK2cVTaLuOYH56L6r6QbIGa3sFkKE1LkLG6KblylNERbjj5qkaZxw0qXeJl4/Y1rE169rKVklfbveXl/brBiVdLWuUzENyBBRBXPHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845643; c=relaxed/simple;
	bh=ojYpKrwiJr/IeRiFqYr/O9ysiIeANv2FZpkain5kT/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HDuvsqhhczfouzm9MAAzb7GArYjmAwnlxPg675tiNBx8W9/lVTFIkBV4dxwxuD21VZg6YFt+R1wuJ07X2Em4JM2w8OfBuSwthBT4JPUBM1UbpJHpLffUMhM5XsKCaGclJYj9f4d2Ci3Bbt5Q6NbEa4+NATSyLnX53CGSGeFffQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BQEIGOcl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MaCMfFJ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB587KH1229730
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=az1eS4yWnkGWVG3hRFxIBdC+UkohID5Sb1d
	RYK81rRY=; b=BQEIGOclxHxPwATXmgPgowWLUs0GrxLA4BiCGkTADCcIUhI22u9
	rmTBiyPEKHNi+CnBlX7e6U2ziWXEBem7cc0j1YQqVtxofhnmhaLcc2G+FeIXccW6
	aD3W407GQN49mE/svmsWcbwD1UFF2855GeaF4/W/JNEmyUlSQAyWIaJOTY3vD4UM
	x08RHnWv/LELx6HZBYPkPBzGJyTo9LKpppaTgwWoxmj9ZtaKwsZWVAKwbkN8bIRm
	mPHsHSFw7XjUtiBZAOP22WHw7UK4PIvOhwglaHjzOg42g7lSDP7i4E/UMGELcNmM
	WSgqajV+ZEcsKNOxlr0cISfUUPVMOVCpjbw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxqw0ba5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:20:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso9417501a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762845634; x=1763450434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=az1eS4yWnkGWVG3hRFxIBdC+UkohID5Sb1dRYK81rRY=;
        b=MaCMfFJ0JSwncX3yKOxM7Gk3UCsy861Qr8Y6ASzts50KNZXaw3+ErSdBm8VkBtTbNU
         rL2K8MyhE0xNlaLYJUQUY3XBfhytVZCsdzQlMSTAaccpXTl+DPhoMOZddWdSTEMToGAH
         GkxVGuksX972ZZagI7PIz7nDzKSefTWa/1EI0lhzB5wm5JrjDK9CjDp9OC1Q33YEX4NF
         chU0He/JhUYdRq2B97975uotCAHNK8KFOWCIVPG+XvxuSU987DKv5a3MEpcnkTrH6ypz
         78BnuMh0KQ6PAhFEjY0UV5sgFLLyB5tHt8I4W24U7STE8tmO5pa20uUg3H4TC+edrCqy
         zLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762845634; x=1763450434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az1eS4yWnkGWVG3hRFxIBdC+UkohID5Sb1dRYK81rRY=;
        b=nmNXkjBzbMjTpVdsHVWke/1hbICfiyL6KIU2pnZvKbOTY6kVX3BL2ticJOmFp6r0EW
         nZJ3ElAdsVtM8GoGEeoEBJexBZOXr6ZN74NoL2tDk+/26AGGpyRT6zO4o31G32fdOT4X
         tmDJl3IOu83vFhk8GGDwg4+FeQmmN3mKwuKMFb5hs0GScIiJfZBG8N57VTGBEVGhZL8w
         F1CUHPbNLSjfHeLkysSwotGR2/oR4bpQRiW4QRwGHvJSDAmJRn5VgvomZRK3uJ6UDpI2
         OYKQBRnAm6Xk431D7XaLwig7ar8yGGlfk6x2d+ZpqyojSK7pIYF44HSrD3x1kx9R6Z5l
         UXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhdqL8Ln4KzSnvg/+b3pxWp9KwLfr1hkS9AIYGJWMyJkZRxk3GEMQeBF3ada4t0lyCEj5V1w5dbQwLkfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYoKslO9fgq+gEDsL+270IHxxT1/unMhG7IwnEtcq743WgHqR
	e8fl+ANPpD7aOyCrICCwshjvyL7aHyFhEZ4uhNG35tXo3gQWtsQMdGfRKSHscXjcblshW7dK+EZ
	7m2cCiuIJtIrozaT1iX714e9Ey9CyVCXqAuuLHlU02L8czfC2atTJu12kSY0RnUQKcKQ=
X-Gm-Gg: ASbGnctblIaS03Z9kCjjjdT1jGv17/HSaBNNqYuUpd6iDnDnnTIAtKtzdoiROgc6ODy
	7zqkMao+ZraDe5NmUrIh3cdYNY3xM5LEjBYcI/yXgRhljJhPmHDhqNOvHwKuKTPVFuaZMCR7l6m
	DRaYzJ8rq04NWJEsaidnCaCdw7oSnz5aapsD+ufnGCG6rwc6FQNE/tOyFxadBIGEHzWKUZrgfg9
	yRYyNAzKyCrAlNEtw3HzvyLCC3+qNjNAXvDCppob8wqlLB7DVT3dFc9s7mIbES6+VmWZJWBHkFf
	2KC2zV06aRynVEHfH8HYZX+2rsjhUKWrqQAnyOYGt0sMBqiyzMGrDyUl0gkKY/i5QoMaa7wtFGa
	o5353SN1G6fWlu3a9+AT9CQ7uWyE+6crV3nJA
X-Received: by 2002:a17:90b:2d0d:b0:341:d326:7354 with SMTP id 98e67ed59e1d1-3436cbda0e8mr14043471a91.37.1762845633938;
        Mon, 10 Nov 2025 23:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZON5M2sRDvjzPFjogKxNKUyz1kK/A/BZI9Od77i2TSBjqWmz2DCeVNpTB4N0QmcaQECKzkw==
X-Received: by 2002:a17:90b:2d0d:b0:341:d326:7354 with SMTP id 98e67ed59e1d1-3436cbda0e8mr14043441a91.37.1762845633481;
        Mon, 10 Nov 2025 23:20:33 -0800 (PST)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68c822dsm20035604a91.8.2025.11.10.23.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:20:33 -0800 (PST)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v7 0/2] Implement vbus support for HD3SS3220 port controller
Date: Tue, 11 Nov 2025 12:50:23 +0530
Message-Id: <20251111072025.2199142-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA1NiBTYWx0ZWRfX1EcCwPPnVa5y
 ZPoxw3MxLX52KA0qe+A5JAJizawY8w6lXSJWxxYDjs0LNso3LK4+mI0HEhNrPywwfF82G9cX3nf
 n4zEp1CNsflSKx5+QCS1FIsCL+LAlY6iinFvO3oRmVvF/Z/RLq0ydDVLSlMRld2lptqXr6jbTrP
 6h7GOWsicBIvdffICpzWV9/u+RCj7WyDqOZrA7FLUjxROQhiJ4oxoqaCB26kojEvV+BsbL08wZh
 4yBr4zg+QlIH4RZvsMiWPZFuP2u4gA/NpAeAbmf7TJcdH/Ugp4SnIrpgHXV6uCwtQBQ4AMwuFLG
 pz1asMlGxWD4zLygNliLXFiIlh2jPNfZoxE3Sk33tObvObRPaYpyPj+n78sI5IuIRTEm3FyWtSo
 MS29gTMEFxKle6ko8uGHtgSjf+X1ZQ==
X-Proofpoint-GUID: ftzdU7tWt0SO59_NxmAEII1GkywUntC6
X-Proofpoint-ORIG-GUID: ftzdU7tWt0SO59_NxmAEII1GkywUntC6
X-Authority-Analysis: v=2.4 cv=CeIFJbrl c=1 sm=1 tr=0 ts=6912e3c2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Nk2SLWWF8xhsZ517u1EA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110056

As per the data sheet of HD3SS3220:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
low. This is done to enforce Type-C requirement that VBUS must be at
VSafe0V before re-enabling VBUS"

This series implements support to read ID pin state and accordingly enable
VBUS.

---
Changes in v7:
- Removed check for id pin validity in ID isr routine.
- Made changes to request ID Pin only if vbus is present.
- Checking for return value of regulator disable as well.
- Reordered variables in beginning of probe to be in reverse xmas order

Link to v6:
https://lore.kernel.org/all/20251102164819.2798754-1-krishna.kurapati@oss.qualcomm.com/

Changes in v6:
- Modified logic to get vbus from connector as per comments received on v5.

Link to v5:
https://lore.kernel.org/all/20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com/

Changes in v5:
- Modified error handling in driver as per comments received on v4.

Link to v4:
https://lore.kernel.org/all/20251025122854.1163275-1-krishna.kurapati@oss.qualcomm.com/

Changes in v4:
- Modified logic to check for vbus supply. Directly checking first remote
  endpoint.
- Used of_regulator_get_optional instead of of_regulator_get

Link to v3:
https://lore.kernel.org/all/20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com/

Changes in v3:
- Removed vbus supply from hd3ss3220 bindings.
- Implemented getting vbus from connector node.

Link to v2:
https://lore.kernel.org/all/20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com/

Changes in v2:
- Fixed inclusion of header files appropriately.
- Modified commit text for driver patch.

Link to v1:
https://lore.kernel.org/all/20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com/

Krishna Kurapati (2):
  dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
  usb: typec: hd3ss3220: Enable VBUS based on ID pin state

 .../devicetree/bindings/usb/ti,hd3ss3220.yaml |  8 ++
 drivers/usb/typec/hd3ss3220.c                 | 75 ++++++++++++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)

-- 
2.34.1


