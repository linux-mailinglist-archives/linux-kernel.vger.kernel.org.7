Return-Path: <linux-kernel+bounces-799180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA6B42814
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11097581BAA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D3321445;
	Wed,  3 Sep 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="JzFDpcwE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jfOytAOm"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9BE1547C9;
	Wed,  3 Sep 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921111; cv=none; b=tbaGVkSF46XTZxnThrKgSXIcZejuq+kYjc0RESfQGOmU74HX0eZ+ne6U3p2UlamlCJhTfVrcyH0jh1MVPyvn8yHdYee26k9jXP7xVjPGXxQ3FTB8WEbLUvuLJCNk6PFxxsh+/c/DPKhTunjRb/vtBn0a+4wcPo7bWFrMj8I2Si0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921111; c=relaxed/simple;
	bh=6MdeTwguEIK8eQzpgGuuZZ5Lyy7wx1K2dYRDQAceTbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYtAcpwYM7ZtWZ4JTGeoxUFxHXB1LpjfDf5iVsPG+ALTgMyCGxJgJtYL8hDFyqMAk8pAs2IVTIw9V5SfYniYsDcuhHT4h52OJDn9gsshlrVHRCz9ATmF1Uui5FFcsDOK+MtFCjRijOuZrXLsfwZerY2uJ7EEN/WYSJ12AaBpr7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=JzFDpcwE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jfOytAOm; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D70D1D005B7;
	Wed,  3 Sep 2025 13:38:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 13:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756921107;
	 x=1757007507; bh=SRUNF/Y6a64X7xwdLuj65KjJXxB/ujzPZMzcxbWjCao=; b=
	JzFDpcwEyO8m9ufE5pY1h7nPYsg81pY8UpW+24UvFFCF6kc0Baaqn7cxRUC3hf/o
	Sr5jRUP8lZXYebNJLJI1reuww/smDaNfCTPZAsdqH7TGTK5jJ+5ocsDAB+8jboZ1
	XveWcsl8prNmBqiuMAA7bQgWucYqKk9VMCjAP3Niobs9UK0d49kMB4KmsWRmNnZF
	SwTZJaVyE1lx5O8kCvri5iav6akQRFvc/WVOVnzMhhqrfqTFYYbmhbbQxYyC/cvK
	okdXsVpVt1FX4Fkl3/rZEVOPrtwTVXEtvnpEkd60amm4+GPWpQrGqVf2yIB8MlqB
	W5GVkGSeDFn69ln15kvFvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756921107; x=
	1757007507; bh=SRUNF/Y6a64X7xwdLuj65KjJXxB/ujzPZMzcxbWjCao=; b=j
	fOytAOm7TI54GmW37UERByxIB7FmaHgjwDmv8N+3XVUg3BQUbIa7MKX/Oq6vs2/V
	KYVzIHfiHrlFryJyL/h0oeg+Lhl1siz8mEFUvII4dBja0Zmz9BKI7ohFUmH0Tagk
	irxST80QSngECvxwQpSBhbs9MJevfamtMTzV+v/T8T041FJEOdPXDWwVpbLZ72Uu
	dXHo5vbOuQWs2WV7cooO0wmrxXHY03XRvQ4kqtcoxO31GM6g62YeagNgrwpfuQs9
	UKnubKcTm1Wu+//e/wZW7bCTUOj2c5A94nQBU4htKEMlySE1nIBb/FgmNnH14WtF
	3gCIBt9gX5fiA9nctFOpQ==
X-ME-Sender: <xms:En24aLwnj7DxmQD8Q46wG5zrnqz2oxQOhtX1Dyy7867hNZNUV9Mzyg>
    <xme:En24aKpJ_4EX3hFGpG9ymwJ3bjAfO6q_TG3T2m8mYIPruTt_7917g82u10fbFFiJ4
    euK7bKWwD_t8f2pEFE>
X-ME-Received: <xmr:En24aK4dZwnv-eiqW9DrGZR890SGtlQE70URyPonXQI5jTcHDxETt4C6S7n5SAAtnKpO0PVSk0MxLntgdvFCPsYEa3CObA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrkhcurfgvrghrshhonhcu
    oehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtth
    gvrhhnpeffffefudeuueduueduhfefkeeiueeihfdukeeuffekfffhheeigfehveekhefh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmph
    gvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnhhovh
    hosehsqhhuvggssgdrtggrpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhi
    nhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvggrnhdttdegkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:En24aBfTPdEQRCBm_u6W2omk4h055mjRqjrWrzV3SpHu4RdeWbyF-Q>
    <xmx:En24aP743LwoZklnj30yPDxVVP3oovLLBEke7B99RZYCI5MBJWoFEQ>
    <xmx:En24aIsMpwfsXupuUiJO7gbOMMzqZ43Ju7MdsNVQBn2thbTQja8HzA>
    <xmx:En24aPiY1sMCAreebb5wxYL2PANZFjPBRKYCoAwX6oWpNdC3de6tWw>
    <xmx:E324aGL234JcV8WXBuIUvtxQhSotYDRY7oE18eJ6Ped_sSJieDSiZXhT>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 13:38:26 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] platform/x86: think-lmi: ThinkCenter certificate
Date: Wed,  3 Sep 2025 13:38:11 -0400
Message-ID: <20250903173824.1472244-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patch series to implement certificate based authentication on
ThinkCenter platforms

Patch 1 introduce a certificate GUID structure to make it easier to
support different GUIDs for certificate authentication
Patch 2 implements the changes needed to support ThinkCenter platforms
Patch 3 adds some extra error message handling as used on ThinkCenter
platforms.

Tested on M75q Gen 5

Mark Pearson (3):
  platform/x86: think-lmi: Add certificate GUID structure
  platform/x86: think-lmi: Certificate support for ThinkCenter
  platform/x86: think-lmi: Add extra TC BIOS error messages

 drivers/platform/x86/lenovo/think-lmi.c | 94 +++++++++++++++++++++----
 drivers/platform/x86/lenovo/think-lmi.h | 14 ++++
 2 files changed, 93 insertions(+), 15 deletions(-)

-- 
2.43.0


