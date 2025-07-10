Return-Path: <linux-kernel+bounces-726630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA0CB00FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEBB1CA462D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B5302CBA;
	Thu, 10 Jul 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sgztZTP5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274F302077;
	Thu, 10 Jul 2025 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190223; cv=none; b=G2dwcAR6wGER20y5Ii0z5cvU+IQqfeRNy55vPNYmu3K2GwEtSgMXcmHhxVNOHBNy/ftZ5VdhPjl16tSqq9pXaS9b6WUohmMU/GDDWy9RRdxHtG5OLy97kWjBXCEmJlNru+IOVxPbGiqX9R74idvB8ApVnocR9Pdm7mFQocalJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190223; c=relaxed/simple;
	bh=AGAfOrxuEt07tLO3k6L8Bw8HJmNVQUoDd/N/1lLMOF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECZEmHRgswP1jAwTUGSp6GhQXCxVi1YQoSDwhRFXOiK+vWSY1Sa5zcp9+450uqbUBjAsgfDhhl5BJYc0baaHn/82NAtCmihiFYPGrjIp5cq/J4zzKOG1d7hAyN+8ErZLvRb3wIuM7IP8JaQGVCSBj/CsZs5hHRvIDcnQX5WHYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sgztZTP5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1C8CA406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190221; bh=dmkt0JTbEarlvMQk+rktj5S9Or++bzNO0o99INz5e1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sgztZTP5YJ2DryfHlJ0TL500eqecWp4bujx4z4cw7A30+G7W8PgnJkcPF/25fz8lW
	 +8KaWPz2IKuhj1ShgehmtJdTC8Ku1zZYaJGEZwljO11tv+5VNbDCOD3nNRe/vdCPOM
	 YEmWvZDHJv5iGFjuJM441ppCxHshbdnuQS6t3JX2YUfXkRwot0twWI01HOBWqJZFnt
	 p0EmcB1op/DRETs79ZBXgk2oCpRlKgZwbIiM17sXsxcsB0liHaU2EmbwWUIIZTCllW
	 yX/93BjHd+OpUfHZdI3WSrAe7TfrMhpUr6+t7E5wLcXc3lYkb2YGvLxAKtVk9Qog9q
	 bN8YmJDAgxxRA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1C8CA406FA;
	Thu, 10 Jul 2025 23:30:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
In-Reply-To: <20250710101931.202953d1@foz.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
 <20250702223524.231794-13-corbet@lwn.net>
 <20250710084119.3e5c1ced@foz.lan> <20250710091352.4ae01211@foz.lan>
 <20250710101931.202953d1@foz.lan>
Date: Thu, 10 Jul 2025 17:30:20 -0600
Message-ID: <87bjpry67n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> With that, I would just drop this patch, as the performance is
> almost identical, and using "emit()" instead of "+=" IMO makes
> the code less clear.

I've dropped the patch - for now - but I really disagree with the latter
part of that sentence.  It is far better, IMO, to encapsulate the
construction of our output rather than spreading vast numbers of direct
string concatenations throughout the code.  So this one will likely be
back in a different form :)

Thanks,

jon

