Return-Path: <linux-kernel+bounces-723728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D58AFEA58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D851F1887047
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793422DEA75;
	Wed,  9 Jul 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EjzSYvJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NtQBkO2E"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC3E2DE217;
	Wed,  9 Jul 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068235; cv=none; b=hT+2ZslyrXSV7/kXn4O4lHsKvsljd53SjnM+IEAwPnw0VaoRkhfktiJGzGUD7esWBgaXVfIy490l/ZWDe9RbiNGj9A/wir+9ChwHwDYTXaaiIb65LuJsciwPzvWrI2QV4k16hdgLtvu39mIxPXDCnd8awizX8jt8kmN9RxvvR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068235; c=relaxed/simple;
	bh=S72tt1Q86mjuZ/H45KolFCbnlTKTnTpglpzCK0oYG8s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Weu/bYmFY+xQxqIRTrFnBTstf+FtjwRYEoOXyeu1ViY1ifoviicE5ugtmQY3/oZ2zNZ3Qzo4eO+jevkLv7bJMFzIDyNyS6lGwyRmqNzraB+e36AVSORnduq8FwmGI/q8uqTn4/PVfm6rC35MmI5BLhloDb9RS+rWpiwEYtIynro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EjzSYvJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NtQBkO2E; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAB07140036D;
	Wed,  9 Jul 2025 09:37:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 09:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752068231;
	 x=1752154631; bh=VjTXoYpJ9Pen/liWCvMuqC7LhwbLr/nwib0obOR75MA=; b=
	EjzSYvJzZH/RwXf8rki+ggp9Emyy0bbZX4nDTbe+SJeCx5Yh0Huq6UPR1w8Tlxes
	bHx7mkugV2wQAJNqXrMD4lh358w/9C4MPPM9P3ABKLLIrd3deGCaXKt5mjzDu65M
	6qEcfmxZhEjZpuW89dTjMdDH8J+kWOWZoWp9mil5ZgzFQ0Wbur+J5FFBt4Pp+sTs
	aLm79AxV+q1YdsENftaw0Jb8KXDNItBcICVAryDiof/RUIfUmnH1FjM2xb9QQL0F
	ZgRD7FgNSCAq6FT0EwiqjNYzeV91B9HCCYoSQWuc44S2EiV2KuSNe3A4lUBypvLO
	32+kADl9sDHC8HwyuAkWpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752068231; x=
	1752154631; bh=VjTXoYpJ9Pen/liWCvMuqC7LhwbLr/nwib0obOR75MA=; b=N
	tQBkO2ED9YmzZCjnkOJtMf1CE+EuaS5Cz3jBbq5bGoIJHXrK2jsT5TwFMtrW/t3j
	deg/4fzcnnJFquKsDLay/lJSv1Zd9N2l8/M7WThxti5RTpnNPdatBAwiAHx1p8lx
	S9iCZzZNoXIzSh88Avz/K7fgr8pR9VaWNPvGUC1DNGABTpQzq+OTaMxiqtpwl7f1
	nMd5kzO1/UZYyGRK5MYUudRxM+BDAe9DqrtK0qcyMYjP+9cHfuF7f0UD53L5zIGY
	B5rB8E5Ux0kf6m2QVjiTcSVflop/VPut6YA9m6ROPGQYsBm6WvD8/O9q21hCRcHV
	TcIQIIuZeWfvpULeOZ9Zg==
X-ME-Sender: <xms:hnBuaL9QBiSo3qqmplamd_FpB67Xn8rVG_2q8bkgmkUl95m22gg_Ww>
    <xme:hnBuaHsXRl26JKJShUFbSMRzUChz4PR1-rajtMsMvm_xfXemy0r9g7VYRxcxzO145
    Ig-IpHgzOXyIZEi15c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhivghrrhgvqdhlohhuihhsrdgsohhsshgrrhhtse
    hlihhnuhigrdguvghvpdhrtghpthhtohepphgvthgvrhdruhhjfhgrlhhushhisehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephihunhhgqdgthhhurghnrdhlihgroh
    eslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegtkhgvvghprgigsehophgv
    nhhsohhurhgtvgdrtghirhhruhhsrdgtohhmpdhrtghpthhtohepmhhsthhrohiivghkse
    hophgvnhhsohhurhgtvgdrtghirhhruhhsrdgtohhmpdhrtghpthhtohepphgrthgthhgv
    shesohhpvghnshhouhhrtggvrdgtihhrrhhushdrtghomh
X-ME-Proxy: <xmx:hnBuaH2cvqrDHLEnJrjl4VPr4vG92XAXRAw_dd8xz8YN4U1LBAjH5w>
    <xmx:hnBuaBQt_GySbGqBCRi-pGUKe8ho0eM0xRm4djvWv4yi6sb7zMr4IA>
    <xmx:hnBuaLunhxrPme2IQ_aTjj7c9d53mFkVuD95r2TuTY3CeDb6Hz_Iow>
    <xmx:hnBuaHJyhdXHEGrjK8W1P7hnfxEhHws43T7SaBLfAY53vFG69qzv5A>
    <xmx:h3BuaLM7Pp7E4HWGZwTpEwkJ2RBVvbvKdZxaziwYfU8w9On7IV3srjQm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 55725700065; Wed,  9 Jul 2025 09:37:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2af2efebb1220e26
Date: Wed, 09 Jul 2025 15:36:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Charles Keepax" <ckeepax@opensource.cirrus.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Maciej Strozek" <mstrozek@opensource.cirrus.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Shuming Fan" <shumingf@realtek.com>,
 "Bard Liao" <yung-chuan.liao@linux.intel.com>,
 "Pierre-Louis Bossart" <pierre-louis.bossart@linux.dev>,
 "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org
Message-Id: <f0275a4c-9801-4288-91fd-e28aa4bc5b7e@app.fastmail.com>
In-Reply-To: <aG5iwy6j3rR0YdPy@opensource.cirrus.com>
References: <20250708184618.3585473-1-arnd@kernel.org>
 <aG5iwy6j3rR0YdPy@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: SDCA: fix HID dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 9, 2025, at 14:38, Charles Keepax wrote:
> On Tue, Jul 08, 2025 at 08:46:06PM +0200, Arnd Bergmann wrote:
>>  
>>  config SND_SOC_SDCA_HID
>> -	tristate "SDCA HID support"
>> +	bool "SDCA HID support"
>>  	depends on SND_SOC_SDCA && HID
>> +	depends on HID=y || HID=SND_SOC_SDCA
>
> Does it perhaps make more sense to add a (HID || !HID) dependency
> on SND_SOC_SDCA and leave the dependencies here alone? I feel
> like that lets the Kconfig figure out the right settings for
> SND_SOC_SDCA automatically, rather than just disappearing the SDCA
> HID option when HID and SDCA are set incompatibly.

The problem is that SND_SOC_SDCA is not a user-visible option
but instead gets selected by SND_SOC_ACPI_INTEL_SDCA_QUIRKS,
which itself gets selected indirectly.

It could work, but then the 'depends on HID || !HID' would
need to be under SND_SST_ATOM_HIFI2_PLATFORM_ACPI and anything
else that might select SND_SOC_ACPI_INTEL_MATCH,
SND_SOC_ACPI_INTEL_SDCA_QUIRKS, or SND_SOC_SDCA in the future.

     Arnd

