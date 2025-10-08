Return-Path: <linux-kernel+bounces-845525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CEDBC53F7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9274ECE25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53788285CB8;
	Wed,  8 Oct 2025 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbWj7Q43"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D02857C1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930823; cv=none; b=Gjq/lpCPO4b2Cw2F+6OAUcCCtW6WfevPBtgqX/wSwryNsNo4dqDDlnA79+iNJpkaexGN5SvXYfS/xhKZbmUoPHd8PszfPGfgkD0nM05b9uXa2nK0WzfZw75hmSk0JcEK1x+ECdLNIGDwpUEQSGvJWOT+h0LYOwVjsniGxslxViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930823; c=relaxed/simple;
	bh=LKLMI7jVIBXqnCINko8P7Uc6iPO097WNdhlQpADJv1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOUobCIVUWHlzEm835PZkSQnuM/ExM6i/OBzxDcwTvoPWv1qbz62m1qsFWp0s5FbkFrvIIniEiwtLzw7nDNaLxigCJ7geQpvvdz99FzBH5EEDJdS4q5+RIM6GXO+godMJanrjAnth9ohBJzzOl9ObYVPOxbIk75EiL2OrvPo7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbWj7Q43; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6394b4ff908so12346578a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759930820; x=1760535620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zB8dGHM529xx30JxD8pLx7WECan5YqHewyo+iNLeAnM=;
        b=LbWj7Q43G5hona31gDyDgNa3GxOq4M8qW5ofvvXTJ9SqLzR9R4T/ovMRFmF3Apk5j5
         H4P6pwbbv4/rSRysM461uLDGxjmqU2axzpgia89DYgl07QkYtU5WZfH/WNLl2FlOrO+I
         Tpbc6YZ54LL+fV4+n5A+K240bivQb/TyXpyvUMppYZG7SnolXbk/VKNOpaPQn6hiVqDl
         RXt4k3Os26eUzworJH4svnWNxA2Tzz6jgpXuax/cda/g3YOuTs1Plr2cKKizcc1zXhid
         JfS9HBxniBhA4Bi9FgkYeIwT2RoY2ygclfGtWaaZvQUx1OvdkhtxKZl+xQUimEsSOPl/
         ALig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930820; x=1760535620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zB8dGHM529xx30JxD8pLx7WECan5YqHewyo+iNLeAnM=;
        b=fnkNucs2dM+aONSJz7+mcBy5pqHQir8zM3w4zw3GlV+ttoKfMvZLSexajED3RvJ0ua
         yjAkG0GFHf555yXScJQU7ATf2wI1eUQ1BPAg2BPUPAShf2bJto35gOdIiAd7I0rQJSeV
         /iJFnvp/p5jwfYXlYur4Xv8DkcOWGhUjrK400BaH417S8VO1ofMCypNGjnSkNR5ARnDq
         l0W8/PNJDGjBbFh2u2p7wVGb7R5I8xpNPnTL/0agDoRw3gr/Y15AS8BCuyGqGhcL0qpL
         IZGqnKTY4HiJAtVaY8TAyWukUs9GR1plf2vqux0eBiB+k39lgimSWR+o+CTM9xcJvaZJ
         iFxg==
X-Forwarded-Encrypted: i=1; AJvYcCV2PoQayzBIfudqgofyi89zBVQMWuWEnbSfmXMGyhn/Px3FafgMVd/jQF3cVKivPDcxTUVcypBlLRw6fpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcc7tE39iViDkLVijJ98r+wxXiG7zCSs41BX2rtOVZidYk+GLl
	hQyi8sP/myVg9yrIb1kF1NvGODRKop5Jpb5b2+D29M0j7jmFGh4tPz0vk2dkd2oiyUx94++nD0S
	E288S7onnhN/nyetwV+GI1qsZlh+/hrI=
X-Gm-Gg: ASbGncthFrNOheZdhRty4HopABu8CU02Kb5fJAYI3dqfifjH5clXfJyACviw22wV3Ty
	4vL6p6OCzCrL48CJyvXmlVQ5vaSC9VdYs6zkFT6oP/YqiaLZj8UscBd4ireiW9LXC4y8VbZIm2+
	1N9VBTOqM33Uoxsej4wFaMLr81JafWjxBNqkTdRI4HCWe9PmvMDVW1sF5AxvvkMWQzSimExkZO/
	hrDXt0kqNkUy9VojaP3yo6rEovqQ4T2Mq2jjdxjoj9A4TPZbXihqpn3tRqZfQ==
X-Google-Smtp-Source: AGHT+IFz3kQI6AfyX1eKxyqA+EEjSrFTpQAPMpdC4B14fHGxY8Y0OX0pY6hc0oAuuFffQVR5VeBnPKULag9YHQ5g3Vw=
X-Received: by 2002:a05:6402:1cc1:b0:638:3f72:1266 with SMTP id
 4fb4d7f45d1cf-639d5b90ba0mr3298613a12.16.1759930820078; Wed, 08 Oct 2025
 06:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007234221.28643-2-eraykrdg1@gmail.com> <20251008123418.GK386127@mit.edu>
In-Reply-To: <20251008123418.GK386127@mit.edu>
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Date: Wed, 8 Oct 2025 16:40:09 +0300
X-Gm-Features: AS18NWAZTdb6J8bIgiCvZr0JlREiiNK9rxDbS29dtNRgNkclFA3tJ5WLbFroC5Q
Message-ID: <CAHxJ8O_HF9cy5mg-W77M02E=WHrMsSOTmyxZYogUut3jJgEyFQ@mail.gmail.com>
Subject: Re: [PATCH] Fix: ext4: add sanity check for inode inline write range
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, 
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com, 
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ted,

Thanks for the feedback.

You=E2=80=99re right =E2=80=94 the commit description didn=E2=80=99t match =
the actual change,
and I appreciate you pointing that out.
After reading Darrick=E2=80=99s reply, I realized our patch was only
preventing the final crash rather than fixing the underlying issue.
Sorry for the confusion =E2=80=94 I noticed that a bit too late after sendi=
ng it out.

I=E2=80=99ll review things more carefully before sending any follow-ups.

Thanks again for the guidance.

Best regards,
Eray

Theodore Ts'o <tytso@mit.edu>, 8 Eki 2025 =C3=87ar, 15:34 tarihinde =C5=9Fu=
nu yazd=C4=B1:
>
> On Wed, Oct 08, 2025 at 02:42:22AM +0300, Ahmet Eray Karadag wrote:
> > Add a simple check in ext4_try_to_write_inline_data() to prevent
> > writes that extend past the inode's inline data area. The function
> > now returns -EINVAL if pos + len exceeds i_inline_size.
>
> The commit description doesn't match with what the patch does.  The
> patch changes ext4_write_inline_data_end() and not
> ext4_try_to_write_inline().  Ext4_try_to_write_inline_data() called
> from ext4_write_begin(), and it does this:
>
>         if (pos + len > ext4_get_max_inline_size(inode))
>                 return ext4_convert_inline_data_to_extent(mapping, inode)=
;
>
> So the write extends past the inline data area, in ext4_write_begin(),
> it will have already been converted to a non-inline function.
>
> The ext4_write_inline_data_end() function is called from
> ext4_write_end(), so you need to figure out why we hadn't configured
> the file away from inline data in ext4_write_begin().
>
> > Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=3Df3185be57d7e8dda32b8
>
> Did you just randomly bash the code until the syzbot reproducer
> stopped failing?  Please try to understand the code and the failure
> much more deeply before attempting to change the code.
>
> Cheers,
>
>                                         - Ted

