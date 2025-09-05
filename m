Return-Path: <linux-kernel+bounces-802812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1650B45747
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 940994E4B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FAF34DCD8;
	Fri,  5 Sep 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AEiOjImT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1sbLv0E"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD034AAFB;
	Fri,  5 Sep 2025 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074130; cv=none; b=gmSm/d/gE0NIe3gB89G7pROR4MnosINJG1zMPiRo+rhJtx/nh9UTQtU7uzqKahLcuSPDINkLw6AbRXAnJoulLoOMovQTcZBfCyJ9wCIDq2x4+Pk8hbvWr0KdRyJBql2TCyIMP1wRmM3QZOcOlDfx1WHRSAnmzXkV1UF1DAiiGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074130; c=relaxed/simple;
	bh=f+rJAPv41Mb11Skbp4mCyfxSC8DpU6046y67tsjA+zQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KOSewkGSQHJRa+c+m1z9/iEwvUizwrz2TMrXR4B6QTvINA4uuM6QhRyRzUrm/jD35D8T+Wq1YezFoGEKFE2D3mV8QMt1rsVvS4n8igUBb0tQNvgP3epaL/U6cnExxdo8ndwxBZKrjuE1TTM09fqOoOMGSYg+e64sVg3c2E8cCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AEiOjImT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1sbLv0E; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F267DEC009E;
	Fri,  5 Sep 2025 08:08:46 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 08:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757074126;
	 x=1757160526; bh=5Lmq/7r9v/uNcdQKPUNBveu5dDJMDCCvrFqqy0YICxM=; b=
	AEiOjImTCxAzXjSa8gzZurKeGNPDlH1Jv81SoyGWqf/6ohmKsf97cD67M3ja4o7N
	WaX5+tmU5w8HRaddu0Y21Sri+hMm7aRCGyULo2Rfu1yoVNGfHVbdyoGBZOk0eVsS
	Wgw93ZS65IAlH7U+6uMeExsevM/j6fPQ7hDGvsuhysPtYrvUkwqHGDyTXPcGN4uo
	q8bL/KfPYODnzmd8e6aNLMgh3fr3+8YNjRtZ0IVBbGBO/mUkaVwaHPx0ujzjQ9x4
	yu2HqOBnC4CDt550dXwfznHI6NZ19n2GYFHLdP3La0AIlY6VGV3kR1HLyqh8V7lw
	Ivrpc275rQN+6ooo2rEzaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757074126; x=
	1757160526; bh=5Lmq/7r9v/uNcdQKPUNBveu5dDJMDCCvrFqqy0YICxM=; b=j
	1sbLv0EuoTdvPCYDcViQ59xaEog7bQfAnLoQczmsSCXFMfi4txRMTfff0u4nh9QZ
	hfWpIlATeCefRQqbnGBBViLsxpanCprXvDIh/65t/ih8wwE3FJYm/S06ubOYorUn
	TS2TjgVqLmwUPFTz4ZS14+tj8E3VegNuXr7B5PIzAi/a7rDGo5JidQA7ZgjxJ06b
	nPI0kwRIDU56Vm0uLmmz7OErrsFpGCTVyGOrGjjXYytKlFGe3iBjShYk/2IZA2LD
	LERXMInEci4r6sxkS/g8suV1BiY593wdscrl46u4gStx/hAjLZs1RGaAAV9fhX0t
	vA0JgmnsSotqhM2FCbTNg==
X-ME-Sender: <xms:ztK6aO-zxnxyrJzzN8kRWB-cQOKU18-bOO5Ov31P61COw-UahlwZYw>
    <xme:ztK6aOtyjRAiipIFcJkRJHNIknySCTF5SpvebhqkcEPDxSHrjxM5GkitpVIF_Nhxu
    A1K3vsqjrFjJx81Y9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehluhgtrgdrfigvihhsshesfhgrihhrphhhohhnvgdrtghomhdprhgtph
    htthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinh
    grrhhordhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipdhrtghpthhtoh
    epqhhuihgtpgiftghhvghnghesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehtihif
    rghisehsuhhsvgdrtghomhdprhgtphhtthhopehtihifrghisehsuhhsvgdruggv
