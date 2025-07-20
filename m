Return-Path: <linux-kernel+bounces-738013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1EB0B31B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6738718997A7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16BE1442F4;
	Sun, 20 Jul 2025 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W92OHI3r"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB378F5E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752975714; cv=none; b=JU+EEupy0HYN8mQIy5SL3mwtXDzInEUd8a9ZedQ6Pq8dy6yG05pH90o84S6Xqtk9UGjK3ssmzgL03s1nLBhOeqKYejYlidfDUfxExlxokNxkyxrM3KGbXXLhqsqaSoDlFsPMrKVnaD6r/RvTHNRiyGqjcs2LbRkqjYrb9cLASFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752975714; c=relaxed/simple;
	bh=ymA0KWF6LM7j7ImEaLBnb73e9uTNMKqOIwWBJyAbC/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0z3uIXxh2Ohn4cmUbPtPR38U5ggKS0H10KVmWuS5dYp14wut2rXEYfesOiKVlR57jjAkrd0P9JJcjvarOoTs6dFFGssehV6nza2R55/qq6rF3eKyK0U8VVaone2FutOu+D+mPT+lyAjDNi1F6FkQlqbON3vSrG5jPwPg+KQIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W92OHI3r; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso2297965276.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752975712; x=1753580512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JNJ1/HN7V3em8M3vAhdU/6pshoNr3a9V5wWbjSSmQY=;
        b=W92OHI3r3boR3TrS7am2MmuzivW92EwhIjkGcSzjDQtvQ3D4CqYjNdSNjT/PurTFmr
         5GPECP+Nwr6oWoIEc/HUxIUTN34LBEDYcE4zNrvAKGD/EDL0xtLHxxYM3iWgH0DMDYsx
         ZGaVC9ZvlKoCitdF61SLVUGsGp3HLApjc5MoeaNUTnJdVxBwcDMh0QCC4WIrRdlkBEGQ
         Kq5jrKppjvjny2WpZs8SRDY01Cp2aPsu3QUhMv8QUYFplKqdYknhlAnlPopOMuOz+GIw
         tPcZJslvTsUnN/tCiVL9NZIMdxjkXtj6Puozm6/l99lm8lfenT1AkYToHRegXJPv15Cz
         Kbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752975712; x=1753580512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JNJ1/HN7V3em8M3vAhdU/6pshoNr3a9V5wWbjSSmQY=;
        b=CXu+V840PAdMsIjR6280rP8iXhIpxCAzIjkalZdSe48PsZHtNWbja+fTHmHFQVozWU
         KpC8eNiD6I1K/MHmy0MLNI13fKCGCduVF9CcnjjMWnu643/y5b4nzry34cWu5vY1R/eO
         hTb1eVRKTL2jB3ZrcGDJDcq/Qgp/S2XHFJZJYyQ98jyC3Yj+iVe70qM7PWpHMW3VELl/
         YiNQNjUtDpI2wLLK1HwMeaB5SN8qNNmpmcDsaLHFAyKEw32JfEj+PulC1Li7EOYwjIg8
         TVyptGDB4n69UgKzKGfivU/ZA4JxKEgr7YBu9I8a2IhRTdTuADposJN59YQy8ChkGuoI
         YK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZIqhJxMm+F6vJWFJ5iO6htprPYIQhafpg0K1RV+AF/brFh2mftJ63Cimv6qx9w7B2PnntvPAqfAreKNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+L66DXV/Q/d6fqVf2lf0ZxTa8JR+rgj1ODA4SyP8x2t5qS8X7
	4CxyEoksSfuH3IeVdhx/gUfv5AJ898i/DaWKXLxLF8Vu+tsKG4g8YTxA
X-Gm-Gg: ASbGncvpenEdUOr58jSuvYP3dLxI2PmRKUd5Jf+hEjwLCPKRG27D+FgF480+liikXVr
	ipnK7GvleNzEFRnH0Ky8kUSAQxk28ri4lBhwlQiaExGNGTshcuiOEIzPG/ecbB1hAFarPXdSXex
	ZfuN1XfxCrp2/rog8JyymZYvY9RlLrFRxEHMdgAXhpsa3bKkjRZpqWEMnDePiWgh6ETX1HCvY8w
	qkuIUumZA6/eNUvX6J1ZMtbZLMU5fFP51pyEH4R0nxENQ3jrnRgaU5nyHpGg0YgCj0biAu9Lxhl
	/yWJ6F1cUGRLhK8OQerf2Q0HHCNi7TD0XMneH3RZEIlLJmgsCf2SErLgv+kT01hKRtA9sg78E+X
	h6QsO9sC11FVGxiR/0mWLu60T3W+r/+wR2jvY1VNgUbkB6pcqXzqGAWPBsA==
X-Google-Smtp-Source: AGHT+IGuDLkqeMd9NFBjjGG1ZLo8mFJBAbTFUyKEZ2NKAbY2G2UblawbtRHxtAAWS+pa2xMTuQJTNg==
X-Received: by 2002:a05:690c:f8b:b0:719:671d:255 with SMTP id 00721157ae682-719671d039cmr50467467b3.3.1752975711562;
        Sat, 19 Jul 2025 18:41:51 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195314cc5bsm11247167b3.33.2025.07.19.18.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 18:41:51 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	"Xin Li (Intel)" <xin@zytor.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/2] x86: topology: simplify topo_unit_count()
Date: Sat, 19 Jul 2025 21:41:45 -0400
Message-ID: <20250720014146.432316-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250720014146.432316-1-yury.norov@gmail.com>
References: <20250720014146.432316-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Switch the function to using bitmap_weight_from(), and make it (almost)
a one-liner.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 arch/x86/kernel/cpu/topology.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index e35ccdc84910..db19c5384f92 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -208,15 +208,10 @@ static __init bool check_for_real_bsp(u32 apic_id)
 static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_level,
 				    unsigned long *map)
 {
-	unsigned int id, end, cnt = 0;
-
 	/* Calculate the exclusive end */
-	end = lvlid + (1U << x86_topo_system.dom_shifts[at_level]);
+	unsigned int end = lvlid + (1U << x86_topo_system.dom_shifts[at_level]);
 
-	/* Unfortunately there is no bitmap_weight_range() */
-	for (id = find_next_bit(map, end, lvlid); id < end; id = find_next_bit(map, end, ++id))
-		cnt++;
-	return cnt;
+	return bitmap_weight_from(map, lvlid, end);
 }
 
 static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
-- 
2.43.0


