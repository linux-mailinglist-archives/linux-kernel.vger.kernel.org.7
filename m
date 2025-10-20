Return-Path: <linux-kernel+bounces-861686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1BFBF359D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46EB405CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748C2DAFD8;
	Mon, 20 Oct 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDKVsLMP"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26C2DC353
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991259; cv=none; b=IA6VGn+XvIW2iu1Er/ZciXzgrQhBHUuteJvqpy5RPvzc7PNVJgyuqlu7fxY0wZcuyY82W4eWRVhQoDLi1lv99Dp8/S1Dj4soIOOuYllu06benn3V+WDc+tetOkokjpvsP0MUFm6uFpdP0s8cMfmyXHjZogze9jSs6UH2NWfFmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991259; c=relaxed/simple;
	bh=cW0NrS3XvfmefHojKNpPlFwBgfzDJ5SAdW6H/5DCfJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwUXB41linHmmQMWHJ8uo5kwO9dok/mWkq+XkNhMoDQzVbUQrudNKzvIePLcQ2BxzDI6xz8L7UvHPXVzOQ0jwBArjfW+D3PzqJqjR1jtr6NznRcOAqI9ymSMszJVEqhudZqytXMEchGcUj/Ezh1CMN6imywA/Pp2ntRQgIN8Sd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDKVsLMP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57b35e176dbso5934471e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760991256; x=1761596056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW0NrS3XvfmefHojKNpPlFwBgfzDJ5SAdW6H/5DCfJc=;
        b=VDKVsLMPM20J15S3GLLr20r5MXIkau6rpxVYq3D0Y5zDQEGdGfsgoYmLpFvR3Aw17o
         T23W680+65Pei+gQysdvQgWcnVnj5fysoWlA0hJVt75WcS03PRf1HmWWgaKm7HUZX/zS
         iCtX+z3a6N5AOCkJuVuww7yZGMLEb2j0Ziy+g3WeTYPlAP2p6IPB7T32WFGxfAc9T6zy
         hwMQaxetN9tvKMrkZgpjzXl/oOrZXNE4BzHaLUoUh1+N7G4ebabKBKc3czuZ8ccZyQIs
         KFfdLw6aE72VAA6DO4qeD6nyCdpvQtb+8HblZXd1gy6dR/EFL+lSS3/lnJTDSDLsvSA5
         ig0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991256; x=1761596056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cW0NrS3XvfmefHojKNpPlFwBgfzDJ5SAdW6H/5DCfJc=;
        b=vNRfS46+8qdnWHY7pIPUrXAxn0/ndxe7KASynZNnORfsWKFtzJkdmn3lfVah9co7kN
         Y8OVdNsq67e8uwo0clchxCfuyzOhIyeFUeEk/9XWflK3V06skVwBu6qyUAVc9V6mNU+W
         K4wmcAr8rzNfZMc14SFx6w7bRP5IaAC7yK8GwSMUBTyouqlGUsNNm5DrCATBzKrHXo0/
         6uvhyDMdK+O1Rs43SKgVJWbS0NINPqOXYoabZ4nvjK0M58/rGkObdShN/7Xre4zmDmlw
         XFw7KsqEG5S7edD85U2Tky8r/LgzzUxJAFErqeC2i9Tmd3/mgmzJtdQYXggnbYmODml4
         1DpA==
X-Forwarded-Encrypted: i=1; AJvYcCXOXN3lTODM1ehOk+vmP9bNvSbYdIqZDNb19VSuYO/ibRPLfu9KtFYZPVHAk46dU/eKXtDNY7aV0v+o/Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjFqBJOPZdKXif1W8YtcW3qjOe4pa20eNyw+I2MrpaZ1TanBF
	tJh6vRfxXSHIkiPApU8KVANWKB/uw2RwXwjs7QfdRMTht90EsD4xyz9DQF+nhqs+3Ty7MSDQE6R
	Ac8MrXBSbb+2osRrW2AfmqrpZqGNrBXI=
