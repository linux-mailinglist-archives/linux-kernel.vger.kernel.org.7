Return-Path: <linux-kernel+bounces-866043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6FBFEC18
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5C4E34FC5C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5B19F13F;
	Thu, 23 Oct 2025 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqDmdwHd"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8591A08DB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761180066; cv=none; b=VxrCQrdtsBWowa0pHAeOpQR9r9twISiTqY4j4DhIj3mQmDnDE0zIvqML+/QmNyYLqhSLZPPkALdwm+TVMRIsnLXtS9EXg1s3svzoLVte7BF+fNFGQzvOr+F3rC9jpd7X4nhdt1M57f3323XnNfwxZXV17QfmApbf0PeRisEVr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761180066; c=relaxed/simple;
	bh=7DgO2ExysMIKV0mplHDEQtusRwR+3gXIIcUSPZ9a3qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMvEHnvAqj4WPl7QjuvOApaQuZHoxP0+1rDK0au0I61TO+IfFrEYGzvPmdFqdSmHfRhnL7purjC8+arvJAGG4feYjGBOy56AgI11K229oxE6wLtKVAQcbFc5XwwnSeHSdKsH5L/UjnG5dnrnHsDvGrruEuQXKxLMnYG/FHmwyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqDmdwHd; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-79a7d439efbso1963976d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761180064; x=1761784864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71zx8jf+73P/W+rkuTFme2ni0Pfhc1L1pq1AvB/zgt4=;
        b=BqDmdwHd7gFJWo2QKoOh7yaVribh00aKVf/VUBa7z1OWQgp3JHJrRQliS7mHwjxnmJ
         oMLGdpj66SF9EIbwwIMQ8nUR8/4nVrzP6Bxxj461cb/PtVDHsxIHiGErTvvc44f6yH+f
         DOHBL8olqsLk3LnhRHBrd7s7YRx/Y2VkS2OHZ4t66Yvavu5Wkeo9L9AMhJal8DFHAHnh
         iqP7O7/fjBpi5/G/zpHwH41e5aqpD3c8krbqQQOi5VIX4EFAkguIXihx9P9odc6Ppbgt
         3AwOdiIadaF2JfpsC/mOBA6VnGcE4jWY1vAXVyPfQG7n6G2zG6LPqTTqFeBMOy4Yp5f4
         ho7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761180064; x=1761784864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71zx8jf+73P/W+rkuTFme2ni0Pfhc1L1pq1AvB/zgt4=;
        b=VPxiFh5cmfpLvKDDBG6rlQ+h3uqBhSpMKCkL/fim+QbroaAZF0+SPXrBHi/7NBUqUY
         iCJ+S/M2NYyvDZxyxq3EUorvWNeOsdindtGRHYPcnM9h8pkWY6r34UdeayEGaBfn34mP
         yeY+Whxnap+JJOVaHUycLHqJVVawv09ur2QbARBjgJ5vOjMMBQDLglfqmLQsGj7Rfv3N
         qPGCvBWOK9gSe0mKRWM0J8KDVIHouh3+nhULhABW6h2LmAENvj38dI5STC0pGgG8CV9x
         P54fjMPfwPX81YAwAz5qeEBCSkPyX9m0x0nhW4bPK9zI7wTkZ3R/L5p9lH1p30+gWpFW
         inzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Eqp5JTuxoRqmfb6i5QHuvZeWnBttFdOZ0YKbSawdd/sddPb9SRccxFP0iu02QNVBsKrGBZkcpcVCsMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPM7ho114wfTBwQbwHoJG/TUrL28NH8WZMhqKfhHouWuh3urQK
	Ck6QaZD/azCttZ5YVmbuN6SAP52nnjBDWMyhKA11B5/g+P5a4cxOX6K5
X-Gm-Gg: ASbGnctiGND2pjPgJwd4aMDzSa72hqATfsgkS1HCMZoDuzhOEK7Gcj2q7uyWwwc21Tv
	f+ZGGt9dozgAjV9DoAr6JAALKKoAOEs/FNOvVqoONMmtZaEOTaPigvUhCmJpuP55abWYXtmmPC0
	M4eF0MV0qVPDG1mR6eg5ZlQ9MbdYEmQNVf+Zqxrdi9EBquR1COOuJUUT2n3Owni4vzXgQi7GeUx
	AynuvF2oDphJOO/tILt0ToCREhngs66Byf8MBYfr5nRngTWdwM5ws3JXuG/Q7mjQ5bOPev1hYRt
	/uw5W4yLUdosaW+RCpJcTJaLv3rG6oRKBuYEw0wf3Eb/GZ3y9bxGpquErLNE3ue2/Nn4wy7+iiT
	CuQzduzrmasboG2pRe6MD2kNRNvSeHQQQ+QK/WL9CkkA67or8mztSTgiYqQWB5zTCPd2cwhtDyR
	kTYw/v0ypOyf+R6WHcYD/AZBFnpEQMMsVvdMmE0bhC/V8kIRFhq48Sc0eYW9TaTqoV2UkOJcTIs
	TWHyaOCl9rMj19t5k4d/oY2KruBUdRxFiu07+lYhc4=
X-Google-Smtp-Source: AGHT+IGd8qBUBkaazKZiy+1ZSStUtxhkxZdsF9kAwOsi+CRvWAqsTZFDBarOPynXY9b02PeUXMHAzA==
X-Received: by 2002:ad4:5741:0:b0:87e:d590:89b7 with SMTP id 6a1803df08f44-87f9eda1e5emr11114336d6.19.1761180064043;
        Wed, 22 Oct 2025 17:41:04 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9f8ede50sm3442506d6.49.2025.10.22.17.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:41:03 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jimmy Assarsson <extja@kvaser.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: kvaser_usb: leaf: Fix infinite loop on zero-length cmd
Date: Wed, 22 Oct 2025 20:39:09 -0400
Message-ID: <20251023003908.130468-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The `kvaser_usb_leaf_read_bulk_callback()` function parse received
command buffers from the device. The firmware may insert zero-length
placeholder commands to handle alignment with the USB endpoint's
wMaxPacketSize.

The driver attempts to skip these placeholders by aligning the buffer
position `pos` to the next packet boundary using `round_up()` function.

However, if zero-length command is found exactly on a packet boundary
(i.e., `pos` is a multiple of wMaxPacketSize, including 0), `round_up`
function will return the unchanged value of `pos`. This prevents `pos`
to be increased, causing an infinite loop in the parsing logic.

I fixed this in the function by using `pos + 1` instead. This ensures
that even if `pos` is on a boundary, the calculation is based on
`pos + 1`, forcing `round_up()` to always return the next aligned
boundary.

Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c29828a94ad0..4da6d4ba4e1e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
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

