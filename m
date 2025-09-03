Return-Path: <linux-kernel+bounces-798106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE7B4198C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7F3485218
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CC62EC57C;
	Wed,  3 Sep 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0E694f7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C32E1EF4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890274; cv=none; b=nXjzJ7JektpNXVrkdVvXSo0HPH0Bw7n7d/42Gr0fvM9TR6QHQ3kIooXzQpkDA27vfuEuWrIttMUdWtkkc4TcZN8fCAr99iFxlvWATz1a6/KIk/uej9t/LrUfHpIcW1/L5zb/M2kVb7r4AU8qNelRE4C8+uMKuNb4QOkIVEPUdCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890274; c=relaxed/simple;
	bh=37WFRxGfXkvYg6/QkLtmsLkCn5i8jVOdpZKNuE4LReM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWeelGy0UUTYdPvyqExRLPU7H2VoMHaoLVnX+bkmCkH4IqTq68jOv6evB4IEAluacrDyDpHQHk8tf3oKCvKxe083Qq6/ulKywVEgGhMDqbGAaSy4WJbtPRFZSbVtBixLYEfP/K6uM+sEFlUBHc2uFMt42L32p40bFc+nzrj1LQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0E694f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32ECC4CEF7;
	Wed,  3 Sep 2025 09:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756890274;
	bh=37WFRxGfXkvYg6/QkLtmsLkCn5i8jVOdpZKNuE4LReM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0E694f7NF6psG08prlAXYkJM98ksYMAzA82Log9c6VLMD85VmJRoln3rdaN2b1Ma
	 q7wUai2E//Qxiclk/Kcy4s24oUPizqTrFPJ/Eni99/pUIYeK+EPam7Q/r52U6feCmD
	 fPmYsEclOvQ4dK2txi9QwMG1uqyXwEAmkNCml0Ra9crbI6Amjje1a79j66rqxSrIcq
	 /kA/XJAtGjcIxiIxo7Sgr6gLr47nN7FRMd6Bwv+F1l1/dE2lDaM98lHc+7ttxwsUE+
	 eD03qFDOu303HREiMTr7kh/9fxCHdtG2+WIv7JgVMgTOb/Ud17SwEUpPjJVjdjkVZA
	 BmdAdCIqqngZg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 40380F40066;
	Wed,  3 Sep 2025 05:04:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 03 Sep 2025 05:04:33 -0400
X-ME-Sender: <xms:oQS4aGrF9vs-2BwMTumtKSltb0rILaPsEXbce7Wc1-YEG9GJBifGMA>
    <xme:oQS4aJxgy3Al5sAK_I4Uy-LGL-XRv_sTvAmjAadm73AAi8obrSb-6e0ioy7C9eVZJ
    89Sg8jDANulBBj0Pvc>
X-ME-Received: <xmr:oQS4aCdU5WbE-g2PgcM-Nskn78h4kC2aNosrj6BlOsDfr-wtRHoqFL_QiI39>
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
X-ME-Proxy: <xmx:oQS4aNe_4TyZ4DWV26viDhAmFw2Q504W-pBhL-14PpQeZk3IidcWPg>
    <xmx:oQS4aMYr0UdkDBd3JpAVNTmiZyEx5p6Lbu6S2tU13dFaxfhMfcTYMQ>
    <xmx:oQS4aG9xpnRm-JrdcAN830fWxhA-LfJuvkBPcYb8DLSsBy2gEabqPA>
    <xmx:oQS4aAWKZ4XvrAQrmLWs84zHRXbsKuVa6bwuN12vs64yK5OOGuqXGQ>
    <xmx:oQS4aPepF5KBAJNj-t6vIUoYQGWZwb_GJcMKdgXOsoWI2UHmflYF4Ep8>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 05:04:32 -0400 (EDT)
Date: Wed, 3 Sep 2025 10:04:30 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	hughd@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Drop all references of writable and SCAN_PAGE_RO
Message-ID: <5mqa4xqrwfeot7q6id5garayr5shflnr6fqkvpao476eg6gk3e@gnpvdttydzs5>
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903054635.19949-2-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903054635.19949-2-dev.jain@arm.com>

On Wed, Sep 03, 2025 at 11:16:35AM +0530, Dev Jain wrote:
> Now that all actionable outcomes from checking pte_write() are gone,
> drop the related references.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

