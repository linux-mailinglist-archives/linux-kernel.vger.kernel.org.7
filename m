Return-Path: <linux-kernel+bounces-778089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C7B2E139
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3774B1C8744A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684D36CDFC;
	Wed, 20 Aug 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="br2XFwYf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087C36CDEA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703533; cv=none; b=kbJUPz9Y7SRudVFqRL6p8P19Sdzv//W908hqAkB+eYvpxFWoKHWNKM59qTxnj7uPTqn5bkkOXI5ZOyi5IL0+jkEp9QUlaJLSX/ljzmWwiSOJ2Cmy+bn3VTJ6PfyByk2uYOC8nNMIMXcFZNat4Fn1lkzhVqorwZDGCVSRVag6BMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703533; c=relaxed/simple;
	bh=XxY6ek00sDc3+fAtpidxuu/eX/gF18Bni2g/mJZ9m5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfNjlcDMkXRy25tadnKUzOUc3/DT5IoHFsQRAdXBkEcYP1oDl0lDykTzlNQbLfNpF/WZfbFHtIIl/tx5WeyxhyyPBC9F94FzW63UFOL5XvxsCeaMjANrBM6g6BImEh4cSo+rTPIeYytAtIEz8iCdcfVPaa+5/fzz9JKEmzPHooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=br2XFwYf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so62552695ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755703530; x=1756308330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Uwy9jIZdofD/KICjKUSkalZ1bxXpwdmk7aQGqM1F+w=;
        b=br2XFwYfHJl6SOwFVzQe6a4yvk0G/QzgFBlKHqUFCuylUU+yeDH4Z74VS2xE6MCPWC
         xY22NpvwRB1iqK7LMlc/o8SVX/TALvSMdeuWDeah0vVtU+WHCvcFjPB/j3xmcoPQRM7x
         i9Bo6WHPakm0JMJFISb0cteoAwjsqGuQ4TNYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703530; x=1756308330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Uwy9jIZdofD/KICjKUSkalZ1bxXpwdmk7aQGqM1F+w=;
        b=j7llnhY+8BFPoBkwMoE/Tgem533UfYILn//+9KpD72Foa6w6d5t1a2WIZKUd0/zmu7
         sx+zGhXg/UcRxznnxNSEifLVgNpyNPo+dLuoURdIZRVsc3WjqNwG+qrLsJT+oWjcIUe6
         rJqtn/GgmIA1gQONkKekQfEE0YFXstg4miHE+xtJspHB047FwCXV7lvBC5XjdSS1STzg
         qvdJu1x9vMPsBWgps4Ot9yRAVkyXeSUvkQUC2DvqShiqcT+95qjJXzoQmXTzWG99smCz
         cxc5v6gbuMsueZgraWmXNvGLCByFZCCVpgxQvIJDH2fsxICObPBBbVbXCuPXwiHMp9Pv
         AJTA==
X-Forwarded-Encrypted: i=1; AJvYcCUDIoxaUYFUHs9Vz1NVW+LYcDC+Y5EuJli2r/Q9c92uhHArtGzZrTBt/cZ/cNRIykU+G/GnY1iLddaOcEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4faJJbRjSUDd6Zps9x2+MXOJUfhjMQwRnCgFY271OVZoWs7Ht
	ON7Q4VzKJL+fKJt/RSYKrtFelUY0X8dx8pTaKeMKebwhQu3d37j2c0ceHhc9BgkB7xsPnBBSMhg
	8e0avmg==
