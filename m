Return-Path: <linux-kernel+bounces-874575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70DC169BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C8B73569F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF52034CFA1;
	Tue, 28 Oct 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DeBNj+QI"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96BA27A907
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679658; cv=none; b=iyx7TIb87pdr2Z6wWC/zPMcF5wzSE16ta3dZtO8QZ3QFcCF1ck8oyvU1o6dReoFlDKIpWm/Vs9wwQsvEs4NbQi1z8UoDCGDHq0sl7t/K0dQsGA9MYBuDR9n8LSlVodoo32mpbh8aM/Nvl7UApPPxrQY95+VWeI7uMMoE0ODGL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679658; c=relaxed/simple;
	bh=G5HCzAYepB/H8QFBd+S3Jv84NfK4AFg2L8UyCv80HgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E/EFsUrukdf+JT91TlBlD/GqLJVoOy9xZwfXpb9eEx97chH+ZTc0EdWa/J9k87UTWBr+PSahVIlIoFTr4oFi4ptPTIRk2EVEjcXfQ/5BajspL7xYXk4l7DUkoX4Y0FtrVfy56f014lkm9Y6W0aox/+hdps1HzYZbIPBH0r+fWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DeBNj+QI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-294baa12981so2238465ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761679656; x=1762284456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKxw5TzPszETpPo4Dvw1WW7pqwG+mTvhI73chB+SE4o=;
        b=DeBNj+QIzObIvDoxaZrN2z/3i0Plp2AFUHR+zbjXgr6BDpW5PoebFv4wshFj7FLG6m
         anRmXXOevjX1jkJ98Pdkh516hXDSeTObvbjjTbPMTwVj7BUg1dYRVQYt/63C0Z/ex+Gf
         WRkNTSZBJ2u3mGMN2utioOq4gsQ3BS6KBDsMAq61iaUIqNnyLU6vrYySkuznwYWEtLpl
         qSjX9C0r6KyBFQlSyME545we84MRpSTDleiglgvKEVso8V/DMrs66PPetxtjgKwF7DIJ
         e/oKdjIftXKMii4nrPHxRALOzvOq5LrzO5jvlHmb9QWd8+BTSjyATZ+Thc//K4GwmO9G
         Au6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679656; x=1762284456;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dKxw5TzPszETpPo4Dvw1WW7pqwG+mTvhI73chB+SE4o=;
        b=Zl7QSgUGDAIf3tPPIG15mcb7AeqNfKHXSqak4h94fNt2owIyFGvOlnqj/5eMFUoOFJ
         1rvRZRBSaIJdWlez7gar22r54rmXKv2NoVSYe4L5/3eCb3wVfjhtVAP42YTWaukiXjSB
         SlEh5cT3JMhW7r+ew+3HrIuf7BlvHhiH9mL8BGyyctsOTuAwNZkF0CP7LM5BaFdL7DYv
         aZ6HIborNBhxhKGpvLKRYppa8iSVKcS2cFoHNcrhVZ7mQJAmu5HRKuoEgsGLWkUCerL+
         RdOTZBsauhvmku8I2Ql7dkQuEqSW081vLWUcQKM3qBHAQ5MJmAdINwj5jPr/tj6WPqHp
         OGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr9R8rYlNPTEl2wfoxjpaxdyjyBlRXVAnMlR1H5mWRQGSImh2x7Vxq8676WBzhxas4ekRiq2PVYHED2eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuA6GzlPNGaWnpcwuOtYjYpmFd3SxQjP0dOx2H+WUJnYvScsFT
	sE93lzAQiV/pRc8MA39BJSsVqZBtG/KjtvA0aajW7mmuoXvibSBIhM5rRkTZ3Yg7kzSIXkgE/Aa
	HQKly1w==
