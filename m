Return-Path: <linux-kernel+bounces-662880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91071AC40DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C373BB314
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77F220E012;
	Mon, 26 May 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="ERuRzYax"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DF13C82E;
	Mon, 26 May 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268057; cv=none; b=O72JJWNI6Q2wlF0y+Ol4oEs18W7veufz747MZ9rMBhSr2XItfJyBeq21QHDkCwuD5ZHduNwzB1k/axXw6k8K+E4O34ygAYYu3EckHj+k0kW6DnCbHVqAQJIXr2aqq2kfS4PX31rDjovBcLxWsMDFyJIpvAB0SzWj7pu5RCyYUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268057; c=relaxed/simple;
	bh=wfA0OXfCddUpAyBQw3yxP6zgf6FNxqwcaPO4EqrHQBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7O9gDx0fr/T8rSb0sZo591SQFcTVklz5GdrSxk96gNH68fCTjeN85u2f40rZubIlZaO78IxJ2BaibwTK6oMHy3mLgISjeJOjqFCFliZTYATDNzWqE4oU8n/H/1HDUtl4JAvj0g3LS+RX548IjSyBMvfD89KgeAnKq5pS6bojIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=ERuRzYax; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1748268053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmM4W7gNtdHHgIXWDPAIbmT8q++dEuBoXaCFg+z7w+A=;
	b=ERuRzYaxXLHaFmcpUHLNT1LQySJUhyBsdONlEV42p2QyTCB6M9J7ruiS6IkCuxVMSKVDiS
	wpFrdcUCDYRabeofqjnM+23P3+CUY1pODhzHHNDUxXmE/+dPZioz1weY3KH5gWNX/gDUpJ
	PhD86ZOTJcLa5/24PgV/nw0ZvnGARdFLOw+eVcPg4i3luOCu5lVVFXvBx4Dl4muJS0s3R9
	wwqW1lc9O6dWBpUG/2S6Hn5greW8DVeIyx/VJ4E9gY4UQPWwAWmWvl0DLnrkVG2QAcXJmR
	/RloKenqCaYNwOPRa9FNNZzXwo6LSizrhmEMdAuQb3wUKHVFdLb7j+ZcYSr7LA==
From: George Anthony Vernon <contact@gvernon.com>
To: dmitry.torokhov@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: George Anthony Vernon <contact@gvernon.com>,
	bagasdotme@gmail.com,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 3/4] input: docs: Fix Amiga joysticks grammar
Date: Mon, 26 May 2025 14:59:51 +0100
Message-ID: <20250526135957.180254-4-contact@gvernon.com>
In-Reply-To: <20250526135957.180254-1-contact@gvernon.com>
References: <20250526135957.180254-1-contact@gvernon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make small grammar fixes to Amiga joystick documentation.

Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---
 Documentation/input/devices/amijoy.rst | 85 +++++++++++++-------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/Documentation/input/devices/amijoy.rst b/Documentation/input/devices/amijoy.rst
index ea4de1ac0360..cbc5240f8af3 100644
--- a/Documentation/input/devices/amijoy.rst
+++ b/Documentation/input/devices/amijoy.rst
@@ -1,14 +1,13 @@
-~~~~~~~~~~~~~~~~~~~~~~~~~
-Amiga joystick extensions
-~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~
+Amiga joysticks
+~~~~~~~~~~~~~~~
 
 
-Amiga 4-joystick parport extension
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Amiga 4-joystick parallel port extension
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Parallel port pins:
 
-
 =====  ======== ====   ==========
 Pin    Meaning  Pin    Meaning
 =====  ======== ====   ==========
@@ -90,17 +89,17 @@ Pin Meaning
 
 -------------------------------------------------------------------------------
 
-======== === ==== ==== ====== ========================================
+======== === ==== ==== ====== ===========================================
 NAME     rev ADDR type chip   Description
-======== === ==== ==== ====== ========================================
-JOY0DAT      00A   R   Denise Joystick-mouse 0 data (left vert, horiz)
-JOY1DAT      00C   R   Denise Joystick-mouse 1 data (right vert,horiz)
-======== === ==== ==== ====== ========================================
+======== === ==== ==== ====== ===========================================
+JOY0DAT      00A   R   Denise Joystick-mouse 0 data (left vert., horiz.)
+JOY1DAT      00C   R   Denise Joystick-mouse 1 data (right vert., horiz.)
+======== === ==== ==== ====== ===========================================
 
         These addresses each read a 16 bit register. These in turn
         are loaded from the MDAT serial stream and are clocked in on
         the rising edge of SCLK. MLD output is used to parallel load
-        the external parallel-to-serial converter.This in turn is
+        the external parallel-to-serial converter. This in turn is
         loaded with the 4 quadrature inputs from each of two game
         controller ports (8 total) plus 8 miscellaneous control bits
         which are new for LISA and can be read in upper 8 bits of
