Return-Path: <linux-kernel+bounces-788023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB5B37EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448321BA2DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E028850E;
	Wed, 27 Aug 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC2nXd4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE61C84A1;
	Wed, 27 Aug 2025 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287200; cv=none; b=iVXnjb/540odwDZ45XyjjjUv6vQKtDZk9EwGHh7Uh83RRH1Jzl0ncGcKPmQ1BzdLGGhpx4D/2ReeJPa0SoyTAAjG4Q7g1EhY7aK0DFsoeIdIJbS/xnhDIYjBSJvr+4TTCZHespFWz+ytuKRGAvm/mjunJrQvl0nOlPnilO54htU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287200; c=relaxed/simple;
	bh=KSdalJn3e3gYWepzypnj4qyOLd7bJ+UaPfpIfwX3Wws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s68hCzbheAtdYYml2qEu9fnkH0OtE9EKd/b6wTIXpNBYX+obPSt+g0MJttabq1L7mUBFfI6kgSeXa9+QRBskvK0vSxarLIQ+2+9rhHzreqWn0oUj/MpWwx6pwgFM5APyMGlfcdl+ZxvZj16vS1n0XGWELv7lb/LcBcKdtVhVH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC2nXd4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F7EC4CEEB;
	Wed, 27 Aug 2025 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756287197;
	bh=KSdalJn3e3gYWepzypnj4qyOLd7bJ+UaPfpIfwX3Wws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PC2nXd4+/YuvBpwiK0ryK7ZJ4VMGOnMgzRwEH5JcjnDWvabhAieVb5nDDHFLS8BK9
	 4Nve8zIp9CLUZ+aDJXqV8YIedt54ZV1+T8NmDBSWmV2l8zW6WFokvTEn3uYlKuC+fl
	 Bj0fn1Ny8qdKDhkNxQTACS2sytcyHzOBKC/vVPpQK5G7d2BOS6o/l/sEi1NNdS8PTJ
	 h0XqRT5cBacWrRqpLO3mLMWjYkiA5lniJWaP7sdJDng/CRmYCPYLblfozXXEgJpjT7
	 Z6gdQh4pUIIavFUQMZ9yYHiSLYbg76HL6Bu1Xf/hSb7AsCuniLmkUWWU/Pw8PpqFQb
	 kvV+L7HnR6zRg==
Date: Wed, 27 Aug 2025 11:33:12 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>, Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?=
 <j.neuschaefer@gmx.net>, Fox Foster <fox@tardis.ed.ac.uk>, Federico Vaga
 <federico.vaga@vaga.pv.it>, Randy Dunlap <rdunlap@infradead.org>, Stephen
 Rothwell <sfr@canb.auug.org.au>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
Message-ID: <20250827113312.62162725@foz.lan>
In-Reply-To: <87wm6p9v8l.fsf@trenco.lwn.net>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
	<87wm6p9v8l.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 26 Aug 2025 23:41:46 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> > -manage had better know the details better than you, so if they come to
> > +manage most likely know the details better than you, so if they come to
> >  you for a technical decision, you're screwed.  You're clearly not  
> 
> I really do not understand what it is that you are trying to fix here.
> The original may not be the best English ever, but it is entirely
> correct; do we really have to churn the document for this>

As a non-native English speaker, "had better know" looks really
weird on my eyes, as, at least for me, "know" is a verb.

Heh, I just discovered today by looking on a dictionary:

	https://dictionary.cambridge.org/dictionary/english/know

That know can informally be used as a noun (a shortcut for
knowledge?).

For me as a non-native English speaker, when one writes:

	They "most likely know"		(know here is a verb)

or:
	They "had better knowledge"	(knowledge is a name)

Things become clearer.

Heh:

	They "had better know the details better than you"

the "better" word is used twice, and yeah, this is requires more
fluency in English for a non-native speaker to get what it says.

Considering that "know" (noun) seems to be a shortcut
for "knowledge", what about:

	They "had better knowledge about the details than you"

Just my 2 cents.

Thanks,
Mauro

