Return-Path: <linux-kernel+bounces-787208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAEDB37301
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC7A1B68276
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891BA36CC76;
	Tue, 26 Aug 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thiebaut.dev header.i=@thiebaut.dev header.b="HAguUeCU"
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6F3164D9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236248; cv=none; b=SAoAjIKODpUsEw4j0t8arfUbGK1+Jemo/wiKQoP0kP3ac9vxRUJgAexKpPopMoPr6+Q3829LfKkZrkGBii9VR+UPB8emL9AtBQGYJ9F6JAi74svrTjpdI6q7ARlETBQJHfYihzDnMTs5YL6VkW1eqMBvDCTPhUPV6E/l4uTf05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236248; c=relaxed/simple;
	bh=00Q7Hs8jlSNSChMZndYZE2KaWXr25PQNp+p1rSW1QBk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZmhFlXiY+dhxbGdhR9UzwABBQKw8/n6r6ytMIaY41dIw0YSnr8209BpwZ+hpxiZ3Wt8gQhwUmVcW91a5CF6AL58Uqs+XxYNhWg54Oc1Nfgpy1bIsyxObtFnqmEWq1QSRvNG6B5sJPH4YBlnqtMN+2FgN63ThN4LNpKWS9yuP36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thiebaut.dev; spf=pass smtp.mailfrom=thiebaut.dev; dkim=pass (2048-bit key) header.d=thiebaut.dev header.i=@thiebaut.dev header.b=HAguUeCU; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thiebaut.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thiebaut.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thiebaut.dev;
	s=protonmail3; t=1756236237; x=1756495437;
	bh=6n7ZSXtCe9rqZ+HVajqBkrfvKWmKlOKzChZBHFb0bpU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HAguUeCUeT/b/nZFHAL6tqJwqow7HzXeK/KXy9xOhm2OKWdpnHtaRZFFYIRcWaVdE
	 f9HU7GiMpC2b1srG+k4nTHasK0OrmzIpq89BT12+pF2PoLgz42aSpCLLJYCQGiQ71G
	 oO7vn9lf0aQLFmJKsJKKFXLhv6CSUVLeN5QsOI9hklSIhca6NHYQyCfTb2moO3XNus
	 GNjjopIojPYfQcMTJXE2IEhYRSk3PBo0/V5/0UWAr/xl1XYIIhvat2BzBzOj8FWNnh
	 BDnbS89GiJfHn9pVdhupoYxmsrL0w8m/xAL36PjgvWiGe3rNCN4M9vEj5iILbcUpLd
	 AJxjcQLgEVkgw==
Date: Tue, 26 Aug 2025 19:23:49 +0000
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Masahiro Yamada <masahiroy@kernel.org>
From: Maxime Thiebaut <maxime@thiebaut.dev>
Cc: "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] extract-vmlinux: Output used decompression method
Message-ID: <X6OQ4pHdpreJtlTnf0tFEb4Uxz8T8gFv_7Yw6tpBK4ZBgHYjJr_URwUwCVynpkb-H8Yjk7DdBF01zY-sfqu_7N5trZQfcd6s_4PtdGlHtlA=@thiebaut.dev>
Feedback-ID: 14194939:user:proton
X-Pm-Message-ID: 82936b61c33314ae1919a87f4df21c1180443ed6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From 3735cd80fa5baf3231f807174395a8252dfb0c4d Mon Sep 17 00:00:00 2001
From: Maxime Thiebaut <maxime+kernel@thiebaut.dev>
Date: Fri, 22 Aug 2025 10:40:03 +0200
Subject: [PATCH] extract-vmlinux: Output used decompression method

When extract-vmlinux succeeds, it doesn't output which decompression method
was found at which offset. Adding this additional output in check_vmlinux()
helps troubleshooting and reverse-engineering images.

The last check_vmlinux() call was also quoted to accept spaces.

Signed-off-by: Maxime Thiebaut <maxime+kernel@thiebaut.dev>
---
 scripts/extract-vmlinux | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/extract-vmlinux b/scripts/extract-vmlinux
index 189956b5a5c8..266df9bc7a48 100755
--- a/scripts/extract-vmlinux
+++ b/scripts/extract-vmlinux
@@ -10,12 +10,15 @@
 #
 # ----------------------------------------------------------------------
=20
+me=3D${0##*/}
+
 check_vmlinux()
 {
 =09if file "$1" | grep -q 'Linux kernel.*boot executable' ||
 =09=09readelf -h "$1" > /dev/null 2>&1
 =09then
 =09=09cat "$1"
+=09=09echo "$me: Extracted vmlinux using '$2' from offset $3" >&2
 =09=09exit 0
 =09fi
 }
@@ -30,12 +33,11 @@ try_decompress()
 =09do
 =09=09pos=3D${pos%%:*}
 =09=09tail -c+$pos "$img" | $3 > $tmp 2> /dev/null
-=09=09check_vmlinux $tmp
+=09=09check_vmlinux $tmp "$3" $pos
 =09done
 }
=20
 # Check invocation:
-me=3D${0##*/}
 img=3D$1
 if=09[ $# -ne 1 -o ! -s "$img" ]
 then
@@ -57,7 +59,7 @@ try_decompress '\002!L\030'   xxx   'lz4 -d'
 try_decompress '(\265/\375'   xxx   unzstd
=20
 # Finally check for uncompressed images or objects:
-check_vmlinux $img
+check_vmlinux "$img" cat 0
=20
 # Bail out:
 echo "$me: Cannot find vmlinux." >&2

base-commit: 6da752f55bc48fe2cf12ed208ab10295d796c2dd
--=20
2.50.1



