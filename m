Return-Path: <linux-kernel+bounces-858297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C4ABE9DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7119358620E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5143570BF;
	Fri, 17 Oct 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LagN8xJN"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025232C931
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714378; cv=none; b=gLi0zjQeICSJADwQLqEdWgehjjFo/R9nkWL0FopYREzKrdXXaw1dB6QqN5qEIFqOX3m41S3IywG3zp1dyi+iLCd32XUKdJDtRc4B7F/dLsqGWlopFrangA0CD/sbNciHijUBaEjyZghDij3x5kRqWnFXjWm9tt/TMSCjItIwU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714378; c=relaxed/simple;
	bh=30hY9VGZfgPtebi29fjNHxTGYZKsq/orJOz7VuvML8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNqnOL26VM5KCB29MWeBOeqW5zDGk4215Z0S2TTmzUQQFbNbnE+OX22sloejVB1fmhcyRKyt4rtFkvBRDhvrXC5q6F+kRkZGdakNURyR/MEzFhF9hyqsGLVpIYVPLrwtvFRx1tDNpkXnI9VBwDYJj2J3FDLRQaZELhMddUA3o/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LagN8xJN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-273a0aeed57so40957825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760714376; x=1761319176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7I2zMxiqw9nCosgHfAG52KOx4TPHBq8RCQsUTlA/+E=;
        b=LagN8xJN898QlM/NaatEe3nqw8GLr2aFGZf0fyZx4rGbkvUSemCzrNSl1rl4eMUT76
         IAoYJTV+SpVh/ZEcVAu2dcp90yppUM+XnsfF97ef1zE2Kz7ykzuMTXaeMM1VFAMriu6Q
         EfcvlPwXXzzXuZyEHL5kgUYHcRK72X/T7MLaGFOoiQWRHzg4num4E3bOBn4BL89uNvai
         MsyjU32JZ9Mot8CX7LnJgKL6eK5RQJeIgqizWY/Lr6s4qg/Fa6TQEDuKUvKgYjeRVjxK
         rgmh7mkPeKcQ4EVxhXEv7gpOWvIkkAet+hlvVD6GVfL8MdtL9zpxdP/khBUcr8oXGXNM
         ZTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714376; x=1761319176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7I2zMxiqw9nCosgHfAG52KOx4TPHBq8RCQsUTlA/+E=;
        b=Gi1hr/7UTKWgJNeOxqzT108hqvyLh5tcTHnDbDWBhpd+qisqEKfGve7UIPEd0OgSvQ
         YWADAM5lrEAP7WiInyDB/kN+ElDJ1mVOf9diTsonlhoquW7S/nA7jFO9TBCUJvwtBwfu
         80kQ42513uZ9P1YQz4yvwXft/zXO4ulJl2Rz877WzMvcQS8W8w1zSBgJlLYSza1pBcnS
         39bEImndoa4GwaW2f6IxExXGLLTm2zGHdKYMlprH+lZOcxny9MJQumTFl+8ZSw4RF2rQ
         3jFSixnWuKlnF+FeOvH6WekdLtV+W2n4LdfALyCmUgZDAVy+kYKkK8ESVL4j3CjnTROV
         wbrA==
X-Forwarded-Encrypted: i=1; AJvYcCVVt1qdJ/+tqrW9844S/wjbTWbdPux2szsLF/Os+wPLO9wfU9QL8KVPBSlMtZxZfpdolqd4Cjz6lXYMYzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUx9OgtwuebBCEvbXUs2s0ti4Dldcki9w0t0KahONnB+Mctn0
	nJInuyt1KvckbS2FjdFooYDpv6Du6Iwz4lkwjudnJ0RI+yjtP5Mo+U97
