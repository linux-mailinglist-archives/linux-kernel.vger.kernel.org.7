Return-Path: <linux-kernel+bounces-858298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43661BE9DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED6255695AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6944D36CDEA;
	Fri, 17 Oct 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNOIULam"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0D32C94B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714394; cv=none; b=gn0WPMQQuVVI1hkYKmPTzixIVl0NZHRkvl2bJqs/qI1I4P6NEC8N2YNRPcsL5oQcTRK+Mn1b2pCYmnENDUXHElqXvCWGT1nyj4QqlYec7vgk1UF6dp4TRDTfAH/f3yxveq/QpmkSzeKu7uOnV3Zz1rcpt11dZTa5hVn79A8tEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714394; c=relaxed/simple;
	bh=7Ap1yiV2IvW5TscRyVekKp/pYADoMM25JQW9IdJTVB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1HH8vRW/v8Y3N2nJ+gG99ppSfGnf0H7qdtKU70ZlSLl2ai9fMH8NFJHliZPDzfwGBx8NqCvihtPm+9eLJ/IWp8BakBlrcNWuLo4SYgwy4++lpx8gJd1vu30GEz7Tcavj1Gr1y3w4aWPCrDkSRrLEjBKL2PfeMj2P6+qizacgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNOIULam; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1496789a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760714392; x=1761319192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXVefTb39Nse0uy+Bbk9GELviGijLUlE6DvoOutRIgk=;
        b=hNOIULamp4llWnj7/SyBAffjMi+1LQK5HtQ+YNgIcHDB/JEWGc14K74B8GXWT6ZoKN
         +5i83W9/K8xFvfeA41QhF3UH1A+sRfnN7uZcvXC0TUvgvSiPhWv9V2QykJ3O83PYXMeL
         lI+tOzMjL3RUKu8tqQPEPKumLlp+T9QKz23kZeoU7B9wndniCqxekdL/yLMzWuexvXal
         Izm2ailEk3hgE0Sx2wPJ9UYRs/BD4XLTAR81/IfS4dsasEry6sIaPaXIHfjSojtPeTa0
         wbplohLXO2HaFha+EnLS8sxtIHS3YBTDbXs48hdGVyhLXK0CzhwIU9NYfzIxP2Yt3Y98
         9gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714392; x=1761319192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXVefTb39Nse0uy+Bbk9GELviGijLUlE6DvoOutRIgk=;
        b=h8uhWdW1PohXjHBLv7to4SP8zpe5vnWpy0p6J/P+6eGFuPU+MME2oTiZ3z8sHWC/CX
         VG9UZ4XjdEvY/J2NiRDPuvyLK+l5TWcGFu+Qbz2lbNay7R6MBiX1RnhVS0XVbZFi/+0z
         K4qUgXvGnuNGkdvwtzjqNOD6BrkgVGIaCTQ0nssklyDGnCJj5JPsIBXfhJlV9e88wmkt
         Dfurn6ryKx0dbd08ZcW1BZhtM5iMFwkvlQZjJ+0/g4+2R6q0RCczp/kKkZD0/kXdOqfm
         zTzZamFVgxFYB4f6grxd6Dtb22SEKQu3DdwtKRFVPT8un+jQE3FwR9+OKCxf4zvgRvtF
         9FDA==
X-Forwarded-Encrypted: i=1; AJvYcCXO9miW9X32AN6Iaofxe3y2/fnzSQFjoFsLqgnN1amRfm6Hvwm++6yYgFrWORcIQseZ8vGcTLl3ZNCb8bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqAqZ9E0XjpKbX1kqWzFgYEgQolOmZ8w92i09yQF+7mAMqZf/
	VBHcGe4Vh6kBYLD5x+WYrFrisisMfFSTa6XXpeT1xKjUBYD/D+Ec19sp
X-Gm-Gg: ASbGnctHYQ+B91KRlX0YXyT+jJvsRbva0p892gv2emoeLebh7bBIuxi1JEcso4Y2Gmm
	NV3RcOQRqVKaKCNZ4BbQ6MdEXVP53xf/s3S5b9wJoggVxR9Be9LYVowQlPPhuF23punx4Xv9lnt
	oNbOzm7KVxLiYpDEZqbnU9kccK3sD22+CiNnOJOFVKJggnY15lritYexdJQOE/muliKvzknDejN
	/IAoS2wi85WTCUGDzC1bVb8gKvzqBE4I9aS00xgPY4cQLg024dhBNIsO/zBlvDMxb+1r2bpVr9J
	QUIVKeOd4e5XHeX4G9EnQIcX65gC3gtjStjdVwgHvLGVAhPiKfWuozF/6GHB7vDTC3tKD6hL+x4
	O69i54qo/SZ+mSFxva0gij/jm+Dpd4zA/LZl/pyWcbnfAblvq7WKXBGHXcK/E0WHduDXvzirShd
	tLubxfIWAfMNMZVHILA3vSMhjZv24G9L6+
X-Google-Smtp-Source: AGHT+IHyIi9hV84N2xKmSAprgzQAB1rjUdqIYAvzNOIv45BdiAJRGsffALu2EyeoAjWoG6N3Yyv0/A==
X-Received: by 2002:a17:902:e88e:b0:290:9332:eed1 with SMTP id d9443c01a7336-290ca12153emr45972955ad.34.1760714392396;
        Fri, 17 Oct 2025 08:19:52 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:fdc9:5e8f:28db:7f80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a756sm67193955ad.14.2025.10.17.08.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:19:51 -0700 (PDT)
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
Subject: [PATCH v2 4/4] net: ravb: Ensure memory write completes before ringing TX doorbell
Date: Fri, 17 Oct 2025 16:18:30 +0100
Message-ID: <20251017151830.171062-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add a final dma_wmb() barrier before triggering the transmit request
(TCCR_TSRQ) to ensure all descriptor and buffer writes are visible to
the DMA engine.

According to the hardware manual, a read-back operation is required
before writing to the doorbell register to guarantee completion of
previous writes. Instead of performing a dummy read, a dma_wmb() is
used to both enforce the same ordering semantics on the CPU side and
also to ensure completion of writes.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Cc: stable@vger.kernel.org
Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- New patch added to separate out the memory barrier change
  before ringing the doorbell.
---
 drivers/net/ethernet/renesas/ravb_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0e40001f64b4..c3fc15f9ec85 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2232,6 +2232,14 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		dma_wmb();
 		desc->die_dt = DT_FSINGLE;
 	}
+
+	/* Before ringing the doorbell we need to make sure that the latest
+	 * writes have been committed to memory, otherwise it could delay
+	 * things until the doorbell is rang again.
+	 * This is in replacement of the read operation mentioned in the HW
+	 * manuals.
+	 */
+	dma_wmb();
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
 
 	priv->cur_tx[q] += num_tx_desc;
-- 
2.43.0


