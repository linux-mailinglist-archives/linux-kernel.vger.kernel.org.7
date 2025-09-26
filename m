Return-Path: <linux-kernel+bounces-834493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F34BA4CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C155387B03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66D1277807;
	Fri, 26 Sep 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="h6GDha0N"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE0230270
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909732; cv=pass; b=WCVsQeV7YAEZMNRuX3ZMGgZsuL+EsDhbO82PU2yopuGZlZq2xU/zij0wAn9Nczz9/9tD8bCvRfQr5GH9p5RsgLnrK8Fcp9PdknwDxMxB3ofWxZtwZWYgO7W0kBDiSC0kSLxHjzf5lXfvitBL95Zwjd7j1alqvXHKSFWdifIcFqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909732; c=relaxed/simple;
	bh=OOR9QS7FsrEUbkiSOhBHvw8z61s35p8iS3NC0740ZFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pn5pglyyAQbhJJ2Vnp3HfBOIr/B66rAHIaXAgz3cxpw3+79JCSZ1e7SHxB5umhdnfHH9dV4O3b+5Sj4bIKAP5L4kBOCKdUBK2xlH3aKdSXJ2MjsMhirEV9uC4m1k/1rZoJG4x9PMIULrvcxxyfpZOcUpko2tJYWQVBS/6VdlklU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=h6GDha0N; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58QI1f5F058535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 03:01:41 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 09877109D57DE;
	Sat, 27 Sep 2025 03:01:41 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5l6c7Gp273kZ; Sat, 27 Sep 2025 03:01:37 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 7ED9410A24946; Sat, 27 Sep 2025 03:01:37 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758909697;
	cv=none; b=E16RVslQq3BU6s4dWIJ+UZyx20eyfaKhZsr7w2AJgbs/SYcLZ+RaAFdE6hWHxTDh72yMLyvqE3WuHQao57T0Rs0w2Hh39pMPl19FcqaIuHCGht0CcLmKwFu9WRQxiGYVt29YjTwfVtogVmN+IlOBwKO/P5w3FxYrY9g3xMq3Tzc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758909697; c=relaxed/relaxed;
	bh=Cw5jpscVFe2IN4A5FMJB47nSlRNFhSLdLchY2fSh6ys=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=KLEt/0pHJej1xhOSZWE6zk3sJKuDw34gHkJXBNxkHFis/KWNiGiltB1NypuFeYg8KQYqLBPdhHSRHEF8N/+CcEpXDGm9TWW6Gm4VPs9F+gruMEd6yXJ7xqV11TUVqhzWDrbwiu1ct+8XDKNF8HmTNIxYvUQe/Ttu50boOcJBKaY=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 7ED9410A24946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758909697;
	bh=Cw5jpscVFe2IN4A5FMJB47nSlRNFhSLdLchY2fSh6ys=;
	h=From:To:Cc:Subject:Date:From;
	b=h6GDha0NtEQmdoJJDNMx9rh5SVHWBprfRVO+1BLa6o0P67xxW7w8VH5qDHnuDbsot
	 XOoHpeKS/04tCLCqOE1pMtlCg9F9bm+AHft1ESYzi8T1FPz2rQo7uwJWc4TqhTsyiN
	 4HVVitfNqZ9/my6AntEyGYsmkybCw4xDT+fNP6XI=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] Documentation: f2fs: Fix typos in sysfs-fs-f2fs
Date: Sat, 27 Sep 2025 03:01:34 +0900
Message-ID: <20250926180134.35329-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix two spelling mistakes in the f2fs sysfs ABI documentation:
- deivces -> devices
- substracting -> subtracting

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/te=
sting/sysfs-fs-f2fs
index bc0e7fefc39d..6e8043ea33e7 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -822,7 +822,7 @@ What:		/sys/fs/f2fs/<disk>/gc_valid_thresh_ratio
 Date:		September 2024
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	It controls the valid block ratio threshold not to trigger ex=
cessive GC
-		for zoned deivces. The initial value of it is 95(%). F2FS will stop the
+		for zoned devices. The initial value of it is 95(%). F2FS will stop the
 		background GC thread from intiating GC for sections having valid blocks
 		exceeding the ratio.
=20
@@ -847,7 +847,7 @@ Description:	For several zoned storage devices, vendors=
 will provide extra space
 		filesystem level GC. To do that, we can reserve the space using
 		reserved_blocks. However, it is not enough, since this extra space should
 		not be shown to users. So, with this new sysfs node, we can hide the spa=
ce
-		by substracting reserved_blocks from total bytes.
+		by subtracting reserved_blocks from total bytes.
=20
 What:		/sys/fs/f2fs/<disk>/encoding_flags
 Date:		April 2025
--=20
2.47.3


