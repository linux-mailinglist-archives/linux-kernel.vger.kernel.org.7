Return-Path: <linux-kernel+bounces-893178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C388C46B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5FE3BF6EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AEC30FF3A;
	Mon, 10 Nov 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHAuyUbP"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309430F946
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779185; cv=none; b=ix1N0ri70WiQLeJfu3iQaGnRSUJKfIJ2YoR+W+y7xXdKSQtz43u71w0qv+DiruXSZwhorwWpedUAszbvEWa9gKDtAP9ZSNgFlRuTvv0cT8wTNnjVHKA4lyHODQrW64MDzTfzL4AKfOn0Mabp7GcinrdyrfO2rPFcn60dSYOqoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779185; c=relaxed/simple;
	bh=lajD8QJElBkHp+szQMp4lvfntXaq7B2csoiFGrMzr/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAeBq+OmvgFVYTOAnJ6lukbn9oXHZm+v7wqn0QyWPxd1ytStWZ4wMhjL0M/WCHbcvu8XnP6pHMKQuPgHcK3SObPIb0i/pSVxAo2Lx5AZewbPzM/YfhcqCo0sklNzlgNby58+OpO6eFjI9Kvmt7xM4rku2Je/lfTdfiNeV5O+zFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHAuyUbP; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e0e4601faeso1777499fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762779183; x=1763383983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lajD8QJElBkHp+szQMp4lvfntXaq7B2csoiFGrMzr/8=;
        b=pHAuyUbPTRgXF6gAyhV8JVy7+EDCorUsZr9eGAo/TITyvpDhI1fXmNQU5oIzJlPQtl
         +Tq+4arshPmQNek2fkonRGxqSqJYlhxpZ1TRy2SsyMwL6dwDtkkTIjCWJ6S9Nfq1C8xt
         X5cSR6XyI+b+5nZSLyX9rqdq5a9VBpVp5BBIQQfnEX9fitosoxpIz24ADV3KXortYbl8
         yxDdW1OYcSBH61IUagKk5zW4GjE5fxgf/hXxSJzyK8jVYPtsYf80RDMPb6WyaXfoJ5MV
         a9Ku5JpyQZA66zbTkcPvsvG2WtvhaKtwRN4H80iw8QP9yYbSpIrk5Tl84oQF2a0gEG3i
         8eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779183; x=1763383983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lajD8QJElBkHp+szQMp4lvfntXaq7B2csoiFGrMzr/8=;
        b=M7bs96Vx7SNMxhUGzZkZ5h9ehDrg2SB0hympDZQaggrVWSN+cu2mvQqa8ACNzGTZm/
         yTnHsDcA0HsiwVedVUt+OVDK88WvVI7a4HhSLu0ID6GZ9Sr8MDLGyyeNVcmZXHkDRlRs
         /6WP4rHlpFChi8XLG57tl8cHjhBh6Mo7ly9oHPCKk2otLI/wCu8eYXhDCCEMShunhhlL
         7Jfq1VidlEyM5Pjwhnz0slTLThrSktNBl8K6m1YyG2u6oHjBHh2VJ0dz5O27I4fpBbn6
         A5DhwzwkTLi88YReQ/+yNQJoUU1YQ7YXbW1YGiue3m7Dcr+3jVQnHVt6oUxcFic38CW/
         l1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWGMfk+cWUrkpjtirA7YCCSvUlJrO3j6LAmdGzYxJfIxU4+j9MOx0TA2useYeDjKWItv3Kyr+O/gjcTUdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKNIg/3m1M6Ly54TfR1veoqYC8C4cFuabxJtCJ50pY+EsLPbxP
	nzoyAx20GcEQWa2IZEsuxxZeL/bedY8CLOPHzwGJSkwuoLI/TSg4Na0sJ0pLgtGmhrjf8EL/d/V
	On9PesoXnwOZU3zpB8mq8dsTDry0aILMkKIUC5LTNjQ==
X-Gm-Gg: ASbGncsYb0TYgHB+8yHP7eOuujrcqKMGZ0nh2TLhrL3REujfZPiiAZcceu3f5e5GkQZ
	O2Vk4jJQDIT/DrF7SCqgsUm9OyaLYJ7UFTpYXKxiKYnIoAZJ2W+ZpnZqhco3BcDfZTuafxMsTCw
	sZeEyrbs5tVllcL43wvEIpfu4+9s9CYGcBlZSbogC1Ecg0xiRZEC1RPd7+9bnAVzdBA1R2XSGte
	lWiyE7HYuVTUdkbMnPxOfVC7ux1MLxt/TQjwuyufnITxA3uGa2Nkjogc+jT
