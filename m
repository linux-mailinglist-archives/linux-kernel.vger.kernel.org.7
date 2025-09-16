Return-Path: <linux-kernel+bounces-819169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09FDB59C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDB31C0354F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809426F28C;
	Tue, 16 Sep 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YHdRnjIS"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1252922DFBA;
	Tue, 16 Sep 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037658; cv=none; b=ae4qxd1GVvoOdy6svXMvjmbUf7148yIZqrx2ZGzdqOFlYVtfN7K7IZH6QcVsAbk2aAUGulLxUrXbI+cCn3BNSz47RyjjzGfIdCFMrKqv+PBWd4qdQRv//s5ICsnaMnUyxDHaRgEYJXJfcQqXJ5ZrXd2ak5fg8l/wPahmALIr75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037658; c=relaxed/simple;
	bh=vQ9B2iUnNZwG8Jf0xXqhxgu2CFfLj3gTrzREA6RdRxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ALJkIzwhws0mF6iSGZFwk8bNxc8HIkcwayGwWSiD1TbAnKkFxE05aa0nxIsKuR62sDGM9i/jnivSPpaUEMDLQ7Q26+arLAxTKQD+rW0hsJdSuCvhM9/ec+4KquqByjTdmflbx0YBZ/V36+iog6S6VVD0oU49Qzd17y6/XIXd1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YHdRnjIS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3658E40AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758037656; bh=gbdugd49qh7DwyvYegacQ+jlw4svGsINKMwBxGYinG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YHdRnjISGGDUB6h/RB933iVB5TA4QeJQ22EZT3o0DZUr5Hg65FxAzWpgT2d/zKaUb
	 6WHH5LJ+Vf7Tc86evXQKGWj4zLXQ8B4lP2FO1hTJibmM0rpdEjcAjtqFB2ruKIoQlH
	 WCRHo/T+J2JkxP3bKz2waSEmHeYPtqpLAzkXzSlE7TYzg3eHveOv+Svno7GifCwtAI
	 vWuFR6RAeIcuen/spY0Y1HMR5uYf3YZtpM8CapkjOhQ6Hg1mMb80DFkZg9rNilHFLw
	 FaM3266QtlDJKN1CRkL1yMsgtY0K4OarMiASE/a/R/3MIGcF+QfdqLCjb5MWsWCes/
	 CgXqWj6lYjWqA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3658E40AFB;
	Tue, 16 Sep 2025 15:47:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/21] Split sphinx call logic from docs Makefile
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
Date: Tue, 16 Sep 2025 09:47:35 -0600
Message-ID: <87frcmflgo.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> This series should probably be called:
>
>     "Move the trick-or-treat build hacks accumulated over time
>      into a single place and document them."

This one doesn't apply - it looks like the same encoding problems with
the translation changes...?

jon

