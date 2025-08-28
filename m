Return-Path: <linux-kernel+bounces-790035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C40AB39E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016381C82468
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81CF31280B;
	Thu, 28 Aug 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gryf6Kba"
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B27223DD5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387137; cv=none; b=s3wV8zPAhOtpoiE5u5dSwgMkH0XGXZVqRJvucUa6ZFsjtLS7C8/vttvwJ+zo7WbMZbwm6gcmZZ/NKzwWrPMxK8tHAPJRQB253MqXIrMJoG1WUhPbCYHv1D4lwTy3xMj4qJHcALGHWcETlUSZhgugMHQJaG7OstMIrxvxBJcHP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387137; c=relaxed/simple;
	bh=QEW+OhFN+T4FmSnzJQJw9bi/llAhDxc5UsY+Ui2/fc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSapoKJlrAQGMSHrMrBAqGIZuBGK7FEJfyh4slLN4Dtr1VtjFywIur+mfOy0o9r/e6Fwi/vJYKszXgZulWxi1hV5LPqPQhGNEmXYzVRBbxTdBuLM2ivroMcnZ4//nqfKMe/fBUNwjcex6fklJ8dX2jVon0nfzuz+4eLqQewkzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gryf6Kba; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-31597d3b410so433698fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387134; x=1756991934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epXRCa0/NqmWmZnYhhismgrmqJPJFawMDtKYxeRatMA=;
        b=w+voeqt6L9jaDAhu1MmxFZl6rRlqRZAzZF3ARRFqnRwj6uz9NNdRRzA375Nzrrgm8y
         +L8wNArRZbxmmpOMfrqXxmtjgdFGH7zSJVv1d6skjesKdz0IKSGul35Sqqw3p/nCoTfE
         nxmLmAVwZB4qwc7sTmx63lia9r2tFHLok7Rm2kn3+o3nm8VbGw6243Biv9k+lQcDj7Wj
         GKETwfbihVQI+Jf2/IaOqVJBgSfIhzPEwSxHqmM2fR8t7yp2I+WO25ResoTHTXBoSXm4
         Zu3tzaj4bMZSY0IFwdygpYILhTeEkF0QflfgQNmQzvC28+c+alElINFDc0QZ14t7W9EE
         svMA==
X-Forwarded-Encrypted: i=1; AJvYcCU+5ZeVXs/Duax0lpA1fykaGnZC9dzNE59CPX2lLEAmlfFjJAHB2xeHwqUjKnvANHt2Ez2KdyQkaFbFOxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf5LYJvWNPmlbnT9S3eubffEoON9ySUJb1rJ7dIjcPv9C4fNcb
	SjeJ4KEmegNefDIS54RRnDO0SXA4cOHNMz0ymBlBxWA8RQJeVmZOPd0J+YOXCIWx/UwD3d6FhdA
	bspORQlIv8mWj/Y9+ZaGyjzYTThsgjE0wHxbPUa4CAEypJLyOdzUnMeWyWCeyf00GkEuyqECsjH
	hLaYnFjWYAGdYSxcXfYqxCQiea0Do56LB8h7ITb0GeiLJ05zsJ+G2i13L6VnTpXRg8pFXsewvtL
	2Jsr5I6o82C3HqqLo5BN+uKfN5c
X-Gm-Gg: ASbGncuX5EDbJ1T8DM/CP9uioTRTXaq4XJs9ZBHzeT7zuKQRrLUmEisMJB2wDHSOVnl
	6ofCg1KCQyK8JIYv0+YZhpnk0Q3l6DwUkj+7K0/JDRzf+OYStdfHMNBAK4bOvMqryOyUa6kKQPz
	/pO100ZpzTERH6InmuXLhMADCfPJQO8+md/OQqQPyUYX/8ICSSfnO0asK1+qmH9FjL2mqiu3KpI
	5kYYYkBd9Ek3ITTQdZhWGQHnlro+H87kDjFFEXwNnoQs6186OroyK7GhNn6wjVL3AnJAQROm66D
	UDZk1djadsfm2/WVqS5LR6KLtv8UkmlQwzKfZVpt0+P7zU+IajOJ4vfLsaqQf8qLDJmEdUBUOds
	fmoqUWXcyCb0sxiMhW/pj/Db+H+NSyFFKExVukndr/kPA3rF1MIkefAIQG/OdgXZdZ0qotLhu1b
	bIEBJ+Fw==
X-Google-Smtp-Source: AGHT+IHilCE5JuhXbaxDzZ1dgMRbhWZrwlMVN4zN8GtVM3s6K6PzARGmFtYbxvXESbtj3o8VZNy6yTzXYO3d
X-Received: by 2002:a05:6870:e0b0:b0:30b:efe2:c1b6 with SMTP id 586e51a60fabf-314dce19c5emr10840249fac.24.1756387134558;
        Thu, 28 Aug 2025 06:18:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-31535026131sm873155fac.24.2025.08.28.06.18.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:18:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246a8d8a091so20756045ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756387133; x=1756991933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epXRCa0/NqmWmZnYhhismgrmqJPJFawMDtKYxeRatMA=;
        b=gryf6KbaEGptA5b+vrY0WOwmavExY8VwvPPWJC7Y73LZCEQmM2RJMSIiC21TDsj4Rz
         WcbMl82sr1VMnktdfWQs2w4lw38xaBwjO3CPaUYVVkqxCP0FtWoFUSKL2ZvIuCuehs6o
         N6cOHh2aObx+AY9FU4lh2wViRsy70rvvi6MMg=
X-Forwarded-Encrypted: i=1; AJvYcCXxTGzUe+PROhp7Qiy5U1Km+21XFUzF97z0k5CRXJG2yFvg2vZgSMEIxwQdmkbqLHJao16ICnogwhdmruM=@vger.kernel.org
X-Received: by 2002:a17:903:1a88:b0:240:671c:6341 with SMTP id d9443c01a7336-2462ee9bb60mr369060005ad.26.1756387132722;
        Thu, 28 Aug 2025 06:18:52 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:240:671c:6341 with SMTP id d9443c01a7336-2462ee9bb60mr369059585ad.26.1756387132278;
        Thu, 28 Aug 2025 06:18:52 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b6a16ae3sm36468705ad.137.2025.08.28.06.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:18:51 -0700 (PDT)
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
Subject: [v5, net-next 0/9] Add more functionality to BNGE
Date: Thu, 28 Aug 2025 18:45:38 +0000
Message-ID: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
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

v4->v5
Addressed comments from Alok Tiwari:
    - Remove redundant assignment
    - Fix print info

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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2201 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  252 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3121 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


