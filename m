Return-Path: <linux-kernel+bounces-727577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36536B01C54
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EA51C2855A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691822C3272;
	Fri, 11 Jul 2025 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="aRvZbFHB"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9DE2C158C;
	Fri, 11 Jul 2025 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237935; cv=none; b=SgwJVEYUKnCV2nyNBSaSX8UqslRip9QD5ceh5yFiPiZkLfN9BjrZ1fhBavIbmBQJyv+Uw/Ux00rbxHWLODaf5c574UEEvRk47n35x2h/xYE5t3aaq8oAEZetmpB85v0OEZq5tbPQl32KODmzm4jVgvepsNYYVZcEbFWsu8QL65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237935; c=relaxed/simple;
	bh=4HatYBiqdBinwDxWxfCoK12EutCJf7054sLtDXTzcvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IUt+5y9ltUn43ou4tY26QT/Z3g9gSi34p3UgwSfDoNDI+DWhXhRXytAD1Ugw4x/fZ2Fg+Xxn80inFfUsRFY3TSIp8TIk7U7P3vQqUkBtUr4m/nWTqh2VVe6zqa4wxLprlM5iJLsq2TATlJi3/Ivk32/Iua7LGCHbqcQKJaUUh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=aRvZbFHB; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 55FA040AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752237933; bh=AC2MxiZyl4bQDhm3Q1e86UyEfI0SVNKT6AX8i4TL+0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aRvZbFHBLXRzWUwGGyR0lhCaE/nDZRYQaVQ+RII7YcjhoQZJNkBc9o7l2pb8Fnt9a
	 1bL7rgmkMvr9a72fadMLPrGKr4OvFT5ASWkmF1NECibgkaL6yAgd6rIzEwH51KzPRL
	 OSC16WJDsEYZcTxVZS96C1xc6nMfcUCvway+bPTifZ9+L25Iz5JhPwyopYh/J/tOFX
	 p4g2zxJnCRgnVPwKlVBleUKw7bIr8CtuFmmAVqqLmnLpiiTggPI0yN2lGNpJTbKaNx
	 KK/vzcT4UN0EUv4Ab79q2SozmlDGtVDqGa4Bld/bEApoM1a8WNiw4dy4kPLANSV2XK
	 h/7jwt+bAQK2w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 55FA040AAB;
	Fri, 11 Jul 2025 12:45:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 07/12] docs: kdoc: Coalesce parameter-list handling
In-Reply-To: <20250711075406.76ae06ec@foz.lan>
References: <20250710233142.246524-1-corbet@lwn.net>
 <20250710233142.246524-8-corbet@lwn.net> <20250711075406.76ae06ec@foz.lan>
Date: Fri, 11 Jul 2025 06:45:32 -0600
Message-ID: <8734b2yjyr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Thu, 10 Jul 2025 17:31:37 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Callers to output_declaration() always pass the parameter information from
>> self.entry; remove all of the boilerplate arguments and just get at that
>> information directly.  Formalize its placement in the KdocItem class.
>> 
>> It would be nice to get rid of parameterlist as well, but that has the
>> effect of reordering the output of function parameters and struct fields to
>> match the order in the kerneldoc comment rather than in the declaration.
>> One could argue about which is more correct, but the ordering has been left
>> unchanged for now.
>> 
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  scripts/lib/kdoc/kdoc_item.py   | 11 ++++-
>>  scripts/lib/kdoc/kdoc_output.py | 75 +++++++++++++--------------------
>>  scripts/lib/kdoc/kdoc_parser.py | 23 ++--------
>>  3 files changed, 42 insertions(+), 67 deletions(-)
>> 
>> diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
>> index f0b2b9082c56..beac5c70a881 100644
>> --- a/scripts/lib/kdoc/kdoc_item.py
>> +++ b/scripts/lib/kdoc/kdoc_item.py
>> @@ -11,6 +11,9 @@ class KdocItem:
>>          self.declaration_start_line = start_line
>>          self.sections = {}
>>          self.sections_start_lines = {}
>
>> +        self.parameterlist = self.parameterdesc_start_lines = []
>
> Please split it on two lines as well. With that, feel free to add:
>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Weird, I was sure I did that...will do it again...

Thanks,

jon

