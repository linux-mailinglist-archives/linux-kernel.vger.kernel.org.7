Return-Path: <linux-kernel+bounces-723958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C864AFECF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AA218917F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B3B2E5B0E;
	Wed,  9 Jul 2025 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dgYw25Rx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OUh8vWqs"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348D1D63E4;
	Wed,  9 Jul 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073129; cv=none; b=COdlRo+9euiGWx9auY4sks8EKn2qEuldxXxh2U73d93D+k849NCP9f/5FKIlPpm1gm2m1vLpttQe671zAaaxX05lPdR24crH9Nao0xOtUQgoOPVVrWq7cwgnJDydUl+gLAhbrWRsCYu9o6of+K5mQmdJLXEzsEDKfHVHxxWHNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073129; c=relaxed/simple;
	bh=LnSp8aF24sr3KVDjqIUnnoZPXMZEfHF/mYlwiLWyEAE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gz7vzya6ZcLyYVvRovkrAOdprdCoNO/IStq/jEvCo76ExxH4AFAARHnu3Sz8CJRgOUE8mP2X26HxyGz2kPeNzukum/Ae8e6b6FyiVj58cxAVzIEvVthgOvhWhtvhhPnUFDoGQseytyMd8R440sqzMe6sqAwZeqC3EQgvyZ2YEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dgYw25Rx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OUh8vWqs; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEC091400181;
	Wed,  9 Jul 2025 10:58:44 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 10:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752073124;
	 x=1752159524; bh=tJ5ubzgQeZmEM/uOLLsmE7v/DdXe2HEW/1v5AYeOmzg=; b=
	dgYw25RxCvj0VdadUKjZeDGqJagcqueXSTlmEvisoQBw7fWI6DKehkohKe3hNL1Q
	ykvNuXMqwZgO3rY1UGNna6ikoPFylt0vX/xVemZBYR6yGN+ZRKl3h+dPMJdlrZx5
	uLcM1okwQrixmVcVXuwYGmt6PA5tRZ9Gvnd9Yti+6/QrO3d8pPFagKfylm1Ecldn
	2PNRR0txI9HFB6+OD+KSKwM+qhmXFaTDLDV+XLEpkctI+rrmdZ4Qdhm+jZUxoh54
	lB5U4dCyByPZ258p4d/t+vSDnzBYihgWm/atVxf8UIbW8ZGG3uLWrCUV9P90tGzz
	s9YiRljtu8qmRTxYHJIANQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752073124; x=
	1752159524; bh=tJ5ubzgQeZmEM/uOLLsmE7v/DdXe2HEW/1v5AYeOmzg=; b=O
	Uh8vWqslGQKwQ7Z/65+gwF9AXSv/Z5uuO/Xi9UekhsWKZZYCftChHyEgqiyNkoiL
	SdGduAWbL4j9cT3HCEZFxG2WCUSQbfibJ9NI4sVIrTS8nF6iC83f+H165qaoTpD4
	VmSvY9MMjF6L0fkPSxZQSNiz4SeQz6bQoIz3KPGhhYVLzbal4CrEpypL+AqpymTH
	ay+uKn4QgEggA3aSMEuzaZ93Xd6/qAKPjQJQJe5TPwiS9dOm8ri84e6jwl4mUhgd
	1fHI2NoJZzEKKLrnjIOXpldL5loo6PfLvK++WL/3dl1EnP/5hyFEyWvZ2n2LoDpi
	jXtMtedyJOL2hWgfyPQRw==
X-ME-Sender: <xms:pINuaNbIYWLPcVvtN5TwrOEv5abub-gGM_uwXT0ZL_1DDu5TLF8iqA>
    <xme:pINuaEbjUL_JKbajEIhC-Og0auyURx7VapeADrOF3C0imyNVOEJ-_Qq7hatFFOdcO
    HTysSNMyZm1Iwvs-I0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegrihhrlh
    hivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhumhgrgheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprggshhhinhgrvhdrkhhumhgrrheslhhinhhugidruggvvhdprh
    gtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdho
    rhhgpdhrtghpthhtohepfhhrvggvughrvghnoheslhhishhtshdrfhhrvggvuggvshhkth
    hophdrohhrghdprhgtphhtthhopehjvghsshhitggrrdiihhgrnhhgsehoshhsrdhquhgr
    lhgtohhmmhdrtghomhdprhgtphhtthhopehrohgsihhnrdgtlhgrrhhksehoshhsrdhquh
    grlhgtohhmmhdrtghomhdprhgtphhtthhopehsvggrnhesphhoohhrlhihrdhruhhn
X-ME-Proxy: <xmx:pINuaHiEzT9UXLOv4dWCroUUjpw0F5_r6vak6qY3wpsIYu6G3kb4QA>
    <xmx:pINuaLSEnMWt8w3c6m5xYGQbprnB28Uep77aIfM1i104xkeAwqKbcg>
    <xmx:pINuaB-ATmHtJsdIPKraS1h3GMp8SqbrD9-FU1CaT9-bMrhctGK4rA>
    <xmx:pINuaEPvhhP_2-N45NSrf94g8TBPOQyarLL-D5iasKe9Y1aCdZjaIg>
    <xmx:pINuaMgmLPMzeWdHZ9PFmdYBeMi8xhHp8yDfOuOniC-zDj8a5HEMhc7V>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1A1CA700065; Wed,  9 Jul 2025 10:58:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T39335a34c5ea96d2
Date: Wed, 09 Jul 2025 16:58:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rob Clark" <robin.clark@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>,
 "Jessica Zhang" <jessica.zhang@oss.qualcomm.com>,
 "Sean Paul" <sean@poorly.run>,
 "Marijn Suijten" <marijn.suijten@somainline.org>,
 "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "open list" <linux-kernel@vger.kernel.org>
Message-Id: <1b8a27c7-5f14-4b79-835c-19c9cc258496@app.fastmail.com>
In-Reply-To: <20250709140838.144599-1-robin.clark@oss.qualcomm.com>
References: <20250709140838.144599-1-robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH] drm/msm: Fix build with KMS disabled
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 9, 2025, at 16:08, Rob Clark wrote:
> When commit 98290b0a7d60 ("drm/msm: make it possible to disable
> KMS-related code.") was rebased on top of commit 3bebfd53af0f ("drm/msm:
> Defer VMA unmap for fb unpins"), the additional use of msm_kms was
> overlooked, resulting in a build break when KMS is disabled.  Add some
> additional ifdef to fix that.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 98290b0a7d60 ("drm/msm: make it possible to disable KMS-related code.")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Thanks for the fix!

Tested-by: Arnd Bergmann <arnd@arndb.de>

