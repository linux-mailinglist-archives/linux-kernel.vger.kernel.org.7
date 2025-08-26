Return-Path: <linux-kernel+bounces-786529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D972B35B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFA61B673B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85E2BF00B;
	Tue, 26 Aug 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VfuSUeDJ"
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CEC29D26A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207047; cv=none; b=DGPKW+UgkpMI2zG5qaK2TK5UNR6CyCa3xLvW60vOirLgEueggigNQpYTgSwVN+hHUoltuKCOKNu2ZO7F+7U0FCHe4lTELMyU1mm/CuIsR18oUiyvlILDiNc0Xz/bTwfJvU4wJtE0M7OoJgUxYhz9U/qL8xt0ut7SVudAD8W1Et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207047; c=relaxed/simple;
	bh=riu+ZSSqC6hnX6c1iN4rk9AnA541mpnUr1tMc7KEwTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8w9UUY6S2UW1k7SmCaY+l7TMxTzH7KAMo7HU6x+SfE5zlX8CjEf02T2fTEYP7WS5dFVroCczxpFtBgxIfBdiL1sL1074s7WUmMm6fCrSxcJgtNvUa0eQGezxjk8jhT6xksQag/fPqPnNSgsW+Ca7EjGMa69e2ikvVTfQ2ayLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VfuSUeDJ; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-74382002fa6so2556962a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207045; x=1756811845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CPe9YQYoyEyzdF9vEiVB1Om4V8Yg6wNSz6wAP+t5EA=;
        b=Av5n2Qat9IH2fNk9MfCIMz+z2g+uee9BqY+sF8VOG63tZH1dmTq1GiZm0LLlFvmgw3
         vzmoFFE/y7qMW3t39E9ARNUyh2aTH3YTayys4TOBG8QM6SkHemrzKZMuUAYH9VBCEc6y
         KylfHKzT/dU7BlKDdYVKha9dWa15JKF+FL6lcWi/fQXFTZRGq0lKbqs+ltlpiILgXdnK
         h8KN0k6wSSkdwcFzMk/ljq5p5euKRcOnZJkiXh6Y7Cg1T66K4th7mLQf0tDwu84eBoCv
         c3/UW2GYzlwgbg0xCv8HZKznmlmheHu+NtRcijL8Ogn10BaphD3wT/RVm2EQfUpFUZUk
         uhSg==
X-Forwarded-Encrypted: i=1; AJvYcCU/HZdaBoUsYfjAw4l+79HythYm9nEhDI07OqFsHdb1HKLAvNB3UUxSjcS/DdmY0QY0rt3ovrsjy0TCOHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUTBXaG5Past+LFmejKWmcTFWRil/TPvttcpWp3Q+sdc+ZGr0
	xfkJQT6EBvJkorcyqMPeClzfio/SheD6ituU0eiNDookDz1rGKPvulk26uGyfNonW+qHJJ9Ra1l
	vC7owO+bjsqNzQD9/QKEOLm1BUsktTkAYX9BNyQV6LHh7W7YM1qWCcUNOZlt/Tkk7iHb53eGASQ
	3+fQkjCHXhPHv1HPFxuJuKnWN7dH7W0+x8O/LqIAf4cUqJ9Q6jGdY20i8DWG3S2Lm5ixkExMVZm
	F8OSwd+KzVH5x88HjBEAtlf7YLK
X-Gm-Gg: ASbGnctOA6Ka+aAuYqwnP9O1i2Npgh44/yJSkT66gB6L9sR/26fTrr5aSXFHrJtuLPt
	xjoaA/E3fUKF2DHjtV4vg74OxN6hbcAYhM7ESe5qiJmgC1JNQ7DQWt3Vfyye8klCTrP1D+6/BCz
	SJtMpirAgl9ZooGuUDBs13hhWF0aP+MF7HeKlJaDP4rxLhLZVk7muadb8/Zk8WDeQEy36SJQ5eP
	yIo1vag57UGYMwaBurN3wkgHsHVX8CkquS/Kq1VhdCY/Dj284IzP8Jk0kMw8q4a+WDjz5BsxVUj
	p53BcU6XDSfgV9XtzJaMOGzVj93hE+YO6uXxRvwvohlAWa4gmOrGB6WL0pjO/pQiWu9xl5P9lkW
	zhHyPLTPRkv1KArQmuV5HV5QhrXNLjw==
X-Google-Smtp-Source: AGHT+IHf1lJQ2ucb8AvteCLCy+wsfocqFPVt22ABgIjlzJcSl7AQyY1t7LZrzRp0S11FoXiH67r+MYPX2Udz
X-Received: by 2002:a05:6830:630c:b0:73e:5e27:8817 with SMTP id 46e09a7af769-7450099b7c4mr7623483a34.14.1756207044800;
        Tue, 26 Aug 2025 04:17:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-61dc792c66esm645886eaf.15.2025.08.26.04.17.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:17:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-771e7d00fd4so2609102b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756207043; x=1756811843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2CPe9YQYoyEyzdF9vEiVB1Om4V8Yg6wNSz6wAP+t5EA=;
        b=VfuSUeDJZE9Y5DUFFRXSbnSr5CIWb0o0ZZKim7oaCmJvtCl3oxxJi06ydVXpWUH+Vs
         x25yLnJ08l35O007LwLT4zYEleUpnu5q7av7nSvtf2IpI3wAD4bGXF5d+350ETfdrsCg
         3YBEb4sDEhJBTzui8wH+pl+U3mXT/DUnFlhLU=
X-Forwarded-Encrypted: i=1; AJvYcCUSfDZmZuBUfPu2cOUBd8c/47k9EytzfwFaI2I2GAxKy4lHu7PyRlJDEnRswoUtReIh1UXECso3t8752Mo=@vger.kernel.org
X-Received: by 2002:a05:6a00:990:b0:736:a8db:93b4 with SMTP id d2e1a72fcca58-7702f9d24d5mr18463611b3a.2.1756207043215;
        Tue, 26 Aug 2025 04:17:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:990:b0:736:a8db:93b4 with SMTP id d2e1a72fcca58-7702f9d24d5mr18463583b3a.2.1756207042787;
        Tue, 26 Aug 2025 04:17:22 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm7280339b3a.41.2025.08.26.04.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:17:22 -0700 (PDT)
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
Subject: [v4, net-next 0/9] Add more functionality to BNGE
Date: Tue, 26 Aug 2025 16:44:03 +0000
Message-ID: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2202 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  252 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3122 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


