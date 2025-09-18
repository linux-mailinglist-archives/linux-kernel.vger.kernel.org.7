Return-Path: <linux-kernel+bounces-823724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB9B87528
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B44816FD93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBEB28B407;
	Thu, 18 Sep 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KlIEIrC0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmXjB2xF"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156992F2E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236947; cv=none; b=DOES8Qv01oub0RNnZmStUEB+MAF4xpWb3rXmcFZgAP+0PNswyYrPCHb7ZABlGgjnfaetie0IUeNdG8JhlnWvxbJow+lbc3o/qJM3/uOvdtbOKw4it3gbBUf4HaiS32F9GtSFb6lMlClhFv2cEQ0w3DZfmtkzZXbvCBlfpcUrqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236947; c=relaxed/simple;
	bh=s3gpeQXk8VvfaQY05VhkeXl+XmvRSReYT8IfETDQo9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxPAh0PVPWB/Blvq5eBwct5SF8j7Bl1BlL7ClTIYsDO/VsJEhq5bf/O9R6ZEtbLmWDu25IOBQl78IPoAuvDCxUuqniQ6FkAIV0DWV0z7BfVINn9Oj3aZGAmZq6bnqS/0sjR75HwJ2/sH5RWCHO7oK601Y2cY14aTydZo3qUiXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KlIEIrC0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmXjB2xF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id F30DF1D002C4;
	Thu, 18 Sep 2025 19:09:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 18 Sep 2025 19:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1758236942; x=1758323342; bh=cGSw325zHX
	BQsfMZxMaicImFWwWh5SwcKbn7vbwwNvQ=; b=KlIEIrC0Yvrn2fITpO0lJyk8pH
	I5KyDr3pmggrE+4IDk3h+NX8dJFpqBp25t1bRDGtHXrAe6yxHLfpwT/Mtad7WNP2
	7X6zq3kV2H/VyjPL34dGqqpJmeROeNRcSbvLwg/rXY/Rn4PQ0aolxdk4qahawG3K
	cVfs0lbHxnWZlyZXTpNehShteJ5rrmK6dVpyK8hz7qGV7OzJwcfpCO+v/smW2dj+
	MstY1fG+KjTT9gyNUctKYviha1pScOOJfA514OXsl7B6OgnqT4aGRHo8k4TVvwd9
	Pcc68rsOEKeYuBdJZrqO/8Y99wtautGGETEaffKPVgdgQXSdoQDXlAdlbFcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758236942; x=1758323342; bh=cGSw325zHXBQsfMZxMaicImFWwWh5SwcKbn
	7vbwwNvQ=; b=jmXjB2xF2NljPwTeXjotE3y2HUp4XwtayeEqjTmXiCPGQ+ORbIh
	14t/HfK+fGairjHCbvlZZuDHLUkQnuYoNXJ2aZXrxkTbXrkNFDztCOVmyiXCZFJW
	8rNfYFUlgMyEIFliGo8GYZecfLCY9weqnbEILkRVDKCMvzTtsM1xita+EDo+m6Ei
	Nz6qPZ0Vhwl0uXc0NfS8yk1HMVgOuMxffLNhA4n/RsSas+n0WCVkFhaXbXaXQ2by
	MvFlOnn9X3rX6liQ0DoKeL30BjCbcsO2Z1TqRSfrOeL+kGekLl4fJUv7W3CkkpnY
	aCHSTH5qT7n1TYWHiVPOSNNgkic3XkrCqpQ==
X-ME-Sender: <xms:DpHMaGb9dul8WbKfY2HFiR78zS_mRnPJfNrcdrXv4dckiIEknMGVDw>
    <xme:DpHMaCUGIkdwNVupOQ3VKXgjLzZEC9hAr_x6faa5OFw6HJtwQakl-uIhKT6VhJK7r
    BJfwF2pbh7qODGuLDU>
X-ME-Received: <xmr:DpHMaC7HtTji4WKkWOD5sb9i6E433tTYkqUcKFDxRIMZ-9zQuOKmYylbn2UJWMQTyMbG7pZqnDlJ-of-273eN7SlpP_pATB85iPRdx2dcCJsbdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhf
    etjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmh
    hotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfh
    horhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DpHMaFjVVdT_Uu9V1jgFsbWmVpBBMnbi4KsKj1HIbGnxm1iWdjHceA>
    <xmx:DpHMaBfeKjVxRS8fnzVNU0_BW4Y8QAyq-WY2VclxO8xt-efCkamxFQ>
    <xmx:DpHMaCdCewpdcvp9Jgn64r22gu7RHozHe_yyU1P6Z_71q-XGFcIrFw>
    <xmx:DpHMaD-4qOowbFYvXPIVNEmik3_iv3okm55wJlVovuD2n0FSfIFejg>
    <xmx:DpHMaEckQJMEozEHWXv_B-0L0ZJ3Zf_cQJpAhTzfdKNYQiLhrMu_nICW>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:09:01 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] firewire: core: code refactoring for work item of bus manager
Date: Fri, 19 Sep 2025 08:08:51 +0900
Message-ID: <20250918230857.127400-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The implementation of bus manager work, bm_work() function, has many
lines for the procedure to contend for bus manager as well as to
transfer phy configuration packet for root node selection and gap count
optimization.

This patchset is to refactor the code for the procedure. A new helper
function is added to contend for bus manager. The outcome of contention
is evaluated as a return code of the helper function, then the root node
at next generation is decided. The phy configuration packet is
transferred and generate bus reset lastly.

Takashi Sakamoto (6):
  firewire: core: remove useless generation check
  firewire: core: use switch statement to evaluate transaction result to
    CSR_BUS_MANAGER_ID
  firewire: core: code refactoring for the case of generation mismatch
  firewire: core: code refactoring to split contention procedure for bus
    manager
  firewire: core; eliminate pick_me goto label
  firewire: core: minor code refactoring to delete useless local
    variable

 drivers/firewire/core-card.c | 336 +++++++++++++++++++----------------
 1 file changed, 178 insertions(+), 158 deletions(-)


base-commit: e6d2338b6f3e522872f3a14fcc5e5de2f58bf23b
-- 
2.48.1


