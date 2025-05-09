Return-Path: <linux-kernel+bounces-641376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A94AB10CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 12:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7EB9E80F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5028EA48;
	Fri,  9 May 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT+2K5kl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515438FA3;
	Fri,  9 May 2025 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786866; cv=none; b=WKGj+BM4OyJks/ZV5nTdmpQHDSeV/LQskRcYzJa+WfeHl2NgIZn+2bMKeQomqaWzdWo2Mw62Z3GTNyziBEkIVlkurgtWeP8cvfJZ5iF8m8fGdsVymhsZ+6cBqlL+c+AIi/avySzKwg6Mgn8gi9eHXt9xVe050KD2bPDK7Uuvwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786866; c=relaxed/simple;
	bh=Xo+PhD9M3W1okKf+V7bhGau1qWfkCc3UrKbh/JXSMj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COmvs0jGpy23LPwdNr5V/2BEAX6FFgfGb8LBgF/9ONb9WNsre/H0CLPsSwkbYaN9zE6/QiQu6BmP8BtU1q3DTck9i3L5cfFlwWmncVTYeTaucRGO4OPNtUAH5yqmL8CRuiV5/Qe69gFpIVbU8BG+olGpmUngozF4TjXlmJIkSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT+2K5kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9C4C4CEE4;
	Fri,  9 May 2025 10:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786865;
	bh=Xo+PhD9M3W1okKf+V7bhGau1qWfkCc3UrKbh/JXSMj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aT+2K5kluS73Xp6CdcV6sLcNu4/lh9XqO98mm3k9MqI68cf6z0ha5v/qkFUbe894P
	 35PEZK5C1SE3SEcrO6kQGKJa2MlRcfrhSLO4kxW3ZnV3VhkYTQdB0xJCrIjtAoE5UX
	 igxRzO5aWXKxWALjGCEm7rc6Ro5BDL0BYXfw4MC3Mv16LsNR+dCHbiuYNdMr51CKG/
	 Mh49prtNNsevrySsgo2Q5Q7L110SRX+hPoEftdyXQShgtHb+qG9O3A4l9TY4vBmFaB
	 jwEDP7kj9dOqUBOIN68Ayuf9sk76xuOp2gfhKNRRuD5Bnat+E2ZMwyecfCp/Jpzfn9
	 50NNezN2jGa6Q==
Date: Fri, 9 May 2025 12:34:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfs: detect refcount bugs
Message-ID: <20250509-verlieben-respekt-44058457ea59@brauner>
References: <20250506-uferbereich-guttun-7c8b1a0a431f@brauner>
 <bsap2vh4o7h3c5kwmtbgrcjuzldic2m33tlierxx6eqxz7uuqy@p3v3ipakqv3y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bsap2vh4o7h3c5kwmtbgrcjuzldic2m33tlierxx6eqxz7uuqy@p3v3ipakqv3y>

On Tue, May 06, 2025 at 04:43:56PM +0200, Mateusz Guzik wrote:
> On Tue, May 06, 2025 at 01:55:54PM +0200, Christian Brauner wrote:
> > Now that we have pidfs_{get,register}_pid() that needs to be paired with
> > pidfs_put_pid() it's possible that someone pairs them with put_pid().
> > Thus freeing struct pid while it's still used by pidfs. Notice when that
> > happens. I'll also add a scheme to detect invalid uses of
> > pidfs_get_pid() and pidfs_put_pid() later.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  kernel/pid.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 26f1e136f017..8317bcbc7cf7 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -100,6 +100,7 @@ void put_pid(struct pid *pid)
> >  
> >  	ns = pid->numbers[pid->level].ns;
> >  	if (refcount_dec_and_test(&pid->count)) {
> > +		WARN_ON_ONCE(pid->stashed);
> >  		kmem_cache_free(ns->pid_cachep, pid);
> >  		put_pid_ns(ns);
> >  	}
> > -- 
> > 2.47.2
> > 
> 
> With the patch as proposed you are only catching the misuse if this is
> the last ref though.
> 
> iow, the check should be hoisted above unrefing?

No, not really. If there's more than one reference then pid->stashed can
be legimitately != NULL.

