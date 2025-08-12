Return-Path: <linux-kernel+bounces-764733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE5DB22694
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B152624EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD81519AC;
	Tue, 12 Aug 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mH2zg6im"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6BA930
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000909; cv=none; b=P2MoALEbVKXvE1CZpcBExs7pVxigxC8DcaPKDSJOhIuuJzvZem7NBpF8WliFOncHJmZdNfkLzIM2eeok9BEcvGCA4EM6j9CDeRi1UgSCj3fIQhrRbEieHGsJsqW4WxGpIFu7AwZ/1hr1meFphElF0knpGlwvj4+cCXvvpMUFZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000909; c=relaxed/simple;
	bh=i2sB+0qnCRMPqW1KShGcR8PsF4cV+J4Rx38KY04/XIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMwDTy3AJTmGwrGPH4QoKJCuQhFRqu+hsEinXhMBbfjF0xhbKnopY/uY3P6lols/DFIcoPUpAzdf+6ZpNQ9xC5UAiodKUH42GMlsApOzpoXgi09e4kLnF8b49dkmdNhhtsd94li/sCMDyttFhEvs62nJjUHJiV5muLAsgewIDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mH2zg6im; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2401b855980so39247765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000907; x=1755605707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2sB+0qnCRMPqW1KShGcR8PsF4cV+J4Rx38KY04/XIE=;
        b=mH2zg6imnTwealhirDV/4vMaQ3B0HQ1gGR0/LpDWos7NjXo+VrgJD5hKcGOfeuSeqO
         XbLyWd7pBfkz+mZZ3UUoClOdz383p+dquGuv5lnu51HjVLGVcawOkE3K1F9ra0l2cWH1
         n4eOJmeWmbON7oTAPtKvzeJoawON7ZPjzBnsbZK4D13xMq6alHfMYULaqLj2/GXkHUaG
         5qf5ECJdK+jx6jpTnFSR9BL6pdHbojBxOm8VpkFhwde9x3FSIP6xu4J0Rvh48DXKnkwb
         LM8/0nCbv4GXirXcpDhYhd3FTuv7xtZNB1rrB5U+gtNXeCIpwL0ePoEUr4VSwTYm/WLq
         ixXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000907; x=1755605707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2sB+0qnCRMPqW1KShGcR8PsF4cV+J4Rx38KY04/XIE=;
        b=ktnn0Vly7LHg2zXVL98BSyz4yJ+ZtFuN4vZLJoaW9uQIpeid1CmRXs2eg372ggHgiW
         YspX+P0dy68Ic5voUAmH5s4vs7SG6rEocxQ/6WaQAqIT+XDiOOCiSmG21rVVZmuA/Q3D
         zJW/X9LResbUWhcj+Sxr3V1HzH/GuPzmTaLgpyT8OFy3nGpZZ5SFHgbnu7YZHqnXnNls
         oDohOarDveUNoKgLUCEwvBsqpbF9Kqz1+bLCB53n0a2c2pajbhEDp0vGA4LkuWdgRD74
         DwMRlB0agf92nMUVUVx+d2cbCobxR/awdjz38PQNdLsdwP/loLubD7AWant1EElPJdOF
         +FWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/uzlTqgsGS3KcS9E6aATTEDAtIbcc8nVe0uG1OB0ok7c4iwcaUZunydvpfEnLtoD5J/KeS9CXn+Pbfms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBzp/fFf5WMl/7Y/h4z9+E+F7l9SWdzs5Dw4uJM59aH8qr+CV
	ZDootPK/uT8QR7fdT0kMNOwdBLSuImm5vOU6Z38HAcraLj0YPJTfDPMdd5M0JPV8fBcE2iCp8FQ
	LC/BpXW/O6BCR++MQAPJhWbotLvZc5c4NQw8n7ujCAg==
X-Gm-Gg: ASbGncvEPY8B6aYEPehRTvJQmF8o2rVV7nhWVM7Yab//lhi0c4702t44z4Z5Rg+b4Z9
	AfjyNlq3zbG3OzNwcobp3NsZt8k58RPVuaPLIsHN8Xuvz3nehsw4TY1GXcQoFHeqpVq4uoxa8ft
	na2kObyEgp8G+fxU8TFOFd0b7BeWIsMGdU3Nvj93kT0AFxXGkMbiZrJZJqb9BJJ7JE/Lq7lbimu
	8vE6RNO1k4FuvB4fT4D7VUxFmRLJ0HXweFa
X-Google-Smtp-Source: AGHT+IEzociZzudTWGhuGdHHssA6mcTMWmh60p7KNfXRPqNC0sHerO7a3+ET+ENTi1aHgD3VUTer3FIsMhpz3v4Tov8=
X-Received: by 2002:a17:903:2408:b0:234:914b:3841 with SMTP id
 d9443c01a7336-242fc340444mr49380405ad.39.1755000906805; Tue, 12 Aug 2025
 05:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:14:50 +0200
X-Gm-Features: Ac12FXxLWlDkhK2ok2zf7fTots4VGX5EbCJBNgP5nS_eF-e5_DRefiW9dEXgJdo
Message-ID: <CAMRc=Mfwz7yD0rUKw+n8eOczrg6E0n=bPJ+ng32D=r-rUgp4TQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/14] gpio: replace legacy bgpio_init() with its
 modernized alternative
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Hoan Tran <hoan@os.amperecomputing.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 2:12=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> I hit a network error when sending for the first one, retrying now.
>
> This is the first round of GPIO driver conversions to using the
> modernized variant of the gpio-mmio API.
>
> While at it: sprinkle in some additional tweaks and refactoring.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

FYI: This is the correct thread for reviews, I was finally able to
send out the patches.

Bart

