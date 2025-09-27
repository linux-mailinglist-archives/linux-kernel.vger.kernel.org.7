Return-Path: <linux-kernel+bounces-834987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6BBA5F83
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B291B24A1C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B592E1C54;
	Sat, 27 Sep 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPVfMT0w"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236472E06ED
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758978228; cv=none; b=Zs+h9knDZlggRu+ons49EzaOb8pd+00vzpU1zmt8L5VtJ6+nunoEp+oomqcBWdEwP8L4hhb0/oOeOsA/LISeE6hMJLKOl4JkejC4IP2DKJ3uxu5gbzr+llPyGN4g6rXnoFbTDYIeh3ecS7ED+sawRILYB7MTFoU3d0SNHIG0O/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758978228; c=relaxed/simple;
	bh=/fWjDy6V8avarvNTCc+QfosD1L4dICg/f5aj4SVzYzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAcSSrRUux+likQSdIR40sh/QdQPmqQonjQImthT/mZk8hpQkrpxIlLJf4Q3+ePrwtOh9tky06j2ckklUMm6LKOlafAA0F3Sn5xGcvyJdL4Q9rHhVMA+YdNMJvuuYimY5xJiZr4ba0eiF9lOTVLC5Cr23nLloZpgwqfGHvetHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPVfMT0w; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b55197907d1so2345417a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758978226; x=1759583026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj5tk1g12uwJWHZQdttUwkD9hZl6wqd9nBrGl6G3EH4=;
        b=aPVfMT0wQUDt+FvdtdudZWosKF/I0wA4eo7Shg7D4A0K4FgXH3UZnSvkR0SuvvygRq
         6BnH+m0gDfI1qTl/jrofAvBA3buKb8VJsTKq2AULR1626pLc9DwdqvqbAN6VH+0Ve2Xy
         MCtuX6jHtSmQjuEz/fzXrLfbhrJWfsxWmMGgfdkyoNpTrbqT/xtMgacPXNgat8BE34QE
         roDHQQtWmxhjMyTheLo54IqmxaiU7CiykqX7DfY7xopneaPf5PzYLg800jSXjuL7wu8a
         ksqN8sfxkI83UIb/KNC4X17bjaY2SAWPdOQfI3h/24sv2YQvlt/vNkxBOOWpz9sTdY96
         ufbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758978226; x=1759583026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj5tk1g12uwJWHZQdttUwkD9hZl6wqd9nBrGl6G3EH4=;
        b=VgqWYd35tE+dFwIFv0rpedq5njHw4s0GxONbCKkAep3FWvHIPIYOFIxDeA4MBF2uAD
         hBIyDCxKN+cA/C0mGDm/krvMUrDZPEbqkg8vaZotUtUF9tO6vOBkQkkwqApUA/wHeakU
         FJdfFme8VT/vpVCtBaxDmvrZjI0MNayuDSrOVV3Eds7R/SvotusTeorrCLjkNL6PSKGO
         guTdwPy60Pdks7Shn7pdgSTeuR5WGmAs470BDrRJUPXjpP5IZU9OhGT7CoGYBzK7aQ5n
         Tj0+fyDmUwJzCevM8Cqp/MafMEWpO0zVto4W7j1EvTODaY3kGHtOTMgS55vtBbE4Nxbk
         Rpyg==
X-Forwarded-Encrypted: i=1; AJvYcCWJIn1AMXcGP9V1WbJ3y5yz9PCTi7wIFko+DfMm/vmY4yL2rrlAYmzqbAqRugX1mtCXmFG37TDdmShWkkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVk0ard0t7o3Ljm+nrw9TxvuxNl0u+sJak1l0NgouXiz8Na4fJ
	ZZnmK58b8wJypwZ4Mioer4Ay1QnMF1qhYc3CAPUAoanSQB2jGbT2wQ7l5VtAcp3rHp1Itity8Tu
	cYMgcQrVydVwF7g8TkMf89Q1ObSKCLcg=
