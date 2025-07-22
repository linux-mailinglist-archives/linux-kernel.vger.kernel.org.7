Return-Path: <linux-kernel+bounces-740181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66873B0D11B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AEE3ABFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15B6289E3B;
	Tue, 22 Jul 2025 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kYi/E4Re"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2D1754B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753161123; cv=none; b=M5ZSphkF9iQrIIZGA5fFQ4zVvWavYkp56Fq0ySrJySnU7XwvIAXd2Z6exxq64QxLUYgg/KDnB8vB0Ftc2Zbtya+xOwdhERlqSj6sXpZzw8RodQhbgpw0brgZxgPkzTiKKg9Fj8FQkgEkhEw7ptxRGMVHEaXzrGT/nbBEGMuw6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753161123; c=relaxed/simple;
	bh=cp7QbS0xMvkOoKs4HA6eWBnh1DAtlgpSHTgAb9VZb5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeZGXlTWAKP29UaoIoc2bQutzxGunLphOZBm/C6RDRuvaYo8PLxcDFEpvKe4oLZ6D7n6hnUTW2YEeMUGH8ba7Te9IWI0SPF5ky5X/tPJF2qK8jd0h9bLOdCIF5OkPgR4oV5dQehfVD7KK9bkWlVOqm4F1feFqOUBa4ng+w3hWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kYi/E4Re; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32e14ce168eso55101221fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753161120; x=1753765920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp7QbS0xMvkOoKs4HA6eWBnh1DAtlgpSHTgAb9VZb5g=;
        b=kYi/E4ReHxDVNM4Ik0OwqDCrEdSHdTewPTRmjeN1CXa5x5oFUp2WqLt3kXG284e6Qs
         sOoFyzy6R1GT2Q1rEDAFQhAlvMwKg0Dyvf4jBUsRm8ky0rvKn4gU7kQyOmG5V3YIF4b6
         0GGa4tgrQ/hS8u+djNKxVJ90g66IFcMgeXSBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753161120; x=1753765920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp7QbS0xMvkOoKs4HA6eWBnh1DAtlgpSHTgAb9VZb5g=;
        b=sVKys/fyCnNU26B9x7cmNNHQ3nET85johFCy34Frs1n8EUU72Rnxo2LOda5xJIFVzW
         wqe5ElTKYBH4XBXrH2pbLFjpF+C4dybuOjdKIgT3aeHJWVaAk3Zdi7KNdOw3Hj7F1+vb
         JREUz0G28HkPljDjeFxM1kuN1cU7IjnhfUNsnMNMc2A9+IDino9BKfXI3GHGfVNev3gY
         36Kwio+UoE57vB4nu70zZF7gix4MZji61eLlWChw+kwPv0EenWrfd8CN956o7hMgmwBn
         hPyu2sAHNHzv3kqqrCND+tQXRpGnPLrVMW0SxvX8ZvgMFLqbbup0izqb7clhalzuvrC2
         xyDA==
X-Forwarded-Encrypted: i=1; AJvYcCWNmol4j52R0fLjEjM5+l1O5hwhntFWBZ9Qtdr8Dtj68o35J8W1wl8EnPswTIKWbqkAgPH7T5l1A3mnQFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRwYXz5uHb/pz/Y1CYR4L6XLGC/IKt9UZp42RjaX8avMmST88m
	12+yEvnHwIHP8tZ7Rg7TAPnMv8rpelxgnwjnW8xirYx0IoIptuABv6O7lo2pBQILzJXbkhXzq1O
	7oyhIAO2FMw0sEjhNCgYyJPY4cBgXGKYFYu1skMAW
X-Gm-Gg: ASbGnct4tU0/8L9dWX0LYJFRKvHjT2gaGfpSoQoK9oAK8nU3RSFPjAEG2AloyXxpLWG
	l5LoyXvnZnZMaqZtQRgAUiwGJ2dolF7Iawz2rDA35uwREkaNb6awko7mApTNEtTT4c3d0Eejdjl
	0CnuoFENhyEjpwuoJmP9jSwTHV4jZ+sODk0glqteZXZv62kkIXje8xMSqzlv35U7+eC5PkZMyWU
	mgPF7M/OAQ5wzCkA2ISWiR+dReggk07N+U=
X-Google-Smtp-Source: AGHT+IH22/vbUKUG8iVF8TLU3Pr09FJMHHQB0cP/VJ/YH6NAlscN+8Vsgqf7M6hY2SpFOoAipmEJQYGQAxTIjPOplEY=
X-Received: by 2002:a05:651c:220d:b0:32c:a097:4140 with SMTP id
 38308e7fff4ca-3308f2bf935mr75562221fa.0.1753161119744; Mon, 21 Jul 2025
 22:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com>
 <20250715140224.206329-2-angelogioacchino.delregno@collabora.com> <CAGXv+5FXr-mGDG4mfqFx0o_dhi=Q3s=Yjpj79UVfEQKf2Wit2w@mail.gmail.com>
In-Reply-To: <CAGXv+5FXr-mGDG4mfqFx0o_dhi=Q3s=Yjpj79UVfEQKf2Wit2w@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 22 Jul 2025 13:11:48 +0800
X-Gm-Features: Ac12FXzrJFH94VROkFmS93jdH200nA-PFU34ujXfOAcSOpzNe3a_1b3sR8e3Sus
Message-ID: <CAGXv+5FAm2zwnVZ2+YHiSJdMoByUh_UV3j4yNTmo7Ngv89Ck6Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:58=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Tue, Jul 15, 2025 at 10:03=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> > usually found in board designs using the MT6991 Dimensity 9400 and
> > on MT8196 Kompanio SoC for Chromebooks.
> >
> > This chip is fully controlled by SPMI and has multiple variants
> > providing different phase configurations.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
>
> The descriptions match the datasheet and design notice I have.
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Maybe the supplies (PVDD[1234]) for the bucks should be added?
Not sure if the control and I/O supplies should be modeled or not.

ChenYu

