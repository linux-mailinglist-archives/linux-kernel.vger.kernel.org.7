Return-Path: <linux-kernel+bounces-844118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EAFBC10CC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A3A1892530
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51752D9497;
	Tue,  7 Oct 2025 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7Gj59T+"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA642D63FC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834269; cv=none; b=nsKByycaWfvyiJvFkza+haHgP+6OVi3voCehlb3VvlCjEQZ/haSruFplAZ2+phkH0DCA7cYBwi8lwHMZ619/b6REVGar4dj4GW6FeUpT8crR5bMh+8txyNrIXYVQIFHbAJJQD/uiItOsCiPfGcpfKwhhLixeMbfp3mQtiy2+8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834269; c=relaxed/simple;
	bh=WMFv49FTR7J4KezskKA/pfZcpNRMZ+fIXAc0O75aC00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRDkeAAtB5Zr4X8LVZaBcbCOkGgcbI7XxUSJkqjbT+RuP4i4I5IbzO36t2APc11ejiMiAF6McEwGyF8PnPcWIWSE56rG6Vdr6qh2BMnSPJz6lYB89fonsG8nvdjW3QsBZ+cAb/5eUP8dYnwIi3g1OssLMVrSiDN0D209zJeSdBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7Gj59T+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4678876b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759834266; x=1760439066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTEKwB63KRhEq/DGo0zhOnst1wucWk4g1/MdUkIfUWc=;
        b=V7Gj59T+nHDkPK8EN+G/Lpa74bhPApX0Cjyf8UPHOiBbQ/2EXwifdLzsRP05MeXRo7
         Fnf3C6k2o3vjCjxVxYyIWV//eoHZviUu/htxkQ8BXXk6bfMUpucNJzTNq+TAj/6Xy3jn
         BQmAyFGsBlXa+o//s8rIgQYo2IWicJ6WzYmBfj61k0hFypd9kR1nGDiWi6emVfIaDtCG
         9SALg3ZoNvqT127I0ymWagHzdQosJ8gpeTHfngYK/H9EyNwRSod0x++o+mbIOkgCeuav
         XRKd/Y+U+yWY7WYlo4qZ0WxcRboZCISgSgouW8PAJBliIiVvsXXxBBYVuRGgmQYoG4lg
         wADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759834266; x=1760439066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTEKwB63KRhEq/DGo0zhOnst1wucWk4g1/MdUkIfUWc=;
        b=h5suz3jF5QWVVLeLP2VwL1qF+NgRnzYJHDDQYaliZYxuIylXByaZ+N9VoVP+y7tlq+
         Tugx1eWQmdEvg3EpQ0BzFEj0wtv1gZ5pP5a4+6axTUdkWDpBuviMckDqOuSskfVP4zIf
         AKjFBKFYZ7qdFyEgseyiwD2ZU/1/p6wD6E5vWnCm5zyIYrQdcC0ObjvAg3ymA3+I/1wO
         HXwLDQJt6QJaSpIqAAjnPk37tAhR1kk/x9Dqne7mG8JCPwuiVInSC3oIsM/B18uxH1Oi
         U7gMtLp0/CkQB5WFDE56l3W9pftl1+tGxJ0Sv6xVBKOKq/gKPwDak2yL7xWZAv0x1lB+
         YQCg==
X-Forwarded-Encrypted: i=1; AJvYcCXv/OSc4sLMfMjIkQAQ9gtWYlJGOdG5EXpodVdhJsRKtws2nWWom3cJqJMlvdEFTs3suyhF7yLhsQR46WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybCfEd1xdtb0xCYLKINrwiqbNr0/ADzyVFPK/PC54PDzhKOtWR
	/AOtDKWb0mnBYDXVnAgD7DwPi16Ea3NIhqZ12Ata7pP7mEIqLcicLlvqYjsfTsK9KgLp0FMtrHl
	Xb9ahWo33l2XDYkhRkeY/qKSTcRVn1peVEW+q
X-Gm-Gg: ASbGncsPxMxchOrOy07q9S9yTtsKmbWQXKrQExILAalxQN/5kZ+/UVVZu/dG4GDVYhz
	pbYS9RPtjp/uk90boizQBPeHWrulNp07DvhERrQFS3D0kpb+ea/yzZVVvHe5oLoMYMesOD/qQaO
	+cuVUhzNCxw5F3ejJjcaEfyAhgOzuvQAW316XjlZrcscJ1HOdFMeJqm/6+98E+uvfQB3VggP8nl
	6tLWyPlZX8ETBhcTKNG58nz6zLXTsZ/imBTk97V8WwWB4b7/Aj8VMIZ6bZh/+11kgt5Y4Qs9iof
	MTs4CNmAWxlucaUuxQ==
