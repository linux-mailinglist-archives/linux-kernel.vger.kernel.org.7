Return-Path: <linux-kernel+bounces-788358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9511DB3834C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFAF6874B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC06304964;
	Wed, 27 Aug 2025 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pMusGPik"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2081192B84;
	Wed, 27 Aug 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299935; cv=none; b=Yfw8uYmIHJPtcgmiuAGBwQhHudoixWB+GP8hi1U4jevc0wKDCr0ICfdfW5BnCSWOvTJlJfyeiPwqhjWoTf57qNn6Cl0s9/06dEs/wf8fKWuqJaxCm79aBMdq2tvb16MurPCkgEpbf/abYi8hOMWTqFGL2CyZn8wzVsLPNJFhB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299935; c=relaxed/simple;
	bh=4EPlLWP60CHTOYEjd0sCpQfB+lKQJPRW9CYnv0BUrO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPesvDctNW6Q9+myCHXdW7TK2IS6qKlinjt1h7R1JWDXtkHUEPJ3zQRWkYZ4d/TeAXc9Jfhdrmgw3P198Z39ykAEtp4ghgbwcLSOZARQfw7WilfOYmxp+ZEO30XzBFyTJs/1DS1n4/5pNvStKEqqGh6Tb6jFjUIUxCjc8R5Z2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pMusGPik; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BD64140AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756299931; bh=2oS6jiCW7s9svWELEuoyK7NvM7Okx26TVuRa20VJlJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pMusGPikcnU/6r9KwUO5SXKIN5vXa1o2tRKFbpYgTWAou/T//ao1oh/DJyrwk5vhq
	 rbx/o2n9ANZs9ZvGdQCsZV7/fdO9iIySQiRO1svduIjXNT3xMD/HmwilUxLo6l/Ekp
	 I1AakfxzI2B9jGFstNLtVbl6yEmbUpk9HVCWkDWHuUJI+M0UjB0/x9BEymujrSQmFc
	 Xpe9QvU+00W7/Sc8K3Dx88txuX6lnTdour9AR+nUfbsdblw5h1wrzkjbxzWXec6ymD
	 1It46CwnYoMR5G/g0rVizizfB4rpbhCyNjABCuJgw+dQQoK1XtgPB2gbMcXDHDn3yA
	 N/J20OhNNfYGQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BD64140AE7;
	Wed, 27 Aug 2025 13:05:30 +0000 (UTC)
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
In-Reply-To: <20250827144757.26599d50@foz.lan>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
 <87wm6p9v8l.fsf@trenco.lwn.net> <20250827113312.62162725@foz.lan>
 <877byp9f63.fsf@trenco.lwn.net> <20250827144757.26599d50@foz.lan>
Date: Wed, 27 Aug 2025 07:05:27 -0600
Message-ID: <87tt1s9ap4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>> But neither of those say the same thing.  Read "had better know" as
>> "really should know" and you get a lot closer.  I guess I didn't realize
>> that it was such a strange construction.
>
> I bet very few non-native English speaker developers would understand it
> like that.

Even though a non-native developer wrote it :)

We can tweak it, but I'd rather not change the meaning, and, more to the
point, that document needs significant work rather than low-level
tweaking.

jon

