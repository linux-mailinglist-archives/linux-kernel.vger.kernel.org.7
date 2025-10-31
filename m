Return-Path: <linux-kernel+bounces-879555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D997C236B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF9404E57AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0984E2FA0C7;
	Fri, 31 Oct 2025 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btC5pFhw"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E725A659
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892672; cv=none; b=KDhw8ANRmMhBuPvDCRdVnNr+uZTzv9cCCyMgPGdpTyQhbJUXVUaYiS1XRilEcaNoTcEJ6W70i1Q9DymPNzJsb0yo0TxCuJjfI6JVtveD+bjpwHJHl3YF+uiIMUCHYDmCECtfLW/zJRL9omZ/syeNYFit1mUdEcSvTeoDApZa6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892672; c=relaxed/simple;
	bh=2Ad22H+YKv3fYSdPT9lbgu9VOjM2ntNDuMEpDFLqgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOz24fwRqBhTtlu9KsPZZdkZm622eBY5iif80Bplnc0+DiXHFAX15DiLIMSAoDXkjZmyhWziFRxyEQSwx4/OwbXsdMaik/WmtCLN0w5QGJHKnp09B3KreZRlClz5IZH+6cxveQjo6TAWDMdoTKwqqjMc/kEKksETkvGqp1f6r2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btC5pFhw; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63bc1aeb427so2144545d50.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761892669; x=1762497469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kS/Ba8wi03ja6q2G16rK+mBdR0oPZku80viIJSVlHq8=;
        b=btC5pFhw9xkOhNITbRDEeX7IBMIZfwYedGjRscgJPL5mMye3/SMxm9v29/ac19vzwa
         dfn+IkIVJgQ+WMC3khNXLZ/sAn8v2ZWJzzt4+lYibX0NFt5ohfLfAe88GKdp8C7ATn3h
         NWXy1qWWHI/aocmoy/uBTMz/tBTNShHJHaXE9sypj30n8Rt5VnOeGtxAV3Z1w1NlCP0P
         KK9xOks9qIIXQIOdqIi1yYlXq4PNaF9XjaF7KP6j9h+/mI1fdV/f4820a3lPFvwcSNKC
         TGZ/zLnCd+MF54M+dO8vkYPhQAOr4zg20T+w3VqEnRRvET27VeU137sewizuwgVlnG6y
         ZBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761892669; x=1762497469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS/Ba8wi03ja6q2G16rK+mBdR0oPZku80viIJSVlHq8=;
        b=e2ugCE1cdGcWh3lXJu8Y5V0ZhAx3hM7xeJd6yqjyc3GELgthU+UhfeSKdntMHrtwf8
         dEpfb9jP/rcFGw59oqdeW2dbLsVERsxkknB4iB5KMTyf9IGGqajUjJlsxcmhUWu4u2GA
         PzZKl2B4rK1oklEiclZzv/Nvn/64dRBT9/mfHMVRAdi7mB7/XdJ2ds/j2P9JvtlLLxpl
         NUhEn+v49+qXsQ2M3sbMPdrgwxCNb7r7lAijrGe5xx7ZOazlrPUGqbKq8Mmc0EbpXoAU
         iVjcIDZ90a8gaZi4guS0fjH83Y9//te2Q38kAxex1IHNDtnMJuNMjMNIncMGhZNYAP0i
         scaw==
X-Forwarded-Encrypted: i=1; AJvYcCXgm4E3dogLczAsNKvcG2bPbpDug7WsfOW1nl7zadgN5u0eHfRm5/egAVr9Bf8G4ArwZ3NqaseoxlloXGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFLWYrzoFYrucqTR/1mqk3pIEutw9eEGZlCKxnS2B9Fstbnt8x
	4osn2u46Rpa94MVAoWbM9TX1IsWMOkPH4OmWA1vgcoWQjjxug3TeNu89
X-Gm-Gg: ASbGncsvg0wW72I4qTRmCaHBBq/NgqLVq2gXAJj2Te8JuJYOjJUHiGQewXG3KrXLjVP
	R6WPgpC6mVmFxPYyg3xWp0qhY45aY7VOnt1UTaKyRcnft1VzES8FEQgEQ5pnDz/+txrqLg4NZuk
	tkY4nlEHjNWX4UFngyLJKLMt9JzLFO/907AFflKqkTC5ajo90UAO6AcotrnEG9MITSsetUrVXJW
	ZUfm/2sCr3hMl9zHFKLfhsu37QGOMdY6abSBPwd/TZ94Yny5k4GxHfU/JbGrwDppQYn7OGGyfPE
	a84OEq1gOYF/jDV5cOheeJvwpaWFhj54IfGR5yLVzgxkHVVJ4axUEUXLecA98ptX2gF5TuTbR+r
	W38EEc5SYuRLF0Ty35yemzvODCm0GH4WF8uGczlyyyC5AUDxHQb+GvItI5QvC5lB8HTjU46vM9j
	+fBOXCwk8N1pWXa19VNQLxXutwCIjJeQS8OOSflVA=
