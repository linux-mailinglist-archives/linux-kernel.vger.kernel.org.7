Return-Path: <linux-kernel+bounces-788193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE2B38110
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B37E460041
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537C34F49C;
	Wed, 27 Aug 2025 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XP5J0TD5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E22D191C;
	Wed, 27 Aug 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294145; cv=none; b=tWXsGRguoL16vk0fQ2J1c6mV+dbG9QywHMW2I4RuQwwuXLxMfCSMlOTmvrHB1jsiBMszc14dQoYdBJSWM4wxjbJrV+40O75U6M/FHW/X4xxmvAqFUVnnuF0ts4RD5IcJAzeNf2/8ntUaqhqOFMZarI6GTwkgPY31Zx0555OscRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294145; c=relaxed/simple;
	bh=ZAA5H80sfHbp3PdX6tNqosaiLeRO73rZrlC2QKyRPAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCm+uKQqyCoD4f+969QtGifeJ/3s9Yf6uHDcIPiwmL97T6BHZatwyKin4+xirFMtalhM0wDxRJqBqbkYtNks0+RAPo2UXHmPbwGWnp16mILCm0Dk6vjaJfcrqZqZnLuKpwbxfz/Swrek3vCLSDClxrGqUeGtdy2vDkjzg64/g6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XP5J0TD5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 696FC40AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756294136; bh=UpgPvg4urVxloVNFyyTQlEb9ha3EJSydCmrpNuvHHh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XP5J0TD5ENlnwD9O4WY89Ftgr9vAlfut3MkPr+riqgBoWa43vUlBX012yEbI/yLdc
	 7uup+dEq6e7mmKdY20sDh0CJqcgsZ20+8eFTHV3xI2zm0dE48vktKnh48+nhMdvasF
	 YSRKnRwaYROBp3ZuR3nxHKqBAD/JHR62ogQOMtVlWa49u5BMvEiYNB7auJxJB4GRXl
	 tbMM1xZS4isNYHZVvOdF1UCDIrVrl0OYM5MaF3+cmty6NzfnumSyopHWcuh86N3bbm
	 tMW05WsZ7WYbKQjo61cgFO97RJm2sukLFKgCnnp+tuISeKQNTs95L2lhtBeyD1LYRX
	 pkINcxpArs5TA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 696FC40AE7;
	Wed, 27 Aug 2025 11:28:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>,
 Fox Foster <fox@tardis.ed.ac.uk>, Federico Vaga
 <federico.vaga@vaga.pv.it>, Randy Dunlap <rdunlap@infradead.org>, Stephen
 Rothwell <sfr@canb.auug.org.au>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
In-Reply-To: <20250827113312.62162725@foz.lan>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
 <87wm6p9v8l.fsf@trenco.lwn.net> <20250827113312.62162725@foz.lan>
Date: Wed, 27 Aug 2025 05:28:52 -0600
Message-ID: <877byp9f63.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As a non-native English speaker, "had better know" looks really
> weird on my eyes, as, at least for me, "know" is a verb.
>
> Heh, I just discovered today by looking on a dictionary:
>
> 	https://dictionary.cambridge.org/dictionary/english/know
>
> That know can informally be used as a noun (a shortcut for
> knowledge?).

"know" is a verb as used in the sentence in question too.

> For me as a non-native English speaker, when one writes:
>
> 	They "most likely know"		(know here is a verb)
>
> or:
> 	They "had better knowledge"	(knowledge is a name)
>
> Things become clearer.

But neither of those say the same thing.  Read "had better know" as
"really should know" and you get a lot closer.  I guess I didn't realize
that it was such a strange construction.

Languages are fun.

jon

