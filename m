Return-Path: <linux-kernel+bounces-753462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CECFEB18362
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C31918866AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C8F26B2B0;
	Fri,  1 Aug 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GhnWjxPA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F922D78F;
	Fri,  1 Aug 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057409; cv=none; b=UKDP1FzhltSQzr7rCXzAh2+/BnrFnJeRyrASUphGuklALF3zhEEaDBoaHu82f/pmCVQHu+kHufyAGuqb21CrPtSzZzHzPjuK/0R7lvwKLHUWd6R1oWjdJeBsdynziYT0PHVLZA9hlL3ghl8hMVIFL+xx+zOqmcWc/HCKVTwU+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057409; c=relaxed/simple;
	bh=gXVB3JgvcsjhNsqRuiqUSIKj5/B+YcRUloogjLKHC9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yjue1q6eTsHzwqk7Pyw688bGC6QLdH3KUnQbuoJTh2KjNyg1ExRyjmu4Rkjo1yLVltGBD5yZJX/2m0o6f0nimKIYuXCq2j+pIW1NZJeHxYkppXUNA9KD7C3fWK7gSlIr1V9mPtOzOaD/TiDwKrEzwUQu06Bmj7NoDbCmRXxM6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GhnWjxPA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D70AF40AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754057407; bh=SicK+6ONz+x3jilrdJ4NRec8oYN9uCe2XP2ecenR050=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GhnWjxPA1XJyPvFFAPoxVR5+jpmNqTW7nqryO/WZsx7vMGoWUaTumcrHDMqXrO1KR
	 9fzaGTdHMONWfDDMAdg6KmPErRDhCJxSz4xnLTb7TmaqJRKAzDHsYhxW3Hgopkond5
	 llTmsGqi3kwgKPyROkrwnVyosVX5CCyF1j1eYwbVOiX8j1bYfbvtkycbWTu1mZG36h
	 4pTBxlol47nBi6B9sOvW7aRI+UQm+gnVDFBRMVHsBsCwbmlbgwM+jOFU2TQlPhDQNT
	 OQOHdxWcdnCsCWJDSZyU+JMvRNl9LrP0ZJQU0PynQUD9hRLQ9k462henzsMC9Hdo6i
	 NzhPa7CVj/ibQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D70AF40AD2;
	Fri,  1 Aug 2025 14:10:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 05/12] docs: kdoc: split top-level prototype parsing out
 of dump_struct()
In-Reply-To: <20250801073411.06cb530e@foz.lan>
References: <20250801001326.924276-1-corbet@lwn.net>
 <20250801001326.924276-6-corbet@lwn.net> <20250801073411.06cb530e@foz.lan>
Date: Fri, 01 Aug 2025 08:10:05 -0600
Message-ID: <87ldo3rv42.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Thu, 31 Jul 2025 18:13:19 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>>  
>> -        struct_members = KernRe(type_pattern + r'([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
>> +        struct_members = KernRe(r'(struct|union)([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
>
> I would prefer keeping type_pattern here. 

The problem is that type_pattern no longer exists in that function.  I'd
have to redefine it, or make it global.  It seems like a rather trivial
thing to make global (and, as a result, make people go to the top of the
file to figure out what it really is).

jon

