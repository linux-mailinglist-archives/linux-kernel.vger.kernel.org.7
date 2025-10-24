Return-Path: <linux-kernel+bounces-869117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF944C06FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDF9F4E9288
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E160324B1A;
	Fri, 24 Oct 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="brZE4fJe"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E492254855;
	Fri, 24 Oct 2025 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320237; cv=none; b=Ye23/CaxRIDNALNlaYcPJvZua7mrL8sDGJcG/fa+5H8/EPFgejmDnWFgM3W4GzGHM7mR0xSA4wC2BeJGKfOM/1OcwA/zdaJ9zHikqtXgSfASkPXe13ARxEMc6HoFaWdUUH9UoZZNprFCA0u5pNCDJwXc+7nFn+wOvgn6YIqce14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320237; c=relaxed/simple;
	bh=NOD813amqKPNtxx0LqE7zeVyv1lxYchv6Dshvzm/Y5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aqanBasF3yUGRk0yfHL26SJ36RGOUCIZJicGfxzSpPhp/Wze8CNpCqgYf0dDsF2gviTW6kac/gUNIPZKyAPaT4wnADhYkFDmmMczTH9sbo4j8MZ+vcNpGkLZ9yRFbL1RyqTQpbn5UJQa4KxANZlOCh4BY/rIdehNVFVEj+mzHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=brZE4fJe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EFDDE40AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761320235; bh=TVAdg5O0vAYwiikVxYK9IeGhWYlvPNX1NYQ5Sxkq4is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=brZE4fJekU9QZrU3Z62OcWwODptz4+Bs2CgD3mNKUdN62W21WcxFKs6T5BF+jF+sL
	 PLMenw7ZhQ8H83f+qrge4YInaJvbk1zoK3t72034xjjRA9sR1C1Eoogzw6mSYoB1rc
	 m0q0cp0V5ZWyawueFWU0VkweBw4cZ9TKQ2RCaePkGZ38eA+MsAgxiAH647icimqpRI
	 L9EoKVgN/5nt7m4kNeQjU7yETQfWXVi5XTeRq4tGaBZxUOyzwXYEostZYdkv20zsjK
	 rtrmVkcnuDq9412H4Pf/aB/WB3tlrs6BrpoQEhm4n+xZf5AXr7l0AihGuIHrr404eL
	 BSX15381dM/1A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EFDDE40AED;
	Fri, 24 Oct 2025 15:37:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Jani Nikula
 <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 00/10] Collect documentation-related tools under
 /tools/docs
In-Reply-To: <20251024112428.44965f06@sal.lan>
References: <20251023161027.697135-1-corbet@lwn.net>
 <20251024112428.44965f06@sal.lan>
Date: Fri, 24 Oct 2025 09:37:14 -0600
Message-ID: <87tszoia51.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> At the description you mentioned libs, but I'm not seeing anything
> at the above diffstat showing such renames.

As I said... 

> The big elephant lurking in this small room is the home for Python modules;
> I left them under scripts/lib, but that is an even less appropriate place
> than it was before.

Leaving them in place tends to leave the diffstat relatively devoid of
renames... :)

New version coming shortly.

Thanks,

jon

