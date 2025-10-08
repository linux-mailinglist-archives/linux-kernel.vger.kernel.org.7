Return-Path: <linux-kernel+bounces-844993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A692BC33C1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E614F34C677
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E7629BD90;
	Wed,  8 Oct 2025 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=star-ark.net header.i=@star-ark.net header.b="tnxG0VFp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUdt+k3x"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B544DF71
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759894257; cv=none; b=O8hnPQ0AyZaLIHTQowOlwvFCeBobkxV3nTCV4eKr6xnI/JreslgObEafUAnh+EvBV6r3YQfJt0NZAXQEGxMj2xrCnSXjq+HZBCr9Yo9RFe4p49NW8WdbMz+ryk3ojsV7Tdpi/Cyia+ynYyQcaEzRLIMOmISV7Y60Pvr3/WaLCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759894257; c=relaxed/simple;
	bh=yLp0c608OOqehE6ao+XhNNZGPPltUl1TMWCGJrj1zrI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tNInBJSkX36P6SJ/1f0C21xxyCylzncvSBF+8txxWkL7o7EiEkLwfgf6+FVlYNhQMTmfq0PC2feEYoe61epFGVKsUFL9rQTNT4FCnZCt2IF/aQaVfQpbrqz+g6gQOYyM3ar+62Geuh/RidpjQpBxM8P3m5Lm7+kTmlivtv7dRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=star-ark.net; spf=pass smtp.mailfrom=star-ark.net; dkim=pass (2048-bit key) header.d=star-ark.net header.i=@star-ark.net header.b=tnxG0VFp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cUdt+k3x; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=star-ark.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=star-ark.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86B807A07EE;
	Tue,  7 Oct 2025 23:30:53 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 23:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=star-ark.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759894253;
	 x=1759980653; bh=DrM0xBFZthWR65HG2j667b24SJaJtTQgyYBWysOgEcM=; b=
	tnxG0VFpfYj7O3UUF7X/YVjz4d2/5zPFa4LbQs5bE+xH/zsw9OkOXwnE+Fd+TW9E
	El/w+l5Or5aGbU2Pk1BjvWKg0lu55332zC7uTmMot6O0y2DSORmTIXcdnDHEVQzm
	Ys/Ft4VOybUSZV+Z91FbRygAyOIzK+nzMqnRxdSfY621jVs3cJiLH/9gqs6M8M/j
	PUpprBdErP3Qo4uir1vSsfYMuPjH2N2+JQ1SYXLLyPnqw4Fv4aclAqZHuL0FMXyl
	2zOAoYr8TQGVUZS8p/2cBDKyhAcz/+J4FTdx8fwd69m9lqjJ14kZ24ifX67qGoLe
	Czedt+kSdKBSkm5Ey3adSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759894253; x=
	1759980653; bh=DrM0xBFZthWR65HG2j667b24SJaJtTQgyYBWysOgEcM=; b=c
	Udt+k3x6bonaM1aFJrBX5WQo1yH0cjMhDuJqSsYiUAhrJB4vEXiEbZjGSNA+eDte
	2TUMLJEa4yY2m87amyC6+TFl+oRpKjSsBOE7AdfPdlKF8+dhLm5ud311zNzKpGZJ
	DumT68YSc3aK9t9V/Barqujil7SiNxxW7MTXEuZEQsc6stSEqzUyM8B/o7xPzItR
	x24SBSxEkS8vteD/iMxKliA1Gjsc4StufT5Ln8lYnfqgX2qSY9ChTx6p2tfLGD0I
	odS0uDeprb6Zk24ji5cZAQIbJOqJFMfefTEIhnfiI6rMI6xLb21uKbVT31mluqB/
	cflgYpTvWaGik6E6AZcSg==
X-ME-Sender: <xms:7NrlaNouvYXWXqtHVe3oEud-_tnyMK2Zkz1DZq5xdrdtuP-VYw-J4A>
    <xme:7NrlaKeiKwJ3twXIaiCOv08uo-F7zSGMajpvggjdadfNfi-KBqi24dlA1936Igqxj
    lNiGAk6vT26Faiv9WcLmyjO07gqCoy5m-krUCOg2oTMyudp2krDOHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfhilhhl
    ihgrnhcuuegvrhhrhidfuceolhhilhhlihgrnhesshhtrghrqdgrrhhkrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpefgtdeggedtheeffeekgfefffeikeefvddtieduffdvvedukedv
    hfehkeefhfffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehlihhllhhirghnsehsthgrrhdqrghrkhdrnhgvthdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegrrdhfrghtohhumhesphgvnhhguhht
    rhhonhhigidruggvpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrd
    guvgdprhgtphhtthhopehlghhosehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:7drlaENN0lBm-IP5nzeW0QynfnNmWiWUC20m3g_-oJ6ufxCCBEMwiQ>
    <xmx:7drlaNMbh63FYqt7ulH4Ry16DYz78JSTnCDvnf2hwnnz6Omi3z1yVg>
    <xmx:7drlaNhGTtE9sF9D51NKkfVl47Pky1BCeOyo-ybah1lj3HU99_ncSQ>
    <xmx:7drlaCuoyZ-HeKME75xcaud2GFzOyz0gH1CUg6e5ZzNrq7kUuOfPew>
    <xmx:7drlaMRpsZ2N8LiOUWLcEffmINLulgP0JQjPFXDG_UgqCb2g6iQrOFXp>
Feedback-ID: i8db94900:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E0A1918E0054; Tue,  7 Oct 2025 23:30:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYuNQIH7K6Uo
Date: Tue, 07 Oct 2025 23:30:44 -0400
From: "Lillian Berry" <lillian@star-ark.net>
To: "Ahmad Fatoum" <a.fatoum@pengutronix.de>, linux-kernel@vger.kernel.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Leonard Goehrs" <lgo@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
Message-Id: <984d02d0-3862-4641-b474-345736a13b9d@app.fastmail.com>
In-Reply-To: <254c82d5-81d9-4e23-9ed8-29cfc3f3c008@pengutronix.de>
References: <20250707091411.1412681-1-lillian@star-ark.net>
 <254c82d5-81d9-4e23-9ed8-29cfc3f3c008@pengutronix.de>
Subject: Re: [PATCH v3] init/main.c: add warning when file specified in rdinit is
 inaccessible
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Tue, Oct 7, 2025, at 10:57 AM, Ahmad Fatoum wrote:
> On 7/7/25 11:14 AM, Lillian Berry wrote:
>> Avoid silently ignoring the initramfs when the file specified in rdinit
>> is not usable. This prints an error that clearly explains the issue
>> (file was not found, vs initramfs was not found).
>
> I have a system that works just fine without an initramfs, but now the
> kernel warns me about it:
>
> [    2.805602] check access for rdinit=/init failed: -2, ignoring
>
> I suppose that's unintended and the code here should actually check that
> there is an initrd at all before checking for the rdinit?

This isn't directly unintended. This message informs the user their
specified rdinit= binary was not able to run, regardless of the reason.

It would be good to check presence of initrd and print a more specific
message such as "rdinit=/init specified but no initrd present".

Kindly,
Lillian

