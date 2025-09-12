Return-Path: <linux-kernel+bounces-813485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6338B5461C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DC75840F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773D271443;
	Fri, 12 Sep 2025 08:56:54 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98426F293
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667413; cv=none; b=b6S8ZTvQKnghqK6LLcBJQC7rK4d6Vcle4p9EEbTC7o+rQhMQwhK02liDy8JwQGlkCY31FNkQ33tNXrxKnTXKVKde+0xu7pGzFnBpODsQLGc9kepHnGedLuwFAgp5IMGR9XO5dVpa0kDMQ10IIqzEdXTZcFSgLjH2detzlSg4byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667413; c=relaxed/simple;
	bh=y4x97uGJUM5QsqfWMCvRjzay1EV09kP3vQXEnBF3d2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud6Bja3tj1pbbjKzFH8HNp3O+eqaSitaJSSoDEW9lf6GykT7HMKfl4tT9JgIalBelNF4IOFsyELKdE/19NPVPT7sJFHGOLs/cAilV/ynGhoLqUbqrBQSgdrMDdOlxEKADF97lOheTbH5J8+uuMzNxCFTWDzUVeRgVAwAcDBu2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5608b619cd8so2025198e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667409; x=1758272209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74tRC2VlzLxPkuO20P1RbEt4g142PM6DdcNwZMtwWfs=;
        b=k9C76lBMjzgEgNsQPWt8yjjJDScIo2oikOIWPzEjqmxR+w53nfF3uUIHuC9MkHNt6u
         Me+tuh9jeF0Kkj/qSGZXNFQH/MgBG09PT2H0QQ/VKOMSJpeO/PDQFi5oCNh7+ATUO+JF
         TZIafF4gSIv/9D7SjLCTUdGqi7ogo8e8QQAWTfBO4aqT+yVRTVSqiFKeSV7DMZxvJkTk
         8eXdk1NFSXqXijvk8Yyqj4nD4kehO+QKocXuEZ/ueIfsYR0GiJaUzODeHHmEgMHWwXyb
         dcVPJQXDGXbItfi/AXvVEYr0na3oeSpJJxiZtCuNCyCXXjz5qGnpE1ooZUuWylZhOXcb
         TrIA==
X-Forwarded-Encrypted: i=1; AJvYcCVLk1y+R2wamhLhMEc8IqVdrnjI+xb2tburzplAZ7KMq12J4VZgerQDFxqjHvY7O9YWMpYXVyHrB3jY0vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybYsVzlLC+sH3UoxFHw7qAio8/ptB6vY5ENKiOUaDdk3FhPKWE
	VL7EzuPfQjregTy9ZFupxDyD3aWRkCh7RMl80tATqbE00GXDbvIHADLCM3ImforM
X-Gm-Gg: ASbGnctHijKe/mdF9u3x+rVr/YTmQK3SKXVYaCNFC6VlyZAcrdcRHZIsreU0y84yP1/
	omDOVrSw8AQYPj+TBd+EjCa18gEuX8CoHx5WYBK8pcHoLEk43mtd/vmA1NjKpkrZskURPXgGMXd
	sVL/nPFSfdD+Sq/PqI5+zVHH5L5Mh2etyJ2MgQh4hP3K48GEX++haYXJcS7xZL0tjGcSGcxjxkc
	O1fahuvveNSGmwrG0z6HDG0nu8YxIrtb/d2UQQuVnsgkMPFesRTGZWKpvvRtG0gWNdHhxKrbojZ
	f+lZFPq3hfK2i/kXCC6RKPk4XYYH4xhDTIxe9idLU5EnHPzEJIqeikPrWOjtPpArbTzze2O4X2w
	d7u57OSgqDmsvhCf6hIrTByogU0/uDsp7SZG7E2fp19Y9LX+oNbK/jbMeSurg8AnI7A==
X-Google-Smtp-Source: AGHT+IFho4NtdaT4XqvVj7/wFTkH6i9DNAV/+9Sd9ouqLzG5Ds/qd4LbMgoCCEQwg8wPZdQ3pN9CCQ==
X-Received: by 2002:ac2:4cb1:0:b0:55f:6d28:bcee with SMTP id 2adb3069b0e04-5704f1cf24amr589854e87.34.1757667408651;
        Fri, 12 Sep 2025 01:56:48 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460d3f7sm1007639e87.98.2025.09.12.01.56.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:56:48 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-33730e1cda7so15578691fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:56:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWd3rxg0szGwrkQhQhVu2/lP8HuafWltAfQcuEzl0aKtboobCXoRdLZxWBfZqmfFa/FqUKcuuAGUwDk6rs=@vger.kernel.org
X-Received: by 2002:a05:651c:1118:10b0:338:d42:2a73 with SMTP id
 38308e7fff4ca-351409b51d3mr4673771fa.45.1757667408335; Fri, 12 Sep 2025
 01:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net> <20250912-x96q-v1-2-8471daaf39db@posteo.net>
 <aMPftsaf4x61-bGY@probook>
In-Reply-To: <aMPftsaf4x61-bGY@probook>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 12 Sep 2025 16:56:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v66khAeP5pCq6RCrPUwQr=tDqJ6O6cs0gokbMNjpTejuvw@mail.gmail.com>
X-Gm-Features: Ac12FXw60L74DnVtPN3yLU-Dvc0n827phLti7Hql_EebywNU_R9Et1E7UON_xe0
Message-ID: <CAGb2v66khAeP5pCq6RCrPUwQr=tDqJ6O6cs0gokbMNjpTejuvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h313: Add Amediatech X96Q
To: =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 4:54=E2=80=AFPM J. Neusch=C3=A4fer <j.ne@posteo.net=
> wrote:
>
> On Fri, Sep 12, 2025 at 01:52:10AM +0200, J. Neusch=C3=A4fer via B4 Relay=
 wrote:
> > From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
> >
> > The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM=
,
> > 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> > output, and infrared input.
> >
> >   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> [...]
> > +&gpu {
> > +     mali-supply =3D <&reg_dcdcc>;
> > +     status =3D "okay";
> > +};
>
> Note for v2: The GPU gets stuck in probe deferral, and I forgot to
> investigate why.

You are probably missing the GPU power domain driver?

ChenYu

