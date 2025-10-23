Return-Path: <linux-kernel+bounces-867283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0F0C02191
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FA91A67811
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D853385A0;
	Thu, 23 Oct 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxN2EgeH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F32338590
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233122; cv=none; b=KvmcB4nmj8Nuc5ihvaXnx18ZdUj1e0a/zDaMtxByP9feC+6Hhf+ApsAvleJ4HahqEvV/Rz8VMii3YaH9g5Mnwtmnfs7NDojZNUIfLBvvdBZbJoBJOQdJzBvnls4VPljfGMOUT7TstP3GefnKEEr37zM+HZno5nPxzpQPjqnqElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233122; c=relaxed/simple;
	bh=/fuW8JOKGNq/+xHFQYhCJv4acRMjcPWVd+bBDSrzccE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc/Ylq3WLIjexVrW63a7x+7vm2FUY/8TsDLnIAIvqlHTxyV/XChYvgyzpJWtZuwXMxpAIHv9w6GPYaJnMv1S6f9egd/5vxVuSqZrNyUSI9fGoc9d8Z2xBGyMAGpMGhAfsmqaORP24YYOuvuWV2l5qHnGQX2y7/VcfmcQaZJEtxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxN2EgeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62410C113D0;
	Thu, 23 Oct 2025 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761233121;
	bh=/fuW8JOKGNq/+xHFQYhCJv4acRMjcPWVd+bBDSrzccE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxN2EgeHWMEu5kXgYfNjZ9KE6sH6xNy26FE47VDZH0/XkWyysEyWKFZV6Kx2x0LLt
	 klFur1yR0nxm+e4MsiW5R8V/gECRfpb8roxnwVhHI0WMl7bBbLMmzdAx+ORiAFwsh8
	 WqdatNyrmgKXfhlFC9yJ1fGyiNeZwvqwNDX7zy7TDs07yezvmGaFsjYQ8zKqVlv44Z
	 Np4neRWq1BgpbX/4d0gQDlEoK+Z/t5pnR+96KeelEri4gNj4xGUk3QiJ1wLd/7K0py
	 yAl5b/Rs8IeS4ShiKeCODfywzC32F4txKu4c4MKVd/nTcHe1xbjeRmvYbd2xZInyuI
	 kcGxBc7/PYOew==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 879B3F40066;
	Thu, 23 Oct 2025 11:25:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 23 Oct 2025 11:25:20 -0400
X-ME-Sender: <xms:4Ej6aNjLrhqPTgtnpQY4rRXXTR1Di6JrIPbPG5PizXKkUWH68jU1dQ>
    <xme:4Ej6aBR8rQEgYdNn0iDUldy9qaXnt8EWsVqkg-NB5um6TZ6gx1e7HUldcgdbtLbsC
    wvOuqcuFUEWZfeh5wfndcNoNubqLoxu7-JdBCiorsOo-0wAVGby8kQ>
X-ME-Received: <xmr:4Ej6aJRhKI081fEmM226qGxV-mDSNAdpgg0YH1GrMQ7mXvA6cB4YL_vJl5LDJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeikeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhsrg
    hmrggrrhhifheigedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepugifmhifsegrmhgr
    iihonhdrtghordhukhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphes
    rghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrd
    hinhhtvghlrdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehhphgrseiihihtohhrrdgtohhm
X-ME-Proxy: <xmx:4Ej6aNC8PUr4qxXXKW6-UVKsTape-5umBvX8jKUj7EXy-RZASbAq1g>
    <xmx:4Ej6aNzw8IArV8kTvm_6tDG4iDH3nabcJz1--0pCJDH3uiR271Okuw>
    <xmx:4Ej6aIpUC1BjKS7N6VUt3kEDpJBnKD2tIv6x8ISMRTwwJO-v0DIHBQ>
    <xmx:4Ej6aAsBsAo88VF4BJnQiz_Q47undDobXK66YlT9ZkPZ8ttZ6ibKVw>
    <xmx:4Ej6aHSbb6G1GBOa_p8Iix_c0ZIMKIegLIVDIl_-zRPEPD9ri6ZENjEV>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 11:25:19 -0400 (EDT)
Date: Thu, 23 Oct 2025 16:25:17 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Usama Arif <usamaarif642@gmail.com>, dwmw@amazon.co.uk, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	ardb@kernel.org, hpa@zytor.com, x86@kernel.org, apopple@nvidia.com, 
	thuth@redhat.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, kernel-team@meta.com, 
	Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH 3/3] x86/mm: Move _PAGE_BIT_NOPTISHADOW from bit 58 to
 bit 9
Message-ID: <hlcz5xsxko5aprmuzaodny45cpnfygz7axsn7muqpsbfhr56h2@kbiinejkqw6e>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
 <20251022220755.1026144-4-usamaarif642@gmail.com>
 <98bc658f-2ec6-43f5-a7e1-e9424450a850@intel.com>
 <797c78f4-1a90-42da-9fed-e87682456a43@gmail.com>
 <90047889-3b90-4c6a-90ed-f155c92f7ce1@intel.com>
 <yv2sjut5urpzz426z4wmufshbron35ohwtqk6jzun46elbcqtf@3z54nh33yl4m>
 <49769803-ad4a-4e15-a691-fd512b667ade@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49769803-ad4a-4e15-a691-fd512b667ade@intel.com>

On Thu, Oct 23, 2025 at 08:12:32AM -0700, Dave Hansen wrote:
> On 10/23/25 07:24, Kiryl Shutsemau wrote:
> > The last patch allows us to only update the kernel that has 5-level
> > paging enabled, making it much easier logistically.
> > 
> > The fix seems trivial, and I don't see any downsides.
> 
> What I'm hearing is: Please change mainline so $COMPANY can do fewer
> backports.

Or you can read it as: without the fix 5-level paging deployment is
harder.

One other point is that crashkernels tend to be older and update less
frequently than the main kernel. And one would only discover that
crashdump doesn't work when the crash happens.

> Yeah, it's pretty trivial. But I'm worried about the precedent, and I'm
> worried that the change doesn't do a thing for mainline. It's pure
> churn. Churn has inherent downsides.

You don't consider kexec to older kernels useful for mainline?

> I'd urge you to kick this out of the series and focus on the bug fixes
> that are unambiguously good for everyone. Let's have a nice big flamewar
> in another thread.

Oh, well... Okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

