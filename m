Return-Path: <linux-kernel+bounces-775571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3DB2C0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80803A77FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3B32BF5D;
	Tue, 19 Aug 2025 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1hMEJr6"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82C32BF4B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603472; cv=none; b=F47FiklFJZlpVnHUb9rO1o4c8hBqV4NJaaZH4o2gysKU4tFyxpntbyhDIwJVCvKfcKRCyUxvvoTzrUuvnYZ6s6Q56s7+IElY5NgcFyhacJNnRd1E7g9PAaCG06XKhvS7f29u1d8I0yDFAg4eKuqfq1K2ZGRlmBHF01/CdB7VCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603472; c=relaxed/simple;
	bh=7/eMLKrcLUdl9Xqj8DrJf/+zOwRJvD6WS4ChYsUSVM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FM0BnbZkEFPN1gJahBSjbpNr5Ts/3h4l3a26dA0fNZnwzJo0NuX/iC5nAkzXJZ9RTvYo3dYeXg2u0joh6kgu/PZq+1aFB2uU/7oZhpW6SBKpo74i9gYd1ANJFbqMZRA7gvtv3b8c0/Amu/DPTgTBNrIB/bDqVjQH7QKmMVZLo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1hMEJr6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f918d71eso36492441fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755603469; x=1756208269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/eMLKrcLUdl9Xqj8DrJf/+zOwRJvD6WS4ChYsUSVM4=;
        b=K1hMEJr6mnoK24g7g4Pzp4lv/5KQzrZYnAw2L5xw9RbGKVjfKRv5eCdiq6R0ne3DsC
         NfeFhKhn4Xu8XgEY/t4I+ZepDtEUoaXpeh3r56tog89rlK1GQfTgnIRDyxTUsqVM11Qc
         92hX7Uy+W+yXYU0kFVAv7mjhnh7bHbSAt7QLBZY8x4iXJ3UUl90WW6KQqVaC7ygZFEBO
         GuhZsMWlxZXCDNtlu63BhuVskhMlZ1ifsLQb5v2Aixu1PgyltJBdcZ2ShtvYC8yZxxoS
         diRD0MhSdfZXIZSC9Pdp6ZcuYQ1AIEWjnFWoj2w7o+FC6Cu4cQhdk1xykOIOYEvUdn0y
         6Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603469; x=1756208269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/eMLKrcLUdl9Xqj8DrJf/+zOwRJvD6WS4ChYsUSVM4=;
        b=IipJknUFKL3paCtaQEZcU8cxrsugW0bMO2A7aU6K0JVbFSbcqRHJliMmY4+BuQlsHL
         lbm17LmVqTIAbI/Bk/DwAPEQGBWmLXamzuCyli4cn2XQW34uUo3T2gO5GOuPytlYS0KO
         OVWZi5LMqCvthIUI+CRaW4oJqSxfioUu9wiLN3DK/r1Sd7U5tCT4DvMJukihRyWMX+uH
         8fA7Qh2ESg6hvsYAZFgBIGXgW/amOJ7fXfqfqgJQNfnqJLC/hDWti61ZMZb2BFp21R/P
         8h5fUmXqGgx8Avtv0BZCPDqS2O+lwNTM7tla0zZRDnNOo13Bd7+p87tGDBzyF16hekLj
         SYoA==
X-Forwarded-Encrypted: i=1; AJvYcCX0OokP9yVUV6x6/97JBzp0Sg3MUn7E3DzmULI6iqQNuQ46UGorVrgGguhtw4y29Vn9/4+VKNCVkkri6xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpM8Rm/HcoQZeNzVhzsXwFm4NuqIGTMMEB75Fo6UDXGLPf7DwM
	7+VDvrVZZexXC86AJ6Z2zp3Ju6XSsnS5kEd9s+6pZfBlGas8PX5vtEv4qssq4aFu/yerTygB5ZN
	ZIZyHU3BCtW/7rjJGQHZdGUGp5jaMoAGeDGJ8YZf1jA==
X-Gm-Gg: ASbGncsAECMXwNv6g7BWaXpA/FOBNDpT44JMgh3JU1B/BE6POo393TruGU/lQUijCY8
	1dva12/yiY6BwRBTumf50XFsauo1sdPz9KEQtf1U4V83j8lwUzJ7sJoynbKCcEee98ju+9ruKZC
	BVI3t6lt5tGE+cnE2k5QZDOI6WMaoLWxlUFhrvw27HsJQJvSea0sxZIn7eE7DNZb/Yl4rJs0M7j
	xSr9MDa2e5ZzNpvlg==
X-Google-Smtp-Source: AGHT+IGOB/HBfYtwdx1tJSfnd8ogKz3lNpvmqr3yKeR29sGeAn5Fs3JN7fK6f/qBLlHS0Ep8kse5cDTuwOrTh6QvnCQ=
X-Received: by 2002:a05:651c:4005:b0:332:6e0b:fe44 with SMTP id
 38308e7fff4ca-335305d3610mr2718781fa.18.1755603468583; Tue, 19 Aug 2025
 04:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812075444.8310-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250812075444.8310-1-liaoyuanhong@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 13:37:37 +0200
X-Gm-Features: Ac12FXyEWFfBEH_uQgjtsUivAwONC_9h6X_7ZZWepm2Dd3tyjJOIzZHnZxTHxdo
Message-ID: <CACRpkdZALwxz_Unmi15zi1XCody8CjrKKXauQNWB_RTOQnGE7A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: equilibrium: Remove redundant semicolons
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rahul Tanwar <rahul.tanwar@linux.intel.com>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 9:54=E2=80=AFAM Liao Yuanhong <liaoyuanhong@vivo.co=
m> wrote:

> Remove unnecessary semicolons.
>
> Fixes: 1948d5c51dba4 ("pinctrl: Add pinmux & GPIO controller driver for a=
 new SoC")
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Patch applied as nonurgent fix, modified to keep as blank
line as suggested by Andy while applying.

Yours,
Linus Walleij

