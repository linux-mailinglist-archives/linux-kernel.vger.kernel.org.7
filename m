Return-Path: <linux-kernel+bounces-885124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF86C320C5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C81899503
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BDE3321C6;
	Tue,  4 Nov 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6ge4vjn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="akuaomvk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBD330D3B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273599; cv=none; b=Yt7qBUYPf4vwLV1QPOOvcY7TSjAoUMpMRLBcjju7grKzMP+DXgz8azuiwgXcCxNz/GKevB9tPY9I2uArdOxrV0UXYYj6PzIlCRn89/zuF6YcJ1H5R+B0wwrVEClFxh1k3mL2Bn3bRnw+tfyLkKHuyoIVcJHFkyzNB6EQxtCYYCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273599; c=relaxed/simple;
	bh=PbPFma9x5d8sKN6XSZk59CRnA+Ci29PRE1+NnL5DPfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gYOEctp5zt1X6iowQD6RnEB7btztTSDVnmknPw+8MmczVWH/gFdz03OnC7r+nhsUF1H93lnmxmM2KdhU9oCzsoK2hSk7T5BgVSeiM0iay7UVbsbnYlLraNudFamhBGcdP8R/YgjjWFSeLYAKQMk2iiaf1OaC95DQiSLSH+TUm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R6ge4vjn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=akuaomvk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Cfmm02061831
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 16:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mFND1X/VRImRfWFC66Y712
	TFqLxcKNdin1F++KljD5M=; b=R6ge4vjnLEKAlkKDqm5c/ePW16kcLlfSo5RYs2
	Dp3AxIcx0+XBjLpnuxGmLnlxjF/ry12iIRrtuCPcy4SSnEZr1w9DQWRvGXBWNg6N
	f/+ofv3QE+JWdT0gOQyGDKhkT8wtVkWLHM55MXQOjAX/QEq9S9PiuWMAy3Eu5MGU
	yRcgI+QQqmwXOKi9kMsoKsV+fuIJuhFtfQ/OcB87D3+wMoxZtXAtalt3nIgXrhJk
	hi1ZNVnNZ7PtK5CHwsCl5ryyk0GFFIyOHG+P8B61xfr81uv0XCo+1x41SN84Qysd
	+IuLEtZ0vn70Xfj1P1hq7Kz4xuHvlCOzsyS/KUQtta1BhTwg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ex7s43y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:26:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso3238967a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762273595; x=1762878395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mFND1X/VRImRfWFC66Y712TFqLxcKNdin1F++KljD5M=;
        b=akuaomvkk9Q5LOaRuy6evgGtmpIj+DHdpzZNqv67vE/HDjiH8Mr0Il/pNr1lOiVpa6
         A2+j3X6DSpqoEbfuVf6TGhud3OHNLZ5hUplfi9Jnw0NphVnrEvxWiWwA4imyiEfhXUoN
         PBa9an4eZIitDnwEOwugbO7nNQmb7gfu6QfwwvOnzRYF4UQQk80bg30DhMwrw2S16/iA
         nEbkhGu2Dwb52gcW07Djij2E/0D3LVJ5icyf9RwC67NhmfyD9WMzCI0AfHnbLpBRWp2C
         E1Av4igm4zvSx3gAX2CR1uKzc4Dz7p7M97hA64DPGUEh20GMMny0eeyAzpkzcfBuejcL
         fJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273595; x=1762878395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFND1X/VRImRfWFC66Y712TFqLxcKNdin1F++KljD5M=;
        b=wG0Wg9bVFxGJWiVtKpOyDsv+a3nmUJZAenszBRM7XDb6yjn6+bnuZz0w9rxSIgeEcP
         ebyvfIwacrz89b9G5loVlDMLXbbBqVasEPkU7LS60Bu4Ciush5Exy1pMrniCrYV4walG
         QBzbJQ5tVxnJjXy3dzrwO4JSIjWziBVsr+pZO92+QdQqVLBYqgwpTt03tk5LkcyZqSK/
         v1mmif48lzmcU/AyOiCk3IJ/8TEX2P+E4mEDo8RiwUi53cYunJKGLBpGfmYf1MvUHr0F
         enku3wVvOR/X3qdF/IjxdnNEwkdcB22D93TQtW+vd/53/EP/ik9grl612YVtiOuao7pN
         Wvcg==
X-Forwarded-Encrypted: i=1; AJvYcCUrHzmybLoUKW3hfRQI3WpQIOT/+iy69B29ABNwUuXUVfpMfS/RhVO3O4Sh6k/1mk/2/z7NBPFvflWGb5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YySESbm0Q+/UVVP7DwVEZ/ch7Nni93ZbbXVF5IZRblH0hqo0QGA
	ppsrl9QF2oJ5ljUrizo7SXPEI/OxVX8khe+dU5mNJpW7zQCzTpTkB243zVIqEDsyJGJAYpU2QdD
	896bxVigsi7bXn5+iyFSPN2dewGmp5gL1lih2HEdMXtoOHoeGSgVhh3phLci91GnYBCcSdIoU+X
	DpFMrN
