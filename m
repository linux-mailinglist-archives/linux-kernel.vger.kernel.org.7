Return-Path: <linux-kernel+bounces-825144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58435B8B1C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA64564F07
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB12BE62B;
	Fri, 19 Sep 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="XmGY5qmq"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91825BEF1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311402; cv=pass; b=MVzevAVmHAiq98CfO/JXBVcrT6UAH7aPdXzoFf/Hz5uiFw/Fryl2i9stnxr4qOOD6Gb+jsLWaZqsdZpN1ddOn5TMQW6MTZPtlz18n/zjk4qI0ytSlS0Mc5B4B620ge3U+qA83PTiapk55aPc8pBMkeiIeALtmRrHG+cMzTZ3+Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311402; c=relaxed/simple;
	bh=LMlfmGweJcMHVFK/0DcnarQ6Fnh6aYFQxAZl9n8htqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpq4VBjQlkr1h8DXQ0nKgOwJSg6C47sGqfwVdg0ZQTtEdcCfZtqGTfLsdN3eJXUF6EJHMangYwMfjocShcNe44iDtEH45Wpr2afMcfKz3qHlaagNjcyZhURxdo5M5OtfGhdDUQQIB6yWUpw49oCwczeDQMOIZ14NweQdOFpUNzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=XmGY5qmq; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 7B33010E4CA7F;
	Sat, 20 Sep 2025 04:49:50 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Authentication-Results: redadmin.org (amavis); dkim=pass (1024-bit key)
 header.d=redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lqtl9zk-C88P; Sat, 20 Sep 2025 04:49:44 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id C8ED210E4C3D4; Sat, 20 Sep 2025 04:49:44 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758311384;
	cv=none; b=a1uPXYpXSGx6J4/RDNjOiQISuJr6+vuxnLc0UpxUIMax0yIXrXa2g7w8ph9ATzPeLjlT/gD4yBwmaqQcl2a5DyzXMToRmpnLAzCIKu+5jDr3gZ8l9+pHQuCu3AupaU4ceR6D9Qb8ElNlELK+x7GbZAXxHtfZe5Js7PiNvIcw97o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758311384; c=relaxed/relaxed;
	bh=06/H+mNhgkNl4weidYr1veKGraAktPUNHw5HfVNMgng=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=IPhmbgbgAlqbfsKVjM8XPpckLz3ng4VDDOlqWgelJrWF4P27mLwjmoftaLFvtzQPmeFwmhbsKyZm4txge5tp4AruOAJ1LFPw0DEJKTYr7fRbhjQkqhiDP0Ya0WhHDLyuI+5V/MKbahiuYil8brGOswB2hQtkzFSbjcZN+8W9V9I=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org C8ED210E4C3D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758311384;
	bh=06/H+mNhgkNl4weidYr1veKGraAktPUNHw5HfVNMgng=;
	h=From:To:Cc:Subject:Date:From;
	b=XmGY5qmq7+ZDnYedTFQ1PvkT8Q8E4ttQaxzRvRVgpW4+ZqXn1brO5U3SXcjjpoAXr
	 bF7oejtgIwwk54DCN8nwQgC4qMObbu5ipG4nzzy5J2haq9y3FrgT3vhDSjH3RygyHm
	 q/vJcequCEiXNvsFkUNrD5b9/k0AA9BfnDXUKRsA=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org,
	Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] docs: ABI: hid-roccat-arvo: fix typo 'Januar' to 'January'
Date: Sat, 20 Sep 2025 04:49:40 +0900
Message-ID: <20250919194940.1828573-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 .../ABI/obsolete/sysfs-driver-hid-roccat-arvo          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-arvo b/Docu=
mentation/ABI/obsolete/sysfs-driver-hid-roccat-arvo
index 55e281b0071a..1f68c9bed117 100644
--- a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-arvo
+++ b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-arvo
@@ -1,5 +1,5 @@
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>=
/<hid-bus>:<vendor-id>:<product-id>.<num>/arvo/roccatarvo<minor>/actual_pro=
file
-Date:		Januar 2011
+Date:		January 2011
 Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
 Description:	The integer value of this attribute ranges from 1-5.
 		When read, this attribute returns the number of the actual
@@ -9,7 +9,7 @@ Description:	The integer value of this attribute ranges fro=
m 1-5.
 Users:		http://roccat.sourceforge.net
=20
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>=
/<hid-bus>:<vendor-id>:<product-id>.<num>/arvo/roccatarvo<minor>/button
-Date:		Januar 2011
+Date:		January 2011
 Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
 Description:	The keyboard can store short macros with consist of 1 button =
with
 		several modifier keys internally.
@@ -20,7 +20,7 @@ Description:	The keyboard can store short macros with con=
sist of 1 button with
 Users:		http://roccat.sourceforge.net
=20
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>=
/<hid-bus>:<vendor-id>:<product-id>.<num>/arvo/roccatarvo<minor>/info
-Date:		Januar 2011
+Date:		January 2011
 Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
 Description:	When read, this file returns some info about the device like =
the
 		installed firmware version.
@@ -29,7 +29,7 @@ Description:	When read, this file returns some info about=
 the device like the
 Users:		http://roccat.sourceforge.net
=20
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>=
/<hid-bus>:<vendor-id>:<product-id>.<num>/arvo/roccatarvo<minor>/key_mask
-Date:		Januar 2011
+Date:		January 2011
 Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
 Description:	The keyboard lets the user deactivate 5 certain keys like the
 		windows and application keys, to protect the user from the outcome
@@ -42,7 +42,7 @@ Description:	The keyboard lets the user deactivate 5 cert=
ain keys like the
 Users:		http://roccat.sourceforge.net
=20
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>=
/<hid-bus>:<vendor-id>:<product-id>.<num>/arvo/roccatarvo<minor>/mode_key
-Date:		Januar 2011
+Date:		January 2011
 Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
 Description:	The keyboard has a condensed layout without num-lock key.
 		Instead it uses a mode-key which activates a gaming mode where
--=20
2.47.3


