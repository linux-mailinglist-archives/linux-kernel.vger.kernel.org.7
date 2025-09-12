Return-Path: <linux-kernel+bounces-813751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4C2B54A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485C4AC24DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F02FFDFF;
	Fri, 12 Sep 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Veuhmm"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C62FE58C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674064; cv=none; b=oFvdAVgvSZA+vxF8tOxDnzU5Pt53E/EoRJ45r3DF85ZjEveBWtCmWSZzgC2xIiYFr+w+P9Ymx7gUj5gVo8UoRAf91K2ohcnFZqHOJRCPDOoWJOF9Q7P1KSx7YGIoWNQa+f2up5O00dm42+pYXVSE3f4PKp9Q1qHmXa7YLCzH17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674064; c=relaxed/simple;
	bh=3y5nospWONScbR7m+PVwm9tYXQQF75CUI8JLYWPI5SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhyYJXzAd36bwqk7ipuvH75SXvhyktmZvn1DSNikp/wFh7WC+OJm8nstFjqJ/tvUEnIL0AS+7S9BN+2JDFykqTsDw3zTHSDdwal9mM2/kIS9oOHdHodPjfeTJqNss8hsiKPguhZlmOpNC5B2zF2S8LBhGKlCvI57JasyPJTfh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/Veuhmm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3db9641b725so1489296f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674059; x=1758278859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgzeJKT6W/ji7pCcEejwbhNcI8dE7vQD5tyb3XmbXbI=;
        b=D/VeuhmmgPnGBEd/uugjhKkG/wBu/MDcXUGXpv6R7fIDDQW5xOY5u/z8N1YM0A4fkq
         flAzA0ej+bTdX7FVlIs2EFGJwTLZrUePBwlJcn5YxdUSbh32joMyrwn5tl0JwjflxMgb
         vZoi1uVfw2EopyWR5Z6J/pTKzY6oKZZbP2tneb3WpIEz04DC89tlMrZVeZHW8OrUTFhP
         EXbF7RwRm95dsE4S3qK+6X1effpMqOrtbqWs0lojgdr0cFItg63S/H1R+WQQcAAepuB6
         1o3b68dRqBkPzs3vSjxsP+TGPlsW6xds00emoZsowmCy2hZzMCnFHfb4JdwP2n86AEy4
         CXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674059; x=1758278859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgzeJKT6W/ji7pCcEejwbhNcI8dE7vQD5tyb3XmbXbI=;
        b=N1WSs4zxyuYvexUUXJwk68FGhxRiYDt1cA7AN1qSWRVmfHtsw9F6v0KN8vYceYd/FD
         WDaH4tpC9tmwZVhZUO3kAKolLfsbaKn+VUWN59rjq5mhNzkPQhn5DqWkXMKh5bQDwWq6
         O00KvPrIOkCxcOTS+ryR4YM3qM5/zQoeRHFRxJbBLRyx1LFFb0LL6Pwcp3iPzBEREI9W
         3uoZrKDOllOZqDEfkL4M2++hZ/N3GqTIzv+Jl4Mk8Jh8mywtUHo+l2un1XDDFqJD8ToB
         laiK3I/QhseZ3ukMI4M8y6XHhdMO2I5z4hQ5mdUFs56G78jJcz1IPBP18Ql19ulVIC/w
         RPpw==
X-Forwarded-Encrypted: i=1; AJvYcCUqphVGmE/h3umqbhRO7zNvFBoSrQ4r/cCZclSKZyeHIKR8tv2Ns3UyKpZwuVE67UplKWe6C0UcOs2djgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRz5+1d0tehKYmjyYdII/woUcmGZzwSciHj4EePjng4Ca/Cx+u
	9Qvimq/lE18msrD71Aiem2DfeUAK/hIW6Q+d5p8tOt7TfYv54mCA/FKu
