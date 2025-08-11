Return-Path: <linux-kernel+bounces-763164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB47B2112E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809223B20AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C28B2C21F5;
	Mon, 11 Aug 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="ZeXNWfO+"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3942C21F0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927792; cv=none; b=XgtvnXagpqWAKBdzv30dlU5kOL3Hj1rnnQHRMv4y8RS2ZjvXcGHMysxhvVP5o+i9N24QXDH/1MRRSOyEYvvPA8S28ccdwjT3M497Z5d7eEPe7Eca8hto1drIpcrxrSiC0a7+/wr9mYnkDzDGL3P5DEcNE6Su1x4jtnPiZnAiCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927792; c=relaxed/simple;
	bh=a41FKwvsBmWc/J+JJXLWQ4dhCt6n29839D0Y6dEV2rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP9ApYL4FMukJhmo/eP4uGKnbVL+yu+F3/8/M6a+kyWK5eO+uPSYmfp2ySxGkvpjI06WZ1XgMGPc4UXqv5G03tkpluAhNcyKNFLPWGQWQUYzxar+4EJEvmN/DCQbeBG4Bqr3Yf6tsS5lCCE7MU1F7AFccRzAbUP7S/A6/7qbN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=ZeXNWfO+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e8320abfe0so290797385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1754927789; x=1755532589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a41FKwvsBmWc/J+JJXLWQ4dhCt6n29839D0Y6dEV2rs=;
        b=ZeXNWfO+tdV5iy8hPow4FsKsrXcUpW3zANP+sSmwIHwP13+yJ+ZSGzMXwg8sW20BDq
         ibPw7SWZ/gPu1tHeDdHT8GJZ2Hp68xO6bJILMv5eugyGeqig8D0TSy0w1gFHVo/u6tgb
         DS/Ci40xutADpElbedXMg9RBZIgbDf1ZIVlKB/dVx8zmZFUQUdBuWBYFjkMaZon2C3Ea
         ILD8pVm7Mk4rgtTDRzncDLLMsm0xkLxz45sEH+GxwmfPy6b/3a+pxQhQ4nKfEyEEjG72
         8KEFrho+yVSU5ng2LEGIynfl3ILlfEvFe5Z2QURqsiU1W9nZ4/mVpmIxnJUjM/NmKD4I
         xF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754927789; x=1755532589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a41FKwvsBmWc/J+JJXLWQ4dhCt6n29839D0Y6dEV2rs=;
        b=J6YgPFXLlP0tuvRfVrHhnFyz+9IvW1gymVXdF6wtRBTx/MKfGfViYirETm2AC2eHff
         0mnHmuzcfjiSVF6X7D9BA2mZj7D7zZ4PWYXyGloXkz2PtdvKy7PfVrCzq1Meo5yTC2Ld
         BGMsehdMNtBKgSenixJOGct7rqz1y+MIFjvZX5B8GB80/dKOolC+k8umW48l72LlKlWa
         2TmwaZ69Y5oPSixWArLiyOn3XYBjpm1puM3spG7/ydJL5aPdbK7yIwX7rYx0pyn6UuOz
         /TmMkz6iWkur8SwU/0Turtb7I43VGQGw6QySe50n+fho0FEf5huV1J4coJ61950+1YHO
         yJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBlweyTyoBs5zUJLq7/v2eQ+bHYKW5h+EhiN8WO0d6MWNLKNW2u/fKqg9p/1onXhBEQCctf+uAn73hpVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqOlkrIs4uM8JvrsoPNjbED0v+Od0FB4STwyk+tn+cQYer2WB
	1KUK3N1EXm030Uw9KZXXODK5EFkcv1VXdBKNMrglDvtpYOR9HYNPCEHUu7hbDrXNzZXwJL5arH9
	bYnWFAYJ/6J2kPbkMX31sBK2uUlKGVLGHxmNu7a07KA==
X-Gm-Gg: ASbGncv1jc+mZw6NUt17fHuHz3cZjW4sCVQLKvcbsAh+GODk5d6t5VOJ6BvpqT6vJT4
	ex80c8wGBBBDLk2cpHlyjXxnZM0MWQBGBOMOdq2kO3Mnv7RquvtnYZX+c7oP8CmOem1S7S7MrnA
	XaDQF7cZfZ3sfiC5cY6CYMcogkAqtgy+kv6b2+KINQt/vqXMVIy75g8qdtfRdNiVetgNSzeqYYR
	GV+w5s=
X-Google-Smtp-Source: AGHT+IHJ6DLqi3WNGqEnPO7HeedB9JAg2/I96pTu/EofZ9KhmVtvwE6tX0gRtaO8UtmUdEGcL4at8u0aKTObH9/A5WU=
X-Received: by 2002:a05:620a:ab13:b0:7e6:4fc9:6457 with SMTP id
 af79cd13be357-7e8588e5e29mr39306585a.54.1754927789270; Mon, 11 Aug 2025
 08:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808010235.2831853-1-adrian.larumbe@collabora.com>
 <CAPj87rNnjvsJ1P89dv+OtawBXTLwfcaS41mzOL9Z1SwtjRcVJg@mail.gmail.com> <c76d9e67-4b2b-443d-b173-76476a7a4317@suse.de>
In-Reply-To: <c76d9e67-4b2b-443d-b173-76476a7a4317@suse.de>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 11 Aug 2025 16:56:17 +0100
X-Gm-Features: Ac12FXzdo3umrCbRk0dXIe8CG-C632a8q7Qp4RAlcg4rABC40XzgtLqLjA3ECcs
Message-ID: <CAPj87rPdJS_pZppfc4BnLWLT+BfikzKhpZJkU2uL8V_OHKYk7g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panfrost: Print RSS for tiler heap BO's in debugfs
 GEMS file
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com, 
	Christopher Healy <healych@amazon.com>, Daniel Stone <daniels@collabora.com>, 
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, 11 Aug 2025 at 13:11, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
> Am 08.08.25 um 13:06 schrieb Daniel Stone:
> > On Fri, 8 Aug 2025 at 02:03, Adri=C3=A1n Larumbe
> > <adrian.larumbe@collabora.com> wrote:
> >> Otherwise it would display the virtual allocation size, which is often
> >> much bigger than the RSS.
> > I've pushed this to drm-misc-next-fixes to land in 6.17 with the
> > original commit as well.
>
> I'm going to revert this commit, because of
>
> dim: 216d6d913861 ("drm/panfrost: Print RSS for tiler heap BO's in
> debugfs GEMS file"): committer Signed-off-by missing.
> dim: 216d6d913861 ("drm/panfrost: Print RSS for tiler heap BO's in
> debugfs GEMS file"): Link tag missing.
> dim: WARNING: issues in commits detected, but continuing dry-run
>
> Shall I reapply or do you want to?

Damn, I'm sorry about that; I got too used to b4 shazam, so forgot to
dim b4-shazam instead. I'm happy to reapply.

Cheers,
Daniel