X-Google-Smtp-Source: AGHT+IH947pREfD8AlyQoABHkMc3nxyjQUTTUzkRKn5YhSDU0NvItlid7gBOTFvypOO7ST6gx4IZEEdWBYk=
X-Received: from pjwy3.prod.google.com ([2002:a17:90a:d0c3:b0:33b:b692:47b0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d60d:b0:269:7840:de24
 with SMTP id d9443c01a7336-294cc753d2dmr47782425ad.21.1761679656014; Tue, 28
 Oct 2025 12:27:36 -0700 (PDT)
Date: Tue, 28 Oct 2025 19:25:31 +0000
In-Reply-To: <CAHk-=wj7s3VKFP2vLmEHhHZ=VBkr5v8J-Y47uzidnt=Kt+dzng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHk-=wj7s3VKFP2vLmEHhHZ=VBkr5v8J-Y47uzidnt=Kt+dzng@mail.gmail.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028192734.2591319-1-kuniyu@google.com>
Subject: Re: [PATCH v2] epoll: Use user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: torvalds@linux-foundation.org
Cc: axboe@kernel.dk, brauner@kernel.org, dave.hansen@intel.com, 
	dave.hansen@linux.intel.com, david.laight.linux@gmail.com, 
	edumazet@google.com, kuni1840@gmail.com, kuniyu@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 12:02:33 -0700
> On Tue, 28 Oct 2025 at 10:56, Kuniyuki Iwashima <kuniyu@google.com> wrote=
:
> >
> > Let's use user_write_access_begin() and unsafe_put_user() in
> > epoll_put_uevent().
> >
> > We saw 2% more pps with udp_rr by saving a stac/clac pair.
>=20
> This patch looks fine to me. Simple and targeted.
>=20
> > Another option would be to use can_do_masked_user_access()
> > and masked_user_access_begin(), but we saw 3% regression. (See Link)
>=20
> So I find this intriguing, because generally,
> masked_user_access_begin() should _never_ be slower than
> user_write_access_begin().
>=20
> user_write_access_begin() ends up doing a __uaccess_begin_nospec() on
> x86, which is not just the STAC instruction, but also a barrier.
>=20
> In contrast, masked_user_access_begin() obviously also has the STAC,
> but it avoids the barrier and only uses a simple conditional mask.
>=20
> So I get the feeling that you did something wrong. In particular,
> following your link, I see you describe that case (2) as
>=20
>   2) masked_user_access_begin() + masked_user_access_begin()
>   97% pps compared to 1).
>   96% calls of ep_try_send_events().
>=20
> and you mention masked_user_access_begin() *twice*.

Oh sorry, this was my copy-and-paste mistake, and it should have
been can_do_masked_user_access() + masked_user_access_begin().


>=20
> Which would certainly explain why it's slower.
>=20
> Can you show what the patch you used is?

I used the diff below as the masked version.

I noticed user_access_begin() is used in "else if ()", but I
think it should not matter as long as tested on x86_64 platform
where can_do_masked_user_access() is true.

So, I think the diff is basically the same with the attached one.

---8<---
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index ccb478eb174b..c530d83f89d0 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -82,11 +82,23 @@ static inline struct epoll_event __user *
 epoll_put_uevent(__poll_t revents, __u64 data,
                 struct epoll_event __user *uevent)
 {
-       if (__put_user(revents, &uevent->events) ||
-           __put_user(data, &uevent->data))
+       if (can_do_masked_user_access()) {
+               uevent =3D masked_user_access_begin(uevent);
+       } else if (!user_access_begin(uevent, sizeof(*uevent))) {
+               /*
+                * dead branch for __must_check.
+                * ep_check_params() already checked access_ok().
+                */
                return NULL;
-
-       return uevent+1;
+       }
+
+       unsafe_put_user(revents, &uevent->events, efault);
+       unsafe_put_user(data, &uevent->data, efault);
+       user_access_end();
+       return uevent + 1;
+efault:
+       user_access_end();
+       return NULL;
 }
 #endif
=20
---8<---


>=20
> Because I think the proper patch should look something like the
> attached.. For me, that generates
>=20
>=20
>         movabs $0x123456789abcdef,%rcx
>         cmp    %rcx,%r15
>         cmova  %rcx,%r15
>         stac
>         mov    %r12d,(%r15)
>         mov    %rax,0x4(%r15)
>         clac
>=20
> which honestly should be pretty much optimal.

I had this with the masked version, taken from perf + 'a'.

---8<---
        =E2=94=82       movabs $0x7ffffffff000,%rcx
   0.05 =E2=94=82       cmp    %rcx,%r15
   0.18 =E2=94=82       cmova  %rcx,%r15
  72.69 =E2=94=82       stac
   0.08 =E2=94=82       lea    0x28(%rsp),%r12
   0.09 =E2=94=82       mov    %r14d,(%r15)
   0.06 =E2=94=82       mov    %rax,0x4(%r15)
   6.42 =E2=94=82       clac
---8<---

One possibility that Eric mentioned 2 weeks ago is that cmov
might be expensive on the Zen 2 platform.


>=20
> (That 0x123456789abcdef is just a placeholder for the USER_PTR_MAX
> value - it gets rewritten at boot to the right value).
>=20
> NOTE! The attached patch has absolutely not been tested. I only used
> it to verify the code generation visually, so you should definitely
> check it yourself.
>=20

