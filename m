Return-Path: <linux-kernel+bounces-881063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D3C2754E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 02:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D6640187D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319623F431;
	Sat,  1 Nov 2025 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0dH7Poh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACDD78F4A;
	Sat,  1 Nov 2025 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761960627; cv=none; b=PSEMjknNWO0mqiSTNMoV1g7vy/B9tTxg82IAvzTyBT1nchbfiINac3nWSq+5huz/LUkFXcKNSOHyCQLpMOyfs9qy0cB7YT4hgLXMWip63B2Lxi+ytp9R2v0HWeSjqsF3nL5UHQodFCjM8FbiAFZZQISiJcX0+bMM0JFfo6ghJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761960627; c=relaxed/simple;
	bh=KXYybCMOsoyA4teq+q4E5zSg7BKUEaObugsAPZvSEno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1fl50VEK2FBYkDiJutpjRurQBiWk3/rLFYXbcaGRaOua1BrfsgaUOSDQYUjHg4gdV3Rg7wfpvCznjgo4/vLShPp8cG8v6whpOVvQna0KVS3WFlav+bYYP4j6P7m3cZdTXtFE4cph1ZeeEZ0JUkprk3wg5oA2EWGX7PewQ/W33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0dH7Poh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2199C4CEE7;
	Sat,  1 Nov 2025 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761960627;
	bh=KXYybCMOsoyA4teq+q4E5zSg7BKUEaObugsAPZvSEno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0dH7PohthNUAtWxRoNk0PmkxBDL9Z6ClZf8aFue7LAJzpIvq9jsZKWFrYsVrZIIa
	 XamLTAut8d09LoegkWaICab+CJELKuwY4pKkJgyQqXk+7F/UBkS53giaia9JdLbNJ4
	 vRoSRG09lO0c0vRBodZ1ueP0buUdXei/qcAxPYuVMpIKvTltPVtQv5l+PCbtbup0+J
	 zNd17NNF8Ovs3HFFI+x2GT7/CwAFuHHYHxdWs6FfHVLHXq2erCQfqiPm2w5ByGLdX2
	 jv6HhtMn5K1+wqWNizB23E/Dvx2cSc7CdKtqr/Ln3PC9YnzIaYpy8fYqZ6Q7qD407K
	 0L82NzguODylg==
From: SeongJae Park <sj@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Documentation: treewide: Replace marc.info links with lore
Date: Fri, 31 Oct 2025 18:30:19 -0700
Message-ID: <20251101013019.68183-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031043358.23709-1-bagasdotme@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 31 Oct 2025 11:33:56 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> In the past, people would link to third-party mailing list archives
> (like marc.info) for any kernel-related discussions. Now that there
> is lore archive under kernel.org infrastructure, replace these marc
> links
> 
> Note that the only remaining marc link is "Re: Memory mapping on Cirrus
> EP9315" [1] since that thread is not available at lore [2].
> 
> [1]: https://marc.info/?l=linux-arm-kernel&m=110061245502000&w=2
> [2]: https://lore.kernel.org/linux-arm-kernel/?q=b%3A%22Re%3A+Memory+mapping+on+Cirrus+EP9315%22
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

