Return-Path: <linux-kernel+bounces-840624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EAEBB4D76
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5783E426D02
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A44275AF2;
	Thu,  2 Oct 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQSeBeVC"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48748274658
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428408; cv=none; b=fv9Pzbdz+oK0TGAxOdhA5vMZiEGCRi1nPfEwWPeMrf6oTzrSGgBrrsAZ9ML61NALKusUHHI7VRC+Hitze2zLb5z7ahj/x8EkhMT87Y9x4WjTDu1AtMe4oe7o9zxZd7W0Q0Wxp7fPzLPYP4WhMXBt8XWrorhVWr8oDnpbDwJyjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428408; c=relaxed/simple;
	bh=0TvBx+bBoyxxks6of1f+mQcu0jvRrKaAXsF7UrPsagw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PnbiwyvbmTUCBm5WQMQf8VeBpoLxh8gTO4J6mA6/0jiSgV6WnbgVs8+c1LnfEWGKSpO3DKpQeeiu0KGlde9TjweDxpbDb4R/aAdJzmbM+ANxkd7agxcMKLbhecGPxni3o0SXuXHRcPD8xDBHygZC9mQeHW3slvTIBm5t442GluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQSeBeVC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78115430134so994291b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759428406; x=1760033206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaRlW9cRulPCQvMjfuOQg+XDpvDBCH22Dz56ia8tBLk=;
        b=MQSeBeVCQPEpQDmmZdCVyxTaZbD++Oiavks7RXVcU0gpxgWjXoI+l/Cg3pvhQTwjKD
         3INUtH+CHlf38nLbMW4iXU2407I0paJfsGwgoHyJs01wIsGh1cMEAaDOSmIT4jbK92q1
         H9lX4BtXO+FmSBUUtmDTkmJD3pcRTSC+yI/Re3i3CskzyYCzjn6hjzMiEMM8fsTXaYV1
         qrEO/iXQJ+RKI2J6ZID7EcjpRKW+u3BZouHlcgJomE7pEEgoYfphgaDnqRwdsMDhhprt
         p02wW1lkEmZY5QzMc5sqPrWLnvYNAPxzR6BjaN/7CbTRiz0h34hWjqxQSW7GuLPi2gpP
         OwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428406; x=1760033206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaRlW9cRulPCQvMjfuOQg+XDpvDBCH22Dz56ia8tBLk=;
        b=mt1cbWhDHvoGP9BP2nl4nl1nwEKltW+HFSmhOKtyU1s0RiJforRiHKVysa3JcPaIl0
         dM5VIg9FC2frmA5z6XGR+EHLEQm4VEobQUdtIUofaOdVpsV7CqtwLVcqr96auHVmOmg3
         GvCoYx3LU6E95o+qzY4QeN14hXRKaB7RG7BrvqB///QmSVZf1E0vWnUpnnwcqWpiwgjJ
         368h7DCWvn7EsGOfCqYCT64OT0U58yRH09Waz0+LxyUQYtrwMujeL1Tzq4IpFMsRBALk
         S72lP7TWEY28Bj6rd9B7D5JVg8pL6Q4coWDzHxskoHvI5XpSXAEoz6S7x1stRZG6k4bd
         /5wg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZJoL0Kkksn6biTyPKDFLsTgCZrubI/r1B2ceSuVwbp8CXX8PS32Dszg8bImV3xlZsJzPXd5Q23cgOjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwD7gKd4he54EfgoEA6QbSEQKZNSXwqb0uTaXDvT2QLfoeM1c
	BOxpDsTzAOTZrMC6IwKPxd+v1HkX8FWHyK2JPmX8nOFrKiqjQkDUSg27
X-Gm-Gg: ASbGncuuEEamxCVQEGFfVriZYBGvKbZrTvSjmbwQ359Ueb+Ydo+hXwicgr6w8TNtLol
	VjNoJYuwobY8xXKx7TceaHtgcnXckXu7k4qKQBCdfCGTGe+PYmd/m3RIP7OfZbEwKhnxQJ4ZihH
	QzB37Cd1BiPlOVTsdLEON7tqvOmVInab6s9pZzmKHXqHiq0MiTQyr9d/n+Fey6G1tDO5lF7CDwx
	JMZ+ZPk9W0NtIbyX78R95tmbXbk/JaXqtv+nRff7c8DsyG6tMoPG/Kzh/daUGM16r2z3rSL5eH7
	p3uNVZnixpwQw2pZkEeQztEOXJUzwuDIyhCDeOqiYPTX4X+Y4EAkSgpm7YQwCrOtfx6dWRTzpbB
	WkdLJ05QSPfSA5IEwWYho1cE+zeYq/U1KHhBfUzdXPJkdVQApxiYKrSbtNb1/A7zItiB/BLrHwS
	K8zhPlAWPY0kbfv9/BGsaG1Y+n3oxOfiO2HGo93BsWR/k/S86A6g==
X-Google-Smtp-Source: AGHT+IHbfrpRJoegzbMifEbArQe0pmEL/MKe7nEOBYzWsJyc2a7fn7nnLBoWsEfmGWDetHChWeFyqw==
X-Received: by 2002:a05:6a00:14d3:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-78c98cf1261mr679991b3a.32.1759428406466;
        Thu, 02 Oct 2025 11:06:46 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm2728075b3a.37.2025.10.02.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:06:45 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: khc@pm.waw.pl,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in ppp_cp_event logging
Date: Thu,  2 Oct 2025 18:05:41 +0000
Message-Id: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes warnings observed during compilation with -Wformat-overflow:

drivers/net/wan/hdlc_ppp.c: In function ‘ppp_cp_event’:
drivers/net/wan/hdlc_ppp.c:353:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wan/hdlc_ppp.c:342:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduce local variable `pname` and fallback to "unknown" if proto_name(pid)
returns NULL.

Fixes: 262858079afd ("Add linux-next specific files for 20250926")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/net/wan/hdlc_ppp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index 7496a2e9a282..f3b3fa8d46fd 100644
--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -339,7 +339,9 @@ static void ppp_cp_event(struct net_device *dev, u16 pid, u16 event, u8 code,
 		ppp_tx_cp(dev, pid, CP_CODE_REJ, ++ppp->seq, len, data);
 
 	if (old_state != OPENED && proto->state == OPENED) {
-		netdev_info(dev, "%s up\n", proto_name(pid));
+		const char *pname = proto_name(pid);
+
+		netdev_info(dev, "%s up\n", pname ? pname : "unknown");
 		if (pid == PID_LCP) {
 			netif_dormant_off(dev);
 			ppp_cp_event(dev, PID_IPCP, START, 0, 0, 0, NULL);
@@ -350,7 +352,9 @@ static void ppp_cp_event(struct net_device *dev, u16 pid, u16 event, u8 code,
 		}
 	}
 	if (old_state == OPENED && proto->state != OPENED) {
-		netdev_info(dev, "%s down\n", proto_name(pid));
+		const char *pname = proto_name(pid);
+
+		netdev_info(dev, "%s down\n", pname ? pname : "unknown");
 		if (pid == PID_LCP) {
 			netif_dormant_on(dev);
 			ppp_cp_event(dev, PID_IPCP, STOP, 0, 0, 0, NULL);
-- 
2.34.1


