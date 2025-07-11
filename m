Return-Path: <linux-kernel+bounces-727870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3BB020DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC672A48508
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5AA2ED177;
	Fri, 11 Jul 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSXC5dMJ"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5AB17A2EB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248993; cv=none; b=iUlm8per4dSzQcynTnYcBmt6juRnK9ZdRhxE0XraCSBcMMjmpz3pvCxe1Kw3RAmHv/0w8W3hE2tTW4LDkJv5l6utEGIKT1wlcrnfkFdxfK7JuebmZqOuoUtoL721y5t3KjA7Lq6KMI4mgEHw8IrAvKnoU9oyC5SY7TtaLwPa8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248993; c=relaxed/simple;
	bh=MsFHUVPklolt2MNco1FGwnCw+YjUi5Piu0whohjo1RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tX9cjbwMnA/ElG0kgPJJFmeEEfSPf001pWYaPr7GGmUdoNaqAnN2E6cVlSpNXGCBhNIf0fJAd5QWR6/MDHmnRmtMOAVCT7a5+Qd/x6vuGSFsej+7Nql6PBsE+TKBJlZI/TT1OpB947Gzsv9YCblIQAZRKvnL4S8+v6ovazELSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSXC5dMJ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-611a7c617a7so621721eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752248990; x=1752853790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kpWDwlYEFZONP4nYRAFW848J3k8ajKrSnxZeLFk6ATw=;
        b=dSXC5dMJKTkDCKDR3hxL6KnHhdvSuCc8ZtK63/byHWSqVlmLyZ2B276QXZQxXyy8Sp
         N9DKuDipaiAMvkafrTo8vo5x/4TTkXE3KY1EaUY+Fcscp4ftFQQZLBwYgnGjqTZpIN3L
         Xdl1Duzw2Wjazr13EXaxZlk+/yuusZX5bgxgCzsTq9SNCCzEtFEba7wYajKj47jaFMom
         WaAZYr6ihIc05qfq8RwuVmn+HRW/HRhOSUmD3zy1xFVyGHHXmPf/TtUR9TvIbunry0IS
         d1RJPZZHgYtZ5mFEhJ0qGroisgk1rtprsRTHuUv5tqS6s1VTHTTtGI86bWvSpHJkMTD0
         MKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248990; x=1752853790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpWDwlYEFZONP4nYRAFW848J3k8ajKrSnxZeLFk6ATw=;
        b=NA75sYRXMzol0vd+bWVjmurNXmv6ek8QjKYHIyADC9oVIX5K6RkI4Z6kMFhopE+JGL
         caZ8aJfU8FD0lg5VCA0XYHAgKv2PlwgP1/WIjirbSRcv4utt+3x4CbTaAfyyy5yKXpYb
         cK3ZZ2TGxAJ/nDxqsTEC5oOah1N/uesj3YpEGOpLE4qTmsiNdwzDHJP/12ejfQ1uLaBH
         rpccWdWj+2v1HS6kfAMeumCC9NKnI37EPirdir/cAEuVwk+UGhKnjDN0wsMfGgDuiEKJ
         uAPchxtALOMmqRgHT/K0wpezNEfBzMbijTb6/UHKIaKx+sXUB1HcoLaAu7keQtvVJ+Zn
         Ub6g==
X-Forwarded-Encrypted: i=1; AJvYcCWjwHFO7XJE2940ZD0uasixhGuTmGFI94cOSYVAwtbOwxoOw3kjmzyIBx1Zo3p1jYYcFZ0T1W5oHiWGwZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qrfWdQS4k7HWFkIsDVA6kS4fQplTHAltdz7wViunDk2wrAGS
	jWiKfyHrJB3jcnABrFQZ4AAm5WGC5ijyz636VrgzxHdWYBzf8kxWpXbxpcN7A9uFyi7IUZof/uN
	R89VT/SU+B5WlmcSzHhlwYe+iBv0CKdaPlRKwq6WBDw==
