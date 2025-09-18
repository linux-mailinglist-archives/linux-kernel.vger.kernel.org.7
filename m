Return-Path: <linux-kernel+bounces-801370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A17CB44443
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605B11CC160B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9630CD86;
	Thu,  4 Sep 2025 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIqjXPCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19D292938;
	Thu,  4 Sep 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006761; cv=none; b=eRNbP5r4crlzCY3uhFvVBav6NLqZ/irFOdIwvDHyay37qJln5Qwk3Y24ogzfXwuvR33NuHLJHi2pkBw+X5YKkv18BdkIz1EN7nwl8Nlv0mMCm4nx4IOGm2K9K5lJtkvxpUiFZYvKY8ttPgoxPa8rwRqB9wyRKqt3e3wc6klMT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006761; c=relaxed/simple;
	bh=vvB9LHzLHbfQS4fQV+J4+br80lq00cFBEEfKBRi/ejU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYi1qbjoqilFp8rJRJ2OtEEgKdlrfJNTP47mrTGd53Lkh471avEDaldA/aPRS62fG6Fv1XrvSk9BtZ9y80om73gD7tZF91kZ3eEedps5LbyIjrZ14Wg3LaZiFJGD48hCwzs+yDCag8hnp53DqKwUHfWHoERuk3jvfy2d0NDcfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIqjXPCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F32C4CEF0;
	Thu,  4 Sep 2025 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757006760;
	bh=vvB9LHzLHbfQS4fQV+J4+br80lq00cFBEEfKBRi/ejU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIqjXPCAMHIzmVOd2/7EtXAdXYGN5Iq6d4OKfkOCshdLqw+mSWKoAGZ9MqKHPuaTX
	 onz7RMXkedX0gsijsvY+kgLgNQ/0NvzkRxBpk/LO4jXjdqMHieAbv0Ma/es05yL59x
	 YU+GnB/jQh+rgVJezrlF2TnLX4oqXkF+FOwffhDeEtgO/ctkOfHvDNZZ2nkG6RaXyI
	 Z83z6wvyjKsHyjE1R8Eb84nopfKUBmV5UpspVy3Se5y7vNR89tRuo0kdlEioFGM2Xt
	 vv8+NhE872Dd9cc55+R9HGY90W8KA/McKcb5s7tePYSHcP7yfvx6zoodPq/W79T53P
	 nuzLiGfBEi1pw==
Date: Thu, 4 Sep 2025 17:25:58 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: Use HMAC-SHA256 library instead of crypto_shash
Message-ID: <20250904172558.GA854551@google.com>
References: <20250731190227.16187-1-ebiggers@kernel.org>
 <CAOi1vP9QRWKoQuYHynTXuupJ=VHhLLtN3s2FE6a+gG6gvrA6SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP9QRWKoQuYHynTXuupJ=VHhLLtN3s2FE6a+gG6gvrA6SQ@mail.gmail.com>

On Thu, Sep 04, 2025 at 12:24:08PM +0200, Ilya Dryomov wrote:
> > -       if (con->v2.hmac_tfm) {
> > -               crypto_free_shash(con->v2.hmac_tfm);
> > -               con->v2.hmac_tfm = NULL;
> > -       }
> > +       memzero_explicit(&con->v2.hmac_key, sizeof(con->v2.hmac_key));
> > +       con->v2.hmac_key_set = false;
> 
> Hi Eric,
> 
> Since we have hmac_key_set anyway, could the call to memzero_explicit()
> be conditioned on it?

If you want.  It's less code to just do it unconditionally.

- Eric

