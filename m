Return-Path: <linux-kernel+bounces-727311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD3B0183C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0121890295
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC94427BF8E;
	Fri, 11 Jul 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YnF55Iyr"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62D23535C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226795; cv=none; b=YzhRFekZoT/Ow8qVfKy4ulFsfkosw0MgZnjkma3vF94xvMcmef6+nv1V4Fxni69K3rwPPeyHeYupQ6YQobK7p8oSosgWqSWEHbVREkRae3QymsRAJ+0j4dv2ajKMZwq6xflRkK/RoD3CCr7MBo3iNteoFQWI/qIqwlEQnCa1/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226795; c=relaxed/simple;
	bh=pGQpbekutr1+Uf+KF67JGtP7oLUb+5ENqzKXL2RpdgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3jnnpVZAIYZZmgVXnvrqj8a6E9R+UYQatrAd2y6zIK2qPKKxNU9f8/ws8DTzpoDnzC0M3rDLqBMbXCXzZzMwkbjrtaWJH/FH4DKx/ijaA/ZnI7PkZ9kcSiD7VZRKKjqKAkNSVD9jxY99XAGej8h1Gq69116hdT2Rokbl0vDHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YnF55Iyr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55511c3e203so1800823e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752226792; x=1752831592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGQpbekutr1+Uf+KF67JGtP7oLUb+5ENqzKXL2RpdgY=;
        b=YnF55Iyr+f1TQQBbW+4dbQpbrWbGMYN1qe48O6u6eLvCyjKF7Apae2xFP0GknxCzpx
         yEqV86rbbOVvww8lcw8A9ML6J4FOTGrf9pd+F14XixhNimXWJJ2oYAuV/gw3fQ5sOZ1x
         jx5OLZSMCgXc0PgXDo5FS4tv+dta7z4+2zzQ+5ca3eMVV0sNxlhsyXdX8KXH2H6mcGv3
         tVQpzyrTzm2Ih8dViGm3M0HblxcHo0FKsvSaqhJwRy25FDDbl7bB/Wyk+KvUXOX2eqJn
         MZEXQ9tuhKMFVI2a6dzFz/fG28TyrWWyb5cbGvMB+4SgOl9CxUk8FfHnxHJA+rA1yInY
         Nwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752226792; x=1752831592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGQpbekutr1+Uf+KF67JGtP7oLUb+5ENqzKXL2RpdgY=;
        b=N2pxlk5ebDsf6GLL/9ebBESoEknPOeFaAg2Ok80051sA6CQeNACcwM/VGLTokuqPYd
         8+ehOc7xO/0Vn/s3S7iLF5Nkf6DWwVrL0IHozBcAr/LW/Fu637RfC+pzJBhQNgoUtojS
         H5eBkhrwl4kgJyvPWpE3bqls7OjgQu/IZ7cwhYAgqzJKgglZ2UqmjI7VkXJoVnT/MqCo
         /WsLC0JtfWBqKfzauRGKPrmU9D/Hea7WaNltsxxwE0gxvKq/YdRpLmwYMKiLGitV9Jp7
         A0Ii91lggTwfSHhcZsJyl5HnBpwEl0fL3UiYFtEjrj70S3SxOUc11L1jKFDBH7rNEZjn
         Oi2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+IIti59VeV+R8mY+k7CMfgr9r0BlrSnRR7z1tnHCJ2gX5k2/QRx854rG84l2Ng/X9B5lQgVWSSzJ5VAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj767vZY1LOAzwyJwM3ZkCT3+oPbqQwynLv6iFZxygNbXym1Ox
	AE4yApC5CCX8dnsBtbY5PiEz/8gbxpNJ/y4XJTKYP3eiXAiACCICHPBSkY4cMHbX89PE2i8CJlh
	EzLIGaH/6bEFJ1K5ok3hV4VN21OYMJRuC735hgLkG+bsr8oW9Jmek
X-Gm-Gg: ASbGncsXO8wpNisqPARTSE1VC9gLq42mTzgQV40DlIyS7JSU2Zo7Q7+tYHb+bIz7Pr1
	sp2dDEfdcQRBjr9o/h9svDAx/fVx6w/hqeu4sVrGy/d6Nte52mAvFW6LCO4ixxnUHDuS1j9+bOU
	BEwYXwKGzc8JwFLmaQ+HhsQy/fcm38FZJ6mBFUhNy9ZaYoY1HcgRBzxY75zWPBCxiabvzSveOch
	WIn5HNpzWAsTX2EonO9XPAYZUqbMuId0Dj0cmfsdiUD4aKo
X-Google-Smtp-Source: AGHT+IEFk4At+JNCjXR8Uv2tek5dQDztaiCpOCt16GcwngGIlLiBnZEyMFdRM1jzv3F2PaNLrKmME9qrl+gtzXvZYmI=
X-Received: by 2002:a05:6512:10ca:b0:553:2375:c6ea with SMTP id
 2adb3069b0e04-55a04625e5dmr712182e87.50.1752226791849; Fri, 11 Jul 2025
 02:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org> <20250707-pci-pwrctrl-perst-v1-1-c3c7e513e312@kernel.org>
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-1-c3c7e513e312@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Jul 2025 11:39:40 +0200
X-Gm-Features: Ac12FXzo6YM4ZlaH08l4154uUlIyN8MLpDwn2Iir1feRC033f3iJ5476U0K0Xzg
Message-ID: <CAMRc=Me5992+A0UhR3BA0+oRBepb94k2TWGDiY1Wdwh_9cC-eA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] PCI/pwrctrl: Move pci_pwrctrl_init() before
 turning ON the supplies
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 8:18=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> To allow pwrctrl core to parse the generic resources such as PERST# GPIO
> before turning on the supplies.
>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

