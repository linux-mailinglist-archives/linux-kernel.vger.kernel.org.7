Return-Path: <linux-kernel+bounces-761326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A72B1F87F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BF63BA611
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDFD1F428C;
	Sun, 10 Aug 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VZyFXx3z"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA921F03D9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805129; cv=none; b=iZtjiOI3yXS5fG5/EMOGT4hm88WCecRVSjX71dd1qnzvlNRTlL1YVQwvpKxm5wyoRqwancWROKXW341kOjpAW3zFNLg65bw9RbaEL/vg0s1tm60jAXPFD84Wtv3iOBwKr9mT5dXT0pRvWzONIxMxrUPopRLN/UIIrPUozRsgqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805129; c=relaxed/simple;
	bh=HNlGnvWAxM2Og4DUSHdcRBrH52bcCWnzTMtrsD7J1Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XAjyMHjW1uLeI7w3exN+m0cmi2Y3fU0Upa26Mk8XAmnEQQV3oAkQn3tzfyoqPdcUcflhRwL6B0/4zb9Cwh9R+m5B8T2htWbqIbkNQ00dcNnF2YFtYbJfSqmpoWXMfxBrjMwKj2yBhsA5QZ0GVusEnXdj5sMAI+NAkVb5qxEh9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VZyFXx3z; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghp4aqIfWYjIth+RE2bWuQf8QfvJiCJcNtaoJe6JOCE=;
	b=VZyFXx3zupTOWZFhm7f7Ztw0M3GBICeCgkaCEf2FXpxoLcV3795eT3GMj7pB4aIDmOdJ59
	POsAg7j+kuFi7Z5z+lnEhkKzT9mrKtPCIbFc4brf8+rAOYEIVfJRvUPs9DnR2YqbamZAKk
	eJdceAQWUaEtLCN3tQNzGv2ysJNVtjg=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 02/10] um: Remove unused cpu_data and current_cpu_data macros
Date: Sun, 10 Aug 2025 13:51:28 +0800
Message-Id: <20250810055136.897712-3-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

These two macros have no users. Remove them.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 8a789c17acd8..236fdfd7cdbe 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -81,8 +81,6 @@ struct cpuinfo_um {
 
 extern struct cpuinfo_um boot_cpu_data;
 
-#define cpu_data(cpu)    boot_cpu_data
-#define current_cpu_data boot_cpu_data
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
-- 
2.34.1