X-Gm-Gg: ASbGncto9xK7an92BaG94TqNHNy1QQdTn1ijviJCB1ox4gg51yDvPvGCiFnUcso5dFT
	TUgJJuo2wTLcGP6emIPxS8xHCd3/XW2/rl3ocpP4qw2/8aXLxZgGHTEo7d1lQQgMkqqJ/3H6mmB
	TPMwDT1uCnXpt8cO/CmQz/CWe3bzL8ezkofpxtZo2EH4vK0OUKLI66Jf3M2H9s+b8nWLim7uYqA
	rmdho3JtNBJPZwXKthKHf4ewzwIA87t86DT0n6A43MdKNpr1XrurMhZMYDfAqvsmv07uDg/VBbw
	QoL/gHDQsK8YqLGAFGXOGE9ccR2WYTNLQO+HGL7W3p1N44PiXaYf23iw8VSLRG6/krv78yDGlw5
	NTIdTsN2L9keFFFj+uxklu3+XEMvgiG+HdYxjbS4VJy7Qzz7aIZGOrljFBNksLiLkVw==
X-Google-Smtp-Source: AGHT+IEUT/tT+IfqX7Mvs4yEeuL9QsbDK5Gt8JG94nYZ3q+jT6imVICXbZj7i6c0wg6iBtpbI+LkDA==
X-Received: by 2002:a17:902:f64a:b0:240:49e8:1d3c with SMTP id d9443c01a7336-245ef1e45d7mr38597865ad.35.1755703529555;
        Wed, 20 Aug 2025 08:25:29 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51aa14sm29635495ad.145.2025.08.20.08.25.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 08:25:28 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-245f19aab74so5718715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:25:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK2aTeV/yjrUtsYQRd0fM35QV0ED+Ff/xMruqT00nfZP6USVeFyMWQOwCnNc8fLuEWMdma9xiZTTggv7w=@vger.kernel.org
X-Received: by 2002:a17:902:f70e:b0:240:66ff:b253 with SMTP id
 d9443c01a7336-245ef237b85mr45917035ad.46.1755703527669; Wed, 20 Aug 2025
 08:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082135.3351172-1-fshao@chromium.org> <20250812082135.3351172-2-fshao@chromium.org>
 <CAD=FV=X_CiSoXyKkg8jBJLPKe3WDBpLEOAngQJNnN8yZfaC+qw@mail.gmail.com> <CAC=S1nhXO4mHkxGbLzja2au7RAfDR+-yRoGAkuMCKCc69N4rng@mail.gmail.com>
In-Reply-To: <CAC=S1nhXO4mHkxGbLzja2au7RAfDR+-yRoGAkuMCKCc69N4rng@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 20 Aug 2025 08:25:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WFR7b=7h6gnyH_MtLW-dcngEqocBz6Lox4_JSBMO9RhQ@mail.gmail.com>
X-Gm-Features: Ac12FXyCoYEHWTUKnbt2HWCJxT_MXeti6--ZquIbT9ku4wcEFO6wcTTI38buFwc
Message-ID: <CAD=FV=WFR7b=7h6gnyH_MtLW-dcngEqocBz6Lox4_JSBMO9RhQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] drm_bridge: register content protect property
To: Fei Shao <fshao@chromium.org>
Cc: Hubert Mazur <hmazur@google.com>, Sean Paul <seanpaul@chromium.org>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 12, 2025 at 8:01=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Wed, Aug 13, 2025 at 2:07=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Tue, Aug 12, 2025 at 1:23=E2=80=AFAM Fei Shao <fshao@chromium.org> w=
rote:
> > >
> > > From: Hsin-Yi Wang <hsinyi@chromium.org>
> > >
> > > Some bridges can update HDCP status based on userspace requests if th=
ey
> > > support HDCP.
> > >
> > > The HDCP property is created after connector initialization and befor=
e
> > > registration, just like other connector properties.
> > >
> > > Add the content protection property to the connector if a bridge
> > > supports HDCP.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > Signed-off-by: Fei Shao <fshao@chromium.org>
> > > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> >
> > nit: your Signed-off-by should always be moved to the bottom when
> > posting patches. I wouldn't bother re-posting just for that, though...
>
> Ah sorry, I didn't notice that..
> Could you rearrange the tag order for me when applying these patches?

Sure, adjusted and pushed to drm-misc-next:

[1/2] drm_bridge: register content protect property
      commit: 407a2fab3c99c40ad1acedaf028e8222da1f0433

