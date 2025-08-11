Return-Path: <linux-kernel+bounces-763292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E51B212CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D57427F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610A22D0C69;
	Mon, 11 Aug 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ff+XfBR9"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08A2C21F3;
	Mon, 11 Aug 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931980; cv=none; b=rGQtzWyFquAfU62x5TdI3mj9roO0BiM+zh+TzxVP19c91DqynVv2MnRqr4QDlQXgXvPL3mqHHebD6+EhHU1ImEuUhsCOXLiVJAIbdDUxH8HryQkSLglK8OxmPP4age/1GpR1/2pwIma2C7QYjOG4zquZq9V2L0KHRl2OSx2C/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931980; c=relaxed/simple;
	bh=QGbHVc09Zunef6coxkTiWUbvAq3aQD3nV+qBRfWxMS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G+twSnMfpdDYWDvzd2Kq7kjFy7Om2opl3P1bg/SykDm8VSXkH53uqXlyk3iTw4P9x9hu+0hcM5ZxIZbH/uAf4mmDEigKX8It0fsTssW4BnBJNYXDJtTdvBdIl8zkjaK0YLO1LByRZlN5/BjgwTf8EXdwxdB7g9JR5CQDkcB0mgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ff+XfBR9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 576B540AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754931978; bh=coIVAIr3cdiEGjXkXF8udEyXocm5M/hf9T95NILisnY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ff+XfBR91ViWXUGVU7z7twKqHspUhMwcc6GbPZIOzzgpcvFwgNPx1jpQuYtzsX8zr
	 tohN0D/IYt/n10zZFKoTcI7E8nIr3nMT/pbqmTlRulRQkMeVXRiK/PNcVlb8pS3WIF
	 i/0cN8BSQC/xBJz41I9z0Wc8l+ZrKAoBSMg2yIFQcIv8LwQWQfpf5VpWPFaf1Opt16
	 9hPFQdIXASXwC6XNzuST4lCJSlGXUsK944oP1bYfMN3g3/lW9qdAObrAPQSkd2Y3Mk
	 MXTQtr5xRWewKvYSom5zfFQKEXzJnbHQoMaOZKpX62A5unpW5SbWufEv1+MM7NuJiX
	 A8whkUIRDycOg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 576B540AD9;
	Mon, 11 Aug 2025 17:06:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kim Tae Hyun <kimth0312@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Kim Tae Hyun
 <kimth0312@gmail.com>
Subject: Re: [PATCH] [PATCH] docs: update physical memory documentation by
 adding N_GENERIC_INITIATOR to enum node_states
In-Reply-To: <20250802125801.10068-1-kimth0312@gmail.com>
References: <20250802125801.10068-1-kimth0312@gmail.com>
Date: Mon, 11 Aug 2025 11:06:17 -0600
Message-ID: <87cy91eqk6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kim Tae Hyun <kimth0312@gmail.com> writes:

> While reading physical_memory.rst, I noticed that N_GENERIC_INITIATOR has not been update
> from the node_states list, even though it's already added in commit 894c26a1c274b8eafbb4b1dad67e70e51a106061.
>
> Signed-off-by: Kim Tae Hyun <kimth0312@gmail.com>
> ---
>  Documentation/mm/physical_memory.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> index 9af11b5bd145..b76183545e5b 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -171,6 +171,8 @@ nodes with particular properties as defined by ``enum node_states``:
>    The node has memory(regular, high, movable)
>  ``N_CPU``
>    The node has one or more CPUs
> +``N_GENERIC_INITIATOR``
> +  The node has one or more Generic Initiators

Applied, thanks.

jon

