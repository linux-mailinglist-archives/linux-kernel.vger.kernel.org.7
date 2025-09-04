Return-Path: <linux-kernel+bounces-800093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA2DB43350
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D0F166B09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776A9288513;
	Thu,  4 Sep 2025 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCy9AtJT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21792882B6;
	Thu,  4 Sep 2025 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969505; cv=none; b=mJzXSt5cvomUDfLdg7dcot1NGYPPDCoLUmoY2Faw0WJ7oclLprHros+buwRIitLru3NCyD+2/RMMtmJFwDgWxtoBqn+EAWO6VH+ySn4JHmn+JAkfqb00VHr0+yedSCnyo+wzhPNnBS6Y4V/RAHWbVzrRyvuUVZjJPCZ6OO/ScTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969505; c=relaxed/simple;
	bh=0OsHXlqoHlP40kFwXdJgC/rknJI/tpZC23Cjet7dHSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+HAWBWRSOkpDpz4w/FNuwrBi9CNaKUJXWCRbreji5HvuHIYOw0ktH2OPR5Su81Txhro6QiUePfzm4E8Sw7AXJTNCeO7u6Fdd/5BJGHtqgGMpd/qg0/QE54FLdnvysDZlC3/tnGd0xKilng7ybdJxl51YhndPO0gPzdO6M+1T7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCy9AtJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8907EC4CEF0;
	Thu,  4 Sep 2025 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756969505;
	bh=0OsHXlqoHlP40kFwXdJgC/rknJI/tpZC23Cjet7dHSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aCy9AtJTk/hwXbjUTR/YB5TqWkk39/JPOgrdpVj509wGPenvcvyavEr3c/kB9NBGv
	 Gmey5iD434j5nkvY4XBF4Xosa2gzhExOxadZptMnI0hUkU1dzwQSXVki77KZfoZvsM
	 Y81xB/6y2+DXs7R9+dnactS3HLx5GFyP6Ot6mzgkx3uFbHX/Z1P19j+6vdeO2moW3a
	 nGnQiMc1KPXKAfIzmu2husZp3WcVEdWB5pm1WRkt4lqff8insnzKuLDtB/CEcg3UuR
	 +dASP4h5bQsoqgoVmvCuCa4ac86ZRkLlJYCZVIBirUoP6dJM+4b85ZRokiL9WCMkGu
	 t/DIBrb22iyDQ==
Date: Thu, 4 Sep 2025 09:05:01 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 04/15] scripts: sphinx-pre-install: move it to
  tools/docs
Message-ID: <20250904090501.1ba22bca@foz.lan>
In-Reply-To: <87tt1jnnts.fsf@trenco.lwn.net>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
	<ed365cdc10243a088b13be5e59b8aa7e733c9081.1756740314.git.mchehab+huawei@kernel.org>
	<87tt1jnnts.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 03 Sep 2025 17:00:47 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > As we're reorganizing the place where doc scripts are located,
> > move this one to tools/docs.
> >
> > No functional changes.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/Makefile                     | 14 +++++++-------
> >  {scripts => tools/docs}/sphinx-pre-install |  0
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >  rename {scripts => tools/docs}/sphinx-pre-install (100%)  
> 
> Approve of the move, but I note that you didn't update all the
> references in the documentation to match.

Will update at the next spin. When you review again, please notice
that I'm simply dropping it from MAINTAINERS documentation section:

	--- a/MAINTAINERS
	+++ b/MAINTAINERS
	@@ -7310,7 +7310,6 @@ F:        scripts/lib/abi/*
	 F:     scripts/lib/kdoc/*
	 F:     tools/docs/*
	 F:     tools/net/ynl/pyynl/lib/doc_generator.py
	-F:     scripts/sphinx-pre-install
	 X:     Documentation/ABI/
	 X:     Documentation/admin-guide/media/
	 X:     Documentation/devicetree/

As there, tools/docs/* is already present.

Thanks,
Mauro

