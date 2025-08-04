Return-Path: <linux-kernel+bounces-755098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C8BB1A140
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79C31889AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA7025A2BC;
	Mon,  4 Aug 2025 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TItct/nj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F2259CB0;
	Mon,  4 Aug 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310013; cv=none; b=LV+104yPsUnJAAKDZ4gsKoHxbVPXm+N9FqPOIAEew19OQlUfLHKfERs3LqOwJk+zmuAUE6lh1sSJku313FtDSCEHhQyZekGLbd548palUfRrDLOT/5se9wJ+OoqPgCQ5VFe8ZUy6zhishLybBf+DCkm8frQd+Sd9BiNboPqEY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310013; c=relaxed/simple;
	bh=ljkWcbCfYxmIn2nHH8ujujMW2j4/BtdmkWsX5iCWtDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nW1E/iK86FTGytCM5ox+1F3CX3OjPT1w0F23Hivpal+N6SOkxYnEg2mdu4zVuzXVbH3xX2iuFxEJxipJ05WbEUx49DCuFbf2s15M/K6j3KqRCr7rrbGgoNZFan9QqqMVoWxm16/2YvOiDFyymdTlbcqeC52XzQPudy+2VcDlVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TItct/nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EB9C4CEF0;
	Mon,  4 Aug 2025 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754310013;
	bh=ljkWcbCfYxmIn2nHH8ujujMW2j4/BtdmkWsX5iCWtDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TItct/njGEtFLnMclwH5f/+tYsTAPjsLsnEJi9NWLYBm5zYcBBL4kDyECT/GovJrT
	 G4e49Le1GfF7J0PqTYtZaeKzGT/lLwrZEwwaq4Z/fpDKnHQVARuSMDU9WFvT2wvzWy
	 zLaKjKFPb0xblIeKfwq2epm2Mq9DpNkl15J0zVp64ktnzGG8YKG5LS5zf6YPkKLWEw
	 9bPzOhtuyELLpAlw6qiw2UBrQxfOQYxhcQSbg6YsLbtcKgpdp2MPfO1SL4CKaEWqq3
	 tXd/4w90MKwnclB8zo0kbNrLEQB5XyfNEAu9Yq9kkmHDzf1cigUo4mxlZf03XoAZCu
	 0ZRD7um9dSwNw==
Date: Mon, 4 Aug 2025 14:20:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 05/12] docs: kdoc: split top-level prototype parsing out
 of dump_struct()
Message-ID: <20250804142009.0f1bb402@foz.lan>
In-Reply-To: <87ldo3rv42.fsf@trenco.lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-6-corbet@lwn.net>
	<20250801073411.06cb530e@foz.lan>
	<87ldo3rv42.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 01 Aug 2025 08:10:05 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Em Thu, 31 Jul 2025 18:13:19 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:  
> >>  
> >> -        struct_members = KernRe(type_pattern + r'([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
> >> +        struct_members = KernRe(r'(struct|union)([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')  
> >
> > I would prefer keeping type_pattern here.   
> 
> The problem is that type_pattern no longer exists in that function.

Ah, I see. If this is the only place now where we have this, then it
sounds OK to have it like that.

Feel free to add my R-B:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> I'd
> have to redefine it, or make it global.  It seems like a rather trivial
> thing to make global (and, as a result, make people go to the top of the
> file to figure out what it really is).


Thanks,
Mauro

