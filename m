Return-Path: <linux-kernel+bounces-818867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88081B5976C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3EF1BC6B79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1A307AF9;
	Tue, 16 Sep 2025 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot8VUQUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A402BE057
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028901; cv=none; b=e3/iCYx9SbuSXq5qjHfqxmGqudNWawlN0EjwCNSdnc+6OKlux4YSqbR5lxKFs8k3mzMkh6fkssw1+/jiyowxHSoJYBAkOwlCHOPbxyDanl6llhqlyG2qSVbTtHADr0Pz2COwXudQcCzn8YYVDoBtk+VRv6Z4UEufhbGkgy1Wsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028901; c=relaxed/simple;
	bh=rAvqEfhmGxEnvdZNyv3LFHPZmEftR6dOMSWOd/EB0bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GdgTGSiOBvwA979xfQpYuYIVhMkj87ZeG3LSA4PvUq8jo0kSwvJCByYtzYxwMutCOzOPbUjXJ576LBeasZDi/bZ9t6fQ2Ix6yQ6i4RlHE6MxPdMwpgIsCs4p8ftUievzTS+nwO+jhQhZdHIH7XK8XUYYZUqcuQaKYp+z2skinMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot8VUQUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1C8C4CEEB;
	Tue, 16 Sep 2025 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028901;
	bh=rAvqEfhmGxEnvdZNyv3LFHPZmEftR6dOMSWOd/EB0bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ot8VUQUm11Wn2fQsIQd89sBxvXfdHgw1OvkeKD97GN6OOkDmDuOVVGqb6eYdxZcsp
	 XnstJ8uG7ADE2sOM49qgDDarHlUWPbC/wVZieuRlDc1Ob2fxjNmPAtRM41vz6lvuOa
	 hG8a7QgYiScra6ptd4v+NK3BHnst6WXvIBMNNOwbwPWaj+9xFPFjRfPWLdNX/iHsjl
	 seKtbnOBm5FiAXJBR1WBcDvVU7ipceTXOVzyNXnd3AQTNn26gJhMZZhj68mvre2oCY
	 4844jDl91bxcTMG3pzI8j9cBomn3J7lvMB0nNfaN4MzOBf/uLmrdMnxe1IM/8up3Dc
	 YUJGpNEM8vxWw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pratyush Yadav <me@yadavpratyush.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Baoquan
 He <bhe@redhat.com>,  Changyuan Lyu <changyuanl@google.com>,  Chris Li
 <chrisl@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250916130516.GB1086830@nvidia.com>
References: <20250908103528.2179934-1-rppt@kernel.org>
	<20250908103528.2179934-2-rppt@kernel.org> <mafs0ldmon784.fsf@kernel.org>
	<mafs0ldmnlmq0.fsf@yadavpratyush.com> <aMgey9qEC_XUejXm@kernel.org>
	<20250915144335.GL1024672@nvidia.com> <aMhAiR6qnXMA-c8r@kernel.org>
	<20250916130516.GB1086830@nvidia.com>
Date: Tue, 16 Sep 2025 15:21:37 +0200
Message-ID: <mafs0v7lih6se.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 16 2025, Jason Gunthorpe wrote:

> On Mon, Sep 15, 2025 at 07:36:25PM +0300, Mike Rapoport wrote:
>> > Under the covers it all uses the generic folio based code we already
>> > have, but we should have appropriate wrappers around that code that
>> > make clear these patterns.
>> 
>> Right, but that does not mean that vmalloc preserve/restore should use the
>> public KHO APIs and avoid using internal methods.
>
> I think it does, the same way vmalloc is layered on top of the buddy
> allocator. Why wouldn't you build things in clean understandable
> layers like this?

+1

-- 
Regards,
Pratyush Yadav

