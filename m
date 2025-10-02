Return-Path: <linux-kernel+bounces-840102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37388BB3897
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F683B605F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6169F3074AB;
	Thu,  2 Oct 2025 10:02:57 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636832F4A04
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399377; cv=none; b=kbgFqvuqRF9X+IXkE6UFuL/bFjBruv8R2hPxQssanEjiQ9HcDw2vEZOWNLDdMGHgOFgL2QL5NEKTrkdHEo09+WtXHj1iECXvYOMwiTRF0+RWGUa9At7GWwLBRPVldpTdHf3ATqrGoItO2SV3miR7Yixs3RJEDJ/2thhPVSgiVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399377; c=relaxed/simple;
	bh=oKOvZbmQNCWQ//hSnLqE+hNmE/wFXuNJObFRI25KdQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVNC/0d2T7dIUS1GMu5W1oofdbX6HFmlfqoXFzb3jSW+dWRcJPizjpMPizd1lrCDwJ5YwHSaFpi87rbBB/ySK4cEV3ZdPZQPjIut0hLYSsl7zKOlxho5ZqfPQePDrJbf98Px7TUOwNpuaZja8cFp00myvmwCeXYlb+RkC0QEnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d80891c6cso320121466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399374; x=1760004174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ3f0Y8jx/ORdUpe8rUwDsc+LhxkZNLDRVr6mrw2tpc=;
        b=m2p9kb5u/O8/2L2z3+f2DbMQx3+D3gpshRgRDGz6DfcwNd+Nw4XSufYkSTB6tFkncq
         6IlEa6ZmkoAv3B6ZumwxCuTi20GKjJabOUfhb37Axe7GWFVhXdEzq6y+yADwxxy4Df9b
         F4miWbOWdLggaWicalk+CCdf2a/cWO/0kYkO+5g65A4ExowcfRigpN5dW1MOg0sjJGa/
         jjtgO6pI709v/eFxYpgBuoQfAuThTN2lI+i6rWmOQy8i9z+mQl9N7cAAHBdakXfm+7eq
         8+y0Ldmiv7PpFZrpAlLW0coMGv807QmJpwVATGnH4TWGGvOmuI5asna3SIUkpc+yigsD
         3+zw==
X-Forwarded-Encrypted: i=1; AJvYcCUJvldvpLTQh0Skhy5QkzwL+0h+49KFVE6b5dbAxBwxZ7dFS8KNPAWjYNYfRY93MHAGmQ+Yz1qNFN2PF7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhofa73zqrRr7KNvyOMDZgqotfw6+OowRR8LQLWD/W/mGEORt
	8/8y6vTe6Ew93jM2THs9r6+lHjRvpdHuhz7F9Ri82Sz/i0gxlBNqGHsc
X-Gm-Gg: ASbGnctevveV3uRa8DYdFgFch3nQCIIZ/57RfmWjYBZpU1WEqpNVE9Ep+6VYsJ6qQfK
	cPeRxglwqv22LNwIGWYAbgRlA38oYfNNEO89NFQTo0jaBOr5lcyr+L6fVRAsEm6OHhXDjK7tU55
	+Iblgrk9sj0h4QMRlIbUTUVMymoOauYbKTxG9IGeRBOVkW3M29WyVwISX2F24/34g6OuSW7y0ck
	aJVtWRr6mQdNLHWe1toUVzP4Vzb+82H16aBaotP6DwqWlWPup2ONmUxrRP2psz2BdhRF+zrH09W
	f+E+eqd5pl19ZU3LSwS/+vCUoMICk8UXs4p794Mauo1z91+QQFeBJJiIlqfVXKsmK54gnmqIu09
	oByYQVo/e9sHFDoUevJprJCCRasX8DRWTeP38
X-Google-Smtp-Source: AGHT+IECt7u/9qQGkVz0M8l72m7XI4NHOj3MUzKdcpcelojvKIeJ3ZA1Crkq5c7f9e4R+Lj32nMt7Q==
X-Received: by 2002:a17:907:3c91:b0:b3d:e757:8c3f with SMTP id a640c23a62f3a-b485becf38dmr356982266b.30.1759399373350;
        Thu, 02 Oct 2025 03:02:53 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83482sm177255966b.26.2025.10.02.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:02:52 -0700 (PDT)
Date: Thu, 2 Oct 2025 03:02:50 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>, 
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH] stable: crypto: sha256 - fix crash at kexec
Message-ID: <vz7xsyrtgg7ss3jlxfykk7frjiwm32nu72pc7pfi244g3ssm77@k7i7t7c3o4lx>
References: <20251001-stable_crash-v1-1-3071c0bd795e@debian.org>
 <20251001162305.GE1592@sol>
 <jm3bk53sqkqv6eg7rekzhn6bgld5byhkmksdjyxmrkifku2dmc@w7xnklqsrpee>
 <20251001165455.GF1592@sol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001165455.GF1592@sol>

Hello Eric,

On Wed, Oct 01, 2025 at 09:54:55AM -0700, Eric Biggers wrote:
> On Wed, Oct 01, 2025 at 09:45:07AM -0700, Breno Leitao wrote:
> > Hello Eric,
> > 
> > On Wed, Oct 01, 2025 at 09:23:05AM -0700, Eric Biggers wrote:
> > 
> > > This looks fine, but technically 'unsigned int' would be more
> > > appropriate here, given the context.  If we look at the whole function
> > > in 6.12, we can see that it took an 'unsigned int' length:
> > 
> > Ack. Do you want me to send a v2 with `unsigned int` instead?
> > 
> 
> Sure.  Could you also make it clear which kernel version(s) you are
> expecting the patch to be applied to?  Is it everything 5.4 through
> 6.15?  It looks like this bug actually got exposed by f4da7afe07523f
> ("kexec_file: increase maximum file size to 4G") in 6.0.

Good point. I've put my wanna-be-hacker hat and try to crash the host
before commit f4da7afe07523f ("kexec_file: increase maximum file size to
4G"), but no luck at all.

So, I would say we want to limit the backport from v6.0 to 6.16. In
this case, it seems the easiest thing for stable maintainers is to
"Fixes: f4da7afe07523f ("kexec_file: increase maximum file size to
4G")", which will limit the backport into only affected kernels.

Let me send a v2 and we can catch-up there.

Thanks for finding f4da7afe07523f!
--breno