X-Gm-Gg: ASbGncu3E86+YLe0qSFrs7q+qhH8es41X592bI6SkTKCm2pglnkjUImjoAj7MOG5b9I
	ya2/oyfcSd6CXxjdv8fHkS5x7vtUmf6pQALIz2sK1vQboTrNmKaHtxZ4k8AbbMN8qnNwkQ5zme5
	eXNxPnM1SA/YZ4pUlkrJx2ofgcR1JaH66mUnVIdAtgKU940EKI9CQy5v3T30q9PydmcGd6ZtS02
	3opIyhFbYlv/Ma7HVrVW8j3AAfdnBAPhV0yDyym1llh8THqeRSudZTzKH+eYBFOZZcSYQMDPqpG
	xELw+M9sf4j2KBMBBb45J1ldVKMuE5/flDvifhycf8/3GYy8LO7k+AXgeUp5354qqBXEtRgF/au
	zP9xiE6V3ZTYTSNju3NbmB4EnWQysN17IFSt77/B8v/FSpMZkiFZMcba195akGeWQSgYq7yRyg9
	ThfDOTW8+nH/zc
X-Google-Smtp-Source: AGHT+IEKxNYK+gyPooOCw0AGIOWMAbKnyvpe9JAaTYZFu44awUZ8ihxoSRmKAS28dBPN94ozwkbEzw==
X-Received: by 2002:a5d:5847:0:b0:3e2:4a3e:d3fc with SMTP id ffacd0b85a97d-3e765a55c3emr2283673f8f.58.1757674059454;
        Fri, 12 Sep 2025 03:47:39 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 7/7] can: rcar_canfd: Add suspend/resume support
Date: Fri, 12 Sep 2025 11:47:25 +0100
Message-ID: <20250912104733.173281-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume, the
CAN-FD interface no longer works.  Trying to bring it up again fails:

    # ip link set can0 up
    RTNETLINK answers: Connection timed out

    # dmesg
    ...
    channel 0 communication state failed

Fix this by populating the (currently empty) suspend and resume
callbacks, to stop/start the individual CAN-FD channels, and
(de)initialize the CAN-FD controller.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag
 * Fixed the typo in error path of rcar_canfd_resume().
---
 drivers/net/can/rcar/rcar_canfd.c | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a0c16a95808c..27301224edd4 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2257,11 +2257,64 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
 static int rcar_canfd_suspend(struct device *dev)
 {
+	struct rcar_canfd_global *gpriv = dev_get_drvdata(dev);
+	int err;
+	u32 ch;
+
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+		struct rcar_canfd_channel *priv = gpriv->ch[ch];
+		struct net_device *ndev = priv->ndev;
+
+		if (!netif_running(ndev))
+			continue;
+
+		netif_device_detach(ndev);
+
+		err = rcar_canfd_close(ndev);
+		if (err) {
+			netdev_err(ndev, "rcar_canfd_close() failed %pe\n",
+				   ERR_PTR(err));
+			return err;
+		}
+
+		priv->can.state = CAN_STATE_SLEEPING;
+	}
+
+	/* TODO Skip if wake-up (which is not yet supported) is enabled */
+	rcar_canfd_global_deinit(gpriv, false);
+
 	return 0;
 }
 
 static int rcar_canfd_resume(struct device *dev)
 {
+	struct rcar_canfd_global *gpriv = dev_get_drvdata(dev);
+	int err;
+	u32 ch;
+
+	err = rcar_canfd_global_init(gpriv);
+	if (err) {
+		dev_err(dev, "rcar_canfd_global_init() failed %pe\n", ERR_PTR(err));
+		return err;
+	}
+
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+		struct rcar_canfd_channel *priv = gpriv->ch[ch];
+		struct net_device *ndev = priv->ndev;
+
+		if (!netif_running(ndev))
+			continue;
+
+		err = rcar_canfd_open(ndev);
+		if (err) {
+			netdev_err(ndev, "rcar_canfd_open() failed %pe\n",
+				   ERR_PTR(err));
+			return err;
+		}
+
+		netif_device_attach(ndev);
+	}
+
 	return 0;
 }
 
-- 
2.43.0


