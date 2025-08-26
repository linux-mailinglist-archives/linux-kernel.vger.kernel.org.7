Return-Path: <linux-kernel+bounces-785981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C37B3531F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539B33BB048
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EDC11CA9;
	Tue, 26 Aug 2025 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JLLz1q1t"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B916CD33
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185411; cv=none; b=nI7ZY/0f4CGzoozqLZsw/sx73rktMYtkdMakGAxLY7K6k6u67XFpGXODDxoiGINv0wQgRhZM40U6a3IxSrGJU29EvdLeu4fTKoUDrmoOSHa/yu7OVaQNfFP2vzBn8woa4NGXocrEpHcfYXW1hl0FyfC2MQziqTJIt7kG717nTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185411; c=relaxed/simple;
	bh=3FhjRy2es/oOFZdHwyiS4hthTz3SWQunVt2WiiMiN4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRwq1Ey7Zx/XsmLVhY/53vOSlGAbQqmIoc7OChw6NKqGnJdiiTp7n9R4PyncosVeJUYDmaRIXljBmSQNiJ0TqEo237zJ/mRoJDPG0x2WUTIIYxywMz33anW9suJqK7wkaG5JQlu3GFo4MTtnOyPjWgCBRvSGm/7FguYIa45qZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JLLz1q1t; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8920c579f98so1399683241.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756185407; x=1756790207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1JIZerC9XYjkBh/CdzWClGmJGkTit8bSTofkNpBRWI=;
        b=JLLz1q1tSDgul57Z+7GHbbFTYRsUzrICfInd1EfbwkbWpwgDIlN4Wk/Z3mvM8Z1hXG
         dsiqljejZE6DGEg1oWKyHuFuuPIXNNrKkLSzDI3TzqxckdJBFgLOkelPyKxZ9MEinJdd
         tgsN9ETlY0BKxgw0SqqMlt62/tWLh0jZbWzTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756185407; x=1756790207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1JIZerC9XYjkBh/CdzWClGmJGkTit8bSTofkNpBRWI=;
        b=J14Kor6FSuvYBBORt7/SjvrTEQHDsUeLmE2R7B2USugWfxJ4zBj1IcgUZuJh3JqHfV
         921dXBvHmApXgfGyBk9YBqKixVSSHdPInaXsve+mXSoEdT9DsyH7NI1HEsfQqHYIZZjl
         3La0x4wLu8bLorpTzdyv37DaRwLf/5c/FzPDiW6+d1idYBrxrnTEKbTpKT+3cmaE0CrU
         AZBJz2FIxcX6IfFg6uXEuYMr10Y/fpTHcVNiApGwficEHv9qfo9UdJfAdOg9/dE+x78U
         NS4HcqkEh+t7gWaUvyP71smhxKxreS/8SIlZN81wHUOnoovrsfKAgn5nLEiUQnZb3n3b
         tdkg==
X-Forwarded-Encrypted: i=1; AJvYcCVGrQuCpVTh7yKsio99lUi+Ikx8w5FEip4I4/KavlavGak3fmo65/k6DHcB80lcWFfMB37TAl27JqUChkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJGUpWFcRPqozCb7yM0bor1PSv9gHF0CcLfIMjS0qJluvhA1N
	TXlajZ/JVRQ68YpB98atsg92wlplYJ1AOX63bOoA1o47Au+4CV4my2VujnMNMxDRbD7kqFhhCHd
	96b4=
X-Gm-Gg: ASbGncuAe/d88vWgVluwX6AcsF7PZ7KJWmp3YSrqYKjOUJGtzfx7AuV/5nt9OIpRyUV
	7iG6sQB9RhrFqxsPIEKGK4qls28YcrdbkV2r3c8g1x8fNXZzNRKNWGLlRMHo9ZIhD49J6i32TPQ
	Uim9wv10SBIxhORi9mulBd06PwGtQo33TfdjQQN6EiKavosme6/QYeT3b7A4kb+L4T+rzI5JMcB
	RM8JivVGXmioMMKnigw1XY919NqTFttp2axW4OogZsw/K9dTCscHDWwfSDSQ68bBgDi0NTeULps
	jXc51UqASc7ROZQvb2GOla0DSLMAdS3l4BZKxIk2DjnDJK0bs51x9tG7vwxWXiD2rvFmRy0269u
	NXH366kIFY9lu7dOz9bQ616hjPhDEA0WojMxKRJ5+4YkMV5ZHhBH3FfiBEA==
X-Google-Smtp-Source: AGHT+IGSbXFo5OoyYUut8eAsbBbkhLjp/6OQ7NH+K/kEUYJaiQw19n15OB8L7Xp4RQKtrGuNPAwH4Q==
X-Received: by 2002:a05:6102:3ecd:b0:508:aeba:ac31 with SMTP id ada2fe7eead31-51d0cde26b4mr4185672137.2.1756185407097;
        Mon, 25 Aug 2025 22:16:47 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53eda5bb6d0sm2029822e0c.26.2025.08.25.22.16.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 22:16:46 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-50f890eadb9so457682137.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:16:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0feBhq1FyDSIgTT+Iwfv/EoE5Sg23zifnsx7Rxq//47/e7Xtj2fpzV6ku3fL734nvIE1nAkV6laY1pMM=@vger.kernel.org
X-Received: by 2002:a05:6102:2b84:b0:4e9:9281:85aa with SMTP id
 ada2fe7eead31-51d0cde292cmr5071231137.1.1756185406133; Mon, 25 Aug 2025
 22:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825151111.3696404-1-wenst@chromium.org>
In-Reply-To: <20250825151111.3696404-1-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 26 Aug 2025 13:16:09 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhJpGD5ro+QiNTkDn90Nbw49jDQjVvwRT1XFQJbwA=z8A@mail.gmail.com>
X-Gm-Features: Ac12FXxPVcynR36QGxsqlVXBYl9-P7WGDtVc3IOfN03AppRsLVWt_DvyhTCcM3g
Message-ID: <CAC=S1nhJpGD5ro+QiNTkDn90Nbw49jDQjVvwRT1XFQJbwA=z8A@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: mediatek: common: Switch to for_each_available_child_of_node_scoped()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:55=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> Using for_each_available_child_of_node_scoped() allows us to get rid of
> of_node_put() calls from early returns or breaks in the loop. It also
> fixes issues with missing of_node_put() calls.
>
> Switch to for_each_available_child_of_node_scoped() in parse_dai_link_inf=
o().
> Also drop the braces around if blocks now that the inner block is just
> one statement.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Dropped unused variable
> ---
>  .../mediatek/common/mtk-soundcard-driver.c    | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)

Reviewed-by: Fei Shao <fshao@chromium.org>

