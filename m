Return-Path: <linux-kernel+bounces-747332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47228B132A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCFB1896734
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323473597C;
	Mon, 28 Jul 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="RPbTfdr5"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24E79CF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753661743; cv=none; b=cCKzRNcwmSLxytlRjQJ9ZFf1xekzmGrAnU3UPpgGiJ14m2ShoOcp4z+buQnQ4vbXSKH3Vzkzk97YdrXUWKSxWNV2keGWAtR8klMt7gYd0/3IIGy+3Rdtehe0yHGfbhPRLnMMLKw6uLqXQThAIzpmb/A5DXu9ITUhWRFHR8KtElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753661743; c=relaxed/simple;
	bh=5k8JYmHT2cWOWtGfELADGc92fbkTdz1tEljYzoDyHO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jXYJbYsaFHbDxJLYspiJhFHm8e4e8HtmxvIs+R85qvJPXihY+7ANBOJB070g24/wYC6ELWMZZiFIwv9O3ggUUz4feQTRAwzI0g+ALomSkcOuAb90ndMFMs0qyD0m4ImCh/FcBsTqQaCxHty/VryLuj9A9HGgeYOuJ7sev4jiVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=RPbTfdr5; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 5EE52104C1CB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:45:28 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 5EE52104C1CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753661728; bh=5k8JYmHT2cWOWtGfELADGc92fbkTdz1tEljYzoDyHO0=;
	h=Date:From:To:Cc:Subject:From;
	b=RPbTfdr5ubQ/Ie0C5V9yg/krhtrN1zu2JngvovCUqM54zyAyv3uxoXkeQAfDD6hsX
	 09w6G31zxeqAlxBucisd1MD8NCzSJyyC1b7PYQu0CgeO74OvG/AiTgiwa5sz0BVfPR
	 fNfwKQ8TweWe07lsfBrtC0uOjEttlJoM17jhtWTU=
Received: (qmail 23478 invoked by uid 510); 28 Jul 2025 05:45:28 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.875186 secs; 28 Jul 2025 05:45:28 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 28 Jul 2025 05:45:24 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id D4A563414DD;
	Mon, 28 Jul 2025 05:45:23 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id AA8EA1E8128E;
	Mon, 28 Jul 2025 05:45:23 +0530 (IST)
Date: Mon, 28 Jul 2025 05:45:17 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] gpu: host1x: use dev_err_probe() in probe path
Message-ID: <aIbBFQqgZalOMc6r@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use dev_err_probe() helper as recommended by core driver model in
drivers/base/core.c to handle deferred probe error. Improve code
consistency and debuggability using standard helper.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/gpu/host1x/dev.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 1f93e5e276c0..e6f3cbeb9ae5 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -587,11 +587,7 @@ static int host1x_probe(struct platform_device *pdev)
 	host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		err = PTR_ERR(host->clk);
-
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get clock: %d\n", err);
-
-		return err;
+		return dev_err_probe(&pdev->dev, err, "failed to get clock: %d\n", err);
 	}
 
 	err = host1x_get_resets(host);
-- 
2.34.1


