Return-Path: <linux-kernel+bounces-812759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0293B53C55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04051C2847A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161AD26057A;
	Thu, 11 Sep 2025 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NcuaEI6l"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D756023D7EF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619323; cv=none; b=hNE8MzLscSJjviJQJ64lm1zDyZQ87mnQ/saxH+SVCoMuZ8WaKVTVASF+qk/xY/9gBEiAcvTLJprYpgG8Z2CvBiMLsYWOwlG+mMpIwN/Q0zh5ST/t/PZgep5O7dRBHJqCIVcLJ6s91BElxHocPO+YQ5uyzxRokuw3qChPdV7k9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619323; c=relaxed/simple;
	bh=S4/aOHGQqTUAIA0XcvGx5wKQh909FOEIhCW0/0Pc6/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICBJCgN/Rmo46LBPfFWoxWI824+79BOQODuLi7U9JVnZn3VG5gW0lnVolUJvcc4OLyiTJVqDBIlSQzkPYy3re39FoqRJyZThl6bRp741WYu8gC4mwGfItgKurI1lKW+oNmFPxgDMiUq+wbt2vq3EiEnEZRlI3/7tFsSjMCsosWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NcuaEI6l; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-406630d3b17so12590275ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619321; x=1758224121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4DDAQLElHWgn/kO6TEgJJZR7NPyqBFo1FrDy3LSQVU=;
        b=oemJcNyXNHs43KAzeh+CmYLeTCnROY2xryATGG/0MQfFMUpTBkLnCJkcnOARqCDX7m
         wcXijr7wAykaPYUIqDuhJEVUewlAIie+aJYsOixgXjTZ2mV+8UHtt7Ja+pD6nKItqVQ+
         ZyHrmqq3/bzUUcpGU+sesvkFWFQqEvnePLPFt0AGfvC+hMU3AZbl7umB5Ef6Q9bLBTTu
         pXbBIso2jFTE+hCLMhtI0oUcUmI1rQ+DTqZN/DCLG4aWrY11UT2FTyuOBpYDccBMZTjg
         nu7Hel0WDoUUfnQ4/sk63MP/e4Yj7YU98uU6caUZ4dnEXUaQYhBCZ8Jmg8sdGRQHJVCa
         7A7w==
X-Forwarded-Encrypted: i=1; AJvYcCW21UYvFsah+TnBswh/hZPLXjwbEq2Uaw0K8jIoTzAtALzrmosnCtaudRqeM2yYcoltqK3Q2W3HP94iKKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuU7c72Z9mhSlICvA2JEMriwRk543AlCY4jT/0sVGG/PcaQPH
	ieRYR8eGKT06so4KurdKa3HTyQcngoQEKiqR+HMrmfE0M4/PXhRdRXdZGmau9Um5YitMj7WgKTP
	nKB63S43AwCDS2c6TwV/9CoOa8KU3SnM5aOztQUb2FuXO9DsANXfBzL2mFIejSoLGtvOrZspEH4
	pGw8HPsg6i9lXUY+bi/PaNvj8JrS2voQawNKYL14777Bjo9rj4zHUKVoDbvUVy9xRfXJnRu8kOz
	wlo2XJi0jA1k9vPkNzUtqcWDDU+
X-Gm-Gg: ASbGncs1jdkKPPFxDmHyf7gfVrUPtjC1x+a4fVO3XeWzpAZ6H7QaecHiH0hhYApWN2A
	GIHhbaRxBhqNHOtXLLCavs8FZuEc7nagPUY3DOoFOTsUwhvM5Ehd8CjXFUE8Bz483Gm4P/lrMDz
	vmgXxxiBddr59AqEZ/v6QkulErPLkUOjx6KLNqro/LnTEXZAjQ/oHAi911K16ncTE8O/yXWMEas
	7qbecWualEH9OUdwZhsgAyrWrG/DNSG36WIWzP/FmYo+bhCpM7OfjQ1EAtzUoazi82MPjOIub2b
	xsBCazAM5lyhwGA/8M01AoEbwqYc02vVoiz4F93F/rjrTlsccIrzkWY6bYZRSfQbQTd7WJ08I2T
	aZFikXU573rn6/2jSK3h/ydYRZ3w4a3iWTyCkRtdZEdY7omb/W12S/ylpj16zHN7T49Bb6Dyv/L
	nucDykFg==
X-Google-Smtp-Source: AGHT+IFhoMMYNoda6DYFuVX35yViRvgILU/QUprjW0YF6AJKEiAEk1h1NFmYuKMw4M8ZMcIORbRl2cSM+Aoh
X-Received: by 2002:a05:6e02:3e06:b0:3f6:5568:d685 with SMTP id e9e14a558f8ab-420a4fd8d8cmr12797835ab.28.1757619320819;
        Thu, 11 Sep 2025 12:35:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-41dece63ddcsm1804115ab.1.2025.09.11.12.35.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:35:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24c9304b7bcso12560505ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619319; x=1758224119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4DDAQLElHWgn/kO6TEgJJZR7NPyqBFo1FrDy3LSQVU=;
        b=NcuaEI6lWk34Cg/18prgCDXq3PGaYnfJjm1+llHbYojpEgDMia2LcuCwINzqiwRm0I
         sFqNTMjkfuGsxg6X5tMjuvGgZ/ROpyutlHZoJcpF4i+5dJgH8A1ZkgtLl+OGP0g1hWss
         Ny0AQYKI+uFuL6YHJ/7Ep+MnzuOCgSGryAYHY=
X-Forwarded-Encrypted: i=1; AJvYcCXVmOVNRYWoeh2qjwL/0ZUJURZkXlS/rIkoIWCKMTXa9t4bwFIXaBuOU7ImrwBxeqgtYF/evj9/Zf2BNkg=@vger.kernel.org
X-Received: by 2002:a17:902:e809:b0:24c:ecaa:7fa with SMTP id d9443c01a7336-25d26a5ac9bmr5002235ad.48.1757619319335;
        Thu, 11 Sep 2025 12:35:19 -0700 (PDT)
X-Received: by 2002:a17:902:e809:b0:24c:ecaa:7fa with SMTP id d9443c01a7336-25d26a5ac9bmr5002065ad.48.1757619318976;
        Thu, 11 Sep 2025 12:35:18 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:35:18 -0700 (PDT)
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
Subject: [v7, net-next 00/10] Add more functionality to BNGE 
Date: Fri, 12 Sep 2025 01:04:55 +0530
Message-ID: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
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

v6->v7
Addressed comments from Jakub Kicinski:
    - Removed NULL checks that are not applicable to the current patches but
      will be required when additional features are introduced in future.
    - Handled unwinding at a higher level rather than in the deep call stac

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
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  482 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   31 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2155 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  250 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    6 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    2 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   67 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3078 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


