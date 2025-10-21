Return-Path: <linux-kernel+bounces-862973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE5ABF6AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0677D4FFE70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F413E336ECD;
	Tue, 21 Oct 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b="YsYpiveu"
Received: from MTA-10-3.privateemail.com (mta-10-3.privateemail.com [198.54.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB040336EE1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052222; cv=none; b=IoyKU7E3KqgHGn2dTJQc6nMKDn5rM53vWl6HRGZMCcqyzMY9xNhdL/ZNeEr0XbRa6JBD+VoneFDkF7Vtjfn4oOFUg07Zn/YeciPwGB49nhTSAL8MytiNzhXeMCrjbOLNuxm450y/EC79Bg3fV995f/2xWgSvok1imWIEnqnBFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052222; c=relaxed/simple;
	bh=0VbGGm8QuRymx9t8Ko40ckdaZaN3jnugWP1LiWeKIgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJPBC7etyhfiLnZn74lUk/bhOP4d8RP+vQUIv598SlZRLJqgA15mpEhliftg8TZPvCU5ZD16d9gUUEk+tMNf8a9Gx3fAGk0C4UWRhlpaoCsNK2lXyKSpnvN4i8VS7pcsgGKIoM5D5DRZvX9yl4iPTtT1bYk25A7lBPIE4xlkb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev; spf=pass smtp.mailfrom=lukowski.dev; dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b=YsYpiveu; arc=none smtp.client-ip=198.54.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukowski.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lukowski.dev;
	s=default; t=1761052219;
	bh=0VbGGm8QuRymx9t8Ko40ckdaZaN3jnugWP1LiWeKIgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YsYpiveu3TLD14TqakeAEKL2jsZ8tmhq+YTGHfwwPzQYPaoAgsDKAfG0OwS/R78QG
	 lV5Nk1wERZb4Zy1vycgndlgUvgRAzNIc61N3wWgYokXnDBjwcrOrHVTxWIsreJ/RF/
	 EjB3fAYPbHR/CUg57KFb+4pJNNf5pJZj+edajUATpWgYKQkFQdwNIvVBoAdjJ6+rBa
	 1/ezSFbHySRe00dfqHr7GZ/r5CPAMHy3gf4cPWUcVfWGJ2O1Doexqyvvpmx48V2vZW
	 3+ejbBy8yPHqGkwNitwpY77HXyHZdq7+VtSgcdk1rjD+BpsJdKm/VN//c8iCpPv63B
	 h25/jbUUwR6dA==
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
	by mta-10.privateemail.com (Postfix) with ESMTP id 4crXhq5fkSz3hhV9;
	Tue, 21 Oct 2025 09:10:19 -0400 (EDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [150.228.61.72])
	by mta-10.privateemail.com (Postfix) with ESMTPA;
	Tue, 21 Oct 2025 09:10:11 -0400 (EDT)
From: Olle Lukowski <olle@lukowski.dev>
Date: Tue, 21 Oct 2025 16:09:30 +0300
Subject: [PATCH v2 3/3] staging: most: video: replace BUG_ON() with proper
 check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-staging-most-warn-v2-3-cd51e1e717f6@lukowski.dev>
References: <20251021-staging-most-warn-v2-0-cd51e1e717f6@lukowski.dev>
In-Reply-To: <20251021-staging-most-warn-v2-0-cd51e1e717f6@lukowski.dev>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Christian Gromm <christian.gromm@microchip.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Olle Lukowski <olle@lukowski.dev>
X-Mailer: b4 0.14.3
X-Virus-Scanned: ClamAV using ClamSMTP

Replace a BUG_ON() call with a proper check to prevent an unnecessary
kernel panic.

Signed-off-by: Olle Lukowski <olle@lukowski.dev>
---
 drivers/staging/most/video/video.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 32f71d9a9..3a7ee2791 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -575,7 +575,8 @@ static void __exit comp_exit(void)
 
 	most_deregister_configfs_subsys(&comp);
 	most_deregister_component(&comp);
-	BUG_ON(!list_empty(&video_devices));
+	if (!list_empty(&video_devices))
+		pr_err("video_devices list not empty during exit\n");
 }
 
 module_init(comp_init);

-- 
2.51.1


