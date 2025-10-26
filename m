Return-Path: <linux-kernel+bounces-870498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C8C0AF9B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB61189CF9C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F9438FA6;
	Sun, 26 Oct 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+/kNwB+"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800020B81B
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501308; cv=none; b=Jw35WhnGtTj1KwzRnuMk+hujhp/M0d0aI9/VpmrSyc1XMIg/zBVhPblOUgau9afQbYmijWPjnaIRylOFiEtFdKOOBimh++a5nSF5BJKCKp9h59gBgRd4/J/aj+7HdAwNaVUqumEdytKxGpA+rX6sObgxHePOmYihbIujna3ZLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501308; c=relaxed/simple;
	bh=wcVNI3+a/OZkRVcbPqxgDwyPv6jxzEQnw/ZSPShSkvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqrUvXFwFGdMQ7dc/2hl0yIPAGXZMzRJpcc4jM5sJNM9qTFqIQLRi66dKaBQPDYNXiG5Bl41ILIzkfYsJB/ByVAQ56GynhpshByimJxXJw1bLLx/gWSmI320TKWMsyR8IkYcqyMpD9YZsh5U/4uQ9OnJPzhg20rAXdLhl/Qev/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+/kNwB+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26d0fbe238bso27288255ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761501305; x=1762106105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XW+6TLqRRcphYWjvidG8sptD1TC75wuXLwHskXrfas8=;
        b=G+/kNwB+6xTngBnnOvUVhxY2IYlIv/wFyhb7qZHgscwstn6dUKW4upd+tnM++3fvao
         eZWaaTopHIn/wkAbIIH0HKAovmFzCTqpHZsx5ET+Gp/D4Z5CEAue+S4rLgcJBYbWPyfd
         hbHrHTk68kwy3nbEGpNXFQJT1Qitb+mQfoQqS6oeD69aw7okF3/JKxTqSFt9bIV+tA/G
         F/S42z2U4BZcW37GpbLntfonHobtycOBhqn3Q/4yxr0EyIHi2IMX6If5Lt6U66CAMJ48
         Wizy+O4XryYpwwNXvDVPBs/va2DlyQTvfD+COrI/dH8tgqMzuLyJzVrQh3Jy9ulou1bS
         lNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761501305; x=1762106105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XW+6TLqRRcphYWjvidG8sptD1TC75wuXLwHskXrfas8=;
        b=CS3v5c4QTPIgv13QS9PVA1D57V29CGYcqZJoIbnd1JQBlG4iCJPHwuqMZOj21pvybX
         2lUMruVSQ0itPTiRDn7PZWNDImEeBocIZsUDjfgCMbaOjoiUZibiVWjVXUCMycsJDXlN
         5388rvDhb7OTdXSHWTUKNIv23vHq3zTtDm0KiytLfTbligkAtto+uPEIEUnaO041O08G
         13JnXczcxUnzKSizon+4PvWWf0QD5ZXiUeYlBMzmftH6C/VJgxmAlWL8QpqMd+1Uwph6
         rBFak11W9IilsTelYhDjm/3Qi8IxcYKKLAk3Q3LoYRafyr4zbvEg2oj54RW6D394aXv8
         i6VA==
X-Forwarded-Encrypted: i=1; AJvYcCUc+CFiKdYRgodpETsc/p4BtBu5lzf/QOzbzPcaWjq8PcghuQ+y0Bri6LRPm/oBjgHTNbBPNWo7K9pvrC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyNRJ1jc2WkZ1+1quE/4WQZ6oNsYleAyJ6K1Vf+LQPBkbaYyVb
	ZMnk9k/iC5yJSjfAGFiYW/1cetSmwo7Ow80GRc4Td/7YwQXDGtKMWovc
X-Gm-Gg: ASbGnctEQOQMbVOBBpjdTazNj+3uDw5mOA6/aupimpvN3t+7p/6hWmb7OHLyxI+R7Uv
	PjgGyExiavxWVFkvP1QfK7xans71zlio+akJqABcsaWoTe79Q8R49pxNEOaV+NTA+1NEL25Jf6O
	zzuo836BxmEQY/P6F2XBYKVMO4ctSnagkh2GwEW42PQEbjkuhiVXOFF2SQqI08cVJuNHFVI+cUF
	RPSPdHLYPTg0+0/7ByD3y6mbhc8VZeL8oZLM9mdZBcr9EOBC5Cgi/Jy1Np1h8502851600Uef+G
	l5zMEzSXB6B1qshov/X3K1B9aKROSdi6BXJT3j+LvpkoSlpd4rAfXsbNNPpuTQwhWMBZxtikHld
	53MTzeS3yCqH8/lYOhp8yYcSH/tGwFI7hG3M8mnjrqb9s1tdVkdDUFqKV4gl2pIa061yIU6b/+k
	VxI0SXpOcjGPDTnTZEM9aTio7q1PoR4oxLJTqAm2jhOb7XjqVTF575N/HqXsIWj42X1/zyrg/pz
	Vfdfg==
X-Google-Smtp-Source: AGHT+IFr6d0VRylVsQquJ/FhyU5BSy8+T51ENiIhdQPVdDI89GUzWkH6pWfficRysWgAQfUU6r2+eA==
X-Received: by 2002:a17:902:da8f:b0:290:af0e:1183 with SMTP id d9443c01a7336-2948ba3ef7emr100193725ad.51.1761501304768;
        Sun, 26 Oct 2025 10:55:04 -0700 (PDT)
Received: from debian.domain.name ([223.181.110.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm54813845ad.107.2025.10.26.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:55:04 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC PATCH net-next v2 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Sun, 26 Oct 2025 23:24:43 +0530
Message-ID: <20251026175445.1519537-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

ndo_set_rx_mode is problematic because it cannot sleep.

To address this, this series proposes dividing existing set_rx_mode 
implementations into set_rx_mode and write_rx_config

The new set_rx_mode will be responsible for updating the rx_config
snapshot which will be used by ndo_write_rx_config to update the hardware

In brief, The callback implementations should look something like:

set_rx_mode():
    prepare_rx_config();
    update_snapshot();

write_rx_config():
    read_snapshot();
    do_io();

write_rx_config() is called from a work item making it sleepable 
during the do_io() section.

This model should work correctly if the following conditions hold:

1. write_rx_config should use the rx_config set by the most recent 
    call to set_rx_mode before its execution.

2. If a set_rx_mode call happens during execution of write_rx_config, 
    write_rx_config should be rescheduled.

3. All calls to modify rx_mode should pass through the set_rx_mode +
    schedule write_rx_config execution flow.

1 and 2 are guaranteed because of the properties of work queues

Drivers need to ensure 3

ndo_write_rx_config has been implemented for 8139cp driver as proof of 
concept

To use this model, a driver needs to implement the 
ndo_write_rx_config callback, have a member rx_config in 
the priv struct and replace all calls to set rx mode with 
schedule_and_set_rx_mode();

I Viswanath (2):
  net: Add ndo_write_rx_config and helper structs and functions:
  net: ethernet: Implement ndo_write_rx_config callback for the 8139cp
    driver

 drivers/net/ethernet/realtek/8139cp.c | 78 ++++++++++++++++-----------
 include/linux/netdevice.h             | 38 ++++++++++++-
 net/core/dev.c                        | 54 +++++++++++++++++--
 3 files changed, 132 insertions(+), 38 deletions(-)
---

v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
-- 
2.47.3


