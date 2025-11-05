Return-Path: <linux-kernel+bounces-887110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEAC374EA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679FA3BCDE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88858280CE0;
	Wed,  5 Nov 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nSKPff3N"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1B2836AF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367211; cv=none; b=ToqL37dCrKMMdVa9TX5GfOHsjSA2Q5jewFcWy8W63Qc+zDbzqLs5h4Tn+DpVCbHAV62xKixSRcjPm6y1fbV1zyjA9usXD7Q/jr43HLjyyQBkbUZsGUcf/4hrmkXc0N4KLpZFfpHIm181k2Z2TI0jqimMWraQcnmXFr63xnYe4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367211; c=relaxed/simple;
	bh=PDY638TJ+NHvA7DQ+tycVynkF22b465WmyEXQFIoKEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ro4CTRBXzoPfXlGJ9Rm8aTGIKSzEUK10xZH7PFtMj/JmEa/eq6rLBQHEvRG8GYi8zZjQWEeAEfSoiBtQNhiSOEy8H8NaxwogLD+//a9m77CuMUkG1Iz0s3eWECzO3M1y4JXSbUV01mjH+NjMXJlNaeYKNUdAQJm4PFFWjcm/9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nSKPff3N; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 871A840AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762367208; bh=y6wHClrjLpszceIMsNVguTMUWHJ4Ch2ZaKXmo+sISz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nSKPff3NhYcUtQm1/4/ae2kGVnkZBSmCsDhAHEzkAiCXdOl2/6fdxiRSUCJfKflDk
	 ZPk/AhseyPQ00P//ZSG/hL/cEkQubzUl0r/x1VITVJyx+W+FxCPdyQ4rdvHp5e+R99
	 1OHy9k6AOjXzKb0FbKFQTL7NIRMoa/beZTwEsRHdwZA93BmEgDXOdmb8gLyBSI19LH
	 /uu5YxB83plCupYTR9SWthmmRx3fnTaoSbBzrDodv1MhfBd1oWEFdXz/lxBSQS38Fy
	 zJfiz90OchAekaYNOsV6dOTXRouVtSplgfg9uVv/zAyva9zMk+lBwW4LuM+b91x3PR
	 L9mbxZUnU8KbA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 871A840AFB;
	Wed,  5 Nov 2025 18:26:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, bhanuseshukumar@gmail.com
Subject: Re: [PATCH v2] docs: Makefile: Sort Documentation targets
 case-insensitively in make help
In-Reply-To: <20251104061723.16629-1-bhanuseshukumar@gmail.com>
References: <20251104061723.16629-1-bhanuseshukumar@gmail.com>
Date: Wed, 05 Nov 2025 11:26:47 -0700
Message-ID: <87bjlg72u0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com> writes:

> Avoid case-sensitive sorting when listing Documentation targets in make help.
> Previously, targets like PCI and RCU appeared ahead of others due to uppercase
> names.
>
> Normalize casing during _SPHINXDIRS generation to ensure consistent and
> intuitive ordering.
>
> Fixes: 965fc39f7393 ("Documentation: sort _SPHINXDIRS for 'make help'")
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  V1-V2 changes
>  - Rebased on to commit 27600b51fbc8 ("MAINTAINERS: extend DOCUMENTATION SCRIPTS to the full directories")
>    in docs-next.
>  - Link to V1: https://lore.kernel.org/lkml/20251015012922.19467-1-bhanuseshukumar@gmail.com/

Applied, thanks.

jon

