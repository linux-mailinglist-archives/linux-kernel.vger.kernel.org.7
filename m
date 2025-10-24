Return-Path: <linux-kernel+bounces-869372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834D8C07BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B8442528B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C37348445;
	Fri, 24 Oct 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LtpT4FvL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79533B964
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329933; cv=none; b=lAW2iesHPDJxMLFlfBsQNWn3wjJMz3hPVmB3TD221C02bSoizk6pkL676PQQtIgmSFqoTG24kECtW/cJpJK1zW0lD+ZLxNvNctTzu5HxqUM3hhjLx4Qg8RcF3aquH82t5cJda2WIYmyr68bcpW6RKdCUzrHc3oQaw2UphxqkViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329933; c=relaxed/simple;
	bh=ZKqHGBqht9+vOXZWnMdIb2qlDFvjo4TXm7DhSQz12Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RE65BiMHJH/T/gjn85tmWyvVexSGWZaBtR3jlCxLinwjmz5xc+b3Me7jFt/yD/FUA73Nlbzw4IzGFvOpQftj9dYHXSlRtFYVOTN7jd2KQM3mlNEsJDpaoY+8spRtSF3opTKgW4XP9poZulQy6G9CB/a1cvvivl4JiexsSF2o6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LtpT4FvL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9ElV009576
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IRFK4cOMW+kcSMn9HpIyzq2Gx8pGlfR7x7M
	K7vaKSWQ=; b=LtpT4FvLFAmf31hW2+YqjrTD5FJJz3KJew1yFqu5jECLxgut0eJ
	IXUUAtjwGSlNZe1YMFVOBBajGrEVHZpUCFC8SzNB0xb3gatRi7pFoLhz9G28tWlU
	Yy0Cmm+6NW/RszrNcZu0sAYmhNN5IBFEZI96hgXo7LrVMn+wDqx77pnibatvxeLu
	EO5s0zd+F8EqBJTRlATxL6r7y2Y//OM1QDB85N2cJjnAryppbozbCzUm5fQlv/Zk
	zb1rIeV0fE6GtqM3dKGJDL9hzps1QV1OjLCtZ77faAvNCqJnp4r9I4D3uillcaok
	1gJInBKu5H7OwfJzpd79lC1iGBbhJf4SHPw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jct7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:18:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290ab8f5af6so15772765ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329929; x=1761934729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRFK4cOMW+kcSMn9HpIyzq2Gx8pGlfR7x7MK7vaKSWQ=;
        b=AXj8Ab+mDuigiJREIbARA3Cx0w1NHy9EvaHMZhWZw9pr1/eZwIDG555XUFuUffYO/x
         V98Sph8WlS58hZMXtD1y7qtN5sjH4I/vwu/sEMU41WV9P6onn7OGnDZxtl2FvQSfmVAE
         k6kAZAb6eUisbEVKBJI2P1w9DJ3yA0rZ/22czMyQ4+bLon7XwVk1EEHydDHUhFCKtmp3
         +B/D5LwrPBbjkpWNyf7/KlqS6ZWpybB7QD0triHk5EdJKLSvw9H3sZ7hc/zos+GVN7SM
         jSFzTGWJvgF7iRhVSm+uPZ79HsGGtOYjXgUgdGYt6MmcmXAIWU28+AoKMPahDgbtg1/l
         oYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZhsmitr2fOdn3J9+b8bWjKLOD4eLvDToyBLr1qvg+RzNjY0gf5rmFlpX9d94MUizylsATyE/oqFazjC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdos05Al9BT6zAH0JFeJFUhl5WONqrKp1cj/wla64Rdn+Kv9PG
	TGgmHcvCIQRAXPu45yW97eqoM567h0PkTx8e9MnacsrO9XpcbeEuglgIQo/u4VivoEO2NvP5i49
	9EKqekXWiQ2k1ho8ZQybzVg2E3nMvK9Tqkgo8OTppsKHBoFRKMY1JMShqPAEYatyle+s=
