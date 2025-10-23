Return-Path: <linux-kernel+bounces-866733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97ACC0084F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31813A2115
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE22430DEAE;
	Thu, 23 Oct 2025 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPvhA6rW"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4330DD24
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215588; cv=none; b=UR7JUdEuGuKdB8AIfiP4GqqQf4nSwj/9jLremzKJDEGjWOeCzseK6CalPvPcK9BT0EFkBJ6ZtnNok0KJPj0rDgguVbxAw3TVIul4rYT5VZafsbQTcQ0OqdD7zkgFBZbD8VM38Jork7F5BfUkRds4bFkmKi12CzgfHB7HnQFcT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215588; c=relaxed/simple;
	bh=dZnKR/a/pDH/CB8DnfAtKqRDaLhcZVhuKSlMbnnqq90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHueQyxthwVQIMYfunG7flUTOAwGFCPGY44o4vObukBkBtmqeMEvg7r16KgfBpfywVQShq5RjiC+wulqFl3v93rVOjdDam89HmgBY6L9GIxp1tmFAAe8cHLfVyCCfTZjn1o4aJamITLVUvl2ijzGD8VWWmB6TWg/FbJMKcI7A7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPvhA6rW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b679450ecb6so502173a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761215586; x=1761820386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aCzwSR2QayqVcdDXwHXvwD07lQU3kcAPJzjXfbUAOI=;
        b=nPvhA6rWBH87cdrJw9idX647l8Y9oOEK0qWh/bOgpXmxQi87eshBl4wvH5qow2a6Lm
         CM0n/siqlSVqD3W64OYysxG3psYZfKg0d8Sl4WwrgAs4uUchx/XtuCNLHpqsP5GH1VI5
         iBoehdkdYMWEpZPbxs2UjSndlg8EgcvIdss28xq7wBeeQzC55w6wNHzwRJ2RfqIg7LO9
         3SliXSJav08Rxc+kzog7khPboY2TPh2aAC0jK3JeYtlR7aqoBv1qtWH+KBPqAUvuTiVU
         kmYgipJQo6p5ejtcsdTgWnKJ4FbPwRLxi1sYthVG3b/UuzTytWsGlVYuL6dt6m+DQ4il
         BP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215586; x=1761820386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aCzwSR2QayqVcdDXwHXvwD07lQU3kcAPJzjXfbUAOI=;
        b=rq68v8rE0ox8FRT3IZ4ehr+/Lzznxr2BqMIZ5dMn5UAmIniwrLAbp2U+veMMnEDFVU
         DAfaLZMuxDbIRUZW3+fhbRG94nj6E3+i5Hj8p3/KN9apB6ToAjNhZPmPvqm98DOK/Skg
         fgR5EhTa17dNxI+5Ku2rSK6I62qs2rUW/5o0aq4cCwtFetP6EgY3MAedDtqhP4Ls3HWc
         8qTuEe9kyhyWRuxsyvdh4WPwriqeU4+sbv1Qvoe5x24YaR2u4Wy9ujssZhwpsWTfTiHY
         wo96dBSoBMju/o9nn+ZVReSD5I1+p17SXcsFO/FJuz625t+JB2m0FjwdRzSO/cwW/G8M
         QPUA==
X-Forwarded-Encrypted: i=1; AJvYcCV6yVRCV5V5lgKIu2LqzDGZ+O6RaovNmP3bk47p+kUDMDMuRow/cqbaMQrSKaZpryXnxDVYpCrmxKj/y08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2G6kS3kMjnuKc2lJMOmKwVd0vF5a+y9YItR/Z1bwraGqjC9j
	utirKVXY1rm02p6cgRFLrbYG3IVw89CS3giwlQXD8Q1tAlmjI25RGVLrCRKRdEHzrNZcZjB9Q+c
	3RZND4E4lpytzuAoxuOiKirNxGdHFc9I=
X-Gm-Gg: ASbGncujRR2PvrAixD0m0xdwbtar8oaHfZQh6g/AJ9beKU3A6s6DMx9z6D75Xy3LO8y
	wRvor//xCt8wW6OTYXQpxgwky9q7ZzOYFvsrgfFRfJIWN/uD82JPyY2espRMEIGP847fblVCJ5L
	elp2zLUDealX8ZZJRqPckQ0xEdlLZpLBvqmB+7PEu2BjkepTSpzdIdrMgcuhjuHvSkO7zzCLQB5
	2rKzyR8FgP43/t0eexBDyC8QDMkCLNHtZo5Y0utGtxSh4ivnlsLibpl8BltvFkq8xoLCAeHcRTT
	PLhxfLWhecPfbOXZDpMtsbA6bPezjUqUmafy6fAiLuG04VAuIT/CUHNxru1f+0QnKdcxE2Dxvp2
	yvhQMXcoqG8F3cZyBAO1+KYUB
