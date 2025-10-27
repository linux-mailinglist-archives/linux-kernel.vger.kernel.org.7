Return-Path: <linux-kernel+bounces-872300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE110C0FDAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46A6C4FC20C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30D31B800;
	Mon, 27 Oct 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbNT1tbW"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006E031AF30
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588422; cv=none; b=REr/9KHswAc0ePxdFLZ3EAfMa+1DYOTJR21FtarQnvNC9dtXoH20Wsw3602Yi6VwdVq8PdAwDcYtjxXp5tkTfAyO8xT2OhbQwVzm/aVuJ8STR4+KznsgoYsj2EcXPdqvFpC5oo7iopqZ5psZFzVOiKCE6iYx5G3R6OiH6lET4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588422; c=relaxed/simple;
	bh=S5EJ9XcCqpHYV/G/pMTycm1y6FReoUK/jP8Ub0QdsKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueJF7ETtVTxBVMrGSZhjqczcfhun8IB6h7uWtWJFpLiM73kIPOXX2VYNTk/gdm9bre1bS6RPYzir2GrO1/JXTymyU/o7IwiU2v3PTGBXTsFBEYWvUI0CYN12f90rbKNY1wq9C4JEWNXO79j6m57uoK36cx7VWaYJdKxaws7hyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbNT1tbW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eb75e8e47eso56890341cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588420; x=1762193220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5tB+vgwG5bHZ8tPheIQQmyuiY0H1S/f7NnZas1yCE8=;
        b=JbNT1tbWx5SDhJF2vPZ8GVYO+ZUKNMq14e8BD3gPZWNn2D1GnNq4KKGWi0iYlQpDqq
         036PYCOwKj1e8h9cp77b2TYa1ev/3F2f8KpzX1AeiyvsR7hkEt2vXGlTTWo0q+tIM/ld
         uuyEljbtGY+ZH/qmja3hlWpt+dRqkpZOIK/wJioJ73EaK1GCbiXgFpGABnv9dRyuiCoN
         9lz9Wg/QM+ST33aLk2MFHl0UDUAGP61ovm/a3M+vA9bcoyNVd07zakGGu9yFMGLRLsZn
         L45SCt0wsuZXnw4XW0cE3bOwTJrlVi3ULf/ilE/7GfqTrty5JUWPvsFvbVETJjaS4wwc
         ccnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588420; x=1762193220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5tB+vgwG5bHZ8tPheIQQmyuiY0H1S/f7NnZas1yCE8=;
        b=cW71dYzE0De55mFaRRUicFVHNrR0odyuB/jhBZucj1I8f/6Jov4t8HH7zky/CO4oRN
         XsPnGagUyNWXXdnCcjJjdTgei1Ox9QE6V0/25GhFsf/sX93XE2wcVBb9y5lKgXaFzwKj
         HAJ/D6gYp3ouT7QSxFzjb7SphMpBoTl5Wk+QOM3cfiFkHuTIniYbuVuzV3d9NIe/Beid
         nhc12XsrdedqFtzslzacAugE6ALhJ6JE9wW2QGXo1urCBl0b8SC9Pfov5yTCTMs7C1tt
         PpTYZHN3MHDSnDXng+4AGkoqbEH9WAQGFlCbx/csFT7KpODIV8sjteJ6aM36TaWvGNxD
         uNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCULZVpxhcXi41M7aVXaqPj0HdIooztWFS+7vltTgD1sV9uLTOfVeCJ9wU2CQmGo7vT0UMQZT7PEQw5Ce9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WrUGbzImUB/o+KhEe8m/KtOWCtVosotbAgOSrIhTNV/et5P2
	VSMBN89R1F4d87zVuqfnkdBo76cos6w2IrGTQLyusevmRfm2FO5VUf8F
