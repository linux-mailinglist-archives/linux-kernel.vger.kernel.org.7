Return-Path: <linux-kernel+bounces-874969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D02C17E49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461C61891C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F12C1583;
	Wed, 29 Oct 2025 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K40/aHis"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4611A2D8DB1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700975; cv=none; b=hYhzAQVQBDf7DZrxfGCIhos6n0EAlbLlqZ+5+qf8YFypqXodYes5Yjolh3sV6pFlSYfFM/p0MncskAxZujuA0zf5q7kIiCkZ17ou9qZHntLCxfsj1ZiK7T53ZkB/SIeZrZSD92M+vYzu912Kly0/OWBKdB7IdG9SlWCX93a0ZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700975; c=relaxed/simple;
	bh=rsaJG5G5GdirEwKDjvrHHZERxpQoyUS1q602EMtCKZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huTkQ8mpfmMva+7gZlPXHKenSgwAIkT7cMAro5TGGijBpR0TIDgf1hOovKqdXeCNRniES/sLnyAXJ8yMoezkC1C+dPb/YNteBv8GTPpAvXIAkh2GTXqC5Ka5/HmE0sA93zNt0aDRRBDU55yb7CQLL6/462hdHpXS1nqro0dU1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K40/aHis; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso181411cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761700973; x=1762305773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJXU/seAFsL4mACUPVLDxeMiP7ShQNJYKccWkDiEgL0=;
        b=K40/aHisIALT/bJrJArF8FyIAQTOSGsuPb+txW08SeAGqTZEe9mJyIblcke43DpwkD
         qGs4DUAx8Oty9NxaHf9b4bBNikVtHXOSAgYCgmCoYPmrVMJVPuuRS6E3g0iBxTzwQ2mm
         LkiC2QAW1jc0VRq94RDHuTGO87uyUlSSAu5ecd+t4ak9jYt2zlvp5Po4FevxEgE6lvo2
         nv3+7xWXyOFlp3bfa3Sonc/qlIPXCtgS5Iq42UxttE1D14zZOBRKnG1fTVPO4EJMcaas
         2DdZ8BWxmquNv+o/anXyu9zLRrNGKJAoN0TS+FDmv2i/CkxhlGxHVL1LCJpQEbPRXh9N
         aaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761700973; x=1762305773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJXU/seAFsL4mACUPVLDxeMiP7ShQNJYKccWkDiEgL0=;
        b=FDKlcHY7P2HrWdlu231DsjZO0VnfwkWtLzmyxNSAYYMm9jaHIPE6igXYiZWhsowvCz
         IU94TLHYzWTVY/QzdBbJip/GLn5sEAyckScP38fUKlEKishejhVvPxOsYonbUQcbGihn
         WEvCT41Rx5loryVwX/su27URzVp70o+KrIgs3JHAXkMa3hSMQ11Yff/49TP/yQVJwdHO
         7utJO3jgIvu2X7jkRcA3eHu87EMXcm+ju/qWQ1AVqcYz/gHXXmJo4KbypLGXfCImtuGf
         X2pKG9vl2Ca029ob4Mm8bqaEwDdxf0+EY7DNdmVjo3kGk65BUZb1kATgZU18YeukIdyj
         RdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+iywcl+KSe/g+Ayn31WWttGCrw3ZRI1PWpbXyv6MBZIa0OhZOl9uuwBPgU5ipODFKcLr89wjyedCGNRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkbmPS8+oU57GiLDytST7OeRsdxxWkYiKL3UfZgB83pQLCSxUX
	sG7M6/Ek1H2/SVNYU0s1076O/z0k+5+cw0qRiELfC5MM8kqRRbS/T4x/v4qAlt3QLD6mUZZUzKi
	JugfWl+EVrgeZya44jLnqDtJOgCGJBlw6yOcmqNwo
X-Gm-Gg: ASbGncvNeOcKXmcxMmijfSlCi/7a3WgMmCV8Y9HQuFJbcvuI499tivzluRTq/78OFn7
	ikwIPsOrVDIvpsr25ILU3sJn9wyt2FqVfQYFGktVcUeL0y7rAAIcIww4qtXKabI/Evn/dIVmYz+
	FhkFb4JMdPPVvRn5J70EJELo3C7zrMcOuvC5tJYxMongDvEd74KOU3HbSh3Sa+pAx65IeXHJJ8q
	n3b/mH8NbPIpK8SifSCFT+Ni6A7Kbt/KHeON4qlBXAp03evhwy4HaEkx94=
