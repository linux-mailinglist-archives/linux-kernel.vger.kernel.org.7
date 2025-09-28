Return-Path: <linux-kernel+bounces-835405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 158ACBA6FF0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C282817C2F1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECC31F1302;
	Sun, 28 Sep 2025 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWsIB1FU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252CD2DEA72
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759059253; cv=none; b=TAo0IBTVtd9169Na8X/sHCe3u/s57v0j7A9f/HhIDZkOwraYlNVKduXhDJ85vHTKCrZG9x5Wa874++e3hREw+N8/2bAb9zfkO0jGb5DES7zIhuQvRuY33QbcZu/7tRjT5vvwwTwLLXFfasmexMPF8LPn158Rko9sxlkZdjVW/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759059253; c=relaxed/simple;
	bh=8ddmUCo0RkiFpMjJDEU/SY+VKBZq9Ul1pKd0v1NhVgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQsCZveWe0YWLw3wXUBaWFyPETsapuMG8m1BJ8dbqcjm7+0lTeWN04tPK1SQ5oRKFeI5bkefJ54fIm5KzSuY5z5jEB1asPuPw8+OfKgBVSIauJjaQGdU2jbbzgm6rS+ikK++uk0qO6uZT7nl89FJ0ubKPZoPUa8KKwrBQM1Oghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWsIB1FU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e29d65728so24499925e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759059250; x=1759664050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/brZK5qlrYAwJveH864FfVdXR8sYuWmR704zUR8n1o=;
        b=fWsIB1FUIW43ahvbgJDmVdFaVmd9dyb6RxvBMMGaUOmiC/OixpeoS5UbMSrYI3jx2X
         uYlYeiAPU3KmwEk5GUv87Tc8vxFZ+Hq3JrSbpO20gRGSHHQjqWvC1Xj6GXdwQY+6zMfW
         KppfGPTeIBjBITVR4P6pXiYIxg94vXam8oqrb0W5afX0GfUhHqU0HLHBMsYlEksma2CL
         ptU8fxmm27MaDhXSxEUnuomVfvJA4hmDTV9unuQweDGm410AIVND5ftRUrnBbjW8MAdj
         8xin9VCnLTc5wUYjoUPwMNFSNiTEA5d0CtKveCKbkf2ZSXMhiRINRAuSDfPwlIBfFeMQ
         /xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759059250; x=1759664050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/brZK5qlrYAwJveH864FfVdXR8sYuWmR704zUR8n1o=;
        b=WTt5LqByjF7Ok1JFqu7DvUNQM7LSM2WuJoQcRpP6StWTV7slyL2kSuKd88paUVAfjV
         19QQrBqx72a73elVBojTJJ6od5BeZJdGq6xPGxFZbw79+HzKXbMJZhGoBDQr58qdLeyX
         IJNwIQCANy8wS9U4d12qTDsixpTQK4rKtc6UKNc6/XgVehxYMbLbe3i6MXs66jXPmS9g
         oHZ5/Kj8ZFgoGwGk2oaohakHmUyzWM6Lpi7RRhl64rtPd4VRcdW6Uu3Kd6gOO5OfO0p9
         a6XH9oMGtIR3gu/TvdHLIB9fi7bqoNZG/eol4HsiwLVmHr7bi3dtPOwkxqGbQnwkUiL6
         bfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLMnvzWtUWToQDfXjS+M4p3fs+4cUPYhMw0pgkKezXE9HVkGzntPEn5ALw02mjc72eN8aRxoUMO1dEs7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsUf7FXg+IsHJrpQRkQn3UonsGSc2jWaDAcdY8OS+oevFT0Vw
	tDhutnptrVDCVtNtJberpy/81GrFs2DaTZhU8DvPuQ452Fyp6IUi0Wxz
X-Gm-Gg: ASbGncvc4SKoNAtFUTkCskc+l4LCuAyiovynb7y1eRreo7OLSfHWS9WcDNM1YLLbJg0
	yrX9yqSR9e3RjlXSPL3vekd/c40ZpdJUjQtxFlxuHwbGObtWeLham/TJfKe31cCgJg+gD76UJJU
	H6QFsLoD3uulD0Jiywx3LMai64kDHUK4FnWAZhBeOpik7z5g+36sdJnSH4d7XVEA+WWVmIX7Aow
	FRECZgZf3B8gqQBjAlFRgkRKJSbtNZ48368EdG5gbh9SK4413VXOi2gHFV25Z81tl/oeG2i7NS+
	BPdOJ35t8ZU9ZrCJLe3r6uBmJBw1oBRBRu7CEp4G0/5XZrO1PrbFz3VLAmp8AJamiuAT9QKdRYR
	7a0iIYc9e+jEZgCZzKVbwDjUzFBhnUhWr09g2vkMsnW1T9sQl
X-Google-Smtp-Source: AGHT+IGiPWTYWAyv8Lm3Tcc9D4kIBKkJOKajbBpkfo6tPA7baawIt7o7+KctTbkc52CFMBbP2N2Vtg==
X-Received: by 2002:a05:6000:4313:b0:3fd:eb15:772 with SMTP id ffacd0b85a97d-40e44777382mr9306072f8f.9.1759059250377;
        Sun, 28 Sep 2025 04:34:10 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996c03sm187074365e9.3.2025.09.28.04.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 04:34:08 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 2/2] staging: gpib: Return -EINTR on device clear
Date: Sun, 28 Sep 2025 13:33:59 +0200
Message-ID: <20250928113359.6197-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928113359.6197-1-dpenkler@gmail.com>
References: <20250928113359.6197-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ATN (Attention) line is asserted during a read we get a
NIUSB_ATN_STATE_ERROR during a read. For the controller to send a
device clear it asserts ATN. Normally this is an error but in the case
of a device clear it should be regarded as an interrupt.

Return -EINTR when the Device Clear Active State (DCAS) is entered
else signal an error with dev_dbg with status instead of just dev_err.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index ea44a766fda2..1f8412de9fa3 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -697,8 +697,12 @@ static int ni_usb_read(struct gpib_board *board, u8 *buffer, size_t length,
 		 */
 		break;
 	case NIUSB_ATN_STATE_ERROR:
-		retval = -EIO;
-		dev_err(&usb_dev->dev, "read when ATN set\n");
+		if (status.ibsta & DCAS) {
+			retval = -EINTR;
+		} else {
+			retval = -EIO;
+			dev_dbg(&usb_dev->dev, "read when ATN set stat: 0x%06x\n", status.ibsta);
+		}
 		break;
 	case NIUSB_ADDRESSING_ERROR:
 		retval = -EIO;
-- 
2.51.0


