Return-Path: <linux-kernel+bounces-835116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB8BBA650F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D81917C48F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149EA1BEF7E;
	Sun, 28 Sep 2025 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5yn2hYH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA925BA3F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759019060; cv=none; b=sGDUqSsSai1/o5o0MELhEcABipzWdObX/kXyejqGADc1LICa14/F0sKgBzOikbo/nm/eAC/UMXVXQf5+ZQbkam/o+IhE+YZLo54Y1dbF0JpX/2+eFBJxM5p/XjPCIehxS8EjUJM9K2BAwbyp1y69MBA8u3DYQnbC6Ch9qlmWqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759019060; c=relaxed/simple;
	bh=ba6wzr+UFiyiYoFNVhxsMUJoo6ADljhE38nRvbuUDTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xixb2EU+3U1wUuncuiqUJEXxVO3Sn3asOGtsHFlODueHPZqquAw3dSOOF3HNLUipvL2WFPyQXvCVRDZf9rJR/oWkygWU7ucnXMk8WMfoBt2imWxiMRf1VyefEmWQW/iaH5oQDBmMXHkr0ePjwLOiOLnIjrlrWCFtXFaOvgHmnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5yn2hYH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759019057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=psSCqpeBnzhLzJkdjUsfUs2VDXVmpZ0fDDgl3ZWHtDc=;
	b=G5yn2hYHTgUlPtWNeJcRT28sDHNhvEmx6h+QiMcHih1RTux3zCWfrEKSkAYNt7iN3prgDv
	tCaPTPT8FLWA7IPLeknbKaPLrN/KOxuSK1p0s+JeSXm0AUEGYkSxFWQW69MnhHtoU7aQvC
	mWW7Xre8fO2jQYUu1/cmXAW/Jf7MonM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-rlwKVnWvOeyQ4b53S3P5aQ-1; Sat, 27 Sep 2025 20:24:14 -0400
X-MC-Unique: rlwKVnWvOeyQ4b53S3P5aQ-1
X-Mimecast-MFC-AGG-ID: rlwKVnWvOeyQ4b53S3P5aQ_1759019053
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d9a3ca3ec8so65678881cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 17:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759019053; x=1759623853;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psSCqpeBnzhLzJkdjUsfUs2VDXVmpZ0fDDgl3ZWHtDc=;
        b=SnvcnOCO7BbTRaMZc/YTtdefsNXuWLHipdPTzW2tPzdFjW4n6Ny+HtLvt1FMVrwWtw
         5oK3BSHYysQw+gwVosxzgvIo71/ANQmhiArZqkCx6BPJbAr63WGirJoYX/w+ovS0v/43
         1QxARscybA9lY1U69Y33LED+r+5pGi2VZKwXCVFkR+Pwod0OQSYtY1QXtaG/Lhsn+vLz
         p+OHDxhLqJ/kEzRXZ3mniMd3Lr0meyAkboQNz1+SaDfSDbcBIxJAD4269LRMgfpByjrb
         gPHYeaMcPDTSXYWlIOS9aQ1T2lUBqGocVJMBkUYjYws5EFzyLV4Vp4VPDMUW3kq2sy33
         pO0w==
X-Forwarded-Encrypted: i=1; AJvYcCUV6fuLI466SCE5q0eEVxBs8Vvd2NAIxcSoox6ryJ6byIy9E4aDH3JFh3TAQzShlzn4+fsNR/JkIg476NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxckzcFmTrV5MnseMPRXrVcEwR4yZvaShYh4abiebU4fOkYwafy
	g+39z190XFh23a0nFftnKAeb7Ji497UPAKPRnVZCrPbMu6jRnZYYMkQPjSo+5NbjrNkex0+O6aj
	D1ZF1zou+BhAtG2MKSUrxSs7a7QQ+lI8VEpmZK0B2juxF79Kt9IOYASWNpY0oL4gf4w==
X-Gm-Gg: ASbGncsUh9dbNsMQtp4cpOxNkC2csWjbZUS13WbpCymL3CoreahpxI81q1qRbZtIavC
	wq0Dsf1gCKqUH78d/rZgRUXTcxYSRYbYwiyMCe/pU7BHGEDYP7zXEONiR91lMPc3t2MsYYdI2aC
	QHsdh/IIEYagQOVy/jW77TjvYglsJph0VAczEgYDkXMFRuVxv+0lCQ5oMcGB7Z51+9tRQMj9He6
	68zzljhko09fN+f/pDQmuBG2cMilbGQtuKEDIl9xL/l93YdO3/l1TT1/bWX3+mjGeutJy6UJEHo
	Xsg4gBKRod8WHeoh7vWBf9JISTzpyHLrAojCqSJtCJRtHGJog8OZ47FzTolmbTu880UoLToPTGz
	HqUmvB3Vq4fDovXurQJjQZHX9QmTyUpndw64c
