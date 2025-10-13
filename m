Return-Path: <linux-kernel+bounces-851196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4523BD5BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B0893512DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB5A2D6E6F;
	Mon, 13 Oct 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL00o2NV"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDD296BDE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380727; cv=none; b=pw0esmWch4epUjdsiaHFvX57n2dYWKHXyTIYmIwj3NeesuDBHDc4jEsaDazfwjUW3Ddf1+TYrB6YfeBenx+nkoOMeBwI+K5+YR/TH95j4EJjhqc6Ua25CmQb0qxlL36D/on0zUO3pZxksPL+OTVj2h3MszXqS/2yxi9vEuuAtUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380727; c=relaxed/simple;
	bh=P61QujgN5J1u4jCGUyQaIH5x+Y70wA/Ujg5vNOBkB/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bA8LQ+zm8BS3Czwofjio5SJXQeS0vmN8rEym/fk+G6/pjilP36rnstH3s/CSiclj5OHL6kUgE90oLA2e31WPzYA7Jqg4GprfZucCKp/sbCcFwQjSTf/F2MHLgCinA2FsUeui7kjFWecJgB0Vj4MZoXVc0RZBFHQlQTN2zHISrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL00o2NV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so54271135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760380724; x=1760985524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl4UbYGPdAv3c9XGkZNC55N7RR52T7NEIW03HAfvHAo=;
        b=QL00o2NV47B8sNRBM8C4I+1k8+Szrd3k/Nag0UODfANePPVDKLJiAOjThENdxRSjpN
         p0AZd75hj9QIAYyHwnTSqRhMx7jQSdGH5PktvzCqUYEXu9SwPbankNfXAEuesDaYZ10u
         1PFDdFSLT2JLkleUP2/c1eMX2C4Dic/gxF8vjiiWLClzg4voGSLN3XeZSd5yamilc793
         OFDTlux1US+xHO+Gx9cTxNvyTxVnniAlUEYnewz9kFttLfJxf66pYGJZztlvDa7YhFq6
         SYLrb9eeAShWnJJvEgKphqiLdKlEV1AOAnpsAHKiPr2N5xUHApKaC0DtTc9Tv67l6VrC
         kqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380724; x=1760985524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xl4UbYGPdAv3c9XGkZNC55N7RR52T7NEIW03HAfvHAo=;
        b=bfFvHeTTm65Tklbtp2eMSnx+lQ3V8O5tTskczDPULy8uE7blon69VmkshbPCDqbtp8
         kjMnAU1T9WwlMyulS/IMLrQV7gub4dw6X0PnilJCTafOXvUvWywgesVwLJBuMOho9A6/
         oadwmGoANZZYT+Qc06jGfNx3Bm5MSh1dJbaKFWDYV4nr5zXTC5KUeUYhK/SC/B5bunex
         C+Tk4GmiwL3mF1DU8oz8JUKjfMZRccreIhnZ7BUnmvJt1xjHQpXunIsDKHr8uSDDBOq+
         SQYRwdfZovpGV7s0Gx7aQLn5AxphY++AUdZP6DQ8bZPlFBtM3Xlg2cjE0+pdNymHsd7K
         BWZw==
X-Gm-Message-State: AOJu0YzspnGUaQh41PEqjhXtPQLoGZgOSjZhM8XuUK5z+ahF5Afa+ahi
	slnFEBF0VScv90oAr4o2U4/IAviKs5qIkuGdHMb7HBLq0vH1/0azRUR8VmgIRxKY
X-Gm-Gg: ASbGncu5GhK56jILSN5lvbSjORKZ/USswHkjENP6Wx6arr/4G/09OLKVXXdoGItUEfZ
	8uOeM5bh+e+4EXf+SfKcAfwDR+7FJjTubzc/xxj2c0T3UkZ/eetbUEwl/7c08zb0LFIhFhVTk2b
	vtBx1ThA31NR2ymYutwNAhjjXIBf7IFjpdW8bCrixLBRSH+3MnMQ3gc1L2yX098MbVzlFW1ff0w
	bL7bN3Xn+m1LvMNl4ODQqe8XbruBGPquYLYnTVENZjsuDTdhVUh8NgRNjCYzQN2PN1Eu/f5Fkfa
	qujUkdOZaIoozO6yopQx/E9inpE3iilF3MpZFwBRCo8TIngGSKvXUNom4r6xiP/czATAyT4ix3V
	j+DMKBjG8uIKMV2OOpQjX8fIIjtPr9VXy8RtF67e0IJZyfg==
X-Google-Smtp-Source: AGHT+IH37/Iov3SsmBlSzbaKFTprmyioGsd1J9aFxMvYeqTg1z0+yrp2AQWWNizCw0MIJmwxhuvCrQ==
X-Received: by 2002:a05:600c:528b:b0:46e:5cb5:8ca5 with SMTP id 5b1f17b1804b1-46fa9b164edmr163770565e9.35.1760380724095;
        Mon, 13 Oct 2025 11:38:44 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426dac0ab7bsm10523024f8f.46.2025.10.13.11.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:38:43 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH net-next v2] eth: fealnx: fix typo in comments
Date: Mon, 13 Oct 2025 20:36:32 +0200
Message-ID: <20251013183632.1226627-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few typos in comments:
 - replace "avilable" with "available"
 - replace "mutlicast" with "multicast"

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
v2:
  - also fix "mutlicast"
  - tag for net-next
---
 drivers/net/ethernet/fealnx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index 6ac8547ef9b8..3c9961806f75 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -196,7 +196,7 @@ enum intr_status_bits {
 	ERI = 0x00000080,	/* receive early int */
 	CNTOVF = 0x00000040,	/* counter overflow */
 	RBU = 0x00000020,	/* receive buffer unavailable */
-	TBU = 0x00000010,	/* transmit buffer unavilable */
+	TBU = 0x00000010,	/* transmit buffer unavailable */
 	TI = 0x00000008,	/* transmit interrupt */
 	RI = 0x00000004,	/* receive interrupt */
 	RxErr = 0x00000002,	/* receive error */
@@ -215,7 +215,7 @@ enum rx_mode_bits {
 	CR_W_RXMODEMASK	= 0x000000e0,
 	CR_W_PROM	= 0x00000080,	/* promiscuous mode */
 	CR_W_AB		= 0x00000040,	/* accept broadcast */
-	CR_W_AM		= 0x00000020,	/* accept mutlicast */
+	CR_W_AM		= 0x00000020,	/* accept multicast */
 	CR_W_ARP	= 0x00000008,	/* receive runt pkt */
 	CR_W_ALP	= 0x00000004,	/* receive long pkt */
 	CR_W_SEP	= 0x00000002,	/* receive error pkt */
-- 
2.51.0


