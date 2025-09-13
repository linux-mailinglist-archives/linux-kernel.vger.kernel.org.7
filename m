Return-Path: <linux-kernel+bounces-815297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A996B56256
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11BF44E0533
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED281F8755;
	Sat, 13 Sep 2025 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="BeTEbU+0"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C7EAF9;
	Sat, 13 Sep 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757784864; cv=pass; b=uBKkDyD1M8iaaN4SpCSNFO++cqldx6ikalX1WvQY2hnhaTUyoaaLKzO2lMqkoERdx6HIQH2bh3eUg+sOYUWP5+YQihicAJrwQtKYG4Cmu/Zte/wZZ52lVcljjPS9orJKhjNmnw9pFHTwOcB9S4XhHi6KglzeefJtFVXlALH5BPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757784864; c=relaxed/simple;
	bh=GimA55GhBUtSka0KXGQTI8PV1VvmRaA5WdoDN040dOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKbgxlJuZ8IyMD/W01dX/iHtj1EnUGh2xg8plleg8AmePLmDkWJC+MJKBPm9sfPZBSARZ5zDAIEecD6hI8nMCgF2AOULAjROUKkzWz6bLhNUkHviOKMTIYRBJm1oNL9RpUn1D2U6loTSDe3WUm8JospfbQHZQNeKL98iM5nN53I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=BeTEbU+0; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id B4971104A17ED;
	Sun, 14 Sep 2025 02:34:18 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rczm48LwjkC; Sun, 14 Sep 2025 02:34:15 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 78ABA10B40B73; Sun, 14 Sep 2025 02:34:15 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757784855;
	cv=none; b=wWvmP5jxZKNXBzoVF3JU5k68JFDd4LinCthVgR+nbeXMoWDRpFX/B1ykUVgi6zPFeaRPsi7XhEHwXnL0m++UUZmZeXjWn2Wce+ajKWZ9IsiQC7JMOYtNJLHJ0d3YDN3TXZ2qC9CmQvWZSDX2/NKbSuJ/ghs9TCLvy5pDavsPEbU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757784855; c=relaxed/relaxed;
	bh=GimA55GhBUtSka0KXGQTI8PV1VvmRaA5WdoDN040dOA=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=jfL4wqfqcAs7V2U/2znYz2CAsulYrEDj8IejZHUBp4CAyJfRsxexKTabCplU4F0GSinZynXR1xCAPlUaBVExS+UytWKmR8olifG4BvQq1EOrxiddmhmHN43qWBGy7FlboU5VCvjPVtBsYVLC3O9d5z+3cnxwTi2niozfe1tGeoM=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 78ABA10B40B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757784855;
	bh=GimA55GhBUtSka0KXGQTI8PV1VvmRaA5WdoDN040dOA=;
	h=From:To:Cc:Subject:Date:From;
	b=BeTEbU+0CmPkRd7IruFHfKNdAkDgMR6Mrg6sVnktbkIzdCcQQobTp33MS9z1ZfYVx
	 enGOifIH7q6cSheJfHFAJfu3ItRZF7BiDBrnsXLdMpc9UZFng3aDo+4gaw4LjKobNa
	 E25F/chCdb0tjAOMtvg6hi9e3OFZXBrrLux9v7Yk=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: platform-driver-x86@vger.kernel.org,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com,
	W_Armin@gmx.de
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] docs: w1: ds2482: fix typo in buses
Date: Sun, 14 Sep 2025 02:34:13 +0900
Message-ID: <20250913173413.951378-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Correct a spelling mistake in ds2482.rst
("busses" -> "buses").

No functional change.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 Documentation/w1/masters/ds2482.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/w1/masters/ds2482.rst b/Documentation/w1/masters=
/ds2482.rst
index 17ebe8f660cd..5862024e4b15 100644
--- a/Documentation/w1/masters/ds2482.rst
+++ b/Documentation/w1/masters/ds2482.rst
@@ -22,7 +22,7 @@ Description
 -----------
=20
 The Maxim/Dallas Semiconductor DS2482 is a I2C device that provides
-one (DS2482-100) or eight (DS2482-800) 1-wire busses.
+one (DS2482-100) or eight (DS2482-800) 1-wire buses.
=20
=20
 General Remarks
--=20
2.47.3


