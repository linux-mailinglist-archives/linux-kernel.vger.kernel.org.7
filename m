Return-Path: <linux-kernel+bounces-766224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1FB24401
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271B21B664A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D522C15BF;
	Wed, 13 Aug 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORDi55VV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331E2D3720
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072996; cv=none; b=tCRUYgKb50b93Eo63PrOxoGvQEdNsUcNIcILL8Sp8pwjRQuoEwhdXtJeoLICFJURGu6fO2k+U2wQS0li+TvANZQFNGAeHzSJHmUhsoLqUB8q5QqUE9qtgMhfIBwG6433quh4HDBy0S64QEB7zLh/Hya/9vRrNOVFXOql71m9UeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072996; c=relaxed/simple;
	bh=HpmLvrPHn4sb+82i2lRKMP37vraziwdZWtrOQHjkRDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5MZpHtPWGO2falz9S6QoNzWvMIZYbyEBIfwhqwObm1s0zA4he3kRa6m1cf3P7bLUhGIh5puhwtHwbHOYFdROCt9GKK0cdlHy7wuFl4JZhetlfbC0WhMc+Y8IzMVrfb/YNe89QLXshLTt2FiPH3OreSlYV2BuZSGv23fFBgqYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORDi55VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAB9C4CEF6;
	Wed, 13 Aug 2025 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755072995;
	bh=HpmLvrPHn4sb+82i2lRKMP37vraziwdZWtrOQHjkRDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORDi55VV/ZNVcO+BDDBbUNdPDQ4dvpheQjVmcfEoVuZlTKAsigwAuFe3aK6iiojvE
	 4e7yBXbOSuInEvU3DZzOnHgmxyidkpd2fR1VedyKCLy/2M9YJm5g6+zM/3YVUzi/3s
	 ZTQNPd7940qOSAzTD/feGOR1giEHSdtN6r9j/rPGIG9z1EHCPml0PIqlj1XwUQHUxB
	 fMQRknDzG0KYY+ZvA2Zkq9nyfPFHEwwKcb9WX1fY/l7eme1JwAk2pAybgO0cxx6R9v
	 kLR5dNVPkTIfndpDdllDqMqsO8U2lzNmiOaKLRumseLrlYimGz5JhohWMNFrvUXxn4
	 tBUUPgExX1p2A==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id B8421F40067;
	Wed, 13 Aug 2025 04:16:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 04:16:32 -0400
X-ME-Sender: <xms:4EmcaJ9bYlqpENhWu9ZM3b1rkWpwlG0ejAGfN5hl5gpmWDsXJZb2dg>
    <xme:4EmcaENOzt1tVLSLCMXrultW8L17ql7E4FM4HK4IpxV0IwbEtdp1obf0VUusmmMyw
    IcwitAMdbROBw4JosY>
X-ME-Received: <xmr:4EmcaFQ0k6CLoJc_wiBIEX78Ie8QrsLWwJlSGdc_NpJQrnqaDtOjJI6MFkkG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepudejvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhgrtghivghjrdifihgvtgiiohhrqdhrvghtmhgrnhesihhnthgvlhdrtghomh
    dprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghr
    nhgusegrrhhnuggsrdguvgdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghlvghshhhsihhnghhhsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4EmcaG8rQsE8nkO8Pw7BXFUXXd-RiXJNyqApIZXatEwUdlY2ztWfjA>
    <xmx:4EmcaP1k2sWKIPsVnixXMBMnZq2BC4N6nxNUox2x8df5vJ19bCsHAA>
    <xmx:4EmcaIKL7gUAWTyNuo8HT5jw93fJosAdbDIZuVFUt4IZ5EQd4puIQA>
    <xmx:4EmcaN73ABzTnA_tXNVpp2lcwvZwZx0hbVCFteVB1zox2VpbNSuCPA>
    <xmx:4EmcaEjpfrJQy1TacPbbA7uC_HvJWGEvLn3o1pPc_tSJJSAJSSn_V_gA>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 04:16:31 -0400 (EDT)
Date: Wed, 13 Aug 2025 09:16:29 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: nathan@kernel.org, arnd@arndb.de, broonie@kernel.org,
 	Liam.Howlett@oracle.com, urezki@gmail.com, will@kernel.org,
 kaleshsingh@google.com, 	rppt@kernel.org, leitao@debian.org,
 coxu@redhat.com, surenb@google.com, 	akpm@linux-foundation.org,
 luto@kernel.org, jpoimboe@kernel.org, changyuanl@google.com,
 	hpa@zytor.com, dvyukov@google.com, corbet@lwn.net,
 vincenzo.frascino@arm.com, 	smostafa@google.com,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, 	andreyknvl@gmail.com,
 alexander.shishkin@linux.intel.com, thiago.bauermann@linaro.org,
 	catalin.marinas@arm.com, ryabinin.a.a@gmail.com, jan.kiszka@siemens.com,
 jbohac@suse.cz, 	dan.j.williams@intel.com, joel.granados@kernel.org,
 baohua@kernel.org, 	kevin.brodsky@arm.com, nicolas.schier@linux.dev,
 pcc@google.com, 	andriy.shevchenko@linux.intel.com, wei.liu@kernel.org,
 bp@alien8.de, ada.coupriediaz@arm.com, 	xin@zytor.com,
 pankaj.gupta@amd.com, vbabka@suse.cz, glider@google.com,
 	jgross@suse.com, kees@kernel.org, jhubbard@nvidia.com,
 joey.gouly@arm.com, 	ardb@kernel.org, thuth@redhat.com,
 pasha.tatashin@soleen.com, 	kristina.martsenko@arm.com,
 bigeasy@linutronix.de, lorenzo.stoakes@oracle.com,
 	jason.andryuk@amd.com, david@redhat.com, graf@amazon.com,
 wangkefeng.wang@huawei.com, 	ziy@nvidia.com, mark.rutland@arm.com,
 dave.hansen@linux.intel.com, 	samuel.holland@sifive.com,
 kbingham@kernel.org, trintaeoitogc@gmail.com,
 	scott@os.amperecomputing.com, justinstitt@google.com,
 kuan-ying.lee@canonical.com, 	maz@kernel.org, tglx@linutronix.de,
 samitolvanen@google.com, mhocko@suse.com,
 	nunodasneves@linux.microsoft.com, brgerst@gmail.com,
 willy@infradead.org, ubizjak@gmail.com, 	peterz@infradead.org,
 mingo@redhat.com, sohil.mehta@intel.com, linux-mm@kvack.org,
 	linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, 	llvm@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, 	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/18] kasan: x86: arm64: KASAN tag-based mode for x86
Message-ID: <mt3agowg6ghwhvcjqfgqgua3m3al566ewmvwvqkkenxfkbslhq@eun5r3quvcqq>
References: <cover.1755004923.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755004923.git.maciej.wieczor-retman@intel.com>

On Tue, Aug 12, 2025 at 03:23:36PM +0200, Maciej Wieczor-Retman wrote:
> Compilation time comparison (10 cores):
> * 7:27 for clean kernel
> * 8:21/7:44 for generic KASAN (inline/outline)
> * 8:20/7:41 for tag-based KASAN (inline/outline)

It is not clear if it is compilation time of a kernel with different
config options or compilation time of the same kernel running on machine
with different kernels (KASAN-off/KASAN-generic/KASAN-tagged).

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

