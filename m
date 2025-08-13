Return-Path: <linux-kernel+bounces-766549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21BFB247FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF016F9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724922F744B;
	Wed, 13 Aug 2025 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVvBrn5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2892F6595
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083153; cv=none; b=KQbPwizs3AaS4BP1WlLn5nzyT0dKUCrlW2MGW+Akd4bkbR19149bcGuStJ7PZIrq4IsbchBd7BkqamX7QooNdSjV+W26VCJhCs+2pnHvRyx5cWGU7ytTzF4RLA0DAY/s1ygTw8ZIwFDsV88eJsbFTAZqK/XJKgKnk4uq5G5S5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083153; c=relaxed/simple;
	bh=Eeai9dFb+kti/XBjctJ0qi3uDnJFrbSx2nI6I5JGe/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG9uvfxM0UzlsE5Gyp31NMYes8ROuf5uu0N/is1xFnACRXw4Va22g/NolFoxHiws7pjXtB9FMfb+nzQGZ76umQtq7iZBn44CQoKfhiD/JYg+2kk3q9jPCs/4Uy/SRAQhPmQmvZaFYtW7VOUB7bjn1UDeU4D/wL6sOKYufJuyrJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVvBrn5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C655AC4CEF6;
	Wed, 13 Aug 2025 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755083153;
	bh=Eeai9dFb+kti/XBjctJ0qi3uDnJFrbSx2nI6I5JGe/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVvBrn5LFehGaYc2qO2snzxpTuN/fEwDLT0hGHkSpzQ3/ePRh7lGO4NPjOIwarFMS
	 YgqriuEYxqTn7wP//Env4yN1cC8JPcXVaVHqlIwVUEJDbpFoWqcIHQsTFDv357ryN7
	 aNJ90rSGYvOzfdiyIb8spetAdPpGdmUqXwfycyc/V989/Swpga1/Z7s3xHncvCzPSW
	 Kd+qm0KVePfbRRCs4DLx8JbOdAvv6AIgXnZzyXFR1ayWVF8r8V/7R1W8NIptWM/WOM
	 dxEDpdPz3JAkY6iDsjyzQ41LzDPYVVNRfa4U/82t942GXIU2CQvB+Krfp9s0xuVBjD
	 XL5KIE8C5CHjQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C67FBF40066;
	Wed, 13 Aug 2025 07:05:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 13 Aug 2025 07:05:50 -0400
X-ME-Sender: <xms:jnGcaIn1p1K9MU1fRyGWzjV0QaDIUTi1zfT2zv7WE8pQiJPkWaIniw>
    <xme:jnGcaDirxVSukN94gQyZs3OTr1Hv2zcp7-fY0tX4suwMW5O1Tc05PrOfPH8osxTk-
    DZ_Z53N-m5mWnXpi4M>
X-ME-Received: <xmr:jnGcaGiopsJBn_DNCn5MLY1IKyfdRiKLiB--lqw0M91wsxo3D_kQT-Rhkv4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeektdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:jnGcaBXUyqFUPMfew4Z5OWLnQYxm0ELK4l60pGN0JZUamPnkFvEXsg>
    <xmx:jnGcaJyWZOPfBrlyFhEBMM7Izc5tbQBmTrmwEKpAcSs1ax97Lv_30g>
    <xmx:jnGcaCZ1SA6oP89KZrD-pcDTmqZEteJLkTO4D3FxGwNjGKkQTMcQ7w>
    <xmx:jnGcaPdCHDN46QC0c0e8jPbv5rGJ_dGyrlROhniLqDa5XRLH8zB5wA>
    <xmx:jnGcaK8yJwFwK7u2RhqfCBJLM8kFptKWxfpX2bimCMLEY2zof4O9jhyL>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 07:05:49 -0400 (EDT)
Date: Wed, 13 Aug 2025 12:05:47 +0100
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
Message-ID: <ebl5meuoksen5yzpzbc5lcafcgzy3esfq7c47puz4tefeskkos@f5wzzg4fjrfz>
References: <cover.1755004923.git.maciej.wieczor-retman@intel.com>
 <mt3agowg6ghwhvcjqfgqgua3m3al566ewmvwvqkkenxfkbslhq@eun5r3quvcqq>
 <rzlimi2nh4balb2zdf7cb75adoh2fb33vfpsirdtrteauhcdjm@jtzfh4zjuwgl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rzlimi2nh4balb2zdf7cb75adoh2fb33vfpsirdtrteauhcdjm@jtzfh4zjuwgl>

On Wed, Aug 13, 2025 at 12:39:35PM +0200, Maciej Wieczor-Retman wrote:
> On 2025-08-13 at 09:16:29 +0100, Kiryl Shutsemau wrote:
> >On Tue, Aug 12, 2025 at 03:23:36PM +0200, Maciej Wieczor-Retman wrote:
> >> Compilation time comparison (10 cores):
> >> * 7:27 for clean kernel
> >> * 8:21/7:44 for generic KASAN (inline/outline)
> >> * 8:20/7:41 for tag-based KASAN (inline/outline)
> >
> >It is not clear if it is compilation time of a kernel with different
> >config options or compilation time of the same kernel running on machine
> >with different kernels (KASAN-off/KASAN-generic/KASAN-tagged).
> 
> It's the first one, I'll reword this accordingly.
> 
> When you said a while ago this would be a good thing to measure, did you mean
> the first or the second thing? I thought you meant the first one but now I have
> doubts.

I meant the second. We want to know how slow is it to run a workload
under kernel with KASAN enabled.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

