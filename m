Return-Path: <linux-kernel+bounces-851747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAD1BD72BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262B21882D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602FE3054D1;
	Tue, 14 Oct 2025 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I3Po+sVg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EED2741B3;
	Tue, 14 Oct 2025 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411751; cv=none; b=kHazVIzWV0FPVNFPvtjD2f3nWhT5FnQUK3cJRXE+X8OSo3ZSzvmH1HVkDvRPANAtm7VgmKVAA0xiRY9FDzkGsbtpe+BrTcaPRNc0mDXil0eKqrEY3ZwsHTIIST6ZtQ/JCKOKEpBkyfhTfrjIOCQOzhQ/HvLqMCkpO45tTbCa8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411751; c=relaxed/simple;
	bh=+lu/+ryfyqNM2uNpW8HwduSNbUWej4L6WRGx0+JZok0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQ/QQTvvfw0Y0JN/Bx8nPWMGbvv7ICPkLSHrLOYqNnL3/5cwsf//tMwx7S5e5UL3P3a5KnxRFo84Xv3leI1FSAfit4ukOrMHDk87KBQqPfcSkGnQqOK7ylmT+IMKLRT7i4T16jGXpsF698EXBBJvtaWBDY+ZmofBhYiYBmKAbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I3Po+sVg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8+bnBOb9M0GpNFUoDeyBksEKjR/Lyjhscf8s2ah6p04=; b=I3Po+sVgXBS6E++00kTh4uWcs5
	T07/7AnYKeU9QKH/xhP7Pk2FQwRkXLRkO+c/WwEOvVxgk3eNkVi3fhCAROyqZ31Z/Y7pZHo9vfGim
	LJyfoY7G5Keb4lD1CaWvTjUpXMZpmhakWHR8uJg7G1dLXHYUSPN+qyFXSrmDnolNdha2iifmLLYiF
	hBlDjWaHRCx9r0TvSre2iXKAEWtxmO8KnuY49xyP311nUgVJ4YgGe4+6PtuHxEMAwsP4R3/A/9vlY
	Dnk6g+UmIN/l1NkHKpNEaynhrYeoTN2A392pxtZiI4bsYqG8FaOm3j4ubAhwTjvUuR60+OThOaC93
	YkA2LIsA==;
Received: from [50.53.43.113] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8VVl-00000001dVD-2d2w;
	Tue, 14 Oct 2025 03:15:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: admin-guide: update tiny script for number of taint flags
Date: Mon, 13 Oct 2025 20:15:38 -0700
Message-ID: <20251014031538.764059-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Account for 2 new taint flags being added by increasing the number of
bits handled by the tiny show-tainted-flags example script.

Fixes: 8eea4e744758 ("taint: Add TAINT_FWCTL")
Fixes: 2852ca7fba9f ("panic: Taint kernel if tests are run")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Gow <davidgow@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/tainted-kernels.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20251013.orig/Documentation/admin-guide/tainted-kernels.rst
+++ linux-next-20251013/Documentation/admin-guide/tainted-kernels.rst
@@ -74,7 +74,7 @@ a particular type of taint. It's best to
 script, but if you need something quick you can use this shell command to check
 which bits are set::
 
-	$ for i in $(seq 18); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
+	$ for i in $(seq 20); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
 
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

