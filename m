Return-Path: <linux-kernel+bounces-788414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA82DB38406
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F983AA243
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C693568E4;
	Wed, 27 Aug 2025 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp9hFHsf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892EA156C6A;
	Wed, 27 Aug 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302592; cv=none; b=Tjkh9P8+w/VmatRDETNkK0vsCS7Q2MfNYldzqlstt66R0bemnxYlfga91eHqyabUlRKSu/gcv0Ci/dldHUUhFc6fcaw7RAJ4utegwuCjaGwGUvUtafeJ7aziNKzX3CMhJers4I9xwubotqxnEAZJqjhBFzzDhq4N2KQhNEAFpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302592; c=relaxed/simple;
	bh=GcaZ3E0lOVaI/dz7qSd5StsudC08+m3pWU8LRWDOSW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG5/eTWILKc1KeX9mDmXM1yG5p2jbS8d83uT/jeogG+Xf9L4eoijJFReXiR9MBCcos4fc/U39PIrHGsJhpLemNugINnExwkqvg0xXExY40EewmBDW0OqLz4Ei578k6FMODHZM4fcAGU1lUBLvqyBJIuDKpGOArZ5APBrtsnxSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp9hFHsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11854C4CEF0;
	Wed, 27 Aug 2025 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756302592;
	bh=GcaZ3E0lOVaI/dz7qSd5StsudC08+m3pWU8LRWDOSW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tp9hFHsf5wZRA5Ngee9Y6zBDrUVaRX8mOvlXsftUuc4AeWx2fWi7D9yy34Xe1oj8l
	 nlgTjVITFfPScm1ESRXnHa5kGCs9AJNJUD3L3tntkqnzGwMP5rMloVvyjUJdFrzS5T
	 C6xzr94yEiEEwKo8Y/2XlPLLeZbbLwxEgLxzPOyHhXjDSYmicCEJ0/lIwfQz2z7LHI
	 BJF0ZqqaGX6HKcnw9mge3LD84jst23rQD+Kp1KXB8Z3UtrXeQnmc6ZYarFizkCH5ps
	 pDH5+QXyurHDcG14vfa86pkzNNr34dnixsyYvSdMTrXoJz3IheycLLCoz6kY8xVmOn
	 yhmsKKqhvaUnA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1urGX7-0000000150B-2qzx;
	Wed, 27 Aug 2025 15:49:49 +0200
Date: Wed, 27 Aug 2025 15:49:49 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux Kernel Workflows <workflows@vger.kernel.org>, 
	Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Fox Foster <fox@tardis.ed.ac.uk>, 
	Federico Vaga <federico.vaga@vaga.pv.it>, Randy Dunlap <rdunlap@infradead.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
Message-ID: <sqnd7m34bpr6goauqis6vbgxokpdupfnp22aco4oh5gutb7sd7@4hjbzotyhwhj>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
 <87wm6p9v8l.fsf@trenco.lwn.net>
 <20250827113312.62162725@foz.lan>
 <877byp9f63.fsf@trenco.lwn.net>
 <20250827144757.26599d50@foz.lan>
 <87tt1s9ap4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt1s9ap4.fsf@trenco.lwn.net>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Wed, Aug 27, 2025 at 07:05:27AM -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> >> But neither of those say the same thing.  Read "had better know" as
> >> "really should know" and you get a lot closer.  I guess I didn't realize
> >> that it was such a strange construction.
> >
> > I bet very few non-native English speaker developers would understand it
> > like that.
> 
> Even though a non-native developer wrote it :)

:-) 

Well, I suppose that non-natives raising kids in US would use this a lot,
as, from the examples I saw about such usage, it sounds to me exactly
the kind of language that parents would say a lot to their sibilings ;-)

> We can tweak it, but I'd rather not change the meaning,

Sure. 

> and, more to the
> point, that document needs significant work rather than low-level
> tweaking.

Fully agreed. Seeking it at historic tree, the original text was
written on 2004. Surely management style changed a little bit over
all those years ;-)

Thanks,
Mauro

