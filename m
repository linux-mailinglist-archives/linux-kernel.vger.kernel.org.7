Return-Path: <linux-kernel+bounces-720758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95817AFC01C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673101AA716E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056F1F130B;
	Tue,  8 Jul 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en7yQjQP"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAA1EA7E9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938804; cv=none; b=jPnwYwiz2mVePmfwWBMk2xk/AVtzdDQYVK7lwEezlEsVxWs6fqdkT5n/BEzkSbDrI7rZEjDUNa2ndIBtPPetPSZ7e54Wdj1XkB1CRjwpttuByAkoBH7PrfDosRQ96nf066V5sr3vEisRemmeOJYdJXzFOZ7be7iE7SsaU9foH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938804; c=relaxed/simple;
	bh=ZgzMhn9PXUw8XaAQ7bqis9LsIzAHvccPSnO/9V1QKUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9zydA/SnDh3vZidgynPqqbk95nL741q8scs2I/J2xNnVD3Hw7mXB0iqkKUtl6pEErZ+iVLX2+3LHmsKnHegF9oK2IVz9ffjsoaZs+DVetnETvq1bOA+a33TcppWJJVNyvyh1NlYFOCWwrKZu7SYUcDE/xFcuqloB8c/zFAfGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en7yQjQP; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55516abe02cso3808759e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751938801; x=1752543601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgzMhn9PXUw8XaAQ7bqis9LsIzAHvccPSnO/9V1QKUU=;
        b=en7yQjQPf5k6xo7pS/FDUpoFTOxPSwc0v4Cr0a1Pw6RXGbL/n0BciyavoZ5I78lc6F
         ZeJucZA9UH0aEUleotdNHKbGbjrSwoR+6vfazRrS5ZtbsZT1UBOWIaHqUHun8YvBwiwD
         Ifh3FGuRK9vUw0/tn3dUJllrpowgSEG6Xg8gKSXLmnPAypurLLsxpESf7MfwPEEYHuKS
         Gv5AENvmHfXt4VK5239AlgdKJOb7oqUnSSNexUzWILYwS8swO0qMAiF5cSKEkZ/nvIzq
         7Sq+eqDmfvIXSsG85E2S5zzBd/fO2oV/RDlzGlq8Gi6ZcyPWLWzKcN1ThavFsY33SIr6
         Jdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751938801; x=1752543601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgzMhn9PXUw8XaAQ7bqis9LsIzAHvccPSnO/9V1QKUU=;
        b=eXQd0fqloQH3VvixvIvVkJ9TZGqJI9nUEANNhfTVXi7mVqhgwg2fDw2Dc3SxWlm5Ia
         7iS8CavT8V5r/Qq4p45YE+axKtMED5+wZ9WeNQFpKZX0SW3kDS8MBbkiYa15ozzIGfsG
         nxoBbzbFcaOPH8uIk+T7DO6afKfEydV7riB/VJpyOS5r+ul3IV+2EqJEWsb44LSl5kcC
         CrfqtsTmKOhEVAIgXs/2oZQv0KPE2dbhqEruoCVSZ3tWY3paybQ4GcOJyeBsaXowfavI
         SEHIh9X9qhZP22CuiIFgZTIZaL5W3zhOkSmS59+49lJ20k+czhImfvMvYquVLesFxA1e
         DfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW0rCjkPffr0+UzNfokw0wng853nFq6kzYMfl2onI/7oWWIsg8YRypUVt1pwEeki0L2aQrMPnuSDRcnyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpN38vMK0IgcazacpS1N/ZAdkDWQDk+O0tXUwEjDdAoat6Wfse
	KnaJFAwIR/5uwP0jQG1c+/IEThdAHxV/P7Wz8LgiSjpEN3x+TcPTUk4r0JGNG5FZKAOxxrGs5kt
	mx3+7QGmWuPp+7vywCDFqy6VvcNGmXHU=
X-Gm-Gg: ASbGnctLSYZeOVbXM3h6kjROP+zANX7yBGAcwUNHJQ12BBM6x/ZidKoUtj+LIZWCALu
	Hlp9hrkz7/3ItbrdtZTDYnN3/6oKX5tuA4TW8j942OySxQfKCQG07Bia3XASEb001m+EJTKTSQ9
	ujXJXgXSzrGTnUAvQV9l63Rd7vgWvRpcMtMOXGydQwGB3EtXkivJrhsS0aYmmGQ/eA1F/2qFRgw
	YQ=
X-Google-Smtp-Source: AGHT+IHygg0TywmldncFMonK90kHL8Dr5llLxOm3DhG+XHvJuPfci4yTlbVuoguyFC6BCZkSLwEJ56H4J2PHxXgxdT0=
X-Received: by 2002:a05:6512:340d:b0:553:2969:1d54 with SMTP id
 2adb3069b0e04-557f89b1acbmr264901e87.8.1751938800572; Mon, 07 Jul 2025
 18:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707234628.164151-1-laurentiumihalcea111@gmail.com> <20250707234628.164151-3-laurentiumihalcea111@gmail.com>
In-Reply-To: <20250707234628.164151-3-laurentiumihalcea111@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 Jul 2025 22:39:49 -0300
X-Gm-Features: Ac12FXyFWnyJ-B08lFE9ya2aqIPGseDa9aDMsZwjLGBKAWhJik9-kphabCMJ-sQ
Message-ID: <CAOMZO5DfuRKYHkC8e4mNzetY204UdPDBHzUVy4M9pyjKpx401w@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: defconfig: enable i.MX AIPSTZ driver
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Mark Brown <broonie@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 8:46=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Enable the config (CONFIG_IMX_AIPSTZ) for the i.MX AIPSTZ driver, which
> is required for platforms using the AIPSTZ bridge (e.g. i.MX8MP).

Shouldn't this be enabled via a select in Kconfig instead?

