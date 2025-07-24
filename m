Return-Path: <linux-kernel+bounces-743935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67799B105AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B4117E0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB24259C85;
	Thu, 24 Jul 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="XDoIcopH"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800618786A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348903; cv=none; b=uboczZN6nVWURYrpN1Xoqda4QOJ/J4cSMJBrEajrf2Km3gQoJEFayGvm7fJQooPxCB+pPlNqJ2sy8GORfQeTqsfjVgwNH2tXnOkZQ940nKRo57Po3/q20apP3RdZcnLZQVrDixclJMJ6qNWB55XruTSJJqIfv16HsCqV0xx16qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348903; c=relaxed/simple;
	bh=MBz4iwUTBD7tFCHnZ6+JubnfKialJN7mn8OjnqBcvbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DR05rhWKPx2jUl8C8PNzpdcZzCfXTL22yZhHmydHTqAXWQXJJ5gQcoiTUHe/tlOYXwk2EshfWqcxGqyXI5OKuTFK9dFBP6qeqs1J/pviHesMw3bO+k/aeyzJPEIfH63cqaJyIjcXgrCGcC2Fz11RHizeGq2+MZCArzKmI0QN2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=XDoIcopH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237311f5a54so5399625ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1753348900; x=1753953700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqvPnkRrB7oXEkshrPQipnY6iopteZAJShBNqYK6f24=;
        b=XDoIcopHCuNuSSCKQzXGmm7VBoNcN4CJRKRSRKKaD0g1mYIszd9lLpFrRt6EHiLphV
         knp785rzEgqTkzGmR7+wCsOcKz7xgMaFInzje5I7QFJXUzSUvy3QF3yGkxkoOD0lujO3
         JmYFB+hl/cE/gBN31Xy/08r4OT0ugBaiX79rSfiDjtkVYqyDbeSEwTDL8V7OjcK24j+C
         Gbf0R+QINXonJaBlbOfnowv/0oZ7QfaYNTOXwwA4IGDdzGYomnjhA7oaH5hUmSdpWxaf
         8EKPX/+2lddJlCOW6Sn/EEozQ06vQOMaa1A93tnY3ALG0ngOEDOW/cCNw8lALpGJE4KU
         hWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753348900; x=1753953700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqvPnkRrB7oXEkshrPQipnY6iopteZAJShBNqYK6f24=;
        b=YbqYwW+XxXp1RS+06cj62SaOaAPq6FgVsqvN2L7ldomOFtL1Dd+wVCQCanuF4ENKRi
         EtxR6MvVRMTs2crm3hVfD7w6SuuL6nL3SdSCuR+h5ITXuKUguknQdQvV6y21pELitzQn
         WNZuMDrhI9acmG5rfGVQuCaDTgOTGF6d+oRuX5I0/SLlJYm8+NjnaocNwzXfFsey9hIC
         8doSu1xE2YIsWDEnDhrZZebyXvTIaGo3BBZh0CH68mKoor0dCqxlQvKZfEnc/4pwMpUb
         VoynSFiqGt+WY2EZdH5dNQaN6Ga9SQkc3SwG0JmoDssKkQ19dPdLdn113n2VMKIg7lqB
         LojQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB06fZMwRUkWGP+1DL2ml7IGv5Eu7NEnpksmQ5cnsnaaedIYkN6UiOXlnzga7OQMjJB9C0SZcSW8G3+i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSg4tobT78B2+lZtr/QuWkmhyuTxWHt3iP/eF327M0LW279xk
	kdalLqNP2jgTcP3JwairsA+VGALKzrDqOHpsHpzZhNeIdzvqVJN8WQNvT6yC9aseqlw=
X-Gm-Gg: ASbGncv/5AiFQAHF5KPX/5G7YfNh1HEWdWJoL0XluQkUPyaS0bav6EMIi6A5yM9E0So
	bkxK80Ufq88SVWX7U12ROShiREI2Tl0+0tXsA3GqygyIIPqfK2gcPc0kF8dFzl1qXkzmBO/f1qZ
	QXijpE1jXh9KY/ALHpSxY9eynHQq9TPb7fZZg/HAfGsn1ZZcPFo7fwXBZdEECTRFudciPAR3+q0
	wVOE19YLNm/qVl7u+Z0jyoJnooloLCHpvFiwZrqQMSeNURX3OjQbkmHjgR1MOFP69wOy1eo0jz1
	IxxVDyaszVGGfrXIfqZWwypQdNr22NLlc9k6GXrV4u5zaTJA8a8oAyZXLnEST3utdk+KLVwSAmB
	lgikEgrLgE7bGjlkQol9//7aHDKAnPUBZzUXS2QjDwpylqSlWfSYpUFU=
X-Google-Smtp-Source: AGHT+IE2cTDYuQ//Nl54CzxM9h7KhUuyIL211ZcA/xCbsrshSiP5Plf/oiQW3J4mDHHU2oBPU65F3w==
X-Received: by 2002:a17:903:40ca:b0:234:966c:a2f3 with SMTP id d9443c01a7336-23f981b27d6mr89262515ad.27.1753348899997;
        Thu, 24 Jul 2025 02:21:39 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:fd43:1ae:25a:bcd3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e66384406sm912306a91.33.2025.07.24.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:21:39 -0700 (PDT)
From: "Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
Subject: [PATCH] ACPI: PM: Use nearest power-manageable ancestor
Date: Thu, 24 Jul 2025 17:20:58 +0800
Message-Id: <20250724092058.10075-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a device’s power_manageable flag is false, we currently only
fall back to the direct parent’s power state.  In a deep hierarchy
there may be a more distant ancestor that does support power
management.

Walk up the parent chain until we find the closest power_manageable
ancestor and use its power state.  If none is found, default to
ACPI_STATE_D0 (fully on).

Signed-off-by: Guan-Chun.Wu <409411716@gms.tku.edu.tw>
---
 drivers/acpi/device_pm.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index dbd4446025ec..81b47fb00e80 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -84,8 +84,23 @@ int acpi_device_get_power(struct acpi_device *device, int *state)
 	parent = acpi_dev_parent(device);
 
 	if (!device->flags.power_manageable) {
-		/* TBD: Non-recursive algorithm for walking up hierarchy. */
-		*state = parent ? parent->power.state : ACPI_STATE_D0;
+		/*
+		 * If the device itself is not power-manageable,
+		 * walk up the parent hierarchy to find the closest
+		 * ancestor that is power-manageable.
+		 * Use that ancestor's power state as an estimate
+		 * for this device. If no such ancestor exists,
+		 * default to D0 (Fully On).
+		 */
+		struct acpi_device *ancestor = parent;
+		/*
+		 * Keep traversing up until a power-manageable ancestor
+		 * is found or the root is reached
+		 */
+		while (ancestor && !ancestor->flags.power_manageable)
+			ancestor = acpi_dev_parent(ancestor);
+		/* Use the found ancestor's power state, or D0 if none is found */
+		*state = ancestor ? ancestor->power.state : ACPI_STATE_D0;
 		goto out;
 	}
 
-- 
2.34.1


