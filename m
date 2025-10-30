Return-Path: <linux-kernel+bounces-877561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D49C1E6F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F671894DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C529617D;
	Thu, 30 Oct 2025 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB2M4pOf"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BE1E008B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802472; cv=none; b=mqrVXqi/addzdB1qq3hasWB2ezXqeIrebAGomS3Vt2PUKL6ruqIEC9tz1rsQeJCAxJbiN3Pt0bUOPkMl06ZJttn33r+nWHXK9luNGN9IzqVqJuoII5B0Oaacv2h2ML7IZ09fFYgX+hgrEsVCtGJ99ccVYmEOx3+r91x7/PYnFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802472; c=relaxed/simple;
	bh=NTNQiMekt27MGuwOcDMw9rk0PNy2ygsDrUNNQVYYVdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AgmmjuLHoSMnPb+xClSQUKJZL6143JS6fNsVNnaE/Z1UVUoKG0Gjwl+uR55slrS/QrfW5rQ9V+YSrx1EtZRbsPVapT14GJHSnQAk2vIRgEabyE2DAaTZOlK2xGa/pUYbw81i6F5aikrs4KCwlOnK7FTKdbkEWmaL9hhn6DUHrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB2M4pOf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso1278563a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761802470; x=1762407270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bXDn90536GRiT2FSB8MvXk81JvmC27CutOSkqb6Hxc=;
        b=cB2M4pOfpgSXw6gXxmxL8SWTnluwBSBVaRO4WAKwO6ykQsiDxAvTVNPap0hL6MskL2
         x2rxHKCbNwCjhDxlEu2TuEVBlcTfV4RMkHGprnOkJchlnSfojeb5Natx1corT1M/LlJn
         2YI5YhL0QgunaQEkhJbYah0fEMKgYpT8mwrp6WtN1qSgvdc62Vkyo2P0Gw9NrI/dBjKJ
         uQo77PbBm7bxVOiR6UvkKiJuchf4zbVj5Yr7w8FDkyS/+oFI7cpO/ngMqJH+4yIfTwSZ
         Tr0h/3rd7OEq93SQ8fko2b+6DDc6aiMSSAXeiYYZ/sYprBVuR7DU7uzeAodFkNyopPtA
         Lg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761802470; x=1762407270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bXDn90536GRiT2FSB8MvXk81JvmC27CutOSkqb6Hxc=;
        b=bctmT5lYAOOGgpCMNubXJp7NmIPdwcfi170KNnkTXQlTtkjZG1v2bIoi/ZYVASx4T1
         D9E1rq5VSkVOUfuT1tbb/c+f5fTuKrj/dphqcUipscaUwoShuywQD8Dt72uPPt951z3i
         CgC38Fd9vm6zSP748Ok0To/jzC3N67rySZNwJgEse8fqHuAMkHbvSgtDEcKDAKmi2P8T
         yH5Wd4qBIBcAZIrYhtOhwQs8KTvjBY2uBlHFFPCttapp2TV2kswCL4D0P+0giRhzetIZ
         jXY+qpluav4DOW0HNmDBnUzSwpGpRuUTyp1bKijbLsbQcYH+Bl9gnmLpgQMty6H9M2zu
         l9cA==
X-Forwarded-Encrypted: i=1; AJvYcCXLRxWMWVGpG7fy0XTBOn4vLSefn6Rs7GCQDlxsMWMiSpL79HX0wYZUmxphVaAnuqSiQ75jfrL/amSazrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+eXF2vxWS0y0f2mnberPZkX4McClF67Xw1QYHTbW04Xec9r0
	ACw/B5sc9Qw9hfm02k4dTi++KcKxkOwm7MQe6vvAjN8XiE+zoiOyTK6bR8jLb97fp+YmVg==
X-Gm-Gg: ASbGncvOg+ub+VzNBQ4Hez+vwFXyjdPh40KVyIxAfN9dAZhE6Q1Zy9jJQkQ5Xh3qbwu
	L4iUjVunoetoznHlWReeTAkke25s/VHhVnp/FCnF0POjfXyO6FNC4GanbP/Z6EFhxl0p4MzC0LV
	vJBWcspzWGFID/ZALsbOFey83nJpECDxzckwO6moAqfIAU7Qn6yVHJh2QYbxUpxfGZoif/t6Aav
	dvR/ebNNunZRFR1JDhpGOq5nASDbkWFqa05JA6TDygphaWwNVsTcUQDyTny63EEkxJXYM0/FWeM
	D8NmtIKZDOsUEOLbvfYEhCu9c97STCYVL2Ex/IUXh1G1hpU0+fjWskySmB/LnsV57xDXEzzOOIh
	3YQ7HAsvXyfEbJHNtSEEmH/K9vhR1jRJB0KxxeItZlons6jGXRm75LgSoHT5fwOL2zuBBxOudKN
	klKNtralNMFbfq+rrdbgJQmQ==
X-Google-Smtp-Source: AGHT+IHQSoEeyg7TPbHVX/naAJ4cljI3iJJFCjsar0UsVAbSVgztH3Vp8TrcvbDMPwYpGQRddkd2rQ==
X-Received: by 2002:a17:903:190d:b0:267:8049:7c87 with SMTP id d9443c01a7336-294ed08da86mr25707525ad.14.1761802470013;
        Wed, 29 Oct 2025 22:34:30 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d40a73sm174659995ad.74.2025.10.29.22.34.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 22:34:29 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] bna: prevent bad user input in bnad_debugfs_write_regrd()
Date: Thu, 30 Oct 2025 13:34:10 +0800
Message-Id: <20251030053411.710-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious user could pass an arbitrarily bad value
to memdup_user_nul(), potentially causing kernel crash.

This follows the same pattern as commit ee76746387f6
("netdevsim: prevent bad user input in nsim_dev_health_break_write()")
and commit 7ef4c19d245f
("smackfs: restrict bytes count in smackfs write functions")

Found via static analysis and code review.

Fixes: d0e6a8064c42 ("bna: use memdup_user to copy userspace buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 8f0972e6737c..ad33ab1d266d 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -311,6 +311,9 @@ bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
+	if (nbytes == 0 || nbytes > PAGE_SIZE)
+		return -EINVAL;
+
 	/* Copy the user space buf */
 	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
-- 
2.39.5 (Apple Git-154)


