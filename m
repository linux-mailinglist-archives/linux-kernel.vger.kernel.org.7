Return-Path: <linux-kernel+bounces-806884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79459B49D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2651916F147
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07602ECEAC;
	Mon,  8 Sep 2025 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYGjV2L7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DD2DCF4C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371893; cv=none; b=h1ZiuP9nULIzPKWoqrkbI3zvvx2K3pZHg/bR/WCQb9tRds3RErv1BP5yO/YXT5bv8dTOerjJqAJXb54uqCp1mszU/OF/hmo6QnEWQFoPMHyeMATQP/5wPBYLj6dJ0uuiR3g/SfI54qa3xSBbJYeaRJlEZ29j9PblmCvOjAwz3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371893; c=relaxed/simple;
	bh=B7r/MdVFkxF8UOpjUQVzgKnL7FVHjfWobr88oKr636Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN30VHFG/nVtkH5rY15/LTj/A9WDTq/XJSNosnvcxEoq3623En0nZmc8eSFtfFuvM0Sz79st7ezmQyoVg6OfX55wSQ1WBMTED0+iQ2n1lJ1vM0Sz6OjOjIxy5GcSr5fK7bNXs+X8RDOlOLVo8/i3OJpRA4F0DT8hPq1yMjKjtkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYGjV2L7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5607a16639aso15898e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371889; x=1757976689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7r/MdVFkxF8UOpjUQVzgKnL7FVHjfWobr88oKr636Q=;
        b=gYGjV2L7/MkOedYGu9TUdyLQ5CgBHp9YrCv6Gh70xrEJOxOFNVH+Bj5+9jKHlejWKy
         0WpnYL4CDkSwBujtEtqgMFTSFtKHwGjTr1fGr+ob53RrOWGxU3C72+fhMrZF7fwiroT0
         vlLlRZrum2/s6aoQpS1JbHClXZoEfwQiNMU+fKMfi+LA6BCkSSj59nGwpeNIRhbPwXXe
         OcYArqmiQcwJ/tS52EqDJE9BiTWORo880ovUGWtZX73pHMvAt6AFQAQ7Ry4N6yjRAOxt
         LxvQIMut1t9+ee9Zup03rNnL9zitqZgtu7EkNLatFTZj9brrh+ycHsurzJ4QGy1Y3mp1
         KGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371889; x=1757976689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7r/MdVFkxF8UOpjUQVzgKnL7FVHjfWobr88oKr636Q=;
        b=XPLfEUkRUm3VQUpyXvZYvSV+bwAr39mP6Tuslj04BSIcr8fCfB+eg600sp78uKcVJH
         pbGJVTO/eC7XYaWpT0nqw/1wl80VjLrNz6ducGoMD6rmuk4syWnwS93U4OIOxdzB5ZNv
         YSizkvY7flQx1FMqOThX/czt4f7V/MOJ76azgo168pUXXdOQ7zRKaILP9wVuOO1aS0KO
         1shYmqNY96Sj1KY9hCCKI77KF7eMAe9DMb3rkHqAqERWGIQEo2YrEZqiavaiElae0pks
         vo3Fa6P4UDbyvUG82Ck4CHxga0NF8GG893hQzaaMmUknMRDAjH29mg33k71Pzvfb3uU+
         KKFA==
X-Forwarded-Encrypted: i=1; AJvYcCX3wt7k0dpRdIP2+2pcmnJ0NUhU77hEqOjpr6pf4Z9SUhYEzOzjznmpHv6INxGMmjWVVNiUwe71BiwKX14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkP+BEHBLkOn5wBf0arokdu4L+rZJiKnw5+vulbCiW9aeDjOK
	23GyKU0yI9JbBaJPSvDOrs0BJtJrnpPto+5EI8Q5Mev1121sZ/BQ8F8Pa+A/tyKiioyi6gCBoSL
	rtlzaH3c0BMDuAlitoh6/rvNDOSYOWOae9CQckG/z
X-Gm-Gg: ASbGncvdEyEPr1YmoCosKKBt48eR99kOfasE/g+rIBl9lk4VOBxTKjl0bTgKHaLPxIE
	HbF+BGtJrfq2SZ9z26DXQcoNU1V009HED6CrrI+WHh9WH1s91HAqnzxiqlveTFI3bkX0vdkCgVJ
	0HtgNqOfMtYy2ePZVHk8h/jA/DCT377lNsyrXeTNPB7BC47GwWFSgr+Oj1kYHy6j5UOmgb0y1Iu
	1Ncjiy3KweKubLLrQnw1SMfBwiJ7rdHyTlqXidfELyxNw==
X-Google-Smtp-Source: AGHT+IHGlPCHT+44DAvJB9zRm+3LM/HXySp5XwuN4EFQvOUkmZCnoZLTNZDiAYuGffXb4da9PPxUbTsQPmLHNTo18Sg=
X-Received: by 2002:ac2:5b92:0:b0:55f:6c68:400c with SMTP id
 2adb3069b0e04-56272295585mr463209e87.7.1757371889119; Mon, 08 Sep 2025
 15:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013419.4186627-1-tweek@google.com> <CAEjxPJ6QfUZijh3PEpHs_Yw6Hmte92-rg8gkvMw9cD=JxA+CMA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6QfUZijh3PEpHs_Yw6Hmte92-rg8gkvMw9cD=JxA+CMA@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 9 Sep 2025 08:51:12 +1000
X-Gm-Features: Ac12FXzaXfPJRpw8SIYa0ofw9A3koHJPN82BozBv8c8kOd4rvQR4t_4Herx7EQg
Message-ID: <CA+zpnLdbLjuGrk-178coxAH1pzpEA1jRzGn8zU9DHZ1rQspP4A@mail.gmail.com>
Subject: Re: [PATCH v2] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Sep 7, 2025 at 9:34=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
> >
> > Guard these changes behind a new policy capability named "memfd_class".
> >
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> When you revise a patch, you aren't supposed to retain other's tags
> since they haven't technically reviewed, agreed to, or tested the
> revised change.
> That said, I have now done so and thus these tags can remain!
>

I'm sorry for that. Thanks for the clarification, I wasn't sure what
the process was. And thanks for the review!

