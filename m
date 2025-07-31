Return-Path: <linux-kernel+bounces-751586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B04B16B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61E13BBC71
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8D923C8CE;
	Thu, 31 Jul 2025 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W2olDuPX"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40875239E78
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753936036; cv=none; b=i2oEhi1v4LpSos+7Xg9sdz4AxmdfPp7GvI8cyBMquEKxJyaLpg64gf/k9lkaVaYWeUSXuPzf8O07IoYXy12dnaaLmUXaHnaOZhX7I5fPeVnOy+rPUjRkJ+TRc0RFGB07HFml1aRIJ8GkCBRKlaQXCCYcpu/q6juYDECx3A8epVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753936036; c=relaxed/simple;
	bh=dYam2Pq4CEYJ0KCSS9ko2j+lY8v/V5n+4ItJzyxiEM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpw3EyBGtAlhQs1Pf4Op12J8YuMNM6wBJYwgZprmo9uovXkEngV/gCzQFZzAnnYESdrA1+9+dX2R+OS5zDOJa5/glzjOJtoqKiX8TrwpPElN35EvSP7+2QWhOT46ehpWreGLGEgSHIfraZzu8lSxbekRyO59FyVQrM2bx5Y9O/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W2olDuPX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615378b42ecso796796a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753936031; x=1754540831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vOzkQIMtT77JtLFwCoXJrtz9lY5XHa4KjUQ3NnuMov0=;
        b=W2olDuPXLMV7X9edz02xRQD0rT4+hqHMokjDbFz04IKlEwL7nqgDMNnPzjr8CWrAJe
         Q/ZZayFnEawdtuDh2fyfx47eB8Hb165Gu5F2Eu6/RpI5eZ9ue6bPNBIWOuWErirurNw7
         7jBpJeW6258UDjLbQx+EYhvFGGQIpsTdsJVpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753936031; x=1754540831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOzkQIMtT77JtLFwCoXJrtz9lY5XHa4KjUQ3NnuMov0=;
        b=r8ePZcO3YEC6JW2br3+Z6ZDRzwMGq7766YzrZCdoaMXLqHcmZZ/TAWlmfKuKjQlAYo
         bRhR6lojCinDBHjY4ZqNe8GlKejDeu6dqC3JH7sC95PjPt6/WLKDwWzpncOise2IVOn0
         icG1v/pHGItzmRrBaHvSf5Gphklsog9PS4uYpFSnBtf2MrrS6T/uJsMGo9IMruZEXV7D
         iKbAT3dqk3hOAULbkcEwFq33nOpRkqT0jTDhBjXAhj5OLOqhbA9+Hn9fcwf2LE525fsy
         X5F6RXyp8zfz50feOkdBmJK1RGpn7AbFX+mSsYlGvoCOGLJcyk/a/3LvJgusSNGoomGt
         60Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUQvAkBQbOAH6O/ru43BR1NHhBB4TC3QaXkIR9I2+DKCqpiOK4+hfM/8zi9K53M91nN2PpK1yduTRXChv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2whyD+pL4QNmMLsURbkRAjPLqya8RCqhxfnwvY2Z2/6rIkper
	9WK7omCii4JUnZ36yJaECQWtWZZZvWm1QKDSWORSctmcDWO+LEjV/m74IiadwqY9NqMkO9JgeHO
	LbcbO53Q=
X-Gm-Gg: ASbGncuVf1Hu0DRcKgfRaQOKH0TpwswqSly3jJ7OCUrCTLfnPNyazk1mFYgzGD7cKWS
	sX/4WmUbTmt1Ye9NkYUgApvkP4dH3ju/1m8AHQS/ZHpo65rZZAkDL5Df8gjQq6HB+YCDKimJ1y2
	CBD5xzXOXJNU4eeVBvCOEEYu6XgDXsuZZN5bmQpJ0AEi9/xFVHvoIezq/EovdcTeBPQrXcOdRC1
	rJat97UPcE0RF3M93Qb/1j+uZYK3qYQv+1rkVAbXpsVq+f86ir45fpkPgjzzD7RqnadXjL+M0EZ
	STUsNtl6R2/jRCHV8uPmZDb8FCCfvMwg63VtuXSKZJfxmFo9O4+DVx8HPYHU+2x+PnMHAc2O49M
	kYk+0kZXla5mfHwGREA/AxhgjS0ptOzGzZZS8EaqCa7vndUAM0c4zxmtNus8X4arlAyd3GTTR
X-Google-Smtp-Source: AGHT+IEdOc9CvCwGDhtX0x3OmAg68To7d+aYajJhxL+yLfgrlJzTw7QA8Xwj8twTH5GdHBct1HYBPQ==
X-Received: by 2002:a05:6402:504:b0:611:d10e:ebd7 with SMTP id 4fb4d7f45d1cf-615871e5431mr5434061a12.19.1753936031464;
        Wed, 30 Jul 2025 21:27:11 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8effda1sm497753a12.1.2025.07.30.21.27.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:27:10 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso758996a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:27:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMN+VJo6TB4IsXI3vQxTt3dR21XIk1SllESNb865I4ytxnbEMX0oKCJBxuCgME7q4vWySodFUh37o9+Zk=@vger.kernel.org
X-Received: by 2002:a05:6402:358c:b0:615:adc4:1e66 with SMTP id
 4fb4d7f45d1cf-615adc425aamr803216a12.25.1753936030334; Wed, 30 Jul 2025
 21:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com> <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
In-Reply-To: <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 21:26:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
X-Gm-Features: Ac12FXwre6RCORiPzhRedNV641CgtlP9IBscQhPSy4mzxEy7OfaBlZWlHvOOAQo
Message-ID: <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 21:21, Dave Airlie <airlied@gmail.com> wrote:
>
> Okay I don't have an rx580, but I have an rx480 which is pretty close,
> but it is booting fine with your tree at least, DP and HDMI connected,
> so it's not widespread AMD breakage, anything in journalctl/dmesg?

The machine doesn't come up far enough to mount a filesystem - my
disks are all encrypted, I never even get to the "type your password"
thing.

So no logs.

The good news is that it's bisecting without any ambiguity. So nowhere
near as painful as last merge window.

Knock wood.

             Linus

