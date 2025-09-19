Return-Path: <linux-kernel+bounces-824629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE05B89B72
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FEB1BC3BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66730FC2D;
	Fri, 19 Sep 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnXbZG+z"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0F1DEFE8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289198; cv=none; b=rZsDvaEg62UrPrGmpUgEIeBC9jKpQfbU166wmJ3tLvS6kFGuh9qLZvMR0cxYEvgXMgD8j7ViFbalK8EWIaWzxkhuNXtyWALOYNwA5MpFSmtKBpqOaa0fH7dOgdU9ZtZJdjHfSbV2TR9UpXffSZKTvmFxmKXCi8ZxeGMJX3vWz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289198; c=relaxed/simple;
	bh=yS4tjevziR0toZXf/8EWO3F7qazDep+9Exg0qySjl74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6TNElLXFYlAOKhspAT524ZW6QdSA/zcPqw9yAJlwRVk2VAZiYQf68zrzssLN+3aydF10HAuWKFpeQWeWFVL+o09cVwGXtNRmT+VEKvwa61t6zyIt75j3GhKfm/NYOd+1Vxj7zyaNv40xF+CWFbZa80jSrWf/KzNmm1+14KZDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnXbZG+z; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fbfeb097eso1361614a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758289195; x=1758893995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS4tjevziR0toZXf/8EWO3F7qazDep+9Exg0qySjl74=;
        b=jnXbZG+zX9hZ6XwqFUrBGnWw27SogfV9/JKlKEpktyKWb5O2fIVJJEH8q4uuvODhoM
         724vvfts7YOcJAvxLoeFc/IKQe+Ive081Hyfw6FH7zWqjG9SUeHcESyxxpEnOUvgNiYS
         g/4hGXkCmSZDuRokbzpe5ZuklfVp+v2XT7rSWspN8SeXk5QrT/+qUN7UOpaJIjf6HLMy
         b3glQe4a1+2XTUVwoqJOUk+bs1iOIQW1aAk15/oq5o2B+7qpXGgT70twthgf/sMOq7Rc
         XqVI+L1igrk9IOoUilhvYVXZUFK8nN7jUl7YmCvz2FZIs3cVYMjxEFCNPF4ouhxL3fV2
         xxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758289195; x=1758893995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yS4tjevziR0toZXf/8EWO3F7qazDep+9Exg0qySjl74=;
        b=pBQLBn4s9PLmGOs2S1oKOonYbRXEgn75fsbCfqXIQ9LNbuzulCJYjUBSfejrOsbAbw
         ZG+I3CLjPNZrcICjrBeAckBaJeNtBk+7zivfTeQmENvwIeU6+eFrdxO1BoITmvY15+pM
         r1G0rMS6z0yHhBYF5TpDLDjkRQ6ZMfW6rDY1UNyhTuxlr27SVHy04a4XJ5gQGhmWZCqB
         1pv3Ag1QSQEvh3Xp24raFkGY7upaixB5sUf0VctUEgj/yNS0GOyTXjfD111NiNwV117S
         dZkx2cciTsW2UWAmSyX1D+tFLMTYs84c3zCO3giybwCGYUV0AJqWJ/8EafOWONA8dwot
         pCkg==
X-Forwarded-Encrypted: i=1; AJvYcCWOimEZe5sI96ykzlED+3/kg3VGOJJBYoJ1+Jy8UDSuH1eeNYwDhCdVKAhgPVx8LmqqdB6tkNFphXBf3bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfh6QX1pyYmZltiQvjNOyosFHZmRnlzH14WXJStyHkzPKOtSp
	5xoDnz9Pb5Civ6QvBtSkwAH8Y7Je7aZUzMGZ+RvUKa1s3U24sDaISOVh8AOBhIrObH3TrMBZQoc
	ptJ/EsYMgAnogLAp9FPmY4E72OhmrM4I=
X-Gm-Gg: ASbGnctJlyp6nRX3K/tQ9YooyVRTFiXN1OUWslVmMY4QrJBK4e8fhiAXHsL95IKyGoa
	BDXcoesBec57GAQd9CEfjWcvmb6oEhYUWBU2qN8LL5jj56FkMDbBerNJItlr+SHTVOzPZUE9u6X
	xhBLwvb7VSVdqJ2OYdtp7d3QabdLdQ9DS5O1JzDNFcI4h3bl/qIFR4zAnjQg/c4H6kJIFTi7bwa
	MNut0PAkEgxuAxjE94Etvq60/hASQm52UREzGo=
X-Google-Smtp-Source: AGHT+IG8y92yXBXG6PZ8P/ch2ZSS1wNstcNcIuj6+aYZ7P6TYOVq/b6w97srocc+Y3Zhyd7rZ7srrxYnAt6SbPx+jsY=
X-Received: by 2002:a05:6402:4612:b0:62f:36bb:d8ba with SMTP id
 4fb4d7f45d1cf-62fc0a7af44mr2864980a12.22.1758289194894; Fri, 19 Sep 2025
 06:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916135900.2170346-1-mjguzik@gmail.com> <20250919-unmotiviert-dankt-40775a34d7a7@brauner>
 <CAGudoHFgf3pCAOfp7cXc4Y6pmrVRjG9R79Ak16kcMUq+uQyUfw@mail.gmail.com>
In-Reply-To: <CAGudoHFgf3pCAOfp7cXc4Y6pmrVRjG9R79Ak16kcMUq+uQyUfw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Sep 2025 15:39:41 +0200
X-Gm-Features: AS18NWBesGPMB9d6nHQB7uHFd7U6Qkkb038pDKj5Q9kZX-8UZXEAoD__UTqjpFY
Message-ID: <CAGudoHFViBUZ4TPNuLWC7qyK0v8LRwxbpZd9Mx3rHdh5GW9CrQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] hide ->i_state behind accessors
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:09=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Fri, Sep 19, 2025 at 2:19=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Tue, Sep 16, 2025 at 03:58:48PM +0200, Mateusz Guzik wrote:
> > > This is generated against:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries
> >
> > Given how late in the cycle it is I'm going to push this into the v6.19
> > merge window. You don't need to resend. We might get by with applying
> > and rebasing given that it's fairly mechanincal overall. Objections
> > Mateusz?
>
> First a nit: if the prelim branch is going in, you may want to adjust
> the dump_inode commit to use icount_read instead of
> atomic_read(&inode->i_count));
>
> Getting this in *now* is indeed not worth it, so I support the idea.

Now that I wrote this I gave it a little bit of thought.

Note almost all of the churn was generated by coccinelle. Few spots
got adjusted by hand.

Regressions are possible in 3 ways:
- wrong routine usage (_raw/_once vs plain) leading to lockdep splats
- incorrect manual adjustment between _raw/_once and plain variants,
again leading to lockdep splats
- incorrect manually added usage (e.g., some of the _set stuff and the
xfs changes were done that way)

The first two become instant non-problems if lockdep gets elided for
the merge right now.

The last one may be a real concern, to which I have a
counter-proposal: extended coccinelle to also cover that, leading to
*no* manual intervention.

Something like that should be perfectly safe to merge, hopefully
avoiding some churn headache in the next cycle. Worst case the
_raw/_once usage would be "wrong" and only come out after lockdep is
restored.

Another option is to make the patchset into a nop by only providing
the helpers without _raw/_once variants, again fully generated with
coccinelle. Again should make it easier to shuffle changes in the next
cycle.

I can prep this today if it sounds like a plan, but I'm not going to
strongly argue one way or the other.

