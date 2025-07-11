Return-Path: <linux-kernel+bounces-727975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F8B021FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D156C188882C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13E62EF284;
	Fri, 11 Jul 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="e5hY1wkk"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5D167DB7;
	Fri, 11 Jul 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251979; cv=none; b=e66OdYOXjFruazZZBCim+NWPVQpEVnB/M4IirqEtOG/vVrvKJlkf5sYbMEa4fvAnxd6tLYgu/6mTSVvW0WuD2lPPDKdds/MZNnMGsCngMyzDuR9HQahlj+2Unqmr46+L5cQUiOOO3o87fQdkBuePJtGEkke9vHhPD1lKsHuVpdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251979; c=relaxed/simple;
	bh=1IxBz7Jb8EgO5nuwYWrSeZZPZG68EayPEKqEDcMYrM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ik0tZYaoid8PVGdpAcQVvzIF10rqIpWtTA765H6KMleAf2FCH7OKWpVLdvdtWwwv7vWm+06D5dsAZjWwEMWJHhySOnNf+TKoLwJTRBB4ihJBIDUwvlCN/X4/flQSfio2QgzaY899b9FjgtqTJV44eKPREmQlMlHjVLB1j9+OM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=e5hY1wkk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BA03E4040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752251976; bh=1IxBz7Jb8EgO5nuwYWrSeZZPZG68EayPEKqEDcMYrM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=e5hY1wkkrWOcYNtRc4hu734TLVNnKCHpj+/cLkeccKHTJku9dVfNdNMb83SxLqWY1
	 wMEKcv3CCNx6aQNl5qfzHdYg8w/XMtg1KGBjBH2zbKIL74H1l04TH4m8Zj1bs6cTGG
	 p8uBPVY9J2Nl2obouWF0QT7sKbqDLZlTg8bZgER48z4QMPJ1QlospXxx+UliF0+Jnh
	 Cow/avuF2Xe7LyHHHLjGJZJMjMRmYv5e3Q50vgyt+lePXtZEiKvTu5BYkFY6tmfX3o
	 GIiedG/7ZiKl7iYAlPElFfKlZV6pPIKc3lmIq8LXxQswQoykNZHBbEmN7fYYEPNi7V
	 SaBoUO1USqfoA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BA03E4040B;
	Fri, 11 Jul 2025 16:39:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
In-Reply-To: <20250711182842.691bc43c@sal.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
 <20250702223524.231794-13-corbet@lwn.net>
 <20250710084119.3e5c1ced@foz.lan> <20250710091352.4ae01211@foz.lan>
 <20250710101931.202953d1@foz.lan> <87bjpry67n.fsf@trenco.lwn.net>
 <20250711081400.78731086@foz.lan> <87y0sux57t.fsf@trenco.lwn.net>
 <20250711182842.691bc43c@sal.lan>
Date: Fri, 11 Jul 2025 10:39:35 -0600
Message-ID: <87o6tqvfzs.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>> Perhaps the new not_emit() could even be aware of --none and just drop
>> the data on the floor.
>
> The code already does that on a much more optimized way. This
> is actually one of the improvements over the Perl version: we
> don't need to implement anything special for none.

So your comment on emit() being mis-named for the --none case didn't
actually apply... :)

jon

