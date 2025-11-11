Return-Path: <linux-kernel+bounces-895886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BD8C4F312
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D66974E058F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD6036CE17;
	Tue, 11 Nov 2025 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="B9Jw8GHN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B542F6577;
	Tue, 11 Nov 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880980; cv=none; b=PFmuq9f2BjbJzeHP1SrXq+P1Z2TMvpRdRL5eINAgT7B+hRiHCRCV9yUqfj85NJOngsEfxHfZSQcRUFJ9oBASD5yQQYEKgJNlKQuJWLdk4s9VelaDZw+Nbx+a+SFL3AwlfbFzk1rs6+00/zcpjfTVgN2pdIghCk4Rvx6BHjf9wIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880980; c=relaxed/simple;
	bh=DmlOJa1fHEn32/Sc8ojajG1QKAcD8mmoC9t6oZqjQ2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uxt4hcWHi0ZaCTLdU/RE8oookUJ+M4r+dU3hvatzHsA02nwkzYfbsPwO42SOGf0x1S9AtQuYwh80ap6IV+e+jSfFn/AdxVjRSnmYR9YE/XrqgQGPTeQCpLWWHjRC4ZBdE8H4sOgliOnsJa/UKKwb5ebhG7RF2gqM8pbBiaB76dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=B9Jw8GHN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AC31540B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762880971; bh=9jXUCFBwjBpcsEQk0cc10lCnTYBRAbS2SKyRSjdCgKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B9Jw8GHNuyvp+2m2kK2hfKCEy4Pv2jd1dYeq3TfsLTGvq50LhUblK57uhpq1mwXYq
	 RQFO57lizQNADOpLpwDUGuTUxuClo2f7nGfO5HnTtNU/gELyA5ld7Iye7So8hn68Xb
	 hWRly4brmxDAxM4g96Bb352jIZO01MyDwMZgxOt9+mi3xOsNtXNs+pYeEAdFSMF2Yi
	 bSsfec+XhTx4pxFwLWtsw/ia9uf23Qjz3SwBNGOLg5tpNcpZIhOfu3WkWRuRteHj5n
	 D01DBR2UOLIipanaBsXD6SJkjTxK4PgaYBW1pMRQQqJBL5uCBCXL/BBU6xQ1w1sM34
	 Sj5o2FdhjucaA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AC31540B1B;
	Tue, 11 Nov 2025 17:09:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert get_feat to Python
In-Reply-To: <cover.1762877066.git.mchehab+huawei@kernel.org>
References: <cover.1762877066.git.mchehab+huawei@kernel.org>
Date: Tue, 11 Nov 2025 10:09:30 -0700
Message-ID: <87a50swl6d.fsf@trenco.lwn.net>
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
> That's the final series to complete the migration of documentation
> build: it converts get_feat from Perl to Python.
>
> With that, no Sphinx in-kernel extensions use fork anymore to call
> ancillary scripts: everything is now importing Python methods
> directly from the libraries.

This, of course, conflicts with my library move ...  Maybe we review
that and I go first this time? :)

jon

