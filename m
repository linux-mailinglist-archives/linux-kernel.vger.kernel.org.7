Return-Path: <linux-kernel+bounces-726954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09ADB0135D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDCF581502
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445FB1DC98C;
	Fri, 11 Jul 2025 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOLZ1Tg2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4E944F;
	Fri, 11 Jul 2025 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214444; cv=none; b=OQBEDfdhuEBq0Jx7c6Fh4ivcBo6+zI7iu5+W8dluKh5ZyJdyqS4loB1+JlxBdWrVmmtfYGZb9K9Qvi8znlAcVsluDszGxo+QJZzKYh4QV1LsYtGKwZGx3aVyXFjCJU7O0+iwEWlRxxRi7E8B/wRLdb0y87QQMS3qoYjXjXINsHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214444; c=relaxed/simple;
	bh=PZK6kYIyNytmjeGj+0vQg1Bn5O2PDhbgR63Po8HQ8hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPSts6/sNy9x7Lsw9MhX4mZt7ZqWQTKs/rLEGta7M7fSwEnZ9vZ9KiSIfVLgXLaBVdYa5ao1E417ftSzKChUq2o3t1j0xJsUxVbQLLgjylKQVsXTfHQfmEbeclLZo5mADSF7Arvq8Uiqj8K/LYWCSc7MrCwr+BROU4duebUcpKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOLZ1Tg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BBEC4CEF5;
	Fri, 11 Jul 2025 06:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752214444;
	bh=PZK6kYIyNytmjeGj+0vQg1Bn5O2PDhbgR63Po8HQ8hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EOLZ1Tg2640+cMHpEvHO2h0QmqRPZtPfZoilEvSCrbWDayhFYvNATnR6gXeG70W+2
	 DHDIPCNV3O5koVAcrckc5S3k9K3SMwu1VhqgeCRYwcira4J/dvbuaN9yReqiyYDF5y
	 cSTbm32zJTlpXPF7tq5UY8/B5UWGV4o1tUyRIDEd7AMo0kfe1A+dLqd+bSbAbhnD7h
	 KT11c11qYdIkJGwcpVqAFz8VBWMeceGAKiEujDfJ9yV7jThhKqmIhEzqNVbT0O0HU1
	 adD2HdWAaB7+q654hVOvHX3DFSSs7D+t6mN8fmSri3Ocqy1yGd9aWSDX5HuGIa0HnU
	 ngeOdYpmSBftg==
Date: Fri, 11 Jul 2025 08:14:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
Message-ID: <20250711081400.78731086@foz.lan>
In-Reply-To: <87bjpry67n.fsf@trenco.lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-13-corbet@lwn.net>
	<20250710084119.3e5c1ced@foz.lan>
	<20250710091352.4ae01211@foz.lan>
	<20250710101931.202953d1@foz.lan>
	<87bjpry67n.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 10 Jul 2025 17:30:20 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > With that, I would just drop this patch, as the performance is
> > almost identical, and using "emit()" instead of "+=" IMO makes
> > the code less clear.  
> 
> I've dropped the patch - for now - but I really disagree with the latter
> part of that sentence.  It is far better, IMO, to encapsulate the
> construction of our output rather than spreading vast numbers of direct
> string concatenations throughout the code.  So this one will likely be
> back in a different form :)

The main concern was related to performance penalty - as based on
the latest test results, Pyhon currently handles very poorly list
concat (30% to 200% slower at the latest test results).

Yet, at least for me with my C-trained brain parsing, I find "=+" a
lot easier to understand than some_function().

Btw, IMHO Python is not particularly great with names for concat/accumulate
commands. For list, it is append(), for set it is add(). Yet, "+=" is almost
universal (from standard types, only sets don't accept it, using, 
instead, "|=", which kind of makes sense).

Adding a function naming emit() - at least for me - requires an extra brain 
processing time to remember that emit is actually a function that doesn't
produce any emission: it just stores data for a future output - that may 
even not happen if one calls the script with "--none".

Thanks,
Mauro

