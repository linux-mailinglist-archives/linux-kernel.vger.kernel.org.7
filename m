Return-Path: <linux-kernel+bounces-815299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF09B5625C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2E71BC1552
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2187D200110;
	Sat, 13 Sep 2025 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="p0ViBRQa"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1A11CBA;
	Sat, 13 Sep 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757785085; cv=pass; b=NMfjrIHmuFM8B6kyHuJd0uGbGV3oWRkvr1KqeQNRvVucOiCTngUbWQullSZhhwtuTRrIR+gS4yzMAk1mDNfW9XryT6ai6H3gHXU03Y+g0tt890J5xDIztuX/f2Mn5uBdZ3dmQPsJdHpvH0yX2GDxD0Gt/0hPD0xmESmTHi1gi3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757785085; c=relaxed/simple;
	bh=dWCb/vnvK0BtdkWp3MFmAB/oC5jsmUMTgwfKeUuN9M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqNrw2lZ2BUKRLNSPteWrVQi10M6xH2OcvF2wRksP2JbJe8rHD8KT7uI8U2oAjMKrzCNNnTF5NfsJxcFEblTQkW7TFqLpn0zP24VRe35pu2cE1N/MxjRf2IqHaE/NDEKJCm32+etUD2/4IdcjEEFgbfLwamd3zQXy6ew9g9Hdvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=p0ViBRQa; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 6EC52107E491D;
	Sun, 14 Sep 2025 02:38:01 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bFH5I1WReXb6; Sun, 14 Sep 2025 02:37:57 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 1850E10B40B73; Sun, 14 Sep 2025 02:37:57 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757785077;
	cv=none; b=krwGIjBFcsRPbmWtsuD0CzEb2FggGl48J/m7jiXhJ10t88iJXAg/HOUZQTkIv6d2oKNNPiWSC0QT6EIKJ+bYL78RCzep4hdiC3rjYwjcHDTFwMb9A7PfkrnBrzUCWJUWineogXX+YecHrsRGaQM+6/G45v0VFgYMpDzxKANNahY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757785077; c=relaxed/relaxed;
	bh=pB4FLnsJZ/3z3o0EVbQQcG9ZUrnntGwHKSlQlpuIDMM=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=Ncnmt9zW7OmM5mMK5CBhTB2LjFsSbLHHq4TYL0Gth14222djV9aZt3NJl/qv+xbzPnW2G6ZFbNjdDgMi+nOkloG3bp6AGTQBHJVRnhE5qakEMzDctx9L3cuXg6+W2ogV1QdxL0OTtLok1zf/zpl9TXcE6XQTgyX6tJIqNmEmM3k=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 1850E10B40B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757785077;
	bh=pB4FLnsJZ/3z3o0EVbQQcG9ZUrnntGwHKSlQlpuIDMM=;
	h=From:To:Cc:Subject:Date:From;
	b=p0ViBRQaZoLfPtweriyKLR2PAyVkhWLYjSL89QLIYpgXPpfW7hxKhF42kKdRRx81r
	 LAjcBVGfGpqJ/7XlKFTI88r5o1W6AOC5rH+CdjvuSdMvYPXpG+KDsCkxIiqyv0Eghx
	 5BG2U7sBHBrcQyjd5O/uTA94zdIaAxIt3ZNfkQW0=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: platform-driver-x86@vger.kernel.org,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com,
	W_Armin@gmx.de
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] docs: wmi: lenovo-wmi-gamezone: fix typo in frequency
Date: Sun, 14 Sep 2025 02:37:54 +0900
Message-ID: <20250913173754.951858-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a spelling mistake in lenovo-wmi-gamezone.rst
("freqency" -> "frequency").

No functional change.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 Documentation/wmi/devices/lenovo-wmi-gamezone.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentat=
ion/wmi/devices/lenovo-wmi-gamezone.rst
index 997263e51a7d..167548929ac2 100644
--- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
@@ -153,7 +153,7 @@ data using the `bmfdec <https://github.com/pali/bmfdec>=
`_ utility:
     [WmiDataId(1), read, Description("P-State ID.")] uint32 PStateID;
     [WmiDataId(2), read, Description("CLOCK ID.")] uint32 ClockID;
     [WmiDataId(3), read, Description("Default value.")] uint32 defaultvalu=
e;
-    [WmiDataId(4), read, Description("OC Offset freqency.")] uint32 OCOffs=
etFreq;
+    [WmiDataId(4), read, Description("OC Offset frequency")] uint32 OCOffs=
etFreq;
     [WmiDataId(5), read, Description("OC Min offset value.")] uint32 OCMin=
Offset;
     [WmiDataId(6), read, Description("OC Max offset value.")] uint32 OCMax=
Offset;
     [WmiDataId(7), read, Description("OC Offset Scale.")] uint32 OCOffsetS=
cale;
--=20
2.47.3


