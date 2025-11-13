Return-Path: <linux-kernel+bounces-899838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A117CC58DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7614248DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC153590CF;
	Thu, 13 Nov 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="A5kpXaXD"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C57264638;
	Thu, 13 Nov 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051703; cv=none; b=sqj1HSw2AFWxOAgL84T3IxmzKuciLK59U+nRzvqc8XOZ+ierYsODYXLkuksJCZw5HOUVVbu1Vk3Ixuo8oomSUM9tBHvn5N4Le21o+60x4fDn1BsoXCRCYKwc3ym06fW3+TBNAX+560jSNwgTQBse4v2gyUMLvAnXjt6iQFHxh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051703; c=relaxed/simple;
	bh=CMAdqGs9O7YD1e8meS58RC8wPDRrJOsX5V8KdhRMj28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rx9wB7Y1ey7WKqe8tVLNzO8W2dZXlZv1vE4T5TvGr1cguBX9Ekmfrny4+jeD9fqA9U0Bpz4uiJaUD+ovLKQDaH1rCC6BKtc1E8C0KJTf+z+KYzxgqTvP+n11tNuPvwvAcByqwrn/mSW8k17eLAPrzYIBNkoS9AJb3tVXIFGvy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=A5kpXaXD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2587040AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1763051701; bh=fZeXcstKgjL+57ApjPda20VrBNPiraqZlGEWM7pRe7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A5kpXaXDWdnd6JY9aFI7r3dDnnM+muZJ6xOiHSd+mEm6Fg/JAO6jsyn12j4A21aeT
	 mXMgPb/m/NAXLIYg6jLy6VGzIz0vstm99JBkYxhrppxHzCBjFFiOMZm0W8zWAgzkeY
	 8FSKjwTXQTj7vmBqR0YducF0Btuc3n+N65q7xjIVDsJaqIHIZMN0b7r8E9FzV84VBL
	 Vo+T/KEbiHtk2TSipu8sll2fDpb2/U6MaL6fyBjhjVTEn1F3YGoekOgm0hC76Xfr8U
	 bDOjergrZVynnZl8GG5OhV59KV7dWh2KAdgnaBmnizwvxzaIFo29bGULe4ueyt4wUR
	 wcriRpQMedWxQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2587040AFB;
	Thu, 13 Nov 2025 16:35:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Dongliang Mu
 <dzm91@hust.edu.cn>, Mauro Carvalho Chehab <mchehab@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] docs: parse-headers.rst: remove uneeded parenthesis
In-Reply-To: <e5de9f7b1f6a963b2912574a65495c47cfbb13ba.1762878176.git.mchehab+huawei@kernel.org>
References: <cover.1762878176.git.mchehab+huawei@kernel.org>
 <e5de9f7b1f6a963b2912574a65495c47cfbb13ba.1762878176.git.mchehab+huawei@kernel.org>
Date: Thu, 13 Nov 2025 09:35:00 -0700
Message-ID: <87jyztsxfv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As pointed by Randy, the parenthesis there is not needed and it
> violates the document coding style.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-doc/9d709020-03fe-467c-be7f-d5ee251bb79a@infradead.org/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/doc-guide/parse-headers.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/doc-guide/parse-headers.rst
> index 954f3285ddf6..bd34a6d00ca9 100644
> --- a/Documentation/doc-guide/parse-headers.rst
> +++ b/Documentation/doc-guide/parse-headers.rst
> @@ -89,7 +89,7 @@ defines the C namespace to be used.
>  It is meant to allow having more comprehensive documentation, where
>  uAPI headers will create cross-reference links to the code.
>  
> -The output is written at the (``FILE_OUT``).
> +The output is written at the ``FILE_OUT``.

Applied, thanks.

jon

