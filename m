Return-Path: <linux-kernel+bounces-780244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A95B2FF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8154C188DC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07292D2394;
	Thu, 21 Aug 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BsKIjGVV"
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E41276024
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791319; cv=none; b=LP48i9xcZb1C4164wWHrlkgQQ2hd6Xk0jK/xnm9yDOH9ASnPlUYvg0SyOA+Mqx9pqnOZdYpBjqyPTcScsPsCrTYgVNJOO0pNLO2L363RB0vSwdyB73VNMMmfokxh1/XNQK0GnX9cII4vmUY6slGztqYUf2IyCoqTTvskoHwSM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791319; c=relaxed/simple;
	bh=QxMezdxGdBtB5eRD0pROjljUigKSdcuW8FalgQx9w8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucyCpnQ2MVdn46puKDGUNq8LH3RjC3jkLtvmVme8m/UXgnisOIgEQpxZPK21bCEpCP8yRQXLhDPteb04aoxRAuKxyxtd7kzaIBS9kHSWdn/3fWAakm6GlUU07L6l77eKmEPjQWSmwdhH+ifgIx08AMSLwH/aVWWdm3HiujH6qkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BsKIjGVV; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2461864f7f8so5294405ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791316; x=1756396116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnMi0sjBhZE4uuElmYuknC/E7+AMHFdyHEwqPSdU9NI=;
        b=gcoVBALFtFTI0kWokcL/93le2JGYlr9oC84cyvwY2II1w7iMR1f+sDlEnpoVs9TMx8
         hyp9S4T5rIVVbyPU296pLN2bCvq2XE4hR9cjvzJUDwcRtsCYwv1nTHt38S0ntTcVEK47
         MwaBun482QdxGsjzn+RcnGDEYQDzFjTjYQpyk8ZAVYmEffT0e3VlaF5iNw+k+P3wqeVV
         SSavCYArbaI5UHpW4oUx+1bWBq2CITvmQUsoJZyxPIWbl/Qj4x5FwJvGeCV/w0joIkGl
         Pt8dju7lrNDJlSkev64IuxUJpliynp7USFNtnFCAoci99v3slOhdr4ARVUfoQBof/X/B
         lJAw==
X-Forwarded-Encrypted: i=1; AJvYcCXdVBG/4l0T0dyIAphvNrGeGfuNq4EHu2PLbcnqVBx3Mctd1IDpPj7BOc3QREuvN7GybF5LSC/XiIJufjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/oE+miGWIWHU7LekFq/dkF9YRrnrEnad3GUa0C4sAEC04Ab5
	xqoDB9EfGGQVJH0kgzyR781SATN6hGzX1sFPt0FVirx5+5defYEewo+qhp3Fvwc1sXo1aVx2rpr
	ZFVdaIjNB41snHN9wmYUtKy3yP79xVZpSYO+F3KhucEinei0/dnzHZ+5+ofkK7sRel1hQ5Bi8t5
	e1U+MQuRaHP8LpZIHfl+IUx+/PGpEcwb/veovkFkdGEybHslc/NkWI8S7KpjFHzLk8xcKxAgXXA
	vUiue9f0FOFRwGa2RApsrO0qI2H
X-Gm-Gg: ASbGncvyQMBe6xHLgC6hdk0c57+hEhoRWw8ecXc0yZw+wrdxTkJlyHcfXKSXkwZqYLt
	CpE3T0CVeeuS9T75DPMqAYCunE+gne4wrmZEHq+5p7nWZRDLK/O9AE6F14ONjvxmOUUElMeptuK
	HrXDULRVdXtdIcMspz348Q1aC0cY0vFenyVlb21P7WB5RcojpH25f56O0Vmb9HXgOhyd/CVK87K
	gj3FFzH5/w3vF1an6FUg0DNZllfsK7H3QWjb+SDzL6N+6yyVzKMVGntBzasiBfdWbaDqhaENzTA
	TcqlV2SOep8QcmyackES4NDdDJZ8xVMEq/v6R/pRjCel/sBGQ7qBakohtWs5hMVQslcc0FxsRK5
	IaktjvEFCk7IJAT6pxaIsCk5bxiHdpTYCxjeHbw+NlQ5GWxbfSMIlcQptm68ziBOUlE1hesA2nV
	ERWd7SS6oS
X-Google-Smtp-Source: AGHT+IEvQ4bwEXPc39FKVMK8Ka6S2p+5MA6kZjtNwQ8vBX1/s0WXdT0w7a/+fMFKQup+zb6YHXUGBylbwosX
X-Received: by 2002:a17:903:2ac7:b0:234:d292:be7a with SMTP id d9443c01a7336-245febd5caamr44337405ad.1.1755791315762;
        Thu, 21 Aug 2025 08:48:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3251545e4dcsm8657a91.6.2025.08.21.08.48.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:48:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32326e2f184so2225373a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755791314; x=1756396114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnMi0sjBhZE4uuElmYuknC/E7+AMHFdyHEwqPSdU9NI=;
        b=BsKIjGVVQ8VCgZgVIvQ4xVrtirKQTzllBPLn/+HpA8xkaCM0mgfJtYuq/TGyib5hpn
         ir+SueLMXI6UQboU/EnC5Wle0merdyM+zV0KZBEw5kGKHMgX1biRVPzYriZoc2mOOAN0
         KUEEVBIT7VZtxFVU4Qw1k/M3FNRGWpOXjGuEY=
X-Forwarded-Encrypted: i=1; AJvYcCVcpSZJoVPXYyDBK4JA3pp4X++gqNefLYhFFVtRKxfM3Eu7Sl++E7jT63IqNly6vKgWI2Qq6NHHV0QjJ4M=@vger.kernel.org
X-Received: by 2002:a17:90a:ec84:b0:31e:f3b7:49d2 with SMTP id 98e67ed59e1d1-32515d21177mr84865a91.0.1755791314041;
        Thu, 21 Aug 2025 08:48:34 -0700 (PDT)
X-Received: by 2002:a17:90a:ec84:b0:31e:f3b7:49d2 with SMTP id 98e67ed59e1d1-32515d21177mr84839a91.0.1755791313505;
        Thu, 21 Aug 2025 08:48:33 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm5046894a12.46.2025.08.21.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:48:32 -0700 (PDT)
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
Subject: [v3, net-next 0/9] Add more functionality to BNGE 
Date: Thu, 21 Aug 2025 21:15:08 +0000
Message-ID: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
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

v2->v3
Addressed a comment from Jakub Kicinski: 
    - Changed uses of atomic_t to refcount_t

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
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  253 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3106 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


