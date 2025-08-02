Return-Path: <linux-kernel+bounces-754101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2FB18E0F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15CE627695
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763C218AA0;
	Sat,  2 Aug 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="lbZ4l0E8"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B513AA2F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754131582; cv=none; b=YaYW9OFXvOqIcJ/9I5F+SmESPencmgn2q8QEZO0Kq3/MQVeFXRSm79ejxVtRxgtsJsQbIElDlJr6J8IHNuiNgsZ0ukMP5HDxOivKv5gdIsOAaCvhVrtFoJ08hkWSw2BabjdbqiGMo+cXcWiU8c0deTQtqjYruaembIuxxJb2xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754131582; c=relaxed/simple;
	bh=GjC27LUcG3dn5srVyYuXU1hib0j8skFeguiq7xLh0n4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Tp3jxrIyD7x/yxThKRa3vyU0qYm0kP18WhFDbXfVRa/Xeby9lvjqAliuXzKgViB7rxVtIR3260vzQ2cj+P6v0AQbvf9Mh8CIoB6u0pEbFaDe2vATOq5euA7ctZT9tDp49VvOzWgsBCdRvU/pqca/lUrC/UehtUTzO7/xeLqeR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=tometzki.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=lbZ4l0E8; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tometzki.de
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e2b5ffb932so1228518137.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 03:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1754131578; x=1754736378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AshJ86qbLOcrlRovTGnUwx2kL8dbcNk45DlyMc1ddH4=;
        b=lbZ4l0E8dBCLmI+M49z4V99jLK/jOGrnUXPnOdNpsvInZbs39VH0ksXmeIHo4o4atm
         uOtq4Fe7ihum+cdoU+UNYfElWGljMSsCsT57JzSjJfVwfJqmuK3OkTy7XH7UuXsSERIy
         hpHre50sVU6Qho7GIoDgCMlOrtjhbBMJGnDmRwEeSF5EeiO2i+DwwTzodY2WWSICmIL1
         L9hFDTMChWb/u3DqMg6WirtRehNqcQ9jhidRemphJF2Yrb48pZPg65UoD6dZsvteyuI8
         vKbqv5Qq1ZKTL1qB45J+XdpnLq2fkFOekYRRlTIWb6zrkHWRUjEbuhD5IwWV+cs6rakK
         OPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754131578; x=1754736378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AshJ86qbLOcrlRovTGnUwx2kL8dbcNk45DlyMc1ddH4=;
        b=cn5HS3EDRsW2N57jMfwuiR/imr5IeJiMlJ2+EcKf/g3XWykHiVC6e3QFVvjVE1eb3e
         8nRyr08NM5yU4lM4Rx7KDPQZpwKJseqHOsQoUKqzxgyp6Gs6xsbIKuvuUnZrC07rngh/
         WV2dki926JsW/nVDQprwi2XIPRtLpJIuvrfUauNNt8Do0gr1qdrdOVJacO5TGSWa26fG
         s/hFgUyy75wfEDgEiYD4cLFsPk0TwWFikg9cIrGocP472aQxAwEDjs5VRfcdMGZ9HoJW
         15lB9+aRCym+6wW6XU8fuqAql3yZudPpsVtOf5Oo1CFHf/DuB44s82upLvCTtcDHr6iD
         sDdw==
X-Gm-Message-State: AOJu0YxxE1OR9Z6kR3WsfPAywaPrlTAPPJLcvmU8aFZIi026If0lWWH6
	05DNVr4SwB+jBKDajM8I0XZC85rexFyr7boKvH0cIY9wnwjDCRT7JI7XyyNt/9fARgvsDDgXSq3
	bELbfliFA87lX3/iuThRHNNgJSzMQj8NZUw66Abdcww==
X-Gm-Gg: ASbGncsyXY7HY0bjpxhaGAgvGOv5ki6zYwBXQXadqdRJSGah7BkRP8r3SIQnT+9hRpK
	nmzJbPYVPxlGemHpCw4vi+hFo9m6QCpGvR3qv9gAgpCxE55+IckljUSWQjYa2QFPFBG6EFdgNvW
	aOb/hiS8YaQc56XlSPcd5Da9Be34r5t3mEhljEnYFPeXgi2hvhw0NDdx1zCyJAPYxPEoEm0pbh5
	/TyUU/S
X-Google-Smtp-Source: AGHT+IFNMQJlun1qhxFHABWfxEe4KXtT3gNasKqMjDslvq9o8yprzFRDSd2OfmO/KqUVhWtkOIuixDQkpA+9Ab8xO2E=
X-Received: by 2002:a67:e7c8:0:b0:4fd:b392:c500 with SMTP id
 ada2fe7eead31-4fdc3c23228mr1068821137.24.1754131577856; Sat, 02 Aug 2025
 03:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Damian Tometzki <damian@riscv-rocks.de>
Date: Sat, 2 Aug 2025 12:46:07 +0200
X-Gm-Features: Ac12FXw3uVxz8cdzoSLE1B6V0R4dpw0ngfLhuQZars8kAjQDrE7g_cZeOxT1qlU
Message-ID: <CAL=B37=-_dBswNrQHc4dgfgZhoyjmaYQxE5dGZhQeB0ZGf0GtA@mail.gmail.com>
Subject: ASoC HDMI errors with sof-hda-dsp on Intel platform (no PCM for intel-hdmi-hifiX)
To: linux-sound@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm experiencing ASoC errors on an Intel-based system using the
`sof-hda-dsp` driver. After boot, the kernel logs repeated errors
related to HDMI outputs:

[   90.933290] snd_hda_codec_generic ehdaudio0D2:
snd_soc_find_pcm_from_dai: didn't find PCM for DAI intel-hdmi-hifi1
[   90.933295] snd_hda_codec_generic ehdaudio0D2: ASoC error (-22): at
snd_soc_dai_startup() on intel-hdmi-hifi1
...
[   91.016259] HDMI3: ASoC error (-22): at dpcm_fe_dai_startup() on HDMI3

These errors are repeated for HDMI1, HDMI2, and HDMI3. It appears that
`snd_soc_find_pcm_from_dai()` fails to resolve the DAI to a PCM, and
this breaks HDMI audio initialization.

**System info:**
- Kernel: current Linus build 2938ae2fa7cd
- Distro: Fedora 42
- HDMI monitor with audio capability isn=C2=B4t connected

Is there a known fix or workaround?
Thanks in advance,
Damian

