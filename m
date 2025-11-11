Return-Path: <linux-kernel+bounces-896149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F0C4FC33
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4303D4EDCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67C43A9BE3;
	Tue, 11 Nov 2025 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NJIomaC5"
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CD3A9BF0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894743; cv=none; b=RjmQEY56GJVq96AwiR/XEK7uYkayQKo5CPt/2f00ldIsZQUwM7G5EzRfho+P9IbrGqKHtoQU2+y8OZh5+huf1eh9MAhy9B2rOXlLdiZaqBJv8xjGW9F0Yu6d69kZQZcVjT6X+bKupVTACbhS8fl9pP5rzgDeqxv7xsxg0/pvRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894743; c=relaxed/simple;
	bh=zhqpMMHJA43pv/+KdT9F7BoGDi/CIcsiUS1ejxY5CQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XM0dTZmwDPbe7DzM8infNnPNhyem3xH88IN+h0K/zdtXXIBQMvSf6iZC031YZm36cXyzYNZVubZQ+B/a/Ng9d1Rh2BHisJp3+nANOfqh9y7684QpN1+zCJrAYKNGuP2E/+7xeG9gFOiwnv/7ILrBlEE5BtzQluYX4tpeY+1xHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NJIomaC5; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-94880a46f3fso5607039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894739; x=1763499539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KrK/OwsZWQEUZ5NhloRbUhuZmbyRGhs65jfLK1FGUw=;
        b=MNR/uOpoDWnsRNIBPgw3ETgzCH8csJWObSISx3w/A2cU41ZkPPgqGVNiGAyyoiaHu9
         WfFIyPHAtn7okREvyHYF7hW8be1yBIIpPe2O4g9TKUHlzgi/gu/cABpdAobQGnFW3051
         jyenxwXzfLSREp7BslZK+qacE/m7A+x1JDqod4Sp7eQxnZFSTUMgJ32htMmcE3CNNz4n
         uHQbMVPsKU/IWPcc+GXjN/KlnnUJEGkNRzE1OL5P94924rMKJqQkcp9FiZw3PkACDAJN
         3YBR3bvyQq6rhz5kvAAw8tOuUKM2XqisWgFVT0Zji+K/iZswt/Moe/XaRgM12JHUfQtS
         aHaw==
X-Forwarded-Encrypted: i=1; AJvYcCVfmelBTmszoHsMvvZbk+kzPW8l0JG3laS6GoYm6X9+IJOvvDEqY8cH4zJhK6GJeFMtF6JtCA0+rYX5XyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgIfoA6Rd4nSrUGLFL1t+zAYWjpQERy/EOfICHlNxijTa+DNE
	J0T3/10KaIdvN2E39SVzkaDNI9lEk2R0LHq2usJyijuKH3SviNGWbhynYBQZFvDkdrQQIy1NimD
	ju8y0VqoNvFewUTcon+LU5HWY/WHHk0M0a8qAbdwVIRKsPAiGBip0tmSIFgB+Gcic3mNu7eOq4r
	KVTmEdH0v5THyiRsW5yx4HpN1jnwlcMneXST7I50w9yiBXvNhNi22+M1cOGKWBtmNbIBRRanYwJ
	5tK/gYpgFgvdBarjo/vgvudJogR
X-Gm-Gg: ASbGncsznjwpWvlJiwxVQQIV7UfNnOIFNPit0VMSHpGbLXTexCyVcoE4NA+46GIfzQR
	h27KNOI7vKNpuLPOkoUC/Y3LDQqDpwWcmafUqw/oxW6bW7AsqI5Lidac452n4i3gW36LxYu/cbm
	JJbnySjIyMrVeFFW0Fj6Js4EeVs2fHao7hfIh8koHpiK3wHzo68OqxqWVpkmR4N6raAWpYL3bp3
	AIgCvLwrQ6bii9PUlFDqtfpdbK/ARL/SfcU3y81WV/n8XvXvsJWOGKl76v+krQtFndGRqR1dGfs
	CCM47KEpVt8BULZJ495re1BWg3bc2N2FOMBmwV8GuBarhbWwcjB2qRJNPoAJgI9CyvG0Zlvp7uw
	H5ibfJrPO67/X/tp+DN3jJ1UNBDaasUj/O/fMgQ7NdWxlyvqgwhs2FA9DwdtDpxFt+e+6mhHrDV
	eiYZBW8udlH0zG8Wl6bPY9/RM+27IN08KNt7LEV4tY