@@ -108,7 +107,7 @@ JOY1DAT      00C   R   Denise Joystick-mouse 1 data (right vert,horiz)
 
         Register bits are as follows:
 
-        - Mouse counter usage (pins  1,3 =Yclock, pins 2,4 =Xclock)
+        - Mouse counter usage (pins 1,3 =Yclock, pins 2,4 =Xclock)
 
 ======== === === === === === === === === ====== === === === === === === ===
     BIT#  15  14  13  12  11  10  09  08     07  06  05  04  03  02  01  00
@@ -179,12 +178,12 @@ JOYTEST       036   W   Denise  Write to all 4  joystick-mouse counters at once.
 
 -------------------------------------------------------------------------------
 
-======= === ==== ==== ====== ========================================
+======= === ==== ==== ====== ===========================================
 NAME    rev ADDR type chip   Description
-======= === ==== ==== ====== ========================================
-POT0DAT  h  012   R   Paula  Pot counter data left pair (vert, horiz)
-POT1DAT  h  014   R   Paula  Pot counter data right pair (vert,horiz)
-======= === ==== ==== ====== ========================================
+======= === ==== ==== ====== ===========================================
+POT0DAT  h  012   R   Paula  Pot counter data left pair (vert., horiz.)
+POT1DAT  h  014   R   Paula  Pot counter data right pair (vert., horiz.)
+======= === ==== ==== ====== ===========================================
 
         These addresses each read a pair of 8 bit pot counters.
         (4 counters total). The bit assignment for both
@@ -213,8 +212,8 @@ POT1DAT  h  014   R   Paula  Pot counter data right pair (vert,horiz)
          +-------+------+-----+-----+-------+
 
          With normal (NTSC or PAL) horiz. line rate, the pots will
-         give a full scale (FF) reading with about 500kohms in one
-         frame time. With proportionally faster horiz line times,
+         give a full scale (FF) reading with about 500k ohm in one
+         frame time. With proportionally faster horiz. line times,
          the counters will count proportionally faster.
          This should be noted when doing variable beam displays.
 
@@ -238,26 +237,26 @@ POTINP     016   R   Paula  Pot pin data read
         This register controls a 4 bit bi-direction I/O port
         that shares the same 4 pins as the 4 pot counters above.
 
-         +-------+----------+---------------------------------------------+
-         | BIT#  | FUNCTION | DESCRIPTION                                 |
-         +=======+==========+=============================================+
-         | 15    | OUTRY    | Output enable for Paula pin 33              |
-         +-------+----------+---------------------------------------------+
-         | 14    | DATRY    | I/O data Paula pin 33                       |
-         +-------+----------+---------------------------------------------+
-         | 13    | OUTRX    | Output enable for Paula pin 32              |
-         +-------+----------+---------------------------------------------+
-         | 12    | DATRX    | I/O data Paula pin 32                       |
-         +-------+----------+---------------------------------------------+
-         | 11    | OUTLY    | Out put enable for Paula pin 36             |
-         +-------+----------+---------------------------------------------+
-         | 10    | DATLY    | I/O data Paula pin 36                       |
-         +-------+----------+---------------------------------------------+
-         | 09    | OUTLX    | Output enable for Paula pin 35              |
-         +-------+----------+---------------------------------------------+
-         | 08    | DATLX    | I/O data  Paula pin 35                      |
-         +-------+----------+---------------------------------------------+
-         | 07-01 |   X      | Not used                                    |
-         +-------+----------+---------------------------------------------+
-         | 00    | START    | Start pots (dump capacitors,start counters) |
-         +-------+----------+---------------------------------------------+
+         +-------+----------+----------------------------------------------+
+         | BIT#  | FUNCTION | DESCRIPTION                                  |
+         +=======+==========+==============================================+
+         | 15    | OUTRY    | Output enable for Paula pin 33               |
+         +-------+----------+----------------------------------------------+
+         | 14    | DATRY    | I/O data Paula pin 33                        |
+         +-------+----------+----------------------------------------------+
+         | 13    | OUTRX    | Output enable for Paula pin 32               |
+         +-------+----------+----------------------------------------------+
+         | 12    | DATRX    | I/O data Paula pin 32                        |
+         +-------+----------+----------------------------------------------+
+         | 11    | OUTLY    | Out put enable for Paula pin 36              |
+         +-------+----------+----------------------------------------------+
+         | 10    | DATLY    | I/O data Paula pin 36                        |
+         +-------+----------+----------------------------------------------+
+         | 09    | OUTLX    | Output enable for Paula pin 35               |
+         +-------+----------+----------------------------------------------+
+         | 08    | DATLX    | I/O data  Paula pin 35                       |
+         +-------+----------+----------------------------------------------+
+         | 07-01 |   X      | Not used                                     |
+         +-------+----------+----------------------------------------------+
+         | 00    | START    | Start pots (dump capacitors, start counters) |
+         +-------+----------+----------------------------------------------+
-- 
2.49.0


