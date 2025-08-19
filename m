Return-Path: <linux-kernel+bounces-775087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE5B2BB1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A588A1BC09E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B8B81732;
	Tue, 19 Aug 2025 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH/FHrlR"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7E265CC0;
	Tue, 19 Aug 2025 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589883; cv=none; b=D1jO6q8hCjc45o1pDG0XnVdnT07acONAIl6wjUS/iGvXKeo/qlcyqzVmR0PjBFS6k0m4uYlyZhZF3TY7ieo+NaMIhwvrPjne2GiZErvy5IsN2dL++NctFNZvCmYQdMQQ+oJdSRT/vTmWIAmQdWfV3REmmcbpBwhdIJVwHTW0MJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589883; c=relaxed/simple;
	bh=3k9u5LZQEUkZoUF1ZY244Bm/yCIAsRnEdGYJ1mociEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YQ8kGzquuf1PgjMrqDTjE4xIaFaUWqJTI4NjKMxfiaLLH9+KJiuh89Q9igJso943KLZgrfv7qH3xBjbESJl6L+4KzjXgqOwwjRWXDPIKkx3MIW/3hB1CA6tmgo/x7C+rg1rAm7i6LAkbL7/pITR7NkGPcn6qve1RThGetWUWdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH/FHrlR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb61f6044so832416366b.0;
        Tue, 19 Aug 2025 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755589880; x=1756194680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTuGzRayZKrEwv7EtQQOorRzKF9lVUpPF9b85RRyVlY=;
        b=gH/FHrlRRmeRykRR4gQwhMKoyRLOraWAZbO94Kh/hIzrw96BRoxg+MgeQwWOlAAv+3
         SRi6aUQtD5r2MYTv/MLJhbUE0BdBpJuL1F/BaTw3k9ilOQ1Qe6I3uS7l8H/r+EZHlNg0
         6q4GNBuwec4q1BjORK+GipCflBMGIb+scq+Tp2BmZL0CpCGZjZF1th0qO8R0k41TgaSM
         q0fwXfHcOUF3Pn+Map3ohXTZSUvzygtnpmHkEaznXMTKeSweb8na96FIggzCYS03InIg
         ZCOtDlNVH6236uyQeMj132KVYNPQ14/Cf0KD2y6KznUZONzlBcwn5blVQI0qcQ1fEY9H
         D7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589880; x=1756194680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTuGzRayZKrEwv7EtQQOorRzKF9lVUpPF9b85RRyVlY=;
        b=RyjuxWepi23eVyO2Nyv9djpiSLqM/ZxdxepxXk/TVoPDXccwI7/MnSnpiyl2karBBe
         50DbDaRw3Myco8MQKLnQKnbSiMuwSCjQk7K8/FkMxpDOQU9c+yz1aMULtE58Y2vGL388
         J/Wspvn9j1Pnt2ks0/p1ogzvcvpqxUh0P2B0PNgGp9KU/BJbaka/HFnxsYDmArxQdTax
         Xa9Zxn3jgxE23KvAVNHQ/sQ3qqFgXyry1Vo94JlLzwC8ewKb+DQmM4JapTwVLD8dvAcq
         O+uq+ei8PfKdKELMCsqJTdgCiNFClNi4BaXg5r00x0CcqsvZzcPYBg6FFGu6N12ajaar
         CnmA==
X-Forwarded-Encrypted: i=1; AJvYcCWDtdGlMo8wFlShAKuLltXqenIaNymbvIKGoGr3sDJVlSxUBeZRdpG4ZrJ3XwzLdPyPDugPqyajGlFlYoM=@vger.kernel.org, AJvYcCWf60zHWnCT4z49haBBMlmtSi7GIRBxAtfPCw5WxTui86ti15kWvwkxtdpYsCsx21gqdlOsKewv7w+pSRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLJMsewIcmZElY6mSiZ/IqA+YSS1/zRvYulPAMXQfmAu9qePi
	HFiD5sadjTEkU0BZIDPgrflusRhZyiot+WtFT/51wnBzzxO7LgEI2w52Pr2QcfG1xZI=
X-Gm-Gg: ASbGncvJk7bmZwLqrhyLyNGkU3NjfBgcbn/u/dORKX5zE02b9bEcyE9eXtV5qPu0mnL
	5qLFZIbru3P/bbbqTzopzNzz4QPOD6Q82akHMX6PJzKpU93ot8Niu6SEX/D8tflTN2jhFookgo6
	l79/M4WCl1C16Qra5BcEy/sw2QGXehOBgmvtvf6n5Ixdui+62eSL5Ua+OPRUbhgHQnh5ompPl7s
	ZfQqkz6Brpc3S6QM0JXnCMtFw+yRNdYR0ufM2Pc4lzSVdILZN66MRY8h/R2F7EiArzBbda9fR0b
	DnN/T/5+WWTYcJkrp3Rz2BuKd3eeIbAWhtWZUldYI5OFnvncgS+lBCkr2NN5BQjiz/wH/8EWyWs
	2NxX3itEgallhwxnE5YfRbxi4eYklnzlE1AqGg7uArq0qeBB83F9uHiZ0GFaYea+toaCPX1LQ
X-Google-Smtp-Source: AGHT+IEmyKv17T56iDLZqo9FBGeDJj4hc5GvAybxr/mgcRbrU5zZbDCjymQ7tP0kZu6qJ7tR6avUsg==
X-Received: by 2002:a17:907:9804:b0:af2:5687:c088 with SMTP id a640c23a62f3a-afddf09304bmr134954666b.14.1755589879791;
        Tue, 19 Aug 2025 00:51:19 -0700 (PDT)
Received: from cachyos-x8664 (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd010e1bsm939493866b.93.2025.08.19.00.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:51:19 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH] ALSA: usb-audio: us144mkii: Use le16_to_cpu() for product ID comparison
Date: Tue, 19 Aug 2025 09:51:17 +0200
Message-ID: <20250819075118.9221-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `us144mkii.c` driver was generating sparse warnings due to direct
comparisons of `dev->descriptor.idProduct` (a `__le16` type) with
integer constants. This commit resolves these warnings by explicitly
converting `idProduct` to a CPU-endian integer using `le16_to_cpu()`
before comparison.

This ensures correct handling of endianness and eliminates the sparse
warnings:
- `restricted __le16 degrades to integer`

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508190811.tjQJZI1X-lkp@intel.com/
Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index da53c1908..3127a3206 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -514,10 +514,10 @@ static int tascam_probe(struct usb_interface *intf,
 	}
 
 	strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
-	if (dev->descriptor.idProduct == USB_PID_TASCAM_US144) {
+	if (le16_to_cpu(dev->descriptor.idProduct) == USB_PID_TASCAM_US144) {
 		strscpy(card->shortname, "TASCAM US-144",
 			sizeof(card->shortname));
-	} else if (dev->descriptor.idProduct == USB_PID_TASCAM_US144MKII) {
+	} else if (le16_to_cpu(dev->descriptor.idProduct) == USB_PID_TASCAM_US144MKII) {
 		strscpy(card->shortname, "TASCAM US-144MKII",
 			sizeof(card->shortname));
 	} else {
-- 
2.50.1


