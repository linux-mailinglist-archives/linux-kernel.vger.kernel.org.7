Return-Path: <linux-kernel+bounces-848883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F76CBCEC0B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 552A04E2896
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024AC27A92F;
	Fri, 10 Oct 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9A9V2g9"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BD2264D9
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139055; cv=none; b=U91tVDaSqQLWfBBsjVRiH9RwMlWV5lh68WQLLL+s3Q29wtL6jMVf5OHvfh7c9q1npZT+k2+/HsdIXio4zJKiWtXLCqW3or7j5v+pR++TAPqbEGVv8/MF9Ze7c9FKU4eWploB1X5NLvXhomM1maxCjkTiwu5ZWRooYk35mR/Ku1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139055; c=relaxed/simple;
	bh=FgkeBqOsjbeRgHk3I+MLzFTg/+x8XLDfjGktRioUugs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfj7JKAWUp93n9dbZAK1Jy5Oa2w6+n9C8zD2+HVXy4oZca8ZfAfTu0B4W64avGz89EvgxlatBvnmXOhuy0rm83biOps2+bs2NMq6GbJewSGZIxRfsqDG4D67nvH4BUEJS07iP7v4nIKwlwWrBiTMmYHsG7cacSKQXkCki9/e320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9A9V2g9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so2929235f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760139052; x=1760743852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYr/plm01c7dWtVorM1VEqtdk+b+bodf4xAATXQCqD4=;
        b=A9A9V2g9QWjo8TgHzeJGzFSBX9bqO9qN2PqX6bCzoadpz1o2c2ZpIwW930yLLJHULD
         6cJdtoVc+99EHpTo6BpmeMhXYECCxKYqRVh9Fqw4xN4VRZwYRl835qe9Btij33khJfFf
         mC5byDxrKqnrxvpu9irJaMuyT2ZRnt9kbQu5nbNSQCpdbtm8Dv8Y8bbe25oP+cUGVb3S
         fB0PCcVMcqYGIjJ9r6d4QSjxBD/ZHeV6UOu2Qdt1hTEdnFgio7tLfmS/1asxzCY7Hrgu
         rnnJ6mRNk+Gpvp/tN1yGd3M0zsYqHfrkyG9VLomuF6jsdeovotuzid+pHYcDhNuBtaks
         v2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760139052; x=1760743852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYr/plm01c7dWtVorM1VEqtdk+b+bodf4xAATXQCqD4=;
        b=TCmW2BvRB7qPdlJGsNTwFN1TvzQZpxCDDfBugP3pH4tmSPHsebw9yfIpGb3lrpAaVi
         QPV32I/h+r4RlTdmHHIwgpNTEi5Z7O3nmnk18qY9iSQkIvKRwxYcAz+w6cuuLRFGhnHN
         mEfb3NxVxFKsz52jFoQ6jo9ccW7ZBHk4TMIzuanbtS7tRmoDcN3uiXpi7cfrxJv1yTM5
         /BaputQOq4Su3GIThPV23BPvGovf3Jk6bArbpN1aZ68tH4lbbjeyWhT7W5ohrAhWj/b8
         OKv+0KVsrenMmDZjUOfoaj2K4vr4+X3NrSqRFksMlHTkQfqQsbKkqvj3Tp+Q3FAtJf6K
         LrkA==
X-Forwarded-Encrypted: i=1; AJvYcCUv/r3aRe7O6d5jcvBcoSQlBp0ylnxGsRKIfg+mBmbV/GpiAJ6cemBGedniHyI2vH1N5T3b0ZLdCSWDjwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gay2iHXadLtJFYXmCvtZYfQbUSNgYUY23yG3vjQ3zzpEGcWK
	h8ekfQxW6UFsBr2JfgipyVYI+AkY4L77PpBKfIqCU/yife2aeg6beJOF
X-Gm-Gg: ASbGncvp9J0pfYay9ShUbWiWir2+vJZcUHHOvxuOtwLplHi5KpFP/S4R0gvCwn6II6e
	8EfXAVCWZPbduZKYax6XoNc2NKanGwG1VVlBQ4JQ9ksfV9+2F3/PQW1OLkCXUDhmxgtHArOySIO
	07otwumNRSA/IoXcNUwpR3ESaT6xK9aHopfeTh5kBqih8ZBn4BUMnhhqVCis7Zt9ALiYtGGYBRT
	fonPsrAdQGOptECemLt9ujP6OsTlrFx3FhtzkeQD6SJVpdZaaEDbs5/KglXW2A/3KkPoAJGz/HN
	6fP9/CcdA1V/YLunW0xvZLO0SgWrKM22PfFchovzmpAuAAnJdqQaYbWqdg28q41fJ2rTk0TfLx0
	rC6Dn65of3uxgO8/L5Y1vScQum/iVPnqywuaYLnb0FfELuR+fSBxFW92G9w8ZGRYl4CqAGHQ=
X-Google-Smtp-Source: AGHT+IFqPw4sYIB50Io+H/SuLeNfDS9P+mnMvCkA8IUq8QpQMFXeHi54SsLgJvs3nQqSlmFllLSIWA==
X-Received: by 2002:a05:6000:26c2:b0:3e1:9b75:f0b8 with SMTP id ffacd0b85a97d-4266e8dc01amr8910838f8f.47.1760139051881;
        Fri, 10 Oct 2025 16:30:51 -0700 (PDT)
Received: from snakeroot ([109.175.243.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497af18sm67941985e9.3.2025.10.10.16.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 16:30:51 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/intel: Add MSI X870E Tomahawk to denylist
Date: Sat, 11 Oct 2025 00:28:29 +0100
Message-ID: <20251010233026.5207-2-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This motherboard uses USB audio instead, causing this driver to complain
about "no codecs found!".
Add it to the denylist to silence the warning.

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 sound/hda/controllers/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 48c52a207024..a19258c95886 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -2075,6 +2075,7 @@ static const struct pci_device_id driver_denylist[] = {
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1043, 0x874f) }, /* ASUS ROG Zenith II / Strix */
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb59) }, /* MSI TRX40 Creator */
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb60) }, /* MSI TRX40 */
+	{ PCI_DEVICE_SUB(0x1022, 0x15e3, 0x1462, 0xee59) }, /* MSI X870E Tomahawk WiFi */
 	{}
 };
 
-- 
2.51.0


