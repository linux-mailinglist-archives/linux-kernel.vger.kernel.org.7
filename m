Return-Path: <linux-kernel+bounces-881209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CFEC27B97
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 11:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6C0401DA8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE82BE650;
	Sat,  1 Nov 2025 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BmYy+ozD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9MXZrVg"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E555DDAB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761992500; cv=none; b=rs5xhxrrTRpDbd8i/61wI0lqW0b6u7NXyvKCTGtQEQONQRIt7zgQRDf3zJGKsPypSswtXiix5B64zghyyvXA9/Sdj4xZ4lBzBPk5xDk6pi5pg+tBwzwr0b71zqxBsHch2MFnzEippCQDAUh0x439iK1SKnIPzjnFzBc2N7ODi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761992500; c=relaxed/simple;
	bh=cOpr/AB2qvh9Vy4zbZ6++mWOcMtRlfwTtvUaDZFoP/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hITnYNv7b21SQ6Vm2Fw0Qd1xInuKdhpctKchkcdhtTUZYmRf2tkFAhfvCK/LlIVsEai3ZtADCqUDTqqH9MwlHlzYwH/oAsMlvgRBLywN2JtS7OJ8DRw0LgbwwJJtoyaEB/khg1nJH6Ga03Cl+4ZX5K2N6LeOujEdUJ7gfZlk4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=BmYy+ozD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9MXZrVg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D38B014000EE;
	Sat,  1 Nov 2025 06:21:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 01 Nov 2025 06:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1761992495; x=1762078895; bh=ztIDKcslTG
	TCs5LtWQS4Ca7IE0KT1FrU69Pkd/aaHv0=; b=BmYy+ozDF42wBpWDHjiJWikmpL
	2OqEXAWnLxAx/OSOyENxVLmzuyVtoRprBFQV0iR8hJLrN9/OOAFlyQlH9xJecp9T
	5CudUw8YS6qo9RV21GU38Ccm61boRvJH1wQt/9FeUPo48QPw2X30QGLH4PhJebxy
	c9EIxsjK/yO5kg3t5vjXLjf6xsekEkgHrp3HMcDi23C3ppMxXKIiqGNVLLTFFETF
	Uj2JZZWi/P7y35CZlTnc4EZxOieHr5Yvrdq2bMAlwaRE/sfi3thl20el/BAIdRUN
	NOQdRIsxB2GzI2xOgyuTL0l1LpwT2UGxgOBu+cN1KZsA6w8XpwaGL57RkPug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761992495; x=1762078895; bh=ztIDKcslTGTCs5LtWQS4Ca7IE0KT1FrU69P
	kd/aaHv0=; b=l9MXZrVgsT2HUEztAerG299jt4oF5VycuFfXgHPdRlP1cnukmkM
	1euvte6FikLBszV0FTi9e8Q146O1AD73a/N1IWzUzIPdifxJ4B7Yotr1gSlgeaxX
	RzMMNzc87slyMD2uCY4tXotYYII2tf+yOWKsD02Tfa1dIrq/aqDEubyJiL63Fc/p
	vHmbV+zM8Flsn0B6cXGY5+zYHdXtk42L4VORbM6syOj8x20H5KrMPYHynd0/gkN+
	OTlUolcTw3SQUueY/SOlVR31HkBq5fDDgqbdSwSZDV0hNQ7WnyHOzoCDIPO+16JF
	0lK6ns8NJdzcIDjA0y9aCD3INJw9WIy8WqA==
X-ME-Sender: <xms:L98FaVfMubpmOyPRGEOn_lGRmF8Dv2UuKDuV9_pBpaMC76TDOY-YTg>
    <xme:L98FaRJ0wGg6s3wMyaeM1Pjm2QbX0e98Ti4S9nmRzH8cMH6D3zdt5SPL5KWpv6DRm
    Rmklr4gkogVLV1kIVm_6A36UccQQVfIDyLsnn81i7YOrAN7KBkiNJE>
X-ME-Received: <xmr:L98FaWEVmAizSVb-b7ezKfJVXj9Hbzs95Mgg6P46xnWIUEM5DcreoH98ui506aOyrRMx5ICjw_CWydHjTwM7b5MygI4XnnRIOqP-OHkuKScajRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedvuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffveekud
    fhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrg
    hmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvg
    hfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:L98Fabor-rz_KAz-QLGcY8znE39dJkT5lopUqZxfIJqu60yZ1yKzlQ>
    <xmx:L98FafRs2rAFv1JpVrLAnuf0s77hOFnbeKX947QYZC2dWljsLQLZ5g>
    <xmx:L98FaYOTpUUZV70t2yuTyQEaoTgFBQ-ErLvFx724UxNw99hQhOGvRg>
    <xmx:L98FaSOJSTWEag1ttwtaizEJLbf9jqPMcP_8BhKN6LWPsjl96te9Gg>
    <xmx:L98FaezWF048pGmpcqDM_YIBMh9ZeJFO_aHt-A61GwxZAPSWzMNVfxnV>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 06:21:34 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firewire: core: code refactoring for transaction layer
Date: Sat,  1 Nov 2025 19:21:29 +0900
Message-ID: <20251101102131.925071-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The current implementation of transaction layer includes some duplicated
code for managing transaction list. This patchset adds some helper
functions and macros to eliminate the duplication.

Takashi Sakamoto (2):
  firewire: core: code refactoring to remove transaction entry
  firewire: core: code refactoring to find and pop transaction entry

 drivers/firewire/core-transaction.c | 57 +++++++++++++++--------------
 1 file changed, 30 insertions(+), 27 deletions(-)


base-commit: b330f98ff238ad9446574965d09cab33736519d5
-- 
2.51.0


