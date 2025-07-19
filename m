Return-Path: <linux-kernel+bounces-737800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7BEB0B0B7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D415560EC6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40663264A84;
	Sat, 19 Jul 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebKgJs54"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11173287255
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939728; cv=none; b=XQqHqSty31Jt9WoCBOVTFvrsjgTYtP7Z1iPYoc0z8yxiqhcg+aWzFqt7i1n6OtV0hswFzqWc9wXTzBcyd3F41tfQQayAx4w6jlsjiCnZSqCoK45SRADw4kJjRKqOGN3YNcKl5egQlsUi8hpudq1d0EEj2ZBhM8qOFX2h58OFxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939728; c=relaxed/simple;
	bh=rn1nnfWM5bSta9/PZz3/I1BzLdbB7ZlLj09o7IEgKVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBcezFNxUnNNKQd0PADPpPLkHK2kVDGUzHoczPSrdPDCwD/lWaPiGS2M0Tcuz4z0DfSV39px2US3mM6eMIuBMe5DoBTqihUKtbVYBqVhy+MCfbaaGSn4pfreALyxSRDzPVvy305AEbFRJHbCyYBeUg5dsP3dlUVkgIUepg5FYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ebKgJs54; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso23733371fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752939725; x=1753544525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn1nnfWM5bSta9/PZz3/I1BzLdbB7ZlLj09o7IEgKVU=;
        b=ebKgJs54pJ2fab+5VlnaUg/5Bojl+h+Q1zvBui86qYGWpEGMsYNCC/f+LESEA9uhM9
         4ebh1vYN47hGuPGSYW0cydgVvchSD/ceo6AuKz2aNeevZFGQzqst1lL5Zh2BFZTIBWAA
         jiflfmk91dvsQrILf7YPxK+tVeNXx7pQh5tPrRVhYulTUcFkQbhJ6nhTETNEE6WNs00e
         ArEHPYsaobCpOHISSlGjOfQQbIsK5x2w1cl0CyuiYt8iA1gUY6WzxaYqEVVqU1A6dSsQ
         pIiVypiiB8DadSHRO53FaKDf0wEymKRk5VbK5sAYXcYy/V9cIw7FDLkQk64DMkNqNmlU
         32nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752939725; x=1753544525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn1nnfWM5bSta9/PZz3/I1BzLdbB7ZlLj09o7IEgKVU=;
        b=GDx/VzEdofA0BSHM+EjMTRktOr9MOUUeg4ujs4JAv1k1HSQv/qiJPLpPF9lWiF6Swy
         s2p9eVo8pGztFNezgV3kOIADLBIyJJ/+ftoHOuqsz4ePUct7uO2IOkiDTFctn88+1zhD
         4FzOFJfjWxpCmabLc1ziL32c6a3ejeN8YA05UCPLERA3/IFA2iyTcwFq2lSpd+sQz0tX
         2IxEGW+A5ZIx4eWcK31mJSKEShYtE5Qqg0uRlNttW/aWHu+evmCeqHHy7QhbrVzQI/94
         b0cuDlUzaxdF2L5sD7B/qTGX176/SJlML3DdfnuZhH+aP9am2T8AI3eCRVYPTLJXK+zf
         oZxw==
X-Forwarded-Encrypted: i=1; AJvYcCW541AlbK3etWfrTbOGc3jvfLassXh2kPJvDdjt/0h03fVSeOjdS43+KYvtU2FXloVj/goTQPyVwMLEc/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0cwXJGClUBYaP3pfyQuWf1xJIF7OeCkYBUALuDTNfJzKs1QN
	mkKBpxXqqezz2X2tNk+bY6i4ZKw6me18vzfl4b41WojaCvwVNU1+z+AKPR7nCm1JpP5oTTMHEOs
	fpnLNlaTdFzBOhjm70YXoHRyoSMMvzy3ImyNFuJxUcA==
X-Gm-Gg: ASbGncuDID6M57jVKnvpwkId4r93NTTyPpksKQXDXs88Ldaxi/oEp5MDbL6KtVkdAqC
	cm2lNJRJ42RyZsiz437ZuW9KvSv8ific/ulGaQGlMYiN7gjAJdKa5Do13NEIehhUvtFbzpoOwV5
	6fkZKh4TjY2Cr9JSsrdiWnlW+eChJw3h7oqxt0YHN7t/sNu+knQTflr3fa+CgjP8Y9XzqNxnjXW
	RwoIn0=
X-Google-Smtp-Source: AGHT+IHz0AgUzYYyokGlt/TZ09DPKHJYVrOty6k/FTgVY5vV1r1KxHh9aV72LWBbI4MCzMrbevh/6hzgi1HVNc+Usj4=
X-Received: by 2002:a05:651c:54d:b0:32a:864a:46eb with SMTP id
 38308e7fff4ca-3308f2b7638mr46687401fa.0.1752939725118; Sat, 19 Jul 2025
 08:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-6-556cafd771d3@kernel.org> <8f9fdb3e-9655-44ce-8a2f-c1628c88c929@kernel.org>
In-Reply-To: <8f9fdb3e-9655-44ce-8a2f-c1628c88c929@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 19 Jul 2025 17:41:54 +0200
X-Gm-Features: Ac12FXwAlxaX4ocIXQ1MhtIhdmA9pd8x_pk-4cH3CUUGhFSCjbZy3REqIbEaUb0
Message-ID: <CACRpkdZdz7eHVjgX-X_UwjJ_qSu5hSPeocuQ9DWSiyjNLU5AmA@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] gpio: Add new gpio-macsmc driver for Apple Macs
To: Sven Peter <sven@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Hector Martin <marcan@marcan.st>, 
	Neal Gompa <neal@gompa.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, linux-pm@vger.kernel.org, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Conor Dooley <conor+dt@kernel.org>, 
	Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 2:59=E2=80=AFPM Sven Peter <sven@kernel.org> wrote:

> top posting on purpose: are you fine if Lee takes this commit with the
> rest through his mfd tree?

Bartosz should answer this since he's dealing with the merge
window for GPIO, but generally it's fine, and it's even using
.set_rv.

Yours,
Linus Walleij

