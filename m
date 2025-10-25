Return-Path: <linux-kernel+bounces-869944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E6C090DE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 423BB4E1212
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BAD2343C0;
	Sat, 25 Oct 2025 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5Brjm1b"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CCB1F4CBE
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761399316; cv=none; b=buckhKJu1ldijmgI1+szC+YQ42GXI9afOcHkttktdzDzrYrLxMOyE0XCiahWH4eEjladuTY3gu5wQm2Xfd5ep6fL3mPL6QPAP/KCsBb4wT8n8fdKVXAnYre6WjzGB+EPabWQ7LOx6Y9uuxGOeuw0dk6s12k/gaWJX9QlsevLOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761399316; c=relaxed/simple;
	bh=MfijaoVY3izM3fqXrWCWyMWpoHEq2dEdD86JsySrhGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSLHOGstGINKfQyXCzGS9mWeKjqqYjdXbJ9O8lwpUkxSk4gQYZ4g3ct77aMHoYxdszt2C7ICXXIPT9I+Ouxce5d/Le0T1AoLAbLm1lKqbhjH+E2FGtJKQ8qMNJpxZK3cvU6V0HfFKOR3ZcZDlbvSI7tnzgVJTeVMo6zj8aTawTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5Brjm1b; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so685913466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761399313; x=1762004113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfijaoVY3izM3fqXrWCWyMWpoHEq2dEdD86JsySrhGc=;
        b=b5Brjm1bhOaLOjrZZ6/NrbrSuOtLJcIweyh9gcGmA2a97zXJGo/DTaM+4QRp+kjtxw
         i31ZxTnAnhbnQR4hnKYa97VMVK+MtmYlW9UNO4/fOkyjYYQB8cBNK88rFH1kKwgowZoG
         ucLVqzmh1iclZfHBH5XyyAJuYTKRMTxju2zHHvfE88O1N7yvo+Q5wvEK+eWTFPgONBZv
         wKSa7N2Jy3EuKyNDPRwvrFhBRlANDwyV1rBgtFFzX2/rhMy8MibQc2QIiC0vnMPE5mgA
         SIF5ayGQcw6g2CvrRtVWjOpCLrToXNE2C+Lm/9JnthJvmPYMjtXKnnWneincdUS0OypQ
         z8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761399313; x=1762004113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfijaoVY3izM3fqXrWCWyMWpoHEq2dEdD86JsySrhGc=;
        b=c8HJQEWg5N7FnZ02m1kQsVZHFpokYxGKAQF/EF/H0KO0R6BXcO0TKoiEVZy/WpiMVx
         6PtZK6nIkb7SGD3bItVPAGFK3eHadH20o+Alwmq2/RzrezLwhBfCd2YajtILwnOcCt+j
         47VkApkyU77ZTRq0wqSsoWiqPn6OW/y9j0PV+Egf4y26cViTN15Q+CDpmPkCk11bugCs
         7LbDqQKBs7YZz3TezshNZPxp5wUu0J3kFfciNcpL6p3cy75q3H1Wlnf/CoaxgOOrbbB6
         dIv6wW4BBcV/d1R9yJxWVkCm3yt2KPQffrNsGopp8iqNswjfdVFUy7GUWfLolBwGc6GY
         7bTA==
X-Forwarded-Encrypted: i=1; AJvYcCVqUODRjVk1BQnoWBFXU3/NBYdxNb0mQ9vef3xH+wvDN7WUt7328bwGQ6u4HB9sJZ3+BWLdFfgNBpEBgF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGl2l/GND9Js4nXxtVIpT22m0JfHdU+XQUyeDwu778flAebgc
	9gTZAX0WpBE4lVMDMlIvauSQD1Ei55KNmmj36hqWZRwcaOnZFRwl2jckNjDQf+9lhA0mV0WdZ90
	4z4gjFFircdTeb3+5N+R2MlOKsXDCyvc=
X-Gm-Gg: ASbGncuqKrIxivQeV7LyEzN1az8/rzee2t/xQCc0+3buE/V0ly1Cnii/yYBGLfWsiC9
	g4Gr2unt+eCATqz+LrhKtvt5caK4TX+aQWA7fDbELwwO7ML45hUQC/60IdZFgz2JW4qCN+AADI+
	u8ZqZak+TpTB5gVyemZpWeyCOYFddC2kKMpOO22wFfaN5m3rSHi68NsXlHgnygkAiDBUc+BDXeJ
	QczOFAb3TwjtqbIA1F8nfFfInOmxfxR7Ke2GONLuSmMvEtEX5tJiPvdXFrQQbRKtV3uET8h
X-Google-Smtp-Source: AGHT+IH7uZY/c9aXdldzkMbKAoJ/0i8VLLTPQXrnrc50zjlhNJvLjiDVLNrDt+OLtE1ordGJQHVqtIjtoshodf9kJXM=
X-Received: by 2002:a17:907:9626:b0:b6d:5840:4b3d with SMTP id
 a640c23a62f3a-b6d58405579mr947011766b.14.1761399313114; Sat, 25 Oct 2025
 06:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 25 Oct 2025 16:34:36 +0300
X-Gm-Features: AWmQ_bl95j0vXJ3ZD4OQCpj-LWwza_GWmiE_3yUYJYUFMXDEz7Q-UHF09K0-mhY
Message-ID: <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com>
Subject: Re: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
To: kriish.sharma2006@gmail.com
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 1:20=E2=80=AFPM <kriish.sharma2006@gmail.com> wrote=
:
>
> Add missing kernel-doc entry for the @chan parameter in
> iio_backend_oversampling_ratio_set(), which removes the warning reported =
by
> the kernel test robot.

Is this the only issue with the kernel-doc? Can you run manually
scripts/kernel-doc against this file (with -Wall) and check, please?
The change itself is okay, FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

