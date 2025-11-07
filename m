Return-Path: <linux-kernel+bounces-889939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD294C3EE27
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192223A9AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5295631077A;
	Fri,  7 Nov 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkxmejsY"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4930FC1D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502886; cv=none; b=i4CeXCTmnBnRZYKVy9Q00DWsKC78W5bre/fV//mWxSGavxMYl+upR9H5qnAJ3tOQm2SeAkKHolpCgpYTblkUj++9iW7MgusFwF0SVm/a0PxYFpXzxlD0DPaHTvbLLhhi7r/QFXF/o6aXvlNK+5oSj/FmwS+8fbC4/z4/H6V9Mmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502886; c=relaxed/simple;
	bh=c/ypx/7KDRitSfXO3iv/XG5GJJGXfdxf5+ySmcx3JiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y05IKb0rf30DC4emO1n5kqu07aYYl8Ek1Sr26NqaH70mag175boTxWatHL3pxhNX99mLeDJzDbgMijGAffekY276cA4GaUMyVAgn3FmQ7V98e0otjBkE+ZV18vJA7tmqvSjgh2j98YhN/TD+Ct8ZVrXo+OMPwXyqKNeb520C6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkxmejsY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so758565a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502883; x=1763107683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AliuwcJnqc6fNYruuHtll/VWN2+GFQQMz8uQSPpdEUc=;
        b=EkxmejsYZ6ak11fC9YR7vvOH6qQY0SIK4nvRhOeX+DbIZ3+UVh1CwmEZP9yXKLwLmo
         YNPkqSx08pEcc9aWX/DgjSqVNkYbYFy2Va68hQTtP+110bJ/sP9Hd9p1+1SgqHkm7LCO
         0DWygUV15EUDIx/azunGi64+RLVSzFozW+8VI1b3yXpTXqPus0k4TZP4FQUYLB7SqCH3
         v+nqmBozp7GiWWcaQLSOKKrG4vUX6XvtsEsmqwnom18ccXT/71p9U4SrueLqZxgEuPSf
         h2nDSkkwgeguRYJ3gz7aZag+defIhhI3zW/ch6YtR4gLbHO0CeF7P7cEJLhBXGlwGRfj
         IH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502883; x=1763107683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AliuwcJnqc6fNYruuHtll/VWN2+GFQQMz8uQSPpdEUc=;
        b=bpnVC2Gn/GrgD+Z3Gxg6fCDKIVVXRE5KJWe2BYTP4HRh0Gzrtt0EocR3MjVOX9eVGL
         kTnLKhM6MpaKeCjlijXP1sOWm+3aKvpnkOJl3Z6I3YuVPETSUcXIg7TuzPvBWM66g++t
         woehok7/wnW9FMovGfSTOhrg9IHaKKnV8wdapioJOOoik++Zk30dNdRgkkCShgWso0D1
         iF9w4LQeGibQ4wuDpuFg7GpBRZy0i9O5yOuUDpad/u4RtfVY9/H/xS5MDlHyI8fEz+UL
         cClkdx3Y8ishGK4tCQtY6q5fMHahqH4YzzHHUvp5MUUAa7OfQyg6BG0MIapriKPO4Jwz
         G/gg==
X-Forwarded-Encrypted: i=1; AJvYcCW7h8GxxZsBUQGIfCRGR5Z8RC+CAyVtvbXJYosZmPZKyLK+qxD7DAzDdtxKR+jmc0AYII0iJV/C0POhc30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKGObKgi4omSURGEIEOyMuqU9tRFa+kwtDuKLBoTvlNLIhDVH
	AzCGKpBgUZHGJAnb1CgyHEwik4CedkOiM/PFl55d6oMe7YnYiKnkiQie
X-Gm-Gg: ASbGncuvewdOFCxnOmaP+4uEmolPKMvfbtUoNL56kQ5yAWwizQmZKNjzZZLWiLVfOVC
	uy37+4E/NM/5Q5WRLEOzPvJsMneZnCQQFEODqZDrf2eT/ERoV6fdVnCUPrmkNIlHgq7OnXQAWTC
	6yIqHytXxnvBrvS/6qmq8ArQmXXLqgC2ArX2VC22FzM/kqmqL4k4viiRDCSZoxtbT6u/bL/ftX5
	GDd5P4gBkGVAc5W933PyKf3WwVyLj//0/10swQP2z5HNbWIJXqvUsJ0cB0/Nn6kTZmQEXclPd8g
	YKjNqwm4MrOveMiqFJ0uxfLoIwSUeAE7ALK/fgrqikMdCRxXQWI9HnrcbT+SQb5kTWkB4MDu08z
	MbVgL65inzcfW2rRgfPG8iw9S978HclBsNy+CZVd96y+Bd/zUjJKWgY/RyBegXM6aZEkE2C348a
	4a3QzWQovxw5SsyjAggMRl48KH+5lvw5Es7jBWGAOW2tDFPt5CgDJXuxqU
