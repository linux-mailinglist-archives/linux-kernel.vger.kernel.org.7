Return-Path: <linux-kernel+bounces-886678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E2C36396
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF98834ED33
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE20D31577E;
	Wed,  5 Nov 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zLSVH+cp"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B47221578
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355391; cv=none; b=WhmfFNYGPscYwtHmV73AKaeTlcVG+51N2H35pt6eL4wW8MNVkMScVbjHmvXUayBldOue1yZ506wC3XukJYGRUjpDd8q2JGpzr8G7o7rc8OmCGXQ5/j7kquYdRIokBwH/KJZnoHaxzzOkjMI2E12EMbgY9Dwz7RTwnuQ13uV+Vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355391; c=relaxed/simple;
	bh=pkzDDAuu5FnbyLu1BGgHTr/rHEA+02rAzTZAHJGNYkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5j6BL2CTt4zBFtqS+W5Xcz1B3Cc8eUhEAhgevxbjLHsH3sdUU8iRZx0eAlM4vOrmNswLhdMIe93v3//ArjX0zNynT2FXHRty75qOf39Y4FSodFQYxSuOhOawsmlijTfjf/K64hx4JbLCDmoTFPBIIHL4f0A+kbtZ2MlX3sMAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zLSVH+cp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29555415c5fso58656355ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1762355388; x=1762960188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npKJdQ/SFEjnsTgPu5T82klgRkrk6WAaS5E6NxS8cDA=;
        b=zLSVH+cpbs1qR5NQ2o43wKSdaOVaS1VtdhnlDEjIX8/9Ajn4HwN6wKHZ6uOD+ynKqZ
         rFTmElrFEmRgMW7OSLqFBHrgnI69SzNmrJhkAGhTk0oAvDWfl0qh+tUGsuwqzgyBkk1K
         ZcpqZR8ls6O0FkaofhQt0cj8b9sYOWUsgrneIQe/qf1DPZKkkkv0B3rg8U8WFEWifI1x
         hQtLuePdI1a8F1YLaQvRLqy9XsOywtP5mPyY8V4Ecyd6yH8NzgRqa3V+PAdNEr4nJu1Q
         2AEp8oyE79PeRWYxy5fkRCZTrIMGdso9ivrUurV5lg0tdWSZDNj8xia4WY0ZIc74/UVq
         Xusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355388; x=1762960188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npKJdQ/SFEjnsTgPu5T82klgRkrk6WAaS5E6NxS8cDA=;
        b=hDsphHh81CYizFrT9tr7PK/lqjYPZuGab5JmQOxV/0dLGwJ1lid3TScLpJqbTz+PbB
         deLLHCH6r5Nj4Bjwbo3fPGjLDXgaG88qZ0XyZ3Z5nKls60NPtFggrVeHfZOki5jUAbZK
         PxScz8svzQwZm8E8rBoOZeu3QjCB2Veoh7Nc7Cetxfk4POgBAflko2uPOYHUddshFfUw
         vVjUVFhL/F3n+4sAddv7r90AeN4BV+dVg1lE3T0JbrZ4xVQ5I7XYabXJstr5/8GG4KfB
         na9VL2pi8ZyHo3wQNxAjY3Fw9zv3qyogCFoxTHZWvn7D9jC7q2aksiJ+CngR0diqrQ86
         VAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXWYvmsYLs2RvRwP0/qnOnTEs/hLnKpyJnIr6cHl7SOWUzZM5c6rcBoZtddkBseAhGZEs+FkQEe26Xf8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7+WzxAwaLF+oYK0eCFVDqEyV288aGAcp8eqxn1K0CYj8okI8
	yiHFc/LoS/nSSHNLrt3isQUmWLPL9naHI+aGMjq3PoonRM/9UFqGt8YWB9mRJBCF4rg1NfLGRSA
	IBwbQJRJSR1BqQ61P/kHQFlokz308UPyaColRIB6+
X-Gm-Gg: ASbGncv+rclbZ6TY8ISGv/KEPeM3+t+ILO/kTP3Rl8E8surktyrHx7QuITsaua2K1CW
	wkXNtQI6hR+TlkScBe2jOBifkS/M+1JRNVaKjc+yS/XmZsK3XN49UWp6BzUmdu3XiS8+FaltviQ
	HUs8mSvcUVri/avI8YXJUFNGvdOZi3M4u8C/qQggPiM6WiwXHIaWQoxeBoIpmQEMYsKgyd3iUen
	9b8niVEolIZtio+bB7NXqLdobKSZetTBkyomoV4JvKovhgkDCbjtAYavg0ctXRADcKAvNiX7Uld
	ITHl/F+HyIx5Pcaa93Q3qHcEbe9DocYF/IX1
