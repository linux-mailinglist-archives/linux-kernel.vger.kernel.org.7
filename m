Return-Path: <linux-kernel+bounces-765029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE84B22AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037645A38DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289CF2F4A16;
	Tue, 12 Aug 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZsH+uVTQ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F632EA47C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008187; cv=none; b=r5GlPsfCCesll6s0GYGwtgo7YqvU41m3QNZELI5aqAx58rBEsaW0UQaLvOCwH/Z4c7gvlUaczFguvWzmGQAWBKTvlaV1fiGVn+q77G90E+wJ3g9DoevdfmFO0Am58XobfGnyW8AwZSXQpQAjtFct2ft1q6vONpod9VQEetqrl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008187; c=relaxed/simple;
	bh=R5nnZKtUiilDivRmsxMYOh+vKL6+puQDJ6xyxH4ExM8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Le14fUQ6N34/3yMeqgv94dTjcr7SEKTynHMSst1BF8J/V86a4Krz5DRnCqwTGmkWy0BgUvRXufxY+H2sgIMZkqbRTEv6qP0jO/TDAPYymQa72ZeP6vsKeuxDla1WBdyUIn2fv2bKff61hZS5kcP4pKZZxRhAdYrXi8XyuiASJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZsH+uVTQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b7454c6b0so6055035e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755008184; x=1755612984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5nnZKtUiilDivRmsxMYOh+vKL6+puQDJ6xyxH4ExM8=;
        b=ZsH+uVTQF/xLILlchoKK43ktOfavTvT+t6GYzbm9aQGMQuoDqOmXEL42L8oXTsLr8Y
         P+1qlPYEmobAdynkNr6mODxl7v5mTbjVHoVSGd4j9iquKqvuXpqzn+blRGO5M/jh/EVy
         T7heI2vFr43GdMIZCV2Ckqu3GzFSmYeYxh/vS+qtOHfcqc7T19aONqTBdBcM9RRBnPZE
         8/3i252m6cbPKnDgasYR80MWym8v7Z0aUKVM0F0rxaco37Jiz7vH2SaBWt4Qz3WKyAXh
         tNurhRTX7ozqTfKt6s2OUFNlE11kSlzye+3Kz6YeLHogZaS5m9rWnWx50Gl358uy8z/b
         OqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008184; x=1755612984;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5nnZKtUiilDivRmsxMYOh+vKL6+puQDJ6xyxH4ExM8=;
        b=S8A56aTvW+0KW/tvMMXWYpqsEwCEsx9Rbfa64bhtfWmoXheTWqmZnp5L3Rb0srcTb3
         BvSL8UlAbguK3poCLSVHnju1zmCPXhSdyhUKQWKYkMYxvEFMshdFj5x3CO8P66t9Os9t
         BOJC3TNzye00CqSBIsCufjc9ozEzqzxMnJiY09ttFkawYROsjss4rPpXjKOq5F84w7hX
         bVKT8y0/ZuBZMDnLG0ridwyVph7JgIFJ0zX+jNmqrAZWCtlNZiLlrO56KMA25LbeQa+p
         c22IPBK8vYfHetkFM3klO4GuqCXMYu/3/OZjk1mZ8FCxikbOtNRnf7snWrql78eGQTSY
         m0ag==
X-Gm-Message-State: AOJu0YyNtr/czmYYXV6dLE39U5+70Db7b5ctZgr8DGHCxPPsd/u68IkX
	lVVOoHX0WhPc6reu/JNNeaq+IbLDcmq6iaBsDN/aQKZMwKRC8b2KBl/B99SL+Kt0zOg6whwY+tp
	JorGpEV72s2PdsAoz4Bqf1/NldjprgjHg5ijONLgimg==
X-Gm-Gg: ASbGncuFN/Yg/tCXZjvw15KTr55rO09+9JiN5RZGVe912C1N0H4TSRA2yf6lx2uFQYs
	tSlR9t4L9bu05UUBJtqfQE/J2lsJvf6N4vLrzu9Shkl9li8sAGgII7fadTCnLDo3l6Zw5e1eAvl
	2PocHs9RlRWtIFQVc5by5tdp2pR1mLE3dn7AowWwB7ZUYtTyGCHYUDS2uXzOgU3PvG9Ap4244Za
	hAZ6jlOYPgGY/gXjaf9uBTepg/aSXDe6gGW
X-Google-Smtp-Source: AGHT+IFSWGaG+YAxuC5QAHmmbcboQlauIZZLZgo0OwDLSkIV0ywA07Ks+Bfh+bGhzN53ifgDGqSDL8YW+yRt/PdEog4=
X-Received: by 2002:a05:6512:1329:b0:553:2480:2309 with SMTP id
 2adb3069b0e04-55cd7581e05mr1175047e87.3.1755008183964; Tue, 12 Aug 2025
 07:16:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 10:16:23 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 10:16:23 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <f4d04d0c9d72d089af7490c6ce91bb4c455fbffd.1754996033.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754996033.git.christophe.leroy@csgroup.eu> <f4d04d0c9d72d089af7490c6ce91bb4c455fbffd.1754996033.git.christophe.leroy@csgroup.eu>
Date: Tue, 12 Aug 2025 10:16:23 -0400
X-Gm-Features: Ac12FXwr1ZykknKcViL5DSBC6TTWTpzY9rOvoc9OKAJoev5KLP9n85B_Vyoqws8
Message-ID: <CAMRc=Mc_MMwsiGybyMdY0T+QiRuZWFGEifxV4Kz7oqZaY_-kzg@mail.gmail.com>
Subject: Re: [PATCH 2/4] soc: fsl: qe: Change GPIO driver to a proper platform driver
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 13:02:52 +0200, Christophe Leroy
<christophe.leroy@csgroup.eu> said:
> In order to be able to add interrupts to the GPIOs, first change the
> QE GPIO driver to the proper platform driver in order to allow
> initialisation to be done in the right order, otherwise the GPIOs
> get added before the interrupts are registered.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

