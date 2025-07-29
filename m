Return-Path: <linux-kernel+bounces-748978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376CB14854
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1361AA12DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9930725A328;
	Tue, 29 Jul 2025 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cgsQpUae"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B638256C83
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771056; cv=none; b=FVKMssoO7llYdVmpv7i2Dnz8lMcwZ2AEXyica1cs2LE2UIbnW7fIgjvMSXAxtbH845cLNIvi8jBgwAk6opvXOdejS/n9RwMDwSB3O6TmLuta1zIPMVUvBjnKIWoqCdDj/VbkG59oAOwe2JaEAnJoty8Xx0CDrWaO+v1mqYHONUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771056; c=relaxed/simple;
	bh=+en2KZk0Ak4P22RG3nat1iP/euaYfhY+2DXhR/dGRRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvSNQGMOo81MC1+wI4RYbq0y93/n4LGCuNoh2TAB2yOV6Eze4cEYn2PMtux/HqFZYDdU/2DY8DJ2ADKWPiRSdixmKEf990ydVJwzhc5pDpLBKgJv/xG1zcNi0zRbFp2F1MD+GzSj6Pm+PSZExwakEn1Tb8WzEYINvWAz6bXuvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cgsQpUae; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55b72633aaeso1201886e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753771052; x=1754375852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdQC/K3LIKSscNRyk8T2PgRCFaUQc02f6qftAleHQdI=;
        b=cgsQpUaekWkmSVOdseWqRCVXFi+ffbsljaMZYm8Wd93Ojq5OKjs+mPthXo9jLfNhYq
         JT2anshYfhZ4jhYhVb5y41HbovuHBLGTpVJali2eQNx6JJ7iOxG62jPor6hty+tmRICE
         T+/xGuX+swyACCFT1M9UtnMhFgZbxRucEs4Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753771052; x=1754375852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdQC/K3LIKSscNRyk8T2PgRCFaUQc02f6qftAleHQdI=;
        b=kqorB8qx5OrWimVYGeF6eIQjzpwmZCm/vFe+ut86xhSRjwhn5qinkcsfbBdhjo1HAF
         KOtIhZA+FnbqIY81tprvJDqNy0+6UWVQ8YwYoT+1sU3JiqAT4VVV/P03LtiYPGk6mVIy
         IYzeLrLHmRY/KVIiFI6eKJTcHeK9jLWWwwtvwuxvvoH1uhH01GD+DCGFMVbRWbKjj/uP
         KjrO3PaNgdwjiUu0pxuIqXy2d0xwDNYNzEClDVqZeN0urpi6SqY3wjSXyMvDx/Xiin5f
         GtlWBwZXk77tq7r0osO93Xjl0I3wU7am2SUMt9eXSwX8RdL9qdYGTgUmLdpDT847f2RT
         UUJg==
X-Forwarded-Encrypted: i=1; AJvYcCVHhg5TSEf5fxzrw76qK75IKEHl6hKEOAP6d7wArrKnk4HGZBcKJGfv8mL6EU84l3WSEkenydTmyNUWJtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD0BRkehLXugEtdkNp3avFuhmMrs7ZdABAVSmLU8Xhr9KGyBaT
	QjGifCyzEaOiGHrRZ6Q9m1g9YZ6sCYbzZjpeoCjQnsUfy051XfKhct7o7Nex0H4PjHeAgep55+D
	395XMptcJzoaicxw0ZeUqyS8sWVyyYzDzBxdKbJOR
X-Gm-Gg: ASbGnctCLsK1N3jTm1lGqAjO3EvfyxaLzP8/8CZz4jUDbVi4C1dqyEB0M9faWXW9qRh
	Wbli/001QSVzeKoZW/KoftlE2Sn9aUzToENYlkFEdC09KruaeImA1Wfu/fuIzdwyOeQz9jxAsUR
	H8WQXaNRzoSFTo/VcTSva15eI9OWsome4y87fNcl0PJwyFN+iDqRLl0nMl1aihMaiknWH0IWZ36
	D7EXRXM5rKZE+SGwTyt0fDsQcPoJyLKMSEteZghdI6t
X-Google-Smtp-Source: AGHT+IEgvlc297To6fHbXdTZorsH91fq0QGaKclycxBL1IjMJRB888ehZGOrD1mGdyChv8MiWaDPZvyajrhgWyt/Rok=
X-Received: by 2002:a05:6512:3c84:b0:55b:57e8:16c4 with SMTP id
 2adb3069b0e04-55b5f4abb78mr3766968e87.30.1753771052463; Mon, 28 Jul 2025
 23:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-mtk-hdmi-v1-1-4ff945eb6136@chromium.org>
In-Reply-To: <20250723-mtk-hdmi-v1-1-4ff945eb6136@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 29 Jul 2025 14:37:21 +0800
X-Gm-Features: Ac12FXzoxBPnyvKXGXlu3ix-9ADJidAZNN4VQPkrQrPMR3ZfP3Di7o5rHnp5ZrM
Message-ID: <CAGXv+5HCnAXoPJmh4ewSF4ay=qRVM_BK0w17yvjbx9efktXX_A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: Use SND_JACK_AVOUT for HDMI/DP jacks
To: Terry Cheong <htcheong@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Baili Deng <bailideng@google.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 5:44=E2=80=AFPM Terry Cheong <htcheong@chromium.org=
> wrote:
>
> The SND_JACK_AVOUT is a more specific jack type for HDMI and DisplayPort.
> Updatae the MediaTek drivers to use such jack type, allowing system to

       ^ typo

> determine the device type based on jack event.
>
> Signed-off-by: Terry Cheong <htcheong@chromium.org>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

