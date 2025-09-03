Return-Path: <linux-kernel+bounces-799182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050EB42818
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D893581C34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D743322C78;
	Wed,  3 Sep 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Doh+p8Wb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dns2EKHl"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D9320CCC;
	Wed,  3 Sep 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921113; cv=none; b=LX3ZsCa2v37TrhKH0MVSsZyI06dPqqtwP3up5k33YkJ4Va4hP9dM/vzHH0S7gImQP5/Kh8n0UcudRvbB/t54sn+x3HDGxl8+q7rnDnngnxP1OGRCmpSaH/VhurfPPuLmllqKiIRvD72ZY5BcS+XM6QmLeCtDLhbkDSa0UOIM+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921113; c=relaxed/simple;
	bh=CJIszMBWvbxHJQiGv4kbis1ILLhdG/+p+Uka8iZrT2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqYJ/k3H+yhhkk/5yYKzZDiWKeZ5QKAoIRgu1rbn0Jj4QNYCwv5ar6aWx3M1VsCRML7QWUewnpGHU/tm6VzSbwqqtmp0sD/8eut2Odx7kcgM3ZnpcJZhew6Z1PD6qc6gk08WForFOt32KyewYXjAgXyDN3Nac9KHiEErR1Ohwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Doh+p8Wb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dns2EKHl; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E9E601D005BF;
	Wed,  3 Sep 2025 13:38:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 13:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756921110; x=
	1757007510; bh=AYha583EgDlRiD4f7ecC81OwJdm0eeCnppqyvyQv1Aw=; b=D
	oh+p8WbSNNXCtJR+DJpT8KKyJxxlu71O9lHW6njlVzCYUCvWlZngYpC+4BHejOYt
	qRm1ur7zRiOUBlTf8a4Iv61jWJY+i9mY1sZvN10XUdtYymet24ha9YpD9xoVbFar
	cRGrDiwOCFRXoOBUkfy+O09iJmjVzwsQ7H+7aNDgE73wnDZxqzMZZvC96of2YfVW
	WP4ZlpTkmLXrp8/U1uCncCqgG8C7PRw/EjxGb0lXO+qQDu/Wt30nLV6HvTXl+rks
	hkBBQlFa2mLRSvZs/XCdMMVlMa2BzAKx3Jm4mrGT7nv/3OQDpBopi8B8jY9mKfoI
	MzXVmAOiSNfjz7W/h7yYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756921110; x=1757007510; bh=A
	Yha583EgDlRiD4f7ecC81OwJdm0eeCnppqyvyQv1Aw=; b=dns2EKHlYj9brO3Mo
	/a2Trf9wMRa3dZLVCVQFDeTjTH2zs3wZg/qX4zMu0Nmg+XK7DnGzB3yix2giA7WT
	jP6aWVKD2Ynz+brxRTHpHq3cscng49N0TWrqRHGXcZ3OMYopUPNX/dtujRN9RDm2
	UMrUD2AYvpveOV1D+1WBuQsc3ms4uQ6KI42AlHnnY7gpxwHIfz/IPHXUDwTQ2XXf
	KF8MRf9NkJowKPyz10Y2USMuuokxUzPy0utZEE+oaJy2+fzxwijTPl/StqbBu82+
	FN9blZvk+rWsejqZv08l42sCwBRBnAcSmKIeUDAF8szGdOyna+1uxFHH6/8juV6c
	OJcmQ==
X-ME-Sender: <xms:Fn24aOmkYuVdcCTrbxn274HxWPtrTN4FGDkNAt6Z0tT6yFbY8TX4Cw>
    <xme:Fn24aNMD_m0LlGUm0F2lgnVGhb3d--4Ad6pm2mdbE70cxpF0fYqTdkYC19KWBrsFP
    4mEJAZOZp9PLNQEiEU>
X-ME-Received: <xmr:Fn24aCM36YvVt1oAhNXIcrNu90wXpU6Zc9gJyNIFgnrlAulNUvFmJfYAdm4ZWqrFM6LR-1CH2z89_0DZx24xuFtiPxx6Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhsohhnuceo
    mhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvg
    hrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueethefgvdff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvg
    grrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnohhvoh
    esshhquhgvsggsrdgtrgdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgvrghntddtgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:Fn24aOjHXTPWMzwjYeZHbvUGLOmZ8DM608nTeyhcwwX_hW1O2DZzpA>
    <xmx:Fn24aPv7Fym6IJwM43uesqfSCRXvepICXtCShRIKnaFB0A8QFFOPZw>
    <xmx:Fn24aESgskh1xhVNNPRaTAtEYwLbl7_MDfQdxgntt1B5dAmWTJCY2A>
    <xmx:Fn24aL20CHn-B314g6TTDrjrLYIyPDjgP9ZFyrWPx50M80PdTYb1wg>
    <xmx:Fn24aH9zHSEKetwhITlCEV6m919agwX9ncprZ0EooA3ujHw7Y_XgYeH6>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 13:38:30 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] platform/x86: think-lmi: Add extra TC BIOS error messages
Date: Wed,  3 Sep 2025 13:38:14 -0400
Message-ID: <20250903173824.1472244-4-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903173824.1472244-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20250903173824.1472244-1-mpearson-lenovo@squebb.ca>
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
Changes in v2:
 - split patch up into series
Changes in v3 & v4:
 - No changes

 drivers/platform/x86/lenovo/think-lmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index f2bef523d6ce..540b472b1bf3 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -206,10 +206,21 @@ static const struct tlmi_cert_guids thinkcenter_cert_guid = {
 
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


