Return-Path: <linux-kernel+bounces-889937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C5C3EE18
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AAD3A76FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECAD30FC29;
	Fri,  7 Nov 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGONIwMX"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69130E0C2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502884; cv=none; b=CBrK89WfWcTXZaufTFfICEA/+6kBs9cjElPiJ6YmXzW2GSfScWOFyCGbTOiCI08jrp9QLhga69Kcir7ZGWRzrxqnRXsCmnnjJuWQflk/ArKSvYTVdzV3DhIRrE9rt9eC6FA3hodrLfS9fzbk8rqwQvCFViqALI8V292ntVdMwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502884; c=relaxed/simple;
	bh=IFa0nENLlX3jBjh3l5VRe6sWQF2NPAjRygMAS6QACCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctIKoBzcLUdnop5LGhzrACefjNXnGnedJBhy02BokASTn2OMO+0OVwP/komeNQy+fgcOH0q73F4dG1FayOJkd3beMPOnUQNwTNVYPBgZnYIP/YVCXQQNkl7twA/vcGTXb+EP/9cHXy8rv8NIbySKaMNGmsB+WpST6XYjIWF8tAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGONIwMX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso864918a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502881; x=1763107681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAm1gcCHSoAlOOU6uyfeG288SIujI9v9lW77zI7FnWU=;
        b=EGONIwMXtzZ6o5saKFNuZsmbmrtZrrHbfbW8i7Jr+3J/HWtz3ARZvjeWQHAuc2AIN+
         y8b5Rr2owF7Eat7gPX/NCQaCRzy30DJQW38KLIyHCMIDHf5sJ53b+o0RuEzXbtLVh80K
         aj0IJ3zi5ZSM3RUcwlNYLFW/rTiRFVOMd4reZawnfRysHw5CxnI7XTKkjjnSs5KIKhoI
         sgX6iLCV8r4ozBOc8IDTYJTPDQtvdJ/LiE8gTTEhrJZzFAN8QglOJ6haVTBkpgd7DHEo
         iaa1ET2yj2ksSwoJ8LIYy5xmca56Kmh4+6D2gAr5uqm8ZdfQk3ilUz2VopwEkVaXBTpD
         Wmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502881; x=1763107681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IAm1gcCHSoAlOOU6uyfeG288SIujI9v9lW77zI7FnWU=;
        b=Z8Nfr0wpA7fBF1Q6WBRH8vtW/8fsOQ7KPuQWVc14mtGTJda1ytRBMseaXBNQScR4v5
         nUQ1E+UWGScQzVoCnhkyYCl2SpH+If7C+zpC1rcWBLJgEX1qw8jKED1bLkRrE2zIUxEt
         ynaEBeDyq4twYFkn9wDu+KHiDGkpS9fmXRtwG8fynOaHcXOHmQJc7kDF56NnaAJPW/a5
         2+eiwm1ZKCmesnc5w8+yDqAgVQ1oguEqeFsP/4BKPr68UsNv/MHR2R/ovHL7j7i6uAmZ
         HAI4J/v67Cw8y/76VCzW8P82x1m7VdS8QHzI2RMOOHKwhRNK/Bib6miOlYRumMqQkQeD
         BSqA==
X-Forwarded-Encrypted: i=1; AJvYcCUHlbdlD+uigLX/od+8mJD8Hzfvc15p6ZvVAf6kLeJlB63fARmSkcL9Y2upHDwHFiyMqw+rg2foD7h39xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Pd0cra3JdaQIO4fOROvqkMhZpA1eZaauQE4fXjk+QNe4fM5t
	1ooup15qan7ga9I3UxFqgSlP1C7jGHdq8QuG8yAup0kwHUxLqWyoUfIs
X-Gm-Gg: ASbGncuXidIoGt+udmHZ6rVhSUqhgOSWUzgDavSQxsG+J301FTU1jh1M2HcRrmAFW0b
	tahHCb/tymemBke9UYiyeVLHeTQwu7NYLdtISeoDXQEwmGERNM0/NIbHMfc2/RO0l1ncgqPz7yc
	4R6hPx4RhI1NYbKcHej6ZmeraVbeWqwjT2nKyZz6jjcP3kQ8RcBxV20E84ewTJ35vNsWD2xwYYA
	7lddXkvkC50wvImCZE5JuaqcEW2UTKLkRQWof/zrHDYepI+C89j8QugWrMdYfn2TRFSyQftNeMX
	LBo14et2+bq9KqFWmfE75OlQ17O7+mhMWuv3/cNPlzr1D/PAKmtqtfEwjW2grUdB1EnCjK3pnvw
	zu5034Ibp7Z7FQmUQBPa621br1TO5fAbpB/+enMSmQqz+1gFGx1jTv5Inwc51RmgBsaVkapepA3
	fpI6RmtByjwZG9u3YiGUeI1MEw6HtBgPBctO+G2Ef4hIieUuqdU/S0k04zGw7xnJT8j+s=