X-Google-Smtp-Source: AGHT+IEstEw1exNyTbFuvnvrUK3nX+jDWzrwRf9MNF5NOkcJ6wg9CRw5gIOyRK6s0Hlt8IeRAvgQVw==
X-Received: by 2002:a17:907:9607:b0:b70:b5b9:1f82 with SMTP id a640c23a62f3a-b72c0abcb78mr238175466b.31.1762502882846;
        Fri, 07 Nov 2025 00:08:02 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d32e25f6sm46179466b.5.2025.11.07.00.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:02 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/8] net: dsa: b53: move writing ARL entries into their own functions
Date: Fri,  7 Nov 2025 09:07:44 +0100
Message-ID: <20251107080749.26936-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move writing ARL entries into individual functions for each format.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 38 ++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d99e15a7a6bb..9eb7ca878e30 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1860,6 +1860,16 @@ static void b53_arl_read_entry_25(struct b53_device *dev,
 	b53_arl_to_entry_25(ent, mac_vid);
 }
 
+static void b53_arl_write_entry_25(struct b53_device *dev,
+				   const struct b53_arl_entry *ent, u8 idx)
+{
+	u64 mac_vid;
+
+	b53_arl_from_entry_25(&mac_vid, ent);
+	b53_write64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		    mac_vid);
+}
+
 static void b53_arl_read_entry_95(struct b53_device *dev,
 				  struct b53_arl_entry *ent, u8 idx)
 {
@@ -1872,6 +1882,19 @@ static void b53_arl_read_entry_95(struct b53_device *dev,
 	b53_arl_to_entry(ent, mac_vid, fwd_entry);
 }
 
+static void b53_arl_write_entry_95(struct b53_device *dev,
+				   const struct b53_arl_entry *ent, u8 idx)
+{
+	u32 fwd_entry;
+	u64 mac_vid;
+
+	b53_arl_from_entry(&mac_vid, &fwd_entry, ent);
+	b53_write64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		    mac_vid);
+	b53_write32(dev, B53_ARLIO_PAGE, B53_ARLTBL_DATA_ENTRY(idx),
+		    fwd_entry);
+}
+
 static int b53_arl_read(struct b53_device *dev, const u8 *mac,
 			u16 vid, struct b53_arl_entry *ent, u8 *idx)
 {
@@ -1912,9 +1935,8 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 		      const unsigned char *addr, u16 vid, bool is_valid)
 {
 	struct b53_arl_entry ent;
-	u32 fwd_entry;
-	u64 mac, mac_vid = 0;
 	u8 idx = 0;
+	u64 mac;
 	int ret;
 
 	/* Convert the array into a 64-bit MAC */
@@ -1947,7 +1969,6 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 		/* We could not find a matching MAC, so reset to a new entry */
 		dev_dbg(dev->dev, "{%pM,%.4d} not found, using idx: %d\n",
 			addr, vid, idx);
-		fwd_entry = 0;
 		break;
 	default:
 		dev_dbg(dev->dev, "{%pM,%.4d} found, using idx: %d\n",
@@ -1975,16 +1996,9 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	ent.is_age = false;
 	memcpy(ent.mac, addr, ETH_ALEN);
 	if (is5325(dev) || is5365(dev))
-		b53_arl_from_entry_25(&mac_vid, &ent);
+		b53_arl_write_entry_25(dev, &ent, idx);
 	else
-		b53_arl_from_entry(&mac_vid, &fwd_entry, &ent);
-
-	b53_write64(dev, B53_ARLIO_PAGE,
-		    B53_ARLTBL_MAC_VID_ENTRY(idx), mac_vid);
-
-	if (!is5325(dev) && !is5365(dev))
-		b53_write32(dev, B53_ARLIO_PAGE,
-			    B53_ARLTBL_DATA_ENTRY(idx), fwd_entry);
+		b53_arl_write_entry_95(dev, &ent, idx);
 
 	return b53_arl_rw_op(dev, 0);
 }
-- 
2.43.0