X-ME-Proxy: <xmx:ztK6aKUkJTmOuLrJLga4jSqy_10oAkMCMKGEIeqOkKtk-2krU6uEzQ>
    <xmx:ztK6aFzzo2GgBBydLdMisEY3oqd6SeyQokeicJr1ZhjFd8N0Eyd7Pg>
    <xmx:ztK6aBGxdL1MMuX8rzg5wX0xrhU1No8BWETYRqxL5rJIGa33mdIlng>
    <xmx:ztK6aKvjwUPyCnZv9TCMzXjxWVZ9C2PrgRhGUZ4meggGPhefHqNS6g>
    <xmx:ztK6aBgJa7xXWKIpzbuS36Vpj9DQWQqT7Bl822J5bYeQSvoItd2g4hnN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18120700065; Fri,  5 Sep 2025 08:08:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ-KNcceaLbJ
Date: Fri, 05 Sep 2025 14:08:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Takashi Iwai" <tiwai@suse.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Wesley Cheng" <quic_wcheng@quicinc.com>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <246834be-9e72-432e-86e4-e1c68262e710@app.fastmail.com>
In-Reply-To: <DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com>
References: <20250513123442.159936-1-arnd@kernel.org>
 <20250513123442.159936-4-arnd@kernel.org>
 <DBR2363A95M1.L9XBNC003490@fairphone.com> <87v7n72pg0.wl-tiwai@suse.de>
 <DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com> <87ms8j2on6.wl-tiwai@suse.de>
 <DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space confusion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 5, 2025, at 13:47, Luca Weiss wrote:
> On Fri Aug 1, 2025 at 2:49 PM CEST, Takashi Iwai wrote:
>> On Fri, 01 Aug 2025 14:35:27 +0200,
>>> On Fri Aug 1, 2025 at 2:31 PM CEST, Takashi Iwai wrote:
>>> > On Fri, 01 Aug 2025 13:31:42 +0200,
>>> >> On Tue May 13, 2025 at 2:34 PM CEST, Arnd Bergmann wrote:
>>> >> >
>>> >> > Make this more explicit by pulling the conversion out first
>>> >> > and warning if it is not part of the linear map, and using the
>>> >> > actual physical address to map into the iommu in place of the
>>> >> > dma address that may already be iommu-mapped into the usb host.
>>> >> 
>>> >> This patch is breaking USB audio offloading on Qualcomm devices on 6.16,
>>> >> as tested on sm6350 and sc7280-based smartphones.
>>> >> 
>>> >> Let me know if I can be of any help to resolve this.
>>> >
>>> > I guess just dropping WARN_ON() would help?
>>> >
>>> > As far as I read the code, pa argument isn't used at all in
>>> > uaudio_iommu_map() unless as sgt is NULL.  In this case, sgt is never
>>> > NULL, hence the pa argument is just a placeholder.
>>> > That said, the whole xfer_buf_pa (and its sanity check) can be dropped
>>> > there.
>>> 
>>> Just the WARN splat is not the problem, it's actually failing
>>> afterwards. Without the patch it works as expected.
>>
>> That is, replace WARN_ON() with 0.
>>
>> 	if (0 /*WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))*/) {
>> 		ret = -ENXIO;
>> 		goto unmap_sync;
>> 	}
>
> Yes, that appears to work fine as well. Playback works again.
>

This does mean that the address returned from xfer_buf is not
a kernel address in the virtual map though, and converting it
through virt_to_phys() makes the pa undefined for
uaudio_iommu_map(). Can you print what that pa value
is that you get here, and where that sits in the address space?

    Arnd

