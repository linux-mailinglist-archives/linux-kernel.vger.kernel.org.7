Return-Path: <linux-kernel+bounces-867381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC563C02746
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49CA83475B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B93302140;
	Thu, 23 Oct 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFIxpRiU"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43F1C8606
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237074; cv=none; b=KJ1YgipGZWCh2UD5b/U81q7JdlNuBNH+WAIPy8U2eOclbaaN4H/gixKiooTVsZwoIMVV8b+9y5Y09rSUwU7HyxgulRxkpTRU7JyAdpa3hlX8ACSxykHkI/qfaXdcLniZT/Wa6YWhOYjvHgfSuOUyFgdO2X4ve3ljvXJbKqZzsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237074; c=relaxed/simple;
	bh=d9phPOIoXS1Mylr572coFt0mkocsbLyAVoqf4evoUog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtPb7qN8Xy9y1t7SLARELHqycVJtSv6DAyDKI32vWIKR85qHQjxHf5V9U9LiKEAGaaM/WKgutTHTgu8KxOd/xXUGxZk64lC/6U6ifH5N7n5C2CmuxzN9sR3RhqSAVRYN06esPpQhNKn0DmTRlSfyyT7yuqqgs1ZESN2hrU+XyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFIxpRiU; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-930ae1b2627so712087241.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761237070; x=1761841870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aJn+juvkfPf0gBRifqdOc31eW4SLDMd0Q6v5JVV+ZE=;
        b=MFIxpRiUtzuQHmibqhKU8jJcLk/5q9j7Qr7NwOui4hQPZtEzsTTgfS9HeL7F1lp9FN
         R1FVzqJn17hDUWVkVxTv6qkgSQ3YNVcYtddgTbcHxa93MsYyrZPrdG+Qqw/V9HQ2dPTd
         OXC314TCKKEYeT0tZHqGxKeLpEbROzQaVT75wIMYgHH8aGdTRVYCFECPXghs/H93UIGt
         ml61097JTIUkFPbMT/3+kP81quW0QsCZhLY9uKv1pWYG1ULdEVTU+X3DOgZjijwvbCX7
         587aDHrGeQ9q9ZxkiHLadNHFd3sS2g4DsJuY6VJEBsALg5Mwe8Xr/fQevSu+bn0hZ+q7
         j1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237070; x=1761841870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aJn+juvkfPf0gBRifqdOc31eW4SLDMd0Q6v5JVV+ZE=;
        b=eNXqp/cz7f8jXX1OPHBdmAIUBqW/biVP3GXwEnE4EUvY86VUHmnOO8H0P/u7Ot+Wzy
         x+nb8C7osteY16S1oSyZvjyhUQXKVy5KQWj/JrrhYTki20wLeiqijwVfYB6yn/8PVtPf
         gxn5sHmUvnrqwGKHOj6yWj6h6OXFVoF9HdPeUPuPa/CYKzV6gLYoTStCBH3WMga5hI88
         AVdjXCAtOVAPcnFF7ps+WttCI2QHYYgjLMyscDDceSfWDoTzudZJjathRrtG301e4+JT
         AshEkqmw75A7panVxWGMoHPVMit7zFoJ6Q0ytrB3YC0Aj1/+dJLOHm1gkGYyZqjk7XY+
         7RSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiOnCXrmGaepQaWV4UcFlFWbCO9c/XGCwadmTMb3rDtTLxDtrfz6NZkE/YWHvyEvhaMtAmmdARfloM+eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbA2dvMWAxpt9S633NDTetif5G4m2yR/0G+oWzbFXEPz2/tqcz
	AR8pk3tQ/ANJ2QFB17Zbw99k1bVIwdG+RR78QmTGZpiQ5mot1Kv9uFOv
