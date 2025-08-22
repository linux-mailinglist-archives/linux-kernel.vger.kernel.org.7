Return-Path: <linux-kernel+bounces-782298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF5B31E91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1E617DB3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452B2EAB6B;
	Fri, 22 Aug 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="iSkjLGhH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M+qjKGPw"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83FC22688C;
	Fri, 22 Aug 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876361; cv=none; b=haKXkgh/snBvTtvobyQWpqrQZSdmEyzXJm1c7Oz9rmV0FwxT9+LWrqHF2U8De/6lzCHWJu0Xx7J50kUhwSgnezc1rOJnb5bFmXziOuP3gorFKg364lLy1sYWHr6F9+JvVWd5h4xeBKe/g7etHjR3vo/z4zJXT+UBau0vQ5XeOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876361; c=relaxed/simple;
	bh=2kjB9karetnc9oVHnHaEJpAOUPGW95dn+4XCESIApwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXFG01hkhm6+LAtWXtkrOEMWnsGn38QzcMPwTNodRdC7OLQ5Y9SgeM/eq5e8eFwIrurecwaQhayOlxO3VM3nmFjBGPmrYYoc5bZCsfUK/fotMeA2YaGWlQug0dNZEZ931gPF7Z2qhJV5K2jG+hsq3iX7JPGCka3mL1bWJvchV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=iSkjLGhH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M+qjKGPw; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B57741D000A8;
	Fri, 22 Aug 2025 11:25:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 22 Aug 2025 11:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755876358; x=
	1755962758; bh=gqIE8uOlilaW5wWCZ7qTDFR0FqZ79zeGzHb0doGbTFw=; b=i
	SkjLGhHifOsWyzqbseHZOI8IHl1IDMhXxTuitjCDURrWc2kAPQ5fpBE07dOZv8wo
	0tWX7CNkWSxbLOwQLTkbB4Ga45f9vW+St1dAefxZPkJF0SxxqSjsFQY3gmt9AUZz
	0MV+sS16yCH/VtbMcifBqkC0i+OsSHFzy7yyBPokfGOUcfZhsHdR6T0NYCHDuesl
	L4rFy86GgjLvD2NsF7NMtxy0x+/p8hW+UgRABuqyAS6GnQnIeqD7Ped7NxITefwC
	Y4OH8m85kCbc4uRSuiJ2cYZI//A2TByDHxzDngEsiazAiQzh3PUMBIw8IGt7pDvw
	vVQlpkC5rSnkzzzCIp1EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755876358; x=1755962758; bh=g
	qIE8uOlilaW5wWCZ7qTDFR0FqZ79zeGzHb0doGbTFw=; b=M+qjKGPw3j2Iplw/R
	ASeBUa4m+LCyWZQIn0gPEcp4QlZ8oA/DKFA3T/wasrlcwES9MmGA5jLpFbrWVlgX
	B7T5IOeeugzY8GVpTYpIigIdHwAUT0XhFtk569wqPP6fSJx11Fl2aEK/0/6g0dvS
	GxjoqQBR1yBqLYNy1xx3X17CEy/Z42uVsMxHXdRPf1USfAwJZ21fcp8SaBiW03Nw
	aBiiUkvGklcZw0cqUxWjXcsAzJSV/23PmOXMrLy0OCw0Z9w2MRjW0hd0V7Be5L1Q
	oqBbj3DOzPT2L90TOWvZ4gszCoF7LSkrtXZGJC3cGgVWX+Mz2Dm0+2dV3ayeCpWC
	kZM/Q==
X-ME-Sender: <xms:BoyoaFyZDrXRYLz-UWnnX6nbJrG-O2yJH_tysYtXCxeNZCH_QRXWEA>
    <xme:BoyoaMpq2GuhZZvoZmoxaEe1dLA76-lkk9UD0AICNYfP70NiGvHzO7MlIiJZy7LKl
    ohRDu2TtvtxhWKcjXQ>
X-ME-Received: <xmr:BoyoaE74HPhL5phI5_FIc1Z9NIMQwqfKQui5F9YhsB2GAQ50PI2nPoBNXY4HN9wP6iGyFlofoARUwgas62nSod95Ok0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhsohhn
    uceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrth
    htvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueethefg
    vdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    hpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnoh
    hvohesshhquhgvsggsrdgtrgdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehl
    ihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrghntddtgeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:BoyoaDeplyLWQ4e90pTHMVb8djWdPc15RJLhiIC0aD1-VK1NS0jDKQ>
    <xmx:BoyoaJ7k_TuQekTbgegj5U6kogtxvfItdU6ca2szEQ2XUNn1DLcPVg>
    <xmx:BoyoaKsf3bMVucCGS390ocd_xPGAGjH4xI5aTZkCe0DEc810CDIp5A>
    <xmx:BoyoaJh9iw2EylujCyDzCVOWOpwv_LH4bc7rU3eFzzd5G_7_pRb_CA>
    <xmx:BoyoaAKmNw5vwcaYI1CcS24lohHcbYNqkIBiybTa7Rq9YdOyGK6PptXh>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 11:25:57 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86: think-lmi: Add extra TC BIOS error messages
Date: Fri, 22 Aug 2025 11:25:43 -0400
Message-ID: <20250822152549.4077684-3-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra error messages that are used by ThinkCenter platforms.

Signed-off-by: Kean Ren <kean0048@gmail.com>
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/lenovo/think-lmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index f7843f3a3325..7c20d522e243 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -218,10 +218,21 @@ static struct tlmi_cert_guids *cert_guid = &thinkpad_cert_guid;
 
 static const struct tlmi_err_codes tlmi_errs[] = {
 	{"Success", 0},
+	{"Set Certificate operation was successful.", 0},
 	{"Not Supported", -EOPNOTSUPP},
 	{"Invalid Parameter", -EINVAL},
 	{"Access Denied", -EACCES},
 	{"System Busy", -EBUSY},
+	{"Set Certificate operation failed with status:Invalid Parameter.", -EINVAL},
+	{"Set Certificate operation failed with status:Invalid certificate type.", -EINVAL},
+	{"Set Certificate operation failed with status:Invalid password format.", -EINVAL},
+	{"Set Certificate operation failed with status:Password retry count exceeded.", -EACCES},
+	{"Set Certificate operation failed with status:Password Invalid.", -EACCES},
+	{"Set Certificate operation failed with status:Operation aborted.", -EBUSY},
+	{"Set Certificate operation failed with status:No free slots to write.", -ENOSPC},
+	{"Set Certificate operation failed with status:Certificate not found.", -EEXIST},
+	{"Set Certificate operation failed with status:Internal error.", -EFAULT},
+	{"Set Certificate operation failed with status:Certificate too large.", -EFBIG},
 };
 
 static const char * const encoding_options[] = {
-- 
2.43.0