X-Google-Smtp-Source: AGHT+IE8N0NuNxDPSMdh3gqIxDWFygZpV4mjnnnjXKw/xdAOq6rsstqv2KVKzg0erHaerfWTmEpODA==
X-Received: by 2002:a05:690e:282:b0:63f:8734:36a0 with SMTP id 956f58d0204a3-63f92272105mr1346690d50.21.1761892669464;
        Thu, 30 Oct 2025 23:37:49 -0700 (PDT)
Received: from vegg ([2402:a00:163:2ce9:84ab:c8ef:8e7:edf3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c667d3dsm2850837b3.42.2025.10.30.23.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 23:37:48 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:07:40 +0530
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	virtio-fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: Re: [PATCH] fuse: virtio_fs: add checks for FUSE protocol compliance
Message-ID: <20251031063740.tyeewgtp7zo2gdi3@vegg>
References: <20251028200311.40372-1-brajeshpatil11@gmail.com>
 <20251028200755.GJ6174@frogsfrogsfrogs>
 <c7zugpb4pzquasx67zypnuk2irxvb7cp5puwuw3rncy6gb5wdn@qigavsewium3>
 <20251029060108.GR4015566@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029060108.GR4015566@frogsfrogsfrogs>

On Tue, Oct 28, 2025 at 11:01:08PM -0700, Darrick J. Wong wrote:
> On Wed, Oct 29, 2025 at 08:58:30AM +0530, Brajesh Patil wrote:
> > On Tue, Oct 28, 2025 at 01:07:55PM -0700, Darrick J. Wong wrote:
> > > On Wed, Oct 29, 2025 at 01:33:11AM +0530, Brajesh Patil wrote:
> > > > Add validation in virtio-fs to ensure the server follows the FUSE
> > > > protocol for response headers, addressing the existing TODO for
> > > > verifying protocol compliance.
> > > > 
> > > > Add checks for fuse_out_header to verify:
> > > >  - oh->unique matches req->in.h.unique
> > > >  - FUSE_INT_REQ_BIT is not set
> > > >  - error codes are valid
> > > >  - oh->len does not exceed the expected size
> > > > 
> > > > Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> > > > ---
> > > >  fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++-----
> > > >  1 file changed, 25 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > > index 6bc7c97b017d..52e8338bf436 100644
> > > > --- a/fs/fuse/virtio_fs.c
> > > > +++ b/fs/fuse/virtio_fs.c
> > > > @@ -764,14 +764,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
> > > >  {
> > > >  	struct fuse_args *args;
> > > >  	struct fuse_args_pages *ap;
> > > > -	unsigned int len, i, thislen;
> > > > +	struct fuse_out_header *oh;
> > > > +	unsigned int len, i, thislen, expected_len = 0;
> > > >  	struct folio *folio;
> > > >  
> > > > -	/*
> > > > -	 * TODO verify that server properly follows FUSE protocol
> > > > -	 * (oh.uniq, oh.len)
> > > > -	 */
> > > > +	oh = &req->out.h;
> > > > +
> > > > +	if (oh->unique == 0)
> > > > +		pr_warn_once("notify through fuse-virtio-fs not supported");
> > > > +
> > > > +	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique)
> > > > +		pr_warn_ratelimited("virtio-fs: unique mismatch, expected: %llu got %llu\n",
> > > > +				    req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
> > > 
> > > Er... shouldn't these be rejecting the response somehow?  Instead of
> > > warning that something's amiss but continuing with known bad data?
> > > 
> > > --D
> > >
> > 
> > Right, continuing here is unsafe.
> > 
> > I plan to update the code so that in case of any header validation
> > failure (e.g. unique mismatch, invalid error, length mismatch), it
> > should skip copying data and jump directly to the section that marks
> > request as complete
> > 
> > Does this seem like a feasible approach?
> 
> Yeah, I think you can just set req->out.h.error to some errno (EIO?) and
> jump to fuse_request_end, sort of like what fuse_dev_do_write sort of
> does.  I think that sends the errno back to whatever code initiated the
> request.  I don't know if virtiofs should be throwing an error back to
> the server?
> 
> --D
> 

I think it is okay to set oh.error in fuse_dev_do_write as it is a server side
reply. But as virtio_fs is on the client side and oh.error has been set by
virtiofsd, I think so we should not overwrite oh.error. Instead, if we
encounter an error in any of the if conditions, skip copying arguments and jump
to the line clear_bit(FR_SENT, &req->flags).

> > > > +
> > > > +	WARN_ON_ONCE(oh->unique & FUSE_INT_REQ_BIT);
> > > > +
> > > > +	if (oh->error <= -ERESTARTSYS || oh->error > 0)
> > > > +		pr_warn_ratelimited("virtio-fs: invalid error code from server: %d\n",
> > > > +				    oh->error);
> > > > +
> > > >  	args = req->args;
> > > > +
> > > > +	for (i = 0; i < args->out_numargs; i++)
> > > > +		expected_len += args->out_args[i].size;
> > > > +
> > > > +	if (oh->len > sizeof(*oh) + expected_len)
> > > > +		pr_warn("FUSE reply too long! got=%u expected<=%u\n",
> > > > +			oh->len, (unsigned int)(sizeof(*oh) + expected_len));
> > > > +
> > > >  	copy_args_from_argbuf(args, req);
> > > >  
> > > >  	if (args->out_pages && args->page_zeroing) {
> > > > -- 
> > > > 2.43.0
> > > > 
> > > > 

