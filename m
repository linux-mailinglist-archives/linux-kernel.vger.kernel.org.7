Return-Path: <linux-kernel+bounces-811195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D0B525BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9531C80A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6071E3DCF;
	Thu, 11 Sep 2025 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQXY/4FT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F48634A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554148; cv=none; b=hNOBJy7Yk1n4n4dnCzyVwFC504R4NgOrzJDOkATbAnV8oSzWCLvFmDzHYDUuMdZpsNZGdN7WOvwWUE6Gji2DsFbj3X/uE33NtZl0/2i327pZILnFW/D9SYCHFymy0k2PW2ENfm76ejOlGCea/wyJZqwrSrOWsH6FxUlwG1MX3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554148; c=relaxed/simple;
	bh=pbx9CJKc7axWAeDhhMzHI08am0iyRkygI0vfKsokbPU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=tP26zZkaNFBNAj3xTXHCKfisQlYwlkIg8zztBh0tdEUCT3vW6/p4KNNv3flzDoOekeAkjujGesyYYm9Q8z8VgRIyOORfYPVR8EkioC6HOG5VnH5oPXDW0I84ZPQcM5fLCXtAWN1Jzy3WoH8NEFj1BmQLycK0yZ+7OzE7+Fgnu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQXY/4FT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so1654785e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757554143; x=1758158943; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHYUQTMOk4dJ87X5RQiMHCWDgvXiiQtLLT2XJqAjiYc=;
        b=CQXY/4FTERuyHPJDONGTYbglxequOCl3GyQgJ/cSLiXHzN5JOiTZgs6tsjNOEri9yA
         uN25JcRcy8nz6uPwxRcn3J2fthUYomHJMGiSHst6PTOwKu9v65g+zy0nJIjmF+fO5dVE
         3WcNnzueoxsZeiyEnia7YZPIJ24vVdf0NmD8f1ynNXeMyxa/2WYjsk9nPx9jwU0uYoOY
         wFJb9k+nbyj6IDRYF22Aj6KNowtyT3Og22uIArzvFk9bBlxFaXj4an4bqD8KiwVkUSOa
         StXGKtp6YHMEE6nF7mPCezZ8ZDPSuNRKitD+F0TW769X9D6cwerytrfQXHT+VEqnyFRf
         doFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757554143; x=1758158943;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jHYUQTMOk4dJ87X5RQiMHCWDgvXiiQtLLT2XJqAjiYc=;
        b=MFDfHu85E4T4hC/Lui5A9ACOGMYKgkOGHjdDEXfhiWaqYeqbvU4DfM2FnUMCiYivQ6
         kIJLLBp/+AprXQbjr8kfKdkBYy9a/lPaoOw1wbjYcXvBYbXvOt/xPh/bFDuUMXLs8k7C
         HeGoVuJeuavrmgauDCvSpLgNgtDMpG30vKSw0UzwDmydFw8aPp8lvDvFWV6XqtrVf0bR
         qewSYtHYrsj4qN0LKfRIjzcvyNLatiDEkiJIJHCDMHhVzvYo8u+dUE26emQQxddTzdek
         lnHK9556QW8EgY+NZmyIq1enFn0ay6vkE1eJ4GkwxZ6Fdir/9C2pCR1fEkirHsTCXu0L
         s8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9hsgr4g9QZKmLpioVk7Js/Zsi+WmNsS0Ve8sKAhXKzwR0eEcsX27lqFWD25KTlEnzU4OPKXCwoLUfel0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziiRzJg74G/SoXlaoSd3OJzgznbiKs7c8c4GZkJPTMNKytRDwL
	ncHaBeF8PwusyghSAMJodiSzy5Vg/Cy5zM7hMlqQnorJkdJJKQ9vzTWidRqrwCmqWTw=
X-Gm-Gg: ASbGnctA9ZcGQ+nl1bvXoAhuziQxY9nQ3SYfN/JVoo4b6VUDUMnipCt2YoKUtmm5+bH
	4iSezaUuWXTcJ6+lGfETvdWakb+4NFkU+MVzlZP7EikJBoNw8R3Z10Q0E2bt0BfhQQgS8cFI5FF
	JdpdKxWp6F5b3owRe8SiDS/vNEtn4zW2hu2G1/lyMXX43C5TDdTcOHdkm/l/Fxrn/jp8s6r8zT6
	X/2LpcoIuZurZ9iL9quOnepa9AeonsNfkQMVny8lpjmmw5p9JthN8CsrrZ1/4scgTAdvCH0ujHa
	z5W/kZk/EdrNcnB40n3Llxaiet2KZqOUvoemJYmfBGKkWLKWKtVQ0ACeqbwFi9GjSraXP617cra
	fvBsE0LCaLa5USLTWrpaGDQw0Md0=
X-Google-Smtp-Source: AGHT+IHN9v4zGixZCD8v12S2CL9xgTL8XJHDo1lrrR0rUDFompRjHV21wwHe9bU6LTLmvxJxRTsOMQ==
X-Received: by 2002:a05:600c:c3cf:b0:45b:8b95:7119 with SMTP id 5b1f17b1804b1-45dfd5c0dc5mr7309475e9.8.1757554143119;
        Wed, 10 Sep 2025 18:29:03 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:a727:6a46:52e3:cac2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037b9ebbsm3680935e9.11.2025.09.10.18.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 18:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 02:29:02 +0100
Message-Id: <DCPKY2GED44G.I2DSV6ZBXYAQ@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: lpass-wsa-macro: Fix speaker quality
 distortion
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Srinivas
 Kandagatla" <srini@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Mark Brown" <broonie@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20250831151401.30897-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250831151401.30897-2-krzysztof.kozlowski@linaro.org>

On Sun Aug 31, 2025 at 4:14 PM BST, Krzysztof Kozlowski wrote:
> Commit bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused
> AIF_INVALID first DAI identifier") removed first entry in enum with DAI
> identifiers, because it looked unused.  Turns out that there is a
> relation between DAI ID and "WSA RX0 Mux"-like kcontrols (which use
> "rx_mux_text" array).  That "rx_mux_text" array used first three entries
> of DAI IDs enum, with value '0' being invalid.
>
> The value passed tp "WSA RX0 Mux"-like kcontrols was used as DAI ID and
> set to configure active channel count and mask, which are arrays indexed
> by DAI ID.
>
> After removal of first AIF_INVALID DAI identifier, this kcontrol was
> updating wrong entries in active channel count and mask arrays which was
> visible in reduced quality (distortions) during speaker playback on
> several boards like Lenovo T14s laptop and Qualcomm SM8550-based boards.
>
> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> Fixes: bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused AIF_INVALID first =
DAI identifier")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Reported via IRC.
> Fix for current v6.17-RC cycle.
>
> I will be investigating rest of lpass macro codecs a bit later.

Any updates on other lpass macro codecs? Is something still broken there
or are they fine? So I guess the changes for wsa and rx macro were applied.
va, tx?

FWIW, I understand that I am late to the party but I tested this one anyway
on sm8550 and it seems to fix the distorted sound and unstable volume.
Sorry for delay. Just confirming.

Thank you,
Alexey


