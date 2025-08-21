Return-Path: <linux-kernel+bounces-778723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E75B2E968
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D051C878E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C118991E;
	Thu, 21 Aug 2025 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ijfPv1HU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cadbmps/"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04EB1EA65
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736225; cv=none; b=uLoJKdQQaaa7WFJ0THZeuqbrmmipXfBO6f2h+k+YmkxqDazUP9YIPdVREOqcypvySPQ1wBY58cEpmdQBN8vKWKVJpm085f3p6saXtgOfLDpfVQopgNEUA40HMJ92cAx8zxFQ29vVuQz1N+sZNLtHKcVOYHWOnc5gGIlVhIXXdVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736225; c=relaxed/simple;
	bh=fHq598hKh9zp0EwdpEpi9EQZD54o5EXngo0JsrLI4mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSQQ/iybphQOTdQoAkIzgGASibmHLTJ2jHXMOtlXJ6WfJpHvxjoaLulcOnWrir87W6baSxIOC+v8N2rwabgeImBpxeE0ahJ4PFl2aRy9BQjOZE1pXZYbbHoFU0Mjy7vWGDOZHu/C3XOBrtyJkYL+s2OKrShzHjqDqbTvDsLSn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ijfPv1HU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cadbmps/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0116014000C0;
	Wed, 20 Aug 2025 20:30:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 20 Aug 2025 20:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1755736221; x=1755822621; bh=+gwwzlTlXI
	aDfV8qx23NRaBErl4HGvjnbBhXkigbWZA=; b=ijfPv1HUZZXvDkTjiO5co5spJ7
	SjGlw+4GiV12AUIk53/dPl/CJTui9xG9phpHzqa7HkuwptUbnWA643bkYAwfNGNh
	0QV+q/358LsXjpXPqFI9m6fJqTJCoLlPS45PsfUgTvKiHTHefoDGgT+6+bRn17X5
	fLtkz12AzLbBA4ngoenFKfMTJOAqw0qr4y4CxTKo45lQCa5QkoXj3wMabYpzl0lG
	ZaQ3VDiGPtG6qKU5n+ONJqvf7Zxkb1KF/Wc6gUX20nvMUj6t1FOUkZFCtNfUxpnG
	w7VWrQqR0XhqzPBFlZGwZA4iMWksAlV5z5/EcJGTdIJJ+Zwma3f3J2RVDUyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755736221; x=1755822621; bh=+gwwzlTlXIaDfV8qx23NRaBErl4HGvjnbBh
	XkigbWZA=; b=Cadbmps/Pnkg5QA3rQXuQ/qmW2lIh5PmDlAxWIn04wy7bwEUj7n
	XxJKbglAQI1XAzKlmQVVEmE5I3UqW5akUM168Amluv60BB0pN046PrAX1aIyxuds
	EbFWMxPl71hHhjmSqGJq/TtxZDb5oB3pUGMEZB1d8Lx5dOMBz5tT5ZYMcHVHwX4c
	gOYzowNEeERCuo4fMg8nVWFKPvEaXn3Z4EgrcSCAdm0QytaSfPyHyEYpX84oVSeO
	N4og84uI9WxMnys/jWIdEfDz/P0D9BJBQnsPqYmRAJCuRWW1w18vgbY/ES/gDDnv
	GfK7aX8rfcI6kHCaXUTjhP2DR1NG4ZKMLUw==
X-ME-Sender: <xms:nWimaLWla7ZzEToFMewG0TCnrhPzaIhhHTeodNZzkltTRIcSIPtCsA>
    <xme:nWimaMipWAU43t_12zk7-lWT0neMUQ6FWwpFvoiXyNoTl7c0PyXIUmg6EV8ufQT7J
    RW7l5yhRRf5B9XkTEQ>
X-ME-Received: <xmr:nWimaJXlQYEo_4Cv-shWnlsUe75FK97ufjckbCR0Eb7wvgtEKZcBllsXXx4svZTBv_uyY4iZB-Z-uhbWroe5R_YU5M8ygQh0RSbgSNeVwjSinw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:nWimaDNRQ_RED8YqgTQpYQR6OfGPswVcGAXIaEVkPm4je5uxyfoa7w>
    <xmx:nWimaFZcc0Lvzlb-LH49IJpebw1_Yufb1lL5gZWl8Q23yFN9LlVCKw>
    <xmx:nWimaPqc2ddVNr7FRD4y3W16JF3aXkCkVXiKHfSf4gt-bgRYJCsqOg>
    <xmx:nWimaBb28tXbHxlgEJMkZRY86P7VFBxxSb2y6QEvY9MsrhCTRmbMPA>
    <xmx:nWimaE6oQsH_kr7e2GLFfIkeiuSltKzPRikijzaPjDzbCPNY6R6pOBDk>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 20:30:20 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] firewire: ohci: remove obsolete module-level debug parameter
Date: Thu, 21 Aug 2025 09:30:13 +0900
Message-ID: <20250821003017.186752-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The "firewire-ohci" module has long provided a "debug" parameter that
enabled debug logging by calling printk() from hardIRQ context.

Between v6.11 and v6.12, a series of tracepoints events have been added as
a more suitable alternative. Since v6.12, a commit cd7023729877
("firewire: ohci: deprecate debug parameter") has already marked the
parameter as deprecated.

This series removes the parameter, as its functionality is now fully
covered by tracepoints.

Takashi Sakamoto (4):
  firewire: ohci: remove obsolete debug logging for IRQ events
  firewire: ohci: remove obsolete debug logging for selfID sequence
  firewire: ohci: remove obsolete debug logging for AT/AR results
  firewire: ohci: remove obsolete module-level debug parameter

 drivers/firewire/ohci.c | 248 ++++------------------------------------
 1 file changed, 20 insertions(+), 228 deletions(-)


base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.48.1


