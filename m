Return-Path: <linux-kernel+bounces-893403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40348C474AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1541B3B5AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7D831353E;
	Mon, 10 Nov 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cThjWDBI"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D68313524
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785788; cv=none; b=Ko/s9rBKD147MdOU0PenZjogkNL6qKFnTeib9GvQjiiVOYM00zQR9SrfqUuhah85jXSQ5AVvhyI0x8+ONQgkLNb1A1ddcfGSzqUC9TXpylLADSHGPE+MukBgN3AGaGUJd3BoQnnx1N5CryZBJtvVGZuWCdy+CjSeAEPd6k1I9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785788; c=relaxed/simple;
	bh=rq8inUEioFPmuMEK5dyLyp/Z5EEtZ4ialpzlvE8Z8Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcf2IXXE5BQjka8w08gLngd9KQsy8xBDI4aSreMyfcMtU3Mtt+Jq1W5Ky710UHzcPyl37vLJmazXnEfZV4H74hK+AjY9OuZaqF8YyOuJGYLaTExkw/LVEPrpa6NiPGDNz5fnfR1ksYbw/r2lqAolEq2lm51WAeedt8Vfv35B/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cThjWDBI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3437ef3c9a4so133482a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762785785; x=1763390585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JikY8RUWAS87/Uf8jcHZAVFCfs9UYHP3mbI5XvHhWpo=;
        b=cThjWDBIb0kUXiKtQ9CYWWUBhosJFcZ2VEnYBhTU35Ofl5N8xdl/eeDcAqmdtjvdvO
         FuZqwbpkLuYMq/TcdfA1OSbWoTaiAP+DcIsQb6k7kr7nJ+oOmKu9h4UsCdPALXNwj1el
         7D8Kk8Qqi04s1FZXIAJx72qrUQjq1tQ1e7RHmGB0vVqQ9oRxKMEDA5ksyHbqVW8rdaFt
         jcGs7fWzCv4eL3zVAtuzh5yBCPN0FuRKFIoEN91wxLYDZE21OHTcgZ7RVmAUFGqVHAmf
         5PXNs5hFUXIniLzk2+E9xE9R5dKYXFsNhJ/WSPRU3hhF2ewM0gtjzwzUTRLObi+4d//P
         Jjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785785; x=1763390585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JikY8RUWAS87/Uf8jcHZAVFCfs9UYHP3mbI5XvHhWpo=;
        b=HbPDfcjC+bvLwVSbIuxX21jAKM/QFT8+IyBWESCNWOvtmG59hWjkiQt1HMNFYKHdNM
         dB/6Y0WMMSA5VpcGIwGJmqKU0z6vc04OAIlOMD4LwD4CrK2svnPyv2IhAO+A/XH4eQSE
         VZlX7Oet0GiYaqmaaX2B99/PR/a9x4zQ9xjwwVQC7hfqy8H1WIs/G9unUf9lyv5Ru6SP
         yRyyP8AOnuUBF3ivbpSlxtcrxppEZylQl+XyNSoqeYlEEz0DRMRMqnU55oNwePOMs9cy
         rUswQScA8hyDQiFaojXdJs4Lz8ZyNF6RKKJKbpReiu1SRC1/4tnnrzfXCwNkAS9/W9XU
         X8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuvTdamD5NYbDdKdLpS8ErzBbZ7SEP7xm+HSWZCakwN6Qr6BDpPH01rptcGrHIBi4pP6muwUi81eQczhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysiljCjLChT2urw6xZnhmxV63jJMDnwyKzjjKzpzu9l9CTntRd
	rTgVbKCHkhFS6mt2IX4CTeEAKxtXOOGBkFyMxTa4LCU9m92UZtFd2EJW
X-Gm-Gg: ASbGnctERt6nP43cgCffS36PM44NXbK4L7pT7khmsXaSC2zUEWXIH32v9kpRvIMbgZS
	XIWBXKIFD4WLOPXCKJbJ/ZKdvXsRzqGQ//UdhgBmFh7qooUz+jyVp3W/AZBYZSL9crqf5vxNsmL
	mawE+C0SydVCGsuyqgZNyW9kmT6LjW29/bNlPEzeUnZac1T7bjsjBfHyRwKuFtYPX6NnuV4haCM
	ubIsm5Pdkbed9Qx7IdSB/9/w/Ps2FboKHZPmgWqAlAp96JNuNVB9OTieYHhregg09bO0RT9YN2/
	pubxe6BaC4C9phwggpUReSEbLmWfmUOihIC7a4qTutvVn3EnAfetktnAf2Me0/URN6m3H9XDUVF
	pROqFTpKf2WP4zo9iA49OYev1T2iaqkeOetgeUheQLyOqkJIaXQvA3bz0PI5aFdihOq1J9YKxrS
	YHh06v6I7XvQhKIKbvuVuW6iJ6i2wk
X-Google-Smtp-Source: AGHT+IHBa1xJTFMz8fhGb7BKgNk6MKI2wokPJ0JpH1QYJDJFAVfq7908wrIU2cRPDlRk2m4QFg8smA==
X-Received: by 2002:a17:90b:1d11:b0:340:b501:3ae2 with SMTP id 98e67ed59e1d1-3436ca72a20mr5911655a91.0.1762785784925;
        Mon, 10 Nov 2025 06:43:04 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343abec3836sm2163308a91.18.2025.11.10.06.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:43:04 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Jesper Juhl <jesperjuhl76@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH v2 1/2] uapi: fcntl: guard AT_RENAME_* aliases
Date: Mon, 10 Nov 2025 23:42:31 +0900
Message-ID: <20251110144232.3765169-2-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110144232.3765169-1-nogunix@gmail.com>
References: <20251110144232.3765169-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including <linux/fcntl.h> after libc headers such as stdio.h may leave
the renameat2() flag macros defined to libc's values.  That leaks the
wrong numbers into user space even though the kernel header tries to
provide its own aliases.

Check whether AT_RENAME_* is already defined and whether the value
matches what the uapi header expects.  If not, drop the old definition
and replace it with the kernel one so the exported flags stay stable
regardless of include order.

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 include/uapi/linux/fcntl.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 3741ea1b73d8..8b667550e44a 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -156,10 +156,23 @@
  * as possible, so we can use them for generic bits in the future if necessary.
  */
 
-/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
+/* Flags for renameat2(2) (must match legacy RENAME_* flags).
+ * stdio.h may define these differently, so check explicitly.
+ */
+#if !defined(AT_RENAME_NOREPLACE) || AT_RENAME_NOREPLACE != 0x0001
+#undef AT_RENAME_NOREPLACE
 #define AT_RENAME_NOREPLACE	0x0001
+#endif
+
+#if !defined(AT_RENAME_EXCHANGE) || AT_RENAME_EXCHANGE != 0x0002
+#undef AT_RENAME_EXCHANGE
 #define AT_RENAME_EXCHANGE	0x0002
+#endif
+
+#if !defined(AT_RENAME_WHITEOUT) || AT_RENAME_WHITEOUT != 0x0004
+#undef AT_RENAME_WHITEOUT
 #define AT_RENAME_WHITEOUT	0x0004
+#endif
 
 /* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for
-- 
2.51.1


