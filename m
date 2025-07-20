Return-Path: <linux-kernel+bounces-738087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD8AB0B426
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520543B9EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 07:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B621DE89A;
	Sun, 20 Jul 2025 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="IzjdQdo7"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4F78F4A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752997848; cv=none; b=BvCN6WgVC3JH7TPucREpY5LoGDz7pZk+3lVXqXr4OINySPNCTLQLD5gAt7OxrCYmyaLdFjOECCypAhKhCwbbLgZ2OTSn91b8uqSWqsfBH6hB4BQYVuXi4InU+gWS8BuqcWg+6VaRpiySj1qPro4D7UONuvQPAPVwu4yZAlS2L18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752997848; c=relaxed/simple;
	bh=1EIzLiEKFNKNhapurV5TiPfyoyMNTU5jV2wejXKsOv0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ncGSYVAPjGCF4sXYAJQ3l6r0J01oqrG8+IevcIh1Bm1ssK7UFZoVfYrouPpuI8quqwcbC+4oZEWM6ME0/YnF0lLESEPTPtpqJpolfIyAW1TC55wMzbwjcrXj2Yu2IclbliTVPXELVd96tf5EfsKrVPMZuZb4bpt7uushfjI0mJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=IzjdQdo7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so3218409a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752997846; x=1753602646; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EIzLiEKFNKNhapurV5TiPfyoyMNTU5jV2wejXKsOv0=;
        b=IzjdQdo7wGaKuhNOGzIiwkYWcxkVGYcbdbgGLQXo2rqvvlIAIkQ85QFjVx5rmqKkL/
         UTy3KIWie02KA41hqh6z901fuLsW9CpW8Ef8QKZshcSkonyCz8Zo4Z+6pDY1TnUm5pYc
         EYjgyiTVLEB2WUJ+94v44rpmgOPKksBJdpGbzV99neONL1vjJ54YlsH50gXibNG2iLks
         ZEwCb2Ad2cL0fxOjr20nW2MyskLxHPTyz4TQcYw7iz5CVZwndUfell82A7uhUUT6ibz4
         cyqpgZ5RzAAq6gn6lBqig3iDjvB+CFW85IzlwEKuq1FVUc0NyBERdJsUd2zONtbNDcvw
         G/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752997846; x=1753602646;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1EIzLiEKFNKNhapurV5TiPfyoyMNTU5jV2wejXKsOv0=;
        b=OhaGZLY/ESQh2g1TiSW89f+kpj69NlhPpxd81qAnL+9dLvVZeBGhM0CwCQqZeE6TVC
         2TkNUFprzd/QwMRWArVbW1AS5oQbFt8Q4AxU+jncWhjfxAM26OpktIf3c3zZl18SBBUy
         Ltsq8P5dtQiws3NkH1zTnHBs06Xrpqo6h34tL/fc4jgSrHV7fxAmPPqbXDXzHETIW3Se
         VUbPema+tyLoomFCsnf6E/fZlvmK+kweEU1nOmevVQynVKcKcLuss+M5aQUacf/GRdLv
         a2D3gik5MXuyANBSkcyWtDciv++iAsE1HbkKMgsNmiPTU43Nx81B8SNSvC6Z0SA5HCsU
         WxeA==
X-Forwarded-Encrypted: i=1; AJvYcCWm23FztWnBD6/WvNBuIyUJl+Ryms3BHY7EZ/IqjJSNgRkCB7sIt4swQnFBbNVkysWZ4doVo3UdnsVq4Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaulDcHp4SbMUIaBsP+r6E+na5VvltXGpkxz+PqW0K6vvwJLy
	jk4hSFfNMEu6Gp0N0xpKFe7wk4GBJrI+gmqysWl8eM3M3FccnFi8ybLSJqg9gQ9Ce6g=
X-Gm-Gg: ASbGncv6JnkWnV/+72phM3LtXFSdwEk6+AnwjjH9yUi+PYyJ4GQ8hSlrf4rB88hJOAc
	2EdCp/qklxuFeQWQPblOWZwM6rfh/Gnsu4Etafpg2M59k0xynSG2cnyOIS0rxjw91UJx+VyAwT6
	oeKgG22P+gANEoAAqWWEw+9lg9YJt69SzAPDYRud01PXdvVOr8+nolyX2uOMHhV/TsvooVh7mM4
	KvizocvVdkBmw7+62Zv2nwSE9HJlYeaKWXi81sS8Zea76CfVWuKRauiDbps5syY3KPv2lXBZaOO
	LwuYsiT2p7APEn8YgTnxMFIM76Ak4fhm+DOxQ0NgJGit7xXgN9b3uxyxSzAoQYL7XTKyzxYTpVD
	XOQ7oJYiGfUvOf7enPD0=
X-Google-Smtp-Source: AGHT+IHLtegd1iyRVDLN/vP8oO8twGnp2iC58ZPKXolFVDdIfrLW6ekD318QbzbDW8XkVDBKOe/oyA==
X-Received: by 2002:a17:902:ef44:b0:234:a139:120b with SMTP id d9443c01a7336-23e2566ae6fmr224043965ad.11.1752997846197;
        Sun, 20 Jul 2025 00:50:46 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60ec88sm38530095ad.65.2025.07.20.00.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 00:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Jul 2025 01:50:43 -0600
Message-Id: <DBGPVFN5DTGU.5UTP35ALYS2Q@brighamcampbell.com>
Cc: <tejasvipin76@gmail.com>, <skhan@linuxfoundation.org>,
 <linux-kernel-mentees@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Jessica Zhang"
 <jessica.zhang@oss.qualcomm.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Subject: Re: [PATCH v4 2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up
 driver
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Diogo Ivo" <diogo.ivo@tecnico.ulisboa.pt>, "Doug Anderson"
 <dianders@chromium.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250717164053.284969-1-me@brighamcampbell.com>
 <20250717164053.284969-3-me@brighamcampbell.com>
 <CAD=FV=Vrp9MM_5de10sV-TC_mp-D7en9gjU8DBoD6mBrRvF2eg@mail.gmail.com>
 <f0d300fc-0141-4eab-a888-d1d32778f5de@tecnico.ulisboa.pt>
In-Reply-To: <f0d300fc-0141-4eab-a888-d1d32778f5de@tecnico.ulisboa.pt>

On Sat Jul 19, 2025 at 11:10 AM MDT, Diogo Ivo wrote:
>> nit: can just be this:
>>=20
>> struct mipi_dsi_multi_context dsi_ctx =3D {};
>
> I am not an expert here but I was under the impression that this is only
> valid with C23 while the kernel is written in C11. Is there something I
> am missing?
>
> Diogo

You're right, C23 was the first standard to bless the usage of the empty
initializer, ` =3D {};`, but if I'm right, it's been a GNU extension long
before C11. At risk of being pedantic, I'll draw attention to line 580
of the kernel's root Makefile:

KBUILD_CFLAGS +=3D -std=3Dgnu11

The kernel is technically written in the GNU variant of C11, extensions
and all. In fact, the first patch of this series uses optional variadic
macro arguments, which aren't a part of any official C standard as far
as I'm aware.

In any case, a simple grep for some forms of the empty initializer shows
usages all over the drm subsystem.

That said, I don't know if GNU extensions are formally documented or
where one would look for that information. Importantly, I am by far the
junior as far as kernel coding is concerned. I yield to your experience
and I'm happy to change this initialization in v6 if that's best.

Cheers,
Brigham

