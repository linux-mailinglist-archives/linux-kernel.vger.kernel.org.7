Return-Path: <linux-kernel+bounces-792298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E6B3C27A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E8B1C87E77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277934575E;
	Fri, 29 Aug 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IVx2ExPh"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EDD3451AF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492333; cv=none; b=mKpTsTLV7/jFFjh2qXB6JQUdUvdes4v5SDItsOClvX1aMB+HHwV9ef7bsCKA0TRA9Do1YEJtXOhm7GzTf+UgFgCHNavzmtnXJqZ3p1sOezsuYQbOiZ50M2liUTBPEHA/VLtjlzg1fEFWMN68ASFEodiArNcczUJpY46aJ0skzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492333; c=relaxed/simple;
	bh=Yi7/9pPs/4YJP5XWNEE72LJQyu4KdkFKRApZVl/+X30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUbfFKscyIlUHbwODzW4ExQBb4PxEhR/701YlFw8Suso43e9iI6AwW/p0O2+HGVkhEgAJmB3Xeaul1AP3IeWiTOA3XxS5rKOlrPBKD8DyL20Ni3XPWCWut+VRsmcT0KaSfD6RfiHxaofzPGWjjtdQffOOVuXVUFPTF1K8Z6dq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IVx2ExPh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afec56519c4so318444266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492330; x=1757097130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ee45j59z6EpVLajLN9KzFmkYRTRnW8AGAmUZ4eXAOA=;
        b=IVx2ExPhYzd5zA9ay3Ing9cvSnG2rHvKjvAck7uEaIBcqvfUzG9kFV+eE1rg8URRen
         cfIjuuW8zZl2pWSdwcvtP0svt5FPLAZS9LLfl5Ti5dWVteo2RXIuzP5r+MRlwfMbErqZ
         m74JGqZTxHbTWX5QGMqJAuFuGNq54uZRuBqa0B8X1L7ySIhVKfq5rzcXDaeQaxensbmR
         Ll266V8uCWMO5N6SSawKsqwT0HeZZNgV/2hIEGNGFtZxQggc9Strf4vf7+ffbLhp0+kt
         K18x8IDnaEWmX4zTM1NsNhdw8NUJtvSMv+Oj1N6xTrolzskBjHPFjGzli19+3P25esaU
         /S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492330; x=1757097130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ee45j59z6EpVLajLN9KzFmkYRTRnW8AGAmUZ4eXAOA=;
        b=VrV3bLLK/+UIsSYuxH21JBaejWPHyhH5evdvWea7lUMXLOsjA1sHUsRizNwGBH+gpp
         VZfiKgSg5D9E5sBsjGWjRD6l1C2yUfcWCML/ANZ85xnIPrX+9GhKby3NtHss3JP9YbRi
         6VsnVmyxR4aTmx/TP26Ub7oj2XCgZetixDSJN0vp3XAM0lW9r155AhHKc6jGtjTPXz5I
         LQdzy6eVPY0Ecee/J5e0CLbLtKY2IlI5psOJM+r7s4hdBeMjam7IoJeUcW1giJaLAe/8
         SfpQf4rkE9EESwNhbQbZXmuX87R9g/gfbJn321gr01J0RCoXfP2ShnngnR/wb9ZPYK/I
         Z0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVZ8hM8jCwlfu1aLfnedAOD9c0DA2ssYf/5lHMX0PC5zXpyueKcVE6lUWNOZD1KsRUxRr1oFcCMyoJQy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGX1Y5iaAEVjLEE7yQBewsYEe7d0fWGJydyOdoa4NBNEwglaD+
	jX4wWRidMaQBo95Zgb4j2PBaoMggVceDK305kmkG/0+O1uhaC7VpllaLmEVUvW+GX2U=
X-Gm-Gg: ASbGncsDnIJsYBdzWCTqD4Twowlt1YTvgoHXmVX3zbTW/5pUGh20ctL7zpmH9rQRqBX
	5mBeTgl0ploK5ybDc94iV47sYJRjG/Qb8jhQXo42eahApNO5wrHWGDlR0TC5KG00djvvoXB5qwD
	aUwY0T5ZmNcnMaVZIOgLHUl3QPGK+VBHrxr4pnepxS2AhDB98PT8zECIYBNOM05YNQ4vx/YMSow
	5yPFvHf2R9OciNo12oac0aqZ38Ff4qEwqzEfsCNkIHO44d5Y06hTUQOxzIv5pcM2+HTk9y3+KkH
	UuVtS3dF54Au9qIGU2miBRRNShuoAnm1it+v9PJzxn3/0+iBieKa4QZKkX0yXDvXcE5834a+VPj
	6eNQoNGE/Bnubc0GRpKUDE/32gf8zDOuqjDEN9ycuXWvPV0SonUmM8MJqr3Dcp/OvDY42QDNOnz
	I+juVcYO5Iud27ULUln6HOdA==
X-Google-Smtp-Source: AGHT+IGJSceHz2hcoyT5ehNIpZ1bJmh2WPC6/xWH9n3KGDraWBfmd4TrD/HA/jbZUtAL0eU1mP3doA==
X-Received: by 2002:a17:907:608b:b0:afe:d5bb:f433 with SMTP id a640c23a62f3a-afed5bc15edmr780600666b.25.1756492330481;
        Fri, 29 Aug 2025 11:32:10 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:10 -0700 (PDT)
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
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 04/12] include/fs.h: add `const` to several pointer parameters
Date: Fri, 29 Aug 2025 20:31:51 +0200
Message-ID: <20250829183159.2223948-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829183159.2223948-1-max.kellermann@ionos.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b9f54446db0..0b43edb33be2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -537,7 +537,7 @@ struct address_space {
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
-static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
+static inline bool mapping_tagged(const struct address_space *mapping, xa_mark_t tag)
 {
 	return xa_marked(&mapping->i_pages, tag);
 }
@@ -585,7 +585,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
 /*
  * Might pages of this file be mapped into userspace?
  */
-static inline int mapping_mapped(struct address_space *mapping)
+static inline int mapping_mapped(const struct address_space *mapping)
 {
 	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
 }
@@ -599,7 +599,7 @@ static inline int mapping_mapped(struct address_space *mapping)
  * If i_mmap_writable is negative, no new writable mappings are allowed. You
  * can only deny writable mappings, if none exists right now.
  */
-static inline int mapping_writably_mapped(struct address_space *mapping)
+static inline int mapping_writably_mapped(const struct address_space *mapping)
 {
 	return atomic_read(&mapping->i_mmap_writable) > 0;
 }
-- 
2.47.2


