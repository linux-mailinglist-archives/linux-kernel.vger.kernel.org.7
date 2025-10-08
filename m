Return-Path: <linux-kernel+bounces-845998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D06FBC6B02
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4946B19E44FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9982BF017;
	Wed,  8 Oct 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDtyGF07"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3228E59E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958893; cv=none; b=o/qZuWve9QDB4AQQ++dZp7J/xF7rGrPGZKlvTCcqzDzrN/NeZywEidWBpVRlpcICkPIFnPn9F9/ZZ3EwYAUUXMADPwK/gq5KUZC7EfQuPOvy6rz3gWr6jSxyf6jOiLzl5DDPCSPn6eqvnCKXU06sR6utb1bZx1xMvXg+/moPoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958893; c=relaxed/simple;
	bh=7n+YI83Xj4h934x6MbxCQNgzt8Vm1/5zHm0H8HdzX2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NasiRZ70v5QeKSVe10tnuL4EKUhifHhNMbE5uLLebBpvXu791BOQDrkM9Gnc1QRo+98qvKDYuVeHfL/lJux529vtKFH1OVcWCZIHGTLjmZCEwsHLqPA3nobyzVPq702xgMU2QPcQn42KdJ+eK4IwSIh/bJsazql/dXSRWxx4zx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDtyGF07; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7b00927607eso237555a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759958890; x=1760563690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n+YI83Xj4h934x6MbxCQNgzt8Vm1/5zHm0H8HdzX2I=;
        b=nDtyGF07We1umQHNf8j+ukDKmkqD23RyI+5kMwnOJCmGpVEwfEMv76J4bamwJaZaoo
         284nXOxvS2uJz2XkhUUwqd8I7VeXVvutRrP66FlZTZmjqQ2PwTqTOGdWrlIVGkZDB8+2
         U+kYHCVRdWNZgSAlxelcRIIwGirsilry9Gtil+SiWWfMzmIlVAZ3UqQMFSHCGH6IdQLi
         dWvJxY3/qDkL2cBWcU3+Rl0vOSGIU5p+aNTLuqrulHkHalOGoC1+85AhsMOAlHMbUknE
         PjozJdbz+bsgMULuKbGQzRP4FPMvjFJGuW7KydDJDxqqY2GUngJ51J91IGSaew68dLLa
         cNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958890; x=1760563690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7n+YI83Xj4h934x6MbxCQNgzt8Vm1/5zHm0H8HdzX2I=;
        b=JS5IBQiQw5DZ8WGS0VBBtnQL0/iem/J4IAUB2T3iQ/gS8+KSV0DWjTuQao5LkhxEYe
         SnJVu/A4ckxbzeG+NZVVhZspADkAS3AmT6SPbvwHGeN4DfRdtOH2ujBHQyIXKozrV7w/
         Pk0xwENTDlV4rik4fdPGDgyKvK5/X+pe2nKTeEF0BM9i2VMXYuWx7BVph4g56PCoQMXS
         bJfPcwTqzlr6cZWKA5NA/XKsqkMNh2TFyyjwWCOhiAaqeSf9GcoGslJGaavc8X3y1Klj
         1yb6WNwIC0ZnJAeAmtYBQK6ZlfddEeSrUILjNixK1/js2O2ylw78BnXgEouUk00yc+d3
         ztbg==
X-Forwarded-Encrypted: i=1; AJvYcCU1N8xzO+JdQ0ZwPEP6Ax297kb1CeEExsUQENpPPL1dd9wnj+E59Ws2JaZhsgiKvFVTR+v7ckd7SE4Djy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyReMHNeeDjb5kNE6iUvv4y3n2feCAg34nUEqYPfk+cRZd0E0gh
	dk0aEYHX0VRMwaFn83ud0/jm1H8Mm2BSSsDqRXYXwgYm0oAn6rt/s5p9AyI3xw4Hngj/bQ/1nmY
	8n5BGxvIrEwUt+tqU7Twsvlxyzg1CvOE=
X-Gm-Gg: ASbGncupRHeIBGAX4QM0na8Rx2vxHqzZjGcY4Za4Hsus4ttlM+GM3TgtD0J+Mum4/W1
	q6eRngRZRL9uBQ6P775RHBwvJDHdY8P815M79a0C4oM1BvkADKmYyohupSNpu+ZqsxwDsW92Ba/
	OdsOdJsM4713kAQsVAy+8buMj6hAmrRPAyV5P/678dZZyNdVzdyHejboCzkQxkniaeqirrmxKJH
	UupKDwCEkWRIC/ddqw4pYSGB16tEhs=
X-Google-Smtp-Source: AGHT+IE98GgrC9jXpPWvx9TvskM3yOdcCbcPpo/3rkti4JNTQTO6XvWho5Xlo6OFAwChVZNifMjlsCVGT7YzZAVwjhM=
X-Received: by 2002:a05:6830:b94:b0:7ab:9f6d:6916 with SMTP id
 46e09a7af769-7c0df6f4b35mr3347617a34.8.1759958890034; Wed, 08 Oct 2025
 14:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008162719.1829-1-briansune@gmail.com> <aOacZAiWxG9XfWLS@opensource.cirrus.com>
 <CAN7C2SCDNz5TB3deVziuNNYFnPV_hmrsPL1k-j5Dsj58wvC2rw@mail.gmail.com>
 <aObHCq6JAHbtTJZ8@opensource.cirrus.com> <200b17e5-9655-49c7-a4af-7adaf2838168@sirena.org.uk>
In-Reply-To: <200b17e5-9655-49c7-a4af-7adaf2838168@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 05:27:58 +0800
X-Gm-Features: AS18NWDuir5zkMv_d4mFWSmBgTAHpZlq4_iGaDwQbcqxaO3UHAZIim2oAuFFIIc
Message-ID: <CAN7C2SApVuEBTpq-E=bT=1yS+hQVv4J6FSe4ACa5_1a7pSprkg@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:26=E5=AF=AB=E9=81=93=EF=BC=9A

> Another one I've seen is that you're using the BCLK as the MCLK for
> another part (a few devices even require this), you might want to run
> BCLK at 256fs or whatever for the MCLK even though it's not needed for
> when used as BCLK.

If you need BCLK as MCLK same clock rate why you need to use BCLK from
first place?

