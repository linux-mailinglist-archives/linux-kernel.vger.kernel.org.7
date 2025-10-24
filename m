Return-Path: <linux-kernel+bounces-869225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA723C0756E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299CF402202
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0D7280014;
	Fri, 24 Oct 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk3jzK/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634426E6F7;
	Fri, 24 Oct 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323715; cv=none; b=in67XCKA5SITiZjLb9mtZAgYtq5zLCsIHuf2WapecWeDocaI4Yp9xzcouClL759ewBDwowRHK5LkRZhM4LrSzWVHkBE4cCWE8cAYczf76K/hgF863fMT/jHsioF74JVVyZ9U6VlQv3yaS2VQi+xy3IDLcJbaArt5QA5ka4OEBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323715; c=relaxed/simple;
	bh=aVz2sHV0RYWauUYavo7tbuZPHzimp5YPbM6ovv3vsS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSein1ZEahMDB611/9wKYSC9vqPv7Uao5YFvSVnljSApRAsmfqYEQWpTBt++S/APW2oBD5CqRrPKzJ4eZfJn5ttPGGJ8Z5H0FoL1rjYRU0ZzsbqWZX2oCXBpgP/ryRh/W0Ph426W9UnqEWUisEFWILJ5UnFmGQm6Ca2oUSUT3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk3jzK/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA74C4CEF7;
	Fri, 24 Oct 2025 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761323712;
	bh=aVz2sHV0RYWauUYavo7tbuZPHzimp5YPbM6ovv3vsS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tk3jzK/reT0mj1nLyptzBR/ovYjq9D+xNZewAWkc/Pa2+BXQu19GXdPPeDxNjpQci
	 8mSokpvaiGiWTtxf6Wgzhof6cJgGCks6UXtisptbv2uZfn+uNhmi9dj7dCLkRegmSv
	 Zal3IAMUu0nvF0IFsWQI2iTKwG6rmr8jX0Y2HI4fxk+3oDvvbHJSpTHGt3J0MyskaD
	 xXKTf4BboVDLKxjzjc96RxhfkpxVDIeEONL379AnVvVDzBIUkJrICwicpVEQqtHQca
	 aANXAb66+hwuRwErro2ebH6M/vmj9TC2MxzBJTiMcazmdIwWyLUGQgSirb0r8Hf4so
	 IAFlEW7HzgL+w==
Date: Fri, 24 Oct 2025 13:35:02 -0300
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Jani Nikula
 <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 00/10] Collect documentation-related tools under
 /tools/docs
Message-ID: <20251024133502.78a0c7de@sal.lan>
In-Reply-To: <87tszoia51.fsf@trenco.lwn.net>
References: <20251023161027.697135-1-corbet@lwn.net>
	<20251024112428.44965f06@sal.lan>
	<87tszoia51.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 24 Oct 2025 09:37:14 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > At the description you mentioned libs, but I'm not seeing anything
> > at the above diffstat showing such renames.  
> 
> As I said... 
> 
> > The big elephant lurking in this small room is the home for Python modules;
> > I left them under scripts/lib, but that is an even less appropriate place
> > than it was before.  
> 
> Leaving them in place tends to leave the diffstat relatively devoid of
> renames... :)
> 
> New version coming shortly.

OK!

Personally, I don't mind where they'll sit, but if you place them
outside tools/docs/lib, the best would be to move what's there
too.
> 
> Thanks,
> 
> jon

