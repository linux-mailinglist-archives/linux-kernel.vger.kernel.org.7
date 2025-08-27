Return-Path: <linux-kernel+bounces-788240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EE2B381AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4FC1BA6BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AEF31283E;
	Wed, 27 Aug 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="hnlMpctT"
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0555304BA6;
	Wed, 27 Aug 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295072; cv=none; b=bTkdC6GqNBMD0JXDdx4QWitK3th76/kdFMHgHsY365al5jKhu/UpnOc/mUqv7IBbsXlIRdYlNdGXn55ijpNP9EY2cXyoUXHpiXRpQwy4KIlyXKTjkInyUEP/awCj9WM0KQIt3W3YGWYvprNw1VWBFxyp4O1Tf3iAacI8nvZpLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295072; c=relaxed/simple;
	bh=HrMzN83Z+OqzS/BaEKv4QwuDuv3LoZ3f5yvP91A9C9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOgqhq4IMIxvpSKo/QunZTf+qewgc/wocbRTY4zV1yb8gHG6fk/W7QW5/qS1rrdNznamS/JlQyUnNfKmlQThpAouunaabNPTKKZGAvK39hsEiWmfUbD0QZpox1qwmbYIeutUZ5ctBSu7u1/kbfc7iTZBKBsR0HoO2FGKGuExuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=hnlMpctT; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id ABBF5440B0C;
	Wed, 27 Aug 2025 14:37:41 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1756294661;
	bh=HrMzN83Z+OqzS/BaEKv4QwuDuv3LoZ3f5yvP91A9C9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=hnlMpctTeA8ywnMBVZg826JEeTSyCFtcqmOeYUoWGDQZOeLfdr4Qe37Q7RUy5hqib
	 KekD1mwEn8ifE1TNXBkRS/QUinu+W53ckbR46zyMcXlgN1lUIwzrBHAyO6Kb6XEKM5
	 jFECOK9errfBSa35WrVj68igZ0l2xW8LbEcpdm9WcsKBm85npWQdpGFbSXRUfRMFg9
	 URKeRkZLk9oTuH1il/vShXgFT0So0P5Ch7QEIKzbB2xjxZbMrGbGJqBD2eVJTCYUMx
	 5KrcaQRGjQyzv0aIDPtVQlBPfFCx8OB1BifGrmKwJ9IjzzTG16BII7EjRzycj6d5vF
	 lU3f2uyVJHv7A==
From: Baruch Siach <baruch@tkos.co.il>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] doc: filesystems: proc: remove stale information from intro
Date: Wed, 27 Aug 2025 14:37:27 +0300
Message-ID: <cb4987a16ed96ee86841aec921d914bd44249d0b.1756294647.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the information in the first paragraph of the
Introduction/Credits section is outdated.

Documentation update suggestions should go to documentation maintainers
listed in MAINTAINERS. Remove misleading contact information.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/filesystems/proc.rst | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2971551b7235..ede654478dff 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -61,19 +61,6 @@ Preface
 0.1 Introduction/Credits
 ------------------------
 
-This documentation is  part of a soon (or  so we hope) to be  released book on
-the SuSE  Linux distribution. As  there is  no complete documentation  for the
-/proc file system and we've used  many freely available sources to write these
-chapters, it  seems only fair  to give the work  back to the  Linux community.
-This work is  based on the 2.2.*  kernel version and the  upcoming 2.4.*. I'm
-afraid it's still far from complete, but we  hope it will be useful. As far as
-we know, it is the first 'all-in-one' document about the /proc file system. It
-is focused  on the Intel  x86 hardware,  so if you  are looking for  PPC, ARM,
-SPARC, AXP, etc., features, you probably  won't find what you are looking for.
-It also only covers IPv4 networking, not IPv6 nor other protocols - sorry. But
-additions and patches  are welcome and will  be added to this  document if you
-mail them to Bodo.
-
 We'd like  to  thank Alan Cox, Rik van Riel, and Alexey Kuznetsov and a lot of
 other people for help compiling this documentation. We'd also like to extend a
 special thank  you to Andi Kleen for documentation, which we relied on heavily
@@ -81,17 +68,9 @@ to create  this  document,  as well as the additional information he provided.
 Thanks to  everybody  else  who contributed source or docs to the Linux kernel
 and helped create a great piece of software... :)
 
-If you  have  any comments, corrections or additions, please don't hesitate to
-contact Bodo  Bauer  at  bb@ricochet.net.  We'll  be happy to add them to this
-document.
-
 The   latest   version    of   this   document   is    available   online   at
 https://www.kernel.org/doc/html/latest/filesystems/proc.html
 
-If  the above  direction does  not works  for you,  you could  try the  kernel
-mailing  list  at  linux-kernel@vger.kernel.org  and/or try  to  reach  me  at
-comandante@zaralinux.com.
-
 0.2 Legal Stuff
 ---------------
 
-- 
2.50.1