X-Gm-Gg: ASbGncu3pu3Qcg6teqeQYqdxLOpI5upTsGD/d9JSe+60/NTtffTm3fiuq0yWufjZc4M
	dYtmyjzKyz5Xv7wc69rsVPgC55F91ELnkYs5UpHtRGFBTTpBXVaxA0HKu/txetgo6DxllFVHDzW
	B4HW6p/rS8/S16g31l02fNrofTwJKoDIiw88PiiDU9yCaw9BnlhQLQKHBbltny5bylDGt2MyYrP
	rCuo1XfyGn9HWr7RhtZm77Xu2zccd1GTitbhkrTaDJFLB5iTUiiBGXW3yTIzOXE0sOLgv6qLDFL
	V7K8fU/goO/BdKkuwwPZ1DRV5GzAsgkHpbqbj4hiwF7sqyPepU+rU8FUUHCPA76EeWwtbcUcevt
	tOpFo/qkeiioEfrD2HEIJHwWzGrmra+yM82Xn
X-Received: by 2002:a17:902:ccce:b0:291:2b6f:cf64 with SMTP id d9443c01a7336-2948ba5b7a7mr38569395ad.55.1761329929517;
        Fri, 24 Oct 2025 11:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxmSFrHaASCsFr+5s4+V4woE9zhvtI9rXOx7daC/mzgx4vqNPPBLgn3gf82z4cvVigpg+Twg==
X-Received: by 2002:a17:902:ccce:b0:291:2b6f:cf64 with SMTP id d9443c01a7336-2948ba5b7a7mr38569005ad.55.1761329929031;
        Fri, 24 Oct 2025 11:18:49 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfd0405sm62398045ad.66.2025.10.24.11.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:18:48 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Implement vbus support for HD3SS3220 port controller
Date: Fri, 24 Oct 2025 23:48:30 +0530
Message-Id: <20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX76vpcpYfiMm/
 17PYq0E66ZNC/N9kwq89E1IEH5VkGgUn3eVrd+VGrCgq+HaDx+B4245zi3tJTgTm5k1PgTPNOqA
 wMq2RZj3WatJxPy4CJytzjyrHaxvwIiKLXtzmtH84xJbmYcG1zYGOxGF/l3rZxno4yMZY5xSIFe
 /dtxzCzr8wZwJO5D59k6MPEetCK1RIbPNkD2AOt0Snvbbze5WzpENh0ujcOOJ6NbR7Z9qvNf0Im
 Hi/pAizF5UuCvs6YAE854aViI6aFhi6gmeFFnDW6q1A/pvSnaIZk1Sy1H1MqfJzGl9M0JGexAW3
 M9DYhHB/wRSC3/iWr9JY5GKlVinJBR0FjCka2wD0l/iGlAGj2vpT5dhleJPuK/6v5LtAmAvc9BQ
 p+kLoK5gRyJL1fKcBHJh7fiZK2IhnA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fbc30a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=gs8g10pPhjI8XjwtQ3cA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Yu65Dc-Kd_qotNx3LpkookMSr0TByi8_
X-Proofpoint-ORIG-GUID: Yu65Dc-Kd_qotNx3LpkookMSr0TByi8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

As per the data sheet of HD3SS3220:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
low. This is done to enforce Type-C requirement that VBUS must be at
VSafe0V before re-enabling VBUS"

This series implements support to read ID pin state and accordingly enable
VBUS.

Changes in v3:
Removed vbus supply from hd3ss3220 bindings.
Implemented getting vbus from connector node.

Link to v2:
https://lore.kernel.org/all/20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com/

Changes in v2:
Fixed inclusion of header files appropriately.
Modified commit text for driver patch.

Link to v1:
https://lore.kernel.org/all/20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com/

Krishna Kurapati (2):
  dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
  usb: typec: hd3ss3220: Enable VBUS based on ID pin state

 .../devicetree/bindings/usb/ti,hd3ss3220.yaml |   8 ++
 drivers/usb/typec/hd3ss3220.c                 | 101 ++++++++++++++++++
 2 files changed, 109 insertions(+)

-- 
2.34.1


