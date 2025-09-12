Return-Path: <linux-kernel+bounces-813180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD7B541AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3A51C8585F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863EF26980B;
	Fri, 12 Sep 2025 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLjheuTd"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E063D544
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757651002; cv=none; b=SkJ2DmwVq18Nf6BjC6624FCqgfFrkVBGZude4gwo8PsbLd0Zu9Np02vnD1eNkPkd+aIi+y41ZuZ3LdLd0lDvsk6HNenxeDu4/4vovKyIgaAogUGJnIH+FexBi/Hltm8xtN7ofk+0rTBOBe+JPr5QsKmbIa7epnYW+fVRr/YnQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757651002; c=relaxed/simple;
	bh=zZkkZ9jtVN9zl8MOUiaRZ/AhuJkVluKe+HXlB+7F8d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EY4m5ErQZpr7GV7utzeCB5f5T25UO3N9mRdHcz9m0Gy9lbz8M/52jSg15FvLr3fsqj3HoE7e9oB+aVV2dxDPfju1kIkiREZfYRfY5Q6XPXPAwXfOzVCGm4CdnEsw2S79CNdYnGsrL8vvk54QHfb3FEdnAbJ+Gx1Szy5ubhG9kTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLjheuTd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2570bf605b1so14012375ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757651000; x=1758255800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6PvSPHugeaR1Sq9Pxzgn3oZJDYqC50hx/s/XnB6afU=;
        b=kLjheuTdORupPVxkhvb9zLIAdStvRNEUQ0+F5iExvln4+HPQAKvRk2lxM0o9YObx8Y
         KGdLZNUp4wDRv0uYR9iqnFmGDZdKbElcgFq8UhJwwc397Wby7tUvyxp/rtX838/dplWm
         KvMrvJgP440JAgPHkkpiPwA4TAw3L36x4mIq/E7fUD/Q05fivqo3MCUsvF1gzomIuDfg
         7WX+vy+IPlpib2PVkxiReBW73MIWZPPIwFU4X/emqvIFz8hBvgRLHCL/Xknh8nQmFK6x
         B29sdgS807XDysODEjsDlopUSbfHgjcRpCRzi8Z4NhUj1b68noDKr81lDAmCYHLZK5HY
         wEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757651000; x=1758255800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6PvSPHugeaR1Sq9Pxzgn3oZJDYqC50hx/s/XnB6afU=;
        b=iHE2MBw59PHEg57bs9wLqInkIR1DA05IevQbTkrOQzieVmV95uZT6OhX8JGGr2I5Ax
         +zhqI4KNfbozBvVNGO4QlHf+2urF4CtAbbUONb3by4lbA2Yz42wqHagHPG5QfK6D1Xci
         iHx3EOGEKPcvzGGzBMX7i4ckg4n3mmyWrcD1AGbZPPDa7TFY9CP9qBlbVrC+oRxqhnRp
         CVoB45jmSEfgxi2aRaN3QoOHbmIl8JgJ2xltimBsL3DTHzDrG47iYJ2I65nOX5yEiY53
         +oFdY/NMj6cOMQoU+awMTlQT2iAc3052jOrhYnsmpXwm2dg8T/0+MVCU2JxQW9vwHXmj
         Mt9w==
X-Gm-Message-State: AOJu0YyQhOgOb4g/XKaH5/R2SWrK+jj2mMZ4cJBDoevVYe3eq27Yjsp9
	m+8SW073Xt/spSFmdLxb2zJvXto7YMdrhB1fNNm7OSm4GpOat3ikTpCX
X-Gm-Gg: ASbGncvypnRdB57lRWFIQMsoKivpVvmNmlHn21AGaBzw72N3YRDepKS1P/LtNeI13G/
	trD67Q1mzzDjanHb5FxIwodgBInK84vXTK0G1HXYRj0FOX+SWfnbiNJdaLON+62A8nNyvaU3qea
	mzWoLvHJC8kCq5WKKH5Pi1E4TITwoHkuaW9AyijsfC55QkP/Aq/Lv5ABU69eyQJFv9WWHOQ6iLo
	JsH72ZD+ug06MXrl4kZicgs+B9ggMUel+0R1beDlOFHBCIhBwecPLvNxq9Esuh6FFQXEdW/Ufzr
	fLhnmZ/ZKUP2Cvh3s9fBfW3+B/t7j0NA8OgIMULEp8V/N8rVK3dWXesmyiG7vVc1HB5/ms3owX3
	4b/wwH6Oxo1KFJ6mg3OD+tmVlgIHbrUYSB32K
X-Google-Smtp-Source: AGHT+IGSxOJrm+Mvz9B8cJ0ttlzyEuGc0X0ipj/MPkzlUoUdDejseGoH8X0VU1oZg8lHeiFEhrUVdA==
X-Received: by 2002:a17:903:b90:b0:246:4de6:5cc0 with SMTP id d9443c01a7336-25d27c16684mr16832255ad.53.1757651000208;
        Thu, 11 Sep 2025 21:23:20 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a5ecsm35469935ad.92.2025.09.11.21.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:23:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C2DF541FA3A4; Fri, 12 Sep 2025 11:23:17 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RESEND net-next] Documentation: ARCnet: Update obsolete contact info
Date: Fri, 12 Sep 2025 11:22:52 +0700
Message-ID: <20250912042252.19901-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5408; i=bagasdotme@gmail.com; h=from:subject; bh=zZkkZ9jtVN9zl8MOUiaRZ/AhuJkVluKe+HXlB+7F8d0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmHFwhqrrrmfmWSwK7CGq1sIeei0qrrpR2c+3ZzL796e 1LmjkUHOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRj8oM/6ut9syU85nFFzDf 2eLpqR1NDnf/ClXvXMTtuTT9k7FwzGRGhh02qpaL+4IVw6aeZflkLjc599Snac/bti+fV+Jx0nu PLhcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

