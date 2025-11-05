Return-Path: <linux-kernel+bounces-887029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF12FC37246
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004D3566E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C191329388;
	Wed,  5 Nov 2025 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivMvtIxW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kk8bYQMg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C8315764
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363351; cv=none; b=qmYA+P+0Ftbxz75ZIbiEzlUAAsskEXZddUdSofb1fGRzXbuteKFtalhx13a8A9ORL48lVvbqEOPt/wll7fRhPOz3eK2iFGtWNuYAh+NxVBUyjAuLlqwKD3QOER54Z8MVl/L+bQ6Yf4TKP03NcNgUceTihh1Du3on685/Uq7KVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363351; c=relaxed/simple;
	bh=gTzO9ZLz/gkWRMxADXfShEqG8Uk4ovzbXbxRfh2LddY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ds+cqP1zVhH730Yjv5IqfXT6gLKL1sqXtIxhC7lRfsEgonpCSD6ja5Xy0t9S6QDdqp2kQ4IGr2dA7DImquK8/WXDoGXh0Y55QY5SV5ix+9wFcsoPF17DbXqESPtqJqaC37+teEfExho15S8mwBL4/aGmjcs9S2gWotO1WwDNVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ivMvtIxW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kk8bYQMg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5Eo6KK995722
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 17:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U+YUYIU9pHv3xXIvUkPp9A
	DNA4qZc7XK8z6vznVXTVs=; b=ivMvtIxWESCNmyu/GgAvo+qFhK8pZqvjYvrtdW
	KrdvKIBoFeSy2hEs+JxyxzBr5LVIPA8oT3Ec/LZ7G/co7yQFti07gc11vvqbgG0S
	8rcDLsG6FuI7DgeD2wWFv85FlcfEo3j3tQNy/cZnuCOCXJVUBU8TpVd7y4kl7fR6
	s0myNNww2eXyC5rYO8HovjgIjPWK6oQ+Hsn4V1QthzwXsfYqJ4E0SwYYPPBJaBcM
	N1d29lOKmtk2ZHrbBcU4wXA6VYaFpsFpgrT1FlTAwlz7OsSEa34BpHF6PaM4HT3G
	9yYL8MiQ5DgCM0vbn9LPrH+wFknzpUDaB8vpJW+iNCZh4FrQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a88pj8guk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:22:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so16754a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762363348; x=1762968148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+YUYIU9pHv3xXIvUkPp9ADNA4qZc7XK8z6vznVXTVs=;
        b=kk8bYQMg1zsFHNJyZOvOY9buXj35GjhrJ55lLl0A94nn/l9pj73m18GzIEcjre/dPI
         R6vKGu+j2EU1wirhpiE7lfVgoHIDTko/7A4QrQxjVl+n/eLshbXRiC4O9hKiYqtGGHFS
         kBztg19ScHimjR/SeRs01UgGrRl8wDsP7WpRXJ7KZTxWIKfHHYwr72TPBuZxngI+CATv
         S5G3yE+/A9Agoni02j47sw9vKfryrMQ7jsWYKTOGEbhnKLbkxPD9zg2H8jejxsM3WbLZ
         xsBV0ilV4fn+mcMAvI2JE4U7AEvnLXo2Pc1hGs+wd69HrHeEPlmVP091ZmR1KCemP86H
         LIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363348; x=1762968148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+YUYIU9pHv3xXIvUkPp9ADNA4qZc7XK8z6vznVXTVs=;
        b=R6cB70FqOGDJOm9E0m8GnC5faZ7ZkHyil2/eN4D93c9x6V7quq8pM5r5vKbAH3gNCm
         NUWhrjzJ7AOpRcn/6vesBhcKQlNYxAnpK9auioeTrp3QxThkrGZnAPwJCw8krU657/FC
         Ey7lDYuoxCYlLdVSdYURo0UiJX0ioNWx/4b2/6OCqh9wJaW01JMFCgT46j2jET2av68w
         PueoeKbX631ZTkGRejUmOTDVidtVIqgQjzdcTNxDrU1qPYV9Qd9SDPyi01S3eIi8KuKi
         mC3RB5cAOJwc+VZemjon5VEz9IDKjxO1C711WOOV42Jhd5Cya3hD45cbIJ3lzi17ceOm
         alKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMVRlDBe4I6ku6nA1LetwU+QUO/9UndLb9x9afnV0m7/N8eMWuP+CsXbZFZWzWemLcMCDQ8kph2pThhsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwY0YyJCvfgnyyknJW6B8h6Kn8S5vmrA3eRIt3mQded1a3jly
	TuDWY0gmt+lKiMi2KaW4T9UluMEwLNoFmJgh4Tk9pWj7UZHoACfBhnpxuWmyvDkwztD/anopXWo
	//LaKkcgHC0WqoJ5mbvQT2K8e04XjQbYoSRFks3Q4NzpfYnSbMR3P6ex+iWcP32k+Q50=
