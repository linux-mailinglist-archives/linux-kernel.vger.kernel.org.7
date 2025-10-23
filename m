Return-Path: <linux-kernel+bounces-866095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1478BFEDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F9E188D4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0A1E990E;
	Thu, 23 Oct 2025 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqDyfHpu"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67051E3DDB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761183686; cv=none; b=BgBv/Xjcz4tzpRheDZbHt3Eicy35ycGb8iweEb3i7VsICa2FpsFi8ZQEORrpR6eeA6LIGJrXJweCHl7Jrt0D9Icc36kOQTTJQRRKJGHGFW7Uwzae/1h41NpzbpOzIWPsETc1fxLeSMMwmtFEuOFbevrGx+WQIhTmueOsxJumcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761183686; c=relaxed/simple;
	bh=3DPT2ECsqKwSg7ut66ATTn1BaxmhelGSo8EQZCwNbgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jrfby/CbRapNs+W6q8R7gX2E93+wGbiLaeaap8nY+D+AecZybExwP13UPMCGqCScY8N6JEQG9GijgYDUgz0i6nQZJaf6ZOitxsn8QiXvwgCSwhhOblI46QdQ4EXqKLcZcp0mldFycJLlMoVPlyyW9Awbb8Hn+FiQaeZqZ2q5ZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqDyfHpu; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so295244a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761183683; x=1761788483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rzb/oNr7wFTg3J3xnm5Y3CrcceSpW2kAmCmptqc3yeI=;
        b=XqDyfHpuooR3x++ZQSBr1J31EcP/WamdJg9K/A2UQKrYKP7bxyJ8DrxBXUmNm44P9q
         0aSoZp+xMb0OWvC42IS67IuxrMKDxM12OX+WBV+lBwaw00163q/lnz8oP1ZACDbjv9pO
         O5MJR3BxnlwQV8Sz2BadAp5ukfXrNqbXcKcK4Ayz7hRaxblAmlfxQcqJ0JBQKmjgbKS0
         FxYCSl0J3fRAR04UaCTs6/yvDyvfnKpopbr2aJ0JUQVN1gv/DmOjZe/vyKIJty9XPN9i
         c8vgBm1ctz+ic5q4yXP4yvq5CEZPAuH2xYT6TL7zPnjWLEtIbKtXELXupgZnBQv23EMa
         iWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761183683; x=1761788483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rzb/oNr7wFTg3J3xnm5Y3CrcceSpW2kAmCmptqc3yeI=;
        b=uPODg05NKnDwFztCtk6PiNFeB6qcFZIUVj56cObRWqRlIuSsdn7akgJo72WahRqyWo
         8koAnpa7UvZwkBzhTL3GvPG4LsOhSA082QzvFmN2IYVOrPQG+zmdeF0Gm891m7LnMwKn
         76ImiUkwo5Nt+X9aDRK969BzDAxnkpiod01yaY9ue01Hr70wq8BErCIXV/gGTIUgTzCF
         r9Of5N8kIeNYBeg5PTRkVecdDHItzqF2hwHgwcyPDT2qjMMA7ySyAKAkBVIbkjeiQYsV
         yU/YXzQz1ddQTX5UbVaL5ulbhHHtQCLexDRtFzqyyvEeXg/AZ72A9+48dTXgTu2BzDrP
         X4Zw==
X-Gm-Message-State: AOJu0Yziq72UyUHMpJIjWZDg8OuM37Rha6iWTKOs0JbFhfLOKiqPIW+y
	7BlA7MT77f/LcEnwV2Ir4XHD1CGV6XleYItj2hl5xl75pCuWmdF3jdD3