X-Gm-Gg: ASbGncsO3RV7WmRRxMskAV6EiaH4p2sJ1+focY64kOdeVLd0/lIGIBgEae9loKq2rnC
	Ue9uXGEyziHmNTDJ1PyX1ZcINfPx8HjHZnV2ALh2M1JSRBcOkte5BrknhOzgdSr5jIRX0VrRz11
	FC0fglU+kK8oDJ1SV5RNRt9AHZFxf7LGNtBY4vtJoL/3OVlwaWKE72AJJw9eKYcJSKjDdYS4Hw2
	fy+vQG2fVJF91Dy9Jzjpn7NXStTLPZdomchsV15c5CPsj9B+qfMuN4EArkiJgoiaIF4Gg==
X-Google-Smtp-Source: AGHT+IFQydMe94D6FwmBD6D2qXtQeTSXE3uir5zVOh5IAVVaCaSW+eB33R3ldR/4t5FzOh37nVJmnRCAO0XKqK8E6YU=
X-Received: by 2002:a17:902:c94c:b0:269:8d1b:40c3 with SMTP id
 d9443c01a7336-27ed4a29ceamr124277135ad.12.1758978226334; Sat, 27 Sep 2025
 06:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926162658.989479-1-kriish.sharma2006@gmail.com>
 <878qi0b97l.wl-tiwai@suse.de> <aNfRhzjqs6Z2fi-n@archie.me> <CAL4kbRMp912C+xqO4RYnGBO_VSqXJDSkNMgktd04zcUMOn_4-w@mail.gmail.com>
In-Reply-To: <CAL4kbRMp912C+xqO4RYnGBO_VSqXJDSkNMgktd04zcUMOn_4-w@mail.gmail.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Sat, 27 Sep 2025 18:33:35 +0530
X-Gm-Features: AS18NWALVElsH8JKQCuuo6ictSDUaIsPrD2BhEg-AqZ4pZxaHqYhteAWJCms6-A
Message-ID: <CAL4kbRMLnkJJcC9zoS+vSbwPxsU=82960vc1pOcrDZKsjLbz_A@mail.gmail.com>
Subject: Re: [PATCH] docs: sound: describe 'chan_map' member in snd_dec_opus
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies my previous message to the list was sent in HTML format

> Thanks for the feedback. Do you prefer me to send a v2 with the Fixes tag=
 and nested struct documentation?

On Sat, Sep 27, 2025 at 6:28=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
>
> Thanks for the feedback. Do you prefer me to send a v2 with the Fixes tag=
 and nested struct documentation?
>
> On Sat, Sep 27, 2025 at 5:29=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
>>
>> On Sat, Sep 27, 2025 at 10:17:34AM +0200, Takashi Iwai wrote:
>> > On Fri, 26 Sep 2025 18:26:58 +0200,
>> > Kriish Sharma wrote:
>> > >
>> > > When building kernel docs, the following warning appeared:
>> > >
>> > >   WARNING: ./include/uapi/sound/compress_params.h:364 struct member =
'chan_map' not described in 'snd_dec_opus'
>> > >
>> > > The inline struct 'snd_dec_opus_ch_map' inside 'snd_dec_opus' was no=
t properly documented.
>> > > This patch documents the 'chan_map' member and its fields (stream_co=
unt, coupled_count, channel_map), resolving the warning.
>> > >
>> > > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
>> >
>> > Adding Alexey to Cc, as it was added by his patch.
>> >
>> > If any, please resubmit with a proper subject line (e.g. "ALSA:
>> > compress: ....") as well as the Fixes tag pointing to the affecting
>> > commit.
>>
>> In this case, the Fixes: tag should be:
>>
>> Fixes: 5d36370f3431 ("ALSA: compress: add raw opus codec define and opus=
 decoder structs")
>>
>> Thanks.
>>
>> --
>> An old man doll... just what I always wanted! - Clara

