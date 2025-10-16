Return-Path: <linux-kernel+bounces-856007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68951BE2D89
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B2A3BE896
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02622D4803;
	Thu, 16 Oct 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsQIb6Yj"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA91D5CC6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610995; cv=none; b=GTYFX2sHOTvlIAU9qYfhiyXMfU474/FwLGZEhpYs6Khtd86E9sXqeYb16tnAU5yuKdln1FCP7DCYT3Qvrux7DPTAqJ6uAuBJuhp1oNR4GOe5+ZOaFou0W+PucLttAVrVx4K3TD9cSj/f/h0RDPQziCLpAuBj8afTxxvYhY2DxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610995; c=relaxed/simple;
	bh=kDg7zJyqLivY4/l1H+Tca7EYUDHaYlB7/rBvbKgyZ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VuvtnDkKVUy66bBUv4KZVx0xGapda2dvNgk6tmUE+8FdFFsOtuv3X2AEjUYwP2aT9m10TRbUcPmbn/q2mTNvPDYH8juiRTTOW2hNou7qUnULLG1LGCRe7Y8X16WaEST8Rp+e1I6OGUiUfgeePb4lGqC/tRa7ZQsUm8IqGBh3IwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsQIb6Yj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b553412a19bso364105a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760610993; x=1761215793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U33wVBeZWn4QEaKPiFWLL976xCbviMDRkFuQmbH7L9U=;
        b=VsQIb6Yj8FLCGZX68MCUK+bz1vtGruDHyNFTq3EATe536a1mkMLiV3z+PCF5IXYCVO
         iIHD7OaATfQFtLlDA0JUFEnVqe+Lw9msXhAbVAEQP9IcXEEXbR2BRjO8rfCwB+jHjvoQ
         7HRB1GHEDhhbehoUQ2rSmqOb0zaA5cv3JUxJdq8KTqK991kIg3wbaSKsqmydwTUKcQih
         aS/iEDXbxEhZiiK3eDCHbmSX/uUH1x8MBOpwRiSEZMsR/sQ73t6iv93hmU4oiOzigWby
         FUlnqlf6hb5BUC81Anfd7bHIi3ByQenH1Qmu9GyjQatBIUwrryZn/GOKa9pzLKX9aboj
         sumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760610993; x=1761215793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U33wVBeZWn4QEaKPiFWLL976xCbviMDRkFuQmbH7L9U=;
        b=FdKg2TARvfsl33XcklbuMcmGIP+BzHDiXyn96ExmDZjsj5GnlfvwiAQZLfHH/MAqkz
         rLpkmODsP4uXcgPxxn88BNmG3VDtQ5oEPwgR/84qBF6wRCfVsT3e9eND0jVWeMpqX/2D
         7m58En+cEQLKvuvwkGgEPbEgpj7BJ6auSqE7SnaiK2BnaGQEq+LG76GggoYaxQ3AzupN
         29/kjLJSkTBbUxf2ay91CpndcpyPvH32yUmG49+J6QsAn1o0tk5IihZG1xebeq/DAsFo
         O8G3jiUYzXweU5tCM3X4M0VzdLgYHqv9DezfU2bUp7tDjNEgWSxZw2orTG02fxQNe59C
         LBaw==
X-Gm-Message-State: AOJu0Yw7jwYocXcREuri9mfBD51ljRkuH/jKcdiEsZfq+O3zsnXKJbdZ
	TqG0SF6U0S/0ojNRUg/2TFZanorDVr5Lh24dqTjU0mHVlptXREUqsWsP
X-Gm-Gg: ASbGncsar/3bgBFFYdZoNlrNs8cmXFG7kJylSc3w/7l5n/nVbEilDSKfSLj7ucOtOWS
	z5AelcsK+Rp8jy+WDHdEWHmWOBHSZxc+VwjD0ElVwZ7z0EU4d9Cc3FqWk8Bz+x+gPx1tappzQ7G
	T+ykHtyP8IR9rh6KdDg9Q7+QEr6kw6QiGejBuRfJdHNeDWspHnw+JxIKt4e0jwa7lV29W13Fms1
	pcsFLg3Q35Y+BOpaw0URVswgeWuoh/xuBao7rYZd4ctMmi1gPVtsbWZ1jagwFeUsC5DsptOPEgD
	MRpAdcwp9QbpQcjFoUCi/dTi0xnufXBBiAlYqMnOzEfrDeXp3vwRIHf+XDT+jv/cTHpCIeSr+r+
	BZiWJydOLTxN2x6rsOCBz59AXk66kbtpHGjxjBw9hfvRHwnDe47MJxnAlPMHlYkLB8Mi0kwEswM
	+1fIo=
X-Google-Smtp-Source: AGHT+IHPctzgAiv32FrdsplWmXnwd78JIYIpOpAG4G8Yzyo/AqYrtvdElUpgeZ8mYl5/x0UlR89A2A==
X-Received: by 2002:a17:902:8a89:b0:27e:ec72:f67 with SMTP id d9443c01a7336-29027356abdmr297126485ad.6.1760610993115;
        Thu, 16 Oct 2025 03:36:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7de2fsm25351505ad.58.2025.10.16.03.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:36:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BA0E8400365D; Thu, 16 Oct 2025 17:36:29 +0700 (WIB)
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
Subject: [PATCH v2] Documentation: sysrq: Rewrite /proc/sysrq-trigger usage
Date: Thu, 16 Oct 2025 17:36:10 +0700
Message-ID: <20251016103609.33897-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=bagasdotme@gmail.com; h=from:subject; bh=kDg7zJyqLivY4/l1H+Tca7EYUDHaYlB7/rBvbKgyZ1U=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkfTk76vLJPZ5VPQaZJ84M3Pv+FHGe95vrw2mjbi9/+7 3566a9b31HKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJtPsy/HdfpR/hI60s31Sv Ms+45Jrfs5XmP39O7TnOeW3XjtoVq68yMqyJj+FpUuG5c3rpztKcHjs2EU/rYxsFzj5L8Zm8p29 SFxMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

/proc/sysrq-trigger usage documentation (in "On all" section) states
that it is not recommended to write extra characters to it to avoid
undefined behavior, which is contradictive to previous sentence that
such characters are ignored. Also, in order to actually process them
(as a string), prepending it with underscore is required.

Rewrite the description.

Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  - Rewrite the whole "On all" section (Jon, Randy)

[1]: https://lore.kernel.org/linux-doc/20251008112409.33622-1-bagasdotme@gmail.com/

 Documentation/admin-guide/sysrq.rst | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 9c7aa817adc72d..6157d93e03a1e2 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -75,16 +75,13 @@ On other
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
+	If a string (multiple characters) is written instead, only the
+	first character is processed unless the string is prepended by
+	an underscore, like::
 
 		echo _reisub > /proc/sysrq-trigger
 

base-commit: a1af37b935c73049c54cb1412cf0850212af420e
-- 
An old man doll... just what I always wanted! - Clara


