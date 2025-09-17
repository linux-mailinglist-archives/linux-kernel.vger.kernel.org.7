Return-Path: <linux-kernel+bounces-820732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94516B7EA93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD56D7B0A48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917941A3167;
	Wed, 17 Sep 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="q1DN7DKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jttXHiCH"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451A2F7ABF;
	Wed, 17 Sep 2025 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113599; cv=none; b=Ycv4Za6wVlFrl0/rZB2ehpiDE031rksNtpvEq3hsA9mCk+sh/oFvl63DHAnNgWLyT1dVRztDMA10ovhwv5ure9jk8+mkvlmzRwLwi9T17cSq0+YYFoBAPPak+/CZrdxTY7LaNlqBsd7BKQiX3MBu1vBYVHm7EsJEgWUv4gwbF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113599; c=relaxed/simple;
	bh=SNw30TtYtjz3bJjJmSYVg/m9TlNMaQnm+dEAkA5BiG4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A3eVPKUwurHl53+fHbKtyflODndKMi5a97AC5sqUz95EXAMmM8wkRaZCkCcVfQ3oEFNvkd4Mn6EdAynkg0O5ZSl3yUvC8fRf5j3L4BvrgOGkY5PgB7Ga0RxPuR3GjXFTyd0tTqRUsBu6ADbvf5st2LetbJBdAdG+q9wdh55fKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=q1DN7DKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jttXHiCH; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17A997A00E5;
	Wed, 17 Sep 2025 08:53:15 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 08:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758113594;
	 x=1758199994; bh=jJDpsD5W7eR4GMzNsuaoxriBHq6EDK0mxwvo7xTskbk=; b=
	q1DN7DKaQgFit561Nw1FbBqlELihxV6Dk1eiyTRLS7lbGNhWC3t7sK5RbslZHQ4D
	qYe5zEZrCMiGvLoAX9igMsTqhLm55wEeVmZHFo7hhdWbSDJ0D0sX1nqaZHOux9yl
	MNRaUNagpsMxRvDzeOptgVs8me4XcpVLBJdF0IVKmDtVHia3HqQ0gEuUGqs2KLPH
	OW7bdFpy3srIERiGmNpCNDG6404jyo7jon9oq2seUCYYqpD73CT2nXhBrvoYDc2E
	0vpJWth2jP3fjHJnIYSraGH7drwaWj8OJbEGIMXM0kNXOACecZXtJdjXnJwkePP+
	6oRJ4hBh3sPvRtwPZlbRTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758113594; x=
	1758199994; bh=jJDpsD5W7eR4GMzNsuaoxriBHq6EDK0mxwvo7xTskbk=; b=j
	ttXHiCH9Zcgg+Dh5DzPnDIxu3tfg676RS5ME0MtGHflR6ige84aYHVrJRlkiwFlA
	rkZkejuZqZ3CjWrnAKg05LnZlc/kw8sbaKgDepumyCCGl3of6adzfKYPkK2mrETs
	oBk8FS6WIx46hWWmnGUogVrrCuu6lCATn5rBLMnzpfFW+7O7YoI8Isl7d5C4TyX9
	Wz9+Eqg3zOz9HttsOZAd8vVMJtOlgNh9DF8tNs6mRRlnFmf1ULbAdPzkBcKYrdm7
	9tywJLj2PDruDzxnaqT2R5V3mXM77OH1oByajcOe3sqOrK+8bQswrussZt++HUJ1
	XNwjW1Hz7seXTOR14oxAA==
X-ME-Sender: <xms:Oq_KaOfa-Z9vOxsGkcASJZyBd5eBWyrBgRwgZNJzLLqk0N6q_Ke1dg>
    <xme:Oq_KaIPa9_6eDdG1u9JNhnUkjJjKc7C7gTsRYTxrXbAnUjdTNAguoM9HnQf_eJVF6
    L1XDdzDWmro87n14kU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhutggrrdifvghishhssehfrghirhhphhhonhgvrdgtohhmpdhrtg
    hpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhoohhnihgv
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlih
    hnrghrohdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopehpvghrvgigsehpvghrvgigrdgtiidprhgtphhtth
    hopehquhhitggpfigthhgvnhhgsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepthhi
    figrihesshhushgvrdgtohhmpdhrtghpthhtohepthhifigrihesshhushgvrdguvg
X-ME-Proxy: <xmx:Oq_KaJ3qk_sUQerlkdhDIhinfcdtHmLHlDw8VENdoLzM2nGdvDtjvg>
    <xmx:Oq_KaPQNS0FzaZwYF7aVo9ohYrWiAuJzRwgAmdkK2yjnLwtwFCcbKw>
    <xmx:Oq_KaMmTn23fsgjLLjbnSrG0sgy5YLDgoJgIDdVdIqZ0dIYaQ8zmZw>
    <xmx:Oq_KaAO8VV8ZSHYtEDaOBdF9xIltOZV6IDHHe0oOH9x79eZUBWWOzg>
    <xmx:Oq_KaIfe3H_s6Fn-7DxjbVOP0LD3JLnkjdyIr9-cwal1-0CazHtVBMi5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4A40A700065; Wed, 17 Sep 2025 08:53:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ-KNcceaLbJ
Date: Wed, 17 Sep 2025 14:52:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Takashi Iwai" <tiwai@suse.de>, "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Wesley Cheng" <quic_wcheng@quicinc.com>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <548b20d2-70f5-403c-821c-630c1e605b34@app.fastmail.com>
In-Reply-To: <87v7lhwkf2.wl-tiwai@suse.de>
References: <20250513123442.159936-1-arnd@kernel.org>
 <20250513123442.159936-4-arnd@kernel.org>
 <DBR2363A95M1.L9XBNC003490@fairphone.com> <87v7n72pg0.wl-tiwai@suse.de>
 <DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com> <87ms8j2on6.wl-tiwai@suse.de>
 <DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com> <87bjnpqe45.wl-tiwai@suse.de>
 <a2a6843f-7e03-4b7e-b5fc-415ac9fc6621@app.fastmail.com>
 <DCU39JVDVFAG.2EOCQ37KAS3N0@fairphone.com> <87o6raxtu9.wl-tiwai@suse.de>
 <DCUXFIZ5KRCU.3JANM98BSE8SE@fairphone.com> <87v7lhwkf2.wl-tiwai@suse.de>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space confusion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 17, 2025, at 10:30, Takashi Iwai wrote:
> On Wed, 17 Sep 2025 10:19:23 +0200,
>> >> 
>> >> Are you planning to post this as a proper patch? It's a bit late in the
>> >> 6.17 cycle already but good to still get this fixed for final release.

I was expecting your earlier suggestion (without my experimental
changes) to get merged for 6.17.

>> Should that code be removed with the new code now?
>
> Yes, please try the revised patch below.

This version looks good to me, thanks for following up,
and sorry if I caused you extra work.

Acked-by: Arnd Bergmann <arnd@arndb.de>