X-Google-Smtp-Source: AGHT+IFSL8feEEjbvxeG62b06CI5tTn7LvdOq1xXx0yvI1Z30Sc5wm0UnCG9Ava+KGc85fT3QUMfDw==
X-Received: by 2002:a05:6402:4405:b0:641:3b9b:b81e with SMTP id 4fb4d7f45d1cf-6413f1fc6f7mr2067760a12.23.1762502880518;
        Fri, 07 Nov 2025 00:08:00 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f71393fsm3627237a12.3.2025.11.07.00.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:00 -0800 (PST)
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
Subject: [PATCH net-next 1/8] net: dsa: b53: b53_arl_read{,25}(): use the entry for comparision
Date: Fri,  7 Nov 2025 09:07:42 +0100
Message-ID: <20251107080749.26936-2-jonas.gorski@gmail.com>
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

Align the b53_arl_read{,25}() functions by consistently using the
parsed arl entry instead of parsing the raw registers again.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c911d7ea601f..1b94cf7b06e8 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1850,7 +1850,7 @@ static int b53_arl_rw_op(struct b53_device *dev, unsigned int op)
 	return b53_arl_op_wait(dev);
 }
 
-static int b53_arl_read(struct b53_device *dev, u64 mac,
+static int b53_arl_read(struct b53_device *dev, const u8 *mac,
 			u16 vid, struct b53_arl_entry *ent, u8 *idx)
 {
 	DECLARE_BITMAP(free_bins, B53_ARLTBL_MAX_BIN_ENTRIES);
@@ -1874,14 +1874,13 @@ static int b53_arl_read(struct b53_device *dev, u64 mac,
 			   B53_ARLTBL_DATA_ENTRY(i), &fwd_entry);
 		b53_arl_to_entry(ent, mac_vid, fwd_entry);
 
-		if (!(fwd_entry & ARLTBL_VALID)) {
+		if (!ent->is_valid) {
 			set_bit(i, free_bins);
 			continue;
 		}
-		if ((mac_vid & ARLTBL_MAC_MASK) != mac)
+		if (!ether_addr_equal(ent->mac, mac))
 			continue;
-		if (dev->vlan_enabled &&
-		    ((mac_vid >> ARLTBL_VID_S) & ARLTBL_VID_MASK) != vid)
+		if (dev->vlan_enabled && ent->vid != vid)
 			continue;
 		*idx = i;
 		return 0;
@@ -1891,7 +1890,7 @@ static int b53_arl_read(struct b53_device *dev, u64 mac,
 	return *idx >= dev->num_arl_bins ? -ENOSPC : -ENOENT;
 }
 
-static int b53_arl_read_25(struct b53_device *dev, u64 mac,
+static int b53_arl_read_25(struct b53_device *dev, const u8 *mac,
 			   u16 vid, struct b53_arl_entry *ent, u8 *idx)
 {
 	DECLARE_BITMAP(free_bins, B53_ARLTBL_MAX_BIN_ENTRIES);
@@ -1913,14 +1912,13 @@ static int b53_arl_read_25(struct b53_device *dev, u64 mac,
 
 		b53_arl_to_entry_25(ent, mac_vid);
 
-		if (!(mac_vid & ARLTBL_VALID_25)) {
+		if (!ent->is_valid) {
 			set_bit(i, free_bins);
 			continue;
 		}
-		if ((mac_vid & ARLTBL_MAC_MASK) != mac)
+		if (!ether_addr_equal(ent->mac, mac))
 			continue;
-		if (dev->vlan_enabled &&
-		    ((mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25) != vid)
+		if (dev->vlan_enabled && ent->vid != vid)
 			continue;
 		*idx = i;
 		return 0;
@@ -1953,9 +1951,9 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 		return ret;
 
 	if (is5325(dev) || is5365(dev))
-		ret = b53_arl_read_25(dev, mac, vid, &ent, &idx);
+		ret = b53_arl_read_25(dev, addr, vid, &ent, &idx);
 	else
-		ret = b53_arl_read(dev, mac, vid, &ent, &idx);
+		ret = b53_arl_read(dev, addr, vid, &ent, &idx);
 
 	/* If this is a read, just finish now */
 	if (op)
-- 
2.43.0


