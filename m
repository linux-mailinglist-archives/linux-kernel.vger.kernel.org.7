Return-Path: <linux-kernel+bounces-808917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08388B50685
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE357A1C16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E13568F6;
	Tue,  9 Sep 2025 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bs06K1/T"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41298225415;
	Tue,  9 Sep 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446977; cv=none; b=HIkG5Q0c6nRDNFv5vLXL+AeHitiw34vYu2YVTZnWZHNkdVWsUhGmACkefKuU53BGnWT/CXPWD+KTfRomNpdfrmzsEz8Aa3kBhdFx9Am2NZKjJnRFXmA72HUxfsnwLV+EDO8TY3UPYPTPzo2hSU9JTLGyVheAJ+p9JwJ9crZzG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446977; c=relaxed/simple;
	bh=ti5QOpFHf/n7c+UCz62PEDL5vM5Vf4UerlJDYJXS41g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmCS+GI2aprC320hKx+BiHe2NokQ3/sUeT+evrplKQp4KPsVHbVum3Kx0H6oplTddzW6wmysGBSwlYW2MQgGYz0QUrlQqjbAi/WiDyj4aMLzyqwE0rJVl+/RTKovjaIf3gh7F1/TmpCRukP9YzYM0FsDJbBP9jC6WDDRpAIUpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bs06K1/T; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7955840AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757446975; bh=7/CUT3fdxoFsxgsuIRLoX3oaraJL+SMcnbFEHKXJQsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bs06K1/TETFleQKZ8jcR2IISc7NHTmQWL2xeWSfHUVxnTVBeGj2mCaNPHe1nj3ypR
	 9cb/hOmUhu/kBcMki7gSbPkzeyc2lokNtpQNjnr4FPlwdQJYeousozF5GKZT8Rt4TW
	 9W5wYQnV19soLeIWCIjp0poYUP8eSB3ku3c+8ECWHZzNkoLYQJDkkqAGaILqhu3B5y
	 ZOeC+UdA3iIgW7rLK3jMMtFBmjHjwbBCv2dtSSl7TkI/2gUuCp9ohqzjWePcycG0S/
	 yIppT/pmk1bXLg3oAAqh7CUe6CY9+7m9fsBJrgHaH5/9B5O8+91v9qdAv51yxHFTR2
	 WDAaE/VDNmT8Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7955840AF9;
	Tue,  9 Sep 2025 19:42:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] docs: submitting-patches: adjust Fixes definition slightly
In-Reply-To: <20250904144533.2146576-1-kuba@kernel.org>
References: <20250904144533.2146576-1-kuba@kernel.org>
Date: Tue, 09 Sep 2025 13:42:54 -0600
Message-ID: <87cy7zv2dd.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Every now and then people send stylistic patches and use Fixes
> purely to refer to a commit which added the ugly or unnecessary
> code. Reword the docs about Fixes.
>
> It should hopefully be enough to lead with the word "bug"
> rather than "issue". We can add more verbiage later, tho, let's
> try the word swap first. I always feel like the more words the
> smaller the chance someone will actually read the docs.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/process/submitting-patches.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

You are an optimist :)

I've applied this, thanks.

jon

