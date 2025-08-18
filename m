Return-Path: <linux-kernel+bounces-773818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A31B2AB05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2834F721E10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A58308F02;
	Mon, 18 Aug 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sg4CjauS"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0122D8DD4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526838; cv=none; b=Xy4fBpHmmo4dgEs592PuyBruX9Ly0ZNjH1pqkRVewD737iCWlwQQKIJzzvQBGW2sOfrjsro/0f7hh/USLmnDpA2Div9eNtsbBeVbltXEnYyfQFsdumrtJNjYPwkJcmYvo72Nau7rHN9HnX4T2NK3RFcit/ZPgu+tdEnpnPha9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526838; c=relaxed/simple;
	bh=tXuh9+Tako/6SI5hu4a6KGj/DLclcRO/0P7UWGFsjfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h39nSbU5z+urqBH7asm5p2UN2snSEUYH8yQiD5UfHp1SUYXqZRMgGVmBa2ECoA2u8cpp5CZW+h9XijDdm2Bzui5bzqeBeZkECe+vwHJJ46sHB+jr9mQmAwV3LXkXr40HFXE18LjkWq9MguUEMseXdwx/XINOXHivzSwJ3sNVYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sg4CjauS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2430c3684d1so38214805ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755526836; x=1756131636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iJWKv+XzfYj67rIu5+Mh6p8y3dF6jMz2KOqOjeZdAE=;
        b=Sg4CjauSV0YZONpSA5QsfBUK18L9iOSB6sI2dCVUHKCEGiEtge52spsYru9YpBwkiy
         JjzlcVhXBwuJbjLreWKjwmpGAVikIZMC76vkTixugiSC8KhpPOL1FGrmX9NEqMkGnG7t
         0reHZ4qXPGBte9PfTD+PffhMSHzPZVd6NWc88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526836; x=1756131636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iJWKv+XzfYj67rIu5+Mh6p8y3dF6jMz2KOqOjeZdAE=;
        b=q74KokOngKjjyVFFHXqqAXqevwfelU4wTWQ29/TFoJ48IgjO4U3roYF0votoRuTMa6
         CJ5/qquyGQ4wIdahzoy98ek7rQoMBcn2O/6WaGyni2m03H1IsHFcLtuDNMn30X4MV0FF
         8Gf02jlcKAAfLkEVLIqcKLMGFjmC4yodyfCAioafEpWEOwFY32Lw+dGaL1hOII1mCLeG
         R2H4lcyjx1gM2Kdyde646quQX41hCNNxYg8PtYIFf88oKcfKeJZVCWwUvZoNCXMfMwle
         MUPPTYPfdE6Za0E2TpylVJ2dlqiuwZ3K0Q/A1rEm2wmOge8BOsxfx0OxmV36LEvklOWp
         qFzg==
X-Forwarded-Encrypted: i=1; AJvYcCXEHR1ceitPaU1H3XfS8OEnG2036z35WjKCo1MRW9tWlJvyFUUVzpjKQ9NiL609aEpah/jX01MvliCo6Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9SRiJJTCDZpk8TbeiGR43bHBxIMDBliO7y7vN4NN8sGDvlQr
	ReESfRfcxAL6yh4IhF4s+vu0+6unJOvaakAWQELDZ39lOHnOCSLMVk4IUUkr6Es2MQ==
X-Gm-Gg: ASbGncsrYEg+vsb7of62ZZnp5zkWsyW1dwFg6qQF/RDhCFAA6DVsX2KhXIytzRdmMGj
	24w8y2cO5JuEHHjQXoTmKoXpZo7JpM9tobz5gK8OP/pKu5aJuNrp7+vTSGWAiKE8Fj1LkLm83H7
	6UzllwUKSRNrMx5cU90sCPpoVp0obcE6bEJiiriQ+Y2acKcmL9kD3gq32SrnDIYvp0grN/mk+oS
	6vWiAooEnv0+7wb7XWmFR6XYiBaIbGaXoNTRl5peuCmyZUIv9xaZFS5dwTPz9AE2xsKSWmV5yxJ
	tZUWlNCZQE9DsvDCp22uY+29LHMA7neKl+4OhWLjajR/Cm6/wFVtv+nmYc4aVR8FXda/x1zaRVr
	BIDiz39JiIgWsIXzzZDDdiUIurLqimjXi2Ehbxa74Gfa/Lu0SWuhcTAenlT8QfbSCBRCwYWe1Mr
	FpQ9BrW29aofyDyhujgAWoWE0FeA==
X-Google-Smtp-Source: AGHT+IEpUxRJiaC/FhAJavL79hu2dwlz/YlZYy2RZksVYR9pcUjk7MzeE8l724xUwIdMDrwU7KEYeQ==
X-Received: by 2002:a17:902:cf11:b0:240:86fa:a058 with SMTP id d9443c01a7336-244594c7a56mr221256215ad.7.1755526836327;
        Mon, 18 Aug 2025 07:20:36 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d578aa4sm81947835ad.153.2025.08.18.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:20:35 -0700 (PDT)
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
Subject: [v2, net-next 0/9] Add more functionality to BNGE 
Date: Mon, 18 Aug 2025 19:47:07 +0000
Message-ID: <20250818194716.15229-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series adds the infrastructure to make the netdevice
functional. It allocates data structures for core resources,
followed by their initialisation and registration with the firmware.
The core resources include the RX, TX, AGG, CMPL, and NQ rings,
as well as the VNIC. RX/TX functionality will be introduced in the
next patch series to keep this one at a reviewable size.

Changes from:
v1->v2

Addressed warnings and errors in the patch series.

Thanks,

Bhargava Marreddy (9):
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2186 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  252 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3105 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


