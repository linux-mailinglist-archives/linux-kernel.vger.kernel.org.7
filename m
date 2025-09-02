Return-Path: <linux-kernel+bounces-797332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CABB40EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD777A857E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC662E8B8A;
	Tue,  2 Sep 2025 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DUPSSqGR"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F02E763A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846744; cv=none; b=QxdvA/6N4Y5cs9U7O3D/MNL5nbzLYWkYRCBu7UdIx/np5+tbN1TUleUv2PMA0VXezAFUw5ECFErrVL7LR+zwWwEpjjF2AyVl8qrvJ9USHYSKV86j99B99G2qjCrMS1BhIxBZLGvZ0Med4JUTMOfbXCQwrCDX1hLevjE7uc2J8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846744; c=relaxed/simple;
	bh=J9nG8nHGWXEat57wAwMEnyjPAAOUbLQ9R91NZPCq/Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5pVK9hgXEJwCPtf5AnxST3ol22i8GqG/kyKYtzLpvnn0ffYNaQxeiIOeZqR1TOfRH1DvoAEuvLjn0gfkVE0/d4XAqDbqU7ysZrI3+g0/HZCqP01ANt3YmtMK750mfxX2dYdo/CA0351AGoQpm/KW1S5yuS1UvGS2GefjJqgP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DUPSSqGR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so1450395b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756846742; x=1757451542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHqjHIQglM9tK4JfRDog5euxPxNLOlXWFw8/kHoTSCE=;
        b=DUPSSqGRyhJIfDv2vCrcwU01xeUlrqmwRL8NIvc8L8gk9vF1iPVxhwf5MfhC1oYYS5
         l9PreG8F0UhefIeIlqKOt/yGEMkqTQlqGImSOq5AXzITNNyFeKGrSm3vnu/wA12zOKsQ
         j0+ql+ExGryPbx1YSfsMxI/UL8sm0WLLBHdvbWHkqsRUavkAp3iN1ixoBehksG7uGtO3
         HBtrOM+/qT7jb4CX3FHyph5dBFQs8mieRubC2qqtDjRCFdetf7HxzXB8+bjO0HULSj9u
         SGay9pdtOkB9NHpU0sd1zq+5MzAFKODgMqB7i02cHua5yyzIj1yTvy7JMzNDlHe5xUo6
         KmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756846742; x=1757451542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHqjHIQglM9tK4JfRDog5euxPxNLOlXWFw8/kHoTSCE=;
        b=JSwPc4e1qf46XOMwX7E8mpL/WDWMKNGpc9ZFX+fZ2gf3eSmTGaDoSV6jaDZD5d+nW0
         QOWaaxzuq3WEWAn39dtFeJzNggZGdm6MzcbCoAa/WgDz3XqnecoGuh4JDaMQFg/cqUgF
         uZ5kbavNlJGT7uADXxW73OJVUYp/yTEw6sihG+jPnYS/isGz5u/UBcB6cDjgchhWe1DS
         lJ91FjPEZXahunMgMJGcHcvjWJw5XMKiJvDKs7+5NsJf1fs5wSl8R0a2ZoCD4SOpRnhV
         vhhX12q1uS8v+zD3WxNlQm/62P3ASY/F4b+eV9Kx0QwhpoVfo0Feo9405PnmZMKbU0QO
         JGVw==
X-Forwarded-Encrypted: i=1; AJvYcCUN59VH884TlaAodnh31bdugmcs1c7cUNyurUSqUEgjuuABY2k1SQA5CC4a6CaJX7PizHiRRnZz3dIxa0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0CluClQpqkPp9cd8TBLHUcg/Sgd6aI/zZP6Jyb9cLl2rQAKQ
	jZi/agsOsc0L/1pw1lyQ5e3RIKkdimudEp8qKHN0uC+L1ngVLGvxdD9zbdWp0wpZhTTjOfMQ7wv
	TT/UChwYS+E2skXwwQktOtKT0k+2ue26YXjib5pB7s03D7+3L07Q=
X-Gm-Gg: ASbGnctF5YoJU3EjYI0qZs8Zaw18U6Gfz6Dze9Z7HkeV7KvFSPHjcteufKUDm+esBbl
	XVEt1N3PdN1d3fE1x1xwgckhVOc//kq85R+DHSeMsmrJt3gKIGOd8mRw2ROmxQ2ku/oAFRK5rQN
	bkWTfHMXsH60ztjK+Mx9ZW3OAIayq7SjurFfCduUaK17yion6eOvKZno0q7CuDvGqzB7LKOachn
	8hAjf5zHlEc7gUkbA==
X-Google-Smtp-Source: AGHT+IE1fkssuy6KH7HrWuu3hk96oiKXN56SvxmU18nMFRkqxb2w1JoLMH9tRZQ1AZUqR+zEZU2ZkkVx8lfhABsQOlM=
X-Received: by 2002:a05:6a21:644d:b0:245:ff00:530e with SMTP id
 adf61e73a8af0-245ff0055afmr3376344637.7.1756846742483; Tue, 02 Sep 2025
 13:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902110049.4437-1-disclosure@aisle.com> <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
In-Reply-To: <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Sep 2025 16:58:50 -0400
X-Gm-Features: Ac12FXz4PNQBy5gQYBTLTutR4yE4-W2AMj1vXuCtuzSByaZveumuHQYDPD1cI8E
Message-ID: <CAHC9VhQnx38fdardU+Q=JF_8mXPZJ_UcMnOTnTv0zoNUvT_y_A@mail.gmail.com>
Subject: Re: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: audit@vger.kernel.org, torvalds@linuxfoundation.org, eparis@redhat.com, 
	security@kernel.org, linux-kernel@vger.kernel.org, 
	Stanislav Fort <disclosure@aisle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Sep 2, 2025 at 7:00=E2=80=AFAM Stanislav Fort <stanislav.fort@ais=
le.com> wrote:
> >
> > When a watch on dir=3D/ is combined with an fsnotify event for a
> > single-character name directly under / (e.g., creating /a), an
> > out-of-bounds read can occur in audit_compare_dname_path().
> >
> > The helper parent_len() returns 1 for "/". In audit_compare_dname_path(=
),
> > when parentlen equals the full path length (1), the code sets p =3D pat=
h + 1
> > and pathlen =3D 1 - 1 =3D 0. The subsequent loop then dereferences
> > p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds read.
> >
> > Fix this by adding a pathlen > 0 check to the while loop condition
> > to prevent the out-of-bounds access.
> >
> > Reported-by: Stanislav Fort <disclosure@aisle.com>
> > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> > ---
> >  kernel/auditfilter.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks Stanislav.  It looks like this problem was likely introduced in
> e92eebb0d611 ("audit: fix suffixed '/' filename matching"), I'll add a
> 'Fixes:' and a stable tag.
>
> I'm building a test kernel right now to test things, but did you
> verify that the path matching fixed in e92eebb0d611 still works
> correctly?

The basic testing I've done today looks good.  If you can let me know
about the email in your sign-off we can get this merged and up to
Linus this week.

> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index e3f42018ed46..f7708fe2c457 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -1326,7 +1326,7 @@ int audit_compare_dname_path(const struct qstr *d=
name, const char *path, int par
> >
> >         /* handle trailing slashes */
> >         pathlen -=3D parentlen;
> > -       while (p[pathlen - 1] =3D=3D '/')
> > +       while (pathlen > 0 && p[pathlen - 1] =3D=3D '/')
> >                 pathlen--;
> >
> >         if (pathlen !=3D dlen)
> > --
> > 2.39.3 (Apple Git-146)

--=20
paul-moore.com

