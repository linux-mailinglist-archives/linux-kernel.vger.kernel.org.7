Return-Path: <linux-kernel+bounces-890433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886EC400A3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D85F14E9E33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554B2C15A0;
	Fri,  7 Nov 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="W8Ho/N5s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U14+gSI+"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2397F2D46BD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520932; cv=none; b=OpEjdTj+tVXHLqcWUmUL2eSLhDpxEMYJcGE9n8RhP2SnIQl65iwLUqgOf9vAmjQFrckFLuSv9JKcb+NwOIGxuiwuAgfaesC8A+rEmlKNJOlsLoCrBnpG4gP7nRiYhJBlxkWLk746MKmdRhnZTx9Sm8lQ90KjwuoPUhQCWhtMX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520932; c=relaxed/simple;
	bh=94f0bHowDoyXW4zroT0w27Z0xAqxOJaWsQnFvbQvqeg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MPKxpf0/Z3woj0P/2p+lwfz47KrXYScACQA/MnY8i2n8ud8wbNpGkfW/imHqSq0Dx//E48WRKCG4jylP7NjGuWkiYYX8F1wYtRs0wUcIHZUvZS3tAwWBxJnAzkaRyUMtiJEpRyp4/UfihTmRwASTSbe7DsU32GdycaRiNeIOHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=W8Ho/N5s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U14+gSI+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44A9E1400183;
	Fri,  7 Nov 2025 08:08:47 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 08:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762520927;
	 x=1762607327; bh=k25cBgjI8DCYqxj5le4xUj5GQC89TK0sK1KYOn2oFKA=; b=
	W8Ho/N5sSpnKR+o9dH0s9fxBaOKEUWjHNCPunqol9jvvTfg+evChx+bdUutpuXyh
	kFbFJ/mZcLQnS+lL7ulwNvblJwSw3p0iX+S4XhswSYhpb8IsSWhb9AbhaQmtNZQk
	kJJAWIS/SmVzZF/iruBOEuzYdLak3etVnEAGHDu3ITQMbWfC7tyWnNqC3pJqSTVZ
	e0cxxLQ+yvc88F3fmqFHRVmWUh3wAbDrshsa+RvrlJYe1xSl1tEmnTRD2cIAkWxl
	+fdN35NoXS6+gZuXvD3BUf8BNG4DHk635eA4chFwuIn5AIFOOq2bv+WlvsB9m+10
	C9QUEw89cyQ8nCx7DKRu5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762520927; x=
	1762607327; bh=k25cBgjI8DCYqxj5le4xUj5GQC89TK0sK1KYOn2oFKA=; b=U
	14+gSI+75VB98v1wajE6c8v0SqCQOrSdhAzCefw/xEsR3Vesrj+NPSNK+7oxt+vO
	p/AWHQaHMGW4NanhUL3iwdbnZuEUGSSa6HO7sl2byehOiJRtwm+3JI7Jva+cKH3n
	BjPcwgnZa/FvxpLwf4uuspngC3XEV8LlqwojLmxRcHlZF5YYr5FGhOi2ta+VrwNI
	BJv6Ay5Wt61N3/BvhHkBXWVyeAd28xulbss4DJPclTRY4pRpVd4IaFDNidBPiO1r
	AXuSFwqxQ3ST0wg8Cb9WLkkVTDD+FR8K53GjHZUT+GPmIrAY3yYsC8G+ZxV4/Mch
	ndRRRi8TEQ6e0S/Rc1xvQ==
X-ME-Sender: <xms:Xu8NaQ0C2eybteYKM-Sngm9Tmzb30YeCCtabJKty1VL5vcnvBDOiyg>
    <xme:Xu8NaV5hyNV1LP57dpOHOduYx97gZmRJzdAj_zgK_9BUo2LUewJYTqX5Q7MIpmp_9
    hfOEtdxrLan2LvI9__LHrygWiZM4l2fI15rBFQo7n2WGWbNIITVXS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeljeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephhhuihdrfigrnhhgsegtrghnohhnihgtrghlrdgtohhmpdhrtghpth
    htohepfhhlohhrvghnthdrthhrihhnhhdqthhhrghisegtshdqshhophhrrghsthgvrhhi
    rgdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhroh
    huphdrvghupdhrtghpthhtohepmhifrghllhgvsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopegrlhgvgigrnhguvghrrdhsvhgvrhgulhhinhesshhivghmvghnshdrtghomhdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Xu8NaVMKWKjxQK1D6JrLRiQSAWN5I5pMZP83U5KYAKDDkTtQ3lGmkw>
    <xmx:Xu8NaYpl9tNU1hpIhurzx3BledHHaP7_MAYBLR50Q5S6TZtDA1a6ig>
    <xmx:Xu8NaScMEC6qfsmq1zbvdclHEcwWdRT-Oex8u_7cYjf6TjM8zAb32A>
    <xmx:Xu8NaWSWAWDT2ImNH9rIfRoBeEKp1e6fqZIyadbP6G5qUVzWURAuVw>
    <xmx:X-8Nafnb7Ov-_I0qyNy-FntOFvKK2ibcefmn0h5q_7UbseJNB6_vFTsS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3308B700063; Fri,  7 Nov 2025 08:08:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Adbv6qxzdhws
Date: Fri, 07 Nov 2025 14:08:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc: "Hui Wang" <hui.wang@canonical.com>, "Michael Walle" <mwalle@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "florent.trinh-thai@cs-soprasteria.com" <florent.trinh-thai@cs-soprasteria.com>
Message-Id: <3e265b9e-c0f4-452d-b1da-3c708517e30a@app.fastmail.com>
In-Reply-To: <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
 <2025110513-manliness-repayment-d005@gregkh>
 <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
 <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 7, 2025, at 12:49, Sverdlin, Alexander wrote:

> Christophe, while I'm trying to get my hands on a PPC32 HW similar to 
> yours, would
> you be able to test with CONFIG_DMA_API_DEBUG=y? The fact the KASAN 
> doesn't detect
> anything after the fix to spi-fsl-cpm you've mentioned makes me think 
> the corruption
> is external to CPU core? Will you post you fix to fsl-cpm code?

I had a look over the patch and don't didn't see anything extra
suspicious, but I wonder if this is possibly a problem with a DMA
to stack, as Christophe mentioned this showing up on a system with
VMAP_STACK=y.

If for some reason the original driver used to bounce the data while
the current version attempts a DMA, that may lead to arbitrary
data corruption from the invalid virt_to_phys(vmalloc_pointer)
conversion.

The opposite might be true as well: if the 'val' pointer passed
into the read/write functions was previously detected as
needing a bounce buffer down the stack (spi core or spi
master driver) but now the added 'bounce' allocation gets
passed directly into a dma engine, that may also fail if the
GFP_KERNEL allocation is not sufficient for the range or
alignment requirements of the DMA master.

Christophe, do you know the CPM DMA has any restrictions
there, e.g. needing a GFP_DMA allocation?

     Arnd

