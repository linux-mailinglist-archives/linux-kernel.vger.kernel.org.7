Return-Path: <linux-kernel+bounces-876138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EF9C1AAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5113585EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2B2C3276;
	Wed, 29 Oct 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hlOtlWVn"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB3230BF6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743644; cv=none; b=rtUtEPBIf+4ndzVi47Q/8RHr2Dz7bhn4XHuDbClspPRq6xcSD2MmEiYDPxiINHZZ0pOZkWZkKU65unwiaqnGGmOwFx9BTG5ql9EMaMnIaTiU/5SubJhlOBtEIvgR8rFCpAaPfnJin1lNlUovfZcDPSC0kIfGxPENGaUM2/tfqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743644; c=relaxed/simple;
	bh=HXh8XVhftIlOuBLfg8NVk9leceRLV9HU/K4pAv4S7GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0Ganit2uDJWE15UrD5lZ/lcM0knViPqzDY1INBCqwlDfLRhI035I2OOXune7WR9N9yyLu89lvboN0Tvn30LOKkG9+HUjPOQxmLxvc2E7m5uqYrej7Qo9krPpXpSqA/3ftuccoO+wzVNn2pqTmCoLZegzg370QpHSyoiQPq/PEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hlOtlWVn; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-362acd22c78so67758141fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761743641; x=1762348441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqA6GSygQlCbGGE92uS1aB1PWjkaAYd841Sg4SieyII=;
        b=hlOtlWVnpwS3XHlygstKeC9HQVK9qNA2JkqB1DjoDbBqjJI28RY8aBgzwcu5zobn6v
         sjQKZ51sZzwj9Yo3JpjAfR/gZAs04ZPoLxvUkc0MZf4YpTU9O0erq77GdSZybw37WnP7
         IfJ5EgphNSGdC4Kr55/1gLYQkQ2fb+iRbNM4z7fVFcxL5D0bt72gcgGRbSX1tc4Pz0He
         f4lSbcZRI3eg6XPKLdtuJiQ+PJAuk5eTwYBfPhc8LP4zZtl2al59/lFALKr+pI86Jqow
         isqLqslnToa664tkOsZ4Texuq9tE6N7j0k/gFF8LE/O0HEo88CCre1sa+lOpNVE/vQ9A
         rZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743641; x=1762348441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqA6GSygQlCbGGE92uS1aB1PWjkaAYd841Sg4SieyII=;
        b=okBNxoxYOP7+SAN4IVKb16o8fyz6l6heoZSj8vVLpvpdcyEaqp36fsnqKDRyckv9D1
         BVKwtdPntdYMCmbsipRREpfOPWz7vvb2t5IVoSbuuWWPLCrltXwqfzyA8JMjsL9tOys9
         GsLkN/yXnJB5lUE4wRe4RRQAO/xRGnjF8QxwPPOHA05b/jiiWur8W0e41kj3wWop+Fok
         MGTRQZbK4j/A15LRs/GQ34F5AAPy41SDX7GG5d4962Qpcb4DLmjyj8G1O4wTQEOGv1c5
         Ltq85NbJJjmI2YbDzLlgnMHbdGmLPL+CYYGh+pZry0Ke4CwHic/oVI9ioE988hgqGlEp
         c1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8RuL7QrrkxzFOgZnQHihr1ant2cITHsz80/ttXFSPNL0pn84bo0zKYTDtdysIHTZPO/ZuKi2RJJZsbfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPe7R+bqUXvWL9ITO087RQKn6SoIqX2csz775ImcenvPghemRx
	QveInSGBU45gTNNowftpqwubTULNz0L5/bnWu+SBgCAqrVeydE5AZitEK1FD/7xxya0IMzgPGUG
	qwHH9H7hazDCFMIAGFIZ1aUn0HATI9K3jY3VFELpaCQ==
X-Gm-Gg: ASbGncs7afjJiw0MTi6WNxYlgBbJu6ceUB9h2SeXPTxi1GvIjVW0SHQJYf4XtXEGNfc
	F6JWGAXh7h/HR9ar1VtUj6OGH1dJ/4J8QT1FdrS/U3Q/Jpu3tF4ATjnE8FYfoDebu8lYaRNGaBI
	kTIt63pAFNyb4HvkFVQFog1KYkMilPJ89S71GH8aeViagKiEhB43oVADTMBacE5joaj13voKnQJ
	epcVJ+2f+w6oRS4T9PVDKh013HpDAscbYT3Dd5WMPvcuWgsxqy1ZlFSjPHgS6I4rCKdy/aIKACH
	FmxVuexVug54KH41z12Gows8Llo=
X-Google-Smtp-Source: AGHT+IEDeO7pOWXIiKISaidNbH4GhhTTnet358H+WU8HbsJA+qhtiRiRxFILoq29B6HEL7w4GKQI73DKFNYwKm/mQwI=
X-Received: by 2002:a05:651c:1107:10b0:36f:4c94:b583 with SMTP id
 38308e7fff4ca-37a052cfe5emr7976601fa.16.1761743640602; Wed, 29 Oct 2025
 06:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
In-Reply-To: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 14:13:47 +0100
X-Gm-Features: AWmQ_bm2G7-iNhdxoXC19qDeGT6XRmVTZTDbAiHUQ68hSenSjedNVmrrWyCNe44
Message-ID: <CAMRc=MeGLUvyM5GGv=eFpKd8_KCcSOnfKXCtZqJwpTGuRTixxA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Bluetooth: dt-bindings: qualcomm: Split binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:44=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Changes in v2:
> - Drop in few commits the properties (supplies) from
>   qualcomm-bluetooth.yaml which are not used by devices left there,
>   instead of removing them in final patch (qcom,wcn7850-bt).
> - Fix dt_binding_check error - missing gpio.h header in the example.
> - Drop maintainers update - split into separate patch.
> - Add also Bartosz as maintainer of two bindings because he was working
>   with these in the past.
> - Link to v1: https://patch.msgid.link/20251028-dt-bindings-qcom-bluetoot=
h-v1-0-524a978e3cda@linaro.org
>
> One big Qualcomm Bluetooth schema is hardly manageable: it lists all
> possible properties (19 supplies).  Split qcom,qca6390-bt to separate
> bindings, so device schema will be easier to read/maintain and list only
> relevant properties.
>
> What's more it messes up old (pre-PMU) and new (post-PMU) description in
> one place adding to the total mess.
>
> Best regards,
> Krzysztof
>

Thanks for doing this. I would argue that the deprecation of the
legacy supplies could happen before the split but that's not really
important and would probably be harder to read.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

