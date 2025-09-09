Return-Path: <linux-kernel+bounces-809012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F13FBB5077F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178E31C6385C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB53570DE;
	Tue,  9 Sep 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCgi2h/o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2EE1FF5F9;
	Tue,  9 Sep 2025 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451193; cv=none; b=bgpEPivyn7al6cCzkcUfclWxzlOms7vir+2KTVM4TSfzQGdKnfwWg6dCOTxzKsnPf6/s1M8rSLzEfY21aZfipZuXJnokPOfZQItzoYTrhy8+rO7clsBlAa37TqoElTrB89kZ2qTJIOKNkUWUzJqGQZ5oZdDKn9DnrE9HhLgGUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451193; c=relaxed/simple;
	bh=lRNvw5Vej2PNjUqrctTC6POIwS0tW4NvDAn8P9RwduA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fapfX/k6V91EeXl3a7kEQNgVunn83Pw3RPYxMiYs73bsau5SZrh0ypE9WW7rftFWUrb2Z2E7MfEleoEsV00zsZn4PZOLNk9PQJE4S19fDuCcHmAlLR+GIXMrnWNDaCMm7mzHy+lvwkd5ISvqo4EZFymKYadnSOPKRs90li6Iy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCgi2h/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D628DC4CEF4;
	Tue,  9 Sep 2025 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451193;
	bh=lRNvw5Vej2PNjUqrctTC6POIwS0tW4NvDAn8P9RwduA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCgi2h/oQxBkyv+fOnr8t5TFe2z+Zv5AnIySO30rnXXrcif2Z2sLz6aR01iGQGeuI
	 dZBqoYvtKNZZWUZq4gvUKQvHs/q5pp0nRCSZjlCVWy0HgfSu6R4wUWsCU2wEttsIc1
	 jEpxu+T8CL2JuMA/a+2gdTh68sm3ozEM5+s4sQARkQct8uykEGEn1HlAkgoFDwWLQZ
	 OY66NiLuCqvt6lqitD5Vkb86PQsVKe4MtFDop2g87p4dW4bUfRx+Ik4GNg+RqES6Hj
	 bQlqo5j4UWTwKa/G43M0oNoa2jTBn0NVhgOGtSKk0xGYOBUpPB4uZGtew6K4ThgU/H
	 s7nARvIYuMpcw==
Date: Tue, 9 Sep 2025 22:53:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
Message-ID: <20250909225308.30a42062@foz.lan>
In-Reply-To: <87y0qnv4j2.fsf@trenco.lwn.net>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
	<87plbzwubl.fsf@trenco.lwn.net>
	<7tk2mkydbcblodhipoddued5smsc3ifnmeqen5wv7eu3mbmvgi@nwxqo5366umj>
	<87y0qnv4j2.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 09 Sep 2025 12:56:17 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Basically, what happens is that the number of jobs can be on
> > different places:  
> 
> There is a lot of complexity there, and spread out between __init__(),
> run_sphinx(), and handle_pdf().  Is there any way to create a single
> figure_out_how_many_damn_jobs() and coalesce that logic there?  That
> would help make that part of the system a bit more comprehensible.

I'll try to better organize it, but run_sphinx() does something
different than handle_pdf():

- run_sphinx: claims all tokens;
- handle_pdf: use future.concurrent and handle parallelism inside it.

Perhaps I can move the future.concurrent parallelism to jobserver library
to simplify the code a little bit while offering an interface somewhat similar
to run_sphinx logic. Let's see if I can find a way to do it while keeping
the code generic (*).

Will take a look on it probably on Thursday of Friday.

(*) I did one similar attempt at devel time adding a subprocess call
    wrapper there, but didn't like much the solution, but this was
    before the need to use futures.concurrent.

> That said, I've been unable to make this change break in my testing.  I
> guess I'm not seeing a lot of impediments to applying the next version
> at this point.

Great! I'll probably be respinning the next (hopefully final) version
by the end of this week, if I don't get sidetracked with other things.

Thanks,
Mauro