X-Received: by 2002:a05:622a:581a:b0:4b5:e49d:806d with SMTP id d75a77b69052e-4da4bfbda28mr165454971cf.55.1759019053481;
        Sat, 27 Sep 2025 17:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyQvKy9OezR3GY2xuXQhprsGnXj00ibUT8p4YTmVwsRyJDVxfzmm+JhnWEed6nQBwgNhgfBg==
X-Received: by 2002:a05:622a:581a:b0:4b5:e49d:806d with SMTP id d75a77b69052e-4da4bfbda28mr165454781cf.55.1759019053103;
        Sat, 27 Sep 2025 17:24:13 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b94353fsm48463401cf.21.2025.09.27.17.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 17:24:12 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sat, 27 Sep 2025 20:24:00 -0400
Subject: [PATCH next] clk: microchip: core: remove duplicate
 roclk_determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-clk-microchip-core-compile-error-v1-1-c5c3bd633c5b@redhat.com>
X-B4-Tracking: v=1; b=H4sIAB+A2GgC/x2NwQqDMBAFf0X23IU0IFZ/pXgo64su1SRsRATx3
 xt6GZjLzEUFpig0NBcZDi2aYpXnoyFZPnEG61SdvPOt633Hsn55U7Eki2aWZKjYsq5gmCXjgPA
 S7zC1AVQz2RD0/C/eFHHuNN73D/ZpznN4AAAA
X-Change-ID: 20250927-clk-microchip-core-compile-error-fef8c20ed5fe
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=ba6wzr+UFiyiYoFNVhxsMUJoo6ADljhE38nRvbuUDTg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJuNGjldiv//RN+t0fu8kS7hQF5G2MWrfjXJmcTFKxpX
 lhk/Cipo5SFQYyLQVZMkWVJrlFBROoq23t3NFlg5rAygQxh4OIUgIkU2TIyPL1/o6765IaO00qp
 JvsZ7y4/kOnzwnPf1ybHS6zbX5/cZMXwV3btnFcfo4O38vGWXKpfxJpsOH3GtcoJp65b9T+TlXV
 9zQsA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Fix compiler error caused by the round_rate() to determine_rate()
migration.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
I didn't cross compile the original series on MIPS, and this driver
isn't compiled with COMPILE_TEST. I couldn't enable COMPILE_TEST for
this driver because of the asm/mach-pic32/pic32.h include.

I didn't include a Fixes tag since the original commit didn't make it's
way into Linus's tree yet. I'm not sure if you want to squash this, or
include it as a separate commit.

Fixes: e9f039c08cdc ("clk: microchip: core: convert from round_rate() to determine_rate()")

The SHA is from next-20250926.
---
 drivers/clk/microchip/clk-core.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/microchip/clk-core.c b/drivers/clk/microchip/clk-core.c
index 3e03e10539c72cc28e53401093e37409c2ea3d08..b34348d491f3e1b576b2b9a8a66bfddd8c2296ea 100644
--- a/drivers/clk/microchip/clk-core.c
+++ b/drivers/clk/microchip/clk-core.c
@@ -374,20 +374,6 @@ static unsigned long roclk_recalc_rate(struct clk_hw *hw,
 	return roclk_calc_rate(parent_rate, rodiv, rotrim);
 }
 
-static int roclk_determine_rate(struct clk_hw *hw,
-				struct clk_rate_request *req)
-{
-	u32 rotrim, rodiv;
-
-	/* calculate dividers for new rate */
-	roclk_calc_div_trim(req->rate, req->best_parent_rate, &rodiv, &rotrim);
-
-	/* caclulate new rate (rounding) based on new rodiv & rotrim */
-	req->rate = roclk_calc_rate(req->best_parent_rate, rodiv, rotrim);
-
-	return 0;
-}
-
 static int roclk_determine_rate(struct clk_hw *hw,
 				struct clk_rate_request *req)
 {
@@ -398,6 +384,8 @@ static int roclk_determine_rate(struct clk_hw *hw,
 
 	/* find a parent which can generate nearest clkrate >= rate */
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		u32 rotrim, rodiv;
+
 		/* get parent */
 		parent_clk = clk_hw_get_parent_by_index(hw, i);
 		if (!parent_clk)
@@ -408,7 +396,12 @@ static int roclk_determine_rate(struct clk_hw *hw,
 		if (req->rate > parent_rate)
 			continue;
 
-		nearest_rate = roclk_round_rate(hw, req->rate, &parent_rate);
+		/* calculate dividers for new rate */
+		roclk_calc_div_trim(req->rate, req->best_parent_rate, &rodiv, &rotrim);
+
+		/* caclulate new rate (rounding) based on new rodiv & rotrim */
+		nearest_rate = roclk_calc_rate(req->best_parent_rate, rodiv, rotrim);
+
 		delta = abs(nearest_rate - req->rate);
 		if ((nearest_rate >= req->rate) && (delta < best_delta)) {
 			best_parent_clk = parent_clk;

---
base-commit: 262858079afde6d367ce3db183c74d8a43a0e83f
change-id: 20250927-clk-microchip-core-compile-error-fef8c20ed5fe

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


