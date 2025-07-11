Return-Path: <linux-kernel+bounces-727706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75344B01E82
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA587BD924
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835532DCF69;
	Fri, 11 Jul 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOwjTDiV"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F22D77EB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242311; cv=none; b=BkPQMdb7k4plYZujkYc2x1NtGlA2ekA2BencmSio44aCl5y54Ccj3bXMmxX8FRB2QOOAeEXX0brPZbislq1FT3uQQnlzna2itJiO+auoZ/L7mfxblOdHnxTntkEOpYddJTFYEfyUnPffG+Vbh0SEBtqE7oIDOliN8uF0kzGhfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242311; c=relaxed/simple;
	bh=pNqonM4UVtrsALbVQxE7BjqrmBap83H9yb8p9qwz7o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCqdmt/q3GAY01M/rnR5ooP/eq6b0WNJuQiybv9uXcE7zx4jnxISMY2dTwuaZKI/MyT0MVt8aUIO6gu6I3Fkboll9vzOA2rFWuIX6gJ4BOtC+lJ0TIQhVXGd0YIE/uZNEBp3NDx3OXM5NSQ/pMOQkazNGavD8V3yD+/I8Mp/85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DOwjTDiV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1592128b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752242310; x=1752847110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNqonM4UVtrsALbVQxE7BjqrmBap83H9yb8p9qwz7o4=;
        b=DOwjTDiV/nNBIE5obEmvtiPRS955V0t1VfTftQX9So+5sPYBiTaYcaSq+zj3bLy6bE
         sFYvscgXurxNNTkDDf332Mr2nk2KHg7XsMGgGKlw4MtHLYMyhJSc77b4ac0+2cuVQuB+
         RkPTB78ukfB1BtwxUtUK1ckCsZeMKm8FLGYX/PSO1aK+/PPnbMZJg0ClQ6qy5qr+8rej
         gvvhs/3dE2YdVRLb4aSssWk2ax6uHd12V4p0pp3PWJOjHvPbBzt78q0TTzazeBlfufyR
         pp2oPCBQWkBgwDDiVVcgimBWrhEM/Yx6LRDddFOZkt6Olj9MaPCcJSeREn499F4wV/KX
         cXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242310; x=1752847110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNqonM4UVtrsALbVQxE7BjqrmBap83H9yb8p9qwz7o4=;
        b=WcoKmi/v8rFBGZsAH/GxGdzpHtIWsDHXPcsoWoIbwk5Y0Jk+FB6F6TfL9RPra6cbkZ
         SGlJVqy4KwNoyRO/KikaqjhM1wh9v9T0CW9AohBnNGRVoM58VEkV/QUz3MFlmHOLgPeS
         TVJJCvhG/VUfsuQM0VCuFE9rmLkzZ7bDPQ6xdg0F1N84Bxc7KSY8BZtttX3c3wI+XKND
         laXs80aqU9R39ac0J8aGt1FIsvNq9ijzFs9N4wdd4JtZgsPCfRrLvIOSq+p42Jj6gsjI
         V1hHvLm6Lm97ne04kem7PEzset3eACml3A3jZqOz9bSwM5TWY8Qb25SsF2+f17I6+iqq
         i4wA==
X-Forwarded-Encrypted: i=1; AJvYcCWTERfJ5yhjLzB0/dJQmEbfrN8zGMwTrBP8UnKjfqThw55K9LcuhnPLp+G5dCRccMLQb2d6IIkM1/t3tls=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5ocNr5UNxgHrCs0MTxI9rfIGbUIfB+9x5r16nCQKGnVyfGLW
	ZAcY2+vU1Mbh/Vi8qcebEj0u87z4QNV/LXoioR7oZkfTnKONBxLD1NNnB8w6TvBzh/nmHMYvwty
	vQd63P55ESwcl74tyjcHc8+zt6gYgQkADShPeb8BM
X-Gm-Gg: ASbGncuWII19tWk8isW84gUyPFL1NJRLNRXoPuv7LUNz6OQsOqZkF7Rr90WVBfziKVF
	W8HLhliuE98qC5SFlFl3DTV06MnIGxuJbj9RGhetH9Rm6iIEm6QSljzazQT/LW0V7PahIrrrW8D
	ZK+RSzlgooS3y7BiFat2eNw6+9j9o4NOQs5PqbdiNreMfe2CjnCmC7kmutDQABDfSnIzO7psqqu
	DhrOX1AgWjxTwffQi4Xr+yK0KqVEY2bo3I1cad3
X-Google-Smtp-Source: AGHT+IF9vpsS88cqwJvceZ3AVWYOHULHoLV6jnQ0fxFPUTnJrLpeVWrilV12HX6w7fKkYy/KsZQkRWej43wmqe/0mho=
X-Received: by 2002:a17:90b:33c2:b0:313:2754:5910 with SMTP id
 98e67ed59e1d1-31c4cb8aa2dmr5577396a91.15.1752242308018; Fri, 11 Jul 2025
 06:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711082441.4193295-1-verhaegen@google.com> <aHEEu1eSSGRhITmW@vaman>
In-Reply-To: <aHEEu1eSSGRhITmW@vaman>
From: George Verhaegen <verhaegen@google.com>
Date: Fri, 11 Jul 2025 14:58:01 +0100
X-Gm-Features: Ac12FXwkr5vfJuzXyUzX28ecPpQ4ARo3qP5rhcHUhMh4j4kcitfjBXfbRa88hKs
Message-ID: <CAAntYmKea1p=ao3OOWb=1Q+BXdyo1SCm9qGb_JMC5ry5DQVt-Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ALSA: compress_offload: Add 64-bit safe timestamp API
To: Vinod Koul <vkoul@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Cezary Rojewski <cezary.rojewski@intel.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Srinivas Kandagatla <srini@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-arm-msm@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Jul 2025 at 13:34, Vinod Koul <vkoul@kernel.org> wrote:
> In your testing when did you observe the overflow condition?

I observed an overflow after ~3.1 hours.
I used a stream with bitrate =3D 3072 kbps.
So the field copied_total in struct snd_compr_tstamp
overflows after 4294967295=C3=B7(3072000/8)=C3=B760=C3=B760=3D ~3.10689 hou=
rs.

> Please share patches for tinycompress support too, we need those to test
> this

I didn't make changes to tinycompress. The overflow happens in the
kernel file compress_offload.c. As a test, I let it run for more than
3.1 hours and observed that the overflow no longer occurs.
The overflow is in
stream->runtime->total_bytes_transferred =3D tstamp->copied_total

