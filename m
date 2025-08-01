Return-Path: <linux-kernel+bounces-753256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E370EB180A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FC1890F98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B18623AE87;
	Fri,  1 Aug 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IZskYN6m"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82E23ABB4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046313; cv=none; b=myZTbSgDYp22N/B5EbNXZxY7hC3dsJDfVZGxDC3y/mY1QrR3mOPf2beGHQk3el3jOmDQlhBJkIxn/lOq5aeX1oY6kPQUsmGNbzGCsZwaLuVptrahTyNzQv34yi4PX5mBjSnmvaSw8AkFcuFV8k1gLS51UiwScqmxE8MNzPGvdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046313; c=relaxed/simple;
	bh=/+jMRUVcZ6t8Pl8l4LNW+ajilhtOkPFN+4QMcHsiT+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fxw5RfkkDP4OOSGARf2KCR6NpyH6mx73ob3AGGH7lYXiwxOzDQMcZc5Y1EB903icePvaoq7rmSj436JF8MC5Gm/+a9KKecScZL90mJy+pILo0hpTk9m30edCgM0qH3JafmN1ywy9SW1n4wwsabGzk4Z7B2+PNDorFxKejRbTFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IZskYN6m; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74121e0fb77so446201a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754046311; x=1754651111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+jMRUVcZ6t8Pl8l4LNW+ajilhtOkPFN+4QMcHsiT+g=;
        b=IZskYN6mZrvU/Q8092yR4joeg+TARsyo10jcJJt31M3dQHkf7oXFB2veU/I4YxNV4H
         wwH904rYXHg8xy6+v+XiqyGHJ7OtI4lH+6I2ajj/CVrtM0fyRnYHFs+nh3l0rqa85T9+
         AMVjHEAlLaBq34xGySiizsDWypESszjJh6f5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046311; x=1754651111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+jMRUVcZ6t8Pl8l4LNW+ajilhtOkPFN+4QMcHsiT+g=;
        b=xDBTzsFQq+nNdheUZL3jKl3U8E/5/Zj2Dvgywi77GxZ/Jahl+WVJoNjkAKexxKo4xo
         qBroz9nD5VPiWJvtobRXp5C/OucVWrd85Fn91r7OP1PSCYr/trn+o2n6GkiHSvBlC+uf
         LeNydc3XAlskdAose4KPr50GyO2gk789sYNIUdAsFBEy+VexoRicmC9vhZcv+i/RHar5
         IgNALA+Cz22iYuRHqd026yru+jrdMchJFG2tw2TzzVElnE9rqIOerF8gYA1uo3GnHvuQ
         9X2d0cntgvUqvnZWg1qz8IpH4k/p7CFm2b0L55zF7NzpCwnkMrPTTJJraSpzdcIwC74c
         eqkw==
X-Forwarded-Encrypted: i=1; AJvYcCU9JYL0zrEe7Lrv9IRibsO3RcdDl9aUbqWZyWe2dc+VkJjgev0u+bSwH0P7Hj+dVLpV9pVBpJvZkbWb8ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmk6GZzfYgiuX0DI/piCD/o8t3UITY70n970PAbgrQpQZ6Mh4c
	VBmalqHh4txXNjPleiG+L6Qmz2AU1eBj8JLUONSFMFifI4+c6xHYUNhBoogPJOeQwXnfXjV3Dmv
	Czejkzwz/MJaPjG5g612QPtTRg2bzM9wTKkbWsEM8
X-Gm-Gg: ASbGncsleUefH0x4jPi4UnOxdmg9fUt/aqPXagk3hMoPAXKb6dvPGd+woOWRruHMUCa
	YSQujrwVcqhSRSkJ+3EleCTAHeeOR2VY1QIuPSMmvBpUj26Rt7rTzy+UsDSZlXHcVgvTqdZIOk2
	rzVQrMXbKp+9HXXShiZztan1PCY+7uEgfO0VzLRbUy6G2PUuIGNj3KRllh7TiQBj9M8yROyaWdP
	fxNbXwsOKNTMtasboGX3scA4VH+y5UHM+yxbCIsdtPRnQ==
X-Google-Smtp-Source: AGHT+IFcu23cfo1L+r2ndOaJ6tIGjp3L6Og5YNOYpWEWiKowVEeAG4TrrXquLF+MqSuI+nCk5jD+RBvLEHmkGlbWWB8=
X-Received: by 2002:a05:6830:3987:b0:73e:9293:554b with SMTP id
 46e09a7af769-74177aadc6fmr7049993a34.12.1754046310929; Fri, 01 Aug 2025
 04:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731101344.2761757-1-treapking@google.com>
 <1519a7c3872a59b7b5f12e99529237035499bc26@intel.com> <CAD=FV=VBhamkffZhVuMEoiwfAoeHRzSORo+=eqMLYVsSBMO-bQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VBhamkffZhVuMEoiwfAoeHRzSORo+=eqMLYVsSBMO-bQ@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Fri, 1 Aug 2025 19:04:59 +0800
X-Gm-Features: Ac12FXz59Gv-xeWJuJdY52SRDvtajWsArQQuLuzom-4gp2vT2ns_QxyRWnAtOXk
Message-ID: <CAEXTbpcPxpbtwy70uGxMcwsTcjpTqEX3EBZUyMg-6k5ULE1PmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel: Allow powering on panel follower after
 panel is enabled
To: Doug Anderson <dianders@chromium.org>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Chen-Yu Tsai <wenst@chromium.org>, Pin-Yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug and Jani,

Thanks for the review.

On Fri, Aug 1, 2025 at 12:38=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Jul 31, 2025 at 3:31=E2=80=AFAM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
> >
> > On Thu, 31 Jul 2025, Pin-Yen Lin <treapking@chromium.org> wrote:
> > > Some touch controllers have to be powered on after the panel's backli=
ght
> > > is enabled. To support these controllers, introduce after_panel_enabl=
ed
> > > flag to the panel follower and power on the device after the panel an=
d
> > > its backlight are enabled.
> >
> > I think it's *very* confusing and error prone to call follower hooks at
> > different places depending on a flag. The hook names and documentation
> > say *when* they get called, and that should not change.
> >
> > I think the right approach would be to add .panel_enabled and
> > .panel_disabling hooks to struct drm_panel_follower_funcs, and have the=
m
> > called after panel (and backlight) have been enabled and before panel
> > (and backlight) are disabled, respectively.
> >
> > In i2c-hid-core.c, you'd then have two copies of struct
> > drm_panel_follower_funcs, and use one or the other depending on the
> > quirk. You can even reuse the functions.
> >
> > I think overall it'll be be more consistent, more flexible, and probabl=
y
> > fewer lines of code too.

I was thinking that we probably will never have a device that needs to
register both .panel_prepared() and .panel_enabled(), so I implemented
it like this. I'll update this in the next version.

I'll also fix the s-o-b line. Apparently I've messed up with my local
git setting.
>
> Yes, exactly what Jani said. We've wanted to do this before, but I
> just never got around to it. There's even a (public) bug for it in the
> Google bug tracker and I've just assigned it to you. :-P
>
> https://issuetracker.google.com/305780363

So my series is not a new idea :P
>
> -Doug


Regards,
Pin-yen

