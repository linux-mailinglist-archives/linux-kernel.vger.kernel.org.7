Return-Path: <linux-kernel+bounces-770413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE358B27A76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A65D1C24D24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10922D2393;
	Fri, 15 Aug 2025 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Olvlv3eR"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6152C3264;
	Fri, 15 Aug 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244610; cv=none; b=EhVCoew4rvO6FJdFR+jmS0gH8IZnSJwvg+2XpBKxKQJnqZ+0yhoNFepaslTJF62bFqc7nNGEqgWi65wt26+P0TYLMxV6f+9al42PqpNCxf0BJ0gP79sgELvjxSUYvw4phRXsPElsRMezvksJKd9FQ+p4zoS4lnil6Xb09RyovoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244610; c=relaxed/simple;
	bh=LhTo5cCdwQe8pulukYwJ1m6eHZbBpd52JQDpSBVReeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6Bl7DK1PDyU/frcCRWGKXLuOPuZzRhLaA36Xlnkz1mmRZPFmxr9GZex342o+6t5vtEb4usBnLiLDDoVZyP/22CopN0WfThCbyZBkkomP9kNGUrNS45XF2fdmutG8NIS+H4bwvZqDXyK3Wigqi3aQAuEqEp+qwf2KRMho5v1LuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Olvlv3eR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2e60433eso1416135b3a.0;
        Fri, 15 Aug 2025 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755244609; x=1755849409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+F9NmXtez3GpQw5LIS9Oo9You3cZ7+F/dZD1WEotmBQ=;
        b=Olvlv3eRPjbyaxlmiY/KydZ6YuteKczH0Le1idMo5PL1Jh7XTEI+7RhX0KfSs/puZ0
         iSq+TKtrx7bRTXnuVVbH0dTp3m5i30V6NxmKNQuQ3rcWVnwXabOhZS9JG97faexrl+5Y
         sqYNRLBvOb1/G7oyvVcO+H49oRCboCVCIriuNjZEopGDHahFbvnLGsowPIlibamKjNvD
         Tkytzwo5juseNlTiq4lvhcFOTv1IiGxCKBXSQeadVIKWiBY6xsGOTaT0ETnW4CyN/qA0
         JONnI6VYjWdULDmoEn+unHJqgPh89mjH8nMmbC567F+fmTRwWOo8MoxWZ2tpQ2Nq5Dmz
         z1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755244609; x=1755849409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+F9NmXtez3GpQw5LIS9Oo9You3cZ7+F/dZD1WEotmBQ=;
        b=tljQ83vgpUOe4vmKMxKlTki2TZ7CrdK8RtU/Xrc/GTT0SvHI6BtiIiIERCQ4jnGVNv
         3zbW37iy2DY+nCCPrkAnKRB3JIQeyysoRzNTankwFeA5Aew/LqLYvZssz4KqvwwAVKk+
         YFgTG6x86YgTYeIbLDy/utHraU7gHrWd5pRLLhpxF/WoMCTTkWzby0+Un87xup62i+M2
         04ozcYrbGENsDxkvfQp/iS74ctSvSgLScjWyN/c3wRq7zw+8PVFn/99zrOqzAECGs7Vc
         a/4CiEnVHIbFdcnQa2FngBJe2piIB0pNn71FuLZbnnWf7uy9+f4h33D3IbpH6BxFZlJ3
         Qazw==
X-Forwarded-Encrypted: i=1; AJvYcCXL6DX7C2zoPa9ZkqAOb+rcitUFJsXFjm7xrMnNUJ+jkeg09AQ4a9mX56J5O4YWiqJTkderot3BO88=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc342472dtv8BmUtmQl0pvOWiEhaFyiUMBAWONjNduJLAuL90s
	w9bdkcwJGS19rKW8RRXEEx65hnE5qk302oqDJfvMhTA67r8YWlwV6UQE
X-Gm-Gg: ASbGncvC+J1tD2/EJ+jAUP5LcK3n7ucE/H6K4ExYfsA6xVyJ08h9unHGvcyVSyosbWR
	iBbbmjm00eA6ZDkN8SARPuxveOqblXBYDqLzXB6Sa/lYVnm9bzHoQXrvMG07zqlci8lnBpmjev9
	ZCZ6oL+5aHDTuc2GBLPiWUcmetKAaGUJblggxJAeRTCWkhL8nLqtBsBUNlI951AJ2bi3fX64mg7
	s+i9kukYTWEQ+Qt0S0/QuyiBxWwJDdYYA0g9+vODuF6qS5nhoeC9ShygMdfWjqYDswR7V8w7KQk
	l++GFxVoTVvkdGsgPHf6ivLE9pjhbkW/GVxpMi4MJSBFMonXjksa5BFEjVMsXn4NktrH5ociOJ1
	Tuq9Mm4vSTzUGzj7Q7GLiZg==
