Return-Path: <linux-kernel+bounces-799513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CDB42CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C7A581225
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24242ED87E;
	Wed,  3 Sep 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Z7n89/IJ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB482EC088;
	Wed,  3 Sep 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939822; cv=none; b=rIJAxm8hZpZXhtnqZuXygUfX9AdDArz30/jW3BqRLNoT98MFEHst8Ovnb9WNzmwwjoBv4vsh2MeDF9iH1paaD6CFDmWrfrL+Jp1O0Inoyhd5T8f0Vd1zRDODoabUtBI+TxakR/3l7EghoOCA3wuJcMlI3XJz2LvsInhM85y1RDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939822; c=relaxed/simple;
	bh=mkiGvLk02qtQgOqRBzKCxDfgS3qMK2s2BhcKdBmvNBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NEriXEzlLfagwX54FMb8XaIrzIo0HinvVwr9sdDzx48lBuMmdTnJ2nK9kRNdUPPFON/kDKqyAkv7pKE6/7gndbyq1IBha55PO5sSsD+ydp+sL6sd+hlRw1XN7KT8BMQ0K85Ii5sZ70QFZPxxEmPSgUSv324GdMnNwJRmd2LwOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Z7n89/IJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0B7A440AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756939816; bh=lFN1fJFly6KNTiZkgwEYEyOUtp9KsRdAxKVxfq2rRJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z7n89/IJlW2sk9Ncm54HOXPyVbXY1tSnGGVp1a8ybxr/+r+QyhYdGQhXQOM+cLwi9
	 i03cQ5VGkA6n80aEV+GQXIVcp97LuXlyCAoGk/d6kw9tOng7ak5fLZ+LRR7LAhOlza
	 B+wCC0zy5hvr45Imv9/d4OdVzODpo0Q7szZA90olBYYqy9dxaVYrrUG0SyavbePGSG
	 wZ2abOs2h2aTfuPzvhH/zJ9smdYaPHnv0JJ6++9rTY6vVsXd1C0q4pjHGFsm5m0ViG
	 VspElDv2lb3EaesncQIh4IkmcGPT50u0zOTt3rHpYmkTVqWEoRVxF78OHtz/Tp5xvF
	 i+reFYMRHAY0g==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0B7A440AE3;
	Wed,  3 Sep 2025 22:50:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 00/15] Split sphinx call logic from docs Makefile
In-Reply-To: <cover.1756740314.git.mchehab+huawei@kernel.org>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
Date: Wed, 03 Sep 2025 16:50:14 -0600
Message-ID: <873493p2vt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This series does a major cleanup at docs Makefile by moving the
> actual doc build logic to a helper script (scripts/sphinx-build-wrapper).
>
> Such script was written in a way that it can be called either
> directly or via a makefile. When running via makefile, it will
> use GNU jobserver to ensure that, when sphinx-build is
> called, the number of jobs will match at most what it is
> specified by the "-j" parameter.

So I've been playing with these a bit more, still trying to wrap my head
around them.  I do wish that we were somehow ending up with something
simpler than the status quo, but perhaps the problem domain just isn't
that simple.

> The first 3 patches do a cleanup at scripts/jobserver-exec
> and moves the actual code to a library. Such library is used
> by both the jobserver-exec command line and by sphinx-build-wrappper.

These three seem OK, anyway, and could probably go in anytime.

> The change also gets rid of parallel-wrapper.sh, whose
> functions are now part of the wrapper code.
>
> I added two patches at the end adding an extra target: "mandocs".
> The patches came from a series I sent in separate with 2 patches.

As for the rest, a couple of notes from where I am so far:

- The separation of the comments into their own patch is ... a bit
  strange and makes the patches harder to review.  I plan to spend some
  time looking at the end product, but still ...

- Acting on a hint from Akira, I note that "make O=elsewhere htmldocs"
  no longer works - the output goes into Documentation/output
  regardless.  That, I think, needs to be fixed.

Thanks,

jon

