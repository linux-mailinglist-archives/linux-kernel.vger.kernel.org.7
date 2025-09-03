Return-Path: <linux-kernel+bounces-798104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D3B41986
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F5E7A28A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605832EC085;
	Wed,  3 Sep 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCuXRWFa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF72223DCE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890239; cv=none; b=qpL6b9xCKljepjZ2K5EAQhNHpBnkXHmkpry5LNCX7sw7aEwfeI0osp0FLSQs/Sy78nkzF2/LK55W7qFgdxpYejtEo9y9vNiNDcd9jyLesE9jlJMnW2nTIrOqlpZ4iAaI3Gz+69w3K9WuBQPOph/ms7SHLvvfzJHXVbYICJZuv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890239; c=relaxed/simple;
	bh=ZaBMP/zFHBda4PhKlPNUHtLAon8HnCbog/bzM7/qsLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M39vAarFt3JzLQk4VBrJIfDkcHVBhJUiAdMrm+RcGyKz/zI894A2pz6kLV6PNIWmXHhxItsqtZ5KCc+u8VhLUP2QbJpqLYnbt7AJWJq2k7JGheHGbz4eykkSM3GM84YJEguE84n5S3EI2WVO1dWK4tsb8plLQsgkmzrVB8OhyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCuXRWFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDBBC4CEFA;
	Wed,  3 Sep 2025 09:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756890239;
	bh=ZaBMP/zFHBda4PhKlPNUHtLAon8HnCbog/bzM7/qsLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCuXRWFaPOKeT8s8VSomyL4TZSLL/K2iEy+vANXoWi7l+s1IL+KAsZOmFbPSpeMrz
	 GtNBOTPlFORl/e6dAOiIq1ZdRNNMtj0b0XNQd42l1cZe5Ler6CQDofvooNBHDuaRB0
	 SkFGenh7wkgssCxScdTwYMem6kILdRABDO8oSf0TGX7RjGObfCai/xtsFE+yEHkcNY
	 GVv/8U0MpI/Z3PGI/wX7PVK74MTXzusiXk20qevHz1G0sfOi20/ykOGsfyfJpGD+Jb
	 bVQSi1c02W0t4+6z9kdot59uCTeogNTv9YMZlxsboNMw/nFVT9u6wJ1ZwhY4gPjIB7
	 Uy3jrL1tukKiw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BD786F40066;
	Wed,  3 Sep 2025 05:03:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 03 Sep 2025 05:03:57 -0400
X-ME-Sender: <xms:fQS4aIQ1N_CDI01OKhItzAZIUDPa5aYouwp9FW0XEtllPt8jUZUeLA>
    <xme:fQS4aK536jiIPuWC9tHkWWd_MqpADSJjbPM1G-440ZfqEj_ZHNmlXYDB4vt8RQ9Dv
    dnmFc4L9gRH8qTGzcY>
X-ME-Received: <xmr:fQS4aNFSdGsvvMyd1uU1pPkrgaAtYB89PixOSmzs2Dkx_X4V51Gpf0j9hz2e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilh
    hlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheehqddv
    keeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrg
    hmvgdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peguvghvrdhjrghinhesrghrmhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugi
    dqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeiiihihsehnvhhi
    ughirgdrtghomhdprhgtphhtthhopegsrgholhhinhdrfigrnhhgsehlihhnuhigrdgrlh
    hisggrsggrrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvg
    drtghomh
X-ME-Proxy: <xmx:fQS4aDnqSNdhLb2-VJF2K12Kx46jhh211gSa6S0cQMvIQDXSXXf71Q>
    <xmx:fQS4aIBDKsRZCWaHlvA1kqNaWZG14y0PnsPVPr67XjVMFOeAGi_o9g>
    <xmx:fQS4aKGnXp1yIduCd61JZC9CQwodSVCSHYf6FTDnSl8zlDGdVnN4Dg>
    <xmx:fQS4aE-Jn65CreQMv2TzpYgUQ-ZrSGeJYULb-1o47oPRlnXely5Gow>
    <xmx:fQS4aHnYg_Kxk0W_Y0elB-E_nAkGfi2jnp4wf8Mms3-Vp2mh8tkL7_eC>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 05:03:57 -0400 (EDT)
Date: Wed, 3 Sep 2025 10:03:54 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	hughd@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
Message-ID: <zpmk35ljrb7qlfel32bpiomcj3y3ugyz6p35x43oryjigizxvm@jrmzg7ao6omq>
References: <20250903054635.19949-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903054635.19949-1-dev.jain@arm.com>

On Wed, Sep 03, 2025 at 11:16:34AM +0530, Dev Jain wrote:
> Currently khugepaged does not collapse a region which does not have a
> single writable page. This is wasteful since non-writable VMAs mapped by
> the application won't benefit from THP collapse. Therefore, remove this
> restriction and allow khugepaged to collapse a VMA with arbitrary
> protections.
> 
> Along with this, currently MADV_COLLAPSE does not perform a collapse on a
> non-writable VMA, and this restriction is nowhere to be found on the
> manpage - the restriction itself sounds wrong to me since the user knows
> the protection of the memory it has mapped, so collapsing read-only
> memory via madvise() should be a choice of the user which shouldn't
> be overriden by the kernel.
> 
> On an arm64 machine, an average of 5% improvement is seen on some mmtests
> benchmarks, particularly hackbench, with a maximum improvement of 12%.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

