Return-Path: <linux-kernel+bounces-815107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC6B55FDA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED76C1C85395
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B736A2E2845;
	Sat, 13 Sep 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="IlhQ4XHm"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1929DB99
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757755601; cv=none; b=ixYC44N0o9Gqr7fhvmdKGq0IxYF4q6nyXUTNsI3+1mYszOlW3We8uqxPxEiFrK3MPYy4/ME+w8a2Hfe12PAeWK5QRcut4Z8wRE/kaygHZGifQETCJIZU2QG54A9tnNmWpSi65AOOIW9oK7HfjE6AMhthdmIfSmS4HwqMHfafuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757755601; c=relaxed/simple;
	bh=usZYJavjdpmmReaxBh4PERfI2wIGrMbPzjspNGels2U=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=jjFOkJtfcNtlTOjrbi0KNWOk60ObSQ8EQ1x8DX83GF75u13CVcFbGmX3DDAnbBvuZ4ko5hUjSwtd6VkErgBhfMkm5Zub725nRsqo3DvvkoQYy9uk5y8ZtqYGyiBugS5KgwIvjgIHk6rAJDu81drH7bxOE9XsguHGRyfCXWEWYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=IlhQ4XHm; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TTMyBxeDjOJTFiCMFqTN9y4ghnBcfJar1y3fczDIOQ4=; b=IlhQ4XHm4IRL0nseofe9g0QOIK
	SOt6RZHwldLH3uq6D7L48O/Y7iaO3XNW/UsMxGtnkJhYxD7ZJ33buEOgHUk3BfDQMSvrzh80zqVKw
	mW0DgFNcPYy9zal1hDWY/b+K2WW9GhLMiywV9TN1kNYp50bxbucDV7ZgyUqE565K3EFVRE5FsuZIc
	2EET8cFz7ZsyiwhjFUdFK8FQZY3dDaO9vqO+sTLIe+bPx0WPZK06u0z/Zb6iHhYyG/82WTugYPWOg
	9iYY1jhAxSocuLrQzMWmhGJKXsxewOCghzLiSUlSaJlWNw2cr2TUgOD7Z6BH0/P3Es1P6z10ib2TB
	Pu0/BXDA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1uxMWi-0037PK-HK
	for linux-kernel@vger.kernel.org;
	Sat, 13 Sep 2025 11:26:36 +0200
Message-ID: <1968f495-bcff-4133-a331-96100548acfd@bitology.eu>
Date: Sat, 13 Sep 2025 11:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Budi_BFX@bitology.eu>
Subject: BF (Bitstreams OS, was Low Jitter, Fair Pay Philosophy, Unification
 of Open Source)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

A good reason to solve philosophy right, is to get rid of the regressed 
"God". (Rather Ell for real monotheism.)

Bitstreams OS, is based on the concept BF, which really is a replacement 
concept, which is natural for computers. - Without God! Fully compliant 
with Ell. Something to try for those interested. (Needs capacity of 
understanding of monotheism.)

The Kawai Computer Bit, Bitstreams OS, BF Concept all is about the best OS.

And MX Linux seems to be a version of what we once wanted, like this.

Made a little playlist here: 
https://www.youtube.com/playlist?list=PLrhKyvVCD4KcT85BxHpwgStzr0-g-y7fW

Light,
Ywe Cærlyn
Budi BFX
https://bitology.eu/








