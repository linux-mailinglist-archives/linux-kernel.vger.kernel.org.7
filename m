Return-Path: <linux-kernel+bounces-799526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66EBB42D26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A8E547BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621252E1C79;
	Wed,  3 Sep 2025 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NsLqI+lO"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608B195B1A;
	Wed,  3 Sep 2025 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940454; cv=none; b=LHSaC66QZfr3gdPbOo5l7KC+JHZynQJHwFgC9854B7NtjDlP3iV1QR0ulu+NCugcCEvjYG+vssj+54Z2uffntyxuf8J7ue07jH7iXrGJl8vQBXRxWlERExgCzyKilIc71Qo5cY16MujUSWw7PpoEmmq0/mYYNi2KIEs92dV7Ig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940454; c=relaxed/simple;
	bh=uA1bKZMnYpOhuulEndfkKADdQ8xuZ+SuY4iq7k2VQ4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VBxfGQrnGjI2DsZlv9SazzFW/mtXVwksDiwrsayA22ubOYSu7AB5DHZFSeTA3CFZq+ASiDmxha7sfCM6r/WZ9BP56ptVcyueaZfaSk1mBBlyhnvZBuUykPfO70dCuSIGlJIYWwPEmRz72R0oncMinzt/xRbSap0MlUcjYtiTYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NsLqI+lO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 64D0740AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756940448; bh=mPoNTuxuTecbcNcgu3iVSEuNVBo44D7XN5OkPNPqVzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NsLqI+lOZkOt1AYVtk7qhD1LJK/3W1j9C1MvD+cMAUzGzbHC3Q+QrNJNoxOr5DOnm
	 4nFaY1fUwn1DftImyb9VDxJUmODVeMYba81+mJi69Bo47bbGWxdr8KOygLt5YzWQu5
	 lI0+ocZEOgrAoCQLvnRvLrm7xj+e/9JsZOe5KPa2k8TJOgzuOnLAddpi1ZyrSM8HQg
	 l2lzIe6sCCDI8Za1Mg5f1VSfJSx1pV33f38rcDBkRXRIZ1LhsIo+Zs1YZ2nRfqjMF1
	 CCPtenf6zwtz6VZAYuVR9t6UCMjhFjAXPTPRxjS2B7AvjynKn5Zp/37JUqiYfvQIU3
	 IhasMLzopBHYA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 64D0740AE3;
	Wed,  3 Sep 2025 23:00:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 04/15] scripts: sphinx-pre-install: move it to
  tools/docs
In-Reply-To: <ed365cdc10243a088b13be5e59b8aa7e733c9081.1756740314.git.mchehab+huawei@kernel.org>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
 <ed365cdc10243a088b13be5e59b8aa7e733c9081.1756740314.git.mchehab+huawei@kernel.org>
Date: Wed, 03 Sep 2025 17:00:47 -0600
Message-ID: <87tt1jnnts.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As we're reorganizing the place where doc scripts are located,
> move this one to tools/docs.
>
> No functional changes.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile                     | 14 +++++++-------
>  {scripts => tools/docs}/sphinx-pre-install |  0
>  2 files changed, 7 insertions(+), 7 deletions(-)
>  rename {scripts => tools/docs}/sphinx-pre-install (100%)

Approve of the move, but I note that you didn't update all the
references in the documentation to match.

Thanks,

jon

