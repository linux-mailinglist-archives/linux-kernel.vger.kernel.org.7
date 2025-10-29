Return-Path: <linux-kernel+bounces-875020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52120C1807C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9C794EF92A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3B1AA1D2;
	Wed, 29 Oct 2025 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gFZ45Y6v"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AF126BF7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704164; cv=none; b=IjetfowNnXqFf+Fg39zycrd1FsU6A8mWqyVrPARFIpJUycAEUwSwDyRyzfyJBAj8FbvH5x7nyWQxGKTDHcHHOlcnxK+J9A3Sw0CmQGYgVjPItOQdy90maeX3L7XhvS9cEZ6sNAsgsA1qiJspJz7vJPtsjuBmzWeH2RAq5N0qDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704164; c=relaxed/simple;
	bh=ARyRKLgC7kM5VyifivsbzBjR6gWaQK88f59a3fGCDUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1Oyu1If7LIRAaFIwGuwh0ogV7ZBoRsKDXGtkM+BoecZ1qPrYMAK395ZipR6ZXCRcJB705Jzbm9kbUdo6/ZW3FUjbdk52npcqWbtb/VBpz6sOJGWfZ9KhApD4NObe0V1zxB2vUTrU7KN3GR4QV1uJ5JxoGnTkHETQf5618dtZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gFZ45Y6v; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso6011972a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761704161; x=1762308961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z4i/cJ7TwXS62lu0Ks328mnczTfLqwKUI5pI9nPizQ=;
        b=gFZ45Y6v/mRgNboJAhrG9nlibg80iyBZI5Vux9ggMKTBadMMNNMOLfyXhy2BJ0SYdJ
         nzq8ula7aM0QUfHgiqgeBDJTFSU8Njf8HbvjbQ2FHBCRYaFFvzHnT++umdEoxCG4t1Ta
         gBSYxl88SoYH8PF6sFnV2lNseNSw3txnpHc/QjwT7xNntStjMdKrr4qSoKw4CC60QhzY
         I4EeyCSKOMqEhRVb5soPBcwm2mDKc3Rhhw34+TGMVB28mHL7QMSk5/xXPIkcisT3JrjC
         APVP23ptF6pAF5laa53MUse2WAC8MPX96zgcGDmkx8IRlAOZE3a3GbuNJ8cwhBbxWQso
         KWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704161; x=1762308961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Z4i/cJ7TwXS62lu0Ks328mnczTfLqwKUI5pI9nPizQ=;
        b=TSBrOiDb/9tDbl9ds5pc/Hq45yO0VRamWcEOZcpjyY/hK/3Q6dhJ42XfTLZJ7ckuAD
         qNSILOWMzMN+kTkJzw/76MCju6rZdTj5xLmuEAi7OmDEWhc+K2H1XbJYhtWxIK81fE2L
         kQ5adzhcSHTTa1eGSoYKZYHtenhfzJ2KrMSJhL3iwX0u6koKdITphgwjVJSgbO+dhZGG
         x2vtfBZyq8hIGXngiJs+3I4AkQmmEblgdX1TK8oUL1gQD8a+VbumW/PbqZ+Rc4WwnjdT
         nFP7g1eDVZcWQpiJNc9zB+vnyvOjUDXl/7Z7tLBtIjPp78YMVqAfIFOITXXMbC5F44ls
         /Nkw==
X-Forwarded-Encrypted: i=1; AJvYcCWpVFqL6Jf5PmBI/HHQ/5/t/A2QKK1yolZyi/ty5l0ZymwoTna3UXlkdqlucfqWPUtIzV6DLPjiDB4QIFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9FRCRDkRfebfKDSmg889IwVdfAfe40dY37lNVmtbHhpfHp5a5
	7IDSGGhRG6taI7kPpFNEcoaBR+Hiq/UxDGJmKngKWnDOufBuT1q40+kAzlvBthM02/QIE9DiuMN
	lyNGSVXdgrutvDzSotkgpQOVUOcjEG5GqUkasJ7wdAKkYdKTrW5cfFA==
X-Gm-Gg: ASbGncveJooTCyrdFj/5R3sLA33f4F91aXlG2LF2vvxMNQgdrStNZJuEZctEcsNjofy
	l4+3vZOVT/3E/U0FL9FLPLvcO/Jh6VSmgmqY7tewBxXRy3gLsSUuk9vk7t04xreSl7AMphhT+6F
	3VXoQRalm/2v2LUufM+lH2ELyxoiTlx7TP2H6zH1sk0AGdIUzcCgoippcGa7/QfL8eSMbKL3FCb
	s+GnHYzu2wHj716hgs1G5Y0zpRLbZX1JkyEeui7BGI++spYRTZURs+8Vppj
