Return-Path: <linux-kernel+bounces-780331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D881BB3008D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B311BC6A01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74DD2E5423;
	Thu, 21 Aug 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkWlqK7d"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A92E1720
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795053; cv=none; b=AyqEwywIfmaV0UAwe+Cn7Bhe+RAbCWEVsTpXhwX8NHvv58gHmeeHSjK7NxzASaqsklxtT7or5+xdt+IiV4jB+8VSzYSnJO/MTSdfO/GYkkeY+uuXdl47o+mDl4+3/oFx68qN2BBWNALTHX+yXeozNNdI5eIU95keICv65ahjF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795053; c=relaxed/simple;
	bh=MA5CoRznscTD/9JPv2I1fgD+UFpMWzRT7Bcr37nG6ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQXUqU+8wbPVRbi0ZNgvdivnhrbbjAzCcBi2SOlBcHL5C+4uYV+8TEIELb+FwgHIQDNdjeiVCBeUKqNxpRk1UzFeYxnrT2n/GQyRsMPHzkadSlCPYbPEcO0mgdQvbmOBSkpTR4PtlAnV3pQ7Z8+zDEglizAEMKsJLj+Bh6Y86/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkWlqK7d; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3354b208871so7300321fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755795049; x=1756399849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA5CoRznscTD/9JPv2I1fgD+UFpMWzRT7Bcr37nG6ws=;
        b=wkWlqK7dAOZ1y+MgUubgf3rcCYYAXyFlwlaf6n4BDE1E8OdI9GvbbFHWXkFl/JUFpg
         QKfV51wUQLLQmaYPN84dofbifww2acVr069Lix2t8jO531wrxko2uFTV43AqOPGFcPC2
         WI2CIbzgrmnkREqIIFNuu2TPj9+XqcicbgOur3++CAajgcp1uC8YwLk5Fwy7lmsjwGok
         75qkS0ue+edCqf8SETxtdazBQpUu9ZXtTajUIpPtPT6xsd1EBJvuWNjHjaa7OPUO71m5
         bNJnhuWZ4pei0ddwxz9G8ZSvM8adFkmUF72vyFqcPzooTr27LGesDsqJ0Z61m+Om3WsQ
         McEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755795049; x=1756399849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA5CoRznscTD/9JPv2I1fgD+UFpMWzRT7Bcr37nG6ws=;
        b=CoWsZ1iElf5rKhLTJRrV555lPTUqm3Hjjl44K3qpQfwsyItuH7Rb5+GCHCwYqVPya4
         jsixbZJ7emqxWTiRm6X2Z0KF647MMbNWBUCBD59DF30X/InGA+U472x9WV1ry9ywbP8R
         dil/2Qigz47bGmje0N0yMcEt9dynl6RWrx4bnObEMA46cDi9E4BywvmjFgBy/89agsvX
         47+7BqjhexgthEqDer3k3JEbi2UqcLWx/b7AUQCsUi8XB/n8zjdYEhSyHHNcqLVu1xyv
         VXDgpVXWQyo7EGspdKJ+tdIqd8UiORAbFd5LgZ3e0Z5Bq4c/31kkq29jF5kmZPUy5ekW
         m+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN969uAwHKMVaKJ0PaHiYiiE4zqkYRKW5Z4vfI41teN0GJVx6CLfFXTGYofbpIcmk+aoBsB3J+phzHMP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDrKfk7tkLLkM5Lq4YcvsJdSl9w3FtqYDmYsZuCEtUX9/swVXy
	j+cZrzIKx/EkyMATBZ8JObPBFybI/gHJ0LM1dnfNNMZoJ2M9+C/u8jOsX092EbnofsWIxnW+B8c
	TN9rClUVJpcAdxxipirph7ppetO6//fQ8F3or3NS1pw==
X-Gm-Gg: ASbGncsd8aY7ZtBgXn7x4Mg8UzQB+ucX6NL0tFMizWtElujpVPSmYQy8q1wu7ftv1SQ
	x5pDytML/VyOEuZ56xTtK3g/vCEkBNLCpjwX4B1vKleNR3lGWrqsGnBYVzOQoHNRI3SUdN/O0pJ
	Ex/mKl0H4BhFcQriqTNePa87zdYNXPQWjUBdv3q1+zt1fEDAuhOUxrF29sWMABbae1N2LzCMO7W
	5lcbKNVDZNTUr6J6Q==
X-Google-Smtp-Source: AGHT+IHXxJmnZpxwlzV39CihpI1fip8jHsQ3wqrQIPStR8+WqibfCJ2j76EEt47pzZKFul7hhblBfkLJ4pGoe6B1jMM=
X-Received: by 2002:a05:651c:23c8:20b0:32a:78f7:9bef with SMTP id
 38308e7fff4ca-33549e3ad61mr6524161fa.8.1755795049223; Thu, 21 Aug 2025
 09:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710002047.1573841-1-ksk4725@coasia.com> <CGME20250821124039epcas5p34b77813c9936b8b70c801e0e1b67891a@epcas5p3.samsung.com>
 <20250821123310.94089-1-ravi.patel@samsung.com> <20250821123310.94089-6-ravi.patel@samsung.com>
In-Reply-To: <20250821123310.94089-6-ravi.patel@samsung.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 18:50:38 +0200
X-Gm-Features: Ac12FXwqIo6zLlw0fIpSEAb-CCiAQ7nCYe-8wPk85-SMsx3heqK_K_zSrsS4110
Message-ID: <CACRpkdbdpcPBC8mwazoXHy+HE+hH-XWDkfHV4Uz38YhZU7UH7w@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] pinctrl: samsung: Add ARTPEC-8 SoC specific configuration
To: Ravi Patel <ravi.patel@samsung.com>
Cc: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tomasz.figa@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, ksk4725@coasia.com, kenkim@coasia.com, pjsin865@coasia.com, 
	gwk1013@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com, 
	smn1196@coasia.com, pankaj.dubey@samsung.com, shradha.t@samsung.com, 
	inbaraj.e@samsung.com, swathi.ks@samsung.com, hrishikesh.d@samsung.com, 
	dj76.yang@samsung.com, hypmean.kim@samsung.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@axis.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, soc@lists.linux.dev, 
	Priyadarsini G <priya.ganesh@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:40=E2=80=AFPM Ravi Patel <ravi.patel@samsung.com>=
 wrote:

> From: SeonGu Kang <ksk4725@coasia.com>
>
> Add Axis ARTPEC-8 SoC specific configuration data to enable pinctrl.
>
> Signed-off-by: SeonGu Kang <ksk4725@coasia.com>
> Signed-off-by: Priyadarsini G <priya.ganesh@samsung.com>
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>

Looks good to me.

I expect that Krzysztof will queue this and send
to me with a pull request once he's happy with it.

Yours,
Linus Walleij

