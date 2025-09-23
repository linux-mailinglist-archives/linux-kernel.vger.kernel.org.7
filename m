Return-Path: <linux-kernel+bounces-829708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B8B97AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBD019C80B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318730C36A;
	Tue, 23 Sep 2025 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8tlKK36"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5B30C357
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665242; cv=none; b=bvXvJtE4V6tUbyVkLKAg9v01YqfInQI5CnlEh4m8+WP7QsDe34y4VdpR3C0Gf8ea29XVHPPRjBFsOK7Y7AkjpGz7zqSKss0tRBUAB1aOlvTWtKREppKbFxuyCivmMBHKtOJk7Vb6tDxgBpiYwABg6pX/PeUSBnXaBHCxzV1Yi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665242; c=relaxed/simple;
	bh=IctFuTYxR5b2i76fpliDW/duU8uZ4S1DduU8Uaoa2vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNt6L3iPbsWipghmFshujDH725HzFhxi1IFSJqxXpjHh3BYf62/+y9pAu2hTXxolP3cdCfs7kITNP+8mXT+9kVAZfyqf95NdLVMcmm2lz2ZsxNjSuccqGqJQaFs6RxVNOQ9iOBJxwn3dl4BO2Mf9fBpSXbZ8ukLXZiE2gFUzMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l8tlKK36; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-269af38418aso65730205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758665240; x=1759270040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pX7rCi7/xF3CzW2LGTp+sVuxts9A6Ss/MmxTLrjnoqc=;
        b=l8tlKK36HX4L9oKc2illV2j08MNY9fUC/PDYKU4PY4bXWC8i7jEwIqGAiqYFObJZXx
         vg9M06ZiFx1fJ8KIi9k7ZffeCPWvguMv6FdrSqLW0fJiHhLk99FQ80tzu4VIpB8Wx8KF
         Vy6mt7bmq3BFtTR4Ex2a2nQ8jQ8HEoIYKNq3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758665240; x=1759270040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX7rCi7/xF3CzW2LGTp+sVuxts9A6Ss/MmxTLrjnoqc=;
        b=bEzwVsKxgt0G9iTVsQ59e8/gi4AFi/FyAE0Aw36EEW5epuEI61EPdbp/eKPlhw3m7J
         cBM2yA1diVGZoJyrbM3h5LbvyJIeymZx4bDp7qOcyBFJCdSKtuyyiR4UmAVhWUfpCrzF
         o8OqdyWaqmrwYp0GW4k2n7NvJ76ViJ7FoJAPtghKj1iV+dgbwJHnJGDFqS/G3XSvCW8d
         A/iKMnNiOTrAQE5hvb156Wr+NMRcnJa/XSXOQqgPb6fRuqS7lZdNvv42rVoXs91Tkquq
         t/7b92zp7lzCWqZa2mn4oFWOumYlEnqhenUOqLzyHj+WF0LZNzP5Z/QQu5AH8Qndb4Ut
         MGIw==
X-Forwarded-Encrypted: i=1; AJvYcCUZIkTnFRjE+wy753+fmQsRpfkUlHQ0lfOYoXOWXtPPRml6Ujz6RKZNN0CA4McMt39ODn+5fzi13vP3bwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2R6rfPdr4YBDE9g78qUrclmivd5F6fWdNEZglGzJlUQ1fQ/t
	hXM9TIUTGfd5tsgsVAOKgooCF/COlWXYN8EaM+4xihDzrFLf33W4GgExmIaGTkNvhg==
X-Gm-Gg: ASbGnctE1sZs1zUxqGo82OP0AJYNCIIDIVMmUO1t5z5oGiTp09B93XSLcQq6irZQzoX
	9FthXw2lLLTDS5x3yMbib9e1xyoUPyef1HsAiVYBKV168ldQXYepCLZdskbBc9JfW/lb4W8de2V
	LKKIR1M+5lA2n7+ThGEAW0cGGDq4PdaxHy9m5HC9KxhaKevXT5ZvIqLdgSn3nRBeeBJx6uFWqRv
	wal0TOrVXDVlTV7L/EGtE36bdZ5ABEQvZVYdWeIqhPhNzOY+Xifk9vNSSZ5kL1yizdMQzPBAGg3
	lvpZQpQqU/Oy0aNWGEHAXLstpLJm7tdPrHowXKL/cPKG5rrcTiC1Oljs43RCOyaIUtD1os1+yxa
	wo90TtkYOFdxm90FTJikK9ZmSJYWmNStiSw3mR2+jte7zKur2O0JuvdVmQA90md1VZoHDksg=
X-Google-Smtp-Source: AGHT+IH7boJUUpyB5XtiGW1q/b1fBgcGs5BDKzeQnQ68gF1GB/zlqoErisxWiIo3r/4bLZrHYq3z6g==
X-Received: by 2002:a17:902:e750:b0:269:a8a8:4029 with SMTP id d9443c01a7336-27cc09e438emr58305255ad.5.1758665240415;
        Tue, 23 Sep 2025 15:07:20 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:26d9:5758:328a:50f8])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2698016bedfsm167410205ad.32.2025.09.23.15.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 15:07:19 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] ABI: sysfs-devices-power: Document time units for *_time
Date: Tue, 23 Sep 2025 15:06:26 -0700
Message-ID: <20250923150625.1.If11a14e33d578369db48d678395d0323bdb01915@changeid>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many .../power/... time-related attributes have an "_ms" suffix and also
include language in their ABI description to make clear that their time
is measured in milliseconds. 'runtime_suspended_time' and
'runtime_active_time' have neither, and it takes me a nontrivial amount
of time to poke through the source to confirm that they are also
measured in milliseconds.

Update the doc with "millisecond" units.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Documentation/ABI/testing/sysfs-devices-power | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index e4ec5de9a5dd..9bf7c8a267c5 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -274,15 +274,15 @@ What:		/sys/devices/.../power/runtime_active_time
 Date:		Jul 2010
 Contact:	Arjan van de Ven <arjan@linux.intel.com>
 Description:
-		Reports the total time that the device has been active.
-		Used for runtime PM statistics.
+		Reports the total time that the device has been active, in
+		milliseconds. Used for runtime PM statistics.
 
 What:		/sys/devices/.../power/runtime_suspended_time
 Date:		Jul 2010
 Contact:	Arjan van de Ven <arjan@linux.intel.com>
 Description:
-		Reports total time that the device has been suspended.
-		Used for runtime PM statistics.
+		Reports total time that the device has been suspended, in
+		milliseconds. Used for runtime PM statistics.
 
 What:		/sys/devices/.../power/runtime_usage
 Date:		Apr 2010
-- 
2.51.0.534.gc79095c0ca-goog


