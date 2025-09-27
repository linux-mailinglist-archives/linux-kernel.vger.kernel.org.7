Return-Path: <linux-kernel+bounces-834745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C08DBA5682
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136F56C0190
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305A211C;
	Sat, 27 Sep 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdXSwMcL"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A538B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931533; cv=none; b=t/9i13zatTeZlQbyNB0ieyictIkIUQrG1CsJdNeAtldyYtZwAXjoIc6lzj0wYlf54jQkZ1KgtK6HKxM0B3SxCl4rIGKfWMfX44jOKqw5ChVAK2TpE/sdM4c2MIVtr4SkKlJNWYHCOGxJaQqSf03JRtJghl1Sm0MTT1WX2Qs6vU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931533; c=relaxed/simple;
	bh=ZJcApcxweyRM5qb8q+BHO4zpFu1pgF/83cKbiJmqjlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVqB751YuaTvfKSeFtuL8ZqizyUn9PFmI3PfIR7f3chmE/ovsZe8wRnQJPAJGTPtUocUdwcJ/hn6ftsfoTtRAdeNG3KbdR9mw2VTIcz+EQYwJuXX6p/WtX0JzJpiHiMzmN12Z0DQBIXHD3/x6xoqm58yS2HmLt9iBe82rTK68u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdXSwMcL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso74031cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758931531; x=1759536331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJcApcxweyRM5qb8q+BHO4zpFu1pgF/83cKbiJmqjlQ=;
        b=AdXSwMcLHkbuAeLin/jsRUHVogbBkofvgtTdfaB5sUBV/SFUIpepZXRPwSRVgLdYKA
         SoK5XyFUYD01O3kx5Ze75xTM3jkdbdyQGUZ27kDaVbD7eNAqO5h84aACmhWjhnSn6hB0
         nvqJqg9JRNfNqbaxqUPkTAKpS70o+wGQe5JSSQkkZSZTmXg/GpH74cglHLARtLJvI7B2
         k1C0CcryL/uPa9y0FSjqvh4jO8leryN5I0KBgCHer3yqjR/qlTaEAitPU8QQsERjsSLW
         n3hDVMZylGkwauyCHpBC0fMsqL+kP7XOX/cKpnwu0QYZ5G65mSvnjG2Q0KITFtUEjkP3
         dpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931531; x=1759536331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJcApcxweyRM5qb8q+BHO4zpFu1pgF/83cKbiJmqjlQ=;
        b=aXx8h4f/FzUjIbxQqll0TMAN7n/uF5CPIjjW90MiHjkA8AUOWkYb3iq3EoRsc2ApWR
         6ypbEIZvnDIUoIgtLQfiQZ0GauIN3pGscrpMF4DnMPK+rZR2ZqpCTDcRh3DuRO3cRoPq
         qa6TpJuxgtINuBKtGJvgBxMFMPXsLr5jHyPInTndYW0lPmqgpVrkyHQc0JD/cwfZYiEC
         B0YBbz1l28ckb+4j7D36BD0KCVwiVnlKMU+Xk/JBEc5SUrf6UCeXSm9OZrX29bPuRmpZ
         selQfkSMYe7+bb+gp+k8bvWheFifK4EYPT7kZfo0chjn612MWkwHhB/tkr7Eomwwvg3V
         COwg==
X-Forwarded-Encrypted: i=1; AJvYcCWQQzHf55EkjZkBTqBDDsA6n9lTUy294r0EiZvuIHLxa/9aorwO3AqNNlaS4EWTZblMQbQ160p6BOdpAoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYtW+Kz7vkTow0U1W7WVCazQ2iyUOeY1sgevtx40jAkFUCkzfA
	OcQKCb466aMwVmZVT0WmuyqbQk/BajeLvEbkab3jC84ef3ThYO4pEnCkmuvfUsyNOdeZWHlAtf9
	j6415VpxaoUzIp96o2q31tLAYti3kckOL6os8lqXW
X-Gm-Gg: ASbGncuGS166YQhH8WyOj6k/H7p4HSZZSfe595SI+XEs7eJWi+O/Q+ql8gJcoa+oPeC
	1AkyKwQBVMYxrm7fSwoWeV6hhPAcf5yn/RBgBgE3WEM9eClgYZHSwmFT0eUJljICGqGJ2N9BVE3
	G/VimbszswXfxcSTWJznNHTqRfaBdgHprXShgUdUvRunOeqf5yibcM7Okxfzl5UHMZwdubyyJY1
	I68bj1GdRM7F/qMb56FxzY=
X-Google-Smtp-Source: AGHT+IHLCDngHaqm1d35Zq76dt69sq1Eb8/W3LhpZr4vmuXG3Ed3TJ7vkp6zVFZA5hFCJnDSxn7t311TgnkpSyfh7dk=
X-Received: by 2002:ac8:7c4b:0:b0:4cf:dc5c:8c76 with SMTP id
 d75a77b69052e-4dec6c15531mr2551671cf.11.1758931530143; Fri, 26 Sep 2025
 17:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-18-ca3099d8352c@suse.cz> <aMqfmzwCu1N_L1qp@hyeyoo>
In-Reply-To: <aMqfmzwCu1N_L1qp@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 17:05:19 -0700
X-Gm-Features: AS18NWAQPijqIrQ4xFfoBcVJ2l0qQApTG79Ewx2_B0nlbyTUd16bMIuKaNKF2Mc
Message-ID: <CAJuCfpF52wCCrddQizzsMHF3myuD7JsH6p8DZJgN8J+DGHx2WA@mail.gmail.com>
Subject: Re: [PATCH v8 18/23] maple_tree: Use kfree_rcu in ma_free_rcu
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 4:46=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Wed, Sep 10, 2025 at 10:01:20AM +0200, Vlastimil Babka wrote:
> > From: Pedro Falcato <pfalcato@suse.de>
> >
> > kfree_rcu is an optimized version of call_rcu + kfree. It used to not b=
e
> > possible to call it on non-kmalloc objects, but this restriction was
> > lifted ever since SLOB was dropped from the kernel, and since commit
> > 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_dest=
roy()").
> >
> > Thus, replace call_rcu + mt_free_rcu with kfree_rcu.
> >
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
>
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Cheers,
> Harry / Hyeonggon

