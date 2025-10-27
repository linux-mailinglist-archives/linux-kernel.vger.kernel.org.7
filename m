Return-Path: <linux-kernel+bounces-871123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9056C0C78A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 317014F31AF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF262F99A6;
	Mon, 27 Oct 2025 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSCGd6xR"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5D2F2619
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554773; cv=none; b=uapF2iHIvq2v7E99f5uDEH1vy1qyJnhJmuWmcIOx3Rumw0R+04VenAyn5rNzsEtc1Y5RvflcQjioQjRz6ExydcqrKSfvVFlHqbUz0Zq1lVlS0fLnk2h7kMsopnS5VBCBfgHN2AvKgdFlTPb4g7QUsihh4ql7JYzG6ou/98hI8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554773; c=relaxed/simple;
	bh=RkWzqksqOOCiG+JB550mDEsdG3hi8TPtMt55nYOaonw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AF3I7nT0HxMQxok/+ANORibutsXgp69u5Yg0zyZ3TT9FyAHvRQ4sV/kFMhxpAQoTSdYZ6IE0tDgcvIZzJYosA9ynw6pX/IoeRLcZtLeL3c4Za/xdgaCLynCN0HhqP3SDcEA0zBJeGK0boFfc5fNcslQYkxIlJvt47sdwD/U64B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSCGd6xR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso3803926a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554771; x=1762159571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYXicRyMzFG54clHK8f3TeDGrtRhrioeKCXtreOKP9c=;
        b=cSCGd6xRCLNlzCZsjB0EvULQy8UCGcDzwKe+k7wTZOquKh0nZRd6xhI0Iag/KIR3zS
         va1LhcEv55U7OfuAjKQALeP3cIVvERgbk2HT74B+9za+gwtYFPvkh1aK1mWgly6ckyPn
         GE8FOFCPRQLXJxfoZ3IgPqE6laL51CJcFCnkeqjVYZj8CHzP6B4mA+8kcxOaIzMF0WRe
         CRKUM6/dzMQHTDTAHcCMQ1sa5t5xriqUJ39w+JgwZiz9LzFqb0Eds/7kxMGZhoI8JFWm
         DkiiJ1cIpUsdUuWFYtj+qMF270ndo1GZx3MSwrD5ZnGflAFqdd+hRlleKUKXRWcpyvoy
         4xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554771; x=1762159571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYXicRyMzFG54clHK8f3TeDGrtRhrioeKCXtreOKP9c=;
        b=mXJp/UstW9evGDrI6nrDiBCalMe3h+80/qqo6ViXLBUK9d32fooKd944Iw5gB5o5vw
         hduXQY2D1UCoa/Bwh7XpaejdFZ+hAOdIPHZoJNEbDejehbnYGPYgWwByelRLbLYbDxeh
         tTi46eT7F+lQK1TpbKQbzDI2qJVNHS7i3lN5CNV5F/WpQEOGbqPVVL5Po/ITcaFveAAg
         nlSOVj44ywY+8hzVNpvc6aBBJ93oi9AoRQW56OTSPqaOljIr3Qj6+WNnnpLisAkMGVyn
         DTgpixhwK2Xj7o8Uuk4FXIuAvPVC0w34K8BHV+PUGh3MJBaaGBT+63MngSG06IgXd7d5
         QI5A==
X-Forwarded-Encrypted: i=1; AJvYcCUXsRc6sp1QoMyrwExh+ITAXVHn/MpHrzAi+6vRFtLcILLFjGbDW6ocks4Z2P8leKeb8/4FTRLat5N/fCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMbnFp9yUIKqdfJMcoh8G3bpBcgn3hhK6fbeeiC8S0HljHW38r
	fxMSWNJa/6oGNuyozRJKpmcIu2NadjqIQKu6YPtrBlmJMLZ3HDNx9Xne
X-Gm-Gg: ASbGnct1N1fUOdRmjeb6i6PaETjJv1MLEgXLIyORVhWOkT+6MSCAeinVtGfUjsig/Rn
	z3Sz3YnlR5Sn9T9MMwccieambX7EAkjXsvnR8K1XPHx0F9slWx9O21Vm0DIO+qnqe5NkLbVAwGH
	0Ca0WyAsMwj08Cwgwk2u8pxgHiLOXzH4jPGqH4U0m3c7dR9a7GKZ1x5xJJ7omu2QRUdA/mEuj/5
	dXj5UJULF9ZObQghehb2Dm5aEpxxng4BDkUuAM2SpdiPJ4p5wDJ82UZw/oIQnAdAqcicSZwdt9M
	GBpnhTIemwkLHhwY7yBG09vUAP/JGXyypYr+4WvzZMefOwp85+sfB1JIw5yg9WInoHAYKu+yNEi
	wndZl3YcEdYfhSNZLIaW971BVZ5f7mze2KIg0S/WEcZ6aqI2N354cOuMPO58pM1Ku7x8YP3zB5K
	yqbVB4nRPfYJiZFOR1/kauBmdVvY+oERFK
X-Google-Smtp-Source: AGHT+IFtc9o9JCh/bKZQgDfAtOs/Qjpo1vXU+pF6273boM1sbWl2NHlxbrCZc5bY8n8bBNjS0zBNHg==
X-Received: by 2002:a17:90b:55cf:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-33bcf874448mr42762102a91.15.1761554771534;
        Mon, 27 Oct 2025 01:46:11 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed7d27b2sm7703951a91.4.2025.10.27.01.46.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 01:46:11 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/powermac: Fix reference count leak in i2c probe functions
Date: Mon, 27 Oct 2025 16:45:53 +0800
Message-Id: <20251027084556.80287-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_find_node_by_name() function returns a device tree node with its
reference count incremented. The caller is responsible for calling
of_node_put() to release this reference when done.

Fixes: 730745a5c450 ("[PATCH] 1/5 powerpc: Rework PowerMac i2c part 1")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 02474e27df9b..f04dbb93bbfa 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -802,8 +802,10 @@ static void __init pmu_i2c_probe(void)
 	for (channel = 1; channel <= 2; channel++) {
 		sz = sizeof(struct pmac_i2c_bus) + sizeof(struct adb_request);
 		bus = kzalloc(sz, GFP_KERNEL);
-		if (bus == NULL)
+		if (bus == NULL) {
+			of_node_put(busnode);
 			return;
+		}
 
 		bus->controller = busnode;
 		bus->busnode = busnode;
@@ -928,6 +930,7 @@ static void __init smu_i2c_probe(void)
 		bus = kzalloc(sz, GFP_KERNEL);
 		if (bus == NULL) {
 			of_node_put(busnode);
+			of_node_put(controller);
 			return;
 		}
 
-- 
2.39.5 (Apple Git-154)


