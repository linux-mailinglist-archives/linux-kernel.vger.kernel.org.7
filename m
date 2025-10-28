Return-Path: <linux-kernel+bounces-872861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A20C123B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF4F3A503A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648771F5435;
	Tue, 28 Oct 2025 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="FtGKA5E7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijBE9gLX"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52871BBBE5;
	Tue, 28 Oct 2025 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612183; cv=none; b=JI47o/0NmLmNQOXJ4nurLCuK69TCdQVJTvOWUsqIDI1QojVInDrt9X0CzcVyX2GCmTCw619t+frYJ0jlgPKDf2B+o1dcs20XOTpXeltkiT+LhwDyJnz/p9NvOrvSk9DhMdZTsdAQDSij3RoQk3TkUcLN085xVRXd41k9gYJDqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612183; c=relaxed/simple;
	bh=NpleAUsPv8tyterDaTQdtwZ7noPPJ/SFO2adnNZi/8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP2LQg1SLNO5d2qdH3vHDFISJDOJ7KcbPilL4OV2S2av/De4vH//dCNM3Sg5aahEP0VH5kBH+30Wi7779UAiBuz+hv56Nt17RrJ75EbQnADh2zVebVYG2QWz0jlpWhBqjk667EmZnkN6/kU7EasXzSMF6QM3MBXEp7ZFY17XXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=FtGKA5E7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijBE9gLX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC02C140010B;
	Mon, 27 Oct 2025 20:42:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 20:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761612178; x=
	1761698578; bh=b66zlWBixK0izKr3d/veWV/xQufa7n1aK2ZSQQUrqfc=; b=F
	tGKA5E7cuYj7NFqCYEJT2cRilNMEuVn92Z/Yq7Lj63XyVkj+NrBPF0hNqB/WLB6W
	FKSIPBl/4MpBf7+FHgma4bfx/n7U6TGeZIT5cvRAJ5h21yI3d/FkorVpD/QA9BL1
	7Yy+HmX3fhW8CIjrtq8yepZtZtViSwc3caEDaaSh7lf1mwxd4Mu52oQWJSX8WuWu
	bcqmpKuGlAXP1iETZcaCgDPO5pKDvuRKebaNdqR3RL0qjARamtDB5gQghoPTqkN0
	Cwk/9wOZY0JfGnXyAwslA7PL0HPlZhyHTgYuWpIbbOn3ERtXuj+wEx++ozYBIisu
	EiypnGSQwBE4i37RzMgOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761612178; x=1761698578; bh=b66zlWBixK0izKr3d/veWV/xQufa7n1aK2Z
	SQQUrqfc=; b=ijBE9gLXSz6jJpJQ9mRY1d43+YZBneNYpupck+u4R2oAVK2FWu/
	hh1xKO3PzyR9q0fFw4YafTDfybukutsJk3TGDVC5k+A85aZ3SGH65gn08LPYm9Fx
	B5KaVkV7ssUdnugshbVB9ljuEAh3NgiqW/bl0FP2KRKxrtCu8+qj0U+MSUF0jtA/
	rdLhsSJZyPzXsGGiM72J9lZCayJpd2t1/3eNAtM8bcBu4B/msP7fw1jhw9W1vTR/
	9gnhciG2pCcQoqxql285qbkLCj/nMB36Fg/6MVi+9D9ymF7MOoxwgj6ToyezxI2n
	MaHFFaQEM8WDbPHA5jMNBZJ6SgK8M0XgA2w==
X-ME-Sender: <xms:kREAadnZXwOeLjNbXeNPPOsoWn9wVJPDu46l7lbGtwWm7k5-FSSthQ>
    <xme:kREAaX6y_R1SyYGYtnXFNLDAw-UGRTfE8tdc6-0mCVj4kLxsCv8eSCP6y5p4ZgXmu
    S9G18-bSPd4TB-JGFUSdy3bVvCNd7dZzjQbuCmD6fCwapKd-CGTFvg>
X-ME-Received: <xmr:kREAaZ3xFhcpsQ1WzZNgGz0shWUs6aDLjjRV3w_ZwcLnXGr1HiH3GVBeapPuTlu36abp6Beyt_ShcTyFPx6XHhqkMqrvIDa5gz2S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheelgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeeiieet
    vdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhsthhrohiivg
    hksehophgvnhhsohhurhgtvgdrtghirhhruhhsrdgtohhmpdhrtghpthhtohepthhifigr
    ihesshhushgvrdguvgdprhgtphhtthhopehpvghrvgigsehpvghrvgigrdgtiidprhgtph
    htthhopegrlhhsrgdquggvvhgvlhesrghlshgrqdhprhhojhgvtghtrdhorhhgpdhrtghp
    thhtohepphgrthgthhgvshesohhpvghnshhouhhrtggvrdgtihhrrhhushdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhsohhunhgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kREAaaELfclbnZP2vhwTRYYq4JD70YUS6P3oxnyJkHEq-rcISSEqHw>
    <xmx:kREAaQgoW6Eu3Rx5wgvjxiDhhU5UpCtPh6QbNyvk_55QxyJnq1n3OQ>
    <xmx:kREAaVA531EsupR1fKS2GuuzwNWWQ6xnTL6yM8mfe7GdCKGTQ3oQcg>
    <xmx:kREAaaSXDCK5GtaaFu-UUdN6XhnZb37MzeEVGnItOwNjHdf9WwiHkA>
    <xmx:khEAaZ_DJlb-vWJWYikgArjlHmvu_9L8ntLeg3uat_c4nMGcDZ0rTsIK>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 20:42:55 -0400 (EDT)
Date: Tue, 28 Oct 2025 09:42:52 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: sound: Increase max size of components field
Message-ID: <20251028004252.GA553484@workstation.local>
Mail-Followup-To: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251023092754.84095-1-mstrozek@opensource.cirrus.com>
 <318f2ed3-57e6-495c-a773-4a094a3784cb@perex.cz>
 <87ikg03ecf.wl-tiwai@suse.de>
 <3cb73dae8e8ac1a29c856dc5c86064d568003316.camel@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cb73dae8e8ac1a29c856dc5c86064d568003316.camel@opensource.cirrus.com>

Hi,

On Mon, Oct 27, 2025 at 11:50:32AM +0000, Maciej Strozek wrote:
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index c302698fb685..7d53f6da59e2 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -1069,7 +1069,12 @@ struct snd_ctl_card_info {
>         unsigned char longname[80];
>         unsigned char reserved_[16];
>         unsigned char mixername[80];
> -       unsigned char components[256];
> +       unsigned char components[128];
> +};

Any approach to change the result of 'sizeof(struct snd_ctl_card_info)'
breaks ABI to userspace application. This is the reason that Jaroslav
addresses to the new PCM ioctl command. Unless, the userspace
application build with the UAPI header provided by the existing version
of Linux kernel does not work as expected in your version of Linux
kernel, in respect to the sound subsystem.


Regards

Takashi Sakamoto

