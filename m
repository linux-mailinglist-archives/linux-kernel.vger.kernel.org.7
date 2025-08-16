Return-Path: <linux-kernel+bounces-771744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F002B28AF3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123092A1E37
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F120E005;
	Sat, 16 Aug 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="TK98vtq9"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426C2116E0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755325215; cv=none; b=pelhc0ufKmRS/4vnSBm0fC3nin2Y5AlHXPsU7HuB42tpjdgal5M1fBlnAdx7VzAIsTbqZSSdbQEaJAnLtfc39jocMoXDwovuk0f3Ezc3G9CAVBvd79tgj+7KXOImvzl2mhTAp4Kte8+08jK5DE85MbZ5r2Eyu8TfN4aCENt9HBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755325215; c=relaxed/simple;
	bh=ep6t0DaH2od4/w3ALMPkD/VxFwAE8feLc9aiVO9z3lA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BIE21Rb8hhegjl6OtIUvxlTZrfAojRBhH8M54APtnmZNgAmrgOafabt4AHSthvl4Lji64mXpY7v7QCILT2dnYPkYGgkBEwCv/6WV6hDp9ncR7TQ6c2bg6sUymeJtpit0UyQvnEW2cQ/JMIcIIu6QmAPKp0TZNpfurzMIQQnf4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=TK98vtq9; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 6AE5E104D019
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:50:04 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 6AE5E104D019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755325204; bh=ep6t0DaH2od4/w3ALMPkD/VxFwAE8feLc9aiVO9z3lA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TK98vtq9aYaIm3djSOOSkWn+jTozBfWzP7o99Y4qlBR1leHdGb90Blpj/dASOpTBF
	 CNArwO91H9mP60RjjGkGqeO77D/HMizLMUtkhlVMyHnqyIoq73+qxFmp6ozaS8XAKT
	 8wDubbST4uTSvMH79Lt9cZROPDtm64GVCjMBsBWw=
Received: (qmail 9851 invoked by uid 510); 16 Aug 2025 11:50:04 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 0.804583 secs; 16 Aug 2025 11:50:04 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 16 Aug 2025 11:50:03 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 0F907360035;
	Sat, 16 Aug 2025 11:50:03 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 2C9841E8130E;
	Sat, 16 Aug 2025 11:50:02 +0530 (IST)
Date: Sat, 16 Aug 2025 11:49:54 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: saeedm@nvidia.com, itayavr@nvidia.com, dave.jiang@intel.com,
	alison.schofield@intel.com, jgg@ziepe.ca,
	Jonathan.Cameron@huawei.com, Markus.Elfring@web.de
Cc: linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
Message-ID: <aKAjCoF9cT3VEbSE@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>

Use kvfree() to free memory allocated by kvzalloc() instead of kfree().
Avoid potential memory management issue considering kvzalloc() can
internally choose to use either kmalloc() or vmalloc() based on memory
request and current system memory state. Hence, use more appropriate
kvfree() which automatically determines correct free method to avoid
potential hard to debug memory issues.
Fix this issue discovered by running spatch static analysis tool using
coccinelle script - scripts/coccinelle/api/kfree_mismatch.cocci

Fixes: 52929c2142041 ("fwctl/mlx5: Support for communicating with mlx5 fw")
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
changes v1 -> v2:
- Update commit message with details on why this issue needs to be fixed
  as suggested by Alison <alison.schofield@intel.com>
- Update commit message with details on how this issue was discovered
  using coccinelle scripts as suggested by Markus <Markus.Elfring@web.de>
- Carry forward Reviewd-by tag from Dave Jiang <dave.jiang@intel.com>
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


