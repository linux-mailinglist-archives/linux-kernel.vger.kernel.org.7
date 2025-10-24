Return-Path: <linux-kernel+bounces-868471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826EDC0542D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308E71B813B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C6C2FA0CC;
	Fri, 24 Oct 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSquGxND"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E82F99A5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296984; cv=none; b=QQnfAkZhwJ3pWyhUqSfo963Mi+cMSTf3jyNtAhT0Fy6AqhmBEOck8iBuLHbNZps5IBqeLOzZuOi75cphS2wsVrp/Gi4hO98rYxeZTqESggK0T2Slc30wtDMvfSD56Dn1rM4426r5aMtUZaA8nva8nFqwclGyCNoCh11PWyrY6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296984; c=relaxed/simple;
	bh=UAqe7CZi3/gqCGelPBXkKXXnwmTO3hbdt/2MJeLAtzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeSUdrH16SQkd8glyYMwdW/OXQSmVJ+8SSToLblTwhy/vU8KjTczAbaYO/HkeGRi6kuYdc+GfW+9kxUjep1pxaEaNSizB5Sfa9KGqWgk1MkaBoJqsogxxVaPSRduhcWPYbWBXWAj6cS5zYO0425pKOUmWYYS1lYdaV2MyHGL3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XSquGxND; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so2219054e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761296981; x=1761901781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAqe7CZi3/gqCGelPBXkKXXnwmTO3hbdt/2MJeLAtzA=;
        b=XSquGxNDnLFm8CXhoRwXciPYi48IDRmy0lZSSSmkvMsZgWl852n5VKIWz/VrFi0o1s
         OHSdl5jneYdsrY+kcvC90KSiH0I/QRT+YxVo5PEFvIEIsz74Ju5oYAfMYlI9TzgATUU1
         4dBGC4YVfwJm+CK/mZ676FFmB4O5xoT4KxwnOMZEN/TRCTcVPMNJunDE06PAWNC/G/gy
         l3e+738pS6pHeElN37MzKglvDcA1FFazgWbE0TjjkkANNr7EsJjWzWweKWyczMblJ/D+
         9+rNJMoOP9AGXwiyFArDYepQGvPgjaOl0qyxJFpoo725MoIq4qh7it0vl/qjgc1J/S4t
         /iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761296981; x=1761901781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAqe7CZi3/gqCGelPBXkKXXnwmTO3hbdt/2MJeLAtzA=;
        b=WwaqfMXaRslBm6tBczQPSEVrBrwPjWdCvl1ZSmiGcZjjuevyeDG//oFdRKvmKqAuA9
         hxBehDcshjXdI1tHrtL1AccUN4u3ZZGxX5zYYkkpMUuDcKhwxWB8M6SDED4ByfZR2fl+
         jlOiT0qWXGoJYQBKrzn7mbnSMd9aLILyfDOCt7Z5d3xblGtudKV4bV7fS4LNOZ5mpHZK
         Tpi/TT7Y44P++h3LUgyIJvpvoRKCF8luCl5FEHXZdVMerdqUuL9kg76Ckg2bPF/QHJd3
         7mtDzSXqL7P3vfGKQ6ZrjOL6KVtxtSQwutoyPRaCKB4Gai4N/vkS4w3zwDgilM6h1TLT
         im7w==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6wNgut59Z8/iCcydywJ0BDexB9F/l2kf6obJ8WtaLa4zSCuVctoMZgVsDo2TEg4rgBSt+VXzJyU0yiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8BdTNTAg/VSfFqzNzWdOOtvFOkAaQFubIcOAHyvcVcLewNkO
	4+6ckOeAIMD+qZWefiMorg4x+9EQZMGNIqKQEyePeIFgtwR8yNE3agyQgQ4SyoGZa0y8iWj8Tqa
	SNLi4Ry84D2LQalED8bT29jDSk84MfG3Kf4dSImM84g==
X-Gm-Gg: ASbGncvNp4PP4p8/4xjq7CKqy6CVr5eXB2ELwuBYGhqJenMC1hyeN4GE0Ua4Gw80ytj
	x2uc7U9+psVEgiEHOs9+lGNPz4PGRGs2dTFSa6Evnz3+B+5oP2F5XYtNnN9CL/fl/+vXJrSdIkS
	YR1cZXPFZvHXGJZMyBmzWPXW73yTzo8WUfolxr4BE7Z0KFdOOd3LjaWLtjws2XXiWOZW5TRbFjf
	A0zgMEt1zAOWNuIvW1R61Pk6TwopT6aJ5FERfmDVgL6qEoUzgCbOlFa4DIzLJ13oMZY584=
X-Google-Smtp-Source: AGHT+IHDOu6wke4O4DC+iGnNtg6zbqtK6KSChdJ8QpPRqUvEhR6minp0q16+phIn+H9iRbMdYm+MpMhaLWHPjXa2aRU=
X-Received: by 2002:a05:6512:3406:b0:590:656c:d106 with SMTP id
 2adb3069b0e04-591d857b65bmr8390462e87.53.1761296980742; Fri, 24 Oct 2025
 02:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-stopwatch-cough-47d5497be5aa@spud>
In-Reply-To: <20251023-stopwatch-cough-47d5497be5aa@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Oct 2025 11:09:28 +0200
X-Gm-Features: AS18NWAWiEwRej3g2OXhBBdqWHb3gfghzPpIRKV8fjV2g8m8SOiJLs6wRO03VzA
Message-ID: <CACRpkdZ2-S+h+Snuj-+QE6-n6J4xSf+edmzdp9+o5dP1Vo1Zgw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Microchip mpfs/pic64gx pinctrl
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	Valentina.FernandezAlanis@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:15=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:

> There's a tag below for you to pull that has the syscon binding that
> gets edited in this series, since that's not in mainline yet.

Pulled this in and applied v4.

This is obviously in good shape and any remaining snags
can certainly be fixed in-tree.

Good job!

Yours,
Linus Walleij

