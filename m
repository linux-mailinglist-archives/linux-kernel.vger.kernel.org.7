Return-Path: <linux-kernel+bounces-826449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7818B8E8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369C63BC396
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D497258CC0;
	Sun, 21 Sep 2025 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZElWmoQh"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C117555;
	Sun, 21 Sep 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494091; cv=none; b=d8AF65nNxob3LwyUiK7qSa3BfTW0IER/vuHaffrnQA7RplVRIVMlUFwg0/WVpB9H0OC9HEv/Eh+1kBAD8DYmwzmKkZ64WeEsq1BVKNAk77mderapGkwzMSPZwbchEp6x/LmYhcq7edTvtzqT7JIXwFP5uopROflYmxyPCEtZy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494091; c=relaxed/simple;
	bh=x/Ep7JllUr6B+C8eOPkCKemRgb1HJsFtt2ohwn+8vXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MxOEIvdudYVMx/p5tVBrwsZwkiUgn1tFdGNfCwm8q8C4c+jqZfyZvEE0gZC+F3e3z7hgbk8MslIDIuZpGW/ok5W12KVnQYmyfm6CkJUZxCnR/sZ/Drb2+w6OBYlmTuObb4iOJDxKYpF19SFCppOii1cQH3rmD0eEMAt3oE1ey3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZElWmoQh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4BADC40AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758494089; bh=H0L6Jp9A5DUwWoFRMbdcmJIq0HARJZ/UPtq+JpYT08s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZElWmoQh3GjNQuJ8ziTZ2CB3d5w2EAuuTUiw5yuWQpRTz/BhEKFE1ptb1RMBPS1b3
	 qWFmgYniWEJ1m8IEnyZQ8MJTPqbKZsmy0uDdCiRm5u0kV7Bd5x6K/MHUUHyLny9cSM
	 d1eDPdoOnIDY1O/0Xqv8HKVEpIyUuXrvZ4gPVv4+7rjLin16HjGnrHzRmTVXN3SIPA
	 /I5iWgvAyFFeY3s65JqM8oN11PqAmXg1U4+H4LpPpFnUI2NWAo7PO2YpDZCF/m58NA
	 R3iW37s9Q9GS+/r0o43TcC424b3+CIdZkNvBvyMCGX3oBpyMOfmIlxTdWfWUjjcTlH
	 QlY1FxOX0h6zQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::824])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4BADC40AF9;
	Sun, 21 Sep 2025 22:34:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yash Suthar <yashsuthar983@gmail.com>
Subject: Re: [PATCH v2] Documentation/process: submitting-patches: fix typo
 in "were do"
In-Reply-To: <20250920190856.7394-1-yashsuthar983@gmail.com>
References: <20250920190856.7394-1-yashsuthar983@gmail.com>
Date: Sun, 21 Sep 2025 16:34:48 -0600
Message-ID: <87y0q78mev.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yash Suthar <yashsuthar983@gmail.com> writes:

> Fixes a typo in submitting-patches.rst:
> "were do" -> "where do"
>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> ---
> v2: Resending patch as v1 received no reply. No code changes.
>
>  Documentation/process/submitting-patches.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index cede4e7b29af..fcc08eb93897 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -343,7 +343,7 @@ https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
>  As is frequently quoted on the mailing list::
>  
>    A: http://en.wikipedia.org/wiki/Top_post
> -  Q: Were do I find info about this thing called top-posting?
> +  Q: Where do I find info about this thing called top-posting?
>    A: Because it messes up the order in which people normally read text.

Applied, thanks.

jon

