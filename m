Return-Path: <linux-kernel+bounces-773991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71FB2AD43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216221BA035E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2754D321F27;
	Mon, 18 Aug 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="W+2uVyTM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDC320CD8;
	Mon, 18 Aug 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531977; cv=none; b=d2fC4fA3+496KDweoAaVK8W7tticmRypoThxKMq45eXXunhG0DI+R5giKjwuMtx/hFj0cKjkARKJbJxr28SMWghJznesZgv7qdemtS56/vEi9/c8dn7HcrZ4/andzyhkbmIip6A8fyV6MTkHbipbYCqQ6lZYK1yJ5AmjCHAq9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531977; c=relaxed/simple;
	bh=33SvtRRZKRpGEJgkApmw9XDN2PRubckU2zN/pwZlLD0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eFnNkTKXWo6X33Li0/kFM8D/Vt8s4sIVmOhWAzvTSg06W1xhvwSzMVNECRCuOowftjPhqfBu9ly9Dy+XgM/FV9qoCqytVYVhndGQasmBIO5WqZVaSXPl0kUEBe55z85JwqbS+T7OOlSMl5BCE1cYUW1Wgvx64e7mvKmmc0zcV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=W+2uVyTM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 73B4E40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755531968; bh=kZm0Bwd6RyfzEuTnBUIgBslD2YQ/6RG8WWIkX9TBaJ4=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=W+2uVyTMXR27DTowkNNp6+t5Lyo4/bR2sMpVLS6Bhvv5PEGFYjXoIOOyMo08MTS4l
	 vyurismLfczWox23k9/cOuXvqJGl10PDHUDgIacjQyH1luudBuRYNpkhKp75rVVrVb
	 73pBNW+EwZxzSvPdIcGHxnlZQwgnaEWHxNExRS08X62+sLs/snjhhN87ehWBmcQ1iX
	 0s6UTYX46UWGrdEBW76Fvo2nDQoWdSDgpD3i8tGJZkC95MWs/9f1KS9IwTppR3Ax2T
	 BbbjMYvnIjjQ/w0QuLjbp5tH8uvvY35tNa46a5MzIUJ/GP8V4R879xa5Vy1G3a4pAT
	 T2fSQwzX22xlA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 73B4E40AB4;
	Mon, 18 Aug 2025 15:46:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Iris Shi <0.0@owo.li>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/sphinx: Fix typo in automarkup.py
In-Reply-To: <8e5ddb7d-8faf-314f-b1b1-2d15d6900862@owo.li>
References: <8e5ddb7d-8faf-314f-b1b1-2d15d6900862@owo.li>
Date: Mon, 18 Aug 2025 09:46:07 -0600
Message-ID: <87ms7wab0g.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Iris Shi <0.0@owo.li> writes:

> "whan" -> "when"
>
> Signed-off-by: Iris Shi <0.0@owo.li>
> ---
>  Documentation/sphinx/automarkup.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
> index 563033f764bb..1d9dada40a74 100644
> --- a/Documentation/sphinx/automarkup.py
> +++ b/Documentation/sphinx/automarkup.py
> @@ -244,7 +244,7 @@ def add_and_resolve_xref(app, docname, domain, reftype, target, contnode=None):
>      return contnode
>  
>  #
> -# Variant of markup_abi_ref() that warns whan a reference is not found
> +# Variant of markup_abi_ref() that warns when a reference is not found
>  #

Applied, thanks.

jon

