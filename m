Return-Path: <linux-kernel+bounces-824902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DACB8A6E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC33A8034D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D931FEF8;
	Fri, 19 Sep 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG5szcBt"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475131CA4E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297086; cv=none; b=BmZaz6b1nt5+F5p/kltPXjFV39xiPdt2tsBKPiKxW5mVutpV2WKSHVGOEwsOAUMWuX16Elzfan2oyl7mSfv4g5JsosU5lWjfRO/3ZssbVh38t5avxixkk3GQ6DQfC57MN/8wCogxKVUh13LMTPIj9CNjpmElLh/GHQo6PZq6QSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297086; c=relaxed/simple;
	bh=dQyUfF40H1BfACBXs1bM9Z16j+bX3eztAVI7x8T9QyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmQH4V2zdrBJdJhZp/h9Nkk9VPAth+kpORUdtUbAou7BS63NN+VdwzgqWwxa4Jvf4igCKu1dnr5vRvTeF3mzsEqfKj25HviqjINtqBPt8pBHv5pGF7+pwq1DgoAC1zW9CmZkXHnbXSvFPRfGGgTWIERTBmm4v/83UcE/1a4WRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG5szcBt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63053019880so52696a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758297082; x=1758901882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQyUfF40H1BfACBXs1bM9Z16j+bX3eztAVI7x8T9QyY=;
        b=XG5szcBtt+khLIa3V1bFWe61mXJw5dIg25jiE4Iwhf6Y7wtmS6AmIdmjNoXeRyb+Q5
         M/eCPNolH2Wvc3NcIenqEV76FPG9a2gFnXRnNxuc+YL/gbyTbKvZRYgGAATGsnA7Loti
         EX7x3Z+eQz7n+01+WFIwGV+MWNErlDx75CE1aBLvIqCCfEA+U0D7VCCwiHBgRbeja21p
         sP4G12o9q4iWEeZC+NOHSfdoMUvIqk41mH54qenYqMg7ob6XPFF3wWtN2sApvl0MMigD
         A0GToNs8n4uJmwp/TEyEVPQEeDhNPvr05xCj5ezgtxuNGckWqmGbc9E04F2WIzuvTAEV
         GySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297082; x=1758901882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQyUfF40H1BfACBXs1bM9Z16j+bX3eztAVI7x8T9QyY=;
        b=GZKomr8VEHlYITNqBoeRPuVcEobUGXSUK/t262LfVJoy0Q9eqbrH1GcLWvnqxO0RtL
         XJzXJDpc+SZcuKjunOTZkgJPrpKBNWagpJhlRNl0fV6X70u/ZwhXGFW967WNYiwy9rpZ
         +l/oc5cfCgn09qCsMVW+2FAQRrw3G4FDVRqnv6b0LT09mimrIRzIEVpTgZftE+6qPnb6
         QvG6722mYbQGnYe4R0Wk9/RLj30AjJc6anGGFZfFiiAd2cvdb4u3V8UEfpLs+qf06Y/p
         LKnBDU6T5gvfiLDPngOYzJ3FjCmJZsUZ8Std7c7jVCrsrG6QbCEhL4HXSuku2Al+fMLl
         T/0A==
X-Forwarded-Encrypted: i=1; AJvYcCV66V7bvLqY19ARFUL6fW/Xl/G/L1HUAu/BnVSeR6yxFv1EFGrSXCfCc/a2TG2cv52MkZEhVewgpPq5w14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8M0ez8J58XxNGbYq9FmmYQle7p8UFNguu1DRpsfezoZM+Vm2
	Uxpqtc2q3nROxWWxRR7ZviRt2OZHs59EwHmmk8GE1fqpQf0WrhxVS27YonoGGNjsU1fk5BKIe/s
	SfXYlyqf4excodnyhc46kpls6x3IWTMA=
