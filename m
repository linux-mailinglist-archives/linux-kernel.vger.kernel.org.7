Return-Path: <linux-kernel+bounces-859572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51202BEDFC8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668B03E7136
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCA5221554;
	Sun, 19 Oct 2025 07:44:25 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248415278E
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760859865; cv=none; b=cEiL2tF5X8rI1yWaqjTfkG9q0DeqTFetl9OHklshLyF8+Po7cNCCs4BzOEZ2JY+KL4FGzhx/Jbtm9UC7XfLz3+17untv0VonIfk8mr47Q35Y81biT1RTTlPLouzkIrYWWndXVv6gNedB62RZ8chrelvTC41SylCyGqeTo9q78PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760859865; c=relaxed/simple;
	bh=VDyEXvhcMjHGVLUO7kySkl3Qfnll/RHQf72z6TXt0us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swcENlzOGDZMBacHj/4DrxW6Sr22xc3HDRxh64N+pTs53iiSRAamk0qoj60MGvktM+tNX7SwWNHe1e6O2Yo1yEtkuR0Z10/PUqtjKjsUxuP2iM+WZK5c02QTgaT5gy2Jmjt/wA/rbaX8NbH2ZxcJ/3MCOP4OAkLP66juOVBhA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57f1b88354eso3750313e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760859858; x=1761464658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDyEXvhcMjHGVLUO7kySkl3Qfnll/RHQf72z6TXt0us=;
        b=XYjl94pIFzXdCH8q85PZzM33FXS6F8RHNvPrDBnsgBgY1z0D8vE+bbM32zyz87NFny
         dTAov47U3pfpZTTDtr9+ZySpIcGiTcnXJosvOZbpR3BQvU0ve6v+TgTNjL3UteE8BxZX
         rJM6yPgNcrjXaZOh8aN/iLd1jWuf4jKUtgZ6T8n5ltPR4ApQ17/3Q4ITWPTCk8fH9RqX
         UiiVD7NfXm8R5rmw/x8xDwMcp1n+LzDnEwmfFFdeOIjqabdCdy6aQ9POq4KoaamwPcFq
         R0F3kI6wtQRUcTFyu6ZR9Lu7w8W0M7T/uFZYTY8epriOwRFPR+PERZPXR6q0DvEHUx9U
         u9VA==
X-Forwarded-Encrypted: i=1; AJvYcCUFjjdPUoCZ2gShc+kWaWEhvLft0JnY2Zb9GaguD6R5Z/f0coiGuxlChGsR8UpQJ7rkVYd8zV1heYjcSBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFs4F4+AU2eFMmE7/O/uiNKsJNyoVTRkegoT9DWvkfwF/1z3o
	r+pdNHMHdsX44bYhMF9jgbCHUZwHA8dUzWYQEQfpUT6CViLs01+g4BUcXmTY7dtj
X-Gm-Gg: ASbGnctMvsPJhsLCSemb/cE0G2s+78CFbiYJiSWXzNB3TDTA5+8RnjlqI7XSpqV2MPC
	XFNQibagc/zndp+5cBxdejH/xreHgL+9cTEp1JcyqScL84CmDEakhwrDSMzD1Pcn/IPSXRZ8PLp
	9qV4VQDTEZpMVzSyVTaZd8pYJVVdgc3V6P+y5L11IVdAN/g19lSF9rQRpyuj2QVmV6V07VElt9s
	JtH3wxCJnGS0NnP71pdFfejtqIBrEcj1nSjB3TI86msko+hEOuXy5VJ1SZbNEw9yUogvAsixsBC
	v74GRLepL3+Z/1ruOGnTejBaEWRP4yBjEwLI3T5qhOFQ7YZIZxMX6+/aJdtjxsDm5UgrZFWoy/9
	NjNtthSTV5lk+0/4sdJq4e3hVk8lji8ajv5WnQ4MLj60P60t1imKMu9nENf2a8cx5HXP62JPAVg
	D2j7qrB8c00Wqx2DGR1+eHFEWHxcDu6gWq
X-Google-Smtp-Source: AGHT+IEpVg69VouDkKxIfNj7Prs7ahHd0ToCNn9ewAgZt4C3XdO9S7PEGzIkbuX0Oe1jmyVac5DzOw==
X-Received: by 2002:ac2:4e0b:0:b0:57b:a770:6d7e with SMTP id 2adb3069b0e04-591d84e3982mr3097169e87.10.1760859857466;
        Sun, 19 Oct 2025 00:44:17 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeafef3sm1339727e87.33.2025.10.19.00.44.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 00:44:17 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36d77de259bso24962841fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:44:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmg7sbgC/EZowr6nNP/+IGdSjbfjswT/RWV62sNpkYXL4vbqxBL45usoUQ8C08NqXJAcESN92pvnTPnII=@vger.kernel.org
X-Received: by 2002:a2e:9a0d:0:b0:362:b98f:edec with SMTP id
 38308e7fff4ca-37797a28204mr31528471fa.23.1760859856735; Sun, 19 Oct 2025
 00:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-4-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-4-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 19 Oct 2025 15:44:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v64QDvw_rQN3v+zPLp8YBcfQBZvOBenKQQ__g7P=kLkucw@mail.gmail.com>
X-Gm-Features: AS18NWA8cc21pStw1TYls77Vg9dX4gj_1oPuVNMT5dpbk_Fef3dnnMNukJyo070
Message-ID: <CAGb2v64QDvw_rQN3v+zPLp8YBcfQBZvOBenKQQ__g7P=kLkucw@mail.gmail.com>
Subject: Re: [PATCH 03/30] drm/sun4i: de2: Initialize layer fields earlier
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> drm_universal_plane_init() can already call some callbacks, like
> format_mod_supported, during initialization. Because of that, fields
> should be initialized beforehand.

I think fields should always be initialized before any structure is
passed off to another function.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

