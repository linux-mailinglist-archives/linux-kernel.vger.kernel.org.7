Return-Path: <linux-kernel+bounces-889941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A14C3EE21
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B8BE34BF80
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6B312819;
	Fri,  7 Nov 2025 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msWw+FDy"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4720310640
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502888; cv=none; b=RtQ0dTvFYFS8kcRuupfVhM2mP3IO5yHmqO7qol1nUiQB2Lc+eJ2TWuVj9fKYQMMSiLOZu23CLBdFIB5JHZUA1anV/EdLq+7ynmwWL49EytsRZJNz6EABM7BMS6f7HC9/8h537rmjzYnwKx+cq63LiAA2D2AUpKK/Amci4bujW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502888; c=relaxed/simple;
	bh=/w5CveTbO/WqJsGriA2LFd+qtHXklKNofJizjnX0VcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZhhPt8YTUySUpMETmVcHgpiwi3KPwHRtyKxkOHs74IjQ/Ku9s7bkbG6+5yx+8cEj6XmQmNSB0wXJSNDp3fyZLt6hScXd11qojZRXib1G7vb90u2dchple5MeSbe0n3K82CItpSvBBtG9BsHVCFa/mE4HSglLiS3+zo5MVbzD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msWw+FDy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so822760a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502885; x=1763107685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTdKjGxTrhEWGEzux1V481YH4d93VhARs2gtogCyhH0=;
        b=msWw+FDyqZzwIf7IL1JC+Xsf8HcXRu+HPIPSU4jrc98hgKcCc6AGShE6jUi7Pp/S+2
         /NEEvCb1Y88HIYeuTM8cXIbEjCO+iW6GFKZH+N9IuT3hcldlR3xjjCS8PftolGgB5sHa
         qaWjxNPSy5YdXepG/AdR+HK9TkxWXYtnL6Xn7cWumUow0yo9FpBFI+/uol3xRuX104yR
         RLW1vfg0xk0kX+4MnOa23DzKvwuQ0OVSyunyLK5Sw9Or8PJPaWR0AmpjyrKEPpI6ukpE
         q4EUMfY5z4rkYixl40OUWJQv1UU9QIrX1iNDzVPiDRGO9Y1dln4RsEpFutZAdLWVGzPw
         eBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502885; x=1763107685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wTdKjGxTrhEWGEzux1V481YH4d93VhARs2gtogCyhH0=;
        b=IxQq/JqdmC57WAaq78Hj1UiTz0XNeRIpWqOdzo5jfSS+woeKLvqpgx1GGe30WRI19p
         Vm5fHLDo7ISdrqYsY7PmSpun4cINxZ+ZpXU+SDmTdMnXXkmrygWmEFR41sSLRp34xk3X
         TcshsE/lCtvEBfywUTjVKOdM0XRtRwhFFZkqolgfqlnyWUu5BfUpKGEIrxsOinjEscMN
         Z9xQIVXUJTBPQKZ61NNC37BGotKUJS1ZH/krfAS7Y1bltyUUF3PnzO8sIIMlk7rSnnnv
         1ObUMZNhKBPeU717XzzBWmLXr6AdD4exXdxkN5SsrNMIFjnFmsoEeyOi3HZHNQsZr0Nh
         LHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWJx+jaA9b6pNgs/sNaueKTtYmjHLYjBFtSCQddwJ1gcx4LQ+7wqHeC2qniblbGCBmxWmCO8ZUZ/ZHYhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xfkQzxCBzwOHoN4CnxXLI2zdPxxCqCMIz9SOchPWOjxfqA8y
	waJsPTJ7tBlww8DgKNODbVa4XGiS0bEybxlDu3Y2eEDT5nE6kiLJhRTh