X-Gm-Gg: ASbGncuKjz4iERj9mh+24uGnTt5dhcWxuDVHm8yTZ2SPxoeaRQ6KQITX4Ubp0lCmuac
	GdCI6BLpXkhRtrVH1L6nW6v2e0MkvZSyn2Ylj1DQnHa0DXIYLDqSoZWqCP3nzHwz6SSKpijke9g
	nYA3qaTZqVYBYMW3ku7aW8Betb2tOL1yIXqAYhcXnjsvZ74msVkjlzJvEAROYAUnzocV9SUYdPj
	aeE1NQriNyX/oLxL1i0wW2Yz1w/xNjDXm3cLBj+EsxH01dCZCeTKxdUXnyArtbzpkAKu4Q18lYS
	bg9wvCZaxi6g3v8MrHVGTlUDQ7YoDjxyPiWWTaDkE9bFnzgRzq/eQUMlQRzFZpGByuYuE4lRpU+
	33tVahjIeaNXyfgfznBLU+3PxttWHvxGZxB5G008KUwtlkt+HU13KwNZGFRBsxFjNd2QbL8MADa
	k41XUUMb5r08g3pisdlkvzW8qj9Y77yL9gcY6ZeOSD39t/7vuo9TW37qwRTXqWtQuhjFyw3c0P5
	koE1/JFqSF62YliAeImWV54yh6MK62N
X-Google-Smtp-Source: AGHT+IGrVvs+TnclUt0e8B7CFqCvUQf6Cb4TKo6WF2EpRnGombTba/6VdXIkUXDiaJc1GXH7IIHQLA==
X-Received: by 2002:a05:6102:4496:b0:5db:2715:d029 with SMTP id ada2fe7eead31-5db2715d99amr2100695137.43.1761237070297;
        Thu, 23 Oct 2025 09:31:10 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0dbcce43sm191757485a.5.2025.10.23.09.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:31:09 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jimmy Assarsson <extja@kvaser.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] can: kvaser_usb: leaf: Fix potential infinite loop in command parsers
Date: Thu, 23 Oct 2025 12:30:46 -0400
Message-ID: <20251023163046.349300-1-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023-athletic-courageous-pogona-1405d3-mkl@pengutronix.de>
References: <20251023-athletic-courageous-pogona-1405d3-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

`kvaser_usb_leaf_wait_cmd()` and `kvaser_usb_leaf_read_bulk_callback`
functions contain logic to handle zero-length commands. These commands
are used to align data to the USB endpoint's wMaxPacketSize boundary.

The driver attempts to skip these placeholders by aligning the buffer
position `pos` to the next packet boundary using `round_up()` function.

However, if zero-length command is found exactly on a packet boundary
(i.e., `pos` is a multiple of wMaxPacketSize, including 0), `round_up`
function will return the unchanged value of `pos`. This prevents `pos`
to be increased, causing an infinite loop in the parsing logic.

This patch fixes this in the function by using `pos + 1` instead.
This ensures that even if `pos` is on a boundary, the calculation is
based on `pos + 1`, forcing `round_up()` to always return the next
aligned boundary.

Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Apply the same infinite loop fix to kvaser_usb_leaf_wait_cmd()
 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c29828a94ad0..1167d38344f1 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -685,7 +685,7 @@ static int kvaser_usb_leaf_wait_cmd(const struct kvaser_usb *dev, u8 id,
 			 * for further details.
 			 */
 			if (tmp->len == 0) {
-				pos = round_up(pos,
+				pos = round_up(pos + 1,
 					       le16_to_cpu
 						(dev->bulk_in->wMaxPacketSize));
 				continue;
@@ -1732,7 +1732,7 @@ static void kvaser_usb_leaf_read_bulk_callback(struct kvaser_usb *dev,
 		 * number of events in case of a heavy rx load on the bus.
 		 */
 		if (cmd->len == 0) {
-			pos = round_up(pos, le16_to_cpu
+			pos = round_up(pos + 1, le16_to_cpu
 						(dev->bulk_in->wMaxPacketSize));
 			continue;
 		}
-- 
2.43.0