X-Gm-Gg: ASbGncst2Axl92Pxl3jbYjF/U/lZhkxHuHWGTMTPcRFqJLjq4cwst1kJoAHPT1WLDZw
	+0/7cpxxLKgLLZiXmuS2PG/rSb3NtVafZEVU4iBX49dvLHKh11GmFAsAHyy3NoFZKQDr+JhA/Xe
	TKpcc1vfu4+jNrUmVVcxZbMAIoHXG77u0Sn2Qd4L6i9OUw2PMDeGeIFXZtrB1xqS8Lzcg+1nvDm
	C1gxgnsgmL+/6O8Icl4bk+8j4Cb4nA7tP6pRE5fhUuLToBKV5XIf1uNHXxgHNGUZZv8dcn8B6R3
	yxeXruO4PR3+Ur6Y/81/x0DIJP9A1CJv56O3nUh0HsfmzcTRr2Plsfi6RKmcoFvdombve+lNk0v
	GDFuyFvzVEWlKeMNu0AS0gcWMpvKwiLsjJQ7DmHAHMxyHryEvHAfkt2Q24K2MvNu/dN4y+nvOgc
	JxOkYpS0eWlGF4yA==
X-Google-Smtp-Source: AGHT+IHyIRvXdVYrV9i1IVQ4yrLt8Zz4b5Hm+8BXHKO49Yornhmp/WfuLPUMpzo6U7zGSqIeB8W5IA==
X-Received: by 2002:a17:90b:1e08:b0:32e:f1c:e778 with SMTP id 98e67ed59e1d1-33fafb9755cmr1009728a91.3.1761183682871;
        Wed, 22 Oct 2025 18:41:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37c14sm570651a91.2.2025.10.22.18.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:41:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 486D3424180B; Thu, 23 Oct 2025 08:41:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Cengiz Can <cengiz@kernel.wtf>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Anselm=20Sch=C3=BCler?= <mail@anselmschueler.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] Documentation: sysrq: Rewrite /proc/sysrq-trigger usage
Date: Thu, 23 Oct 2025 08:41:02 +0700
Message-ID: <20251023014102.16777-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=bagasdotme@gmail.com; h=from:subject; bh=3DPT2ECsqKwSg7ut66ATTn1BaxmhelGSo8EQZCwNbgE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBk/211kX76SnvR916miWyZ/tkj95O0t+uypJyp4usrAu tDwZ9rVjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkgDYjw6dzlhqiFdpOd44n XA9++W2B8643hTMc3qVPVCiQO2H5QICR4Xz0QtUjU0W1Pzun6xx6fXCZxZwbffv6e911nOSVV5w /zgcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

/proc/sysrq-trigger usage documentation (in "On all" section) states
that it is not recommended to write extra characters to it. The sentence
may imply a contradiction to previous sentence which writes that such
characters are ignored.

Rewrite the description.

Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v2 [1]:

  - Keep /proc/sysrq-trigger future API change note (Tomas)

Anselm: Do you object to the rewrite?

[1]: https://lore.kernel.org/linux-doc/20251016103609.33897-2-bagasdotme@gmail.com/

 Documentation/admin-guide/sysrq.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 9c7aa817adc72d..a88266b171aa17 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -75,16 +75,15 @@ On other
 	submit a patch to be included in this section.
 
 On all
-	Write a single character to /proc/sysrq-trigger.
-	Only the first character is processed, the rest of the string is
-	ignored. However, it is not recommended to write any extra characters
-	as the behavior is undefined and might change in the future versions.
-	E.g.::
+	Write a single character to /proc/sysrq-trigger. E.g.::
 
 		echo t > /proc/sysrq-trigger
 
-	Alternatively, write multiple characters prepended by underscore.
-	This way, all characters will be processed. E.g.::
+	Only the first character is processed; any following characters are
+	ignored for now, which might change in the future.
+
+	Alternatively, to write multiple characters, prepend them with an
+	underscore so that these all will be processed. E.g.::
 
 		echo _reisub > /proc/sysrq-trigger
 

base-commit: 0aa760051f4eb3d3bcd812125557bd09629a71e8
-- 
An old man doll... just what I always wanted! - Clara


