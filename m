Return-Path: <linux-kernel+bounces-722588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D078CAFDCA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AB67B79B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F6153BF0;
	Wed,  9 Jul 2025 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFggfCmZ"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50EB944F;
	Wed,  9 Jul 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022841; cv=none; b=WOTS9WKRfGz/xkp1B68Y61OcZ/Fc7PTJ8zCpIsbSfq70Dec0MwtQfYfzY1b5PKNTzmN7DgvCZx7S8uD60GnpXEqrbfJ60siJlnw3x7mzFrdb4QeJ3/vgZzR43THZCoqjxdF7rzMDidm2YcvemhIz4GwLZxnkOi14OyVOdIN7WVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022841; c=relaxed/simple;
	bh=2noVsCQNVQLRiGq6reRkE5gM+8BX0pVDlcLEQw236uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7vrRdzi12QXNcprN0Uaj8z1vhBBceCBw5cWHOgLiIHmIXrt71Udb8Z/ikQncq5YPUk7QTNrkPBwzuLXZ7nfwSm4fUr/QixTxGN1MBkMt4Yhw5ghkwiSj/+evvse1a1QBtTLwUrMjkR/U/Lf44N/HKuZ/g48bPt4z1yf/hGBt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFggfCmZ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso4535676276.2;
        Tue, 08 Jul 2025 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022836; x=1752627636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0AEBACIj7iufFFEjwK+DXtNtO5oq6pBK1Svk06pLxI=;
        b=bFggfCmZ1Z7GUsxha4gTXpZmi/YNN/hmWHxtnqjw8TLfIn+PPW+zmUZXhxo8GaejcL
         WNKumoC4ZEeMSZTBJEFdpGr2SAdQUvTOkMb9K2dLEKJrX9fojUMz2mFfiN8pxlAVPpYN
         Fxg0j37pbHYGlsz+3WA8KwTpcijZjrEyN/umVxNBPTtYc+9SsuQ06bY1fdi3fj9H7wRA
         Retr4gvLHCL+oNE95L22ay+JUH5m/NStY/g5GR9k3n5D/vqPGKfsfjBgyIw5hzMJEzpu
         rp50WxLsxJOxErQ6eXSz2xU2uKVlKN/CRPn4XC1vEPcgxBLe23Mgjaf6e9orokT3AFjf
         UTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022836; x=1752627636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0AEBACIj7iufFFEjwK+DXtNtO5oq6pBK1Svk06pLxI=;
        b=c9AbaExLhV7ufjufUy9h4PGvT+RIAGcIb/ASyfkqH9vRIl7sNSsfPt7rWhAFBruCcF
         QYnk5KCfwjTRBBW72tDV6M1eH1ZhQS3V9bENjNqguWyikYw410S1LfdoC/9EFxYOYcVE
         +UGpkeEdKvlS73m8WuEMva4RUs66X9jdr6tUvYSFEIszzATixNIUhKnqb0ThWACy6UPX
         WRVuytACiWXN7i6JzL0Kt1k7iABYxe2+CwvDOv6lJG9C5K+N9zb5/FVuFLaMN3sodaAe
         zL19zJPT3DLgE8L6KqemIsCquPYxy2frCGx5MBakBk07mFEzVK2xT1PL7JmyR9qASOUN
         u1Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4HERkVCek5VZuzCg+csCOnFotCDNUG+l+yc7i1fFqx9QTBPhDLW1AI6pFa70av7ddY/H9gWQ1dt3fmxT@vger.kernel.org, AJvYcCWi1HEcTl33AV3t+LoZLel760HnZ6cjVEZmBa1rY+4FrKEqmvVEa/ic/tUUaNgeyKB1SFDAj0HZtho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy798UMs7bz0FtJVyGwq5ghLJFgKldg/CcmvSg9mb+IBF9fvW+y
	KUVG0i1kp69ech0W8ZQE127zSPWDnfPYQhrEWxZmFFDDnZIZt0efrZHdVTFNq/4XC5E=
X-Gm-Gg: ASbGnctxKYMJDkTRCJDxdlVA8SFeLnl5L3n5d0VGFsBviIDGxCUKTCE9xn082TT6yFA
	bEKYPhqUDJA/YVBM6V4w+FXwPodR0XNeAK9LwawRKK0DhhR20Ay89RjTBxK1N0kMQHvV57k4FvG
	qPAjpT/NoyC5E5ZfvVxs1wOX6Sia85v2CY+ZIwpKTvR458lPmdqMa/a0MOIkXYCMCCA8usD1sB+
	67S5V1Ktmmsf9XGVVT88YCBmpCk2cDUuWLagGPaaq0BCjfsw9WpAetlhUYS3LThBp5i0gBDmoXf
	i6XP+MaOzUzmg/FflrTQnEv25RJjaOl+sXvTodG4x02oQUMJTLvxzi8LPRc/IzLrBwMLB9ofetF
	FW8hyZOY=
X-Google-Smtp-Source: AGHT+IGDozJUCJpVBxPfjv9ILiQSL1R6miXqzbkK4caVqVpgbl+9ZhuvLHM+DyHUEdodqwUQX37wGw==
X-Received: by 2002:a05:6902:986:b0:e81:9b39:e46 with SMTP id 3f1490d57ef6-e8b6e102b32mr1051961276.18.1752022835632;
        Tue, 08 Jul 2025 18:00:35 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:35 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 05/13] Docs/ABI/damon: document schemes dests directory
Date: Tue,  8 Jul 2025 19:59:35 -0500
Message-ID: <20250709005952.17776-6-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Document the new DAMOS action destinations sysfs directories on ABI doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 5697ab154c1f..e98974dfac7a 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -431,6 +431,28 @@ Description:	Directory for DAMON operations set layer-handled DAMOS filters.
 		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
 		directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/nr_dests
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for setting action destinations of the scheme named
+		'0' to 'N-1' under the dests/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/<D>/id
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the id of
+		the DAMOS action destination.  For DAMOS_MIGRATE_{HOT,COLD}
+		actions, the destination node's node id can be written and
+		read.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/<D>/weight
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the weight
+		of the DAMOS action destination to select as the destination of
+		each action among the destinations.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.43.0


