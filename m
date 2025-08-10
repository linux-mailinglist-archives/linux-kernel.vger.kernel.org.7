Return-Path: <linux-kernel+bounces-761547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5CCB1FBA3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 20:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB3B7A619C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577391E8324;
	Sun, 10 Aug 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="IBUIA3yp"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BF1B0413
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754849878; cv=none; b=uMuaD4ni/wnqWzhlQQsVtupeCzOSF82Y8Eiu6oQP8R1rUfu95F7U/inTIg7xlY/94edXsZN0iiG4Rs71lWGSyv6KGC5eirZVml6/sseDraTT2Bo3y7wHGjkTfv7sgjCUBQhbCF5n9mSdVtrEK5e/aI2oPJN+crviK3RGHc0aZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754849878; c=relaxed/simple;
	bh=jSLQ2MMep3BO3PDTDq4ar1dCyTTYIEy7Eb9UEN77+7U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nvuRzSyNLnSy/dllvh0b9gfnnbt85vUfRjZSrH2aya2J2xt3A8nlDVvFgv8Ad0nxl4SlJnHwNanc77uMR/8HqCsh1bOfASkgwiDX0/SAMr6Jy8zmJdHlosTxqcsfWFf7YMRJIejLEik7l4OBGHfK2CP4+/w3ayNq7NGrGjzQ4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=IBUIA3yp; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 71C05104CFE1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:47:50 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 71C05104CFE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754849870; bh=jSLQ2MMep3BO3PDTDq4ar1dCyTTYIEy7Eb9UEN77+7U=;
	h=Date:From:To:Cc:Subject:From;
	b=IBUIA3ypS+Lq7Lw4YNVlKIH13FyUBKEsBpamwIYwG1zojkKQ7RJgk9ElC4s19vgIE
	 rrKMs30NiCU4OTOEore/kvEyTo2voBxmBAv3pUW3B686RFyTVpyJkfFYrfd5pY5z6B
	 42aCMpJYZMh6TT5fU2Ft3ViLEOk60GtNHS62sVDg=
Received: (qmail 29123 invoked by uid 510); 10 Aug 2025 23:47:50 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.114037 secs; 10 Aug 2025 23:47:50 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 10 Aug 2025 23:47:48 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id CA65B360082;
	Sun, 10 Aug 2025 23:47:47 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id A29AD1E812F4;
	Sun, 10 Aug 2025 23:47:47 +0530 (IST)
Date: Sun, 10 Aug 2025 23:47:42 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: saeedm@nvidia.com, itayavr@nvidia.com, dave.jiang@intel.com,
	jgg@ziepe.ca, Jonathan.Cameron@huawei.com
Cc: linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
Message-ID: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use kvfree() to free memory allocated by kvzalloc() instead of kfree().
Avoid potential memory management issue by matching alloc/free routines.

Fixes: 52929c2142041 ("fwctl/mlx5: Support for communicating with mlx5 fw")
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/fwctl/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
index f93aa0cecdb9..4b379f695eb7 100644
--- a/drivers/fwctl/mlx5/main.c
+++ b/drivers/fwctl/mlx5/main.c
@@ -345,7 +345,7 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 	 */
 	if (ret && ret != -EREMOTEIO) {
 		if (rpc_out != rpc_in)
-			kfree(rpc_out);
+			kvfree(rpc_out);
 		return ERR_PTR(ret);
 	}
 	return rpc_out;
-- 
2.34.1