ARCnet docs states that inquiries on the subsystem should be emailed to
Avery Pennarun <apenwarr@worldvisions.ca>, for whom has been in CREDITS
since the beginning of kernel git history and the subsystem is now
maintained by Michael Grzeschik since c38f6ac74c9980 ("MAINTAINERS: add
arcnet and take maintainership"). In addition, there used to be a
dedicated ARCnet mailing list but its archive at epistolary.org has been
shut down. ARCnet discussion nowadays take place in netdev list.

Update contact information.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/arcnet-hardware.rst | 13 +++---
 Documentation/networking/arcnet.rst          | 48 +++++---------------
 2 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/Documentation/networking/arcnet-hardware.rst b/Documentation/networking/arcnet-hardware.rst
index 3bf7f99cd7bbf0..1e4484d880fe67 100644
--- a/Documentation/networking/arcnet-hardware.rst
+++ b/Documentation/networking/arcnet-hardware.rst
@@ -4,6 +4,8 @@
 ARCnet Hardware
 ===============
 
+:Author: Avery Pennarun <apenwarr@worldvisions.ca>
+
 .. note::
 
    1) This file is a supplement to arcnet.txt.  Please read that for general
@@ -13,9 +15,9 @@ ARCnet Hardware
 
 Because so many people (myself included) seem to have obtained ARCnet cards
 without manuals, this file contains a quick introduction to ARCnet hardware,
-some cabling tips, and a listing of all jumper settings I can find. Please
-e-mail apenwarr@worldvisions.ca with any settings for your particular card,
-or any other information you have!
+some cabling tips, and a listing of all jumper settings I can find. If you
+have any settings for your particular card, and/or any other information you
+have, do not hesistate to :ref:`email to netdev <arcnet-netdev>`.
 
 
 Introduction to ARCnet
@@ -3226,9 +3228,6 @@ Settings for IRQ Selection (Lower Jumper Line)
 Other Cards
 ===========
 
-I have no information on other models of ARCnet cards at the moment.  Please
-send any and all info to:
-
-	apenwarr@worldvisions.ca
+I have no information on other models of ARCnet cards at the moment.
 
 Thanks.
diff --git a/Documentation/networking/arcnet.rst b/Documentation/networking/arcnet.rst
index 82fce606c0f0bc..cd43a18ad1494b 100644
--- a/Documentation/networking/arcnet.rst
+++ b/Documentation/networking/arcnet.rst
@@ -4,6 +4,8 @@
 ARCnet
 ======
 
+:Author: Avery Pennarun <apenwarr@worldvisions.ca>
+
 .. note::
 
    See also arcnet-hardware.txt in this directory for jumper-setting
@@ -30,18 +32,7 @@ Come on, be a sport!  Send me a success report!
 
 (hey, that was even better than my original poem... this is getting bad!)
 
-
-.. warning::
-
-   If you don't e-mail me about your success/failure soon, I may be forced to
-   start SINGING.  And we don't want that, do we?
-
-   (You know, it might be argued that I'm pushing this point a little too much.
-   If you think so, why not flame me in a quick little e-mail?  Please also
-   include the type of card(s) you're using, software, size of network, and
-   whether it's working or not.)
-
-   My e-mail address is: apenwarr@worldvisions.ca
+----
 
 These are the ARCnet drivers for Linux.
 
@@ -59,23 +50,14 @@ ARCnet 2.10 ALPHA, Tomasz's all-new-and-improved RFC1051 support has been
 included and seems to be working fine!
 
 
+.. _arcnet-netdev:
+
 Where do I discuss these drivers?
 ---------------------------------
 
-Tomasz has been so kind as to set up a new and improved mailing list.
-Subscribe by sending a message with the BODY "subscribe linux-arcnet YOUR
-REAL NAME" to listserv@tichy.ch.uj.edu.pl.  Then, to submit messages to the
-list, mail to linux-arcnet@tichy.ch.uj.edu.pl.
-
-There are archives of the mailing list at:
-
-	http://epistolary.org/mailman/listinfo.cgi/arcnet
-
-The people on linux-net@vger.kernel.org (now defunct, replaced by
-netdev@vger.kernel.org) have also been known to be very helpful, especially
-when we're talking about ALPHA Linux kernels that may or may not work right
-in the first place.
-
+ARCnet discussions take place on netdev. Simply send your email to
+netdev@vger.kernel.org and make sure to Cc: maintainer listed in
+"ARCNET NETWORK LAYER" heading of Documentation/process/maintainers.rst.
 
 Other Drivers and Info
 ----------------------
@@ -523,17 +505,9 @@ can set up your network then:
 It works: what now?
 -------------------
 
-Send mail describing your setup, preferably including driver version, kernel
-version, ARCnet card model, CPU type, number of systems on your network, and
-list of software in use to me at the following address:
-
-	apenwarr@worldvisions.ca
-
-I do send (sometimes automated) replies to all messages I receive.  My email
-can be weird (and also usually gets forwarded all over the place along the
-way to me), so if you don't get a reply within a reasonable time, please
-resend.
-
+Send mail following :ref:`arcnet-netdev`. Describe your setup, preferably
+including driver version, kernel version, ARCnet card model, CPU type, number
+of systems on your network, and list of software in use.
 
 It doesn't work: what now?
 --------------------------

base-commit: 2f186dd5585c3afb415df80e52f71af16c9d3655
-- 
An old man doll... just what I always wanted! - Clara


