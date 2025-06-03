Return-Path: <linux-kernel+bounces-672227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C8ACCC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 19:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D9D16C562
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951A41C861B;
	Tue,  3 Jun 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjkV/1HZ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAF1E885A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973330; cv=none; b=MTr5wyfN+vHe7e9Hb/rTX3Z+pq9zLB4BtipfLoWGNaufqcApBVZOUkbKYigDrah2sJSj4BQpTp7xDn9CjdlHJrLBheIVqGY4Rn2qLLzZQwu6SeehkPTn9vqNrlQ3+rGDndFEvh9OurDe++j0PnxIUXj1S66YBgsyVmebW73M8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973330; c=relaxed/simple;
	bh=c45GtF2NgyQzejp5bMuW+j3uJNUfGruUk0n0QKANtRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASYYHNLTsEi4hDVlaZNteM/hru+xqMv3zCTea93898/L+gNdrhYFNSubtO+c1GWLtiX8bzP3kkeQS00O8YPMh/gPcK6qqs5k3I7YME0qbwKZYPUAQhUgIjSve8LlA8agm4Ir9KWZdrX9wlZZY136hkzvp1wA+CnLoA1QWnVbwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjkV/1HZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450d726f61aso6475e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748973327; x=1749578127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojV48z9aXEdGn2OT2DKHUp0OlbWYdZap6cRg6lS1OBc=;
        b=BjkV/1HZAo2oT1JGkXxZBce8uxOv95DeNkjDV0I7zMUK0qPs52mUeS86fEvDkSkvHU
         pS1+VbnG6TPtIy3nOBfjYmch46u39kv8O4/9S015gYq72h4hXTyTG1uokcW3BHovLvxT
         Pg817zZcGs3HGBowvlgWBFj/cUVJXHx0QjSu1t7H69vVrcm+p+3IkC7TfXH7olyxVhLF
         r1NN0bhoEaLncaKB52jCeI4Y1uZ3tIljddrtDpFF87ZEDCSiXpGqKCjvlje4P2pTbKQZ
         UX8zvLufsMvFsOsXtaogmruKlC+f5KRmUMkQLRaGTsRaFHR4NhLN24Gtn9bJvTIY+3Hl
         BzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748973327; x=1749578127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojV48z9aXEdGn2OT2DKHUp0OlbWYdZap6cRg6lS1OBc=;
        b=QKZkgD+/fhHBANeA/tXjNlSv3K+owTFz1dvJsC4dDNOyo4N08tsgItlPgMrM6/zlOh
         oujOPDXGWB/W0Mm6HUkta8b4gf4LRAqsrbXK2DacSIrf7WV0yxkBn0oie1KNXj4Nx+Bx
         BKoxlG1l3PYyr4hqlptVfX/+DaP4azh1owDfWXvvANSi1VEI9SRlVeSFDD2Tah4qEEBE
         ue1EptYOWaydoXaZJWXpRpZ6QkdGmL/eQ07vLMTdsCT3zUMJt0TzvLyivkNZRYF1lYXB
         SqYR/IjlXTzZ4cIX0yMM24YzGG7Az1o7DPzQEm+stnV2udpn/5xG/2G7Jr9Qi+rbA/dc
         4CZg==
X-Forwarded-Encrypted: i=1; AJvYcCUihBIa5KPBRfzGLLSsEMupms1C3y8/mNbFfZq4/Hem2f7vvBpe0hDXtuEt2Bt/jl9bGg9LrgkpO/v+V7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJV/3LuThGiIjUiDrVBPGwnuGzzq6IxHRHhcxLYHg4QMJsa55O
	ljby2Fp30CS9KtXVLzT63CRg6iKwgKywL/YOLLAeEpEDHlD/Uy1HGsY10UGj8EGg6wGzgCDGHEf
	pDWqtc5FFdrLWKzTT4eBlscjKjt5KklwUXPqfZ+m5
X-Gm-Gg: ASbGncsujX9hhgeQLhCsFpmD/tBpc3rwsas9CYAkD5eryoj1UUi+ZeOeuGszI1XpgoV
	oLUgfXED9IXkHXzvZHanY7H2xIP3j/XuF1QfN2fFrhi0zMEWwYChNOjcLryl6GBtKeGktZpDhhO
	zLObiMekyhMUnggUuBJGgpcmyMmSDaRtBmH8KpbwWbbd5WDyNtLpDCgf0gda911+n4POsAnekYG
	rTspA==
