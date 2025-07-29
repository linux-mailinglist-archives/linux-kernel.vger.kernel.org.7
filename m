Return-Path: <linux-kernel+bounces-749552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F097B14FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCE718A4788
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C2CD515;
	Tue, 29 Jul 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edAeu24A"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C948217730
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801209; cv=none; b=N3NY5W+DmKCPg6T2uPUMwdB/tN2+KBEFnpV6Ug7C9/Ng475YXWxjmGs07n3EwJJfBcA/ImmreW6wnPhycsV/lDyt7eEHJ00CmEiY4tf6m/5+0QTsMeOuKclHUDux9Ya2BzifX6nqq2FJr+DTAb9L383uOFXDJ99NhNTbRvbwCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801209; c=relaxed/simple;
	bh=EwjSdytWW9gUZqnvlQRD7pMbE0e0WkLC+veaoAgiixI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rqf8UWcagVrUUDccBVYmla720jOtfhZ0uUdasMRcyJyZiLUZNgYHAtdOgjDjXFITMXnpcua7y7vrIHTry9u6yum2TyhQb53qzbjMxgGn5gBoE2SJUIhqfofHFPlosi0uu+BCWjbgSsbfTUS2WAhNouzSBBGeW96JeQ/jFXQvGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edAeu24A; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2ea58f008e9so4124593fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753801207; x=1754406007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C4F2IyA53fJUkXZJdbFacQRwrzvQMOEeujGzyXBBH6g=;
        b=edAeu24AVvsP6TNmjGmc7FgXnDm9vOzn+f2du6dDWckGB1vqFv5/9LV40KXr9zwSfb
         F1U3KKe2hhJv7oviEhf1AY4TBQOFtsTh0ywi7XOIq3n/h46hbdQxGwrPiOtLGBP4b+fP
         oxAwgtYv0tZ1NrR1aoCF+4i5+sFT2foVfPcEI2gDJf+EqlxBd+gopVDEvKz/YxsUVnbD
         3c6GL6Gq+YtTmeWH+MukCAqkq3wLWpodJ6wHXm5JpAj2jOFau+OxxQ0I0Y9TpVlWmKWp
         LEdAPUBB+51aKThFhiOx66PCDL0EmXqjzN787sA3NIL4EqkebQjrJnlU8SEDpFFD+AAB
         6zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801207; x=1754406007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4F2IyA53fJUkXZJdbFacQRwrzvQMOEeujGzyXBBH6g=;
        b=nmw7Gygpiq6xfz3gi2QH/5/Ysn6jQh7qVp3+h4iu9A6aETd9qPAOafD0S6tX+69JyV
         IiHB4X6ZN7Q/9DsOs4tSPJpzUGdsvVU2aeHbuOatTWqqKrLzXnSDUmaPxgKj+dTRqROM
         qyYpb0rwx01ml6F9mPS2lM2T+ktBMc0N5RbQs7LKLeODZh0Sjikwqz+Pr+sJq1vTPqhI
         FJbeQ9mBTqjB+4p2+/cYrkkkAWrG4QtYGP2TWvcdXbarPqQ5ovygQuWPAsP+O9i0og7N
         K4B1KznMX3S2d20uyys3pm+tC5SWbsjLTzt4rnDOfgNRhL3/txjX2zQUll9XvFd5HlfE
         FqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpaceh0BVGMrPIbZLgYco7M+GFyVX3yHx/vbp0E8ZaVm29dQlz4VgUUlhu/XKxdJ4xCQfVXRacRqfuN50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBrzAd7QAS7janqxEKGZb+EOVHbpP3tXYCzK1XXommJxPtEKs
	TQ0B8Md7l2PlYXFCauOOIFDha1f31MxTtTjO8Jwabry23efEwcFOMmaZYMJ05UgqWSSsNngCL7n
	4gUiH28C1JmQY6i+05EbyXAwMZTavJYNjh6nIxEHtJA==