X-Gm-Gg: ASbGncuvpSExQJFFLVljZR8q4opgPyNnjhlKFPS1Vpzj46ghLO/wXcIQOVJKrrnhnHQ
	PXwQv0OupoQPwuF+YtHVualLto4PnaFUb9Mqp22OsOQe0NHbCLbHowzy5KEN8bnIHayw29MYGGu
	yIKjcA+qtESn+NHosOP6xb4Un7kmZHZvfASd0SpQG3zMxU4PTCnWvlnAcJADRO/QRr6sCHCd4vB
	OsxqN8C9jlIwxkGRaF65K5+5CnymQLyS74/7/lXRokxtBHZlw==
X-Google-Smtp-Source: AGHT+IHMYIIjAX6ewyUslo99+c+F/Z/A6Ra3Vsq5RSMEC2P2mKWDv4Y0XysebCInkszOpKuAszEHVouh8UZ0MItB4g0=
X-Received: by 2002:a05:6402:4396:b0:62f:4610:ddf9 with SMTP id
 4fb4d7f45d1cf-62fc092b59dmr2993257a12.13.1758297082332; Fri, 19 Sep 2025
 08:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916135900.2170346-1-mjguzik@gmail.com> <20250919-unmotiviert-dankt-40775a34d7a7@brauner>
 <CAGudoHFgf3pCAOfp7cXc4Y6pmrVRjG9R79Ak16kcMUq+uQyUfw@mail.gmail.com> <CAGudoHFViBUZ4TPNuLWC7qyK0v8LRwxbpZd9Mx3rHdh5GW9CrQ@mail.gmail.com>
In-Reply-To: <CAGudoHFViBUZ4TPNuLWC7qyK0v8LRwxbpZd9Mx3rHdh5GW9CrQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Sep 2025 17:51:09 +0200
X-Gm-Features: AS18NWD5sjprDZ05x1PqO_AbsDi_64hioVxDvXeUQi-rv99l5X0YtG4bwFwHNwA
Message-ID: <CAGudoHH+=m8frJ3vLY=UoDt5aSSyF0XsmKBFKCK7nDfRxTC1VQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] hide ->i_state behind accessors
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:39=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Fri, Sep 19, 2025 at 3:09=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> >
> > On Fri, Sep 19, 2025 at 2:19=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 03:58:48PM +0200, Mateusz Guzik wrote:
> > > > This is generated against:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/=
?h=3Dvfs-6.18.inode.refcount.preliminaries
> > >
> > > Given how late in the cycle it is I'm going to push this into the v6.=
19
> > > merge window. You don't need to resend. We might get by with applying
> > > and rebasing given that it's fairly mechanincal overall. Objections
> > > Mateusz?
> >
> > First a nit: if the prelim branch is going in, you may want to adjust
> > the dump_inode commit to use icount_read instead of
> > atomic_read(&inode->i_count));
> >
> > Getting this in *now* is indeed not worth it, so I support the idea.
>
> Now that I wrote this I gave it a little bit of thought.
>
> Note almost all of the churn was generated by coccinelle. Few spots
> got adjusted by hand.
>
> Regressions are possible in 3 ways:
> - wrong routine usage (_raw/_once vs plain) leading to lockdep splats
> - incorrect manual adjustment between _raw/_once and plain variants,
> again leading to lockdep splats
> - incorrect manually added usage (e.g., some of the _set stuff and the
> xfs changes were done that way)
>
> The first two become instant non-problems if lockdep gets elided for
> the merge right now.
>
> The last one may be a real concern, to which I have a
> counter-proposal: extended coccinelle to also cover that, leading to
> *no* manual intervention.
>
> Something like that should be perfectly safe to merge, hopefully
> avoiding some churn headache in the next cycle. Worst case the
> _raw/_once usage would be "wrong" and only come out after lockdep is
> restored.
>
> Another option is to make the patchset into a nop by only providing
> the helpers without _raw/_once variants, again fully generated with
> coccinelle. Again should make it easier to shuffle changes in the next
> cycle.
>
> I can prep this today if it sounds like a plan, but I'm not going to
> strongly argue one way or the other.

So I posted v5 with the no _raw/_once variants approach.

It is more manual conversion than I thought, but it is all pretty
straightforward and contained to a dedicated diff.

If you still want to postpone this work that's fine with me.

