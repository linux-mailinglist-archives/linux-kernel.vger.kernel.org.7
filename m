Return-Path: <linux-kernel+bounces-887102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5E5C3748D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1C9734F7E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88627E060;
	Wed,  5 Nov 2025 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hjY594gl"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A634D383;
	Wed,  5 Nov 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367074; cv=none; b=H3NE5W6R3ABwvcF2a2xuLqnVIfhH01Cs7+jL5nsv7Y5PZpILbOtOoxBX3oPY/+UFyhD+7OovAZfpPLg/VJ46D4BVNT99Sc8XPZHoaZBUbtjIc0EVYVPeAfAd5qH1popYMoy5NFMJeZ0R7Y8CTT2hipg3V8dDQhBvBS4R6Vmbn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367074; c=relaxed/simple;
	bh=yoHiVQgiGG6BDULFlDGgY08q5QgpGSbAfNL6yhnawFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aHvMqEEauKtdonfWV0O+Vht7G2BS0eep7iFx96ilX/LAYvNlR+DduhxlP2qJf+oTulZXsD5xFXOyDpYLLcZHpQWPf09DxpQ9bRY6lbiF9Hs6ohON+nj0wzlgbgS9jR4cQ7wMlg4wnSGUrJjFpiitsjhgO5QF/jAyTgpSn/xuYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hjY594gl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 037E040AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762367071; bh=HA9lBNqJvo6qv/crqkMsdxN/89F3Z1EGmiz+u+7tgDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hjY594glND73HRRIGvsnx+jd1xXDfAovze5BojglxiG8qRZveWayEsqbGL6jxv+2p
	 +uE/toj/9UbMwvUrxG9Ga/X5pCOrUo9FNsxje5X8OizuXSprnzXEBDC/j4wTW6s49V
	 ZUvVbjC0CoK0eMAn2niTRhQc0BQ4gjWQxWN+vc7t1deKliVr5F8OwVmohDV6+QyYAh
	 2wDCcz1BEB6k981qCKxIfjhKJ6ud8SWiGDMzzTLKdiiuGTRGrn3PS4Ai7GYFqVm6Xg
	 k33JDgckr1My4pvAk91c4iq/EYocFYWlowgQL0eAbQSh9x4gL6nJ01f3IltN9i/91X
	 wIKkb0Lv4rYSw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 037E040AFB;
	Wed,  5 Nov 2025 18:24:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, Eugene Polyakov <zbr@ioremap.net>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: w1: fix w1-netlink invalid URL
In-Reply-To: <20251104194403.945611-1-rdunlap@infradead.org>
References: <20251104194403.945611-1-rdunlap@infradead.org>
Date: Wed, 05 Nov 2025 11:24:29 -0700
Message-ID: <87fras72xu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> The URL in w1-netlink.rst for an example userspace application
> has changed. The former URL is no longer valid. Update it to the
> github URL.
>
> Fixes: e4e056aa3518 ("w1: documentation update")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Eugene Polyakov <zbr@ioremap.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/w1/w1-netlink.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20251103.orig/Documentation/w1/w1-netlink.rst
> +++ linux-next-20251103/Documentation/w1/w1-netlink.rst
> @@ -196,7 +196,7 @@ Additional documentation, source code ex
>  ==============================================
>  
>  1. Documentation/driver-api/connector.rst
> -2. http://www.ioremap.net/archive/w1
> +2. https://github.com/bioothod/w1
>  

Applied, thanks.

jon