X-Gm-Gg: ASbGnctvXb9IjSjCGfa5gX6Q8kP1UWegdqcofJrBzoxyP7dvMpllHFdD5VB63AHEy/J
	lKO4WEw+zcX4tC85LERI4QWSleKbemwhOIfUwxPKgnr8CjPuVD7AuM1GAFayOZ8+WLsunmPz/kT
	H06oE0F+OUKMCTgxYCuI4+qoQtAJQsGdQy4dsVwYjTuCaeeK+nlVj2LdyuIyIUJRdL2sDtWs7xa
	HZM3N6ERX/7p0yKkjNRN5vyIKREJfnBt7u4oWAZltng3sVNj0Z1iRvxmmODb11w61V8RbM1aVXT
	n5IzgAgHOGICMAObWf0ct6pAmJItetzvEcM8rLQDVN9U6WoNujNhJvTlfIT/Y566yWjJR6oxZri
	SCaT/WXTXTsDnnEfGOajkLgpHVsThJ1gFQ0Y+eQJL2eWbyjOaFPsX/lLQLA==
X-Google-Smtp-Source: AGHT+IEHn9rjC5GIZfbJaC/Wtg4QIixDKg5Hpt/C2qQW9ZsqfAuXCErSqKYeOZ7HcP2rIQpvBj+Z5Q==
X-Received: by 2002:a05:622a:1b20:b0:4ec:f017:9e26 with SMTP id d75a77b69052e-4ed089db331mr4530611cf.26.1761588419829;
        Mon, 27 Oct 2025 11:06:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37fa7b9sm55446871cf.17.2025.10.27.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:06:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 wireless-next] wifi: rt2x00: check retval for of_get_mac_address
Date: Mon, 27 Oct 2025 11:06:39 -0700
Message-ID: <20251027180639.3797-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027180639.3797-1-rosenp@gmail.com>
References: <20251027180639.3797-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_mac_address can return -EPROBE_DEFER when nvmem is not probed yet
for whatever reason. In this case, nvmem mac assignments will not work.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 v2: add wireless-next tag. delete misleading function path comment.
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c |  4 +++-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 10 ++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index b264ed0af923..f07152fa3725 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -11011,7 +11011,9 @@ static int rt2800_validate_eeprom(struct rt2x00_dev *rt2x00dev)
 	 * Start validation of the data that has been read.
 	 */
 	mac = rt2800_eeprom_addr(rt2x00dev, EEPROM_MAC_ADDR_0);
-	rt2x00lib_set_mac_address(rt2x00dev, mac);
+	retval = rt2x00lib_set_mac_address(rt2x00dev, mac);
+	if (retval)
+		return retval;

 	word = rt2800_eeprom_read(rt2x00dev, EEPROM_NIC_CONF0);
 	if (word == 0xffff) {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 09b9d1f9f793..665887e9b118 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1427,7 +1427,7 @@ static inline void rt2x00debug_dump_frame(struct rt2x00_dev *rt2x00dev,
  */
 u32 rt2x00lib_get_bssidx(struct rt2x00_dev *rt2x00dev,
 			 struct ieee80211_vif *vif);
-void rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr);
+int rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr);

 /*
  * Interrupt context handlers.
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index f8a6f9c968a1..778a478ab53a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -988,14 +988,20 @@ static void rt2x00lib_rate(struct ieee80211_rate *entry,
 		entry->flags |= IEEE80211_RATE_SHORT_PREAMBLE;
 }

-void rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr)
+int rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr)
 {
-	of_get_mac_address(rt2x00dev->dev->of_node, eeprom_mac_addr);
+	int ret;
+
+	ret = of_get_mac_address(rt2x00dev->dev->of_node, eeprom_mac_addr);
+	if (ret == -EPROBE_DEFER)
+		return ret;

 	if (!is_valid_ether_addr(eeprom_mac_addr)) {
 		eth_random_addr(eeprom_mac_addr);
 		rt2x00_eeprom_dbg(rt2x00dev, "MAC: %pM\n", eeprom_mac_addr);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(rt2x00lib_set_mac_address);

--
2.51.1


