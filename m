Return-Path: <linux-kernel+bounces-774429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EEDB2B21D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2278527983
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1425F984;
	Mon, 18 Aug 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AhFaCD4N"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71B253B56
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547904; cv=none; b=VlKRzZvkh57URVS49FHmuh2QFmWgVjeI97j08UiT1eOkiGczF4UW+x62AqbuamMLI4CxHM3IHpRf8jMKJQycyfbITzJ024zXDkH8cC90lrbjGX+c81QRTfoNVh2fY4IWDO63Lq1NjKW9ldQvOPaRf9jP+eRK2Vw4cqYZREb/XY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547904; c=relaxed/simple;
	bh=bMc4MEiytgUN5MSZi4bOBd3NylG8Y4lOdPTMucUwZM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ro53Z3THkHUsgBvExn1sOdes19Hq7cE9H+ehALLeglF5w2eZ07OFEpthpW9AyX3idO4pUl4XvnjPbiygnQy/DTmLKgKqE19exMBNPXgsldNAlzllWKRIk75GGUyGKGKl8nKNrYFvf6qyvpt3LyTmaxdeSUmtChdpwT4rIIvxmtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AhFaCD4N; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb78c66dcso646386466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755547896; x=1756152696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgER9EDMTIBQYEXALGtaORMx9kWQNeO2USv3gouUbwI=;
        b=AhFaCD4Nl9EopiaGZc8HNwqYRWJj52O1wK+l2J3UFkhKUTc5PVXPkp19RFFd4JF9sy
         lCupkBnjq/E8jupojAcWlh5l2yMen7YPTGamNDrxhvhEbHjQX6sDV8hN1LRM1AtegCQA
         AgH6wA7K68dgE1uAH3SPuciQsdhBuMSX6HAj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755547896; x=1756152696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgER9EDMTIBQYEXALGtaORMx9kWQNeO2USv3gouUbwI=;
        b=KTaKadC5xoMg7XsYPAO1XdmqoHTIwb3Z82387SVU4OMfPLkQWEpv+aZio13i0aHSQN
         OZqyyLu3nO5VfxMcFD46H2GdhtGUezqOAAORR7VzduBq7U9mn+O2AY0unYhU71zAFyCL
         gMVbomKmjjHV7l3dY3x0oeCgnSydVdDhDCSesQ+4el/bsLHAH/RZCsZafPX7Ae749mue
         ekID+HnCQAE9GOPuUYm9oLZXA38eiZeQVDzO/JjSANY9Ca+hUjWNokX3RXgCevYlSN9i
         Qb9JpCG1atymd1nGdW60K2OZ1CHVbrzYggqplvw499u93kGu+RTNl43xFT1NBzt8Dyuq
         MFzw==
X-Forwarded-Encrypted: i=1; AJvYcCUMxtl/YxyZ4nfSrmY8BZEqFUaTr0lQ0+HTD62Vk2/PVWyaE9QOETaWXPDAsEbhOx4aIIrb4CaY3qQJWFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrpjtRkdZrBu6MHmXnYtiA5tnuY0yi5T92YqijYzxpzD0JUAN
	N6qdxN0b3JMYMTrRIM8o1YqtVmmUtwaqecYVpiKvLiXQEWCm8hLr4cgWNQgXYsTR48J/nslBfIM
	yNXIwlQ==
X-Gm-Gg: ASbGnctGDqtVNr8W5Ma8gx9UQx3bAhSJQge4nteHu+MdesQ3X9hAI9qd6dQJpIh+NIG
	cZI8mftdvt2sp96okUV4/8l30zXdMgvbreDChV3836m67VUK0gs8121YDLbPlZMeRAt8kJOVmrx
	W13nQvBjbBlD/7BJvP+QrqGI/R2dpy6Mzu0iR0rVCHmuPKetvHLXntbCDquMbIR4oJZygOmm6rw
	wUmO/Fz+ePFhyqkrpgvznnIjZ+qOHj0ulQZSjQ9/CxoXFnNSSMSiUFNR7Fl9Hu4Y6OaLftFj6oj
	wJh9wryjT8TWZ9cCeJsgDt9NT6ZR3Udhklhm/BcLnRcQa6MXBILzTgEjkWGjATrB4dYw9HMAK4l
	qFrcp65WYIYdWa+ARRTuvplE/lzhRW1MoAEl29C/8Mguzz2IG5xN6WPV0WbmN6KKgeCr698n1
X-Google-Smtp-Source: AGHT+IEcNs04oNAXIPG2/71CdV0M5UBk6+YOxdiSZpAexW4g41Dklrpw/X45ZpzG63WA9HRsLB5teg==
X-Received: by 2002:a17:906:a413:b0:af6:3248:62bb with SMTP id a640c23a62f3a-afddcfb5a3amr6824866b.30.1755547896240;
        Mon, 18 Aug 2025 13:11:36 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd010e8asm849637866b.92.2025.08.18.13.11.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:11:34 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so606754766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:11:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfuVvv8bMLPyMmPcb30TT1102qI5byGzIwvsA1uBzdjU2qMLEQCZsssarUc90vXDFHQ/D9dMutYxd9mjI=@vger.kernel.org
X-Received: by 2002:a17:907:7ea6:b0:af9:3116:e110 with SMTP id
 a640c23a62f3a-afddd20426dmr6122366b.58.1755547893874; Mon, 18 Aug 2025
 13:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818115015.2909525-1-treapking@chromium.org>
In-Reply-To: <20250818115015.2909525-1-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Aug 2025 13:11:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZK3HO8iC3VyMH+fP_XG2ogSNvUWuUcPFUxn1jU6-JZA@mail.gmail.com>
X-Gm-Features: Ac12FXyrfB2_QJdzc3F-AXnavWgZcAA1_jLXyiQVztCZpVvUWjbjdascj2sVMMs
Message-ID: <CAD=FV=XZK3HO8iC3VyMH+fP_XG2ogSNvUWuUcPFUxn1jU6-JZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/panel: Allow powering on panel follower after
 panel is enabled
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 4:50=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Some touch controllers have to be powered on after the panel's backlight
> is enabled. To support these controllers, introduce .panel_enabled() and
> .panel_disabling() to panel_follower_funcs and use them to power on the
> device after the panel and its backlight are enabled.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
> Changes in v3:
> - Update kernel-docs of drm_panel_add_follower() and drm_panel_remove_fol=
lower()
> - Fix the order of calling .panel_disabling() and .panel_unpreparing()
> - Add a blank line before the goto label
>
> Changes in v2:
> - Replace after_panel_enabled flag with enabled/disabling callbacks
>
>  drivers/gpu/drm/drm_panel.c | 73 +++++++++++++++++++++++++++++++------
>  include/drm/drm_panel.h     | 14 +++++++
>  2 files changed, 76 insertions(+), 11 deletions(-)

Looks good to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If there are no objections, I'll plan to apply patch #1 next week to
give people a little time to speak up. As per discussion in v2 [1],
unless we hear back an "Ack" from HID maintainers then patch #2 will
just need to wait a while before it can land in the HID tree.

Question for Jessica / Neil: what do you think about landing
${SUBJECT} patch in drm-misc-fixes instead of drm-misc-next? This is a
dependency for the next patch which is marked as a "Fix". It'll mean
that the patch can make it into mainline faster so the HID patch could
land faster. The patch is also pretty low risk...

[1] https://lore.kernel.org/r/CAD=3DFV=3DUV8_XGmxC=3D7Z18PEnj6wKz+yZQuV_4h+=
LJh_MNCqszvg@mail.gmail.com/


-Doug

