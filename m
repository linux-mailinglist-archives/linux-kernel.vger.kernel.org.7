Return-Path: <linux-kernel+bounces-899354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E5C577B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 602274E4804
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185A134F481;
	Thu, 13 Nov 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JUhuZbL5"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19035979
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038105; cv=none; b=d9GTzXgxcndahtFuIUXShAPV+jiKnmJaDvvLA+pFO4bH8B4RRqIy7scFzOM+sHB1XswdVIqhYllvWcUlxRVF9tlB//E8HnP4YguF3+5py7ZX+Ie6tF7xZzcfG6D8G7VkEEvYGk70seP0UG1vPG983pCuXbQSJT8+NGGvqz1lBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038105; c=relaxed/simple;
	bh=0WAjlQlYd7TRhzy9CdLhI5NpDR8tBXFa7yz4Q+j/n/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAWWT+evh0Ddoe9J36XxAmB6A885eRPP7WjX1xlEw5zQH0ruegmd0GRo9fv91869uk1L+H3+8SyS7uWxMNiyTCzKIW+g9DBKb3yKjAFlWh5WYq6/aLlczH/bPl2zZL+o6PwUK45Ka97x8ENqJSR/lNz58D+47GTEyDHva7Qj4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JUhuZbL5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b32900c8bso468829f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763038102; x=1763642902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9KdbGIqeaFLzm3aG4RneLOSJzVNfE/rTf15PS18ARmI=;
        b=JUhuZbL5noPKEQYrE8nvrYih7GrzMAnbXt4ls8613BU16dxxr/27Q4k/NLxwPy3up8
         zcqOxfaz7UXNEpPqWZO4EhD0IghhwaExVYERhgTo9h4qm1ghLE0as8xoHMBl91fp5nue
         0AhXBbKoaTGk1JA6SkFb5Pmfrk0MkyeWPTkpnRw/LLFpOTM74xxCBr228v6+ja9oGARj
         aPAS09JSPAT1DAWObtFqQzu6NYoDDzpDtSPGz2OEy87bzr482xKEv790eu9lCkInLqN6
         ntFPpaMy6eR4RI4ZeyjgvLwzo/8w5ZrFGPSXcwkt6pO6lLCqyzVfzdfhEnCK3j5Kf+sd
         W+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763038102; x=1763642902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KdbGIqeaFLzm3aG4RneLOSJzVNfE/rTf15PS18ARmI=;
        b=U9hJNQjYVp2p/BtkjJ6NECoqkwRFoxZ05H9EB0W7o1azqAXZSrxYZrXJ3d1uRpCbqs
         Z+rPCSbsER5r1x1yfSVxtpnClVaun1znHW7P4OtH2GdQdkiZXnxjTTbI3PEi/ZYIwZrS
         8wsWNVnuuZiAFIdGdJ+dEwhCM6UuJNPXJPK1AHWp/N9B5rAg3SOu43lLGpi1QkCX8MCN
         flakrYqVEyDy9nqRUZuKLtxPEmuzEe7nA+zToByuhoBZT9jKtWLF89t7lQilVRy+t64D
         z18ANWw/JYjCREL6324fQr614zugXMYImjk2C+eWt2Zpfe9Fe8GzA6HQ0Ft4pkaTrC5B
         smeA==
X-Forwarded-Encrypted: i=1; AJvYcCXIo+oE0xE526FWdAmuP446My8JVdvVPv0yF8SRwM5QXiG85NJPDM6KOVDgZ8scc8QJ50r634//ljWgsz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/dQ+qX+hpxxlnyS3Cr12meg+QQIlYdOkhQeo4bF5DMP/4dkT
	eryh/biHpodtG4H5XfI4KP2X0skDioqnhNyAzDCZ7eLYuL6FO8OCXSSMXHDKv/bcIy+P+MT99eX
	nRryzYOW/7LCvSEdNh5Iwjbks9WVoOCAWbNCvMGCoNQ==
