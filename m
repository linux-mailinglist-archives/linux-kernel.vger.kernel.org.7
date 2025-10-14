Return-Path: <linux-kernel+bounces-852935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3FBDA3FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF5D19A4658
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AA2BDC13;
	Tue, 14 Oct 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIwqjw8j"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C529A9C8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454642; cv=none; b=ucotfNaQtMPvipDMuOoGuGLJaM3jsWnpJx92wNIxs4Pwx8eXMyeF6Z4gvgEaL35/k1X+epyrQ1yW0RshE1S7Np4cORQ3/v1Eg4fVCbcliWKmp2uQBfyGn9ZaCfcM+yOXp8m0y0f9tnJxCmJarFEoEeu+elDeEtB43T1B1RqcFZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454642; c=relaxed/simple;
	bh=N45NLKx5qz/uWyKxlofVnpvkJRX+F3r7dB9pwWo/Bh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzBN/fSSTQIO7LEqtgp/hW+0q71+fZHcHlgLRHjolbuYjK7+8B3FB8UNM/7l0jT68qZN3A27c7KSfm8SQFl04LJLPG9W17i04qvSXbiG8Mt7WVTmSs4bRumwTki2dY5JQ796a/QNhh/+MfXDD2RQfaBN66FpOzrph6H370Gj8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIwqjw8j; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7815092cd22so8256807b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454640; x=1761059440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N45NLKx5qz/uWyKxlofVnpvkJRX+F3r7dB9pwWo/Bh4=;
        b=fIwqjw8jl1RqtcbDjDGkeNyqgqMfCXA3JgCx43UpS/0X6LYOoyp4xffa6PGHw3E5Si
         vLfnptyA1MGdns2e4Xlz2u8psDiW2Dzv4Q8e+qWBOPFFkAxpv/I2NvFwUI06eWYfXs2C
         aD7u0ZtPVD3+/Oph73K58cT0NiA39YeVQAfEYju6uZQOusIY/XrlJNZmp3p/ACOWjSRt
         RxPyKFqsGuSasa75muxl2sBpHkIvvK+ZVyGTuI+IyfSLBINV8Q21IJnzSGlA8rF0GGWe
         y7b0gvGbcV17CU4thP8qoBPWnkBjEClG44V2tPn3nVzEeD9xN62FzK/XPK/DreczcVzT
         kd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454640; x=1761059440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N45NLKx5qz/uWyKxlofVnpvkJRX+F3r7dB9pwWo/Bh4=;
        b=W3qq5QvvR85wFsgq/ry8yvv8/5cSi6iMZQWcjGCaTq4K/RfYP7sYAxt3AXkdBX4IVe
         k0FIuuWu0m6FiGlXDwbv1MFg1CtHaiOu7UZgMiGWGLWibwRSzC+mxVPFZWoY7wL3wpSg
         O6hgayC0Ynlx/s+hMRa2OzwGOQTVeTXiIzLhtCnX7o+TJ9hTx51En6fzDrwEoIeHd7XH
         CSCaaJSj8v0wI4O1kSd5ePP43PJbgpfIfdWNGrECOPSLimNyd9a9o900LuBafY/OKTKa
         xhjYMfg3wBjMJqXEUw3GUipw3bL9rr7WHe61Vn4lMyY7UaR54/NT3ha8s+KF8wfG1gQa
         7zIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaARH4nNsXsQnhQfpwgidA0ctatlsKf3PiWdHlG1YzcP3bycywK6ZTq2mSisVY3Sni4gOtxhwvGi+n0ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjbtb60aEOyNAJ1778g3Jv5UDGqqKWTxo938vw+fITPQVDIYZx
	pnibMehq7K7gzBxem/b/5WBC/78eHXpLhww53qTYRFIUmH82TpsLPIUf54OtAZLQk4HjmNgnPp4
	IjaB3YsJFB3iukN/mv62bc8/fBhcuXPE=
X-Gm-Gg: ASbGncuY/C1QKtDK/BUQNNZTDz7KLWBzyLSsf8af1lffmwaA1WWYjdUsKvpmBszHgmB
	gkZYv6IeVH+wLpr2n/ydCVvkR6ymeAL0ZFnRhjvVPMB0g8gPbu4nXE0rZyVRqo6++TLFO8E8VhD
	9rzY0bR7fOrLYzTjWbtqL4DLEDb9BH18hdkI2yIthy0U5X1nVAa8GslYqreCXhhmamHjgWZ8rur
	IJl1esxNjKLPbvvuSR/U+pX7JyZcKKkF3t+Mq0=
X-Google-Smtp-Source: AGHT+IEFfM4FGXJTQvWxhXUxdmWsCY/lm3PJuw9ZamSWPJz4UM3zNM8yD1Az1RQbZf5hUGrZH3eo7Ks3oQB0n6rIc2A=
X-Received: by 2002:a53:ed49:0:b0:63c:f478:a389 with SMTP id
 956f58d0204a3-63cf478a761mr8925251d50.3.1760454639956; Tue, 14 Oct 2025
 08:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014044135.177210-1-ghatto404@gmail.com> <20251014044135.177210-4-ghatto404@gmail.com>
 <e114504e-4bdd-46b9-b708-8eebc3075163@oss.qualcomm.com>
In-Reply-To: <e114504e-4bdd-46b9-b708-8eebc3075163@oss.qualcomm.com>
From: Ghatto <ghatto404@gmail.com>
Date: Tue, 14 Oct 2025 12:10:26 -0300
X-Gm-Features: AS18NWDwBpX6-RyiTxhZNQIFNlFjEHOZ4VGcSVYA_G4DwYI9zaRA-L3iyRKhUSw
Message-ID: <CAMQHOhfjsi1L+3j3TrcjEjPp3xkn94KOdsrVZvJCyUDFBBSeqg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: r0q: add touchscreen support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:01=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/14/25 6:41 AM, Eric Gon=C3=A7alves wrote:
> > Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
> > depends on "Input: add support for the STM FTS2BA61Y touchscreen".
>
> The second sentence doesn't really make sense to be included in
> the git log
I'll keep it to the cover letter then
>
> > The device has an issue where SPI 8 (the bus which the touchscreen is
> > connected to) is not working properly right now, so
> > spi-gpio is used instead.
>
> Some Samsung devices used to use spi/i2c-gpio intentionally, also
> on downstream. I'm assuming this isn't the case for r0q.
It isn't, the device uses fts2ba61y on the spi8 bus - I hosted the
DT at https://github.com/ghatt-o/ss_experiments/blob/main/r0q.dts if you
want to take a look.
>
> Did you enable gpi_dma1, qupv3_id_1 before spi8, when testing
The driver probes, but it fails to recognize the touchscreen device
and ends up erroring, spi-gpio solves this and I did try enabling those.
It also works on the S22+ with spi-gpio, so I decided to do the same on r0q=
.
> that? I don't see any obvious errors in the dt that would cause
> problems
>
> Konrad

