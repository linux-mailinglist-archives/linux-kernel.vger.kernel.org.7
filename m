Return-Path: <linux-kernel+bounces-875874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F84C19FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C74B1C67353
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3231062C;
	Wed, 29 Oct 2025 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMLLqUHO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212330FC25
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737091; cv=none; b=SV/taAT/64zyMiTUOuROM/nyXUwuod3GHMbaDx4SkPFcGGM90zY/j9wz1cX9i5jB42q9MTn61J/rE/nq5K/puRhl9qnMlIDLSJVhe2rH9RMZ2gfCeowSoSk2VeCI0OZXUP2ixYPOqorH9EDfp92QLdhEKGnsLxqNBznflBYhK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737091; c=relaxed/simple;
	bh=SSN7+2SHUlqyDZJ7M9gECbgIzqZWKI8o2SRJwxBxLK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ULaS38/wDrJFG+hodT0I+YcdlsbnlJhs08VUns1VPVgHb2RAGbVkNEGWHkqoX+QNQVWnrfIE7+E0Cq3nerZPaOvz++eZ4ZpwRVmvlqHveXETyfHC65O0WeInGckT+VYpLo79yI5CtogTsV+zBTkPJv7sdouTPj3+HTWjOEl90S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMLLqUHO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47118259fd8so55444105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761737088; x=1762341888; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SSN7+2SHUlqyDZJ7M9gECbgIzqZWKI8o2SRJwxBxLK0=;
        b=SMLLqUHOvRiXo5bzPpbV90MNXbK/6aZbH/ta4d0TPKSfwmHmyv9AW0FO+PiQqFzDkI
         D9ahNnTjW9Gs+quiAyT5UMxyRNJXHrXOHOuyPqaXEpwAZSgYe+Hy8QaYPg4FrzjTbrPn
         USgHEQIYkKkRZM0tR/wFzFCHbzQWYI5hhcnr935wl1urUHxYozlS8k5+uI7D5dHHarpm
         Zcby/6r9AYLl9hpHOF0iMH6cdmPWo8ZYanRKPEQuRuSFSd3aBcCt/EuCsENAupKv3LwD
         qcNm/oGtx0Ft3E0n+yyJ2DhhaWXWWrbpmiAN76thzPnCD+jsTYlGivMamgKNCnA4T+6t
         H/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737088; x=1762341888;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSN7+2SHUlqyDZJ7M9gECbgIzqZWKI8o2SRJwxBxLK0=;
        b=au2+HTdrDqR7rra52Z5Dl8ZZIZ/vOTy3WqhSUCl83sLyen6FaBSZljNw2oVyU0oBAQ
         lTHrJeGPJ1FAMaEqGMMezlUdxkCjZypFWjw6PHKrqUb1T029H/VUEqsYhTmUWDWT+Jw3
         XEQ+TkqnfuftGPqFuNEIWXNBNZRzaEjCvaMGLE87zVZDcJAGNTjGq67yTEjW/tVpSkYe
         onM3CLHMPTex1iChIWYrHIqho9rF1KKmVe8LWdNiSBsUmbcXwOz2xW9N0Bibz3WPRNgJ
         LqQDvBSpKxQVuj8MmiyklgXHkOLB22UyYSwbd0YGOAe2ZKAGAQ8svtFXXaL4pjTI3W/t
         rucA==
X-Forwarded-Encrypted: i=1; AJvYcCUCQfGlDUFAVFWpmWBucFdPONRufZb8pyAQRt/IqTAiHP6iXTekv4c3D/yauJks6be1WIHzN11GjbJULww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMp+Tha5pnsv1dAa0O2/jyX9/FPD2t9T9ZLFlMS0TQWedBBlEi
	6a8Vuc0+T6yitTbylL+rlx16MxkU04RVVsnAvzIbxKOtvmSjhpfdd+dS
X-Gm-Gg: ASbGncufMXs7MK+wM9XMHHl1nvIGAKGeDgpea4/4h48b5GW9Tc8bbm7jCad4PkedE3Y
	qJ4KZNPzfzNXeJ0hyPRsMxWJqotCY5MGDk51Pfe/XReQoNjpmTHDtDMTUC00ixUg2F+soal+ywx
	znD7PfgtfSXJYx7+F8NwTdmLZ9w1/WEA4cBHanAy1ZBpKcgSmNeyHGedbtienow8Pty/QMZqxKj
	/a0sBG0V7WX3ETeldNKep01IWaDetIMl+mIHS/1vQgXVZyOIBByL/3DfFDueOvQ+nCO3meoEUVY
	+j5twAUS/AVMWM/8p8KZzklaNBrfIz7uHmo5ptwALUa1kIEvxVxqawZr6vIvL676bLXC+5AHzMD
	f3rqGpfh1FkItTkQs76+HvlE25kmV9y9asRmsBhJ+QEhgiaVT/+SojBWDgbHoXgoAJ0NIMruKU1
	298NgULLBgzB72rlfKHevJG5uQU4+gbPiHQtEHdIvfA8HJoNyI99Hf7X76
X-Google-Smtp-Source: AGHT+IEkpyQtLQ97U7LSxA+GQnz86sOiezs7Bj4Kw0ZYAFnyDPGMmE4GKO5EGWyqrEBvSGThbDG3RA==
X-Received: by 2002:a5d:584d:0:b0:425:856f:70ff with SMTP id ffacd0b85a97d-429aefcda6amr2551180f8f.45.1761737088137;
        Wed, 29 Oct 2025 04:24:48 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b22sm25422572f8f.9.2025.10.29.04.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:24:47 -0700 (PDT)
Message-ID: <3e2ebf04f53cbf801e13fd808d8438c6d2cee412.camel@gmail.com>
Subject: Re: [PATCH v2 4/4] ASoC: cs4271: Add support for the external mclk
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni	
 <thomas.petazzoni@bootlin.com>, David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Jaroslav Kysela	 <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Nikita Shubin	 <nikita.shubin@maquefel.me>, Axel Lin
 <axel.lin@ingics.com>, Brian Austin	 <brian.austin@cirrus.com>
Date: Wed, 29 Oct 2025 12:24:47 +0100
In-Reply-To: <20251029093921.624088-5-herve.codina@bootlin.com>
References: <20251029093921.624088-1-herve.codina@bootlin.com>
	 <20251029093921.624088-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

On Wed, 2025-10-29 at 10:39 +0100, Herve Codina wrote:
> The mclk (master clock) of the cs4271 codec can be an input clock.
>=20
> In this case the connected clock needs to be enabled outside of any
> audio stream. Indeed, this clock is needed for i2c communication.
>=20
> Add support of this clock and enable it before the first i2c transfer.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0sound/soc/codecs/cs4271.c | 29 ++++++++++++++++++++++++++---
> =C2=A01 file changed, 26 insertions(+), 3 deletions(-)

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

--=20
Alexander Sverdlin.