X-Google-Smtp-Source: AGHT+IFn+MXcQMSx5ZelVSBHPMB42FF4a5qIDNqQvvUWSmhllHrAaiDMiLd4+ulqAvDPp91tPekjTDAKq0N4QZWV80M=
X-Received: by 2002:a05:600c:4510:b0:450:ceac:62cf with SMTP id
 5b1f17b1804b1-451e5fe840fmr2009315e9.5.1748973326911; Tue, 03 Jun 2025
 10:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512091108.2015615-1-skb99@linux.ibm.com> <CABdmKX1nhR3BXKyuLaAoo50KNyBwaexmH+af_s8WxULJUZ9+pA@mail.gmail.com>
 <CAPhsuW7pyQuLgq6S7+KQ3K-MdavmCzBb-tNhg9J_56X_yYug3g@mail.gmail.com>
In-Reply-To: <CAPhsuW7pyQuLgq6S7+KQ3K-MdavmCzBb-tNhg9J_56X_yYug3g@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 3 Jun 2025 10:55:14 -0700
X-Gm-Features: AX0GCFv_Lt9ScU6hcdIgKqcgflEyVE0GtXfNhaXJacaRBEaJF17vb8aAJZOjoU0
Message-ID: <CABdmKX0thb23TPqyuFvDeTXh56e6r6bT-QGabQu_FL2S=ScOPw@mail.gmail.com>
Subject: Re: [RESEND PATCH] selftests/bpf: Fix bpf selftest build error
To: Song Liu <song@kernel.org>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, gregkh@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, hbathini@linux.ibm.com, maddy@linux.ibm.com, 
	venkat88@linux.ibm.com, sfr@canb.auug.org.au, alexei.starovoitov@gmail.com, 
	daniel@iogearbox.net, mykolal@fb.com, yoong.siang.song@intel.com, 
	martin.lau@linux.dev, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 10:50=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Tue, Jun 3, 2025 at 10:33=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Mon, May 12, 2025 at 2:12=E2=80=AFAM Saket Kumar Bhaskar <skb99@linu=
x.ibm.com> wrote:
> > >
> > > On linux-next, build for bpf selftest displays an error due to
> > > mismatch in the expected function signature of bpf_testmod_test_read
> > > and bpf_testmod_test_write.
> > >
> > > Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_a=
ttribute::read/write()")
> > > changed the required type for struct bin_attribute to const struct bi=
n_attribute.
> > >
> > > To resolve the error, update corresponding signature for the callback=
.
> > >
> > > Fixes: 97d06802d10a ("sysfs: constify bin_attribute argument of bin_a=
ttribute::read/write()")
> > > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > > Closes: https://lore.kernel.org/all/e915da49-2b9a-4c4c-a34f-877f37812=
9f6@linux.ibm.com/
> > > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > ---
> > >
> > > [RESEND]:
> > >  - Added Fixes and Tested-by tag.
> > >  - Added Greg as receipent for driver-core tree.
> > >
> > > Original patch: https://lore.kernel.org/all/20250509122348.649064-1-s=
kb99@linux.ibm.com/
> > >
> > >  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/t=
ools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > index 2e54b95ad898..194c442580ee 100644
> > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > @@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
> > >
> > >  noinline ssize_t
> > >  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> > > -                     struct bin_attribute *bin_attr,
> > > +                     const struct bin_attribute *bin_attr,
> > >                       char *buf, loff_t off, size_t len)
> > >  {
> > >         struct bpf_testmod_test_read_ctx ctx =3D {
> > > @@ -465,7 +465,7 @@ ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRN=
O);
> > >
> > >  noinline ssize_t
> > >  bpf_testmod_test_write(struct file *file, struct kobject *kobj,
> > > -                     struct bin_attribute *bin_attr,
> > > +                     const struct bin_attribute *bin_attr,
> > >                       char *buf, loff_t off, size_t len)
> > >  {
> > >         struct bpf_testmod_test_write_ctx ctx =3D {
> > > --
> > > 2.43.5
> > >
> > >
> >
> > The build is broken in Linus's tree right now. We also now need:
> >
> > @@ -567,7 +567,7 @@ static void testmod_unregister_uprobe(void)
> >
> >  static ssize_t
> >  bpf_testmod_uprobe_write(struct file *file, struct kobject *kobj,
> > -                        struct bin_attribute *bin_attr,
> > +                        const struct bin_attribute *bin_attr,
> >                          char *buf, loff_t off, size_t len)
> >  {
> >
> > Should I send a separate patch, or can we update this and get it to Lin=
us?
>
> A fix is already in the bpf tree, with this fix as well:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3D=
4b65d5ae971430287855a89635a184c489bd02a5
>
> Thanks,
> Song

Thanks, I was looking for it in driver-core.

