Return-Path: <linux-kernel+bounces-803138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D62B45AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05DF4852C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1613680BC;
	Fri,  5 Sep 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rOcsPLlk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2FickLW"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1705072633;
	Fri,  5 Sep 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083888; cv=none; b=gVs+pp4gk9/BcYv7vhuFr34xdb4ePgDCylpWZJ9Z1vJ9pJryMuWot0THfGWUNBn9TzgOjwM8rJmZEnE3JMBC8Ck6gC80ngULwwEm6tJ/RwJzU/mOx2A+F9sW4yeRvDGyiY1xwhGdgqNdnu+n5swioB0czp6lQDYIAYseltnXGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083888; c=relaxed/simple;
	bh=Th39r3re/CWiQX7cW/EKDLPanCgXrZ2wFojCl8A0tk4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D4F/+973LwFQ+09Qs6frfkNsBGg3BnDv9M2YJ0iYhb4v80OlqcTUUNlijCw4LfxQPCxnI6xgxXATAWkoyaYEyDjq0E3YDCSNmew54NqsawY5/THhL9vRNxZhRJ5E6u4X9NKO/lFhWldixGnxuzWB0yEgZau++hVRkFKwiFpASBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rOcsPLlk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2FickLW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EA5414000BB;
	Fri,  5 Sep 2025 10:51:25 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 10:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757083885;
	 x=1757170285; bh=KtzxdsiHKaCYqM1C6/vRI3hQpAxCejZ+2CkEkzEmUaw=; b=
	rOcsPLlkltf3YOS5IIYKhCbwONjtTjmPpZokpe0pTObmRYabuB3BErxz65yp3+At
	74f8LZ7bwWoUJR11jyOGUf1Py277ZxjThLRzJ1erXZfjCwSrxFYeBehrxx4Tga5k
	RviiMV032aQ2IKZK8rYThtKuS1pPj4Mlx8SlAKgF7TDQl5MHMBKrjzXyTZC9NfXm
	F+RvDPIoDdAev+5JqeLA1QP95qXFrYQ2ujOqHSssV8UANhl2qXUgjFdETjnNYgke
	04F5yP+wR1M4bfyCJXfSNoL80Bh6T74D+/wUBnVGDSk5wwXm1Pk2Q+0VEDz29l/O
	DbwDQrWkCQCBFZtcqm7ICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757083885; x=
	1757170285; bh=KtzxdsiHKaCYqM1C6/vRI3hQpAxCejZ+2CkEkzEmUaw=; b=S
	2FickLWJGWwgF7jaZtjWqup+NQ7MWn/kf1+9b966mlVyo0i/YvLLnMF+bU18eF2l
	mjaCHoqPO4dKnzmaOoRpM/VvtFDHcR391ukayg9tQjBdrn+YZy/bu6WuQ35IIMBW
	Xjrp8wFolIFmwdw6SRawqNQFMl4cWQoaD03VJbDCTO/eX3b6hed4jUHKnTrEmFSe
	g37dbzqbljBEiex6dthRFg2W0LS6HnsJKzxYs8RbQ+KQCCdL01FzRjDgQr5LYiRP
	8+q4NQnNoRuQrez8jttIA2UtwPo6NMGIdke7ZbzH71CBgs0eBvijMvlmuuGSktvg
	edq4uq0dKByUxX1Y7NsnA==
X-ME-Sender: <xms:7Pi6aCt95cgpSMi4oipL7l3fvNXFScIsUr0_5YE3H1xO5ffaWvSoJw>
    <xme:7Pi6aHcJxa0aWm9WcLSTH8FtXSIE_OJVziNPY5TD-Xgx_jl1IHka9g53ORyntzpkD
    HRyErux3aLI_0K5XN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeludekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:7Pi6aGF17vs1Kg2vzfrqEnPXSnEdattJRcPWLqPd-272AEs0jYZ14Q>
    <xmx:7Pi6aGg7NKWdyyCKKAsPOFBioXK0XEKxaHvwpXOlol81ia739a9N2Q>
    <xmx:7Pi6aC0mrvVT9AcHXdfjHFYvFqvRjvZ7BYvlO5AWjGjQmnl-iksgRg>
    <xmx:7Pi6aJfoPxHhP4LMBrituU-8nREamB6Ud9emnKX06hUVlx15LJ4jNw>
    <xmx:7fi6aAvfQwsUtpJQnVRwvX-XoqXDNLVfPZeKmfjHAmTiz8YDmHZSnoGE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 224C1700065; Fri,  5 Sep 2025 10:51:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ-KNcceaLbJ
Date: Fri, 05 Sep 2025 16:50:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Takashi Iwai" <tiwai@suse.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Wesley Cheng" <quic_wcheng@quicinc.com>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <5d5ab559-4d01-4092-a872-2d0bb6ac5ebf@app.fastmail.com>
In-Reply-To: <DCKW943MHDZO.3QJRSTIXDW1C4@fairphone.com>
References: <20250513123442.159936-1-arnd@kernel.org>
 <20250513123442.159936-4-arnd@kernel.org>
 <DBR2363A95M1.L9XBNC003490@fairphone.com> <87v7n72pg0.wl-tiwai@suse.de>
 <DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com> <87ms8j2on6.wl-tiwai@suse.de>
 <DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com>
 <246834be-9e72-432e-86e4-e1c68262e710@app.fastmail.com>
 <DCKW943MHDZO.3QJRSTIXDW1C4@fairphone.com>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space confusion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 5, 2025, at 15:17, Luca Weiss wrote:
> On Fri Sep 5, 2025 at 2:08 PM CEST, Arnd Bergmann wrote:
>> On Fri, Sep 5, 2025, at 13:47, Luca Weiss wrote:
>>
>> This does mean that the address returned from xfer_buf is not
>> a kernel address in the virtual map though, and converting it
>> through virt_to_phys() makes the pa undefined for
>> uaudio_iommu_map(). Can you print what that pa value
>> is that you get here, and where that sits in the address space?
>
> Adding a debug print gives me the following below.
>
>   dev_err(uaudio_qdev->data->dev, "xfer_buf_pa=%llx\n", xfer_buf_pa);
>
> Not sure what exactly you mean with "where that sits in the address
> space" and how I can figure that out.
>
> [  130.124938] q6usb-dai 
> 3000000.remoteproc:glink-edge:apr:service@4:usbd: 
> xfer_buf_pa=ffffba0486ea6000

Splitting the address in 16-bit chunks, this is

0x00ff.ffba0.486ea.6000

which is well outside of the 40-bit physical address space of
the CPU, which confirms that the virtual address was not in
the linear map at all, and probably it should not get passed
into dma_get_sgtable() either.

From what I can tell, this seems to correspond to a virtual
address in the vmalloc space instead, which is what happens
e.g. on arm64 when you ask for an allocation on a noncoherent
device.

It seems that dma_get_sgtable() does have a special case for
this and ends up walking the page table for it, which I
assume is what the driver is relying on, so Takashi's patch
seems fine but could use a few more comments.

It's still unclear to me why the driver has custom iommu
handling rather than just using dma_map_single() on buffers
allocated with dma_alloc_noncoherent or DMA_ATTR_NO_KERNEL_MAPPING
here, since it doesn't even use the virtual address.

      Arnd