X-Gm-Gg: ASbGncu+rlR1HEdwi6YxRQN0tmB/IrNXdK47qavLj2v/an2z3X1fHY2k0ZunB0qeaQl
	RyA3t7h8137z5GDt1Pjbquk63GiVaZt5fi4CH/4MNGPOei6RaDPKJYRWQxloShrRJ4KhfL8k2Og
	DAMUX4zmV5d2Lcd5rYKXsacPvMUzvZ8Rmfj+ndw7LRYMAn7izcCJsPbsaQhf9DnuuyOUM1lhsfN
	W/gg+hGE28SGbHVea2smsr6qBY4ehFlNODWZ3R+77mqP/ahJQNJp9BCknqdNEVVe0AVw12qI96f
	q/p9zD6Mn5EWoszjk8YsU3AL3H+8+EaWuuacvZWErKyDaXJ3bO+HCr653BCzhcWIi/MvG+bu6y5
	VoE5IxZ1PqsFVcqJCAAiGMT+AzKRU2s+cubkBso1SZHSz
X-Received: by 2002:a05:6a20:7484:b0:33e:eb7a:4473 with SMTP id adf61e73a8af0-34f846fdc8bmr5054423637.23.1762363348397;
        Wed, 05 Nov 2025 09:22:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZwVfSw3eIQPRT1N/Rx23JfWFgBnMquNlKK4SWJ6as0e82cODYlNwm+u4AWn0nKCkC7l45OQ==
X-Received: by 2002:a05:6a20:7484:b0:33e:eb7a:4473 with SMTP id adf61e73a8af0-34f846fdc8bmr5054375637.23.1762363347827;
        Wed, 05 Nov 2025 09:22:27 -0800 (PST)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af48d83c20sm518014b3a.62.2025.11.05.09.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:22:27 -0800 (PST)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [PATCH ath-next v3 0/6] wifi: ath11k: Add single shot/periodic CFR capture support
Date: Wed,  5 Nov 2025 09:22:20 -0800
Message-Id: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IJgeU2K4sCOtECVkza4Dy6GHrfe9wbv0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNSBTYWx0ZWRfXzAGhTTj1MGb1
 m0bEKfz+oVrFm2Bzwmp+ausraGZja55Xy2u5G2KzhfWYIf6wUxPOiTllOtZUavWDKuMiM58sTxn
 j3XEUueqKn34qdZrZDniZ3JfDMpN+b8qnDEikxrypD9ih7dbwnFkglSvHjfTp53XLywGd749xHh
 zofaPnOIoA+2nvZtdGN7qWxmQnSMRbNzYrJVZDjlZT1En++7wXwgQ4zHbLmNC+CKAaoR3OGhwFe
 gqQQZy9Q0sKFdr5Csa3MAsgvL5TOiw4Q2tOeU44RNEe9bgYXqYn77It1sGx1cspf8BMiDFs/h1o
 xFbTeSaAj/RnXDz0GutVP89zaeds2ReZb5WRw9IoFyQZX8XgOulDAfzmJ6+CteiPn3fyJxz2RPN
 qUJWoMS/vZ9k3ginP4eLgFg8pyKQaA==
X-Proofpoint-ORIG-GUID: IJgeU2K4sCOtECVkza4Dy6GHrfe9wbv0
X-Authority-Analysis: v=2.4 cv=ZODaWH7b c=1 sm=1 tr=0 ts=690b87d5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DEz-XpLMnQOtgUD9lTEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050135

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
Changes in v3:
 - Update related comments. 
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

 drivers/net/wireless/ath/ath11k/Kconfig       |   11 +
 drivers/net/wireless/ath/ath11k/Makefile      |    1 +
 drivers/net/wireless/ath/ath11k/cfr.c         | 1007 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h         |  302 +++++
 drivers/net/wireless/ath/ath11k/core.c        |   41 +-
 drivers/net/wireless/ath/ath11k/core.h        |   19 +-
 drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
 drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
 drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  143 ++-
 drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
 drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   17 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
 drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
 15 files changed, 1833 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h


base-commit: 059ca8fd692b67a77fb89e9d4e8f57cf08e32b08
-- 
2.34.1


