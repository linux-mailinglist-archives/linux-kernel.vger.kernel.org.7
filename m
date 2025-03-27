Return-Path: <linux-kernel+bounces-578181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11619A72C00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 10:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA0189B3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0720B21A;
	Thu, 27 Mar 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHhu4LvC"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7720B21D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743065976; cv=none; b=btEIqXOHCm1WjCZHsE5/9kg8zfGw7xweLOk6bLV1ijgwefGkIDtionjzO87NnA6LCWozjvClkWeTG44bGgjoWrizg0UM7BiSQrrlhSpD7CXPQ73vlTbufRw8TRkSc805Gr/R9snq8xNCkokxNmFqWySiFQctROohBojrCwfggV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743065976; c=relaxed/simple;
	bh=PJySQcnM2gEJgqSvsTA0iKQyJv2f5G7NC7T27Z6UBUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqsk1pQfu6klaITvt36mZRzusKtPb0lyuOSNrOwi76vb+OHo5SuM/HbA1RhsHeyZOr8MigYR+eY1MF6IOwqLnk9UO+cAMOOznympuFRhBe9GEL27+RRcft72gNC/FMGYY+g+Lb043q0l0oHOyhaw7MlquXi82XYx2gha4SJ5bYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHhu4LvC; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-477282401b3so8228961cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743065973; x=1743670773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKYf6sJzSF2m7isaVeqD1yLNbBPnebAaiEGfNFOSM2s=;
        b=XHhu4LvC6WWKD3YC3cqnDNijwJM5U/ToGJXXaUFhUA1OYAww/IlMNv4TCVwzv2jk+x
         nT5/bG2uqWmyis+22EQAOA2aOvYHkqeW9NBJ5dv+Qs6u+VabhlWjmAKOg4Aky4zUQx7I
         taetQLE6Xx9EdJKibfwe/MnT4Z992sK6BEchJc7Lmnth7+9cdrNLvSNI4QO0IxqGXzzq
         S5wX7wIKqZRIU5FQZpAofG8ym+gl+ad0gBiAN1ceY6c2TzszspMijTUNhnH8oBAp4C3e
         zo8WcxAZPQrcnlWWU9arMHaXfQMA5o6GTjyFgrtBQbjViCkOaIWTULOuJxpxFNgtlzbr
         PQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743065973; x=1743670773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKYf6sJzSF2m7isaVeqD1yLNbBPnebAaiEGfNFOSM2s=;
        b=T0YCWklwVnhId6NbHuTS7H3Ov9RC0xNXeZaVEbAw5kohM7i8CAas9hvGcRl2Ml5L/8
         Mi9VcFjwdXm1FkGXMLxlxG73zdrGwRgiC4DAXgn80/7hiDMh/msHbQeK62VzMm8BQw+x
         jfyj7wSdl2yWrJqpPVnFaaX80lhO16k6E0EBzVEVFy7qtHJFLoNfpU1+EVUqirD0bZ6r
         qVn7ajAUE/MCl4lZzZ6ndCIwfIibY82ho2ijS5KdqwuNHVIgy8cSe8P+HNisO50E19JT
         8HnHHA1X0kJSOfRUhwTR8rlJvdMMk3p8AwGf3JqRWi6lHlB2njrsLdhiPowvCf40Ucj2
         xT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWt1CKE3/4PVqP1AgBNG/6HAho2sC3gqKCjFx3YA9PYxGEyP1dyZgSSkPvglIk8eNFl4Gb+vv2DQnnkUhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/IQiaRo/Kli0C62gyHWy1c+l9e0WdIdRK7JkfHB42C1Ti8KEA
	tNPfzLTfc7MW37vmfSyGpD0GYoa3npfgnZUHFOwzlU7MSzawPNX8+kZf28Y5230BKdEddMqMY0a
	TxchCFHEA+ZqarX1E+0lRG+V0+0d4Az2S/7Bt
X-Gm-Gg: ASbGnctN4PsIek2cReo/h6iXbgE8lPQpp+AY0r80yJzqHwnsFycjJzKEZI3ERK3iwhj
	h0TJX8+9+wiwqi3GkK5hVlEOyMiSFskM36oRc7kb3qwjnZQGdP37/IDmblps1PpqwQIBo3in4/v
	urtTGDQqRZGWNPh3MOUbai53yRpqs=
X-Google-Smtp-Source: AGHT+IGmva/CIik2bWD7JZBchNV7aIHTN29EezwQnmyggR/INaYwIu70UCMfe/iI09Xx+oJaSq5rbUmglIRE0Cqhw/Y=
X-Received: by 2002:ad4:596f:0:b0:6e6:61f1:458a with SMTP id
 6a1803df08f44-6ed238923f6mr33341016d6.14.1743065972980; Thu, 27 Mar 2025
 01:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com> <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
In-Reply-To: <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Thu, 27 Mar 2025 09:59:20 +0100
X-Gm-Features: AQ5f1JouR4Q1MXJe5a_He0AgQvX1E1qN21i4k3YWXXHTlk6BK0OLOFdSssl0F7I
Message-ID: <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 5:10=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 26 Mar 2025 at 20:28, Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
> >
> > That is not quite right. If you look at commit 581dd6983034 [1], when
> > a firmware is about to be loaded, the kernel credentials are used.
>
> Ahh, that's good, at least there's no "random state" to check.
>
> But it does still mean that the security check is pointless - there
> aren't any other credentials that would validly be used for firmware
> loading, so what was the point of checking them again?

The value here isn't so much about checking the source context
"kernel", but rather about checking the target context and enforcing
that firmware can only come from trusted filesystems. So even a
compromised privileged process that sets firmware_class.path cannot
cause the kernel to load firmware from an arbitrary source.

These restrictions reduce our reliance on (1) individual component
manufacturers (e.g. NFC chips) implementing signature verification
correctly in their firmware loading procedure, or (2) the fallout for
the Android ecosystem if a component manufacturer's private key leaks
because even firmware signed with the leaked key will not be trusted
if it doesn't come from the trusted filesystem signed by the Android
device manufacturer. Leaked keys is a very real problem. Restrictions
like those added here can significantly reduce the severity of such
incidences.

With this, we can write policies for Android devices that enforce that
firmware only comes from trusted filesystems. For example:

allow kernel vendor_file:system firmware_load;

You could even imagine a more lenient rule that allows any domain to
load firmware, just so long as it comes from a trusted filesystem. For
example:

allow domain vendor_file:system firmware_load;

We can then create tests that prevent rules from being added that
attempt to load firmware from untrusted locations. For example:
neverallow * ~vendor_file:system firmware_load;

Such tests are quite important for preventing device manufacturers
from adding insecure policies that would allow firmware loading from
untrusted sources.




>
> In fact, the commit you point to was made exactly *because* the kind
> of pointless and wrong security checks that I'm complaining about were
> done, wasn't it?
>
>                     Linus
>

