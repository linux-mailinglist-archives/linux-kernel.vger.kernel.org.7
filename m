Return-Path: <linux-kernel+bounces-748623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F3B143CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4873916DFD6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23526AA94;
	Mon, 28 Jul 2025 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2CdzZo5"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853542222C0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753737847; cv=none; b=KgNyJ8v4mQVnmHJkveyQGY73XOwxQ83AX+czOHX6AvM/5Q7MSLQ63yXU+11CvPDVKzHlQQnZAdl6XKP+7ClSNZmQ1AolLDsRE4QAzbi12ik8aFfn3GuFDqn5oK6ijAT8mdumAeQHpwmA/2Z7XP+BGxZHpBDdnBt3vNUGJVwAQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753737847; c=relaxed/simple;
	bh=PR6Bmb/GXDhelSMazlv4bzLtGQXIwEObw6gaqQ9MH7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSbPGABfkNXt6pDQkn39LLIotYjSBkCW4kyOnRKEk+eOoBFX5biLvMl+0WJe18KHZVlNTc297ztcasPm6TwpZSQR1WZrfq2lPmY5MWOy8GMjhQgG2jWxLhgWk0jCQ0mboLMJARr+e73oLfYTLI2RjNvh//nKZ/+4pPJY/kIqhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2CdzZo5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31ec2ac984eso287541a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753737846; x=1754342646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnyU3zBHht6Z7NOh1WUr0q1KrJ4YVsGuKsvaRq6aEj0=;
        b=d2CdzZo529cGVNF3ORdmHlqcQ1Spqv078tP8EhEo1Gzh0nDhPkBkB1F8nW0JFVYIry
         ra5xQ7fXQINUwMAaGONEZYdrMhMLeStWkK3Vm/3a+7J9vL+flBSAeSMXuxrxxGJO1Nwf
         KjFbjk5DiBAtp+77FlPgRCXB9sqd6Ly/9f8+Zm5DKJknpdcB5P0ykeelQ8OxdHAhS8Wt
         3Ml732PKgy9ePygL98FedU3kxas0XOQO7bTzUzl25OisRuH70xHBzf/sRPfaokRhz8oq
         f//UnohOEAZiaiKdgjPifvKx/w4F6CdHw0f2OcS3SMLWDHastz6+AQ16c9xXURmDtGj/
         DHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753737846; x=1754342646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnyU3zBHht6Z7NOh1WUr0q1KrJ4YVsGuKsvaRq6aEj0=;
        b=VZHYaMupKUdURvq6saAlOLrxbUPm4pg2vLvlHW7ZySIU3QVyMt+s+IPjNOhXXY3RTP
         roff8xSikIoO8RaOqiN94JQjIUjBzYyl3vPM1aysE7Y2qMxpwEAfofyKTHrP+TloNii1
         BxbhFAbqSVVGh5DTU9ztqRTbFqjEPjLCiCXSdw1GG9u81yHzXVf/Aa05O72KyU7uWkUy
         e62VIO1ZVAQoV4Heodh9d7hDWYMPyFxQWKHxiazRReHLlRDvh+2m/oSuO6akHjJ/BHEN
         vOKPzBBGnOwCq5hj+TRMzWeMENxbcYx3IsNfIQRu585K0yYeXy3xr62FGGTGILHVNJW/
         mIqw==
X-Forwarded-Encrypted: i=1; AJvYcCUaO1oTXyYUn1PLvBaTcnBTEM7b09acyd0AQXd9ZZNPSbPuNfbTSOUeMpWwdiNnQkvbWH9RQ3Cwgryc250=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUgc62StHR0cjzOXGqZKH+EtkIKOzMXZoHRudZP6oFhnUqPKb
	IXK6jYa/On0JwvIs5MG6wIIGRByvuA8V6Vsc9S7yJ+Nz4L5g92Fmdo9wzvKvxUDOZxWqkVZ+GEO
	qy5eA1Vg9u/UoseODR+yH2HpJziLsmZM=
X-Gm-Gg: ASbGnctH08w5HilT8jqP1XulVwLQbLdr0r8waVjS7IC9c6sRssFiz4T2sZ7ogL9g4xN
	GsN88Do7Ct1Om4SArslmW24z2o2YHfNGABW3wDU0mAGD5wNU5xiHK4XqHezW1TyJpNV4DvbvYrK
	8GS0EPd+TDPsT31rkiTeudl6r+AgH7dkZr+LOPhfa2GU0MQTtyIdgv6bLqHKAmWxevDfmfttxEj
	xlFoMrT
X-Google-Smtp-Source: AGHT+IFMn7Er+ZI3GtpQwahkfKbUlbo/uHN3By9Q6pXGy3EiuqVCs/JWXfbQW+C8U14fcf4BfKNW9as6KGrtg48yANY=
X-Received: by 2002:a17:90b:3ec7:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-31e778d9e57mr7217472a91.2.1753737845604; Mon, 28 Jul 2025
 14:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADnq5_Mvhc-w6nUi6WmpL3Czp+0kqsFaZa6bgVqodps=8F1t=A@mail.gmail.com>
 <20250728195338.GA3244723@bhelgaas>
In-Reply-To: <20250728195338.GA3244723@bhelgaas>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 17:23:54 -0400
X-Gm-Features: Ac12FXwxHztX7Rf5OYTgYrAe8edepb-DozRr-c5yN-yRJsV-5dsHhXNuQl5WncA
Message-ID: <CADnq5_MwdowKPsdXZN=Ku4pQHMRVCMK=krdciVWnPC+rD5Zfig@mail.gmail.com>
Subject: Re: [PATCH] drivers/gpu: Fix typos
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 3:53=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Jul 28, 2025 at 03:16:32PM -0400, Alex Deucher wrote:
> > On Wed, Jul 23, 2025 at 4:28=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > >
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Fix typos, most reported by "codespell drivers/gpu".  Only touches
> > > comments, no code changes.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Any chance you could split this up per driver?
>
> Sure.  What's the appropriate granularity?  This?
>
>   drivers/gpu/drm/amd
>   drivers/gpu/drm/i915
>   drivers/gpu/drm/nouveau
>   drivers/gpu/drm/radeon
>   drivers/gpu/drm/vmwgfx
>   ...
>

That should be fine.

> Or I guess I could dig through MAINTAINERS and find the most-specific
> entries?
>
> What's your preferred base and timeline?  This was based on v6.16-rc1.
> I can rebase to v6.17-rc1 and post early in the next cycle, or late
> next cycle, or whatever you prefer.

v6.17-rc1 would be preferable. Feel free to send them out as soon as
rc1 is out.  We should be able to handle any minor conflicts if there
are any.

Thanks!

Alex