X-Google-Smtp-Source: AGHT+IFabcSQt9M5y3fDoD8jUgMf2MuJyHJOnxcYAyMVXS602xVGJ3Z8xp1XeyY5yCpZHLL7Cj9naoT5kL+P9mGfQFk=
X-Received: by 2002:a17:90b:3ec4:b0:33b:b020:5968 with SMTP id
 98e67ed59e1d1-3403a2a2304mr1604393a91.21.1761704160714; Tue, 28 Oct 2025
 19:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029005448.495880-1-isaacmanjarres@google.com>
 <CAHC9VhRp0QTAZqux8JbL1JUfLxMV9G22Q0rKZ5fQL2C_8mod_Q@mail.gmail.com> <CABfwK109-4zzBUiQRdNg1re0dQ+dRdau=OXNFhtNsUc6YAEyBA@mail.gmail.com>
In-Reply-To: <CABfwK109-4zzBUiQRdNg1re0dQ+dRdau=OXNFhtNsUc6YAEyBA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 22:15:49 -0400
X-Gm-Features: AWmQ_bn2NEgqJH0AOdinubhn7W0GHQ1zBXnZ6Q4GwY2tvpXHzRyHYLGZOuaAuRw
Message-ID: <CAHC9VhTF646GKPVQjS+bvdws2c8DjdR3jRX4Hc-vUjiF-b0mLA@mail.gmail.com>
Subject: Re: [PATCH v1] audit: Improve path logging for unlinked files
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Eric Paris <eparis@redhat.com>, surenb@google.com, aliceryhl@google.com, 
	tweek@google.com, kernel-team@android.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:22=E2=80=AFPM Isaac Manjarres
<isaacmanjarres@google.com> wrote:
> On Tue, Oct 28, 2025 at 6:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Oct 28, 2025 at 8:54=E2=80=AFPM Isaac J. Manjarres
> > <isaacmanjarres@google.com> wrote:
> > >
> > > When logging the path associated with a denial, the path is scanned
> > > to ensure that it does not contain control characters, unprintable
> > > characters, double quote marks, or spaces. If it does, the hexadecima=
l
> > > representation of the path is emitted.
> > >
> > > This can make debugging difficult in scenarios where the file name th=
at
> > > was given to the file does not contain any of those characters,
> > > but the hexadecimal representation of the path is still emitted when =
a
> > > denial occurs because the file is unlinked.
> > >
> > > For example, suppose a memfd is created with the name "MemoryHeapBase=
".
> > > Memfds are unlinked, so when a denial related to that memfd is
> > > encountered, and the the path name for it is obtained via d_path(), t=
he
> > > name will be: "/memfd:MemoryHeapBase (deleted)". Since the name has a
> > > space, the audit logic will just print the hexadecimal representation
> > > instead of the name:
> > >
> > > type=3D1400 audit(0.0:319): avc:  denied  { read write } for
> > > path=3D2F6D656D66643A4D656D6F72794865617042617365202864656C6574656429
> > > dev=3D"tmpfs" ino=3D75 scontext=3Du:r:audioserver:s0
> > > tcontext=3Du:object_r:system_server:s0 tclass=3Dmemfd_file permissive=
=3D0
> > >
> > > To improve debuggability of denials related to unlinked files, check
> > > if the " (deleted)" suffix is detected in a path name and remove it
> > > if so. This allows the actual filename to be validated and emitted
> > > if appropriate, making denials easier to read and more actionable:
> > >
> > > type=3D1400 audit(0.0:254): avc:  denied  { read write } for
> > > path=3D"/memfd:MemoryHeapBase" dev=3D"tmpfs" ino=3D67
> > > scontext=3Du:r:audioserver:s0 tcontext=3Du:object_r:system_server:s0
> > > tclass=3Dmemfd_file permissive=3D0
> > >
> > > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > > ---
> > >  kernel/audit.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > I'd prefer not to add any additional string processing to the audit hot=
 path.
>
> Hi Paul,
>
> Thank you for taking the time to look through the patch. Would it help
> if I could
> optimize the logic to scan for the " (deleted)" string from the end of
> the string
> so that the search is bounded by at most 10 characters? I can also switch=
 to
> calling audit_log_n_untrustedstring() instead to avoid another call to st=
rlen().
>
> If not, do you have any other suggestions to help make this improvement?

Since we don't know the length of the path string, I'm not sure
starting the search from the end would be a significant improvement as
you would still need to traverse the string to find the end, and then
do the search.  It is possible that searching from the end may be
slower than searching from the front, although as you point out, some
of this work could be reused through the use of
audit_log_n_untrustedstring().

However, we're still doing string processing/searching in a critical
path.  Audit is already suffering from far too much string processing
and I'm *extremely* hesitant to add any more unless there simply is no
other way.  As this is a "nice to have" sort of thing, and not a
critical bug fix, I'd strongly prefer not to do the extra work here.

As far as other suggestions are concerned, nothing comes immediately
to mind, I'm sorry.

--
paul-moore.com

