Return-Path: <linux-kernel+bounces-785243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D99FB34805
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCB7483FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9431E302CB5;
	Mon, 25 Aug 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="bn0biXbU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctCxZ671"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F63019CD;
	Mon, 25 Aug 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141000; cv=none; b=ImTgKF6IPycyeTsmhGzyJCCGiZFk2iLEeJ9MOZ+9YYkyWjrp8GlMtREDSjAhfByz5WUUdmgRPu/n6x3sv409KMCOFV4EkQk0dbhPi9AYAr9i+WL/WoTxc1B+c13xeIqBBZ+xIlA1Kbb0ER4ujad6EMv1iRUs3p/dfOy3Gu/PYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141000; c=relaxed/simple;
	bh=68meM5dW0pFqAWQR7T3HRlXIi+A3lOi1dQgByqLDlb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ppf+mMyFRNi16ubN9OwKpRcw/+CNPCFT+lZhhWrlxX7q1w+9AqNbYpytyBqL0h1yoEWEbM4lxLjLcc+TxJH2oSFswlyluO2T1ZW63iv5my/vTp5Hu6TeBojU1Ydv338NAk7Ztu+IKA7yiFjxf9ryFaCM1k2EreDGeo1h5oIYpMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=bn0biXbU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctCxZ671; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 019321D0014C;
	Mon, 25 Aug 2025 12:56:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 25 Aug 2025 12:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756140997; x=
	1756227397; bh=gPgtk1hYc4sG1zhLOdAr7vtpUuIF3CQJbkc1bMz9Z9U=; b=b
	n0biXbURehozv2ZqzY0mVGrWDzNydlpr3G/qwlGUqLlydYQtY8nDCGrBGt2NZ7qf
	Wo/pHd292Jhm3dKugqkbQ+SwbMp7tF70iFyvlNPxphFS2r3yMYN1SbHm7WSdRu+/
	clYvnT5SHP68+3IcqZ72fh4qYDHmyxF+yORwux+kRGAt7D26nvRrMkQLYoX7wzjQ
	zeMHq8mKGev+zmwVHeKC6se4XOGTAwSr1dlheRltJ+8ujYeZxMwSkbYm6Wv6pw3c
	JTZihoT5/xxpCDkSqgaYr63OdTI1Ou6+5XTyv50fECXunQDbRW525DeEh4eSk9ah
	lXv+RUriuAlbXEpspzO5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1756140997; x=1756227397; bh=g
	Pgtk1hYc4sG1zhLOdAr7vtpUuIF3CQJbkc1bMz9Z9U=; b=ctCxZ671nhqPlLXhL
	GO33xK7xzVebHdwoPreYFJHbwab43FXRvZ6pW8N5Y15Ec1Lj8ICQntCJjBbok0Zo
	e9vZ71PvyIqy3IB8pn/YBjA2zmNXpg6Shh/EDKlwXoPVqUFm1Flod5lISGBjaT8A
	IXC3d7zOpKmheUNyr38jb92VQE1NuIzaTa+A561ZeihX3F2wTMZ68pb18qQJcAwa
	nH9B2gjTAcBrBlqBp47HQVvi9zE/ilKLZ10zHeJXBoDPkfsnSRxHFh7e7Z9wAE/h
	cBJ53vetPYXyS6eOqOmO94HoWNKvc6F5mtHeXnzIe5mw4MqQi91NN88ZBghLn3sy
	GxI8A==
X-ME-Sender: <xms:xZWsaJ8H6fJsDD6u-arqlXiHBCBBWqB5pxn4xVlHc6YOyof59A_Z6w>
    <xme:xZWsaFGPrcDo39AAvvFvoUtt4R_wKHSlSaUO5uIvJeJ7SmF9vpNh1bl3WvjC07UKm
    3UaBb4aGRE1xmVeAu8>
X-ME-Received: <xmr:xZWsaMnPIlQDboZYKTAXh6jn9xEhnWSFulBGUHQyQknvRnZi7ePTv8dpwiAVVwSFK-Eni1_Dfi-y88jqWrVJgPIIjLYmbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:xZWsaJbqEOB4FkdX6GZ-_w9zuHhCpBH40qoiL9zVCrFsFc4pKpFb1g>
    <xmx:xZWsaBEU7n478T_aQfeNIGASqxYFvvxYmwQneeLqbNOtYpnS9WuLVg>
    <xmx:xZWsaKKlxnaYPDIOO-jUpCFDcuF39568IZAoxaJkXLP1JgvJQD6NGg>
    <xmx:xZWsaMNxCYsEG3DCcpplB-sY4qQDa1uIIr_aM1qcCCym_YfO2tpcHA>
    <xmx:xZWsaFUhJmuLZ81jsAvQdUQtFan-gZlat08O5NMQ3V-Ppt-ab29DbfJo>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 12:56:37 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] platform/x86: think-lmi: Add extra TC BIOS error messages
Date: Mon, 25 Aug 2025 12:03:38 -0400
Message-ID: <20250825160351.971852-4-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825160351.971852-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20250825160351.971852-1-mpearson-lenovo@squebb.ca>
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
Changes in v3:
 - No changes

 drivers/platform/x86/lenovo/think-lmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index 3a1cec4625e5..006ec0446c4e 100644
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