X-Gm-Gg: ASbGncsvxXgr15PA6mPPZtd3wF1h6M8N+s/v9ntBS155di6DLYQDmQJYgmmeW5JC/tZ
	UbGq29d6+Nz2I1/3yUNnSzPoU/Pwl5BCvveMt4or7a2zo/z3SeiCQx5jUsIpb6ekJgU8bPZPusC
	cio6G6CcyWAVoTzDfLMiQssdgtWGZPkAct2Q73eZAgN74n0Amp433yVnmROJTwk8Zpw4dA58YEq
	ivDJhkCWkVif4IdqJZBVmUdlPpdU0uAhMxyag7yVbGbHnwDEtQfEx32ULr0GvjQoLMJkV+Rbh16
	up1mWk/ReyuVI4K5ca+Grd48mgjHIzJKWiTHacM2hK7MoX9mOcpid4aidpe6BmYkHAmTOHHtxAE
	el0ffBrqoXiDNUbf4PwZb7jByH3T1KtIwBMmIt5y7eBuChZZXB1htJywOQWn8euFR0Iq3M8OKbg
	DKlDOgLpoMB/wrMd3bZP2HMvk9aNCbKg2mMuEpcgqpvY6hr3RX3/u1GOcn
X-Google-Smtp-Source: AGHT+IGqYCR86ksAXMSbxGS3kKDImFaO+wj0FVOjmRbbKMm9CWkZuNs3ibEZwfK+6/EwUPZd5R0fMQ==
X-Received: by 2002:a17:907:c0d:b0:b70:ac7a:2a8b with SMTP id a640c23a62f3a-b72c0928d62mr192969366b.19.1762502885065;
        Fri, 07 Nov 2025 00:08:05 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf312e25sm177083666b.20.2025.11.07.00.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:04 -0800 (PST)
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
Subject: [PATCH net-next 5/8] net: dsa: b53: split reading search entry into their own functions
Date: Fri,  7 Nov 2025 09:07:46 +0100
Message-ID: <20251107080749.26936-6-jonas.gorski@gmail.com>
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

Split reading search entries into a function for each format.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 56 ++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index b13437ea21a0..fa4cf6ceddb8 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2076,28 +2076,48 @@ static int b53_arl_search_wait(struct b53_device *dev)
 	return -ETIMEDOUT;
 }
 
-static void b53_arl_search_rd(struct b53_device *dev, u8 idx,
-			      struct b53_arl_entry *ent)
+static void b53_arl_search_read_25(struct b53_device *dev, u8 idx,
+				   struct b53_arl_entry *ent)
 {
 	u64 mac_vid;
 
-	if (is5325(dev)) {
-		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_25,
-			   &mac_vid);
-		b53_arl_to_entry_25(ent, mac_vid);
-	} else if (is5365(dev)) {
-		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_65,
-			   &mac_vid);
-		b53_arl_to_entry_25(ent, mac_vid);
-	} else {
-		u32 fwd_entry;
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_25,
+		   &mac_vid);
+	b53_arl_to_entry_25(ent, mac_vid);
+}
 
-		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_MACVID(idx),
-			   &mac_vid);
-		b53_read32(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL(idx),
-			   &fwd_entry);
-		b53_arl_to_entry(ent, mac_vid, fwd_entry);
-	}
+static void b53_arl_search_read_65(struct b53_device *dev, u8 idx,
+				   struct b53_arl_entry *ent)
+{
+	u64 mac_vid;
+
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_65,
+		   &mac_vid);
+	b53_arl_to_entry_25(ent, mac_vid);
+}
+
+static void b53_arl_search_read_95(struct b53_device *dev, u8 idx,
+				   struct b53_arl_entry *ent)
+{
+	u32 fwd_entry;
+	u64 mac_vid;
+
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_MACVID(idx),
+		   &mac_vid);
+	b53_read32(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL(idx),
+		   &fwd_entry);
+	b53_arl_to_entry(ent, mac_vid, fwd_entry);
+}
+
+static void b53_arl_search_rd(struct b53_device *dev, u8 idx,
+			      struct b53_arl_entry *ent)
+{
+	if (is5325(dev))
+		b53_arl_search_read_25(dev, idx, ent);
+	else if (is5365(dev))
+		b53_arl_search_read_65(dev, idx, ent);
+	else
+		b53_arl_search_read_95(dev, idx, ent);
 }
 
 static int b53_fdb_copy(int port, const struct b53_arl_entry *ent,
-- 
2.43.0