X-Gm-Gg: ASbGnctS5fmUI2GmeHJ9FaCK0zRZvy5So+Hji6zXwjq0nHWAYjnICsnmvjJ+6vd932h
	lQbIV/CmvEik+BWPzvqMTgeSU7YMEeZriYa4SVNoLI3sCURtJ88jIVnb9U87gbnrZ0w2uD2nOIT
	OY4Y8iRG7qkiu5QQj95HnTjcQNbcp+AJ1LnYftxziyso71M4EID35fKun+NGWV6pK7eRYzvDoNj
	LNcx5q9
X-Google-Smtp-Source: AGHT+IGJojF6PlhcjrA1wNjXCzUyTV7RWaNo8a2BsfvF8gdMqVZlc9grq7l4y4hEKSuakuE45Fo4LXiFWn5Tzojrkyo=
X-Received: by 2002:a05:6870:f214:b0:2ff:a805:52dd with SMTP id
 586e51a60fabf-30701b3379dmr11268693fac.26.1753801207071; Tue, 29 Jul 2025
 08:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
 <61958a3cca40fc9a42b951c68c75f138cab9212e.camel@perches.com>
 <CAO9wTFhCb7gDEo+q2SAZcn2KdUyVe-fG1E4bR_+US9k2J9DOnw@mail.gmail.com> <2a2bb7879e22208205fbb8f9bc56fb3c882bc307.camel@perches.com>
In-Reply-To: <2a2bb7879e22208205fbb8f9bc56fb3c882bc307.camel@perches.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 29 Jul 2025 20:29:55 +0530
X-Gm-Features: Ac12FXzg9mbgodopTzeTXNVIrBbNoBUtuTp7uwzcdL-XJ63aj7BA7fR9oRxzLxA
Message-ID: <CAO9wTFg5g5GjY=g2T6m7-jbAg_0U+OttpspxNQZ8ONK=gGJHCg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: suppress strscpy warnings for userspace tools
To: Joe Perches <joe@perches.com>
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 19:14, Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2025-07-29 at 17:15 +0530, Suchit Karunakaran wrote:
> > On Tue, 29 Jul 2025 at 15:54, Joe Perches <joe@perches.com> wrote:
> > >
> > > On Sun, 2025-07-27 at 18:20 +0530, Suchit Karunakaran wrote:
> > > > The checkpatch.pl script currently warns against the use of strcpy,
> > > > strlcpy, and strncpy, recommending strscpy as a safer alternative.
> > > > However, these warnings are also triggered for code under tools/ and
> > > > scripts/, which are userspace utilities where strscpy is not available.
> > > > This patch suppresses these warnings for files in tools/ and scripts/.
> > > >
> > > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > >
> > > > Changes since v1:
> > > > - Create is_userspace function to check if the file is in userspace
> > > >   directories
> > >
> > > the changelog bit should go below the --- line
> > >
> > > > ---
> > >
> > > This
> >
> > Sorry I will change it in the next version.
> >
> > > >  scripts/checkpatch.pl | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > > @@ -7019,20 +7019,24 @@ sub process {
> > > >  #                    }
> > > >  #            }
> > > >
> > > > +        sub is_userspace {
> > > > +            my ($file) = @_;
> > > > +            return ($file =~ m@\btools/@ || $file =~ m@\bscripts/@);
> > >
> > > All other sub uses start in without indentation.
> > > Please move this next to other sub blocks.
> > >
> >
> > Yup will do it.
> >
> > > Please do a git ls-files -- '*tools/' and see if too many other
> > > files are matched, especially the Documentation/ ones.
> > >
> >
> > I didn't quite understand this. Could you please elaborate?
>
> The search pattern m@\btools/@ matches files other than the
> first level tools/ directory.
>
> It also matches Documentation/tools/
>
> Perhaps using m@^tools/@ to match only the first level tools
> and change $file to $realfile to make it clear it's not
> a/tools or b/tools like the diff filenames.
>

On a related note, should we also suppress warnings for the
Documentation folder?

