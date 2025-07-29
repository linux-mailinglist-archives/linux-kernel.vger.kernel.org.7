Return-Path: <linux-kernel+bounces-749481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8048B14EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B4A540F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4E01B0F0A;
	Tue, 29 Jul 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="agzKqtps"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5337259C;
	Tue, 29 Jul 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797475; cv=none; b=dnbgi4yRPlcy8MdGqFR/NRTZmCy70NPLI5OKeCz6TSb8/AAcoFBKmIqq3pEvzlvU252d7X8RO0G90h31oH3tzHFnzmkiVO8cva4boS/YsblU2sHarM8ALlANtHkqRiRnuS7ssQ93NhMYypzM7TOz0QSUuqRx7I3LY+YfiiBI3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797475; c=relaxed/simple;
	bh=ks1nAjoBz1pTfGiqLmJwm3OBBNFYD0LExEEmMDMcA7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ssFekKoXOER2NY22lFMobN7FuZb9ZFse0w3MZfLBlYLKguE97jqdw+JWmb5heFM+21+ZF3tZF1FCernQPA9fD/r1UXAbAIWDhlptuEX02qIKuTHjXtg01wOBVhLE/vTfz3oYzS1T/Db3QXgFftiXYGY8i1aiSVwQlayKlJIK+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=agzKqtps; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7324C40AD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753797467; bh=P8wsXs03gozA4VY3hwxn1i6SkHAYJMbpQyS0M+mlC30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=agzKqtps3DPQ2rq1fSHQAiAjOVVjyS4HzWaWEj2qW/e553VKCB8QNut3ieR3VjHhj
	 35BA2VIqNEJgHCQO4D/agsAb34Ekdl/m+73N0obZjtTBn6cfvwYisGcBa0SXMXq4ap
	 nW0oi3yAj8Ma3tSyZCSP17CaGDGXE2M4H523MdnaHgUDHhuXU2pvKgBj61n9qkCqhV
	 UxCKKtZT8Ed/TaxXB1Ivt6wfEkqmAP9CZlr4M62wJ+NmppuFffipQWImCHCeN6I3X2
	 h/q+LwiOAThJNWXQFbCycSwPxMTy9Yg4PNtrvrm4kBq18fkLwi/LMSIxPuRoytAD8/
	 Un2T1jJKCml3w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7324C40AD3;
	Tue, 29 Jul 2025 13:57:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>, Akira Yokosawa
 <akiyks@gmail.com>, mchehab+huawei@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 1/2] docs: kernel-doc: avoid script crash on ancient Python
In-Reply-To: <e9cf21e5332616f2fb58a90fe8ba6f91359915b8@intel.com>
References: <dc75423e817f92cc6b8369892ee79166c2fb5ecc.1753713955.git.mchehab+huawei@kernel.org>
 <8251d567-5218-4fa1-aed2-f38ec089989d@gmail.com>
 <e9cf21e5332616f2fb58a90fe8ba6f91359915b8@intel.com>
Date: Tue, 29 Jul 2025 07:57:46 -0600
Message-ID: <877bzrxfol.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@linux.intel.com> writes:

> Agreed, this breaks more than it fixes.
>
> Python 2.7 reached end-of-life over five years ago. Do we really have to
> cater for ancient stuff? Which actual real world cases do not have
> Python 3+ available? Please just let it go, and see if anyone ever
> notices?

I kind of have to agree.  The only real Python 2 user I know about is
OpenOffice.org, which promises to get off any year now.  Meanwhile, as I
recall, the advice from the Python project is to say "python3" and not
count on bare "python" being available.

jon

