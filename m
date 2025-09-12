Return-Path: <linux-kernel+bounces-813912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C1EB54CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C2517E0BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F53064BC;
	Fri, 12 Sep 2025 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DL4/ihgf"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322EA306488
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678595; cv=none; b=r43I2JbyZb1d5GhgSmsC1QHTTjsK0xGLTrBVvod9+hlmmGMLWB163/fZ/eCzpPofKko3VaDiqqN+cYwsFkPeuOoPjq2ROZK9ru3aOFVY7YBIBuoyD1dr1rYVrwP5g39gnDufK8Gj8hZr6jzrIleJp6xvkc6XfQLhGQyRZwgbfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678595; c=relaxed/simple;
	bh=QVperRnHEJSGJPTmM6KVvWxpKyHPxQzH/drJR08pJQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYWQOffjw2dMGD/2GC5WVN2NoCyA8UZS3Xc7xpiF6jHDgHdz90nqnXlmxfpaauRMPA9l98KYPA9GwfS5pfB0LiG7Gbg9yFBuiO/a5H7Rn+c/RU1S4fTGqGg1gegJITna9pxWLK1GxInAsRCRv6IqbjCq0u6sLy4c06ztsaXJeyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DL4/ihgf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso1950709e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757678592; x=1758283392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PdFHKIGbwFEvO78k7VYipO5DNz3mTKctmHS0mOU/VI=;
        b=DL4/ihgfFFXwIRBDN6byjzagNqLkh6HN+KEtNsE5XF3GAIey8uj/hdG7u9iRH5pUrg
         gWHhGaL+Ykdw4rYmVdMYI6leNkBKlLrFjG/1x2rQkFpUAQ6Z3CkS11dReuW9O4AmVMlt
         ASL49h+4ZOzl+GtpEKbGODW3bjM7/2AuiTCL8lmnLbTssR8bW/hIoQ9PMrwaz01dAjRh
         SXPjN2aeV8ms/mb3CGu0aM0/ZupGivEdLqnLPrCsOyVJuW9XV8g/VhgxyWMaAuU2PpfE
         PZu3gHqsfIk4TLuF+bXwa89ifMHGc2Ndloe1sLqoc4tXbclcSngtOEcCjhm2JwvqnjCR
         trsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678592; x=1758283392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PdFHKIGbwFEvO78k7VYipO5DNz3mTKctmHS0mOU/VI=;
        b=m4hSBmCqUSl9d6G2cWK1mM3hEcuyRBqt4l+46TbCd82ucxJqHDWk3RUoAFr9enpaWr
         88srP8QXuoDC8pTSLqpv8FachAgVrpMwuZnu6IZLw2fIB1bpxZxhP9TP7AXyyMqK+NBr
         +n6O9f6ToRzCrr6VrkU6AZn1lWb9OegQKav3Aw5mCQlQS+KAsrg61OppMuU+s06jMYGM
         BycWGLHz6mM3HwvED5UPZTsjbLHbYb+MWVkEYJVwKC9TYHSXCObOuf6v1ZL0I+ANdFG0
         3H5GqM7fJ1nau3bPQpuN6YHKaLVCPI2XfeQ96AGN86cLklWOLGTfWoqHqnhG8Ra7AZHE
         tdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc7ikbKS25rbiYXMkAFyYtxjoOr74TF+mReiEbT2ehTUTM0dAZ4PshBIGr1xRNK5KLFdSm0b5ARuNyOIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJ2nNbP5Y5wdVKYGLNew6U941bTDl09GD7uxVpzz9UmwNvBHz
	dwTEwR1g0Li7LqfZkALz1H2TyRbMWqDPReMqNrRrssmoheGlhC5RrxHMqWCjZd+2Yh0oAH/vyrs
	i4Fdu3wYwyL+4VHIL0AiKhzYG8r1sgzsjpheqHx1yMw==
X-Gm-Gg: ASbGncsuFQdsDqebKZBrsidXDsDRabUczlVQ9vooC51qy1mh9/AWPZTlQnMIpKkGUoK
	to60RHnY53vvb9X8LT22IwbssokmlyrcV7oDFvYUPuTMKY0KKtXNMlvdza4LlXn7dLOq1DvIlyZ
	IxO5BtFw6yRbf0QBUTC5KZROLZakjPO/U/rOi/KbENw5b6Ur4+KSnq1soofMtUyjmiX4DjQnxoy
	bXEMSo=
X-Google-Smtp-Source: AGHT+IGSZOlTW8CCLhnbl5TBUxb6BdFbzV6+OuHe7/KsFBuH3oWJWnilJXYkrdME2jw+G6yIQ8lGS/eJCMYe6xHrNns=
X-Received: by 2002:ac2:4e0e:0:b0:55f:493c:ba2b with SMTP id
 2adb3069b0e04-57051f3c661mr692236e87.49.1757678592231; Fri, 12 Sep 2025
 05:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909181841.102103-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250909181841.102103-2-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Sep 2025 14:03:00 +0200
X-Gm-Features: Ac12FXwqQ4S6LsJ5ISymFmSoLLy-PySRhoETtxxqmtEpkSI7Fd-SoneEsLrhhRs
Message-ID: <CACRpkdZAt2n2gd7TuwRiBzUwjKy-LH=d7EYC7hg=j753UxKQYg@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: drivers for v6.18
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:18=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tag=
s/samsung-pinctrl-6.18
>
> for you to fetch changes up to d37db94b078197ec4be1cadebbfd7bf144e3c5e4:
>
>   dt-bindings: pinctrl: samsung: Drop S3C2410 (2025-09-02 12:31:25 +0200)

Pulled in, thanks for taking care of the Samsung drivers!

Yours,
Linus Walleij

