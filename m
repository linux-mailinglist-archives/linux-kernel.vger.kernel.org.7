Return-Path: <linux-kernel+bounces-780474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF090B30255
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 600A27A8876
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E23343D88;
	Thu, 21 Aug 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="VOhLKqCb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U3p0eNKU"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8A157A48;
	Thu, 21 Aug 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802407; cv=none; b=DcG7NCjrzrsI0h7Pqkznc1mRXXtqYZ5F/uWMAFcRYkTm0GHcWFmjBDUiy5szLrV5YcPN9tLlJKX5F6Kyfx5KKWQLhkjwnb/E/IRXWne3Md9PUzLEv/0gWlZxYtpu7AmW6RwM1EfA8w1cqvB45C1O23pWa0XhmIlD8kT0oSu565o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802407; c=relaxed/simple;
	bh=EPCMCoGF7gljXImYIrIH9WCIHz6oSi5p0rIwFzncohY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgXo3JRtIRt+GeKJB05qyQ3/kF0L6BFJ9uGRHU0pM8ma/NUL+aoP/7s23Fv/Mlzg4zgsaGKFQbzsCILwE6ZLXJoENvaMVAhmlNfkDmFOef9mGzBLJwxxC9n7xRQ3FuA6mCASLplEPWSv5H+q2CGdJRlaJlq5gFkOUDNGJemeono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=VOhLKqCb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U3p0eNKU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 695A67A0060;
	Thu, 21 Aug 2025 14:53:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 21 Aug 2025 14:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755802403; x=
	1755888803; bh=Cth1hV7HSFBnl4TouUdtNRZlbqgis9EHwFGij6IrGus=; b=V
	OhLKqCbQ5VMGzWNkKUuzpyUsPClcAR7voOuB/p+zZD0mAVvwDS2asxJHQSeTh6JH
	mFRZWIuwS5EuuPrhMmg3lXIULrVZT9o6tkEwpZHWuoC/g/ElMS6MgtsMxb1y1Gto
	qqrQSkPnIC9/kBsWBKLMUoG1tCBKTWEYxsvWDNZ3wtydXk8RZcrWFG91egdPxARq
	mtY1m5/pxhqIOcOXFb7tkS55OCWDGba+zn6SKRyBfQdSDIyxHkJSncAhPpzRXzNR
	1u4XLnkzSQhj5hzpz6yKVX+tWv2FrX0KmLq5si29BeHW+7HZdXcoOYy6y4xBgZut
	XhMTcTvSdwCRl9qmaDeuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755802403; x=1755888803; bh=C
	th1hV7HSFBnl4TouUdtNRZlbqgis9EHwFGij6IrGus=; b=U3p0eNKUMCVhVa4cd
	Uwav5G+YQs6dlXM3sFLQh7j/eoUK1z+Yg3rIPJQpQs/N9YraKOFPGL+wfQ2DKG+n
	5VvtY+5yBZ1BPxV+lsSt9y1GC/t4WunXJlnomWyrFdFD9gJtZwfbiRNcGunxpAVJ
	YVkUWo9g9Ku+DrzWhrcIGHM3reT/N/9dipV41INXPwL7BaiFP4fDTmpCshYAMAJi
	HEpWIU7FKhU9q/MPaep16fU79mg8NHQYMhuac2Ike7KBAy89tMmDPTCqWBKfrOOP
	x9ujgWIA8yB9xezWBmfn1VYXtYCp8qltJQ8e6H9f3bs+tgCKxSJvMhkfKPV6BsvR
	mODQA==
X-ME-Sender: <xms:ImunaEV4Uc4k8-CRASWIzerByeHIFbvRLydXhT2C3TgL0RZLL1BICQ>
    <xme:ImunaGh7kxZheBokmNNTIgiDSvMaXmKUsvs2sSUc1u6YAkn-PP3wwlvIUYoJMgwkA
    qmDR1DQvZNbqL8f_6I>
X-ME-Received: <xmr:ImunaKs8_AhDto-aA2790v0JSMOUvwa0Mc9A5wxlH20KDKrYpyo2bOJN08OMxNxFAVv_fSRZrvElR-RvWaFMtx9-TqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhsohhn
    uceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrth
    htvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueethefg
    vdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    hpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnoh
    hvohesshhquhgvsggsrdgtrgdprhgtphhtthhopehhvghikhhkihdrkhhrohhgvghruhhs
    sehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuh
    igfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhssgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ImunaH7RTvLKHE5IfXuttvDLqSW7nl3HBmu4obRIv4sXGE1ByZ7dmQ>
    <xmx:ImunaGPW20OfHOWYZD85vUZZjcgT28aEHK5HOcGUFdJ1uy9ROeN_sg>
    <xmx:ImunaFsJ8Ur1zKZVAtdKWSTqM6VphI-oiU_jlZwCoVesyHECkpsIOA>
    <xmx:ImunaJbcHJA7l46wvbBUyWS_LCjesvLH9WdY1UCXwRBPePo21amfUw>
    <xmx:I2unaFG65gHm_ZKiFEfNRHjQIGQoHKcDhBz9iM8Q0KvMBGl53Dh4OzOM>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 14:53:22 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors capability
Date: Thu, 21 Aug 2025 14:53:07 -0400
Message-ID: <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UCSI spec states that the num_connectors field is 7 bits, and the
8th bit is reserved and should be set to zero.
Some buggy FW has been known to set this bit, and it can lead to a
system not booting.
Flag that the FW is not behaving correctly, and auto-fix the value
so that the system boots correctly.

Found on Lenovo P1 G8 during Linux enablement program. The FW will
be fixed, but seemed worth addressing in case it hit platforms that
aren't officially Linux supported.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/usb/typec/ucsi/ucsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 5739ea2abdd1..181351afe887 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1790,6 +1790,12 @@ static int ucsi_init(struct ucsi *ucsi)
 		ret = -ENODEV;
 		goto err_reset;
 	}
+	/* Check if reserved bit set. This is out of spec but happens in buggy FW */
+	if (ucsi->cap.num_connectors & 0x80) {
+		dev_warn(ucsi->dev, "UCSI: Invalid num_connectors %d. Likely buggy FW\n",
+			 ucsi->cap.num_connectors);
+		ucsi->cap.num_connectors &= 0x7f; // clear bit and carry on
+	}
 
 	/* Allocate the connectors. Released in ucsi_unregister() */
 	connector = kcalloc(ucsi->cap.num_connectors + 1, sizeof(*connector), GFP_KERNEL);
-- 
2.43.0