X-Google-Smtp-Source: AGHT+IF+Jp4TZZNdb10Dlv1cbJi58GlI+BOxy9UbOQY/mMuQP4DLHpNvJr/SsPE4NForvYxVTA+SZzff7xnw
X-Received: by 2002:a05:6602:27c2:b0:945:a7ce:646c with SMTP id ca18e2360f4ac-948c46418eamr88566539f.10.1762894739389;
        Tue, 11 Nov 2025 12:58:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b7ab14ec76sm58169173.29.2025.11.11.12.58.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:58:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so118532a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894738; x=1763499538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KrK/OwsZWQEUZ5NhloRbUhuZmbyRGhs65jfLK1FGUw=;
        b=NJIomaC5GKL1a1ywhiL2y12zlZD+BUQdBcZ6CqT5YUTU42HhCGhukodoqFZy0pGcu1
         4pOfW6wzZ7ehLy/sy6htlkcRAjgf8kQCDuq2JvcHur275g8Vpwo0MusG/vh+V6FeBHsd
         OQHMEWaQBax4DGhkzGYpWHJHTSNF4kvxXd5QA=
X-Forwarded-Encrypted: i=1; AJvYcCX+/1uuDHdfnnKGefBmABpaT2sg3PYcWV6UUe3+Jsnlv16Wo4SiNvJRMbZ/n7IalakmrV5T5xyUXnDXvtM=@vger.kernel.org
X-Received: by 2002:a05:6a20:7351:b0:342:f5bc:7cfb with SMTP id adf61e73a8af0-3590b82e3ddmr641137637.56.1762894737970;
        Tue, 11 Nov 2025 12:58:57 -0800 (PST)
X-Received: by 2002:a05:6a20:7351:b0:342:f5bc:7cfb with SMTP id adf61e73a8af0-3590b82e3ddmr641113637.56.1762894737539;
        Tue, 11 Nov 2025 12:58:57 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:58:57 -0800 (PST)
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
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [net-next 00/12] bng_en: enhancements for link, Rx/Tx, LRO/TPA & stats
Date: Wed, 12 Nov 2025 02:27:50 +0530
Message-ID: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series enhances the bng_en driver by adding:
1. Link query support
2. Tx support (standard + TSO)
3. Rx support (standard + LRO/TPA)
4. ethtool link set/get functionality
5. Hardware statistics reporting via ethtool ‑S

Bhargava Marreddy (12):
  bng_en: Query PHY and report link status
  bng_en: Extend bnge_set_ring_params() for rx-copybreak
  bng_en: Add RX support
  bng_en: Handle an HWRM completion request
  bng_en: Add TX support
  bng_en: Add support to handle AGG events
  bng_en: Add TPA related functions
  bng_en: Add support for TPA events
  bng_en: Add ethtool link settings and capabilities support
  bng_en: Add initial support for ethtool stats display
  bng_en: Create per-PF workqueue and timer for asynchronous events
  bng_en: Query firmware for statistics and accumulate

 drivers/net/ethernet/broadcom/bnge/Makefile   |    4 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   41 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   35 +-
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  653 +++++++
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  214 +++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  395 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    9 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1289 +++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  191 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  736 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  474 ++++-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 1604 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  118 ++
 13 files changed, 5713 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h

-- 
2.47.3


