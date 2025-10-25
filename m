Return-Path: <linux-kernel+bounces-870047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AD7C09DA6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B36C5840EA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87C2305E10;
	Sat, 25 Oct 2025 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2bffbq4"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAF3064BA
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410434; cv=none; b=Zn1ihjsm/wZDzjm3QwFIuKU7dfL5NT8H7rIkkB9ju6qIhAN1UsjOXiIynd+PShO/Xyp0LN+DjSqi7V54PnAiGnRmFNZaqGLuSVRwGT6DFUzCpSFmKn4rNixqh20z4F/8X3GzY0HYy+Gntfe2t7clxhgdEjQ4bsjbL/qsMSMVW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410434; c=relaxed/simple;
	bh=142ZarbauOc/OnyndUEIR7x0gLhU0Vf39KWkHIFGmYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtxa4WoXf6icwmdvmYZ8fVjCbXD6eBrTwXLTeKXHlFOPym/v3oejrU6HRIwGKq3I3w+4EKn7bLF5zkAkfK5I4uu7wzGx/2/qeZf2xYF7RwQllVGljm9HM6boUIyh5j6L2EKeDoEmkbeM6YGk+Flqq9SqjSAyy0v8RxgGX5jx5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2bffbq4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-89ead335959so134027785a.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410431; x=1762015231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVD9Zxv6Y0ifC9xZiOG7Ki+TEfCe0ib+yy9r9fDGLQc=;
        b=E2bffbq4Ds02AQpl5Qu4A6vUW9DDnxFSCVuvwODdRYBO87m9APxmbbdz/OMSE3eYX0
         31KuLZR1HTiahp9XODbFezyTjr/+r0lHsBySNOlOhhLiORMTQ0wKRounf8UJdkYEIb/q
         PI3lzI7VG55iMAWHWZ2DsgAcJap1EzIGk3zpWWqw2TKrcQTSZPseqXx6ls0jb2I9sico
         g2wXlJcC0uCAGV+c/Y4Mt/1gP5qNHC+imvs+0X8U74QKspC9OUoCa+HOJUd9x+DZ+Frf
         S3+mjLQI74L6MYnws9eSSQcFt3eX5FWzPDmKcbHPO+l7vdzzUp62tRJp1Km8+EMA5Pgs
         MNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410431; x=1762015231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVD9Zxv6Y0ifC9xZiOG7Ki+TEfCe0ib+yy9r9fDGLQc=;
        b=pXe1OsyepflFcr+NaTlcK7fPaPYmRIw16DQLydfMeCzFPMoTWYzB5/l7BtXvkDpWvM
         lsQF9Ehnfdf/oWFbQU9PnHVmwBegzIdN26V4IGp+tIjNfqaohWdCKivlQoCI2oD5E95z
         B4q01oEV8Pha03IxiZx2TjCp0LQ5i2dQuHuZIp+sDsYxLQuUoEv9uhFH/zDSkj1T284u
         V3tuYx3ej8Z9dLv8l08la4w26100/Yk1+kW+q1LZ5NOhl1jjlTE1Ap0GiZClCU7scOzf
         5zVp60gLBXtFhBcfEOCS6O13nkSz7EqUZUWN4T6vtXWiIU5ptxR/hxW5SXNUi/gqKkkK
         Fgjg==
X-Forwarded-Encrypted: i=1; AJvYcCWFmUNNeukKZSb3M47V1sc2fosasBQmarqWz3OdbJPoP8vHvW2uALMTRtsVVMJQ171Drfi37yoJgneXsz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8FLNqNsjCzLZX0MYVEQeMlFMS6wPKo9FoYNsY+VchuTS14h0
	5aeS2ANkKazHOuuYi94G8YKWYRNq8d2w/IKVdNMCqypmjx2nydvv+Ae+
X-Gm-Gg: ASbGncs2A83XJrTBkQXh3TBlSVyIxq05otBiJAkEN8D/p71Ee3lywYb33/9UO07Yvwe
	bMXJBsJhwvM2nb0xbP02kJ+5rAxuGfBKvrESl2l/z+yt/xWnQ7pOIlsy6TmI3XzLThdVSZJWHum
	QetTPWN6/rURHMz3J3i955Fc2t3JJFg5NY1MEcxUBIz9udeVTRNASZ+0/XwWALPkeYrUIvEkzcZ
	UbCtGc6zurIaf29TngLNV1k4jt/601YqJOBj9f0yLfC1KOHKtTfCd6hA0Y+d6lVR5w9EXAEAyap
	qMMBb6Qa75FCVBPxb2wXfnHVN7dm+PCjXyTHWEFReE8dr9r+Jj+LVNrXj4adU1m4hU1JPnRSfcE
	iarDKE3yAyq7aUa+cVQX/BxIhL8hYKxFMNnZOPvd4VLNaPFkmWDbEapdL8EQB7T71CsQNs4pO
X-Google-Smtp-Source: AGHT+IHi0SzLVtyyhZwoQbQ1wMM4wPKEE+MJJFPaEhrXN5x+mdVgxlbnahirAfa9H7ObZoH6VLCARw==
X-Received: by 2002:a05:620a:2a06:b0:891:e26f:512d with SMTP id af79cd13be357-891e27ea1acmr3419884985a.59.1761410431571;
        Sat, 25 Oct 2025 09:40:31 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421f8b8sm175760385a.7.2025.10.25.09.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:31 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 02/21] iwlwifi: drop unused BITS()
Date: Sat, 25 Oct 2025 12:40:01 -0400
Message-ID: <20251025164023.308884-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BITS() is unused in iwlwifi. Drop it.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index ddc84430d895..b0d68b4c504b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -11,8 +11,6 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 
-#define BITS(nb) (BIT(nb) - 1)
-
 enum iwl_bt_coex_lut_type {
 	BT_COEX_TIGHT_LUT = 0,
 	BT_COEX_LOOSE_LUT,
-- 
2.43.0


