Return-Path: <linux-kernel+bounces-785952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CFB352D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331CF3BFEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94292E228D;
	Tue, 26 Aug 2025 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ledbbsfp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802642D3A80;
	Tue, 26 Aug 2025 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183656; cv=none; b=TOxWqRDkhmGapS5AojlHcXeyINpqf57q2VO2YCsHahHBkm/mbUQ/yhoTXEoxl2YHAZrhZr6PClcdBYlKqIrg8Iz+6qqIfcf8tw+Pm74onCSh1ymCKExp5fnapy7RyOkaURairkeNC9ZhwJpSRNlu/vMPNQTlKAuCpV4TaRDxdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183656; c=relaxed/simple;
	bh=WaPZVVjMhrpiv+RnuL+4O1L+T8RlvigGHVXnK7YFpts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yf9jx0Og+4ekZsmDz2i3gnUPKlV13rP5xb8+u0RLvfy3cR31oVsMZt0IenlY/cQNW0DKdsbtk5W1BC2qofcxmAyHUghdzIapPXAx9sWwUMVMA2SvUa/UKTcPckVLTXviE++wniWDcwUjuWKL9h9LnhK45ybn0Rzs4z4p8iFC+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ledbbsfp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BFA0740AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756183651; bh=a8+hWff1KQlSJOK0qvgkMuuSdA0Yy7c7M21npm8LnhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ledbbsfp74ooaF7euWH5BChITt0L5pS3h+6cEY/5/1QAkvt7jyQM36qZu9HjcS4/J
	 RyjYjbmBy0LBr3iCRRh6nwe3kt7nEoS97rP8vBU5XEPhQCDbLx7rGf6QYrrsOB+Z+2
	 P3YXaYsaBuW6Z9R0rDIVpKoFlHTfAN+UQ8nbCC2PaizUy80FrDpdabpjoC1daWZ30l
	 l8euCtwueVZ37hQ23Su4GqU14GKZbP1A9Ba3NmAUsbjx1Acq/KV1zdvf5m91xHepUN
	 HYbeg7Ax/W2TYRtN2j4UMEvCmh72MAzRcCT7/mpD/WGrHBEo+/h8QjH3N+W6eNSzgv
	 o4sgAAEQ1kGRA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BFA0740AE3;
	Tue, 26 Aug 2025 04:47:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Fox Foster <fox@tardis.ed.ac.uk>,
 Federico Vaga <federico.vaga@vaga.pv.it>, Jonathan =?utf-8?Q?Neusch=C3=A4?=
 =?utf-8?Q?fer?=
 <j.neuschaefer@gmx.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: management-style: Correct "know" past
 participle
In-Reply-To: <20250826003437.7695-2-bagasdotme@gmail.com>
References: <20250826003437.7695-2-bagasdotme@gmail.com>
Date: Mon, 25 Aug 2025 22:47:28 -0600
Message-ID: <87349ed6zj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Management style docs writes on people under a manager, where they know
> the details better than the manager himself, in past perfect tense. Yet,
> "know" is in infinitive form instead.
>
> Correct the verb form.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/process/management-style.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/process/management-style.rst b/Documentation/process/management-style.rst
> index dfbc69bf49d435..1381b253b19ef4 100644
> --- a/Documentation/process/management-style.rst
> +++ b/Documentation/process/management-style.rst
> @@ -42,7 +42,7 @@ actually true.
>  The name of the game is to **avoid** having to make a decision.  In
>  particular, if somebody tells you "choose (a) or (b), we really need you
>  to decide on this", you're in trouble as a manager.  The people you
> -manage had better know the details better than you, so if they come to
> +manage had better known the details than you, so if they come to
>  you for a technical decision, you're screwed.  You're clearly not

This seems actively wrong ... ?

jon

