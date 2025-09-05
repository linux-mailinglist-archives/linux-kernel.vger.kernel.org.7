Return-Path: <linux-kernel+bounces-803444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E65AB45FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95881C2106F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26FD30217E;
	Fri,  5 Sep 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KIrZfW97"
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6F0258CFF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092816; cv=none; b=shhtcbQ8Mpp6ys95Nb4wxnHmPncVoE2l18qbXMU5m5iYuPs+Z88027O2p0ExmCEhfqJuPZhQkm1w7S8HLQJ002GsPpPpDTYzrmMgXhTA8UykApCdHcrBXCejyFaiQG4QDd5L6meleULD8N/N819U6UoNIqY1P225xAIbrvBgLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092816; c=relaxed/simple;
	bh=0AT7APgm8B0/OQcxue2jUmcVmW2/EJobNbH376ZH6JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlQDA2lh6SEoA2XAfM98viIn/ns6boPDaprLSIV4zstt7JkjrueMd3AmtabCxdMqBkgsxUIZ+V6249srYZdMtLXRT+SR103KegsgmPQsdZ5g3ITMM0jFaWjhm90Jyz/eiPGx7bruVh3Ds/xuh678jboNYail9AhkNft1gLBtM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KIrZfW97; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3f663c571e2so21170095ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092814; x=1757697614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLFW2g+f2TuwLyM0X1O85UbfIsEt5ZueedBLU5KTuv0=;
        b=Ia87TLNKEmABp50/lQMSMbNU5UNOHizzhHqoM+PmxAabeZHSIQkK+PV7vWUoTKuU06
         kwBwhl4C3cn7IVCiDQuTE7w/lPa57WSeEsk0sY2bi6kwYKuDdlzq1SdVBElwAMeKP0Fu
         6T7nK4j1TCbLrbVAwhy2uqdN5BXf4vBTyzXrYrlsQymFDD4OTIRNwpyDuI4AfJx32ExM
         NdY8zuinuxsOmtiWMof/PVgplaw5yrGYJF15IVA4zqds981O4X2jGUTnrrvXveyp+WJH
         1T1ui470DYJJnDumTvFLVXJUVGVL0RNaKDYtg7oXveayfeO1JYTJwst79NSuD+5AvKTg
         CjRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1WgssK81w76DnwOHJ4TyStiC0g632BgPn/w/T7SasDRQ3Pv7oa9hok2OMQfTi4DdObwrJTVfMsjRAbA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbULY+/zj70MvVBNrYiRBjqFsU+TwOoeZCxL3ItZIsQXXKl26
	SaF5ib2krgiJS1r33nXfq4/HFG3uOgekOSvQjayT2es29ovAA0E/bdj3ThefhhmyKdp2SEJjV4Y
	XRga/pGUp9aTxCDINkQ16dY7oFEsN51LBQAOFXujLvzUocpp4rOQTcoWwHkZLNU+37+iNwPVYWF
	NJMzT4/cCZ+IpEI+/rbgaeAro3O2U3g6P00MiL0k1+aJh7He1P1/2P6R4Pqvmz20ZnBU/3vjVxM
	CJmkDXpCP3MyZqvg1ueHkU+S2F0
X-Gm-Gg: ASbGncugFJ8hOUBx3g7+KOZzPbLBtP8y2vYst2okp/uPnQY/Dhg5ncO2RihXhvIF60u
	EfUOYGEmK9zrhjOm9APXq9AeDUnrZUw8QPLEOqu2EEdcrDMg13+565nN/9N7YB43FiHt8WF6yOF
	ChpuGphpuS5h+86qLoGBWAvGzsAkjwvauVrTzglm92wUZhRCJGjoGRdVlQ8gmE/A6bXENj4IwRS
	CPx1rL5FGiaVppzRP0iMyigxnhua8jyYBBkdx+BMBDwwvmVZSdVf31zWAe+HO36F4/thoFij/FT
	ZxSI7QklFRHE7ynpjFdATgfZr25LoQsIf8I1cZd+p33CcOefLrL7+4NzOiCoY8VNYoibGtVTmh6
	dF98AoXIG38yG7nQMSzVGEsWYc9q+PdPh/+gILPl8yYEQTjDgAtZ8zZ1NW8idz+UQmM3pcmmcoB
	qZYvqq+Q==
