Return-Path: <linux-kernel+bounces-895180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4B4C4D2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFC63B3327
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBA13502BC;
	Tue, 11 Nov 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoAMdZ4G"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A734F265
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857833; cv=none; b=lcrnCecyXeifrhy0xRb6LHN5fVEqFig/DtZ1MUPkz8QVdCnA7/lo0M425Pw1PN069zd0mqQY+joiEwLSzLaKAZtmi/gpqhscDIOeBDW5N4YlXBYPG3LRlU+hlouZvbKtnmqoEQ1j66dxFfjw616N3qXrPRlhLi+bvHq3pE1qhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857833; c=relaxed/simple;
	bh=SskqgXLt/V1yNmdj79sn9yutCDT6ypSkI+cVjqdA3Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI5YZ3ibyQ7GI9FBGkWweCQRutHEXSq79ssYOje2nQfP6re47+fvSlRGIUeeZCfnilvtBv58boLR1MGF5FDf+KaWuJI1c/fj3qBLMZpRz1i8KrzpznfXo8hIXgU8H4x1V4uU3gvHsN+HuXt15o5USSMr09e5KH6SbNni646dxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aoAMdZ4G; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-786943affbaso30674057b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857830; x=1763462630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SskqgXLt/V1yNmdj79sn9yutCDT6ypSkI+cVjqdA3Ec=;
        b=aoAMdZ4GDsVZXOdtQdFRhrMS2K3fyqxHTQL4UBooKSpJdPhUgkBSNYsJV6WvoT51D7
         cyxRV9vXmiA5tj54QvVnCyMyzWGqR/Hjv/oXFkTmuUVpTb0BMJWt0qQXel/hVwMDraIP
         QaAo9b+LpZvYzkZCipeF0l6LxqvcGbwbkel0tt3liCnkLeUzc1LUySbp/ITGRYfcelwL
         Mat6DeVw7O1sck6zgrNz3B+T3pEOuxgkdY6h7KZgTMtNLszAf0bFk1mLgZcYHsI+S0QS
         ZMjtGjd7B3q8FV/rN3oVtqMgYclaZCMKN6h6TrSmcZLcCOG2Pju2JP5lxRq6IngdETGg
         SYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857830; x=1763462630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SskqgXLt/V1yNmdj79sn9yutCDT6ypSkI+cVjqdA3Ec=;
        b=mumtj7PEdsglbFechaVDtcLY0iYJJRxje3KcFL4xPtH3LXpODaDvMbjBd1BdcHNUS2
         LxT7vYaE6XipMlbkyr1TqpK/Wq2licxIIjo7SQe/E+jCbJjUZp0yFlELpPwAnz2l/FS0
         XPyuFHzzFXz0Cl9xWKmP8WC6leGOtS34M3N1zv/W2H9+yr4I6KeDR2wXasP+mGSM7LRE
         n2vXGY6/jBh3SRqFbREzbcaAWpfp7DF5Wha7iDljihq2IPSstvnV/VZC5Ts8LcHvzVNb
         AvBDHyQxW6TViQGoUOsexDq2iMO206/HT4iuJye3qrYVJiCdZKllsgMmUxQBVO+EHj8p
         m+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfW7rY6FPGDM5dgJj65C3pPmCBTWQTp/uFn0HXQfAOvxj+d5u0abGy4cD+hG72JcYICiw5civzbJGT/wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ADmtosl5/Cxwr3SSwN6AFWDgoHeO8LI1+r1yV36vkRfUqfI+
	khqiGoqg1yiP86m4pjVUDnrMplwXVL6gUyN8CL/J5yXluMdW29PQKN55XYInEVxAzR8ZaPV0KZn
	LrSqAkVoUCkf0J+h8PR7y97gyim7fGKMSGTJjCPnIHg==
X-Gm-Gg: ASbGncvLrbCQH8owuCL+nrZbgqxStqgzO9qrQBZ55N5mf1Hex/t3t/0TWLls8ssd5UM
	f6NYETFh1J4ixivUlgKG/brAIoRtqFyT6lBffw3WNZXZzKCA/fXpfJfXvUJAbWcloUOAa3I8JOb
	q+x6A9oaoEf3am9fuudqhA2UKN2CfxLwwz2nJzloQu5FGMhnzfMzHGThxelEKLVLVUp8ir/mRkI
	jPoMk0TfylNgKzNRS506b3iYc0lsGeWlK++waDcYhmONM/09ngKVfwpqO9Y7wqGZ5HWnhU=
X-Google-Smtp-Source: AGHT+IEi46gFe2Gc58dgZGHKXPtg9MeZZjbfraM5Zhb8zF1ao1O9DUHuINeceNpyj8ML6p+v/cNPJjLoRvHJIEr4ZNE=
X-Received: by 2002:a05:690c:3505:b0:786:9774:a3d2 with SMTP id
 00721157ae682-787d5470c8emr109020077b3.69.1762857829792; Tue, 11 Nov 2025
 02:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org> <20251029-gpio-shared-v3-5-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-5-71c568acf47c@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:43:36 +0100
X-Gm-Features: AWmQ_bmyzwb3DdThSflgKKoxHLLAiD3IBdKLnNpObGkxmw37AFoyfkH61KGqKvo
Message-ID: <CACRpkdazzchuetece8WOJ+0D002HXhUvK6d47JmyeAauopoZXw@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] gpiolib: support shared GPIOs in core subsystem code
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> As the final step in adding official support for shared GPIOs, enable
> the previously added elements in core GPIO subsystem code. Set-up shared
> GPIOs when adding a GPIO chip, tear it down on removal and check if a
> GPIO descriptor looked up during the firmware-node stage is shared and
> fall-back to machine lookup in this case.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