X-Gm-Gg: ASbGnctsx5c3aoSqNJ85MQHOR4Wf7hEM3IQGgJhDqsRsroIJSjy9rw8X/mkc5UCZ/8G
	zqYI7V6+OVZMlQhmgfUCvfy9ndub7GoyiNaKK+72HXHUXlFigIUQoT4wYhQXm0BiaZiesxJmi/4
	aIDmR9zj+UsjqdRenAiFuZK8ckCdz7UgPf07ui/WirE7RW2sV4O9VYht5V/E88FtPFWvKK+Y3JD
	wnbNrn/gINVMWasf3zwJLBxUpIzPWQ31fLtghRkHRb0M7ckLU2GMBA3u6NVq5Gy/WBXh+StzkwV
	+TpdxDc1vszfxkmylnQjETXp4Cpl9of/RZk330oWNy7RtVXSKcnng88b4Ri0FGBICTM6
X-Google-Smtp-Source: AGHT+IHKmx9M6WBv+Hyb+0Z08254rZnAw2KSTYKn4pRIYlIFATqmMcfv5MK4qXd/zptuAkq3icKcnKyA1oTq2TZ3w8Y=
X-Received: by 2002:a05:6000:230d:b0:42b:3afa:5e1d with SMTP id
 ffacd0b85a97d-42b4bb94f93mr6600961f8f.20.1763038101809; Thu, 13 Nov 2025
 04:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762972845.git.foxido@foxido.dev> <5bfb05436ed8f80bc060a745805d54309cdba59c.1762972845.git.foxido@foxido.dev>
 <0a31cf84-ccfe-4da4-b922-85da570c6e3b@gmx.com> <20251113085403.GI13846@twin.jikos.cz>
In-Reply-To: <20251113085403.GI13846@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 13 Nov 2025 13:48:10 +0100
X-Gm-Features: AWmQ_blM8P4UEnEduwT6zsPb4XIz6qGyFcaQirwGNuBT5XDZ9lpihdZeuC9h5AQ
Message-ID: <CAPjX3FcAE--WHP78jvpXy-aBUEmX9e3FK=F68v-f8sPJbi+CTw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] btrfs: simplify return path via cleanup.h
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Gladyshev Ilya <foxido@foxido.dev>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 09:59, David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Nov 13, 2025 at 07:20:01AM +1030, Qu Wenruo wrote:
> > > --- a/fs/btrfs/extent-tree.c
> > > +++ b/fs/btrfs/extent-tree.c
> > > @@ -1878,16 +1878,14 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
> > >      * and then re-check to make sure nobody got added.
> > >      */
> > >     spin_unlock(&head->lock);
> > > -   spin_lock(&delayed_refs->lock);
> > > -   spin_lock(&head->lock);
> > > -   if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op) {
> > > -           spin_unlock(&head->lock);
> > > -           spin_unlock(&delayed_refs->lock);
> > > -           return 1;
> > > +   {
> >
> > There are some internal discussion about such anonymous code block usage.
> >
> > Although I support such usage, especially when it can reduce the
> > lifespan of local variables, it's not a commonly accepted pattern yet.
>
> And the discussion is going great, I think we wont't find a consensus
> without somebody either missing a coding pattern (you) or suffering to
> look at such code each time (me). Others have similar mixed feelings
> about the guards use.

And yet I can imagine even wilder creativity like:

> +     scoped_guard(spinlock, &delayed_refs->lock)
> +     scoped_guard(spinlock, &head->lock) {
> +             if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op)
> +                     return 1;
> +             btrfs_delete_ref_head(fs_info, delayed_refs, head);
>       }

Here the indentation is irregular, but still looks kind of just. Would
we be happy with such exceptions?

Otherwise this could end up rather mixed and that does not look
preferable, at least to me:

> +     scoped_guard(spinlock, &delayed_refs->lock) {
> +             guard(spinlock)(&head->lock)
> +             if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op)
> +                     return 1;
> +             btrfs_delete_ref_head(fs_info, delayed_refs, head);
>       }

