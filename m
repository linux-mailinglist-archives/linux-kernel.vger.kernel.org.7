Return-Path: <linux-kernel+bounces-822559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDADB8421F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746D94A0584
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44AA2F999E;
	Thu, 18 Sep 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNruJSl8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC162FAC06
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191640; cv=none; b=EydPOZ5wTM+whzHRdkyKz5ARf9bA/1a/JqluKo0IKhuohwzK6KeVHUGjMASf5AF62wTx3hxsqLuwvUJzn49QrBomLupSSTGdIkw4MCGVDcX+SvpHY51R+FFxg2yIuqMvhcFjEYYZzjvR9wNuOwt/LDn6eBmwkbZ6NDF5A+Jmw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191640; c=relaxed/simple;
	bh=OD7Mw5ZrocAdW5s9yeVVSt6xbyWWtkvp2zc8JMWiBZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OVU5MbNCUReCEbKDD4ydOX6z3xCdzpOU784ZdrD6LpTxdUzEog62KW2Zccfinl9xvtxy6B3iAFD3QEUqQYjEDtVH02vmQTFPq8mqG67IgPNWTkDQp8qi6xGEKcnnPtitw9vE/2Cgcs8atv9MTXi743mF2uChQGc/9x0fyaiStrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNruJSl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3183C4CEEB;
	Thu, 18 Sep 2025 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191639;
	bh=OD7Mw5ZrocAdW5s9yeVVSt6xbyWWtkvp2zc8JMWiBZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BNruJSl8/KBB4up6PyP7UWp7d2fZ5VU2Y7JJ1RtQGHBcbm77xK8Nfa5Lpq0oVgeZY
	 wpAOm0qMeB4ZWzHGR2SFWAEPXE1VE2c3StJdhOyfwfKSs/dSinzWr9/4pyQYgp+8Jp
	 inT9VKwXqiT20OdmMqpanrVonSLTSVvGE9c/QgevrkvFYrruo6hwR3F8j+9vkz3dvm
	 y7M/lBBSlTGAPU7sg78PK8tjzGhik4XUg5NzFqMXb9sRa4eAQMncVyvgbPhUH6sVKn
	 QQfiOzYZBOOG8LEYn0iBVCw7kH3ZFCC12NrIRjeg8RwNp56GSHhX26Xyrv235hMrBZ
	 XDSxHqb8lOjnA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250917174033.3810435-4-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-4-rppt@kernel.org>
Date: Thu, 18 Sep 2025 12:33:56 +0200
Message-ID: <mafs01po4gicr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 17 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> A vmalloc allocation is preserved using binary structure similar to
> global KHO memory tracker. It's a linked list of pages where each page
> is an array of physical address of pages in vmalloc area.
>
> kho_preserve_vmalloc() hands out the physical address of the head page
> to the caller. This address is used as the argument to
> kho_vmalloc_restore() to restore the mapping in the vmalloc address
> space and populate it with the preserved pages.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