X-Google-Smtp-Source: AGHT+IHK7V7bGcz0b0sGmw21GNrHcXYdY1gAn79xg7vp99JFrGhfcfBXR2vDKXRNfGzHuAPD7elxkQxreFFRRjhl424=
X-Received: by 2002:a05:622a:11c8:b0:4e4:d480:ef3a with SMTP id
 d75a77b69052e-4ed165a8088mr2292611cf.13.1761700972959; Tue, 28 Oct 2025
 18:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029005448.495880-1-isaacmanjarres@google.com> <CAHC9VhRp0QTAZqux8JbL1JUfLxMV9G22Q0rKZ5fQL2C_8mod_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRp0QTAZqux8JbL1JUfLxMV9G22Q0rKZ5fQL2C_8mod_Q@mail.gmail.com>
From: Isaac Manjarres <isaacmanjarres@google.com>
Date: Tue, 28 Oct 2025 18:22:42 -0700
X-Gm-Features: AWmQ_blUwNjwIC7xRjXcpWEQg6_GFvt3ZzX8vmFZE37J-4-bwe8KZznN-0pMazU
Message-ID: <CABfwK109-4zzBUiQRdNg1re0dQ+dRdau=OXNFhtNsUc6YAEyBA@mail.gmail.com>
Subject: Re: [PATCH v1] audit: Improve path logging for unlinked files
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, surenb@google.com, aliceryhl@google.com, 
	tweek@google.com, kernel-team@android.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 6:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 28, 2025 at 8:54=E2=80=AFPM Isaac J. Manjarres
> <isaacmanjarres@google.com> wrote:
> >
> > When logging the path associated with a denial, the path is scanned
> > to ensure that it does not contain control characters, unprintable
> > characters, double quote marks, or spaces. If it does, the hexadecimal
> > representation of the path is emitted.
> >
> > This can make debugging difficult in scenarios where the file name that
> > was given to the file does not contain any of those characters,
> > but the hexadecimal representation of the path is still emitted when a
> > denial occurs because the file is unlinked.
> >
> > For example, suppose a memfd is created with the name "MemoryHeapBase".
> > Memfds are unlinked, so when a denial related to that memfd is
> > encountered, and the the path name for it is obtained via d_path(), the
> > name will be: "/memfd:MemoryHeapBase (deleted)". Since the name has a
> > space, the audit logic will just print the hexadecimal representation
> > instead of the name:
> >
> > type=3D1400 audit(0.0:319): avc:  denied  { read write } for
> > path=3D2F6D656D66643A4D656D6F72794865617042617365202864656C6574656429
> > dev=3D"tmpfs" ino=3D75 scontext=3Du:r:audioserver:s0
> > tcontext=3Du:object_r:system_server:s0 tclass=3Dmemfd_file permissive=
=3D0
> >
> > To improve debuggability of denials related to unlinked files, check
> > if the " (deleted)" suffix is detected in a path name and remove it
> > if so. This allows the actual filename to be validated and emitted
> > if appropriate, making denials easier to read and more actionable:
> >
> > type=3D1400 audit(0.0:254): avc:  denied  { read write } for
> > path=3D"/memfd:MemoryHeapBase" dev=3D"tmpfs" ino=3D67
> > scontext=3Du:r:audioserver:s0 tcontext=3Du:object_r:system_server:s0
> > tclass=3Dmemfd_file permissive=3D0
> >
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > ---
> >  kernel/audit.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
>
> I'd prefer not to add any additional string processing to the audit hot p=
ath.

Hi Paul,

Thank you for taking the time to look through the patch. Would it help
if I could
optimize the logic to scan for the " (deleted)" string from the end of
the string
so that the search is bounded by at most 10 characters? I can also switch t=
o
calling audit_log_n_untrustedstring() instead to avoid another call to strl=
en().

If not, do you have any other suggestions to help make this improvement?

Thanks,
Isaac

