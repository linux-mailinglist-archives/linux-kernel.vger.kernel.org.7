Return-Path: <linux-kernel+bounces-815313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E68B5627E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EF11B21571
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 18:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5C2147F9;
	Sat, 13 Sep 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKngJ2y9"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DC1FAC37
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757787230; cv=none; b=uB62Te5s377HntKXAxBGwLdB4OUF8nkTUwyU/YtfFy/udDDpEYCTHzqzxpHxPKYSQGFBmPdXkchmUsFQqZS4pR71yHzyYp+es3auRPAOm3cPK2iUML8Bdc9ORZJW0pa2BHMjSmQBipsAFEY6wXYW2nZZ8T1HjbhbQzwKSPrgcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757787230; c=relaxed/simple;
	bh=3rzaM2X/zFTxRZBZgEHTS2j0+xkHtGU3DGTzIAZHWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CV1AssVpt4iUCV4XZKMWUo+DxIdw7q3cpfTh9CNZjRwwzIcRJLQwFPgBXAGkYXpePLF/d0Xl+ZrV0E+QjcPFsx8FgK7POaRPkTFqV9OjAe0+Hyu0/Sx/LG9TTrYyhAJPqKVG3tEw46OW+E0huf4B3aYFNTZgoUShC6aqaPwlhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKngJ2y9; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea3f49679ccso333550276.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757787228; x=1758392028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqC6tk+ZfLggMyonbV+QWYHVZPiMQwp/bc2dZEheebg=;
        b=FKngJ2y9BuPcidAcNLHInK8z3ZE40mdZbhYHrjtZLqW8NRmjkc0bYkNvW2xtKq4U8x
         FaqhGRiNRqhTxNder2f1gUXu5+oapnqXyxRBNAzzhrmCwl7l0MsL1jaxEsCoCMkGjd/E
         NcRWrJXaV6Ki/0cx4nR80Q58QiOgk0y26x94RhuZOpJmvq9qZ2v+tvEevtzyINmNK2qV
         IMGF2sefTS+xM07Yz1TqnhGxGvmXGjUBnYTJLIa2k+UwMrtQwY5g1mvcgPtxAHBVaair
         rxGUsNVTzoTiO1kfK7xyMD0vC78D87eB5c5apSd8pDHcUeL8zSgD9bgoI5r225bfciF2
         A/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757787228; x=1758392028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqC6tk+ZfLggMyonbV+QWYHVZPiMQwp/bc2dZEheebg=;
        b=lFt50fa3i74ejVcbRx5uic4Tq2dOlSTT/nvCEozntlk32TSJ7mMms6BC0/7JeQij5U
         R6+6SuRDnMfZvIRoMJa15GQUfdTarxil9x57H9onStEP7BrMhZryeH2YbeS9+gS4/7Uq
         ovrQ4a1bFxn5f072XSOK2i+9FY/dwf4orkLr4BjVaQshWWjOdT+vmGUVgaYJXpPq/2qM
         vewSs/+10ZnHI1x0TdbJCSgruvB4U4JEVpRjuxhW/9f8yuYRfYtdwOwL5ZK/XiCon5cI
         mVPHNlwUXkNezD6K42DxQcEhRnAedhvu+9WYjPsWCkFmg0mrnuUPTwa3o90Cw0+xzbki
         epjw==
X-Forwarded-Encrypted: i=1; AJvYcCXI8wWE5JxPIEAMwyxiMkVeVkP4PiG/IynAUtcXy969aMJOzhpaQf1q2wjFX1C6qFEnoyvJWFeqHYh5/Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmirkRim6AHr1I+IWSwgat/VDQVznGZNpniYzZEV5zZgoQyZp
	LOnTMR8+kwaqBdqTf2PuZzQbhcTf/M//3svwtFdzIvJ/+l6CFTglyLxd
X-Gm-Gg: ASbGncvxkxlfdW6qEqcJEHNGRKVs0EqhdtOHOQA4/vom+s+co9G7hqmujAJFQZAGQVl
	P0S785+Su9IEvEALJgka6gLwlqe5woG8J3IRR21dSMbYgZUOZFBmlc8Q1ON5p8nonrWLFyuScJp
	dQtmh6CKhcVSZL6F4d9Ja58q3DIf9DBhQvF8MBH1ZEAM8s6AgSQ4jIiyZ70KosCSXDgx5StDg63
	qRCfCxm+sg8C2CjVNULqtRhfwboQ5Zi2wwcEWZ54lFIAjNE1F+/4y5GwUflfLpPw+YOlieziLxZ
	ebBnRJyIta91tP5ClV8e3JD2vU/qgeOGynEAswDgWdwM0/F09rYcm8qdrTgIenQUxK0MwFy/4N2
	L0Tx4FCnnCrLsrll5pYC87TWjGLD4ecQcRltUAF+GgHhbq7OQSIRFWJpIAS6o67XeCKJWd0OcK0
	x6wW0=
X-Google-Smtp-Source: AGHT+IGXmfP8lhQsAEr8A4H+juDqXUoD1IEZHDk4WG2eYBTmnl9v+NYkqBaumyp94fhbs4FlMP4+2w==
X-Received: by 2002:a05:690c:610e:b0:71f:e5c5:5134 with SMTP id 00721157ae682-730645316f8mr70119117b3.33.1757787227704;
        Sat, 13 Sep 2025 11:13:47 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76928fe2sm19907537b3.25.2025.09.13.11.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 11:13:47 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: renesas: rswitch: simplify rswitch_stop()
Date: Sat, 13 Sep 2025 14:13:45 -0400
Message-ID: <20250913181345.204344-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rswitch_stop() opencodes for_each_set_bit().

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index aba772e14555..9497c738b828 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1627,9 +1627,7 @@ static int rswitch_stop(struct net_device *ndev)
 	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
 		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDID);
 
-	for (tag = find_first_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT);
-	     tag < TS_TAGS_PER_PORT;
-	     tag = find_next_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT, tag + 1)) {
+	for_each_set_bit(tag, rdev->ts_skb_used, TS_TAGS_PER_PORT) {
 		ts_skb = xchg(&rdev->ts_skb[tag], NULL);
 		clear_bit(tag, rdev->ts_skb_used);
 		if (ts_skb)
-- 
2.43.0


