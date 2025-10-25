Return-Path: <linux-kernel+bounces-869950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4CC09180
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 806444E2314
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6F12FDC2C;
	Sat, 25 Oct 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtNJdJRG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1D154BF5
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761401575; cv=none; b=JuKo6B+CNI75Db5Dqd9xJGjNGfI5zoQucH2G1ot8BgS1UbU0ok5mG+l23M2qZWyAQDadw1DKRX4tyMVkUFCGVSAsbVoShnN/h1tVVKCJN1HnlUVXR3BT2e0RHx53CCwtz327ECFtneD5AofpUvQI+dlj57kwR0My7MQD8WnheYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761401575; c=relaxed/simple;
	bh=1uBMmtCh/viplQefOR9TqmDhRgZDm4IZ2AI4MnuTSUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FltAcPRUxqyBoBjuQTGPvXCr51wNiwGyWDa4b6EL13Tcg480zI7yDlBETZh/ywmpaLN3TsfK2b7bE3ndlH+lxCwxXj5yGC577MMj29/kS98YavYaqlLJVq6ft7moMxDIPhJv35acxILuZBFbmQxJhMlIvhFO/rpVxEmeqP+7pdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtNJdJRG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29490944023so14370225ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761401573; x=1762006373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uBMmtCh/viplQefOR9TqmDhRgZDm4IZ2AI4MnuTSUY=;
        b=WtNJdJRGhJhKY9eTX9WQhJaLclB+OAy8kga1rMjP9XQs+9yVhu+2klNSjuqIciREFI
         yEugC81YPggsqau70moopF/ab0RGZfYfj74QWEm/68mpvRT+cEyCuekeAjV3EOS1mjkr
         3HpACcDZV14AWDOouOkPW5DYIz1yN9CwyAPZPHW/JwvXi6JOaB6zDNGWhQ0XEGpJ+K+h
         CgX2MiBur0DIBDFQLF5ufs8HDOHCWX/MMQ90MYlGGX16N19SPPEQB6dpboFhWEVgeEl9
         zFd6hAIoQIuOq/SK+PhDge75FvlKgRsZnQ25RoGtxWMCMZdBPaYODVpqU3LrnifVM38n
         GkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761401573; x=1762006373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uBMmtCh/viplQefOR9TqmDhRgZDm4IZ2AI4MnuTSUY=;
        b=box5+FG0/PMHz1IKd69v+8CdKb1Et2VhzXuiphSHZNXPYLLAnoEOqrhUdH2LkvwR+K
         UIfH90wgN2z9ggqcy8IkBerwzuXnxcl+X3YeDcMzHSlpTgzaWT1mJYhpbg8fFrKJX4t1
         lxYmvBsRk7FV4KNB53Hb9aN9cmn9J9sSi9XLj1+xwwNTpzD0ZkJCCW9/QQRAv05cPRe7
         im3EH+nwJrX1wj4SSUbw8ydudhXmLaI/joQ0MTDoG7lYqnWNlarWofIKcehXW5M6RsSD
         fuHozhH+EJU0keYpNShzyfHAxrRCEioYRM4RL6tsyxlFCP6ajs5dZZaNt+JQmX2u4zAL
         riGA==
X-Forwarded-Encrypted: i=1; AJvYcCXCEuupkea8oUvbwE1W/hKZy8f+G/wcax7bxFo0fJbzoMeUV13g2NOymlwHA70vknrKRXFvoLbcx0u2AHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTiboXCuseJxWfdCmwi48spslG4U5jzi2kxwpwxttRZSpXDZi
	wufM69ocCULOpg/GWmkwQ0AWRG5LTGUqC/rkHnSDN6LCk6wX8vLMfBR/oM0yYWGsTYAGn+ZLaRe
	+kXBGxxYI4t6JO4t2CU3wH5Vc2jskDac=
X-Gm-Gg: ASbGncvFk1XHMx/XoDK8VUlmWS3Ra3nJZfteE/NI49vfrE9EtPveclntcI8w1syEdy3
	guvcBx0zvNh81gwhBscLTs/M3o0X8gMApm1+5n6MjzK77yCeIsgdqZocom2DPDQG/Ktp0cRk+sC
	8S5VKNfYU9tKJVriLLGn812Su1HpdyUdgftNdsmPCBAupuO2+Dqgsaa6hrfQkA81E2FVREzlPID
	lNGqBIrkqvFZ5uLCBKimdcWqOyg47Uu4mgC6wb7EwNYZcWKMfoXnixamUsa
X-Google-Smtp-Source: AGHT+IHWBcBT1UJnsX1+ArqbRdHy3UbLUVR8NxUERGbtq9s9Z1BL9aKulgmICq4Bc2myVg4Yr88PTHuecN6P/fiuIp4=
X-Received: by 2002:a17:902:d544:b0:261:6d61:f28d with SMTP id
 d9443c01a7336-290cc9bf243mr398462235ad.50.1761401573179; Sat, 25 Oct 2025
 07:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025102008.253566-1-kriish.sharma2006@gmail.com> <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com>
In-Reply-To: <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Sat, 25 Oct 2025 19:42:41 +0530
X-Gm-Features: AWmQ_bnWn9FhlmpJBIgkveJcUc9siDTgKElhxu1c1ixI1RBDlVYzhMcYHK45t7s
Message-ID: <CAL4kbRPy67Vkq1A_H_E=B99+M-09s7xWMYHCMPYFaCG0nMWWnA@mail.gmail.com>
Subject: Re: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 7:05=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> Is this the only issue with the kernel-doc? Can you run manually
> scripts/kernel-doc against this file (with -Wall) and check, please?
> The change itself is okay, FWIW,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Hi Andy,

Thanks for the review!
Looks like I missed another warning in the latest linux-next:
Warning: drivers/iio/industrialio-backend.c:1069 No description found
for return value of 'iio_backend_get_priv'
I can send another patch to address this if you=E2=80=99d like.

Best regards,
Kriish

