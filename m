Return-Path: <linux-kernel+bounces-881193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9008C27B06
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CDD1A253FC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA352C2374;
	Sat,  1 Nov 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2KBum1A"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7D22173D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990482; cv=none; b=u55dpAnVM5BCjUyMZgmsXTAB/icTD9F+NY0Bohqb5HzhESiXLBVx/nn4BXRcREjYBXTikA/pOi501Ijz7NCPhlRKftLQrOTSdP6QXZI+vcFOdjm/GLXCXLJ6bgOT4zcJeOpC3TcEvkyjQ+isdsO0yZUjKt9aTHBTvBEaY8xnpBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990482; c=relaxed/simple;
	bh=WsMaVYjhEX5xzYsbLkIYbNUU/KAzYM8jBkJPwJqvx+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgEOSc4+8l7i231exW2Okx16igbYO+Xbz6dqGFxhMVB9AkiV8Kfn8r8GaGOqmSR8XydFf9Aa4vhiVTZAnJ/ORQYT2TFpogKhAB2BbGe+y13mnTZ7Uz2xENLmSjRduJudTuwtzvQ5OJ+pCA1eKdGdfD/aQI8g+kKi4uKOuO1eans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2KBum1A; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b593def09e3so2240001a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990480; x=1762595280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys+iXshBYZnizwFhgQPeQbnnGsPPwsLlRfA8FiXKhyI=;
        b=i2KBum1A1oetCqXn/NH0NnP0kM1of8OivYXErx5FS7wf5Ny6rLV6nSuuL2EeZ39B8W
         f4Y9NFPAAcVYr6FMaeebliczS9IxyZHoU+XPuceX/CG8SeVQNII4jeHZ3ydiLw1dl2UO
         yfxMIEkpjrzfmZ5ddQHbkR+VPGJGnsF46AesdYLNDBRustXeFjRqPJGyhDHuOw/DcVcJ
         hzwYzmzqD8LIdbbiLAV1PQtYA5PaW7WvfQgBlyjUpLOQb4smhQEcS1nMx5tGS/ql5LtM
         EcLwk0qLrAamMbgUOxo7lvOPf/VZfMbaWo8+VaarpW0ayar61mFa6EiLXH/OzQgdIe9M
         qtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990480; x=1762595280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys+iXshBYZnizwFhgQPeQbnnGsPPwsLlRfA8FiXKhyI=;
        b=FPvhyiOiGCogJK7A8dCEjUQX9dHSQ66nrSkq2E/MGIzDH3+AyYVnQSiezQjHdhIpoj
         6wPI0edTUQJlWosI4GfUOuLoV56erZrBAB09cLfRpf4wWLbFyurnvyWF0BgdgXKDcirW
         mKsXeBOe0LLr2BVzNkGvCwK61DDc1BZBftR9QffDLGgKX5DMGDJ5J1kc9QqsNZdZ0Yhr
         Ic08CLzqMpHPDF7K+rIY4rSxnu88tXb4sijdcSe9rKyXNrnDKAxfC37UtqJQKdWqO4m2
         OZbqoR0BlcOZGxoi3L2dFaU4z1cXKdzA632AlqKwpjbP/TFPzbDb+OTrdm7eVxHwXe0S
         efmQ==
X-Gm-Message-State: AOJu0YyYNA+NQswKYyVWXRgf6NDLYZ6f+oVD7zV+b47t6+YpURQX0VNd
	VB9+Bo6BVNumjpBpNzc+KyNiZlPM9q3JA4Xp6muyegUpTHSRnUdFc4T2
X-Gm-Gg: ASbGncvrHhlFvh60AKh3AyDux032ks8LuMYUSSYcw/pN2XXkYll71XIfvPFK0HuzIz1
	psr2WCeSa+GYBXonFQp9l9YX0yx8MmMo1YkSUtXcGLavIs/1lnIlUpt3HjSfsWh6j9YgzQM3X/q
	okFBb6QjDC7HSP6+Rwb0wZ9br/iCd6WPZYKyU4NTdq5kZ7jplyaukV4bY5CxlgmbzcLvoj2+zPH
	LiXghePss7NhiFXWZB4UWxdiRVSXmN+41Hol23T6/6p/Y/e1VWNh7HIc4MrpDE3gZtcGK65e7Iw
	dcFXDXZRjZEnywcipcNtzxeayb1CrWo5G9XIniDX/WKOTjlYSjTtiN7e2SyHipgZ+jCAcy9nrTf
	OKSj64sTz9ZLsbCe8EgH5HEqD39J2/SS+ZKA0Ex5Iy9wnWUYggysPoR6hCT8P295c8O716IUDTr
	qh
X-Google-Smtp-Source: AGHT+IEuf2OXCpVvj5mt9JoXkTV63btzK3GM762PmBpPq77R+yTBCtQ7CzPQQFc+4UmjQ7/sOnLiHQ==
X-Received: by 2002:a17:902:e5d2:b0:246:e1b6:f9b0 with SMTP id d9443c01a7336-2951a38af0amr90955605ad.18.1761990480237;
        Sat, 01 Nov 2025 02:48:00 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268d10e9sm50868325ad.50.2025.11.01.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:47:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 64F3D4209E90; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v2 1/8] Documentation: xfrm_device: Wrap iproute2 snippets in literal code block
Date: Sat,  1 Nov 2025 16:47:37 +0700
Message-ID: <20251101094744.46932-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=bagasdotme@gmail.com; h=from:subject; bh=WsMaVYjhEX5xzYsbLkIYbNUU/KAzYM8jBkJPwJqvx+Y=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms13Kblm6rb3ryI+T9Q+WPFs0pi1svRc3x2Oq64MTPF 0zlH6+d6ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEpPMY/kr62J815jXz/FLd 2HP0xr50vrL37DMXPGjLnBejwvieo5KR4e/D+bXTT/7i4HW9dY7Tc9VR2b5lk1fuPj6N0SA9zPy 2OScA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

iproute2 snippets (ip x) are shown in long-running definition lists
instead. Format them as literal code blocks that do the semantic job
better.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 122204da0fff69..7a13075b5bf06a 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -34,7 +34,7 @@ Right now, there are two types of hardware offload that kernel supports.
 Userland access to the offload is typically through a system such as
 libreswan or KAME/raccoon, but the iproute2 'ip xfrm' command set can
 be handy when experimenting.  An example command might look something
-like this for crypto offload:
+like this for crypto offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
@@ -42,7 +42,7 @@ like this for crypto offload:
      sel src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp \
      offload dev eth4 dir in
 
-and for packet offload
+and for packet offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
-- 
An old man doll... just what I always wanted! - Clara


