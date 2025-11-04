Return-Path: <linux-kernel+bounces-884517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE3C30592
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A8D3A9B21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD429BDBF;
	Tue,  4 Nov 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf3pNu0C"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2226E704
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249550; cv=none; b=rM3AviT4L0ISdbNQlher2K44pWOKxOE90EacuZ1J1R5F8tadUs0TnbDyzH7ugsgb0kGOI4yA+9OdKKlb5mo59i2XWrR2lvU88629VWH15pDcDdQVJMPVPUgsVmaOMlGh2XfxUpxAqVvr74xmg79hmWVx29QhGQtytWO5PjsHVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249550; c=relaxed/simple;
	bh=Y/8kkJtUlvT/f8ywlYeX1B4ZoD/ySaLtnH0dGnqnmAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZh9F6F7V4iDtoAcTmjbIJySQH6JxZFXWIV0a0fYRvVepnKCa8/JEza30RbEq4zj0OLsXRnMFof/3uKa4gyp0hV5xFi7p3K1CjpVjmE6V/6F35TxLo+hPPPx8ojkMuNcqXial39kBEjGZyD9npYl+SasEiHJfC5jQQdTyLslkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rf3pNu0C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640c48b3b90so2682276a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762249547; x=1762854347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKJdWvkPbuojvyFkWrgOJDggLZVTca+r/oAisy+M4uA=;
        b=Rf3pNu0Cg1d48tOeaZtZaLUkE/PEszLIZCf1p0J0eQREPNueGK+mEQ6TOQwKX0fevP
         DG7Bf49VqBKXjMXfX+cxHFvoOdj0HEyx787WuG/kGgy0ZKASykSskdCNsJbQakDLDfmB
         t87jC0FfJaGK2EkHbJ2skXAhafGEtVnaWmFwNihX/9k+M/WkZkLc1S7n6MArxGDLViHA
         mxPiF89Dk7LQiqHnGfCi3TdkBqKIDuUcIWubluYRrUL9svX3Pgcse/je3swjxwnN1W1E
         gUlOLs/2RRZquqbAd/Rto2820kkWJatdFt7IFS0sjW6lP07/tMpw3G0PdkY6g5ulk8uB
         zzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762249547; x=1762854347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKJdWvkPbuojvyFkWrgOJDggLZVTca+r/oAisy+M4uA=;
        b=bGCzJt9BPDzcx3LL9tQT534inFRnVtUqhymFXBEsLJrg+b4KyVVemoHSahakMgvRlP
         8jLCD9nlXQr9L1EMwTxA4ZLHRv4NNJ5qmpKiCG4nzykAkhtOxnM42u2uHBaX4JmBjgla
         FwxKzOynr6dWEBOgtu60noUc5/obr3flMc+YQceQT+rV3opX6gHipLx0rVq83XEayRzB
         SR92sJ5mCUVmib6lGyFk9dFf9RzwEohH3MLZ+3THb2nplhBNd+rTku5PJEy9ttk6vfXL
         AZr1SuBqtlZS3OfdCGQEo2WaZgZsHiS8q4ssMbk2LYYcdQfdsz4DSgq/MWg+srLpk/HS
         4WFw==
X-Forwarded-Encrypted: i=1; AJvYcCVS/zaM3tc+SZH33tn3BKT8oOXt13E99VgZHCEZdmuDk9Hynjwhp0ncjstnKcVVfODLJV3TiQjB86/om1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFx5HFWZwfdllRpbPY7kzjnCV7FG8Y5atONKS3bCkfP+Dudj6
	685ghdISC+JIdCH9LSoUoaIFhPHRG3SiPvpTIfX3fssD3XgxAXHiqh+dkiAz9/9CqYuNDhnMFHO
	wBmUg+YUzlqmGleI7XZvkcJflpud5aJ8=
X-Gm-Gg: ASbGncvsknqDDjy5dsK9WIiphk89b4CByCNp1oCVJ8ZZKiEMYYM9iHr4iri90OjtNnC
	dgK3yB/AeyjBIGXVrIW6AzsYhxN0n0I9pFQTiB2z64GuopyaCOxKq6MVOm+JyzIDJFzUEHEA/h/
	fcgwO0s132LUdIZ4lOE55bupHYcQ4wLPvLOLoIMPe8fHc7jWkBkwrXF3rZ39hauc8nBDHZIGFXu
	wyLtHY2OuSbBVok2NQQoCTGLOludKJ44/fl+GTLwe8b54GlLgbIExRS676/MPGKUi3xpGjaqowA
	HUNb1g3PAu/y6Bcgeak=
X-Google-Smtp-Source: AGHT+IHXA2qJBi6f10DqUtNaDt/G9hT+Ey8B/WnoFdz3Hmrh6KCUpLdIDtROPfgXbvSfxz+h0BRwI+TkCKOqKrtbbyk=
X-Received: by 2002:a05:6402:1462:b0:640:ea21:8bfd with SMTP id
 4fb4d7f45d1cf-640ea219598mr1427481a12.31.1762249547237; Tue, 04 Nov 2025
 01:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
 <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org> <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
In-Reply-To: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Nov 2025 10:45:36 +0100
X-Gm-Features: AWmQ_bn9rw0ha0qFFSykU1xP6jfkkEMSMAVkMSHJG30ZX97XNHwd3yxbJVnihQI
Message-ID: <CAOQ4uxhw2Tc4YXwhkS=5EVC3Tg4F+QyrA7LE3V29pNhQ4WJeyA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 12:04=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote=
:
> >
> >         /* Perform file operations on behalf of whoever enabled account=
ing */
> > -       cred =3D override_creds(file->f_cred);
> > -
> > +       with_creds(file->f_cred);
>
> I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
> have this version at all.
>
> Most of the cases want that anyway, and the couple of plain
> "with_creds()" cases look like they would only be cleaned up by making
> the cred scoping more explicit.
>
> What do you think?

I had a similar reaction but for another reason.

The 'with' lingo reminds me of python with statement (e.g.
with open_file('example.txt', 'w') as file:), which implies a scope.
So in my head I am reading "with_creds" as with_creds_do.

Add to that the dubious practice (IMO) of scoped statements
without an explicit {} scope and this can become a source of
human brainos, but maybe the only problematic brain is mine..

Thanks,
Amir.

