Return-Path: <linux-kernel+bounces-793878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC44B3D995
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C670179014
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50476257431;
	Mon,  1 Sep 2025 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YIR+J5db"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4311247291
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707159; cv=none; b=u5YMKmTxT/j7uyxwA+4K9PrB8f695SRGHZHJImXdPwmov1Dm+R3oYO+c2QrwDyovEnPbZ1tuZXe0W6mDJ2ddi4mgpRK/6HEqWDdWbWkd3py0tE+OjchtZCHu+kW1AMcKzL1wCUfGx2MHKTYT1J2i2j3CND4WU/uaudPLIfQNtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707159; c=relaxed/simple;
	bh=oJIpLLq8mn4y7wdscckPv1cTmoMWyeuhyGuMWqlHISg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAexk/5G1VIS43t9K476ckdnNbG30TdWS46KRdPuqeVR44rRT7gSj0MwilhmxBHNVidL6uUdrwakJoU65gGsXSieHZk6dkCMMFxP+96mdezoAeGs7qaC6aY0esOv7zesGcqtHjg3q2Sa5jmm5L38DIZO7SdMUfPBl5S4z7/HtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YIR+J5db; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afebb6d4093so658671766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707156; x=1757311956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpCkz1SZAm30DtLN9HzajIn9qKAPCWS80gkzy9YwyJg=;
        b=YIR+J5dbZYegy/PQpUw9sZ9SATExDLHT3bybgi7cQWHSu41/4KJrVyXk99OIEuH8oz
         D5RrdjJ+0K8bHl8KD5lBug5VyMsHq/PQ5za79lz5kDPbbbIKn1gAAnNOqlYE9KeDoNyk
         qGtRSoisncoBtjrLOGCKivqKvEZFCSBKLh8Ue7LkQUReM698PpavnFzh/TX40cUdkn4e
         k/MMt+EDBesIE0xUBrc1lSIQR7tRDZuKpiQJ9J6O5Y9gLzM+EAe21iQ9PGhTxWO0BCle
         Ctp2hTkm71A93TiyKsh3oT5OKDzIFLsYp2ShlMD84E00ybcX1wvzoJT2/QlxXoJgGT/1
         iP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707156; x=1757311956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpCkz1SZAm30DtLN9HzajIn9qKAPCWS80gkzy9YwyJg=;
        b=L69CZCSYfxuwmhO3iTeyh715YOS3ijvQ2UZ0xb7rUA+ywdHL1lE7wBKbT4FooY34pj
         lRZiaj/fY0jJPYZSKTeGYDd9T/9EJVO+kRXZLqA8aygM50LyUrO6SP2U8faoN6LvrTPH
         8yAU6UBt9eZjpgR0weIyW1+Z+o5nZdRz3PD+YxGLaBpoIDTBMi14SbyY5FvmjPU7O12Q
         ltFZ+DSNATP7WsNFarCjtL8tUGcaQGtp9JEy9+eVIRqT3eJByi9HQMOsie498aEqpLe0
         I0sN9PyofODZwzgPdBzaMJx8SFj7oUeakOWdey5R/es4YXxIpmty3TFHfHsLQFS4Lwbe
         v8iA==
X-Forwarded-Encrypted: i=1; AJvYcCUkSSgfG8vHuCQ8BODeow10DaJzvMcuhJ57b8Sms97W3Vq6TvpUiRqZDvabvtAq2EcnKwNX5FiSoT8lqe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoMWEV9jKPjObL+oXTM+NSHnr+ce5Q8RejEr3tP4n5xWjIiono
	tRz96Z/9UK+pbBBE7Wx7AVRT+czF4PTOYWwdKVAVOb1ryZKcDaXfb/siB6KvMNWEjt8=
X-Gm-Gg: ASbGncuV0YmFRkVtTW5inot9rz6GIoB/Sptwcu03CZSiqAPrTiUeiJFG8AiAd0YJIf7
	3BKy0c3zcV+3tKrMMfLNW9tMeEiB3p2CWAjvHdGcbG2VEkT0yV1vNy1aK/tKzCggYGXN6uR0UEO
	p+cMsSVPPtQ3ztuPqv8aphg6giwrXNhFLedhBzZKysDTD2mS5zL70ivABxePeoz0ZzI9eBW9v6X
	iGtRIz9SRFkqqBUTKGK+n0W+05bBT2V2TeXs3loIS045XrWmXldsKoXMQXcPOmMYvRa+fex+k+d
	BF/47bdrlCrIovT8ZCWTX4V4XtavgAS1i9HPt90c5bmsph0BW1S+6rZdzh7ZM9lBjoOhreC2cVw
	6dqupgcVC3euubJa6lIuVMLA64a6Q0I6MfYfYMXnI586Cd6cQmukY8XtuUHW51SfNfehalDmVR0
	AugGdhWjBhwAEUcECDhwJiFxiFTHNw4z0H
X-Google-Smtp-Source: AGHT+IFiW66dPNAjaKWaNSd5/rc66CQvfLy+BReC835wGyDy9GLSMV8wAFikPHytw5Ty44iyPHhAkg==
X-Received: by 2002:a05:6402:358f:b0:61d:3d9b:6522 with SMTP id 4fb4d7f45d1cf-61d3d9b65a2mr3731973a12.8.1756707156180;
        Sun, 31 Aug 2025 23:12:36 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:35 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 04/12] fs: add `const` to several pointer parameters
Date: Mon,  1 Sep 2025 08:12:15 +0200
Message-ID: <20250901061223.2939097-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/fs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b9f54446db0..8dc46337467d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -537,7 +537,8 @@ struct address_space {
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
-static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
+static inline bool mapping_tagged(const struct address_space *const mapping,
+				  const xa_mark_t tag)
 {
 	return xa_marked(&mapping->i_pages, tag);
 }
@@ -585,7 +586,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
 /*
  * Might pages of this file be mapped into userspace?
  */
-static inline int mapping_mapped(struct address_space *mapping)
+static inline int mapping_mapped(const struct address_space *const mapping)
 {
 	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
 }
@@ -599,7 +600,7 @@ static inline int mapping_mapped(struct address_space *mapping)
  * If i_mmap_writable is negative, no new writable mappings are allowed. You
  * can only deny writable mappings, if none exists right now.
  */
-static inline int mapping_writably_mapped(struct address_space *mapping)
+static inline int mapping_writably_mapped(const struct address_space *const mapping)
 {
 	return atomic_read(&mapping->i_mmap_writable) > 0;
 }
-- 
2.47.2


