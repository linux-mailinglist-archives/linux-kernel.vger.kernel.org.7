Return-Path: <linux-kernel+bounces-728075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D5B02374
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A5A7A59D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9CC1B4242;
	Fri, 11 Jul 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzjWWBqA"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650F5383
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257836; cv=none; b=C6d7BxvYfLcVlq401ILrXOBu33kNUJq5f63YleeG+kqAm2S6gpS0BDYv/bkcvsNtue13QCMH7n+dNEVBuTFu9IbV+NIccqYk64rnCEsoaA5Sf/xtCgLoyIKZbEJmF0nsFDR/4vhSUTzwxUGqq+AMVvqGYcd/R326VqAv4IUjOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257836; c=relaxed/simple;
	bh=QYvEVyisu7Z6GreZjW4tCms0hBLpxnPiggZ/J2R6LGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ8KpvQNXQkyRJMWkNRh/yaV49+rIJAKu7GbFjIkR/zKoE/Oo02KAejsiurGWU6x1ekWfSSLdMgm346k/iRMFnpCXLfRZDGkzWRefQYl3uksZGRlsENXNS3XTQgvLnirOsyKNKZsTZKKkwjEwqUFPGr/CUtdhm917/JrdOEAjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CzjWWBqA; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b4876dfecso35489531fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752257833; x=1752862633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y+y1NjMQjnO8BX6d3MKapk59N+eGmMqtyYDPUlr7Xc=;
        b=CzjWWBqAWUrc42ZpPtNzTft+4+5MsESaOZwkhQrLtRgcDWIVgA3golo//CvNKAYlqA
         LitC8c6rSn1OL2MqSVRkdU8cNwI6IO6r3N2bVKMsJ+rKzjVpz3u0yjKAjBX+S0DXJTre
         SEIio+GbBVjyVNi8RM9+uQVdJDcg7hzCBpUGtnwgFeIgLUNXn775aI2z1RuxGhATzc0+
         BIPEWfMNA+0EtHK3VjWor2fWSKYg93R1j1BdM4BfnTEZxkrbZPgssjo4jhiZOx35L6R2
         /vHGEKDEYoJiQjBnbr96OwMcfHD58nDacz2N7TsoMUQUfJH4yl2XNFq82sjVf6EAogal
         Xx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257833; x=1752862633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y+y1NjMQjnO8BX6d3MKapk59N+eGmMqtyYDPUlr7Xc=;
        b=FsMmOh/Ix5XptTZsAv6uh5wrKqMXk8Zir3bls0itVGRjlFBqixmu1Vmnb6gZI+RQnh
         LKeX+aUJlf7GQBPX1UNXJdE8OYhEjuIUqzJJTQlARAc56RSaecQilskSkmANNfjvm8dn
         nlzlu4nBfRajpIXxnV6O//CAFUnZjXB/HRhCim14r911sE1js2SR+Gmlpy/vH2ad0FN+
         8HFYDnL7TRQX39Jr2YGmKM7Tf+JidQ2DVxm6Z3MxHV/0zyy5A8/Tmqw/JlZgfwBAdZMc
         kOP4OQKVb0E5FUU26rs6urZ45SvFsr9mHMWWQUyjvTkaULqN7tLDlsEUQLomCmWySaNu
         Jn5A==
X-Forwarded-Encrypted: i=1; AJvYcCUDXm+1hoBQMFF4CjjNd/pypqIeZVkhQJSswakm8ILiATZ6VEYHyVZTQaBaqgoVDwb9fb/omfQ7ATjqgHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoih1y/p1b6qqcfaBCGQoDhFeR/tWplD+0NW4HLoasr3ybRCav
	T8xsLsxGW3q83ApmcFF7szvMc+upk45vfgwKtTWB5I2bM5DcJGwUyn9MM0zGI6w2x/NELObE1gv
	tVyVnsIteJWfk2t76j3uwgNJZcpEdIS/jZ6H2i3snK8GVHW2X9XX/
X-Gm-Gg: ASbGncvsVQSA4GM8Z05om90HcJhRmHtxTcGx6RN1Aqeqg9mxBK18w8SKSaW4tnLXdTL
	Vl34Gi3W1eK2aNwSRR7qNzmPYdOm3WwaqW02F0gZrQzV2dn4d6WwfCyPEwUXpVQ0LyNAoYJNHyY
	f210YyUqX7FIpnTq2Xegi73zi1fM9/KNIf4oNSeik+Dq7iCt6wT+9axXy6+JwXg/KdsAineFg5L
	emiyV4=
X-Google-Smtp-Source: AGHT+IFTXdPK5ouoC7CNop7rcdpVbgm/PLpNuMA/4LUKjGc3j/t/RJTnxOeKBYlPmUQiKz1UBrh6piJAWvjJQb85Qjg=
X-Received: by 2002:a2e:9dd7:0:b0:32a:6cab:fd75 with SMTP id
 38308e7fff4ca-3305225fddemr10781141fa.11.1752257832712; Fri, 11 Jul 2025
 11:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-pinmux-race-fix-v2-1-8ae9e8a0d1a1@oss.qualcomm.com>
In-Reply-To: <20250708-pinmux-race-fix-v2-1-8ae9e8a0d1a1@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:17:01 +0200
X-Gm-Features: Ac12FXyhRoIM2kVVfeKGSARAFkZflXxQbi1Sz62x4a5cymVKfg1ewyjnPOhC1Kk
Message-ID: <CACRpkdY-4qHvYYDC39Z5K1mUkeMvpy0b4S-az673OdqxE6uPtQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinmux: fix race causing mux_owner NULL with active mux_usecount
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 9:59=E2=80=AFAM Mukesh Ojha <mukesh.ojha@oss.qualcom=
m.com> wrote:

> commit 5a3e85c3c397 ("pinmux: Use sequential access to access
> desc->pinmux data") tried to address the issue when two client of the
> same gpio calls pinctrl_select_state() for the same functionality, was
> resulting in NULL pointer issue while accessing desc->mux_owner.
> However, issue was not completely fixed due to the way it was handled
> and it can still result in the same NULL pointer.
>
> The issue occurs due to the following interleaving:
>
>      cpu0 (process A)                   cpu1 (process B)
>
>       pin_request() {                   pin_free() {
>
>                                          mutex_lock()
>                                          desc->mux_usecount--; //becomes =
0
>                                          ..
>                                          mutex_unlock()
>
>   mutex_lock(desc->mux)
>   desc->mux_usecount++; // becomes 1
>   desc->mux_owner =3D owner;
>   mutex_unlock(desc->mux)
>
>                                          mutex_lock(desc->mux)
>                                          desc->mux_owner =3D NULL;
>                                          mutex_unlock(desc->mux)
>
> This sequence leads to a state where the pin appears to be in use
> (`mux_usecount =3D=3D 1`) but has no owner (`mux_owner =3D=3D NULL`), whi=
ch can
> cause NULL pointer on next pin_request on the same pin.
>
> Ensure that updates to mux_usecount and mux_owner are performed
> atomically under the same lock. Only clear mux_owner when mux_usecount
> reaches zero and no new owner has been assigned.
>
> Fixes: 5a3e85c3c397 ("pinmux: Use sequential access to access desc->pinmu=
x data")
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Thanks Mukesh, patch applied!

Yours,
Linus Walleij

