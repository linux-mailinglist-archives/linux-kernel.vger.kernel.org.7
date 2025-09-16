Return-Path: <linux-kernel+bounces-819344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36213B59F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F00C7AD2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03793248861;
	Tue, 16 Sep 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avYs+ih1"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A18BEE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043013; cv=none; b=PPNy5LHWn9EW40dyvYgkivU/JnEvDVele4fzOEqlMpKOndtJ6jtgWXNEIOLWf72Hmjt7gKKhr3uHzVyxhRIcDoiF3pv0Ype2DP2v9rku/UG/qN65LQEBwWAZZoF2ufndxjynIM71NqIkNiT6GkSkHLxcH1VeXrP6bqu4Cw5YR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043013; c=relaxed/simple;
	bh=UrB+H0yILRakp4kBxbK9yn5m03BlYcSRjFf4srWf0mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTRwmB8ecqXUabeCbe/zaEDtfL/oBivPnJJ3AnYoUGkIn8bWVmJvP/1iG4J15RVXL4S/mEXe4Cc7+/ISQNKU5SNryUeltA8wY9hFeDVu0YJ5HyrRKru2l3sJedLU1sG34ryFFfS/OPv6gwWcv3gSn+iVhGa43ZcsudofFG+k/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avYs+ih1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e9a9298764so2201484f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758043010; x=1758647810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXunugfsP8zuDyXjSm9YGg4hKUE4YJh9L2VZnuLOhL0=;
        b=avYs+ih1kw1O+o0Pp/LNRbyQ1xf9INErFqfnbTjqTl/U9vMp7X9FjgCd7EW4WJoJiE
         yyP7gENxZOcKOY8nxkgV9PqgJndmtVKVUCxkp0SYYC/j9T7I/odlumPcpYyVFH61pQSw
         g+cy2c6duksGkXeJvoAbetfTAFI6iZrcfFLXrbgK6Hzsiv2cQMb0/42fgMKQXOHubc38
         Ejpe38hlLF55Z6YY6AEJ5sELzSCJiZ1mFasJUfS8osHmUsWFst/mT+8QYtxLnF+WVy6K
         HY2GBcXeC1AWOa5Ayxmz3Oow/GGc36nl8AJCIjbk1sUs4VGZxSd5Uv9ggU1eHsRuaTgb
         yVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758043010; x=1758647810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXunugfsP8zuDyXjSm9YGg4hKUE4YJh9L2VZnuLOhL0=;
        b=cqveJlkCXcYSginFt2aen0ZAKhrN4jdeeAYvdQ30jxtfQ5S3Pk3GDTpOdTzLNyLTJ8
         Po1NNRvH0yzo3qbd0YgvLRDLJi9oSSmaZcaTkC6Vl1A98o5zwi+0IKIPeIRaTzgt9GrB
         PCwMmPtfztAhSfh9Q4eJBEsWpyTnbGCiMfMb0EwEclWgN6FXLrmvQ779SuevdoDuCNFf
         M5XcK6oWNlvPAV+m+z2ibf78Ql9aTQdZsa35tVeHbNHCT3Lqcepnj6Cn0PsXbDh8mkbq
         rRFPRnAzxgDu0omT1nsJr4W6VJE/jDTik/gViuquVNC+N2fnDTWIbPGDkapBXaynYoOi
         TK8A==
X-Forwarded-Encrypted: i=1; AJvYcCUuhMUg1t0DyWFaUsijr0n1Pv9DZygbOgZtxVjRAm3HeO6mZgJCoXwlqQ+F6/+M1N4vHJ014EaRbniWroY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhfxszHhedGr0vpuAKTAVEiqpH16EaSNq7JXG9nYwpwoYio0+Z
	vihBuaCWl+9bfC/zQTG3cebq9FolgteOZS9nu52mLsjWTlLNgENwDGPqH6tag6LAiPUlTSrQcGn
	VfoviF1wjo1fJyn3aKcKqSaFGv8bkbU3xmQ==
X-Gm-Gg: ASbGnct4GLlK0NOYks0PG4yyCMBR+xGyhI4aACKV376lndQm2hqH53goXTKmtBI17NB
	lTVnFdg9+qqvXnYsJVaandA1odaJyUCCcHUClmFyv5pxHTsM04CTpCGjEEPeWXCRkCnUOPAHpwG
	dMikP+RX3gHP2TQJSPmEdTB9EA4XTgvlXKdiCZ4OXI/hHFnityo4eL375MW/uEoAr0RFpzrbZkl
	g/i5AsC
X-Google-Smtp-Source: AGHT+IFqtKbkdbMvc8sfBF7NAGkQWbnxp9HrEDPJ04COedo+lOLyWWYScVsHNbKPb0qvFTIJ+DkHeUqPkHZxzlthVWI=
X-Received: by 2002:a05:6000:1789:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-3ecdb8bcc30mr2101171f8f.24.1758043009793; Tue, 16 Sep 2025
 10:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912065146.28059-1-clamor95@gmail.com> <km7thoeguhkdp23gatn3w4kibgazzxi7s3cbkhueuokychqcbq@nabzlmfg3dmi>
In-Reply-To: <km7thoeguhkdp23gatn3w4kibgazzxi7s3cbkhueuokychqcbq@nabzlmfg3dmi>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 16 Sep 2025 20:16:38 +0300
X-Gm-Features: AS18NWD97oKjyygDrh6IMRSKq_qvj7eHt051Sltk5_HLhw06CzvSFGSnKXDHzEg
Message-ID: <CAPVz0n16NWiLgz9XT-_NF8gvwBMj+6+L_0Ua2gCDE0WK482QBw@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] dt-bindings: power: supply: bq24190: document
 charge enable pin
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 16 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 19:59 Seba=
stian Reichel
<sebastian.reichel@collabora.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> On Fri, Sep 12, 2025 at 09:51:45AM +0300, Svyatoslav Ryhel wrote:
> > Document active low Charge Enable pin. Battery charging is enabled when
> > REG01[5:4] =3D 01 and CE pin =3D Low. CE pin must be pulled high or low=
.
> >
> > Svyatoslav Ryhel (1):
> >   dt-bindings: power: supply: bq24190: document charge enable pin
> >
> >  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> No driver change?
>

That is correct, both my patches for bq24190 charger and bq27xxx fuel
gauge adjust only schema to reflect the hardware configuration of
chips, drivers for these devices do not need any adjustments at least
for now.

> Greetings,
>
> -- Sebastian

