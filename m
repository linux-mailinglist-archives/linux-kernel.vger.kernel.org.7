Return-Path: <linux-kernel+bounces-863104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38858BF705A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DB503125
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F76241114;
	Tue, 21 Oct 2025 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="dc2ZkPcE"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5B23A9AD
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056379; cv=none; b=pZ+2wKh8dgO1912osCYX9x9dZW4QGbjiQyi0U73CslRT6MzhU1B6eeWqsCyTev8ZIyNtZuNYtpQER484N2r6+IcQW73i53kjabDcHP21omaipRWy/WZWSUyh2o96n85NLYmHV2c8Xn69DFGXJ3UtkENRIsOlyD0kRBjEG6KKGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056379; c=relaxed/simple;
	bh=87MSFTNbptJ4Inr951zcViFxPcY4PZZDD57HvfnsThU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KMj9CtuCov0Ue2u9um2DFiMpE/C6VKticgIpB1skksH5jNvJXX6CpDUEcBGx50UWMmIN6OrFHIt2iPN08H6v3BwdjCSF9Hyr3h7OJdsXH9IWCZxz+P7XVIUMi66r/6OEm9KmuxgmXRPes326khZZDC3DEvkll7BKbcxSqsww7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=dc2ZkPcE; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-33badfbbc48so6937126a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761056376; x=1761661176; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5wVNQ1TPPYCI18FBmEto8HZyxTAnf2PB3RP/4Cuf/Q=;
        b=dc2ZkPcEXWcyWPyrvRPDEkqSXYavSFZ49J27JQ8NwjznWubjaEx5IdD4YjNcCpG8JW
         xUvInh/LVjTMk04Zfb2Nlp6RhMDgqDjH7fdjTdtqNZ+iAuLq8tHoJfcX0CMo4kNJq/wY
         8XIe89aLNkcSvY+nk36saJsVpE4dL559ocQWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056376; x=1761661176;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5wVNQ1TPPYCI18FBmEto8HZyxTAnf2PB3RP/4Cuf/Q=;
        b=cJXeiAhGJTQdCQZZw2os1eaF3TN+PmOS8gmwo2mr5IeOGZJaoqU8DuUhm2wBwfmLOb
         /timACim5lQ9LmumhDKLjTw4vxs+KZkoAj7NpF4Dajtj04+HV5V+5NznpDRpChny5DuB
         GODaydfVTxXojQ33x/+hChhD2grAv4A2eh1pr7QgkGyI10AGkHvNynEWGcExAa510F2j
         LesIw2BpX20zitu3GDHlRO5hEGoblQVlm4cB+7f0lFl9bZ6MVbi/+aBwXBe5J5crQyW7
         4He6FDqnOHmKb04xMeo0Tevh4QZKgWVt4CKhId/o7I3X6zuKRtQ4oNtMqycRE8T7GkQx
         xERQ==
X-Gm-Message-State: AOJu0YxdBbeMIhEJAfEMxZ7ryJClzByVxMjsYrl5BwpvoXGgrCSQhNyD
	oFwtokXUjeQM/R2qDLABj3xEwlPs8EbP0lNAPrVUCbWrCbt5ioDCUcauGQGMPGDFHjlbHEbmhui
	Der+sr9EXBq9IZVRlCJvFkLT+UiX20w5kH7+27/DUvumwDfSY9NqLY/t0shc0CH3ACejLj2VESI
	/32g==
X-Gm-Gg: ASbGncvsFff4i7iRBP1K8ap1lmgEnSesxbXjTLThA78o2qJoyiMIvKa8eqfD144t0vZ
	uSOkZDPOUfEU/iBMKskVlgl0KIn9vJdg+ctMhNSiBeb29wKwkdvx8MDQfhJKfmFZz7bAjM2oZqx
	8Kuok99nCPSB9VcuQ/x/cIOKf8Ofworinj4J8bx85dMWkFkKLWud7w8MHvTfjE3MvNTlcxyvNm9
	jzOjle7LfD22279Q4YQUGV4q+TPfr6keeA47ZlM3CJuqH7+aoMAumKszoZjefbf1OETXqIwwNVB
	cFOAiHM0wOip7sukyGKsDaWT+sHtTjHCsfeFrDUCQsDs/iXZqDJH4Y7u/fwIXs8yD65gEu23a5r
	TqqMOk0SnhhI7mI1e3TY7wrGu+rHu7RvnppxSPP2m9YuIlXfaHrhLfAhQFuvb00gauO20f0njxN
	v18j2vrGI8EsNsLt5b2eyeY4GxGIiq7qE2fWh+9PqQtQ7P1fW8wxLtwklfpPMEa+3P3nis+kSEJ
	L4j5j2POlDYFyc=
X-Google-Smtp-Source: AGHT+IHIaDKojfiTdbsfTEYd+zOBRBeCYxOoeBHDl40xbCNiQqCWeC4TsJBVF0y1C1QNbY6znVFMfg==
X-Received: by 2002:a17:90b:2ccc:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-33bcf8fa1fcmr23266958a91.19.1761056375562;
        Tue, 21 Oct 2025 07:19:35 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de0b42asm11305802a91.9.2025.10.21.07.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:19:35 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] spell-check:successful spelling in driver
Date: Tue, 21 Oct 2025 19:49:29 +0530
Message-ID: <20251021141929.33942-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/android/binder/range_alloc/mod.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder/range_alloc/mod.rs b/drivers/android/binder/range_alloc/mod.rs
index 2301e2bc1a1f..ff9eb7bfc2b3 100644
--- a/drivers/android/binder/range_alloc/mod.rs
+++ b/drivers/android/binder/range_alloc/mod.rs
@@ -291,7 +291,7 @@ pub(crate) enum ReserveNew<T> {
     NeedAlloc(ReserveNewNeedAlloc<T>),
 }
 
-/// Returned by `reserve_new` when the reservation was successul.
+/// Returned by `reserve_new` when the reservation was successful.
 pub(crate) struct ReserveNewSuccess<T> {
     pub(crate) offset: usize,
     pub(crate) oneway_spam_detected: bool,
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

