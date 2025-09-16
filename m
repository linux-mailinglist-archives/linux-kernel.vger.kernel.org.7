Return-Path: <linux-kernel+bounces-818447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B1FB591D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77977A1726
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65BB1E47B3;
	Tue, 16 Sep 2025 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RZI+e8Jm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdMynQOk"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4842A96
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014017; cv=none; b=iMPN7J1S2OhisP8GMu0EUKGOQ1cr5jwmxsK8JQioBczeLUaK0eO0KQFx0CfP4WcuIzBbRC7pXqnlub3l7fjduvyebf0fxEN4gAZ+na398/y5aoqQxanhbHiTGUURCiRGMadpeWfFoPJxubtzoGxeg1tHyTEKLtLBTVVzz5j4eps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014017; c=relaxed/simple;
	bh=htZ5QDlkwX0N/4KY3bJdPNAqEk2Chv8cn6FrjKf5IRU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Df3Hrh5vJc0os7c6Lgb8KrMVvr8tAWHoOXxwQIkkwvVE1rx7RMnobV7TQsbb6SOa52euLQ/a/C1saKWHxLpQhh7umkdgYzj29SD+czH7tnH1Q3s+w6InGDcDZsuR6jETeGYeUzbVEefRoKVrDMIHa1nnakhqzIo8awupYdF1Ug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RZI+e8Jm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GdMynQOk; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7D6C7A020A;
	Tue, 16 Sep 2025 05:13:33 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 16 Sep 2025 05:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758014013;
	 x=1758100413; bh=1OgYWMorWlEx85Gl8eJPGx4bP2k6bqHXQlySjRgSPhg=; b=
	RZI+e8JmSUmd+MgaXuqoWuj7f3IfGtutChgIepT1Be15uX8DwcQO9s8WQ3koYW81
	oX2RsRVu1V94Y431wW470lVFZ9yLrjSqGXPbuXJDeRzeYeLQmy70hDLoaToVTtqb
	eBfzaBOvJ8F6+OGh5bbWJLODABYTu5S+wGs3JFCVBqMMPkpIaPi2/JDGi5AnCara
	tG5wOn6J9FVyjQXAFvxJ10CQqBKiamyGOajv2icre7R5FH8mTYtvYvkUTK2H4b1w
	G+rWMUnZmQQ2tYsjYWp8FvpsI8WA0E8ogORRb94PZx+2FPmklYzFH7gO+OGIyaja
	WpnW228Qg/Xs2DG2a/y75A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758014013; x=
	1758100413; bh=1OgYWMorWlEx85Gl8eJPGx4bP2k6bqHXQlySjRgSPhg=; b=G
	dMynQOky3jd/4AvDeL1equvO2MMFmqe85lh8q1e69UY+ApCz9I8RJ0FQqOzGld3Y
	NfVVbtsq9FLkbkNMxFoJjvdjqU6H/+O6M9YTOX4hnYoHOMW50Ef6i2NY7IwaVlKi
	oTRA+Xt7DIYkgaeCqtPFZh67aA8nfdw6cYgKj91xr6dmOU6xkyx4NM1uy7UIHCHJ
	lCmtWYLaxrA8caW5vHYG8k+ZtR1O4y/UWS3BLrebLzUuUlYafmy5/vvG7a34sh/C
	TCN6Ck8S8ymR9ig6KuG+FfyVG8qP1kJlzmumIY5qFxyfTXEcB7IGYf5Lru/Ht4L7
	vyq1R9AWpY0DfmnREtK8A==
X-ME-Sender: <xms:PCrJaBp0JrOpVG_PG4r13VFj5rKw3cYPTg62p9PsK7586MwMvsKUVA>
    <xme:PCrJaDrnnK9PRxsZWcJhvWyZMkW5lGohGWBgN5D9phHraokEDAk-weMTJtACBRi_X
    elVCG4-E5tScS1k5b0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopeifsedufihtrdgvuhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlh
    gvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghn
    rdhiugdrrghupdhrtghpthhtohepohhffhhitghirghlthgvtghhfhhlrghshhihthesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrshhhsehhvgihqhhurghrkhdrtghomhdprhgt
    phhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprgifihhltghogiesfihilhgtohigqdhtvggthhdrtghomh
X-ME-Proxy: <xmx:PCrJaDKnVJ8NJ5VM4UwsMgrD457HryZ6M2dmkk4XT7k5RMbl4bZk_w>
    <xmx:PCrJaEDxd-q54vhPgMcuQLPdLq_GvdcTEialDf-h55aiSdeaIU5oKg>
    <xmx:PCrJaLftXYywb8MkAPAiv2wltbIGFHiSWxUiIrH92lSfvAeJRzU7qQ>
    <xmx:PCrJaL3QxH_oUveVZbLNJhaAMFig-4sj2kFN3bICj1T92uVM1SnHQQ>
    <xmx:PSrJaJx2HGsR6ai8Z5NQI7Hde7Bk50Z_tk5_8n4bq6b4FM8XvRA438ed>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71FFC70006A; Tue, 16 Sep 2025 05:13:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADclxERWIs8s
Date: Tue, 16 Sep 2025 11:13:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Willy Tarreau" <w@1wt.eu>
Cc: "Ash Logan" <ash@heyquark.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 officialTechflashYT@gmail.com, "A. Wilcox" <AWilcox@wilcox-tech.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>
Message-Id: <afb4527e-3958-4b04-9bbf-d48e80616aa0@app.fastmail.com>
In-Reply-To: <20250916070052.GA3616@1wt.eu>
References: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
 <432e049f-886d-4734-ad59-52569a796046@app.fastmail.com>
 <11e667d6-2210-47f0-a9ec-a134a60e138c@heyquark.com>
 <39164c56-78f8-4bac-acd2-a996149c1c57@app.fastmail.com>
 <20250916070052.GA3616@1wt.eu>
Subject: Re: 32-bit HIGHMEM and game console downstreams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 16, 2025, at 09:00, Willy Tarreau wrote:
> On Tue, Sep 16, 2025 at 08:20:35AM +0200, Arnd Bergmann wrote:
>> > The maintainer of that downstream claims to be able to boot modern 
>> > text-mode distros on the GameCube' 24MB, which I find really impressive!
>> 
>> On a simpler musl+busybox userland and even more feature reduced
>> kernel (no network, initramfs-only) I could get to ~10MB, but then it
>> doesn't really do anything besides showing a shell.
>
> When you build your systems from source and install only the necessary
> *files* (not packages) you can get much lower. Here's my reverse-proxy
> for example (aarch64):
>
>   $ df /
>   Filesystem     1K-blocks  Used Available Use% Mounted on
>   /dev/ram0          11520 11520         0 100% /

Yes, that was what I did in my busybox example, which used a tiny
initramfs in the end. Your ramdisk itself is already bigger than
my total 10MB RAM here, but then it also does one thing instead
of nothing.

    Arnd