X-Google-Smtp-Source: AGHT+IG2n5h40h0uXDvhOaYG1ODrl6MH66mS0Kg0YJ2Fc6MbnZC5W+akAaB8uZW/JgLmbU+Z8yK1Xw==
X-Received: by 2002:a05:6a00:993:b0:76b:fd9d:853d with SMTP id d2e1a72fcca58-76e447bf915mr1371167b3a.14.1755244608609;
        Fri, 15 Aug 2025 00:56:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45292dc1sm587699b3a.50.2025.08.15.00.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 00:56:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2B3EB42BF64F; Fri, 15 Aug 2025 14:56:40 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Device Mapper <dm-devel@lists.linux.dev>
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/3] dm-pcache: Remove unnecessary line breaks
Date: Fri, 15 Aug 2025 14:56:14 +0700
Message-ID: <20250815075622.23953-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815075622.23953-2-bagasdotme@gmail.com>
References: <20250815075622.23953-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=bagasdotme@gmail.com; h=from:subject; bh=LhTo5cCdwQe8pulukYwJ1m6eHZbBpd52JQDpSBVReeY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnznq9XeaPT6ddyxvznDt+WUuX/07Z5cE+YENi4cufF2 jXZquqFHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI+lyGf/pbZkxcdY+ff7Xm 0vMFG9oTpi0tzT3Lfl3geHvzYeN9N/gY/nCs/fxc/TBncZFI1oe4ac8iHrQ8vvOE+ev1PHfD+hm Ld7IDAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sphinx confuses line breaks that are placed right before section
headings with title heading overline. This causes htmldocs build to spit
out markup error:

Documentation/admin-guide/device-mapper/dm-pcache.rst:27: CRITICAL: Title overline & underline mismatch.

-------------------------------------------------------------------------------
Constructor
=========== [docutils]

reStructuredText markup error!

Remove line breaks to keep htmldocs building.

Fixes: 6fb8fbbaf147 ("dm-pcache: add persistent cache target in device-mapper")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250815130543.3112144e@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/device-mapper/dm-pcache.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-pcache.rst b/Documentation/admin-guide/device-mapper/dm-pcache.rst
index e6433fab7bd64b..ecd015be798243 100644
--- a/Documentation/admin-guide/device-mapper/dm-pcache.rst
+++ b/Documentation/admin-guide/device-mapper/dm-pcache.rst
@@ -24,7 +24,6 @@ Quick feature summary
 * Pure *DAX path* I/O – no extra BIO round-trips
 * *Log-structured write-back* that preserves backend crash-consistency
 
--------------------------------------------------------------------------------
 Constructor
 ===========
 
@@ -57,7 +56,6 @@ Example
 The first time a pmem device is used, dm-pcache formats it automatically
 (super-block, cache_info, etc.).
 
--------------------------------------------------------------------------------
 Status line
 ===========
 
@@ -97,7 +95,6 @@ Field meanings
 ``key_tail``                     First key-set that may be reclaimed by GC.
 ===============================  =============================================
 
--------------------------------------------------------------------------------
 Messages
 ========
 
@@ -107,7 +104,6 @@ Messages
 
    dmsetup message <dev> 0 gc_percent <0-90>
 
--------------------------------------------------------------------------------
 Theory of operation
 ===================
 
@@ -151,7 +147,6 @@ If ``data_crc is enabled`` dm-pcache computes a CRC32 over every cached data
 range when it is inserted and stores it in the on-media key.  Reads
 validate the CRC before copying to the caller.
 
--------------------------------------------------------------------------------
 Failure handling
 ================
 
@@ -163,7 +158,6 @@ Failure handling
   rebuild the in-core trees; every segment’s generation guards against
   use-after-free keys.
 
--------------------------------------------------------------------------------
 Limitations & TODO
 ==================
 
@@ -172,7 +166,6 @@ Limitations & TODO
 * Table reload is not supported currently.
 * Discard planned.
 
--------------------------------------------------------------------------------
 Example workflow
 ================
 
@@ -196,6 +189,5 @@ Example workflow
    umount /mnt
    dmsetup remove pcache_sdb
 
--------------------------------------------------------------------------------
 ``dm-pcache`` is under active development; feedback, bug reports and patches
 are very welcome!
-- 
An old man doll... just what I always wanted! - Clara


