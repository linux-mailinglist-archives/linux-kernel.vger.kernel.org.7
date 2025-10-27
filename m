Return-Path: <linux-kernel+bounces-872633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6CDC11A00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5651946191F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49B32779D;
	Mon, 27 Oct 2025 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSoM4J4R"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65520313E21
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603065; cv=none; b=B4w7IFQG2y0adjGQlb0Dqa/p/IjUr1STKWLTRIjVGRDUu+02MI9nv3N3uR7uXvhk0vzI0Gay5szWGtppKKyv+1szVWh9IdIK+QbQdiFQfwpFvgUSc1C+0AdNnLdmyMD0DbbQOzFha0yr3S9wlBpYC1bRRtEKLSEEfugEdJVzl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603065; c=relaxed/simple;
	bh=v9H38XxmVOscTdAXBIMgyb10vFFsNxVOxLuwwMxDzMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB4i7LPHmpkWJfNuaz/XPBZhdOehie4PBk0DgGCqZk1wBQKAqqkPPkVQcV25moGBs4dnK/hl1c6GRYfFOMT28T83EGHwEhCGWEJpo9u319fSD0uv50kGXfOZXsw5T2mNUHKxhNk6iMrS3IrkPXT1JR+fP2S126KzqcofvGZHTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSoM4J4R; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36527ac0750so46506751fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603061; x=1762207861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9H38XxmVOscTdAXBIMgyb10vFFsNxVOxLuwwMxDzMg=;
        b=xSoM4J4RpfdRV/WtHwRQcV2fC0k4PmVf2cXIk9Lnd6oGbNYeBoCxBIFYiuXwUrhKrJ
         iMspsjtzu4jFF2tLOGjB4zKmL+MfgKL7HUifLb3Z+tdl6CeXeCIZDbI4HL36mwB1L8rp
         cKDqcTXan3XGTpVADqw7+MqNXxaYR9kwsUwp/n06zRZtBWszcUzVuGDVuMpmm5Gxcg9b
         rV5j5AFJWPOeTFGhLGNxJx2E2wg91ALFCsc+KmY47LfwWOIyhJpsKIJHlmq2X6STRbwP
         ZMPl16OPrm1StX4rupCtU8GM7r6zK7YfpcgDtFxZDpAkhrtO2hZoHidSbUtabtm2sfmG
         FLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603061; x=1762207861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9H38XxmVOscTdAXBIMgyb10vFFsNxVOxLuwwMxDzMg=;
        b=AJPOMgp8qKjUuAqW+FAhMK4aGi1NDDp2RUXjejB+WGlIfpLg13h+SfU7A1G+FfPAet
         4FM3E537ktzfudu1RZH/aXYZ0J0TS8mQL7JMCSUMs78Go6dNoIeEIIseqrqa+Rx8clnX
         1sIp48ODNd7pm4QJiles9LT6k90if1Vlpu3bGiissruAeAj08nR1rYa+DPJ1YB7Gdi9T
         rp/GYhD9wwmMrkuK54xC6cWiUNgd0gbD00BSNTShmXqh96qXnNM6mcAJ4lDLyf0rrgnk
         2wsIRgHPiuaKb7GpWimFaUOlHI2Df9o7Iyf5HJThg5WTM1zv8N/VC0+83QI4OPERvhMv
         WxwA==
X-Forwarded-Encrypted: i=1; AJvYcCVtLuLm31v2WeBgbV5VxULsi+FSYzhKx2icgzJ5GwD9Tehi6ys/XjBrbpARoLJCJ7gkeTqUuM+DPDykETA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrQpQVtJpwoKoxLFaUGmJQbCIukzfI6QBseJktfsXSc5bb7PZ
	fbUKnGOk/soyg3r5pmPqLOOSmCnc72SXpn5oini5UdzuqbiaSj8baF1ukdUfRZkijnXTR8kJDF3
	g85yOou3lhfsG7u0YzEc34UkuP9N6rPFQq8sRYPWzLg==
X-Gm-Gg: ASbGncvboyqDd0NHWJlFKq7DgrI00MZPRFu9UNHt8EpScF8y9fKoGXKs6KqtRnYuBzG
	FbWOQiRcKRYVcqblr4AC0KQCeSJqI54oxJxe314b2tvxHrUCwzbmcMFTZhVyZyJaH2kd3HfObw+
	XrlRGvsNLEbprAgbR10f3rP5JFUAnj4qAbd+CSZBSxa+v/kjTL29JbWd08GAl6KJsnkdvnokr31
	1ON4KyGLV+oNyF8o9ygAmcDSBdTZR00obDdAf8nDjUKCHMRDqMdkpiLgBTt
X-Google-Smtp-Source: AGHT+IE3B73ELbUQavOS3+9V8O99ObkxGs1XUoqNSIUdKZBsD2NXFZZaX5rjgwqiz7ABPv8TjN+usn9RpujxaCi3agw=
X-Received: by 2002:a2e:bd89:0:b0:378:e097:e195 with SMTP id
 38308e7fff4ca-3790775a094mr3319331fa.33.1761603061549; Mon, 27 Oct 2025
 15:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-4-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-4-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:10:50 +0100
X-Gm-Features: AWmQ_bln6fs42YRtiqP8ik_NX7rcLNvMO96ITfFJr8FlYTKtoHQT9TbJlFukMl8
Message-ID: <CACRpkdZETuUGn47foo49xhj5krfE42sJ09vYf7EuKzm7J7kfUg@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] pinctrl: pinconf-generic: Add properties 'skew-delay-{in,out}put-ps'
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:27=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> Add the properties 'skew-delay-input-ps' and 'skew-delay-output-ps'
> to the generic parameters used for parsing DT files. This allows to
> specify the independent skew delay value for the two directions.
> This enables drivers that use the generic pin configuration to get
> the value passed through these new properties.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

Yours,
Linus Walleij

