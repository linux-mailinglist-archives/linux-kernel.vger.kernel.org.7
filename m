Return-Path: <linux-kernel+bounces-867376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B612C02713
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E5324E4478
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476DA2D739C;
	Thu, 23 Oct 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQEz05TZ"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7212D592B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236841; cv=none; b=s6s5S5L/Yfkxcl+m/WM0Pq+Z3XkTOlyZNEYeWf1i8cpz4sH/Rz5RN/Azc5nnCitIOO8w56w7ry4NbiXnDFHJUdNXUgVqh21XCuaOGIwTBUe4Jpp6e4xsxdGmflJNADIdB9oLuXpcF/cQrkaBuBjNvQCWHwqlLyVk5fy9q3IsoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236841; c=relaxed/simple;
	bh=eIKrqlXU/8n9AqT0k1+v3qjg2Q9CMZzbVJvOLiJgpEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nm79U7t0cgxbAtrCHp1Sipx27PWm4Bhl8aFoMBW7gEG0bvKcDmSrrlldLOx3XCDV8eIqsV9qs7WtYdF8Coyy1QgjLsTjk4FFwrRusZfPMOmAN6kmUjovi1FRpJFKr+lDX2uICcNXS9aXPzCRAtolFdzSU2tWmVTgLJnQ9CmVRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQEz05TZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c20106cbeso13945126d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761236838; x=1761841638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2imvIwdo3P7V8AuAbuO7jvkCgPpqmVrl6exJRyM00DU=;
        b=KQEz05TZ80Z8FaTDYpyks3wM809T9FmSZ1mAadKM0nn8RCiyzsFyl4JwFTCxpuz1pe
         kheMGCswjGQEbyByrZL1bnUknNblylIJ5P2BrCjwu4dkcDgDdNkYga1jK9UrwhPHhZJJ
         QWwQaVEidby/f+FG4HkV+/UCH3naPtF1+z5VIe+Ai3u3o1guq2xok/dTJ0Jujc0N3FkQ
         5d2sPQxUWpJrcr2cqr57SGYHjkBv7Nz67SWNm9IDM0soVQrA+IqNE0WzQWArhjZLqUjl
         hb/n1WBFnAKdNZ+i5b3/eqTcm6Jqg6KZiBJexKlrSfYPsFj9Chr5vmdawaKuKancynmU
         71Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236838; x=1761841638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2imvIwdo3P7V8AuAbuO7jvkCgPpqmVrl6exJRyM00DU=;
        b=PzR/RRlzd8ZBiA8AU001dvB9Y1xR1FSVjpEz9X/xF9f/qSoBW8zE64Y0kDaCOuYZ6s
         wnMZefXv+eQqQhgYy1on8OYt7lG8K9kwu7uD0wV9k895hXGaE6T+7ASmEwQVBF6mJ+WB
         40xTnJejQIhoUJMqxHmnQfSdMbhhhGwR5bNsLA1Ag2gJD3eGzB8O4MFDTBl8U2nk9KHb
         n/frSwO4s5b6D2Hpu1QTAeKgf/RMy1/09YVmjw6jepURqsDmOcRxotoQ5Cj16N69O7qz
         ABny3bP1JgG6Hr/1FpSWw5bB+fJ2MuC9d35nT/HUS87Hyht6v+amuNgbTMSkuW789Xkk
         mWbw==
X-Forwarded-Encrypted: i=1; AJvYcCW2yGHLEUK3qrEZjFTzSeWp3zP+4OhOz3CNCMgybLHbxyU9k/xqCmgt6xPVRCmxti/F25qQ5wsqjkZcs34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tIGoqf1RK5SEf+fM5j+UWGxy5BJhl1veOzEFE5bvUyTt4TYG
	mPxXGALw49lDRAwmye+/+cn1imp4oj1vbYYK4rCJTKoeMILm+Kz9TNYv
X-Gm-Gg: ASbGnctqvOIanOBmfvar8b5XuJOYUGB9AkMJXdRfhwuRGmhE0RCO/FXPB20sZ08I4WO
	0Zk+6XZEG0EJ4tWSMpUou2mVEkoKIANX9CgWJHJp/N+syOs2a28ZGQN9JsbelV6Z/lvMMjhYv6p
	uAgZlD8xd4VstXvdH+NQdRt/TkMkfzWqi3t3cpW8mBZT9iUeWt4K3HhuamD6Y3w3TND6d63zECu
	Ofj3cYEY1GucJj+1FmTY5x2kDEv5p6LOLCAg4PUHzJM//SbDDrLQNB2bnUj/zSmuTPc9jflguOJ
	1Cxfa1QR3hRhJoXtFcwOm5iV42IHdLjBa6Wa4nyjsaVbMw9OJoS+aX3IbH5EKOXGwWJ/MEf1oIg
	E+cBisEt6lBH+HKehz8ckXBgOsPPFiEWu/L6Ui8FdpKlFN9sVfjZeVpn5/IaAkkIQ0bsN8fqoaD
	RoIqI6TXZa0Z+UYPquMC667qJWfDck3dbTk3h5hDgwQbbDuuDKLDLLAA1nVjwdy+HAf96EXdKi4
	R+dt5olCt83LMyddRlHtZNPnSUQKFlv2OpDSpg+ZPs=
X-Google-Smtp-Source: AGHT+IG/t8sPFUNbEssBw0o8EJ7IDLcRUAqafB6jh5jOeBHVSLTybCLKZLOZDFW2qLfhUheRhw2XiQ==
X-Received: by 2002:a05:6214:260a:b0:87c:2919:7db3 with SMTP id 6a1803df08f44-87c291981c2mr239330876d6.51.1761236837786;
        Thu, 23 Oct 2025 09:27:17 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e7fc743sm18286456d6.52.2025.10.23.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:27:17 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jimmy Assarsson <extja@kvaser.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] can: kvaser_usb: leaf: Fix potential infinite loop in command parsers
Date: Thu, 23 Oct 2025 12:27:09 -0400
Message-ID: <20251023162709.348240-1-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAsoPpV7Kzap1Sn8QFtBbvwW-DJMTTcU_bBOUDYYC286Uaddtg@mail.gmail.com>
References: <CAAsoPpV7Kzap1Sn8QFtBbvwW-DJMTTcU_bBOUDYYC286Uaddtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The `kvaser_usb_leaf_wait_cmd()` and `kvaser_usb_leaf_read_bulk_callback`
functions contain logic to zero-length commands. These commands are used
to align data to the USB endpoint's wMaxPacketSize boundary.

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