X-Google-Smtp-Source: AGHT+IHaOc9Hf++xJ77n1T9F3eaANxA6a255QvjbOAcsfDAumQrnMbLyVAX5itd8dNhL35m/2iP5WQb/9KW6fxXbd5k=
X-Received: by 2002:a05:6871:60c:b0:3d2:fddc:862c with SMTP id
 586e51a60fabf-3e7c2452b4cmr4340908fac.7.1762779182758; Mon, 10 Nov 2025
 04:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102-automatic-clocks-v3-0-ff10eafe61c8@linaro.org>
 <20251102-automatic-clocks-v3-1-ff10eafe61c8@linaro.org> <20251103-smoky-rustling-bloodhound-7590ce@kuoka>
 <CADrjBPpjX_qSehbNkaAG03f=whs09qFzzgNiY3sztk7v0QeCFw@mail.gmail.com> <20251104-enthusiastic-cream-gibbon-0e7b88@kuoka>
In-Reply-To: <20251104-enthusiastic-cream-gibbon-0e7b88@kuoka>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 10 Nov 2025 12:52:51 +0000
X-Gm-Features: AWmQ_bmYJGLwRqlUrf73Sc1rVwj8QxtUbwqaYUkACotkTBe74SIkf0KWHru_6Ms
Message-ID: <CADrjBPpGt3qBGucF1COWZT=OZ+8ithg6=-QefhKUiW4tkC=KrA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: google,gs101-clock: add
 samsung,sysreg property as required
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 4 Nov 2025 at 08:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Nov 03, 2025 at 01:49:53PM +0000, Peter Griffin wrote:
> > Hi Krzysztof,
> >
> > Thanks for the review feedback!
> >
> > On Mon, 3 Nov 2025 at 09:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Sun, Nov 02, 2025 at 08:27:14PM +0000, Peter Griffin wrote:
> > > > Each CMU (with the exception of cmu_top) has a corresponding sysreg bank
> > > > that contains the BUSCOMPONENT_DRCG_EN and MEMCLK registers.
> > > >
> > > > If present these registers need to be initialised
> > >
> > >
> > > ... for what exactly? What would happen if this was not initialized?
> >
> > The BUSCOMPONENT_DRCG_EN register enables dynamic root clock gating of
> > bus components. So it is related to the automatic clock gating feature
> > that is being enabled in this series. Things still work without
> > initializing this register, but the bus components won't be
> > automatically clock gated leading to increased dynamic power
> > consumption. Similarly the memclk register enables/disables sram clock
> > gate. Up until now we've not been initializing the registers as
> > everything from Linux PoV has been in manual clock gating mode and
> > until starting to implement this I wasn't aware there were some clock
> > related registers in the corresponding sysreg. Additionally with
> > Andre's work enabling power domains it has become clear we should be
> > saving/restoring these two sysreg clock registers when the power
> > domain is turned off and on.
> >
> > > What is the exact justification for ABI break - wasn't this working
> > > before? Or new feature will not work (thus no ABI break allowed)?
> >
> > No, automatic clocks and dynamic root clock gating were not working
> > prior to this series. Currently power domains and system wide
> > suspend/resume aren't enabled upstream either. As we work on enabling
> > these features we are finding some things that in an ideal world we
> > would have known about earlier. Unfortunately it's not so obvious just
> > from studying the downstream code either as they rely heavily on
> > CAL-IF layer that has peeks/pokes all over the memory map especially
> > for power/clock related functionality.
> >
> > Whilst it is technically an ABI break, I've tried to implement it in a
> > backwards compatible way (i.e. an old DT without the samsung,sysreg
> > phandle specified) will just fallback to the current behavior of not
> > initializing these registers. Things will still work to the extent
> > they did prior to this series. With a new DT the registers will be
> > initialized, and dynamic power consumption will be better.
>
> So explain that this is needed for proper and complete power management
> solution on this SoC, however that is not an ABI break because Linux
> driver will be stil backwards compatible.

I'll send a new version shortly with an updated commit message like you suggest.

Thanks,

Peter.

