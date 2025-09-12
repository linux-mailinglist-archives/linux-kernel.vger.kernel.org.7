Return-Path: <linux-kernel+bounces-813682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F583B54952
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A5E1CC3777
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA152EBB90;
	Fri, 12 Sep 2025 10:15:10 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0827EC7C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672109; cv=none; b=MlKh4pb9QM3ObjK2/Ye5Cj1u19CG2K0i0H5BFx52lWGWKgzSZ0tcc7U74xTqiLqY4De66G9XZPoXYffgwRjgtr68PMrxZjivEUblHSuRUnlrDsQhjHVs8T+QkQsEc4yVv4UM2puwUwwSsFkZwgikBGDzTaLLQ+KRsMGQzmYzsCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672109; c=relaxed/simple;
	bh=Wqc4PSuQxVxondoZXB1b6xHH5GpS8US7xvzX3T6eTjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WvwKXx1cMsb3aPu9rtXlD3j2ZCNodMZIU3Tbyw2xazejhvR2TEwaEB7jCHDmRLRUwJLuWv9Lo+C6oZb1fCDwlp6FrLamXtFSRS0XvK/KWkq+Bs48SALiSwCiwGwX2bGMCmoUxAmKdJolFiW4al2HskSUYPEr46QaUNtIf1wVHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202509121814533872;
        Fri, 12 Sep 2025 18:14:53 +0800
Received: from locahost.localdomain.com (10.94.9.215) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Fri, 12 Sep 2025 18:14:54 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<naveenkrishna.chatradhi@amd.com>, <akshay.gupta@amd.com>
CC: <linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] misc: amd-sbi: Add NULL check in create_misc_rmi_device
Date: Fri, 12 Sep 2025 18:14:51 +0800
Message-ID: <20250912101451.1928-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20259121814536597104dcdccf3c6ad174a6980de98bc
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Add check for the return value of devm_kmemdup() to prevent
potential null pointer dereference.

Fixes: 35ac2034db72 ("misc: amd-sbi: Add support for AMD_SBI IOCTL")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/misc/amd-sbi/rmi-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 3dec2fc00124..50b8e9e02833 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -471,6 +471,9 @@ int create_misc_rmi_device(struct sbrmi_data *data,
 							 GFP_KERNEL,
 							 "sbrmi-%x",
 							 data->dev_static_addr);
+	if (!data->sbrmi_misc_dev.name)
+		return -ENOMEM;
+
 	data->sbrmi_misc_dev.minor	= MISC_DYNAMIC_MINOR;
 	data->sbrmi_misc_dev.fops	= &sbrmi_fops;
 	data->sbrmi_misc_dev.parent	= dev;
@@ -478,6 +481,9 @@ int create_misc_rmi_device(struct sbrmi_data *data,
 							 GFP_KERNEL,
 							 "sbrmi-%x",
 							 data->dev_static_addr);
+	if (!data->sbrmi_misc_dev.nodename)
+		return -ENOMEM;
+
 	data->sbrmi_misc_dev.mode	= 0600;
 
 	return misc_register(&data->sbrmi_misc_dev);
-- 
2.43.0