X-Gm-Gg: ASbGncs2Dwmovsrqzz9XL+Ey5UDUqdTsK97aCW5Wdi8J3rqozsfCOdvDX3Oc7knl83v
	3Rmq1YSIRNjihAnVzpuOe8m/g7NO1vb5g7/rBtWrKR4ELYHHUI+WyKowialZW4JG4N3NSXOhGyw
	KlxgpLx+zbqyArq3OoeIZoTwm2JnbIAUyyxCT05luf95tO8W4Vq5rnCIBm9w/Y5MFFnQ0nf/Ee9
	Io9uhs=
X-Google-Smtp-Source: AGHT+IHv1hWw2pZQOckg98iZ5DP8H18RgsI97u/wmdJaWiqskQQPUlSUM7hA7IGFfKLNfKIFCIMEQTMIDL5dj9i09a8=
X-Received: by 2002:a05:6808:1a14:b0:406:5a47:a081 with SMTP id
 5614622812f47-4150dc288e1mr3095704b6e.13.1752248990474; Fri, 11 Jul 2025
 08:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-gs101-cpuidle-v6-1-503ec55fc2f9@linaro.org>
 <aHElXbj4-T--QqKk@bogus> <aHEmB-K7Pf7WOswk@bogus>
In-Reply-To: <aHEmB-K7Pf7WOswk@bogus>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 11 Jul 2025 16:49:39 +0100
X-Gm-Features: Ac12FXyPP2ayGhZhRKT9piHwpXNM8Cjgh20ByzhOS5Y4tdqk1oaHtAN9grK3Fzg
Message-ID: <CADrjBPrRbSYXVg5KyNB8Z9qLkZ2sGzEUcP+nf2UP2rVm2T7bSQ@mail.gmail.com>
Subject: Re: [PATCH v6] soc: samsung: exynos-pmu: Enable CPU Idle for gs101
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, William Mcvicker <willmcvicker@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Sudeep,

On Fri, 11 Jul 2025 at 15:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Jul 11, 2025 at 03:53:17PM +0100, Sudeep Holla wrote:
> > On Fri, Jul 11, 2025 at 02:50:26PM +0100, Peter Griffin wrote:
> > > Register cpu pm notifiers for gs101 which call the
> > > gs101_cpu_pmu_online/offline callbacks which in turn program the ACPM
> > > C2 hint. This hint is required to actually enter the C2 idle state in
> > > addition to the PSCI calls due to limitations in the firmare.
> > >
> > > A couple of corner cases are handled, namely when the system is rebooting
> > > or suspending we ignore the request. Additionally the request is ignored if
> > > the CPU is in CPU hot plug. Some common code is refactored so that it can
> > > be called from both the CPU hot plug callbacks and CPU PM notifier taking
> > > into account that CPU PM notifiers are called with IRQs disabled whereas
> > > CPU hotplug callbacks are not.
> > >
> > > Additionally due to CPU PM notifiers using raw_spinlock the locking is
> > > updated to use raw_spinlock variants, this includes updating the pmu_regs
> > > regmap to use .use_raw_spinlock = true and additionally creating and
> > > registering a custom  pmu-intr-gen regmap instead of using the regmap
> > > provided by syscon.
> > >
> > > Note: this patch has a runtime dependency on adding 'local-timer-stop' dt
> > > property to the CPU nodes. This informs the time framework to switch to a
> > > broadcast timer as the local timer will be shutdown. Without that DT
> > > property specified the system hangs in early boot with this patch applied.
> > >
> > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > ---
> > > Hi folks,
> > >
> > > This patch adds support for CPU Idle on gs101. In particular it achieves
> > > this by registerring a cpu pm notifier and programming a ACPM hint. This is
> > > required in addition to the PSCI calls to enter the c2 idle state due to
> > > limitations in the el3mon/ACPM firmware.
> > >
> >
> > I would rather keep the above note as part of the commit message or the
> > code comment as this will get lost when the patch is applied which is not
> > something we want. I clearly want to loudly shout or shame the broken
> > firmware for not getting this right.
> >
>
> I did see the comment but still thought it is worth adding the note in the
> commit log too. Sorry for referring code comment above which is wrong as it
> is already taken care.

I mentioned it in the commit log, a comment in the code and also the
cover letter so I think we should be all good? In the commit log it is
part of the first paragraph.

Thanks,

Peter