X-Gm-Gg: ASbGncs+7B3CBLOqOEoeb32Cr7mQDYzi5Cv5RjZX05/ZpVI8kMkyk8YYPgErJdAt31r
	jG9sGwUiAzeMNzsylnkb6tTgLv0mXlfEjFX0MkdyBi/ducnm4nmay1OWnBxNJypdv8FFBnh4IZQ
	x5dBMIYXT0EeDP3ALL3o5Xlo2ETfBeWjfw7/VMzXf4rTr4FzZdwXNJhq526D7Xhu622+nQGTefH
	rAPeZqZ0qzJGQe1uVafu6mr8Q+Bc57YpNUoP2aOCrFIvsmrLVFF06dd4kkxTZhN5WJiX1rPgfNw
	VKmNBXdnwguz7kZDm0+KCwblqcAAQTpFJh/qIcpZcmsZJIR7B7VjvJkw7gokU7wJSPjpPalrpMN
	wdiy+4l1tgVkBWg9NN+xMrnbwu7PJFet5M/fyj9f5gJMdWQf0pg5x3OuTFhfFF6pe1lsrSifJiz
	ecXfxY5wGolE32GDQCRdMgVt74vYqE+61n
X-Google-Smtp-Source: AGHT+IH0+48acCb/GQWZoQcUE6viuTtTcLkvy8Fj+MMDiu+Sba/GIsfY/hul5gd1I7tvE0KgRk6MoA==
X-Received: by 2002:a17:903:24f:b0:279:373b:407f with SMTP id d9443c01a7336-290918cbe15mr103570215ad.5.1760714376203;
        Fri, 17 Oct 2025 08:19:36 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:fdc9:5e8f:28db:7f80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a756sm67193955ad.14.2025.10.17.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:19:35 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] net: ravb: Enforce descriptor type ordering
Date: Fri, 17 Oct 2025 16:18:29 +0100
Message-ID: <20251017151830.171062-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Ensure the TX descriptor type fields are published in a safe order so the
DMA engine never begins processing a descriptor chain before all descriptor
fields are fully initialised.

For multi-descriptor transmits the driver writes DT_FEND into the last
descriptor and DT_FSTART into the first. The DMA engine begins processing
when it observes DT_FSTART. Move the dma_wmb() barrier so it executes
immediately after DT_FEND and immediately before writing DT_FSTART
(and before DT_FSINGLE in the single-descriptor case). This guarantees
that all prior CPU writes to the descriptor memory are visible to the
device before DT_FSTART is seen.

This avoids a situation where compiler/CPU reordering could publish
DT_FSTART ahead of DT_FEND or other descriptor fields, allowing the DMA to
start on a partially initialised chain and causing corrupted transmissions
or TX timeouts. Such a failure was observed on RZ/G2L with an RT kernel as
transmit queue timeouts and device resets.

Fixes: 2f45d1902acf ("ravb: minimize TX data copying")
Cc: stable@vger.kernel.org
Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Reflowed the code and updated the comment to clarify the ordering
  requirements.
- Updated commit message.
- Split up adding memory barrier change before ringing doorbell
  into a separate patch.
---
 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a200e205825a..0e40001f64b4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2211,13 +2211,25 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 		skb_tx_timestamp(skb);
 	}
-	/* Descriptor type must be set after all the above writes */
-	dma_wmb();
+
 	if (num_tx_desc > 1) {
 		desc->die_dt = DT_FEND;
 		desc--;
+		/* When using multi-descriptors, DT_FEND needs to get written
+		 * before DT_FSTART, but the compiler may reorder the memory
+		 * writes in an attempt to optimize the code.
+		 * Use a dma_wmb() barrier to make sure DT_FEND and DT_FSTART
+		 * are written exactly in the order shown in the code.
+		 * This is particularly important for cases where the DMA engine
+		 * is already running when we are running this code. If the DMA
+		 * sees DT_FSTART without the corresponding DT_FEND it will enter
+		 * an error condition.
+		 */
+		dma_wmb();
 		desc->die_dt = DT_FSTART;
 	} else {
+		/* Descriptor type must be set after all the above writes */
+		dma_wmb();
 		desc->die_dt = DT_FSINGLE;
 	}
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
-- 
2.43.0


