Return-Path: <linux-kernel+bounces-751777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE9B16D47
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB0D18C5220
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8227A2101AE;
	Thu, 31 Jul 2025 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQCHljKl"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53ED2AE74;
	Thu, 31 Jul 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949798; cv=none; b=Qi4sytyQWZVyQ2Bq3Vntfenp8uPbfi8Fm1q0u6t5aJggcZ+QRKF2vY2/0AC5aSebLMFrXaVxMa1B4JtGEeAJkp49toh6rnyW91NX8X3rUYPiOtzv7J6m6/OI4jmEnx16SjVAw0MgB0fThOspLmrc3roIspHM/nqVD+Oefid/BtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949798; c=relaxed/simple;
	bh=/3qyoptk+YyQLvomM07dubKiNi/6dayhVx7Ff+NcRS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3vUT2xM/2SADbkcc0FjM9VF5fm1pj2o0VNi9sLa/o30uN0M/0yf5m3bLXTKrAKz13/Dxx77RZBA1CCJfxjh4NO8wf+RfDIG+3lFah+2p0Uq84oLDtbz7UM374nNMZD4pZTpHVzvlFIek4DaQD0iQDtL6IZ6LNJ8sjlQnF9JMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQCHljKl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so158561b3a.2;
        Thu, 31 Jul 2025 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753949796; x=1754554596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhhYc2FY7ChMHO1jeNXy2jNY10kqnswuZ8GNXNYHgU4=;
        b=HQCHljKlW3B550lVNCnu8clYYuDaaTf6+ub8/8p1KEq0VBcv9BjrmqIsZc2PJ04Xnn
         bnQ17njdEzzv5XdU1dMDMs7q0TzG/wjoxLMpX4/TtGHX2JepmViCULr/6KC++GxTDI4G
         q94i067v4qbkluRfqhlg2MwNbye1X1WwpQ4TLAojl6vPNAxoiaWELHplwzF3ka1/jHEP
         Ouv0AktmHGWFC/S5yQekjEtEAsTZaw2CzCJduNhZobbOckhgP4Tz0/rSK83uTEHEXHjX
         j6nNuBkOR1va63SuN8KjUl1vloUxC3U59DuD0AuRS4AaVa314E7wYRqWbXLlQF7ym+MN
         ZSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949796; x=1754554596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhhYc2FY7ChMHO1jeNXy2jNY10kqnswuZ8GNXNYHgU4=;
        b=svojJ2Uk6bpqHBW9yxvuRsxLiPv56vE81n2J46bGG7HIa/wvUvx7ojgeZVmzbmUAeR
         e+8YXWh114XPnbG7d8VsZjaBme9U2pfS7ok25NCkqJBrVgWzv3v3i75A7ZiAFvG558T1
         3e9xu14/zydK9giaQZdcgEOe3d6y/Kzxt/6+Xf6+LESwr5KleocHs+YKKtH6CQKgWqyJ
         P7nRjG1aM3v2hz/tp3FV4tEkf4KJGS9dj4jQYhERHhGfb7YT5FPGzJanhgIGQWufDyps
         cYwFZCoV3C4AqKexg7LoYghX24b94LW8P3x1esQokj/y+5nnsfDQFlVfJ6sn97ymLsvM
         T+gw==
X-Forwarded-Encrypted: i=1; AJvYcCVSwWhcFJn0POhcFCyG6hKfXnMCjNrZ822sxA2Id3fVTPGNmqUl/ZO4pds1iMTfZebobtzExeNNsoyGaWE=@vger.kernel.org, AJvYcCXlfOvK5wfaPufTx6g4f/UUxX/2K4BGVtkBCXx+7rVqo3Csn35B+iv3HS8TXJ+3mT4VzIKW1ZDaR1XDCMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXCAN2IMbNnTj1jXOfjNx02NZS8ZjDlK+T5H77i7OWvggMinT
	mPAP+d1DatEUqKmyt/GGzwTVCGpxrKzMo6g5EKuDBXZgpce9j231LZ+P
X-Gm-Gg: ASbGncseVU8f4n9P4UWjhibNVZR83abVwUE0csDthg/JzoZ3akDFghv9oZIm8ac55YH
	m4BGpAANGHzn3J9ekeyMzzjHd4EBcJ80SQ5EY33FF4ZmSzq7SUAMcbNhuYV1hfNym5SPlWpANDc
	7E15WUpa/vHaSucZ7SQkBBNnn4XNx2bCP3wTuGun1KLUbAODFlexJ+83EPKpVyCR6oPMHNL/gyf
	0PGfcLrDrbJV5q/SPOwxV4p0EpVT9RmcgjVyZnCZyC6DqHMhFFrPBe8Vt2g5G2ST/TrsuTXd39u
	fmOhAfNwJhNJHxPEntcC2r4jVIDaUPFIRFJeOTxTIfoVviW4tE5AJdqmXs8VHiKSzEaZu4ockNw
	MQ+NwvW8OPDlt+k3kR68noafVWNBQYGCg04EFStFszgk797IEct/zdVrmkBb9NKQ2iZzbYPbWGf
	jKWjefY2t2C0wQyzMwp5rfrHk=
X-Google-Smtp-Source: AGHT+IHj6NjQywUHTiDaLbP3vxQzZ/gFBItupW42UFts6aGdA0Ob9uvcPWOg+9pKWvhZ9Jl19LRSxQ==
X-Received: by 2002:a05:6a00:1890:b0:76b:cdce:484f with SMTP id d2e1a72fcca58-76bcdce5e86mr1992297b3a.3.1753949795882;
        Thu, 31 Jul 2025 01:16:35 -0700 (PDT)
Received: from 25.04 (2001-b011-700e-36ca-566e-86ea-9a3d-92ba.dynamic-ip6.hinet.net. [2001:b011:700e:36ca:566e:86ea:9a3d:92ba])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bafcce2sm907975a12.52.2025.07.31.01.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 01:16:35 -0700 (PDT)
From: noble228@gmail.com
To: tiwai@suse.com
Cc: perex@perex.cz,
	hulianqin@vivo.com,
	lina+kernel@asahilina.net,
	cyan.vtb@gmail.com,
	dan.carpenter@linaro.org,
	bsevens@google.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"noble.yang" <noble.yang@comtrue-inc.com>
Subject: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB Audio device
Date: Thu, 31 Jul 2025 16:15:59 +0800
Message-ID: <20250731081559.10842-1-noble228@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "noble.yang" <noble.yang@comtrue-inc.com>

Signed-off-by: noble.yang <noble.yang@comtrue-inc.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index bd24f3a78ea9..cbb66125f839 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2408,6 +2408,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2d87, /* Cayin device */
 		   QUIRK_FLAG_DSD_RAW),
+        VENDOR_FLG(0x2fc6, /* Comture-inc devices */
+		   QUIRK_FLAG_DSD_RAW),	   
 	VENDOR_FLG(0x3336, /* HEM devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3353, /* Khadas devices */
-- 
2.48.1


