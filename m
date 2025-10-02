Return-Path: <linux-kernel+bounces-840655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D9BB4E79
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1506819C7057
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76D2798F0;
	Thu,  2 Oct 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFPiZffk"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB102797B1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430506; cv=none; b=J+15HEHqGxA3vtoDtBdHkL/fqtMAiRUPHoj+V3JCV9yYCP9bD1/EYIg225D3tR+0Jn6It1t4fpSmDs6EOoBHzRoJU5GOnx+SPKXBZqP7uasZuFG4HvQzNc7DftqfkuqvU14lsmb4oNEr1WVZpVstEnt2e8bjj6OUQrmciEwK6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430506; c=relaxed/simple;
	bh=YWSdL9iHyEd726JhNHD7MN51UkV7bajCdSoTr99QOdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoauKQH/NoO5NZz/tS/pFGEkNmueAeHbnODYWN49V0R93430oMv3R4N+VJx//D71i+DQU6eBhjFkxE7/IDxfrlrrtt5SiXzHPg7dQQ4SamZDz4l/G63fsBHkK3OECZ50YybfXuRX1rJe1DY1lKFU/NOG5Sh5LgmsoVltqTsijHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFPiZffk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so1311891b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430504; x=1760035304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjJJ9Gi6XfvKg9Dd6D3t2op0cLjNPAyn06zdnW6N1oE=;
        b=VFPiZffkpl6W0wFmoaZW02UPqNEN2U2eFQjexbs4lPO82d47uOkJUqwXWU8Bybx49i
         OP2lidqGyrjQ8PbDixDP/nYW17fsnbW/TXTYRINIR9sDeVtSEGHEbHKaXBs7OFVUbGxO
         oeT9HG/MIfpqv//JkFt9qDmHZ3O1oLDiwNG/y5yRvW3BRA8dhoDnj0s8IgaBd7WMSpAm
         YauwT8ya/TD50XVMLJou+Ht+umrF2qybqbyayHRoCYELIrEUB54p3wLvmRfwIJO1kSAZ
         MHgwLMC4114vWAeAVO6RA8oPeetRgFF8l49KOISkbm8V53aE0+qFGk+hpcWerYuPFIZc
         xmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430504; x=1760035304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjJJ9Gi6XfvKg9Dd6D3t2op0cLjNPAyn06zdnW6N1oE=;
        b=tJkC5q90kIqOzK7u8lXD+dNHF2+iu19Z8uDrxMYTW3I1heAmOJelZOJpQKTE+BUZRI
         jgrbjf3r20WiFpZ5rupbqGQaFEsJW+MpA5XDuiv6t2ipalc5kO7irL0b+1XNqT8g8SDH
         Y6P2EXAa0AhhRsHRKxCeC2y0PGkY1KMecOmY+6vuFZTiHuMmEFqmZ/Uf8uZBx70gR/Ov
         Xrsv3nJiE5LRMe8k3C9lO2of+qKDfNNK6NqiFiVa+ge7gzO3EApII3paADrhZXOjVCNz
         ezGop/rlwWQ3Txm8egLerIcJfGPDyj5rruUCQW4rUJdEto03jE7DDGSiT0XoEZxuAmWQ
         ySlA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZsuofCPABvvmAH2+xAomugjsSMX4TFf8SbAwKVNJhe/nG4zK7MiMvsfcjFS6WOgcrtCIDQrFIFforcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrtfk/26LR0hagfITyKBRClnum1YvSpoIluFVPwwNW5/7//RIQ
	BduXk59heZravywy58E4eZq7+YbdImis5UUZn8Ho7VRt6At3tB5J+wGV
X-Gm-Gg: ASbGncu2Ef7ETTY6qdcMrAspxnRA4CT0qn4D41fmHNJwH6/Jy5PTqbwBSesS3fnqoJk
	W8OAPDRGKnOO4RwfXymX1qoLQDbmYXKe6ztG/gduKWXSkapq+wdwRHdgd6RgWaNX8yHgGV9F4XS
	36rjXAS8AOGes3pnD2hllz1ZFHVJQSs4h0+Zk0ehCEFMEKLYSMdubg+ISeMPU/L0lTROhdwDS0e
	8bOoQSZaoFgRjEjyCgUOhYmb/STh/k78hWDI0+BKQ8N98nzaZ1yLeHZERFjjBZ/oURFk2yoZBt+
	4VSMz3qYQ/q6jwysBdK/Fb4LI4B4qMw5mRFwEZGvnEQqeDBEFzAVZS0fif6OwPHkow8WnIaQpNQ
	mNpsbQ+/XMppVp1Sq38EgHY/mM0HqM1iMcUZFQbyQxfuQdFpJwYmiGRN8
X-Google-Smtp-Source: AGHT+IGJdOUCo0q60wBqDv3QWu8P+anIHYeha8r7eEuxjSZYKXHFbGJVgkqXh7CMKVbMXH/oLFbqXQ==
X-Received: by 2002:a05:6a20:2584:b0:2ff:3752:8377 with SMTP id adf61e73a8af0-32b6212c522mr504856637.59.1759430503914;
        Thu, 02 Oct 2025 11:41:43 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm162917a12.18.2025.10.02.11.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:41:43 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] iio: accel: bma400: Refactor GENINTR config and register macros
Date: Fri,  3 Oct 2025 00:11:01 +0530
Message-ID: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors the BMA400 driver with a focus on generic interrupt
configuration and related register usage. The main changes reduce
usage of hard-coded values by introducing macros and formula-based
register addressing, and add a centralized lookup indexed on iio event
direction.

Alongside these updates, the series also reorganizes and renames register
and field macros for consistency with the datasheet, and extends comments
for additional clarity.

All patches are pure refactoring. No functional changes are intended.

Akshay Jindal (5):
  iio: accel: bma400: Reorganize and rename register and field macros
  iio: accel: bma400: Use macros for generic event configuration values
  iio: accel: bma400: Use index-based register addressing and lookup
  iio: accel: bma400: Rename activity_event_en() to generic_event_en()
  iio: accel: bma400: Add detail to comments in GEN INTR configuration

Changes since v2:
- Split single patch into five smaller patches as suggested
- Addressed review comments related to trailing comma [Patch 2/5]
- Extended renaming of macros to TAP_CONFIG registers [Patch 1/5]
- Addressed review comment received regarding write then replace in
  activity_event_en() [Patch 3/5]

Testing Summary:
- Tested on raspberrypi 4b and 7-semi bma400 sensor breakout board.
- Since no functional impact is there, so before functionality is
  expected to be equal to after change functionality.
- Tested mapping of GEN1 and GEN2 both on INT1 pin as before.
- Tested both activity and inactivity detection by setting attributes
  events/in_accel_mag_falling_en as well as events/in_accel_mag_rising_en.
- Did read and writes on various attributes such that write_event_config(),
  write_event_value() and read_event_value() callbacks are triggered.

 drivers/iio/accel/bma400.h      | 151 ++++++++------
 drivers/iio/accel/bma400_core.c | 345 ++++++++++++++++++--------------
 2 files changed, 286 insertions(+), 210 deletions(-)

-- 
2.43.0


