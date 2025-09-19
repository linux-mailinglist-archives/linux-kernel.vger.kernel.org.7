Return-Path: <linux-kernel+bounces-825048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A32B8ACDE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2FD5808A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971430DD38;
	Fri, 19 Sep 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cb0B4LaA"
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A01F152D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304094; cv=none; b=lOgtEwjmSJohUIjBiNW/wanApejZCKdGhW3WXdH1lGmzthFyBHYMOLk22UJMGkNdzOniTeRDoJgUMtV3N9ikQjKyWQYNX55EH7R4p5mRu5AaCD5XiCuksTXnEXX8kHAx/aWQ6zHvNdCz5KQTSFhKBnNUUaa1VFhzaHfo/vemX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304094; c=relaxed/simple;
	bh=V6jKT+38G+cM94b40t9dw1NuZtwzytsckMLg4WY1PwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOmh7XzeGLG20u7fPucNvB++LB/tWCxpNpIVQr5DI6HvaiN+J4wsbkRvVk/AKvbJRsd2xkZTkBQp384sWZvBsA0WgS65ybGeTVB26VIOC/rwVHMY5epc2iURWsGJwU7fy/0T6RSlzy0+2nzqvfdrNlwIc8hy6dmlPsZnXJ/ezSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cb0B4LaA; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-791875a9071so23778796d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304092; x=1758908892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQdBnzkJ6XZr3h+JOYCkE5AzdDxHuHzROOLjBhUEp78=;
        b=uNfdZPWHtbIasZPgfH/XcStbKrNLOMvk77BWWgwrfwXd8vK8X8ROHRrLzZ95aVVZae
         axr8Ny4yvzuR3nXTs1pHkPli90jVqcs3MbOn00AlvfQ4ATy4rzy0SEG6vxPznz0W6zj4
         mch2gSe7kUIrOBms0ug9ItaBkuxShFHeJumDpEM3LmYuVVKwdYmQajeSegSzB3IViRUM
         0HNphGQF//DFIEWoRV/4LSeS0E9AaA/CIK/5wcbr3sveFrhr2WyA+z0CiS9aAupHg5fs
         gXu6ic15xwcEu3o7fHFox8YBBZ+zPAfSLH5oz8bDfA4zrLNvs1m8d4W5NqlDGKGFAErK
         XLMA==
X-Forwarded-Encrypted: i=1; AJvYcCXxxvEDKJ1u/+1IEdSyQy4HHkG4M2utem8QSi+UIlrDj/DGVBsAeOOGzpAD1Y44wQ0Ym4GkMDHoWQyT3SA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WhXCcv7pxNRFEAG8ygp+P2I5ugNy4MEZz0hzR4J4cr22xr3d
	eUyV2oxK6xwQGbJUnKUBwWTLS6Inr5zEe1AXVEq9CNY+rQgxKxkcnCIHxlkcFiS8b+WwgazPBuZ
	FNKomAyjsHfNAXlWgNxBZQpOgs4Wik3aeOZ3QnrpGm6hwEL1Y5CXoi7owm/6i+bYcROq66e0y45
	AxEADa/0hQJSGjPE5q2KbAlTUVkG8CzKsLrgEYZTHUbayDdKO65Jv5ct0epWoOHp61HUab1dYZC
	cvBCz2mZMdpirT/bLP9GXsNk37i
X-Gm-Gg: ASbGncvsTyibsnbp/1KfldM7OAGg7BKs5U8e8Glk2uWvDEs4WKp1mER1jybRgBsrV23
	hRVXaT7WuoVI01jXQDqPshcKjnSInvmw/6AtHh0Ia+VGTpEGGzmtn/0khSMZt+5HRj8y0+S+gep
	hNLQdTZwwt2n94f2jLHVTgqg3Dn1YzutWawUM4elTS7wWlN9lT02vBKQgPRV3nZJuY8gB1Rq0Rp
	exbF8ibAbsCloNlF5RuEJHw95zvaa2NJxgKa9ZilYQT9CDAms8R9zP2tCvIrbB/eaHIIPKyUwJk
	gVBRMVhMLrf8NvwbKY+vCvHymGQdj4TP0ENkRGVa7FA3ylADcBJLXinwmt6yAAp5b4PVjQ2gX3E
	922NIGTgJ1zESM6sPBOUg8DYNiObz4bPqNh7lwSArQRThYZC851uOU+O8DYRcpMf84dQKZR2RL1
	rXGsbWbD3A
X-Google-Smtp-Source: AGHT+IFsW9xAvCoDkMLiKiCJEFsDKMmTSpCfiy+BNQq0a9sghr95TC1jKvAlkjOuM7Dq5/JprmvxOOIYa4Nm
X-Received: by 2002:a05:6214:2344:b0:78d:fe76:bb57 with SMTP id 6a1803df08f44-79919dac7eemr39933926d6.36.1758304092065;
        Fri, 19 Sep 2025 10:48:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-793532b8435sm3680686d6.44.2025.09.19.10.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77ecac44d33so736230b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304091; x=1758908891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQdBnzkJ6XZr3h+JOYCkE5AzdDxHuHzROOLjBhUEp78=;
        b=cb0B4LaAJSnCsVHbCE5kEb4oPxkghDKbn83sQyBfJdnqOUdOroZcIqDrfnpodrT+CV
         aDFjT8rQF3EmxQFIySEKlGLfIkzBfz4xUgc7GyY9NoJEhWZ0bazRdrj64HvlaLIDIcP9
         YSiJIbIc4nOvBli9YZBg97KpAlSFJAU6IdvCU=
X-Forwarded-Encrypted: i=1; AJvYcCUzH0AkA+sGd2GbKPq1sAu4Flf+PGXxMhHSzK/ANEU9+jEOIHRb4UVPSehVfKsjXIr5IN4mhMtxC4BIAqY=@vger.kernel.org
X-Received: by 2002:a05:6a21:6d89:b0:249:824c:c61d with SMTP id adf61e73a8af0-2925b42019amr6693389637.17.1758304090755;
        Fri, 19 Sep 2025 10:48:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d89:b0:249:824c:c61d with SMTP id adf61e73a8af0-2925b42019amr6693367637.17.1758304090319;
        Fri, 19 Sep 2025 10:48:10 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:09 -0700 (PDT)
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
Subject: [v8, net-next 00/10] Add more functionality to BNGE 
Date: Fri, 19 Sep 2025 23:17:31 +0530
Message-ID: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
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

v7->v8
Addressed comments from Jakub Kicinski
    - Ensured buffer post fails when minimum fill level isn't met. 
      Few functions related to buffer posting got impacted and 
      their return type for error handling.

Addressed comments from Simon Horman:
    - Fixed lack of error return when memory allocation fails.
    - Fixed max_t(int, ...) usage by switching to max() for unsigned data.

Addressed comments from Alok Tiwari
    - Fixed type of the variable ring_type.
    - Made the netdev pointer access more direct.

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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2217 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  250 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    6 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    2 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   67 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3140 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


