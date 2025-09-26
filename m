Return-Path: <linux-kernel+bounces-834152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF63DBA40A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF4A1C00A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80212F83B5;
	Fri, 26 Sep 2025 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAJ0dtTt"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132F199E94
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895635; cv=none; b=e2g9cEYrzEZssZBqlwJGH2CdTiXXzK31XiUmmRzbyU5xzQTTygOLHCc5g8U4n7Bi2wyOGZUpjf58c04euhfOGL4RQ7cmk3Mo+h+7TxzihP8+zQhICRRNEuHP8pVIURS+HzUvcEVWCFUqoHyu2IRUch0B3MNYwbOOPM7Meaue/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895635; c=relaxed/simple;
	bh=StcU61O7Bduu+n3ctrkb4ORbTcaBshXBtfrgjHAaeAE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VMXmXO/4vpn8OcoMQgKgtmhJLY7AJ7YKXOd198HsZbXv1P70dG6ThSvTC31+0vD6ESsEF+nNyBE5udNmWhH3OcR/qRozhH20PriRMlWlyXk+s3YnM1jukImrYlQVapAV5caCWAFC3I0yYbquBR1aksON0RW+fbvF2wc9RiOsR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAJ0dtTt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso374261cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758895632; x=1759500432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=StcU61O7Bduu+n3ctrkb4ORbTcaBshXBtfrgjHAaeAE=;
        b=ZAJ0dtTt/DoEjhB/gnNs2GMHkfGinLNE0JCs/CvlqYEMmh/T4Q4Y4p2V1H3fc8DabW
         r/RHeBeEXvoHm7MxTWyP3br3vygAqnCmtZlzCroFZ0R8Cp3xxawP3GzDs6djhs+Z+Ywm
         JcgtTfq5FfbYm1ENEiXG9LAAuRbwEEwgLhn2/qhv1Ix0As3c6esyoPkJE48ryzXj1G0M
         kK90UMaRDcZEU4fVv2G1wEdxZfhqYjb9PG22arVmckTqMEdVn1kH3evAdc8gr74imY7B
         ZBPi1tZ4BahR+dR2VC8QL6kxgiiuYXwng0cco2mA4nVZjvyBuhpYIKKGNbQO+mQpryYV
         eKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758895632; x=1759500432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StcU61O7Bduu+n3ctrkb4ORbTcaBshXBtfrgjHAaeAE=;
        b=AbcjGoAI17Dr2fu5cC9ZNXfCHhzjpn/SrOe+5LdDgP8qIjscenJ8PJjYsMIkRTxjhh
         jV77tEDpqmegI6aUANvR0PhezjXcazJwW1BIgEsNvTJROJmKLrkCznUXsAe6RXtRIqeG
         0yIQyyIW38/2LHiIM2xQUA4jXGJqLAdZHZNI2L0mkIE9sJMrAu0kykmkHM+UcQfC5Aqz
         urfq03b/iU93fQrYM70nL17gC0oxTiXKJ3T+BKPV9YV4ONZ5JIfxBZXg6zqyXFo75lbp
         hstgeWiU3u5hDnmQLqDuC4WAiCSBgHTPM/jx6nBcR962ekjCr6Kx/l+J+xpKwtBZ2aEj
         hIqA==
X-Forwarded-Encrypted: i=1; AJvYcCWbmcaO0JzDOMBdcOg6losmi4yf9H4oA9/+peMo53TBcOXkIJBuzFvCcsQuQSBhWdILCsigv9yVrRPzWPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfTtr84dZID+liy6cW1NDkSD26VsSPBWcARSI9x8UR/h5WMFx
	qECpT0moZU2Ub8aBTM5+7aGECvo/TRrhPP/DPc53cmvl1SpWu/Amoqg/2/QnKkPfc05ifZ0lPUv
	7JxJTxRUawIl4hA5+sdRgQbXntKv5jD4xzzCrhWFm
X-Gm-Gg: ASbGnctafK369F3o29fen4RQP11AJwaaUai4UZ7IFX4t/0FeiM9AFSUcSmb/sfdHuAi
	q0qPU+08/GZpTCrZp4gvIRqt0J5qixsTbYib4f0oRUJji4xIBwflUNmuLoeq9YiKf430B/cDq83
	XssaCnRE+ymoW2xyjjvPMUNU+WDJyaipgXPYqOsXgC2fd2IVrO82WhQiJWLPnCJrnEk2+rliDzD
	oesBsTmt2V9gupv5jsOFA0H4CY0zOU3EGbduXuO
X-Google-Smtp-Source: AGHT+IG58XmVVP4JYJU1AfrUfvapvQBotoDRlseFBHxJw51RyRcpKv6Ocibos4E3WKcK0v3GK2U8+crTo++BhUDtQrU=
X-Received: by 2002:ac8:5754:0:b0:4b6:2d44:13c4 with SMTP id
 d75a77b69052e-4dd1814d82dmr5668941cf.10.1758895631929; Fri, 26 Sep 2025
 07:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mostafa Saleh <smostafa@google.com>
Date: Fri, 26 Sep 2025 15:07:00 +0100
X-Gm-Features: AS18NWDXUhX2c5Ql_neW8IBl1rstnr2mdAIs4XtgEZx5rukS5nC-KjFNy7VgTYk
Message-ID: <CAFgf54oYjUEg9KkQUzneYTZH1Z8cX56va5M0853eWPFaYT+Z2A@mail.gmail.com>
Subject: Support for Rock PI-4b
To: devicetree@vger.kernel.org, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, 
	open list <linux-kernel@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to run Linux[1] on my Rock PI-4b, which I see is supported in
the kernel in =E2=80=9Crk3399-rock-pi-4b.dts=E2=80=9D.

However, compiling =E2=80=9Cdefconfig=E2=80=9D (ARM64) and flashing my Imag=
e doesn=E2=80=99t
work,
It just hangs before any console (even with earlycon), I tried to also use
some of the vendor configs with no luck.
I did some research and found that [2], which indicates that the upstream
support has been broken for some years?

Has anyone tried to flash a recent kernel successfully on it? or any
tips are greatly appreciated.
Otherwise, maybe it can be removed to avoid misleading other developers
(I got this board to do some upstream kernel development on)

[1] base: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
[2] https://wiki.radxa.com/Rockpi4/dev/kernel-mainline

Thanks,
Mostafa