X-Gm-Gg: ASbGncsw5SZskj4TJj5EnIqy0nhqObWVaIzX5vZbD95yoqmU0K/GsFHN7eSnwLGr6yP
	Mrgymcpx9ItsKXXM0nKDAOO40Yxa1YvqiWve7E4zmP3aOxM6b4IOrGsv3Yj8/nZwTQNhCoxQ309
	zpWrvDBICB9K8qzIfw6OJM25k8U7e7aOkAAWYvOklaaFlc4zxKPA54VBdoUDve/cDjKsZZHQsjc
	VkdqyXOz07gZUHbFE9TeL8oQsGvvPooyP4+hvAKpmoQKRqIkeqmLQIIQeY4N5xxI1qtop0MouEm
	K744jZAxrcF177SuwKM6MbkxZVrPJ3KIzJuEAHYSwWgW9tO+IEo5tz484Ik4uzX/7BXaktB0Sdy
	wYkuj2nsSHT8vdP4kCoobTEeaA3Wg+OTWm3SzLa9qHSzA
X-Received: by 2002:a17:902:fc45:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2962ada4d6bmr2508525ad.18.1762273595425;
        Tue, 04 Nov 2025 08:26:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBUwXeVwkSk0IirZkEPPbrkJQYnb/rbwE7ff67TC2LgRxXyedOxM6ikgcQcHtDZv4YQt7Hug==
X-Received: by 2002:a17:902:fc45:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2962ada4d6bmr2508025ad.18.1762273594713;
        Tue, 04 Nov 2025 08:26:34 -0800 (PST)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7a8a9sm31508435ad.107.2025.11.04.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:26:34 -0800 (PST)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [PATCH ath-next v2 0/6] wifi: ath11k: Add single shot/periodic CFR capture support
Date: Tue,  4 Nov 2025 08:26:27 -0800
Message-Id: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEzNyBTYWx0ZWRfXycV+DQsPwJtD
 lHJJaNyJdpQzWRCFp0wtWQG/hqer0MAqGvnmdzH+qH2e6Gz6lm+MszaUpHGJY0/v/Ou683QadrJ
 yaQETTYZPIKiRO59YM6F+Bl8hcYwqXLneRQCkrHKOkNAu+82mce102LEviMXWnVHhzVz6PZuAOT
 yCpAyKaxDNTso8J7NMzACndjZafJDTZwniFOs9kWWl2MDSzq6f+H3DpgSsNZGxI4YEWNGAea38S
 TAsmw6Q2PX/9CfdwaTSrqf+3yMwy8uha+JFdx5EJRRxOIwKrsNRueh/SInBTbxg76Vc0W6unbTZ
 Bqj5xARXBpNZsiUBrYivuItdDSgnWGsY8Eaij9pxzac/m6QHtWVLVN6nFnjfs36Zv8+Txq3vb60
 jmcfKBnZ4FjwoigVS/hwrlgnOEk5aA==
X-Proofpoint-ORIG-GUID: rMuPfB_XHO3yx_A6duL5jB1NcnYAXem8
X-Proofpoint-GUID: rMuPfB_XHO3yx_A6duL5jB1NcnYAXem8
X-Authority-Analysis: v=2.4 cv=auy/yCZV c=1 sm=1 tr=0 ts=690a293c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=hBgn-SwW0Swv5iSSo8sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040137

To enable/disable cfr feature use command,

echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr

where, val: 0 to disable CFR and 1 to enable CFR.

To enable CFR capture for associated peers,

echo "<val> <bw> <periodicity> <method>"
 >
/sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture

val: 0 - stop CFR capture
     1 - start CFR capture
bw: CFR capture bandwidth
     0 - 20MHZ
     1 - 40MHZ
     2 - 80MHZ
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)
method: Method used by hardware to collect the CFR dump.
     0 - from the ACKs of QOS NULL packets.

To enable CFR capture for unassociated clients,

echo “<mac address> <val> <periodicity>”
 > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc

Mac address: mac address of the client.
Val: 0 - start CFR capture
     1 – stop CFR capture
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)

To collect the cfr dump,
cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin

Previous link:
https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/

Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>

---
Changes in v2:
 - Update related comments. 
---

Venkateswara Naralasetty (6):
  wifi: ath11k: Add initialization and deinitialization sequence for CFR
    module
  wifi: ath11k: Register debugfs for CFR configuration
  wifi: ath11k: Add support unassociated client CFR
  wifi: ath11k: Register relayfs entries for CFR dump
  wifi: ath11k: Register DBR event handler for CFR data
  wifi: ath11k: Register handler for CFR capture event

 drivers/net/wireless/ath/ath11k/Kconfig       |  11 +
 drivers/net/wireless/ath/ath11k/Makefile      |   1 +
 drivers/net/wireless/ath/ath11k/cfr.c         | 994 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h         | 301 ++++++
 drivers/net/wireless/ath/ath11k/core.c        |  41 +-
 drivers/net/wireless/ath/ath11k/core.h        |  19 +-
 drivers/net/wireless/ath/ath11k/dbring.c      |  50 +-
 drivers/net/wireless/ath/ath11k/dbring.h      |   8 +-
 drivers/net/wireless/ath/ath11k/debug.h       |   8 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 143 ++-
 drivers/net/wireless/ath/ath11k/hal.c         |   3 +-
 drivers/net/wireless/ath/ath11k/hw.h          |   5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  17 +-
 drivers/net/wireless/ath/ath11k/wmi.c         | 147 ++-
 drivers/net/wireless/ath/ath11k/wmi.h         |  97 +-
 15 files changed, 1819 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h


base-commit: 059ca8fd692b67a77fb89e9d4e8f57cf08e32b08
-- 
2.34.1


