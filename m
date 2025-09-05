Return-Path: <linux-kernel+bounces-802784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14773B456F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE0B189F80B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF134A326;
	Fri,  5 Sep 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KMx/d56S"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1E26B747
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073215; cv=none; b=U7xV9jW0oCwwx7VJSvVhHnLqhLNuRWt+4mj9Kzcf0FCCag7e8AzjWGMp+vE1A62aId/15pqr4qIXFnU44+nWI5NJC7PQqNYUTvNfiHES1bEMgyNQFmsl8j0T1GfoXrA5YQJvXTKyTviKBA2Dghval76+lqz5X/pzri2GuVwyEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073215; c=relaxed/simple;
	bh=tXTx0khqBmsWWU+P4PnW2zGkwrJJZK3FQK11Bvgu8Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RawkQAvjuhQSHnKtc1bvw8wOwPco42fGJFLaR+9yJ6LYoxrQG7eqnmWF+tyBLti/a78iA69ZtrA4HSWG6RevdXwDg0eZEYnjQOWq1izBE4nx2+1ueCFSBQ4RH8I6qVULIX2Eq3sJlGWQYCFGuekqeU1TNiT8A2yFhBu8qlarb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KMx/d56S; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47052620a6so2267987a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757073213; x=1757678013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F41JthKB4C65sSuKjAh9iAVTRgSsULVhOOzeHvyaTPE=;
        b=KMx/d56ScDM/SDv8lJgTaKxZr8qoswIPDdw8mkBxRfd1XYwq/aTMf9H15PnIgqxHSJ
         hKUHD3oQS6GFW6IY9ZEisssY8+R8fTgwbK6IIbVTVt39zI+/qgNUPh7rQ6OT1dNiable
         Aa9Sa28/t/FvDx+6eJAStiapQWmUzNty2WNJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073213; x=1757678013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F41JthKB4C65sSuKjAh9iAVTRgSsULVhOOzeHvyaTPE=;
        b=SG5ANFwgH+699CXVnzKIAxJqo6cbjTyIEMYT8D8GgTpeQoYnzH8y7oaWMVyozdtFKr
         3CD3rT/Ma8OuYeXKJCfImwekZvbp1D/2jprouw53jdG2RO7TaI6gbLclwJvqLLZtj9/w
         Rd3y8/MV8E3MpZyOPXC/d+Dun+fKfWEccst/eQmCVbLtyM+iXTOg8zxDfFYYOn4nl2f/
         ACaXfxOdA9aBFKnVNdZW9GcKHOU1DEYcSkmeYmauWtryGws/w51irjkgyY0Qo47LM8Nh
         G6XkorJOVRRDx6hTyoCr1VjbMpsDoaQsDIgw2+B9AqVhVxnpRtgRvTQ7YUrswu12JHIJ
         EjMg==
X-Forwarded-Encrypted: i=1; AJvYcCUoU+8sgpQGw9t1RLUaa1OHQdD0OjWCPeCiSCRJrZ3t5rD+/HiQ0KpLsvcFDS9kZ3K1/c0fuJmYJPQbuiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNuXptU0EKccZccWXkMBKOZ98CR5st+lIkVaXqofGvnBXhD2qP
	qfiBkL6co9TOz3q2d+Zbd8LlCxG61HfGS9MNRT1106nYRvR2cym2xBVJ7WNFpbb1IGazwXf+ASe
	jrHgqSSDDR8gu3Yn5pPdqzAPFQFKwd2u9w22be61Y
X-Gm-Gg: ASbGncscFui7yaxmK1PeC7tZ+RPYpgWPz9XLBMEpqAdFdOXZPRtdw/ZGnoE++OdRjlW
	Rr7qfr/3lyOaFNzPA9qVwk6K1Yao7s4ZTTqRnbnBl/R0RiVmeKYsqjtRFQkfZ/lmblbRvOmw5lZ
	1/RcgOZIBlhwSMM2f2O7Vxmk4hvaSDiwT/cCWeU6VEC6Q8o8csiZvjxhyUQ80nC0r0gpteIRUka
	ANH9o07V+DutuGuhNte1DRoNUOUezayBA==
X-Google-Smtp-Source: AGHT+IEN1O0V/duOoV36FoG7uqX93rMwXWpvjMiuL+p5CH98oeicc+oRQqsaUN3czxuXHbTlA0O+Sji4kT9kRYHU9gw=
X-Received: by 2002:a17:90b:1c08:b0:32b:6959:9a84 with SMTP id
 98e67ed59e1d1-32bbe1040a1mr3955599a91.11.1757073213062; Fri, 05 Sep 2025
 04:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825145750.58820-1-akuchynski@chromium.org>
 <20250825145750.58820-2-akuchynski@chromium.org> <aLq0FCAq-LiB139t@kuha.fi.intel.com>
In-Reply-To: <aLq0FCAq-LiB139t@kuha.fi.intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Fri, 5 Sep 2025 13:53:20 +0200
X-Gm-Features: Ac12FXwtlyscSNNgxTecVI02owwO8UoR1t0SvM0NbByNpcnkqJWSEDXQoTY3or8
Message-ID: <CAMMMRMeq2-kGZeZUi_UwcUjr_TORYcncgJEqAG5+jX2Hbs-ULA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] usb: typec: Add alt_mode_override field to port property
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:57=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 02:57:46PM +0000, Andrei Kuchynski wrote:
> > This new field in the port properties dictates whether the Platform Pol=
icy
> > Manager (PPM) allows the OS Policy Manager (OPM) to change the currentl=
y
> > active, negotiated alternate mode.
> >
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > ---
> >  drivers/usb/typec/class.c | 9 ++++++---
> >  drivers/usb/typec/class.h | 2 ++
> >  include/linux/usb/typec.h | 1 +
> >  3 files changed, 9 insertions(+), 3 deletions(-)
>
> This is okay by me, but you forgot to document the file.
>
> thanks,

Hi Heikki,

I missed it.
Thanks!


Andrei

