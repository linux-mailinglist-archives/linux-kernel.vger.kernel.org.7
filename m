Return-Path: <linux-kernel+bounces-741237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934FFB0E1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2845D1C864F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937CE27B4FB;
	Tue, 22 Jul 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8vHy8OQ"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CCF27978C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201709; cv=none; b=TRZ520jl0HJ0UeTEHCNlynTleXfj8LZZMFVKx9+YSuNhk577kPUxc6WaSyv9WTkHPQ/7SfUedZ3V3O8sPWIafAUXJbHS1eYHzX6zy8iEqdWNxp0bN9d0Wx8dRCGq11NPZAJ4d9p3aNU9b2RSQfEOFPoLAtvdlFnTGNq43pniTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201709; c=relaxed/simple;
	bh=2ngJ2kRGxmj//2+PG4hWPab7EQBzvrPtsys183PFZbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaMQaVdU2XzTJdibQ4kj6RTtW826gNM7jKms7H5IhtDQFG6VQZzClNoDPsiqmTMrhQbUzlZ7lmT4FEU6GEzHMmJh8SkHjrqus/BZeo0nCMBa5GJ8/yGXonZOw3OLf2m/Fl3P8XmXUtXVkJGtUintYdBwyZbIB6nY0z70lVbqzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8vHy8OQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab380b8851so49274131cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753201706; x=1753806506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sCVh46Bww8YRXEQZffVRJrwKL4AozPZ8WZKTowec4g=;
        b=N8vHy8OQ9bsblLRAzmvynCHnw0vLIt+CFVyvhvdlDniFHfYd9TxvQgfU+p6upH4gjn
         YltGolAWxmtkvHQ3aB0TnmkKd4kMsngQt5aeBtoP1O3OOwoDQoA/Y8ZxOxHN0PKdbeca
         ApQGypgC5Nda5ihtdsoN9fMA0sPazRrDIBc53j7bZkX8qawu6cwSNT//qoFOmKlnqYsE
         U4yBhKrCXtIfNkEnV2mQ7BHs1H1+rMV1ZKFdrqSJgS2+hLO9snm2V/HT00gZi9/6zadF
         Fjuv9ZQe41MEEEZWQjVHphlgbppl4G55cKzn4ruNpm8HSCNX4Vj4XqDNwxeWnazvMS4b
         mOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201706; x=1753806506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sCVh46Bww8YRXEQZffVRJrwKL4AozPZ8WZKTowec4g=;
        b=wZisCg+MOkUUiDKiU9eDJobO31SO6OTQljMtWlPbHmIwg6kcLfnUlxUINbw2C+K4XV
         EHoBQ+/Q/BU2THoFoX6zXkRAHGZabRSIGQMT9p+p1RwvAGG9NVyy7DshH7MRligNok5J
         8AMI0oP75Wx+ZOPJa+QOgt645tTlRdzsEnugty+uo1QEu5yQ1idukHILZ9m3Jjq0kGIr
         w4bvtDWe9DcDUe2sIOhijExnBGK184SvAJXcN2toANl0JjUPDnx2Wjqi2KkJb800c34x
         TuC478/6QtOwaNVBNRPv2X6J9/l21e8UtU8/Do8GC1ysmGLCrXhUf4lvLEdbogEesQ+6
         YCbw==
X-Forwarded-Encrypted: i=1; AJvYcCUtK68/D0I19KHCv16DdFHloCFjDZMNzGQWQelaN1jM13iy+7qZ2ngw1pT36mcAJW1J1dJqosSs93Ax9y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4Zu9jI0Fc/ZXZZkWH+TC39Gp0j8XXQW+L9DIX5lzFZBTrYAC
	cJuHGjnXavZfWRtKRFZuD9JLkw3BtgZj5J/E3UQzIuGsyUlcCAXZr391nV//UrFoGHpFkhhqWpp
	oG+X7K2fl3eXIz1wTWdBKvktV4UW+bcqtHae5rTb0
X-Gm-Gg: ASbGnct+uiTMUP1H9XqtVuG04EdmtqqG5JFykPf8Dr9VAQhq5HCJIvFOj9+IqyapyIi
	bmqzMFMS5XBLabt82NtGIRFwgkgxBRTrlYHk8bf/OzIofOWAhi2Mjy9bP72CbK0J9unh9fgRcmp
	pXegHFe4EiR9VwvsnGs2wI7UmJr8viljCwsmHL3RPR9QwJDpZ/qVq6r5Y5Gf7hvbbTnPAEBVGB6
	Q8wGka0gdOSYiO3
X-Google-Smtp-Source: AGHT+IGKZynev0wRanI4s1eGTM+ft5BRNAdPwJV6J2EKTZZT9RumWxttQkZsc++d0yfo5VetxU5YpsYhHadXnkW1sEs=
X-Received: by 2002:a05:622a:15c1:b0:4ab:6e68:117d with SMTP id
 d75a77b69052e-4ab93d4837amr332784471cf.24.1753201705864; Tue, 22 Jul 2025
 09:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
 <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com> <CAO9wTFgzNfPKBOY5XanjnUeE9FfAGovg02ZU6Q1TH-EnA52LAA@mail.gmail.com>
In-Reply-To: <CAO9wTFgzNfPKBOY5XanjnUeE9FfAGovg02ZU6Q1TH-EnA52LAA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 09:28:14 -0700
X-Gm-Features: Ac12FXy4knn3eMDleOqMY1e7I4kseMX2vfET1LKRx4dKWQ_shE1ef1-YvpuilDg
Message-ID: <CANn89i+dif2qjKM6oO1o=BKutXoO6w9kWnnPfc50BDBJ7VpAeQ@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, sdf@fomichev.me, 
	kuniyu@google.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:22=E2=80=AFAM Suchit K <suchitkarunakaran@gmail.c=
om> wrote:
>
> >
> > WRITE_ONCE() is missing.
>
> Oops, I'm sorry about that.
>
> >
> > > +               while (i >=3D 0) {
> > > +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> >
> > What happens if one of these calls fails ?
> >
> > I think a fix will be more complicated...
>
> I did consider that, but since I didn=E2=80=99t have a solution, I assume=
d it
> wouldn=E2=80=99t fail.

But this definitely could fail. Exactly the same way than the first time.

I also have a question. In the Qdisc_ops structure,
> there=E2=80=99s a function pointer for change_tx_queue_len, but I was onl=
y
> able to find a single implementation which is
> pfifo_fast_change_tx_queue_len. Is that the only one? Apologies if
> this isn=E2=80=99t the right place to ask such questions. I=E2=80=99d rea=
lly
> appreciate any feedback. Thank you!

I think only pfifo_fast has to re-allocate its data structures.

Other qdiscs eventually dynamically read dev->tx_queue_len (thus the
WRITE_ONCE() I mentioned to you)

