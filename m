Return-Path: <linux-kernel+bounces-786825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBAFB36BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D68A05E07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE0835CEB6;
	Tue, 26 Aug 2025 14:37:03 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582235CEAC;
	Tue, 26 Aug 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219023; cv=none; b=lVYv6YUafyHtikTku9WNf2cO6d2RVIY2W63cfZwqkjOzop7tjkilffvxRLikcCPgC2hgvfniTzeWMVCTaaAMDa6WT9Uf2EXR4oxtfCe4UW3/FmDlvtNrMGZXkTzVotlXYApSqHIjFJaU3pjCAkI46BvCQq1rp3aZ5HdiPbae3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219023; c=relaxed/simple;
	bh=W4Hpc79q+QcXmzMws1jD7BCm2B50joywsBVlH/fMtqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJCB5+KrfqDflK/iPGopQE0Z6ZydhFbnxNX7g071hjx8cSOENYROHOwHxcPcfHAaNSH3EO6uhKuwO5KgV3m+nxDEZyU2WpMC7BwAhjUfBxKmF5fAIWIbVlNP3EbHfCjN3GA9BJ2tfm56tZjtD8cNTuSn5puvO8NTtEqJk/gSVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cB99K039mzPqkS;
	Tue, 26 Aug 2025 22:32:21 +0800 (CST)
Received: from kwepemf500005.china.huawei.com (unknown [7.202.181.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A8E41400D1;
	Tue, 26 Aug 2025 22:36:57 +0800 (CST)
Received: from huawei.com (10.67.174.161) by kwepemf500005.china.huawei.com
 (7.202.181.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 22:36:56 +0800
From: Cheng Yu <serein.chengyu@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <gregkh@kernel.org>,
	<linux-cve-announce@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<serein.chengyu@huawei.com>, <huangjiale13@h-partners.com>
Subject: [Question] fix CVE-2022-49980 introduces deadlock in linux-5.10.y
Date: Tue, 26 Aug 2025 22:24:18 +0800
Message-ID: <20250826142418.961703-1-serein.chengyu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025061820-CVE-2022-49980-982c@gregkh>
References: <2025061820-CVE-2022-49980-982c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf500005.china.huawei.com (7.202.181.243)

Hello,
I noticed that the community has assigned CVE-2022-49980.
I found that the issue described by this CVE also exists
in the linux-5.10.y. Therefore, I attempted to backport
the fix patch to the linux-5.10.y, but encountered a
potential deadlock after applying the patch.
The specific call path is as follows:
   usb_add_gadget              [(1) mutex_lock(&udc_lock]
     -> device_add
       -> kobject_uevent
         -> uevent_ops->uevent
           -> dev->class->dev_uevent
             -> usb_udc_uevent [(2) mutex_lock(&udc_lock)]
This results in repeated acquisition of udc_lock, causing
a deadlock.
Does the community have any suggestions on how to resolve
this new deadlock issue introduced by the CVE fix?

Best regards,
--
Cheng Yu