X-Gm-Gg: ASbGncuLVfY6/RT0y4YExk7/kP0tTGNJw91uJS9yB1n1/SwcKYu4Z77AvU3ufbhSdy1
	g/ppWGCMYZCxBboz1OyYaRx2HBVgj6/2b79a5USQdpLw/Fmau4xieLv3Hd8u62vF6furKhF030S
	TA7oAKWf7fIBDQYvKdRoPACBimgmSYbJP1/9dwgjUJg7AnjkGEsFwih4iKbUDI8HELnIyUf+8sR
	h6YGOPFXdbCmK49Rdecg3fufN88rwQtfJE2w1+EiCwe706rau91WshRoBN6WVyaK1vfZkVd4IhP
	47+So4MevUdXGqvboqEV7BG7OZzH
X-Google-Smtp-Source: AGHT+IH5YbH/N0GzOG9KC4T3jdDKTBXy9E5rcby+9lA7Aeai++z/YKb5cv2iLVBi4oC0gn0ky+3LKbarimVH4bcAel0=
X-Received: by 2002:a05:6512:23a3:b0:576:d5df:fe1b with SMTP id
 2adb3069b0e04-591d84cfb78mr5033821e87.10.1760991256016; Mon, 20 Oct 2025
 13:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
 <5d7491b1-8f9a-4040-b854-ff0b94bfd24e@kernel.org> <CALHNRZ-okVZ8tzKYa=jqudDu3dZ_Yq1CkeErdcvxi5xJEgJFbg@mail.gmail.com>
 <113725e3-3e82-4921-b045-8d5be3fed8bf@kernel.org> <CALHNRZ8r_bg-Pm1ZCoJT9sk++zQcq85R=8N6enL_Vcq=VziNwA@mail.gmail.com>
In-Reply-To: <CALHNRZ8r_bg-Pm1ZCoJT9sk++zQcq85R=8N6enL_Vcq=VziNwA@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 20 Oct 2025 15:14:04 -0500
X-Gm-Features: AS18NWB_ZO-oT8U4UToGcdXsXZWXtPvNCoksa_QZNadvxO4znElXh9NUJcwBK4g
Message-ID: <CALHNRZ-2Hv2ix0Hr9veOPWdO=ekgpEWKBWtCiCsQa29DcfdkUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Support dynamic EMC frequency scaling on Tegra186/Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 9:31=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
>
> On Sun, Oct 12, 2025 at 9:25=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On 13/10/2025 04:18, Aaron Kling wrote:
> > > On Wed, Oct 8, 2025 at 7:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> > >>
> > >> On 09/09/2025 15:21, Aaron Kling via B4 Relay wrote:
> > >>> This series borrows the concept used on Tegra234 to scale EMC based=
 on
> > >>> CPU frequency and applies it to Tegra186 and Tegra194. Except that =
the
> > >>> bpmp on those archs does not support bandwidth manager, so the scal=
ing
> > >>> iteself is handled similar to how Tegra124 currently works.
> > >>>
> > >>
> > >> Nothing improved:
> > >> https://lore.kernel.org/all/20250902-glittering-toucan-of-feminism-9=
5fd9f@kuoka/
> > >
> > > The dt changes should go last. The cpufreq and memory pieces can go i=
n
> > > either order because the new code won't be used unless the dt pieces
> > > activate them.
> >
> >
> > Then cpufreq and memory should never have been part of same patchset.
> > Instead of simple command to apply it, maintainers need multiple steps.
> > Really, when you send patches, think how this should be handled and how
> > much effort this needs on maintainer side.
>
> To be honest, I was expecting all of these to go through the tegra
> tree, since all the drivers I touch are owned by the tegra
> maintainers. But getting stuff moved through that tree has been like
> pulling teeth recently. So Krzysztof, what's the alternative you're
> suggesting here?

What is the expectation for the series here, and related, the tegra210
actmon series? Everything put together here accomplishes the single
logical task of enabling dynamic frequency scaling for emc on tegra186
and tegra194. The driver subsystems do not have hard dependencies in
that the new driver code has fallbacks to not fail to probe if the
complementary driver changes are missing. But if I was to split them
up, how would it work? I send the cpufreq patch by itself, the memory
changes in a group, then the dt changes in a group with b4 deps lines
for the two driver sets? That seems crazy complicated for something
that's a single logical concept. Especially when as far as I know,
this can all go together through the tegra tree.

Aaron