X-Google-Smtp-Source: AGHT+IEVeKjC+2aXnTCKjPUS9zcFaiFLEzMKGjAoFICWfiJp14olYOw3509WeJnzpbY3MNLq+VyE3lcdbfSY
X-Received: by 2002:a05:6e02:3788:b0:3f8:a02c:7bfb with SMTP id e9e14a558f8ab-3f8a02c7d0fmr42622145ab.28.1757092813044;
        Fri, 05 Sep 2025 10:20:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d8f28b5afsm1071852173.25.2025.09.05.10.20.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-772537d9f4aso2168837b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092811; x=1757697611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLFW2g+f2TuwLyM0X1O85UbfIsEt5ZueedBLU5KTuv0=;
        b=KIrZfW97H0sufB4YotksiJEZDQ2YqMMGIbaU3u5z1aM6VhCG/yrsNmBaW3Ftq4cDYG
         XKZtWRg2mUrqHyqAfHp2BrdnAWxObVmuu79Ha5k4eB0aoF1Or8dtZRcZWxRbSOaQ0BZF
         JVtHqNm0KWaUVpIh6sin1hRm5X6+vRahAzPSo=
X-Forwarded-Encrypted: i=1; AJvYcCWfVgXgHe6/l+MXuqaxFlDW+vA3phRTUJnKvy3h7mygdsMF0KBPAAa+nAELyQLMjOgbWMib3jpqJznbp40=@vger.kernel.org
X-Received: by 2002:a05:6a00:240c:b0:771:f8b5:d93 with SMTP id d2e1a72fcca58-7723e38c01dmr26590000b3a.27.1757092811453;
        Fri, 05 Sep 2025 10:20:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:240c:b0:771:f8b5:d93 with SMTP id d2e1a72fcca58-7723e38c01dmr26589971b3a.27.1757092810976;
        Fri, 05 Sep 2025 10:20:10 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:10 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [v6, net-next 00/10] Add more functionality to BNGE 
Date: Fri,  5 Sep 2025 22:46:42 +0000
Message-ID: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patch series adds the infrastructure to make the netdevice
functional. It allocates data structures for core resources,
followed by their initialisation and registration with the firmware.
The core resources include the RX, TX, AGG, CMPL, and NQ rings,
as well as the VNIC. RX/TX functionality will be introduced in the
next patch series to keep this one at a reviewable size.

Changes from:

v5->v6
Addressed comments from Jakub Kicinski:
    - Add appropriate error handling in several functions
    - Enable device lock for bnge netdev ops

v4->v5
Addressed comments from Alok Tiwari
    - Remove the redundant `size` assignment

v3->v4
Addressed a comment from Jakub Kicinski:
    - To handle the page pool for both RX and AGG rings
    - Use the appropriate page allocation mechanism for the AGG ring
      when PAGE_SIZE is larger

v2->v3
Addressed a comment from Jakub Kicinski: 
    - Changed uses of atomic_t to refcount_t

v1->v2

Addressed warnings and errors in the patch series.

Thanks,

Bhargava Marreddy (10):
  bng_en: make bnge_alloc_ring() self-unwind on failure
  bng_en: Add initial support for RX and TX rings
  bng_en: Add initial support for CP and NQ rings
  bng_en: Introduce VNIC
  bng_en: Initialise core resources
  bng_en: Allocate packet buffers
  bng_en: Allocate stat contexts
  bng_en: Register rings with the firmware
  bng_en: Register default VNIC
  bng_en: Configure default VNIC

 drivers/net/ethernet/broadcom/Kconfig         |    1 +
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   27 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   16 +
 drivers/net/ethernet/broadcom/bnge/bnge_db.h  |   34 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  485 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   31 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2211 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  251 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   67 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3136 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


