Return-Path: <linux-kernel+bounces-883777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E9CC2E64C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4F0188F2C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A6E2FE053;
	Mon,  3 Nov 2025 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="C7PZi8ou"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A519DF6A;
	Mon,  3 Nov 2025 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212192; cv=none; b=IHKVfbbL3V809XEN9zwi0I6U4x1hRJO7piMRqVRjRo9k+6gr1DXE6zNYU1N0rylZ6mAuKwFwUhNcp1dmySiSJUC6//Em6pBBmfZBQBDYyhk+ZOtj6YbzOc9Dvosst1EBDn9nY/NOYTy3MTVKebaJ5qeM6n6KCujHTxo6OdywkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212192; c=relaxed/simple;
	bh=oUJdMVPVABIGz7WSVSv5QPKIrswKl2xn4xN9tSyRalM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWlbp940a9DMT1FcGcYxPFndXFEKHXfl3DqfHPw7JGihTge44N8kK+AfpF1GvecVut6eSrSf8Pk4NfRubRXXTEglSSGjcHllxjynNBWjq/k6ElfFKWmbjQvx7PRedkgwkcgWpJ3QpxiV5XvcEETjQNqgZ6VJx2Wv9Qy2SNcYzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=C7PZi8ou; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F134A40AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762212190; bh=jfeAfWg+IWTxPeqmknww3EatCKkRqqTiNS+SFy7zDy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C7PZi8ouCV7iZa59u+XIrElecjYmTtEFsaisx0hWWOJo13R5FX9nYHvuJRn+d9m/3
	 G+u2qR2tbuu0nzKy7e/8cy9QLbwqviODfTpNYimSGyYBTVQc7TkTcvo7gkQ1rnmRj+
	 3FsTgsmzDNqCe+orVXZIDYgMQHa0/QauBGyXKnc8u0JpcIwybwl6Fo8Og49W8yxM2O
	 c1+39723JTDAD3p9VR7EIq3bX0NYXv7baxQsvwzu/8XpTQzmTJMKTC0ZvfGQN6aMeH
	 dQnO7JQlIVoaTQjXHW17da3+xsLlZYozde36YYcjTTssIGHtYiV5jHLamyMfOmktit
	 ULWemk3qQDBOg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F134A40AED;
	Mon,  3 Nov 2025 23:23:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Memory Management List
 <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Documentation: treewide: Replace marc.info links with lore
In-Reply-To: <20251031043358.23709-1-bagasdotme@gmail.com>
References: <20251031043358.23709-1-bagasdotme@gmail.com>
Date: Mon, 03 Nov 2025 16:23:09 -0700
Message-ID: <87o6pibt0i.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

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
> ---
>  Documentation/driver-api/usb/writing_musb_glue_layer.rst | 2 +-
>  Documentation/mm/active_mm.rst                           | 2 +-
>  Documentation/translations/zh_CN/mm/active_mm.rst        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

