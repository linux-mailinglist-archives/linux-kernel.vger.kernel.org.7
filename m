Return-Path: <linux-kernel+bounces-760090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D677DB1E652
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09797177894
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF41A26E14D;
	Fri,  8 Aug 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E0O0eyTL"
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E685273D6C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648139; cv=none; b=FGeUmK4NFOXwqTSgMmxgZLor9UwmakxOvMDNcK+0lNF39R74lhpJGdppbC3i+jlF7qHhiAXAqBEI8b6tXk7E7ebXhnCiZ/potwqVkiI54gVaY6YF2p+Q6uHCTBHuf2INla+qMEvYL1SXSJZJfcqnvcq3R3rQSdKdmx2q9yhcfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648139; c=relaxed/simple;
	bh=l+/cjitHQaCn5Z2qFtrgnop6PRPmcwaQTWfAxvoFm44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cA+ZR8ARS8hmT0+nS9Wt0UQsGnKOff6okmXjkV2K3QQ8L6KpgqGV6DZymcm4QFWnZdu4V3KYLUpwSzZZ8hpzLltYs84zMlBda2mwVH+D/OqgWweS6CMhufRybNhExphjgNK5Q9GYlFUpwVwX//IzDN8Q1BGhnWqDu4ZvZ4nD2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E0O0eyTL; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BCE5E43145;
	Fri,  8 Aug 2025 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754648132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+/cjitHQaCn5Z2qFtrgnop6PRPmcwaQTWfAxvoFm44=;
	b=E0O0eyTL5CSCW9zYLfXjJYG+MrSNMES9PWx+hdfNrHkAk29sheGYLyET1egCdCzjJERF9/
	E99actiq6It4TqLFk9JQZr4lmPAZpDQmbwvWj74Ta4k2ATEdB8ozfbblfkU720JNdvSvVo
	uuctgDRTuCftk4/n0hpcwC+QqCEMv80hwmlTLwlGq/5yXM+4nS6vA0tWIk6Dh+8CJJ7HVO
	xyefbxaDrI6vqap8R4hffTdyKBKuDgn4INe2qj6GaO/WsAnFYsdcJgMVWmW79bgjgux2Oi
	o+7lmm1PgUgF3Cd37RPS3OhbctCwTFW4YYEeKfVhude3mfs6YMwrjmPwF9LqOg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  richard@nod.at,  alvinzhou@mxic.com.tw,
  leoyu@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 1/2] mtd: spi-nand: Add support for randomizer
In-Reply-To: <20250808095503.906244-2-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Fri, 8 Aug 2025 17:55:02 +0800")
References: <20250808095503.906244-1-linchengming884@gmail.com>
	<20250808095503.906244-2-linchengming884@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Fri, 08 Aug 2025 12:15:30 +0200
Message-ID: <878qjuazlp.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrdeiheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrieehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhgthhgvnhhgmhhinhhgkeekgeesghhmrghilhdrtghomhdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrt
 hdprhgtphhtthhopegrlhhvihhniihhohhusehmgihitgdrtghomhdrthifpdhrtghpthhtoheplhgvohihuhesmhigihgtrdgtohhmrdhtfidprhgtphhtthhopegthhgvnhhgmhhinhhglhhinhesmhigihgtrdgtohhmrdhtfi

Hi Cheng Ming,

On 08/08/2025 at 17:55:02 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> Add randomizer operation support for user data scrambling.
>
> For more high-reliability concern, if subpage write not available with
> hardware ECC and then to enable randomizer is recommended by default.

Could we adopt a helper that allows to enable and disable the
randomizer?

I have no use case in mind right now, but I feel like it would be a
better approach.

Thanks,
Miqu=C3=A8l

