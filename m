Return-Path: <linux-kernel+bounces-833949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D5BBA3647
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB253B012C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755C2F3C0D;
	Fri, 26 Sep 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXoy3eNw"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778526CE1A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883795; cv=none; b=um+dQL5Mrt9v/OJ/TVv6AV5p9arYi0PCWIQOB6QHJ+vES0ZMGlJnxaYXnDzhFmjdjkvuMYluGcRc3bLbmkm9TRrWoH6XmQaZtAyLkX5zaLgPtsuz5Cd35j82n/fjKII5o66vt5vziqlAIRy2aEP+pmd1J8MhMfP65qeRyvl66n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883795; c=relaxed/simple;
	bh=B9mVRBnVQVHHuU5i/JXW6OOSeasGzXnGqCJ1qEWL8Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5u8Zs16Hy2R5WWAgBQpC9xrAkGYjsFGrTYZH/wXlm/IzFub1kbb/iQ7bO99m05lClqdFn6iY2JVOQyUZMDiTe8TQno3DSqMZHIqranMQtjZ/vt87alf2LGXWrXAie0/53KG3XqfyyE2ORR3+I/atjE/c2ITywPwGvWVrWI5ISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXoy3eNw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b57d93ae3b0so645220a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758883793; x=1759488593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xiu+FDDItLuHlZJZJZE6peZ9lOx4+vSWvOYzm5iBrqg=;
        b=CXoy3eNwY+m3xFQSVtbTdxWZYOdx5u1RH7BUUhuOdBX7GbcHZ6y+mjh+fGQ7uWATBg
         9002ifGyX8EZ865mMqlQznbP3uWURG5c6eWESPy5sAl9UtWKq/68QoXXMNevss3liiu4
         qw/4Gw0Ts+Xm5vyd5h4dPKInaXssTxT2YW9hzKPl6XFRTqi4mSfWSje2M2j0/bbjWLu6
         hRrFCQUYs2BqI7UcP4AaUZ0cbkuOScxRFcMBxK3dve7m86Y17ArZ9t+YWmIs+PMEJeMJ
         fjCidtHtZrzOw9MtF3HhPR+zR/Ph2woI/qviVWhrcc4Ihv9MDHtJLvmUYKUpd0VTE9Db
         a3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758883793; x=1759488593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xiu+FDDItLuHlZJZJZE6peZ9lOx4+vSWvOYzm5iBrqg=;
        b=oVaJEQezxrY7GWqKNiPyEUddR773XS05YVHSazaWCtBjkAt6cnqdYBv6ZuxVHNzPTZ
         T7lm8zE9037uatiAbdw5AEM+mEMfYGesrDCAn0DkvILRF+0b8dzSQE0xwRx9AYoHlHTM
         pUKZKpsYJoA+5OgEbF38u9JSySDQMqwgxZPRAkHmoktlitH9IVaKsa/tFxRv0gk+duDj
         6PkJ8DPKrKmifvTwpSRXlKWnkYg+V7n5Alr3mKV+c2cCxV37QEpt2YjnZeyfyfLDcON7
         xDhHs9W5CzZbg/BoZW0U3cJN0/+i2SLp2pRMNjqTyi4Jw2TeCeD7F+jy8cPLGlvmhQqD
         hAHw==
X-Forwarded-Encrypted: i=1; AJvYcCUK3mVjktPal5X3DdPVNhHI5S8lFy8YMv+iPdK+1qdBukY8s8x+J2oQORwbpr6vKfueu6uZWwKWJsqYU3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXX3WET3oNoBympzzI89JCRb4hDmHLTiM+SOZA8/ADeSIdSK1
	IWienwHLRlTyd5sDqI58GhD7B8q+J7EtJwI7es4sVYIRvyS4RdL7a/sV
X-Gm-Gg: ASbGncu699qPDHt7PBK3iSI1YwSUrRsfz35jTTRTpQHcwYmZyMe0FnYFY7F8CfqvcWp
	qnXZZrFMlwB2fBXyu0wvEqAto1AZn4iX29xNFSk9P7ubO0pgxK9h4l7OU6xTZ9kjs/cMClBCsgj
	PDejCCSKS8uPdnfaci7EKTIy7EMOD5NyRf5eR3g1pEo4+WfytkPXQnIfZGGwHENpUFiRrmu3pzp
	lGbS2Jiu1aBq5NipL3WBR1ik/1cZf6592iqtaXYR0TVzYZJzy3rSrj6XFaPvVXBfMVBieuXyM+Z
	nLns7JfmbBbONj92U6rAQTSBw+kELWuJjYgac8nThoP7I7JIjHrM7fOsucZQyTgDx9EZ1YIw5em
	DtxNvXZMnuoTXK/HdRA==
X-Google-Smtp-Source: AGHT+IFiRN97whwAzqHmwPtTB+CzzgbkrvOHlXC8SosAv1OI3C0LaGR5vlCT4kKYthKy68V84nyixQ==
X-Received: by 2002:a17:903:1a2d:b0:25a:24f2:af00 with SMTP id d9443c01a7336-27ed4a06c8fmr74076905ad.12.1758883793458;
        Fri, 26 Sep 2025 03:49:53 -0700 (PDT)
Received: from lgs.. ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d6523sm50595195ad.11.2025.09.26.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:49:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wan: hd64572: validate RX length before skb allocation and copy
Date: Fri, 26 Sep 2025 18:49:41 +0800
Message-ID: <20250926104941.1990062-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver trusts the RX descriptor length and uses it directly for
dev_alloc_skb(), memcpy_fromio(), and skb_put() without any bounds
checking. If the descriptor gets corrupted or otherwise contains an
invalid value, this can lead to an excessive allocation or reading
past the per-buffer limit programmed by the driver.

Validate 'len' read from the descriptor and drop the frame if it is
zero or greater than HDLC_MAX_MRU. The driver programs BFLL to
HDLC_MAX_MRU for RX buffers, so this is the correct upper bound.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wan/hd64572.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wan/hd64572.c b/drivers/net/wan/hd64572.c
index 534369ffe5de..6327204e3c02 100644
--- a/drivers/net/wan/hd64572.c
+++ b/drivers/net/wan/hd64572.c
@@ -199,6 +199,12 @@ static inline void sca_rx(card_t *card, port_t *port, pkt_desc __iomem *desc,
 	u32 buff;
 
 	len = readw(&desc->len);
+
+	if (unlikely(!len || len > HDLC_MAX_MRU)) {
+		dev->stats.rx_length_errors++;
+		return;
+	}
+
 	skb = dev_alloc_skb(len);
 	if (!skb) {
 		dev->stats.rx_dropped++;
-- 
2.43.0