X-Google-Smtp-Source: AGHT+IHsVcEJWnjTOcRm6kFFDy//zI+E6pFS+QqeNfX+0JG9e5gfDnfkAhZ3l+gYEusuaLmHBHf70Dl2/e/vWAz5ugA=
X-Received: by 2002:a17:903:1a67:b0:24b:11c8:2d05 with SMTP id
 d9443c01a7336-2946e23029fmr26514085ad.45.1761215585733; Thu, 23 Oct 2025
 03:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913105252.26886-1-opensource206@gmail.com> <8199bec4-b9e1-4d6e-98da-a4d7eb667437@kernel.org>
In-Reply-To: <8199bec4-b9e1-4d6e-98da-a4d7eb667437@kernel.org>
From: opensource india <opensource206@gmail.com>
Date: Thu, 23 Oct 2025 16:02:54 +0530
X-Gm-Features: AS18NWAg0QSyYQsw_O7gJY62YSwJ5TkGKjIiCvVi1yEvwsZR1T95LHjrV-YNDLA
Message-ID: <CAKPKb8-s96v+Nh29Z5E0wgyXYgoFHJT2SHA_WpZshXspo0WY0w@mail.gmail.com>
Subject: Re: [PATCH v3] media: v4l2-ctrls: add full AV1 profile validation in validate_av1_sequence()
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: mchehab@kernel.org, hverkuil@kernel.org, ribalda@chromium.org, 
	laurent.pinchart@ideasonboard.com, yunkec@google.com, 
	sakari.ailus@linux.intel.com, james.cowgill@blaize.com, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:44=E2=80=AFPM Hans Verkuil <hverkuil+cisco@kerne=
l.org> wrote:
>
> Hi Pavan,
>
> On 13/09/2025 12:52, Pavan Bobba wrote:
> > Complete the "TODO: PROFILES" by enforcing profile-specific and
> > monochrome constraints as defined by the AV1 specification
> > (Section 5.5.2, "Color config syntax").
> >
> > The validator now checks:
> >
> >  - Flags: reject any unknown bits set in sequence->flags
> >  - Profile range: only profiles 0..2 are valid
> >  - Profile 0: 8/10-bit only, subsampling must be 4:2:0 (sx=3D1, sy=3D1)=
,
> >    monochrome allowed
> >  - Profile 1: 8/10-bit only, subsampling must be 4:4:4 (sx=3D0, sy=3D0)=
,
> >    monochrome forbidden
> >  - Profile 2:
> >     * 8/10-bit: only 4:2:2 allowed (sx=3D1, sy=3D0)
> >     * 12-bit: 4:4:4 (sx=3D0, sy=3D0), 4:2:2 (sx=3D1, sy=3D0), or 4:2:0 =
(sx=3D1, sy=3D1)
> >       allowed
> >  - Monochrome path (all profiles except 1): forces subsampling_x=3D1,
> >    subsampling_y=3D1, separate_uv_delta_q=3D0
> >
> > These checks prevent userspace from providing invalid AV1 sequence
> > headers that would otherwise be accepted, leading to undefined driver
> > or hardware behavior.
>
> This patch was merged in our media-committers next branch, but I noticed =
that
> it now fails the v4l2-compliance test for the visl driver.
>
> The cause is that the new validation now fails with the default values fo=
r
> this control as set in std_init_compound().
>
> You can test this yourself by loading the visl driver and then running
> v4l2-compliance -d /dev/videoX -E --verbose
> (-E stops at the first error)
>
> Can you provide a patch to initialize this control with sane values?
>
> Apologies for not noticing this before: there are some issues with the au=
tomatic
> regression tests in our CI, so the tests weren't run.
>
> Regards,
>
>         Hans
>

Hi Hans Verkuil,

Thank you so much for the review.
yes, v4l2-compliance expected to fail indeed since it is sending
default values which, our newly added code rejects as per
specification

when you say patch, you mean patch for v4l2-compliance tool with
proper values so that v4l2 core driver can accept?

