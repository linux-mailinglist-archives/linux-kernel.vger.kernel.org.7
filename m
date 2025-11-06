Return-Path: <linux-kernel+bounces-887841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BFFC3932E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 315F44EA151
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B82DA746;
	Thu,  6 Nov 2025 06:02:00 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806B2C0F78
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408920; cv=none; b=uU7l+oI5z9BZ9xNKdH2oUbnmLPJf8e32SOcEJPuBW5Sk6rYNDMJzZ64I+y77RM9DpX4Spz5xz53uxfCfU1wHcbW8Ft6tMnTy2yQ7ZbRkfGeW/OJS+y0fu9w+N41WEjXFnwxbTdbINyiPe9vZC5k4e2LW/QfgCD+X65se7JQch0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408920; c=relaxed/simple;
	bh=/EMy/K4xOqVd/TJc3X5qTwSIeGII2QmhmiESeAGTuis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idGp413CEzG9fwyu/mEF1DFz0FSLxg3PpZtSIm1cZgc1KkDu6z7xmZzHVbfKKJGCN1YgouhHtVU2C62I4H9eLERD+jX/XPVVnYCH6NsaLQLtv0Ds8nn0yPddU5Fv5KEY3wcASL7qMZ0KTeSMNY3ByMfHU5UwKljsJK2zLNGF7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a34702a20so4889621fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762408915; x=1763013715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EMy/K4xOqVd/TJc3X5qTwSIeGII2QmhmiESeAGTuis=;
        b=Ht+PxDCrmdjSilDnn95mmxf2O0NIt0msu3fi40g6VTFvkzvM9PzqnXC8bPoVeWH1dM
         48Nm37IIu2ZhjMxq0wEDR5ELTZuhTd2rM3sWrWlFL9I4HR2ta9yrNYqes+2oli4VLmor
         I4oRoKfzURuyAKlVSpl19l/b6yjoaCrgJ+au6t0Uvft0v/rLRaknaWktfONm3MccJAio
         cnEKt0fU+xa8Ybo4Tvb83hH/q/F4rZ2UK3sOGpd7zcdA3k725HayK5oZeZayoGIgYGST
         vplVhmRSPTJgNI3CdOWdgZgMmkQBivgtDBSuNMisglroj5Q1LgScqHabV3VUOiXc/bTF
         Ua2A==
X-Forwarded-Encrypted: i=1; AJvYcCXBFgv4JuQ/iC4juVcDZ6UftWqb57X4//skkNEjZPepjlKtBLUYz0+fYagiUaV5t/kPyw742BEgMZhwIBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoPyR0RIjueWWG2++CfXWPzy1ARD93yMpnJxmfb7SeSqVSxCT
	em89ZhIqpjiycotbjn0Ej80VOKUVakfQI8HC6gYIpcVyAkxMA/pH5+sqtippng==
X-Gm-Gg: ASbGncvO3hMTSwFZN+5RioROvijz5YjPTWseDx18zswz6kCwMqR7HOQhlacKeSRYHMP
	+dNsO75hODHIFuqf/slCCjRDdP9ir2pNAXC+sSgde2OkKe1T06nqwd45CHHuTq0pAMfXzFNHJjs
	xIz0jL/vXb4LMcPbjaFSMWhsu+UUxtvvu9ekwxvwLnLT9x1rj/K/CwPASsKu+h8/e/3i+lY+MlZ
	w1e3/+yP1HTPEIwSdWJjae9r0cAcj3LfWJt63jMqBaaVNoJ8igSoQu4if7uXN12jQVlYRlghRyi
	9ne6H3oI5MH2IzL5JHJr3XPz4j8owhIGpJxF/u4/vtaYnJCiqusFQiIN+M2NQnfx0glqlODaWtH
	nO8j/alb68Dh190MOmhSYKMnwsThfwDinKsGjmXdGoUjP+S3ail+MkDdc5lF6DARo3NoyfYftEj
	ZQGJR9rjYwGhNVruo839K+PavGO2LCTUPAfkIURM75h/U=
X-Google-Smtp-Source: AGHT+IHE/07rzmTGH6JswtR4smnI4AlQ5WOgF2aPnNGFd/nIdotgJVWRqDw0HmMXjbrT2+NgzpXMCQ==
X-Received: by 2002:a2e:b8d0:0:b0:37a:4bbf:7962 with SMTP id 38308e7fff4ca-37a51475b27mr17121961fa.26.1762408915062;
        Wed, 05 Nov 2025 22:01:55 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0fd8c2sm3708081fa.48.2025.11.05.22.01.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 22:01:54 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso5486371fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:01:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbQwhX4asuegtv4ifjD0uKBmykJry7iAeTF8FJplvCng6CU2RO0pD/tNnRgs+k6tygwWCc/utDzDiqTnk=@vger.kernel.org
X-Received: by 2002:a05:651c:908:b0:37a:2d72:6119 with SMTP id
 38308e7fff4ca-37a51406a51mr16362171fa.21.1762408914469; Wed, 05 Nov 2025
 22:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704154149.3464461-1-paulk@sys-base.io> <aKhFPRP8ILNkKAvy@shepard>
In-Reply-To: <aKhFPRP8ILNkKAvy@shepard>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 6 Nov 2025 14:01:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v66=Ppqw+_fpAsRYd_4OBOhbHkk7RetfEXbYmvQ_+hoe7g@mail.gmail.com>
X-Gm-Features: AWmQ_blhZqLqx77LWLcKS7_dqP43aeZsGzE4L69w_GDVHcl80KjzuIFGb-55rnE
Message-ID: <CAGb2v66=Ppqw+_fpAsRYd_4OBOhbHkk7RetfEXbYmvQ_+hoe7g@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: Cleanup v3s mixer config fields ordering and indentation
To: Paul Kocialkowski <paulk@sys-base.io>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:24=E2=80=AFPM Paul Kocialkowski <paulk@sys-base.i=
o> wrote:
>
> Hi,
>
> On Fri 04 Jul 25, 17:41, Paul Kocialkowski wrote:
> > The v3s mixer config definition is a bit messy. Tidy it up.
> > No function change is intended.
>
> This patch didn't make it in the previous cycle.
> Would it be possible to pick it up this time?

I guess this is going to conflict with Jernej's refactoring / cleanup
series.

And, I think v3s is not the only one that has fields in a different order.
Might we clean this up after all the refactoring?


ChenYu

