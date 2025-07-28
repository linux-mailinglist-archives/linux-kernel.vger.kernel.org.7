Return-Path: <linux-kernel+bounces-747348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFBFB132D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9687A175691
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454061CD1E4;
	Mon, 28 Jul 2025 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="sAt8hmae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObRL3G+s"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782151FC8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753667494; cv=none; b=LXjvEa8TpG540rzCj0cQtwSDwTXQ9OngJRfdUN/IGoL0fl9Steh5ZiWf+4OM6irNXhfbMzsyleaSK7iQ0Yf7P3kelbG07DKb/Mtb3CyU3CDhN6okLd0xcv86DPOtfytQhk9A/3yljLkH5TjjJrCjKNL9ZF91PTkIaD7MlhBVpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753667494; c=relaxed/simple;
	bh=WZFEZdXovnDFmO0SQp6k8CQkNZ8QFGfS4Pd89bTRI0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N55HxEY65uo5iRL1xmrY2yWJ61Tls03yTLyJMudTWQf/nF/txX+8RbegcN9CtGH8wtQWsv0ZBqfsF2qzsI9miGsYZ+mJoto3nkGZxknJlTEhi1OwKjQU1e5PwmYKFwSqo59DWt5CQ8NwXG+8WKYwZhljv702j+g2Do0CuBnRvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=sAt8hmae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ObRL3G+s; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C408140008D;
	Sun, 27 Jul 2025 21:51:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 27 Jul 2025 21:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1753667490; x=1753753890; bh=6Tv+N/N8/k
	atx+Nag61D7gFnZ24jk3quhzStI4rkCPY=; b=sAt8hmae0+2RvqoUnsPGfMOnmN
	lk6bgtDOBq1rPMd2RQR7e7zEIVOBgVbx3N8QzoEB38aAJOssDLxSS6srqbUGXtqm
	YTx1kTdxRb4oEg4ccppV8IT7KYdCwXqq11EnyG4+JpXEqOAKDmM2666VuQMW4OUF
	KtOvQPWKwuioaXU25k+E9iydsG0o8SwrNYQSk1PzJYiSSn13DtTdQbIirbMJXueD
	uWSO9tKQ7EavEKakQ68vrDnsKUkxHsz/jmBaqod+5PR3CDHBQD9rWnNJdlAAa5MT
	ibPIPsSaqPIKPQWLYj5eRc3Sro89Zg+pWtSIyTRK4/Dfgt4yvtqfj/2hBgLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753667490; x=1753753890; bh=6Tv+N/N8/katx+Nag61D7gFnZ24jk3quhzS
	tI4rkCPY=; b=ObRL3G+s2DBapMKZIHIjcdBQVu0saIchwl3mYmXUl07jnmiABeD
	49D5IV65NyQyzOmAghTAKmg527dbxqod74xEiwee6fU1VagyX+rszcLbzbdKyXoK
	Kirl9GCAK94kz8Pn3XVobfg300FCOLVsWTmpudjZ6tmyKW+feQhaXfgav/UN1Iv+
	puFX7Eb6nBW6+FAoUmO023lleUxkfcav0+lzRULNj4I9OxywuV+t6fYK2bp5Bf9a
	nlMprI15jRvxopuLE9iV9uoLgWuUpl8Y060uHpe9rqHEuWdYG06kMgoOnpn1zaVj
	NOlOi05DoXBUABpEb4H3+/b1h/zoYemlQIQ==
X-ME-Sender: <xms:oteGaO3kS3PlIOgLQvyDo5dEUGIVnahzo4pm3MWBdr9Z9PDiODSMdw>
    <xme:oteGaKDkP8EeaXaqOc8ArcIxIhcMsyohI3QxE22wQIY5bt9QyBdYxojcq_Y5acBko
    _GK72OSuPmpUHZ0EXQ>
X-ME-Received: <xmr:oteGaI0DtNC_rPSyHSvw-k_SRzUAF80mSwk1UDgdE-_IXFlPkrNDN1fnrigyu3wUCn9q8p1hrNm8gHQSHW2pu9FoRGgSNXqwsGGZDsJ4_kbrZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeltdeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepgefgheelheejieelhe
    evfeekhfdtfeeftdefgefhkeffteduveejgeekvefhvdeunecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqd
    guvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oteGaMvjZv_vzbsQVmeyxWBP0kvXTB6s_HEofVxSsgHE8t1HgunV4Q>
    <xmx:oteGaA5XbeprwG3tAuDJ1AnS5Vy8KP65IVA6AtTXHH1a1QtjDsy98A>
    <xmx:oteGaFKtKqa5wNXWNLFHPfWQLSgJjjqXisxTwyIMHdgUCrpckHKgrg>
    <xmx:oteGaI77ReRrebWu5UrmhRMXDMsQPzUVEyAlmimaxbe1ATNYKKXVAw>
    <xmx:oteGaEa7UB1fhLLwZivsas98QVxa9ZLmoEL7BO8lM2HPTKVtdsp7BzNh>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jul 2025 21:51:29 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] firewire: core: call address handlers ouside RCU read-side critical section
Date: Mon, 28 Jul 2025 10:51:22 +0900
Message-ID: <20250728015125.17825-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

After applying the patch that replaces tasklet usage with workqueue [1],
I realized there is a corner case where schedule() is called within an
RCU read-side critical section when handling asynchronous transaction
from local node to itself.

The mechanism is:

fw_send_request()
->ohci_send_request()
  ->at_context_transmit()
    ->handle_local_reuest()                       [to local node]
      ...
      ->fw_core_handle_request()
        ->handle_{exclusive,fcp}_region_request() [under RCU read locking]
          ->fw_send_response()
            ->ohci_send_response()
              ->at_context_transmit()
                ->handle_local_reuest()           [to local node]
                  ...
                  ->fw_core_handle_response()
                    ->ohci_cancel_packet()        [for request packet]
                      ->disable_work_sync()
                        ->schedule()

Previously, when cancelling the request subaction of a transaction,
'tasklet_disable_in_atomic()' was used. However, this function is now
deprecated, as you know. It has been replaced with disable_work_sync()
which requires that the workqueue be allowed to sleep when invoking the
address handler.

The purpose of this patch series is to move the invocation of address
handlers outside the RCU read-side critical section. Reference counting
is newly added to ensure safe invocation outside the section.

[1] https://lore.kernel.org/lkml/20250615133253.433057-1-o-takashi@sakamocchi.jp/



Takashi Sakamoto (3):
  firewire: core: use reference counting to invoke address handlers
    safely
  firewire: core: call handler for exclusive regions outside RCU
    read-side critical section
  firewire: core: call FCP address handlers outside RCU read-side
    critical section

 drivers/firewire/core-transaction.c | 66 +++++++++++++++++++++++++----
 include/linux/firewire.h            |  4 ++
 2 files changed, 61 insertions(+), 9 deletions(-)


Regards

Takashi Sakamoto
-- 
2.48.1


