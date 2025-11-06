Return-Path: <linux-kernel+bounces-889413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DA3C3D805
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5158188BEC5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCF1307491;
	Thu,  6 Nov 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtAbrImh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD6306B15
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464563; cv=none; b=aRI9Pwzx9VTsu+tDCaERpHcdwrkkWVlWLL8AdxfI47M5W3sg2BclsOUMUkn02ZSN37oYVskuI3n6RsPWhlrm5+kWacxvuBhmYFZjn8X3LIf9jU8RsiRa51lKCyDAgn4R6ol6/ybttm4DfU5YWbJxf8pxeMQi0MNK9SC+kHNEh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464563; c=relaxed/simple;
	bh=/GBxVAq5xmr+3KXl3Ok17RMalYATBJK95ryBBuy5VaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRYFmmll/Ap7/AVNh6LGRDekEKWjh/E+I8b5W0HDmp+FTNVR+do7xv5NVqcSJrKSMVimezsn02vnGxZx4pUye068VUbK55lpoCdYpBwV+ZM52gTHvs9vUYxkwI8YQUiKkRdkO3ssgKMHHZBTqazrIEicMb9/GEXL+haAPSqVw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtAbrImh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+gqNXzwQrUwJSMxzoqSc1CwBu2yw1frjOj1IBpGl38=;
	b=HtAbrImh01omTfEt8zRF6b6U1FqxEx6bPFWX/a+4IowFeyTae/8+pOEYk16ioRqNvZ5vHt
	t7Cmogvp3vMRl7HRvyhZC4/Fht7d2GP4SFe6ABkuAQ6jWWwdZEaII1ddbWDl8YHxFqswLG
	l2aO6TuNNMPat47SufH+2LyUW7p8F3M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-k61oNvIsPW2_VCtk-ZibCA-1; Thu,
 06 Nov 2025 16:29:18 -0500
X-MC-Unique: k61oNvIsPW2_VCtk-ZibCA-1
X-Mimecast-MFC-AGG-ID: k61oNvIsPW2_VCtk-ZibCA_1762464557
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C3C719560A1;
	Thu,  6 Nov 2025 21:29:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05AF419560BA;
	Thu,  6 Nov 2025 21:29:14 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Subject: [RFC 01/10] docs: tmpfs: remove implementation detail reference
Date: Thu,  6 Nov 2025 16:28:48 -0500
Message-ID: <707886a5ce4afa4c54456ab2ad8dfe5ba0d86086.1762464515.git.luizcap@redhat.com>
In-Reply-To: <cover.1762464515.git.luizcap@redhat.com>
References: <cover.1762464515.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The tmpfs.rst doc references the has_transparent_hugepage() helper, which
is an implementation detail in the kernel and not relevant for users
wishing to properly configure THP support for tmpfs. Remove it.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 Documentation/filesystems/tmpfs.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index d677e0428c3f..46fc986c3388 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -109,9 +109,8 @@ noswap  Disables swap. Remounts must respect the original settings.
 ======  ===========================================================
 
 tmpfs also supports Transparent Huge Pages which requires a kernel
-configured with CONFIG_TRANSPARENT_HUGEPAGE and with huge supported for
-your system (has_transparent_hugepage(), which is architecture specific).
-The mount options for this are:
+configured with CONFIG_TRANSPARENT_HUGEPAGE and with huge pages
+supported for your system. The mount options for this are:
 
 ================ ==============================================================
 huge=never       Do not allocate huge pages.  This is the default.
-- 
2.51.1


