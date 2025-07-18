Return-Path: <linux-kernel+bounces-737094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B682CB0A797
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B263188801B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B962DECB2;
	Fri, 18 Jul 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="lev25uV9"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D522DECC0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852633; cv=none; b=o24UaowLMC9KkA1bbFUccndJyySQDyws1HZLZELAaIQQp6jQ04yjqK9dZU6CyI/WtfPK+X89RVqaN41FZfU0dsfuVBeX5dW5RFsWdVnjx4QReKxrrH1rStyvymhQz+L7MaZXC+VLi2PYniBPjIjmhyU8MsbcML4Br6JPeapqz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852633; c=relaxed/simple;
	bh=f3LSdoYYmURS1rjz0097H7ejp033uVg7byHFkNuPVVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ldgGzCAm2exGu+edVxA+eF0hVM9UzVNxaHybTJN5eMtVdtzTOZgxpJfOkigVEiqi+/5Qy+NguMfGuPbtyMtV8rxv+NZkzAWW7BojKSpJDaUs4vjPdpVuLeGkIKEFTcVn3R9CoUQ59NpPFa86K7td/AR7AOdZmlQHEZzC4zVFUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=lev25uV9; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id F2A63101193C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:00:23 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in F2A63101193C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1752852623; bh=f3LSdoYYmURS1rjz0097H7ejp033uVg7byHFkNuPVVE=;
	h=Date:From:To:Cc:Subject:From;
	b=lev25uV9L6S8T9uZxe+yu2+fKUbS2pCyuZfta79tZWvM3/B4GvdekxUth7VnAvNWr
	 aMIAw/s3/QoWvXFMbkk+EUPzxeztrG8NF2+Izz06vCRTDoBe7GBY8eOufwx2hTtAsJ
	 EsVzUpmG3bAuaScxO8wjZBMiB1Zt6z72WMGMDWVc=
Received: (qmail 13141 invoked by uid 510); 18 Jul 2025 21:00:23 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.023033 secs; 18 Jul 2025 21:00:23 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 18 Jul 2025 21:00:19 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 84B093414EF;
	Fri, 18 Jul 2025 21:00:19 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 5DFEA1E814D3;
	Fri, 18 Jul 2025 21:00:19 +0530 (IST)
Date: Fri, 18 Jul 2025 21:00:13 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jens.wiklander@linaro.org, sumit.garg@kernel.org
Cc: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] drivers: tee: improve sysfs interface by using sysfs_emit()
Message-ID: <aHpohUxxSH42w16U@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace scnprintf() with sysfs_emit() while formatting buffer that is
passed to userspace as per the recommendation in
Documentation/filesystems/sysfs.rst. sysfs _show() callbacks should use
sysfs_emit() or sysfs_emit_at() while returning values to the userspace.
This change does not impact functionality, but aligns with sysfs
interface usage guidelines for the tee driver.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/tee/optee/core.c | 2 +-
 drivers/tee/tee_core.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index c75fddc83576..ce44e3498d37 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -72,7 +72,7 @@ static ssize_t rpmb_routing_model_show(struct device *dev,
 	else
 		s = "user";
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", s);
+	return sysfs_emit(buf, "%s\n", s);
 }
 static DEVICE_ATTR_RO(rpmb_routing_model);
 
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index acc7998758ad..944f913f8592 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -977,7 +977,7 @@ static ssize_t implementation_id_show(struct device *dev,
 	struct tee_ioctl_version_data vers;
 
 	teedev->desc->ops->get_version(teedev, &vers);
-	return scnprintf(buf, PAGE_SIZE, "%d\n", vers.impl_id);
+	return sysfs_emit(buf, "%d\n", vers.impl_id);
 }
 static DEVICE_ATTR_RO(implementation_id);
 
-- 
2.34.1


