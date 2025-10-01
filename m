Return-Path: <linux-kernel+bounces-839183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC38BB0FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6C416DFBC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B926059E;
	Wed,  1 Oct 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hyvjgiRt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407971804A;
	Wed,  1 Oct 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331446; cv=none; b=C7Bb7qqdwRxURhsm7YHtJbzEwsZ2EYN03i+i14lRlJFw5pi6KTraiy1evS4T/fRjcYIfIiHxMnFOmCzUmRf+wU44xnfIN/vNxcq2i0iWR/j/0ec3XqULNt6RnjWbbqGfHMLaMAZMSIzlfpe7BXPGHFMLtHzogJUQsBJRHg20IUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331446; c=relaxed/simple;
	bh=uSxSwcRiOedDXLxhKHKuV9V6Dg4ErwnHgLo2OrsfABM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1vQGr///uopctOUWHxoioTn9wG1vcC2YqbAag5sEy5OexSXkd2cRI/MzL3vNuj+w/OKLJagm2t7W/yBRkH+4TgmdhsN+RwFEvo5v+UL/norWZRvP//UmgcpWRaLNBTRGmu3sqYQH8IWyoWuYd3ORMZ/4isys1C6+1IMYkYWnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hyvjgiRt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4E3A440B16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1759331140; bh=yLk5OwJbwXxV5BczbIFscvh4zqFZOlvNfCr2TP9UgbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hyvjgiRtDJHYsTOoMedTQg3tjIVLOPV86Gr5ixQA6l/gXaWg45bpr6ovRo/aqXXmA
	 sAox3cGc481W8k4zJNaUZixcFztg+kgk2MEFqjxBW8AIfJcZ2uVqWZAKgpVCtK4u3V
	 1o5DPYJCmKQXTgD+JvCbhrwSIlC4BGhe+bXjX7IQsjdS9+E3yawYMC5HGaR8g8fcUs
	 YKKfqvTsIftKekG+HOmKzSlTjQDL5V+ymYwC97W+/QxgotlvmcOWicApT+a3AF6sSu
	 pyNrvdDOqdyjmnJ3e0qe1jiiJ0qnEmWwpPcySVeSoDedM8biTLP0e6Bk6hNfhosCnp
	 xA9sd1gmhctdQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4E3A440B16;
	Wed,  1 Oct 2025 15:05:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Some patches against build-script
In-Reply-To: <cover.1759328070.git.mchehab+huawei@kernel.org>
References: <cover.1759328070.git.mchehab+huawei@kernel.org>
Date: Wed, 01 Oct 2025 09:05:36 -0600
Message-ID: <87seg2u0fz.fsf@trenco.lwn.net>
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
> This small patch series contain 3 minor fixes/cleanups for
> sphinx-build-wrapper addressing some corner usecases.
>
> Patch 1 was already submitted. It avoids 2 harmless warnings when
> texlive is not installed.
>
> Patch 2 fixes the checker for latexmk (PDFLATEX env) when texlive
> is not installed.
>
> Patch 3 restores the logic to store *.pyc files under builddir 
> instead of sourcedir.
>
> Mauro Carvalho Chehab (3):
>   docs: Makefile: avoid a warning when using without texlive
>   tools/docs: sphinx-build-wrapper: pdflatex is needed only for pdf
>   docs: Makefile: use PYTHONPYCACHEPREFIX
>
>  Documentation/Makefile          | 19 ++++++++-----------
>  tools/docs/sphinx-build-wrapper |  2 +-
>  2 files changed, 9 insertions(+), 12 deletions(-)

Applied to the build-script branch, thanks.

jon