X-Google-Smtp-Source: AGHT+IFom2dGM5sld/4yLOXQtA5IRjQEqmpbg1uF0gPNwQKLwyidJ91yICqTHTAgatieRNiOiiAV4Ie6v1Giq+OAEmk=
X-Received: by 2002:a05:6a20:3941:b0:2fe:d5:4e80 with SMTP id
 adf61e73a8af0-32b620b181dmr23563053637.37.1759834265653; Tue, 07 Oct 2025
 03:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913105252.26886-1-opensource206@gmail.com>
 <CAKPKb882DgYB2fZXRDU_y1Xqz6GtFEErvzzET9eOAm=db0ns1g@mail.gmail.com> <873C85C5-2BCB-4631-BA18-919CE448A7CE@collabora.com>
In-Reply-To: <873C85C5-2BCB-4631-BA18-919CE448A7CE@collabora.com>
From: opensource india <opensource206@gmail.com>
Date: Tue, 7 Oct 2025 16:20:54 +0530
X-Gm-Features: AS18NWBJt0wWIycj1rLQ12Ilg09Ig2SzbOfgvj4F0Tkn2zxjoJ_mGhprGTgEd2c
Message-ID: <CAKPKb88VHwGp-iLMa=zZy3Czq8S8wUd9Zzkicvd4er9OiLg6UQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: v4l2-ctrls: add full AV1 profile validation in validate_av1_sequence()
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: mchehab@kernel.org, hverkuil@kernel.org, ribalda@chromium.org, 
	laurent.pinchart@ideasonboard.com, yunkec@google.com, 
	sakari.ailus@linux.intel.com, james.cowgill@blaize.com, hansg@kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 2:27=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi, I=E2=80=99ll review this in the coming weeks.

Hi Daneil, did you get a chance to review this?

> > On 27 Sep 2025, at 06:51, opensource india <opensource206@gmail.com> wr=
ote:
> >
> > On Sat, Sep 13, 2025 at 4:23=E2=80=AFPM Pavan Bobba <opensource206@gmai=
l.com> wrote:
> >>
> >> Complete the "TODO: PROFILES" by enforcing profile-specific and
> >> monochrome constraints as defined by the AV1 specification
> >> (Section 5.5.2, "Color config syntax").
> >>
> >> The validator now checks:
> >>
> >> - Flags: reject any unknown bits set in sequence->flags
> >> - Profile range: only profiles 0..2 are valid
> >> - Profile 0: 8/10-bit only, subsampling must be 4:2:0 (sx=3D1, sy=3D1)=
,
> >>   monochrome allowed
> >> - Profile 1: 8/10-bit only, subsampling must be 4:4:4 (sx=3D0, sy=3D0)=
,
> >>   monochrome forbidden
> >> - Profile 2:
> >>    * 8/10-bit: only 4:2:2 allowed (sx=3D1, sy=3D0)
> >>    * 12-bit: 4:4:4 (sx=3D0, sy=3D0), 4:2:2 (sx=3D1, sy=3D0), or 4:2:0 =
(sx=3D1, sy=3D1)
> >>      allowed
> >> - Monochrome path (all profiles except 1): forces subsampling_x=3D1,
> >>   subsampling_y=3D1, separate_uv_delta_q=3D0
> >>
> >> These checks prevent userspace from providing invalid AV1 sequence
> >> headers that would otherwise be accepted, leading to undefined driver
> >> or hardware behavior.
>
> Mauro,
>
> A reminder that I have been warning about this for quite a while [0], whi=
ch
> includes mentioning that patches like this, although welcome, do not solv=
e the
> root issue completely.
>
> I keep working on what I believe to be the solution [1][2]. I would appre=
ciate if
> we could restart this discussion.
>
> [0]: https://lwn.net/Articles/970565/
> [1]: https://lore.kernel.org/linux-media/20250818-v4l2-v1-0-6887e772aac2@=
collabora.com/
> [2]: https://lwn.net/Articles/963966/
>

