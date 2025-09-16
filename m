Return-Path: <linux-kernel+bounces-818471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B059DB59231
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616FC164BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95E229A310;
	Tue, 16 Sep 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Oxq/qRBs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXX6VCaB"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD381F63D9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014957; cv=none; b=tltPX+Bf/Or6wUSDVgU20HgZOtRSmMhWKY9ueFLvZAIr/aNeVe9VlYn7FbxLkRYeXC6XCq//Eir8DGeI7BRx/foXehOIrWlI5AaM6aZHUteWlhCC3tCtirabmI31q19odUZEBVN3yKh8QM67fYG1kKAw081Zljnv3un+MTmIR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014957; c=relaxed/simple;
	bh=lrcf1n43V1CTv5TKCaC7/1U0gBUdGPDpYdmj/r20YSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQTRKZjUY3S9exMHFjNh5e8UYkIb44kk8f8DEIJBlXm0s4nanoPH6LjQMwinpYr4CgmWS3z5IlQ72kqGaIA630bRJpjqc5lqoWmUfWP2RCBfKCimMzdT0CLAaQMc7O3z/nsAcp5mpptvsg6Z0F+G636HOqJu+rLtXpeQsSSuAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Oxq/qRBs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YXX6VCaB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 92C2BEC02A4;
	Tue, 16 Sep 2025 05:29:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 16 Sep 2025 05:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758014954; x=
	1758101354; bh=5RahN1nKreb/kWvqsVS3VXXptJiVPO4DE4jLNfb+LCo=; b=O
	xq/qRBsbLho52vgHeWVbG2UJWCayG7TLcwZHKz5S1S5pGQwQtx4Du8OVrtA56b1J
	RZXL+tohI5GYmR60L7dXKVvgpn18OqOiWPlKGnfohAKtUWtpwpfwTpUehYvPptXx
	NIPX1fxa8tUFvvFPSQ1inI6CfSbne3jLW9RCoNpFOkBE71EFmG8VOz2GheqvF6nB
	sLRp4SEtCepRN/dE6R9IagOJixgRF4CeB20ZUrmHxD9Py/oZCLKThxPhRwbiZVOE
	vlQ0aeBtzSCY1ah2m4a+qZt0xugn5MuySnMxMiW9XwQfwDMvBliD2nCy+wDw5X4R
	Rp3U+YRPWNVXzr7e/uj8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758014954; x=1758101354; bh=5RahN1nKreb/kWvqsVS3VXXptJiVPO4DE4j
	LNfb+LCo=; b=YXX6VCaBKueNu/Lsxgj0HauU9xiScWgLahxrR2WqlgF15ymBnlj
	G+44ldfKUVHRL0zT/2LrWUmTGWX6wHdwJ8qhpBU7gYT50Iu3NeOvxCzrlCgpo9e4
	n6/Y97VLbVSLWNMlA6E3S6gSuDPQK6I0jXJ9SmsKuBmfCS2CbT+NrDkV1o/qancL
	911hS8E2HK7kEMdfDve3sZ1zRisRB/W94p0pNj7afPVr6x5LPp9mtsB2mVVhLyjU
	n1qzcrNb3P8gGXP7XMQrliOpk2u0Ib08IofsCKCunc9wO3PysjfeSlD2bKsSNMMH
	jAREwwiJwUyplZu1JJJIYYD1gjgjOaMwHhA==
X-ME-Sender: <xms:6S3JaGwmOnh-AqDdFuT3whhLqr0u6ajgMukZckrk-FWMusBEu0h3zg>
    <xme:6S3JaEqKSWbTUjEoqu7lJ6JXhCxs_L1vXgPT6urzr5-HpMquh_hM7O4uzJkMFgh0Z
    In9Xf9-zwp0bwsOG-w>
X-ME-Received: <xmr:6S3JaBlfWUHLtTVTa6H0PR4C7hyA-Ou3IOm9or1qPfXSgLkfGxWvZ5HY8FjWBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfedt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrghntggvrdihrghngheslhhinh
    hugidruggvvhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrshht
    ohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepsggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggs
    rgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtoh
    hmpdhrtghpthhtohepnhhprggthhgvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:6S3JaPqeSgPOCfaX2QbBr8B5U-EEHZGMHYEZHCK4dEwfBpdLxTLn7w>
    <xmx:6S3JaKZVhQ2Kj8EpSlxkWZkBEKThm7uZ8qajDh96BqObdZZ5_KHEtA>
    <xmx:6S3JaFHLhaNsFzBVAupFxxPpiwbn3BLueHfVyXX3nNVKHkbf2UkuZw>
    <xmx:6S3JaKzt7MYYHCompAFtPR0V_pjgr-igjGoObeIFdSElYa8LtDIJig>
    <xmx:6i3JaMNL22lJiUEyjS6wpOSMECdzy-s97p_RkvSvF9f9vPc1UH8sA0jW>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 05:29:13 -0400 (EDT)
Date: Tue, 16 Sep 2025 10:29:11 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lance Yang <lance.yang@linux.dev>
Cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier
 in khugepaged_scan_mm_slot()
Message-ID: <ol447ofo44vwtyfwg3zrdtcdlkfzzmx4rre6qhyotmwvecnec4@usa3nonuk2sn>
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-2-lance.yang@linux.dev>
 <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com>
 <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>

On Tue, Sep 16, 2025 at 02:21:26PM +0800, Lance Yang wrote:
> Users of mlock() expect low and predictable latency. THP collapse is a
> heavy operation that introduces exactly the kind of unpredictable delays
> they want to avoid. It has to unmap PTEs, copy data from the small folios
> to a new THP, and then remap the THP back to the PMD ;)

Generally, we allow minor page faults into mlocked VMAs and avoid major.
This is minor page fault territory in my view.

Also it is very similar to what compaction does and we allow compaction
of mlocked VMA by default, unless sysctl vm.compact_unevictable_allowed
is set to zero.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

