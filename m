Return-Path: <linux-kernel+bounces-729533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA09B03808
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9187ACDA6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88FE234973;
	Mon, 14 Jul 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb5x/Fju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C469230BC6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478345; cv=none; b=QJsw9DGisxczn2jFUn9NKX5mNTsuNNqFkKxaNkSqELHQov8/BKb4k5jkFrevksVeaYEoImvp3o5Yy6xmHHargj+gao+rHMJQAk5zBIlhEL02UCm6t5vwWXJ3/ewvIKEzFXqEu+q0Lv9/PmjKQ14uEvoQyXcNCCKWpqNCdYWKKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478345; c=relaxed/simple;
	bh=JLygtD+6Bzb59X1CqJTUgCd+8x6usPf2+L4NNuh6NO4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gtum5ZFlnxp7+35h70UzAIYJqt1A352o82/4nBhq3MTPoL2fazilm+LcaHaE4ppeZh5tSIaxMUxSAK8JTBLfVk+KbmQiXMKRFNuRmI12P4bRCybhGq/WmHrt4emhkTN2a2CXGHSm4pbDP1qWCiii1LPL/kCFEwFd/GwKhc1C4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb5x/Fju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FD7C4CEF5;
	Mon, 14 Jul 2025 07:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752478345;
	bh=JLygtD+6Bzb59X1CqJTUgCd+8x6usPf2+L4NNuh6NO4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Fb5x/Fju3CZ2kO8tu11MFHWmglzbFfHUSFZLj47TUPf7zKVsdOZQ/ARlFE1pnrQzx
	 jpSdnXu2yCLKRA0GLsbmZAFwBM7cLM3UMic8PUTqRnE19qTkmUKk99geHcfpDoKjqp
	 +cm0bWVWYaDCekNEUC49Rtub8oeNd9sMK/cs9NvqpCm4MUEOWrmKiQLITr7RuyTuo6
	 HEjfOnyo4e60ZtVSoYqlzb1PVLjTDmFqBHvFS+ubuaUkdAtUiYhnR+qtgI7jeVBBt3
	 C4+tG31JJw5nh2I3YEvtpO/pVr+4aYYJRsIFHkA4XcF+vVBHgZ4zRftN+4CZ/jrcmw
	 1Ti1YM/pqoKog==
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD5FAF40069;
	Mon, 14 Jul 2025 03:32:20 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 14 Jul 2025 03:32:20 -0400
X-ME-Sender: <xms:hLJ0aKla-AnPJiaZ3mBAJZX_KO01gHIecuN4Lsyn2bzFFR8zpl8Ogg>
    <xme:hLJ0aB2M9MmMe3ednOzR-tZayzg3_smkNX9YziyICoKJFOkrdmUAuoch5UgaOa-oc
    j-S83eGJbAvhp5_JPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedtudeikeeggeefkefhudfhlefh
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddvgedq
    vdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggvpd
    hnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggv
    vheslhhunhhnrdgthhdprhgtphhtthhopehmvghnghihuhgrnhhlohhusehnvghtqdhsfi
    hifhhtrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehjihgrfigvnhifuhesthhruhhsthhnvghtihgtrdgtohhm
X-ME-Proxy: <xmx:hLJ0aJ-yqFbxVVMjFnHHARSmFHsE-bpCFWs3jzRgcVAoFFt0gOAGBA>
    <xmx:hLJ0aM4CrtJTMkgVs0pLjbrrwhtRYXOntIglFlTLb83BfcW6HXOR8w>
    <xmx:hLJ0aJuwtQEDruo1LaSsJxavCgtNBkwR6BXxyxVPTifzgGTVIvz1TA>
    <xmx:hLJ0aG2tPPjW6-WKhue13PINWbCFws8wqdTuTbfMxH1TT_BE7KkLGw>
    <xmx:hLJ0aKoC0M6mFxJaSoMR6OE94OXkatBB5lgw72isYsxNT87NJR91SjDR>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B265B700065; Mon, 14 Jul 2025 03:32:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf7a06b27ed897eb3
Date: Mon, 14 Jul 2025 09:32:00 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Simon Horman" <horms@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Jiawen Wu" <jiawenwu@trustnetic.com>,
 "Mengyuan Lou" <mengyuanlou@net-swift.com>, Netdev <netdev@vger.kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Message-Id: <b81a3d29-fc64-43af-839c-0d1d14dc55a0@app.fastmail.com>
In-Reply-To: <20250712153052.GF721198@horms.kernel.org>
References: <20250712055856.1732094-1-rdunlap@infradead.org>
 <20250712153052.GF721198@horms.kernel.org>
Subject: Re: [PATCH v2 net-next] net: wangxun: fix VF drivers Kconfig dependencies and
 help text
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Jul 12, 2025, at 17:30, Simon Horman wrote:

>> v2: also drop PHYLINK for TXGBEVF, suggested by Jiawen Wu
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> Arnd (CCed) has also posted a patch [1] for the unmet dependencies / build
> errors portion of this patch. My 2c worth would be to take Arnd's patch and
> for Randy then follow-up with an updated version of his patch with the
> extra bits in it. But I don't feel strongly about this.

Sounds fine to me. I think we need another patch for the PHYLINK
dependency, as the current version in linux-next breaks with LIBWX=y
in combination with PHYLINK=m:

wx_ethtool.c:(.text+0xb40): undefined reference to `phylink_ethtool_ksettings_get'
/home/arnd/cross/arm64/gcc-12.5.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_link_ksettings':
wx_ethtool.c:(.text+0xb9c): undefined reference to `phylink_ethtool_ksettings_set'
/home/arnd/cross/arm64/gcc-12.5.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_pauseparam':
wx_ethtool.c:(.text+0xc10): undefined reference to `phylink_ethtool_set_pauseparam'
/home/arnd/cross/arm64/gcc-12.5.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_pauseparam':

Randy's patch removes one 'select PHYLINK', which would make that
configuration slightly more likely to happen. The easiest workaround
would probably be

--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -20,6 +20,7 @@ config LIBWX
        tristate
        depends on PTP_1588_CLOCK_OPTIONAL
        select PAGE_POOL
+       select PHYLINK
        help
        Common library for Wangxun(R) Ethernet drivers.


    Arnd