X-Google-Smtp-Source: AGHT+IES6bIx3iRmi6TnNQThdacyfXUn2MC8E/Eb3foVxURjYD3jCFL4B2OtVSRN6RcZ3uuhcllKhvneK9OOZ9vCQ9U=
X-Received: by 2002:a17:902:e943:b0:273:ab5f:a507 with SMTP id
 d9443c01a7336-2962ad3b1a3mr50683155ad.21.1762355388147; Wed, 05 Nov 2025
 07:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQoIygv-7h4m21SG@horms.kernel.org> <20251105100403.17786-1-vnranganath.20@gmail.com>
 <aQtKFtETfGBOPpCV@horms.kernel.org>
In-Reply-To: <aQtKFtETfGBOPpCV@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 5 Nov 2025 10:09:37 -0500
X-Gm-Features: AWmQ_blU6XcDEnFl20FbnBbH6b7zO2BsFs-Y_L7D1GiklwITbV2JeRK3k2GQLkI
Message-ID: <CAM0EoMnvjitf-+YFt-qsFHXOnZ4gW3mnXBzMT_-Z6M_XSvWbhQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
To: Simon Horman <horms@kernel.org>
Cc: Ranganath V N <vnranganath.20@gmail.com>, davem@davemloft.net, 
	david.hunter.linux@gmail.com, edumazet@google.com, jiri@resnulli.us, 
	khalid@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org, 
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:59=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Wed, Nov 05, 2025 at 03:33:58PM +0530, Ranganath V N wrote:
> > On 11/4/25 19:38, Simon Horman wrote:
> > > On Sat, Nov 01, 2025 at 06:04:46PM +0530, Ranganath V N wrote:
> > >> Fix a KMSAN kernel-infoleak detected  by the syzbot .
> > >>
> > >> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> > >>
> > >> In tcf_ife_dump(), the variable 'opt' was partially initialized usin=
g a
> > >> designatied initializer. While the padding bytes are reamined
> > >> uninitialized. nla_put() copies the entire structure into a
> > >> netlink message, these uninitialized bytes leaked to userspace.
> > >>
> > >> Initialize the structure with memset before assigning its fields
> > >> to ensure all members and padding are cleared prior to beign copied.
> > >
> > > Perhaps not important, but this seems to only describe patch 1/2.
> > >
> > >>
> > >> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > >
> > > Sorry for not looking more carefully at v1.
> > >
> > > The presence of this padding seems pretty subtle to me.
> > > And while I agree that your change fixes the problem described.
> > > I wonder if it would be better to make things more obvious
> > > by adding a 2-byte pad member to the structures involved.
> >
> > Thanks for the input.
> >
> > One question =E2=80=94 even though adding a 2-byte `pad` field silences=
 KMSAN,
> > would that approach be reliable across all architectures?
> > Since the actual amount and placement of padding can vary depending on
> > structure alignment and compiler behavior, I=E2=80=99m wondering if thi=
s would only
> > silence the report on certain builds rather than fixing the root cause.
> >
> > The current memset-based initialization explicitly clears all bytes in =
the
> > structure (including any compiler-inserted padding), which seems safer =
and
> > more consistent across architectures.
> >
> > Also, adding a new member =E2=80=94 even a padding field =E2=80=94 coul=
d potentially alter
> > the structure size or layout as seen from user space. That might
> > unintentionally affect existing user-space expectations.
> >
> > Do you think relying on a manual pad field is good enough?
>
> I think these are the right questions to ask.
>
> My thinking is that structures will be padded to a multiple
> of either 4 or 8 bytes, depending on the architecture.
>
> And my observation is that that the unpadded length of both of the struct=
ures
> in question are 22 bytes. And that on x86_64 they are padded to 24 bytes.
> Which is divisible by both 4 and 8. So I assume this will be consistent
> for all architectures. If so, I think this would address the questions yo=
u
> raised.
>
> I do, however, agree that your current memset-based approach is safer
> in the sense that it carries a lower risk of breaking things because
> it has fewer assumptions (that we have thought of so far).

+1
My view is lets fix the immediate leak issue with the memset, and a
subsequent patch can add the padding if necessary.

cheers,
jamal

