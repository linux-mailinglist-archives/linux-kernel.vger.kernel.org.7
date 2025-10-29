Return-Path: <linux-kernel+bounces-875851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0CC19F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFB94028D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5CA310635;
	Wed, 29 Oct 2025 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP2OTyxf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6E2DE70D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736610; cv=none; b=AuQXH4Lf5Cc4HRSCAJ4mez/kRwTK+bFhdqa8M4/sUhKpz+r9EtCHiD7fb0ak+RkFWxO8JVIdt13b5RCc77eQtEOOc8apIg547jFwmwYhdVJzvPWIMPc8iDvm4iQ1Sre4rCJ+8U07Q3Ti/M9e/XkSAZAl0qwtUysFbj9UMt2aggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736610; c=relaxed/simple;
	bh=iNs2W88xibjLrgXbOdvLwDJqMNBdJqCGzzdryH6uikg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c887toJE5VH0fFp6fvgZSWZJpZFBPSMJT/1tPeC//Wc1oyAxY9eTxaKU9xIKFXCqgBLJRwN5QbGXF+x72wQuNYYgpXCgI1JKo+u7/5XYq2BVzeevlUPAgvv8soWDeZIxaG0SGVC0ToPWPUj2j8KhbNfnsZ8tFdH5u+0iq1FMQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP2OTyxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718CDC4CEF7;
	Wed, 29 Oct 2025 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761736610;
	bh=iNs2W88xibjLrgXbOdvLwDJqMNBdJqCGzzdryH6uikg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KP2OTyxf1XEj0XZm6VpkKI9dPY50h2i37uyJuZ2Uuu4cUA+pvJpietR6o0kHynmFd
	 o37IcYYOofwwx3v03YdOQEeuDmvPZxqON1407AhDyQsCW4ClF5MwSFBHniLC635610
	 809xOAJik6txGhSk31S8hz1lSV6PQ1JLFaRUfAwFjKb+r7X5L2UpzwYpKPRI+78uvU
	 2bMedsgAvXw1S4irD+7v0ZOVykEqrlMB3c/StkZiAwB+94u+cIt4K/se0CecNMJ9Q2
	 T9BeT6oRxpkIAY+WDhujDlSDHrkxFHfZsjvCkpCpMKiHzbAFdVhOlAXIglXcArcIum
	 JgDH7RYgSOMdA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8FB99F40068;
	Wed, 29 Oct 2025 07:16:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 29 Oct 2025 07:16:48 -0400
X-ME-Sender: <xms:oPcBaZO6lfmC-Mua3l16fCzkSAs7Tx2I_WumYQydLcQc5mVJPEisEQ>
    <xme:oPcBaVJYoXXvLx7oHEQ-CSoTk-5-i53_LpLSHk1hgLsjKCt15WTx7YG0CvBQ9ssfl
    UsO3ED-qjNvtn2nC2FBqYEAljgntSVpjDLc7WF0ugQMG7BvTSwUV0w>
X-ME-Received: <xmr:oPcBach5kS8k0d4J0t4p33_OwiQduxzSe9OQqE9jft7xmvDSqMcET7r7peVQRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegusehilhhvohhkhhhinhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugi
    dqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrght
    rdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrd
    gtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsggr
    ohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhope
    hlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepnhhprggt
    hhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrg
    hrmhdrtghomh
X-ME-Proxy: <xmx:oPcBabeMIrjhCPKlIhdYpD-rHjd-YcfavdcFH3S0eYx1o4VLRERtvw>
    <xmx:oPcBac6KBarARx_Mfm45pzpP9ZhWgQra0xWowHGT287EcoH6-SmJIg>
    <xmx:oPcBacghqWlpd57EAZ7LYWaeysojbbfbtnMM-5_7T_ceygxaLVwThA>
    <xmx:oPcBabGhd8r4ILWmiKPmY4EKtO_72rb_uqDDMyzcuTZdrH9yuAHrpw>
    <xmx:oPcBaXU_6r1C8H2YaGwU98AAAVGTTSx4jp-fGDAqnrtsWWOiHMOzq5RU>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 07:16:47 -0400 (EDT)
Date: Wed, 29 Oct 2025 11:16:45 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] mm: shmem/tmpfs hugepage defaults config choice
Message-ID: <ivpba53svcfavp3f4pfqfm5z3goht346ri25rstz4dteggcbuf@73bnztkf53b2>
References: <aQECPpjd-fU_TC79@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQECPpjd-fU_TC79@shell.ilvokhin.com>

On Tue, Oct 28, 2025 at 05:49:50PM +0000, Dmitry Ilvokhin wrote:
> Allow to override defaults for shemem and tmpfs at config time. This is
> consistent with how transparent hugepages can be configured.
> 
> Same results can be achieved with the existing
> 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
> in the kernel command line, but it is more convenient to define basic
> settings at config time instead of changing kernel command line later.
> 
> Defaults for shmem and tmpfs were not changed. They are remained the
> same as before: 'never' for both cases. Options 'deny' and 'force' are
> omitted intentionally since these are special values and supposed to be
> used for emergencies or testing and are not expected to be permanent
> ones.
> 
> Primary motivation for adding config option is to enable policy
> enforcement at build time. In large-scale production environments
> (Meta's for example), the kernel configuration is often maintained
> centrally close to the kernel code itself and owned by the kernel
> engineers, while boot parameters are managed independently (e.g.  by
> provisioning systems).  In such setups, the kernel build defines the
> supported and expected behavior in a single place, but there is no
> reliable or uniform control over the kernel command line options.
> 
> A build-time default allows kernel integrators to enforce a predictable
> hugepage policy for shmem/tmpfs on a base layer, ensuring reproducible
> behavior and avoiding configuration drift caused by possible boot-time
> differences.
> 
> In short, primary benefit is mostly operational: it provides a way to
> codify preferred policy in the kernel configuration, which is versioned,
> reviewed, and tested as part of the kernel build process, rather than
> depending on potentially variable boot parameters.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

