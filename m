Return-Path: <linux-kernel+bounces-888003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3BC398C7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F0C1A228A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B729B229;
	Thu,  6 Nov 2025 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="guwO+1W7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z1Nlzm+y"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BB1C1F02
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417086; cv=none; b=RCQgACfkCeTu5hNAS/FReex48EsoRzLcDHLZR49SWHm0Zp/dIFS4OJCaJePWqhWhl8Hh00sWKqVeYAwQrZcxGApm2We/AUJUpns7bPy7fnBGG/Z+ISZMZYfRRMTXz3RTIebLMhdl3BX3Kn1NPImWLbuAzNK2QleuI4tezyHSXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417086; c=relaxed/simple;
	bh=ITMyoDZfdEphSpBbeud4XoxdjOe6Zpo0J/Mho2bg06s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jwrmf6cBQURp2A/BQnNNsKcCmX22K8ATBeL60J4wW176PxOTyQyVk88nzlk+l9Dq+yX0d2oIJ1FGLl9A1YjNXhlaag4hDI23trWIfH8nyDjoMEyXeuDFW4o+yiJONBNcL4zM8IB7SnPdDD7Oqrm5K+8dweXNPobd1R8imwWuW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=guwO+1W7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z1Nlzm+y; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 76C721D00158;
	Thu,  6 Nov 2025 03:18:02 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 06 Nov 2025 03:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762417082;
	 x=1762503482; bh=TqgU2VcotITnPckxbq7cMlD+VCAh1WiNPNxsRuiwdPU=; b=
	guwO+1W7n7qraD/nSb8TG7dM+89LhcFjz794vvWxX5gLWxQzU3p04/zvjHG6no9/
	y119HR2k6RZhyzmzf+wO5b/iFSSJS9twGfEF5fCGvs6ftkJqhQTXLeOtuacS88Lf
	diQfZ7aSPQb2D8Wt9oHPlfaZtR8MTzitcr61mtM3KHAhPznm9y3HSjGxDDYkOxpZ
	2IFHiLYFj8kSwT4TBpzmbVKOiSmFYDEWco9zrYv/dL+U0k9lNqlpG5kv3qGjMT2+
	A7St4R7cN1fGVYdQutCv5HiXHQBhtTA5X+zPXLfVLOGl8dP/mAFqVD+uY2vwg+Wa
	IFrBfmaXjQT4LZFhr8wCRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762417082; x=
	1762503482; bh=TqgU2VcotITnPckxbq7cMlD+VCAh1WiNPNxsRuiwdPU=; b=z
	1Nlzm+ymSGpuZ1ZGg8WYGaU7iveX0OuNTBKy1ZHTP+b8mRLmyma2D2cxYWuQnDVw
	df/1f6y9Rv4J9Q/MpNN2Y19LnLmYpPVhheGVqbqMtgS00Wu4ugFZ5kvD0HQM4mWW
	xRi078MDveLKodQNjHWdEh8vdMt68FUyxHEsyvwjGwWoH2YQ4qThlRe40969GbVG
	Op5lNjkSZ1h6fUp9VU6YYKk37f37zjH097HF7oZbd5duVvg89MxqEToEHVQ8GHiU
	1hcLew7f90v/nrnGsrdQcNLYwgx1gNRuN3NMkBd/JQA1FKsbUZFIYcsKDc1xAtO2
	lbuq/seg7PpRQGijMoGzA==
X-ME-Sender: <xms:uVkMaR82EzIasp4v9wNwr92ejZJ41FXckApuhQjb4QSCNLYf1X58EA>
    <xme:uVkMaQi58DY89dkriYtaIky3G_sQVp9F61pfE_k_9hzVH7zQlASLwy-Qfvt0HHVyF
    GeTOy-e_PZBGaTJ2djmgsC6e_iuKyHwNdYanhJUE2oTZG5LBVuFH5N3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepveehfffhffekkefhkeeljeegledtgedvheehteejgeelieeugedujeejveduhfet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphhinhhtuhdrphhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgvrhhnvghlnhgvfigsihgvsheskhgvrhhnvghlnhgvfigsihgvshdrohhrghdprhgt
    phhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpth
    htohepshgrnhhgrghnrghkrgesshhiugguhhdrmhgvpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uVkMaSgwW_4_Xkumubn62TxNyCyrjVX1gkGjCaekpbuceVsa5O-bXA>
    <xmx:uVkMaQIuDYSn6OBwL5dPhoynMK6lxa-Tw0tv3w5d8HP8vQgm2rtoLA>
    <xmx:uVkMaZG8xjpkTBiRBbNM145nYyejg_8qoizlfOjAm_ufgo79dqE0Xg>
    <xmx:uVkMacTX7X0BQKoMRsfCLLenECDuVIuajg9PvxmcgnX0sT8PL2q3Hw>
    <xmx:ulkMaUFjt1lIN4cwe79VgWpiPXNYCPIwaB1oR98uxTQMvkNPzmmFZ6i4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B1B3E700054; Thu,  6 Nov 2025 03:18:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADbfFBy_oOaZ
Date: Thu, 06 Nov 2025 09:17:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Pintu Kumar Agarwal" <pintu.ping@gmail.com>
Cc: "Siddh Raman Pant" <sanganaka@siddh.me>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 kernelnewbies <kernelnewbies@kernelnewbies.org>,
 "Neil Armstrong" <neil.armstrong@linaro.org>
Message-Id: <0fe1ce84-b7b2-4c37-a94a-80ddd7339105@app.fastmail.com>
In-Reply-To: 
 <CAOuPNLh5O0YuRi6=oOSCbaH0zy-kkKUcD__G0Ncw5yAFtko7=Q@mail.gmail.com>
References: 
 <CAOuPNLh4R=H0BfQ4f13woGzc82jX9LGB+kxAGeGVkhwYqKcg4w@mail.gmail.com>
 <19a481a7843.53422ba121754.4867625372707455852@siddh.me>
 <CAOuPNLhMcPJ_vkvyDKTW1c4TcSYusrzrAdu8khazHoy3txJGDw@mail.gmail.com>
 <c40a0a35-ac43-4079-80ca-361bc8c9ae8a@app.fastmail.com>
 <CAOuPNLh5O0YuRi6=oOSCbaH0zy-kkKUcD__G0Ncw5yAFtko7=Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re:_=C2=A0Query:_Y2038_patch_series_for_3.18_Kernel?=
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 5, 2025, at 10:47, Pintu Kumar Agarwal wrote:
> On Tue, 4 Nov 2025 at 15:18, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Which chip exactly are you using?
> This request is for one of the legacy QC MDM 9K chipset.

Ah, I see. Support for those was never fully merged, so it's
much harder to upgrade than other platforms, especially
if you need the modem driver to work.

We do have some support for the newer sdx55/sdxx65 chips,
and much more rudimentary support for mdm9607 and mdm9615
(without modem) in mainline, but since we've never had a
fully supported board use the older chips I would not expect
them to work without additional bugfixes and a rebase of
the missing drivers.

There is of course a chance that you may get them to work
in a way that does not rely on knowing the time. If you
don't have (or use) and RTC and the system time is always
set to Jan 1 1970 on boot, this would technically work
indefinitely. Running a 3.18 kernel is obviously a bad idea
for a number of other reasons.

     Arnd

