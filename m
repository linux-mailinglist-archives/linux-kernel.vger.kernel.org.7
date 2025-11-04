Return-Path: <linux-kernel+bounces-884441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA1C302ED
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59A954F786E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502792BE658;
	Tue,  4 Nov 2025 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PoSZC+0i"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0E26ED3F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247178; cv=none; b=qQEtyJHLQ1t6o2tJwXPC8CUWcBoKZW3kmxlvJ+OCIiDDS4mOKaRmTBvZy+XCAkMQjpVdLXTtEePWL2zK8TMawlGHg2IJRdN5QzO+dKh6qglXG12xqtQqULJ6OVp5nK75tpVCtWIDZrMlz+5B/7aJ1HuDBk40HzB0TQcyJoF2Eqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247178; c=relaxed/simple;
	bh=Ve6j/8aRh68YK2EiWRDoB5ZD0BlMxlKqu7uay938KFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdxYFac1lceAOU8HzIoLSGplKKtLonDKHdPlPDSBMuaWtul8pjEE1x/lBJcPBr8Uo2de42RHUHFvZE30qUNIqIzo6fOsnZK5w90ZnHOAxjNynOUo+6jcdb0HujCb9OOZIqNP50jszmb0KCPAwvIDSpw51aXkKWTimKDpH+NvaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PoSZC+0i; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-378d50e1cccso53911481fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762247174; x=1762851974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve6j/8aRh68YK2EiWRDoB5ZD0BlMxlKqu7uay938KFA=;
        b=PoSZC+0iciZFBC2TmXOn9vSn9Kt0zggcNW1x9OICYgmt4xRVsBUgaqZIVlLrGz7XT7
         CE94iGnisB8V5SdewP5mxG0WZ+X/QMr6INujPM3OC4vit4sg7qDxwUapRChbbI2zugsM
         zfqM7mCQLEU4FYkg9eYwzODeZRQhq1EaO2RM+Ya32Mv8nbtxlnXHp0dKQi5XF2Tcnuh/
         HKShYPXCSGBFxSNPbJIwV/P5Io6T+6lVakNqDa5i73piCOi5XOnmYdBdLkTkLjWoxNDz
         eCj2JnHxRvSb+qPpZp3tinyzfYHqBBkcgRaJeTJzcT8TFbFbCwxmLIqHua0B51ONZLx8
         20PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247174; x=1762851974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ve6j/8aRh68YK2EiWRDoB5ZD0BlMxlKqu7uay938KFA=;
        b=AY5MIump6JYcjXPN8/8q8iOmxx5r9pwC5T61M/fj8LP0fZUH7l/Tetk7sGGpSfvVj1
         k9nQFuzKmBus4X/dHbAmV9LwhjSU/TGH681Do3eCdjJomcuDI2cJ7hV6kK2++CS1JrkD
         +LRpovqKclkkuMiyq5akUaj2OW8pFCBjhn2yvxF+PkdZFepPz3M2FDDG+PHwYeWoDpBm
         sbfOYjV0cFV8z/urIaQvEbqSgWuQuoA4jF2XWL6tMYaW+s3kC533PFuwy14kGENx0HOk
         q222f6WXR3nn4FwGPmHQCFGqwEwETuD+S3MrJk/nMuEnNZOl+9eH98ZJ9PKczTAWhtIu
         Tpew==
X-Gm-Message-State: AOJu0YzW7AfJHh2alwwbyFzrFxOC+QG9LKAcVDxBBB4VtHZakBy90cKY
	9OR6/szm2cR8vM1nAcOdU2aSLRV1RUSR470C4koP9WB4kxMnaNCKGR2Hpmef3TQH03LVjeFaQvU
	sNLApeTX1tkd2C/B3C5atz9E+COX4G17G5YljkZ5Fng==
X-Gm-Gg: ASbGncupytaXAaPUAjpKQSr6Gi4fCrodHRVdI4bSe6XA0hNdwSZlBHgFfy/98Ho3hKf
	yo34vRLgbdZxyyq1QYYNLbExEd6jiMvjGcx7pQE4WqKGwvA8CE0aZife9whycHU7e1LN1OVZmEU
	vk229tw3xr7k7gtDJvb9VlEaWcPC2dBFLx86Yq7YSqL1+emgweo6TlvbkuPBhBfZFuHfG30/2CT
	tUcsgSXWI4uJ/N7LHSr0ocLXgRfA3gi+uC/bPLpidhIAoWLa+7vOeaCWKDBo6RaH+iyMXqs7yA7
	ddSis7yOF2ljybt9vw==
X-Google-Smtp-Source: AGHT+IGoHrnYG8pwuIHGlYyWwSS5cdb6Yc2Im4z8V243Aw9CaUJS7Bdv48REX9tserm65W5shJTVHeZLHIb6C1wIJVk=
X-Received: by 2002:a05:6512:1442:10b0:594:27fb:e7ff with SMTP id
 2adb3069b0e04-59427fbeab4mr2389190e87.51.1762247174389; Tue, 04 Nov 2025
 01:06:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103164800.294729-1-marco.crivellari@suse.com>
 <20251103164800.294729-2-marco.crivellari@suse.com> <vzwd2i6wn75oxn5e34xwky74ezpjjosyhx5kvcvwvywhohzegq@xfhhlcdei6it>
In-Reply-To: <vzwd2i6wn75oxn5e34xwky74ezpjjosyhx5kvcvwvywhohzegq@xfhhlcdei6it>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 4 Nov 2025 10:06:02 +0100
X-Gm-Features: AWmQ_bm8IBsb5ejrK32XwjdslIRWl6oYAyZossJmkVQl98tzAWm4SvM3BJaQbUs
Message-ID: <CAAofZF7nfB881LL4qry+L2Z7TNsBx+TWgELv1aKEUpkV2H=pAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/i915: replace use of system_unbound_wq with system_dfl_wq
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, Nov 4, 2025 at 8:31=E2=80=AFAM Krzysztof Karas
<krzysztof.karas@intel.com> wrote:
>[...]
> "This patch continues the effort to refactor worqueue APIs,
> which has begun with the change introducing new workqueues:
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag").".
>
> Otherwise, the sentence "The above change to the Workqueue API
> has been introduced by" to me suggests that you are trying to
> re-introduce or fix something that already exists in the kernel.

Makes sense, thanks for the correction.
I also realize that if I were put that sentence after:

> This lack of consistency cannot be addressed without refactoring the API.

would have been better, anyhow (maybe it had already the correct meaning).

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

