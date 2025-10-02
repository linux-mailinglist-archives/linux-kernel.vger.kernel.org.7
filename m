Return-Path: <linux-kernel+bounces-839879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7091BB2A20
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAD916C95B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3E928F935;
	Thu,  2 Oct 2025 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="I+tBT8yQ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329127FD4A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759387179; cv=none; b=tOyfzPX0g/GZHQqZC4OtGAYjgcKHWwn4MQewLcPlJUuWFwvgB9q20U1o+95m+J7x0Ge7+ZXW4X/M2w9tq8aAgWQszCvum/ARUsXFfyceqAWkAb1/qU33DhLzU609jztzVCSGcmGymu03fIDog8/V/1vkgDfBSU5ARBdlp38sLbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759387179; c=relaxed/simple;
	bh=h07yeJrXp0KKWyT5NM4k8j6HoCCNDDRyu8u/h//9b78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eThCkCubW++7Ka06PQMlrhj9i4owzJ8A1zXpjFDSFjuYSVaU3Y27Ua6IKUfsiRbclAjBq1J4jzRu0pbzWNPKAnATnqhAtCMlxFefIaGCA/zdjS28SUjCiZ9DMlzy09yXcUm1OuY4S8Bk2TVs937JDpJBV7yJW1eK6kHCRep/mws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=I+tBT8yQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so126807566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759387176; x=1759991976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap0trZKBpNWQl5/rOaHJpgxg2gWd6IXjcEn0D7NKp8s=;
        b=I+tBT8yQXpb07ICKiaQPfBkQ6Fi3uj3/SAZ4UIpAVqGP0kYC3p8OkUxy11Hjmytg4q
         S1TqHE3JdTY06ATjQl1Ewsq+uvcRAa9dfEegB8p85rOTzxhkpb1AHPVqoNNx+YTiFL9l
         XxuLuHMXTX9nHMy7+NqxfCrVs0OBZdc9DEy+s3HlaX6ZQJRKCJAxU3rM3wWKuOBP+JOe
         jUxpTzNIYEEyitZ0PMslZ2fWFUUc4FJEyYMGdojbkuHQX/czrFv2BiZnxUM8+urp8WeE
         mcsQ4EZgRd3ZDQs6z89OSandVfzNspFghnVLn6xI8P44x1jVe2Shd3XSDN1wANPMdSz/
         gIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759387176; x=1759991976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap0trZKBpNWQl5/rOaHJpgxg2gWd6IXjcEn0D7NKp8s=;
        b=MXGeu0GdQvhjA7btgR3XHgYB7tlW3HFWR5v9jCZ9QZ4j/JmcvS9pUQM3m90CPkTecu
         0rkI9mGNT0/IQ03eYlOzqPizeuv0wglxea0Ru1m6En2+CdAI10Asreh53utHmgVb+psq
         n26iQp4C0s8RJKYKARz7S56qhCeMOr+Hk/gyKEVTIIX1zqUak2u/C04wuU32VSg8GrDv
         42znwvj9sX5rAGm0VJczulWWcXzFgC6q66uDzkT0tmoEszy6GiZStwZ6L8qP828Li+fl
         +bSP7D9vPtc2y4vtkFJhAx7pYNjk2HFWT1h2wBBwLi0EhkrUNqQZU4ZtlvGO7XQ4jRfx
         vxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHq0KVZ/BLEKU4ZDIFgVZzHfRcYaVz2YPvtr98Lh7vJYXgqwDFHhvOITrNpsc76o8flvSR25oApcNwTbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvNQ/EEusJrenEp5h4YmTZYByS77YC5Sk2squ+9NdCZRLgX+Q
	SddbRI+f1aPNJHuTume8xUJjhIpQEnPzzy/ulJT9N8LVxHjM6aAPuUsG0pyjgza8OS7r59g+vfd
	b36Inu7OZZZKHMsqQzee4atcZ5zJFuqmJ1CPeRnzgtg==
X-Gm-Gg: ASbGncselzzwuqAmHLo/ldSc3uxkTfSwVvApihaFpZ/gVlzahoMtpQUofeo4hRke2xE
	+uON1iHeGb+TSjX7FKPU6jILUoJPEeie8p6Av81YLOZ/GQTkvENjBCDI46QtrzrvQMcg66jyhff
	zx3RjN58x6nRVPGHtO8zFHnMngvZUy2tJH9b1nMlyU0RqQXM+GPThjBQbWKoI9fRqVHEosYwQ8W
	YrI+xYepD+AVjJntlKv2mXAan+ibok9
X-Google-Smtp-Source: AGHT+IGUnzkdj2lcswlCqZDgs5Ku4aNkdI+TCKF6++VOCgMZT/hqD8+gC7knGTQNNiNEvjduQzqESNvMwlxPh6pZTY4=
X-Received: by 2002:a17:907:3cca:b0:b3c:7df0:f4a3 with SMTP id
 a640c23a62f3a-b46e4d7dbcdmr752400266b.17.1759387176253; Wed, 01 Oct 2025
 23:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002060732.100213-1-apatel@ventanamicro.com> <2025100208-challenge-protrude-d6c3@gregkh>
In-Reply-To: <2025100208-challenge-protrude-d6c3@gregkh>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 2 Oct 2025 12:09:23 +0530
X-Gm-Features: AS18NWDhJNRsJZTZD3Q1-o5Xm6vaJUsnLrA5WXVNJsHWXEPoxcIqYp1hBGzENNI
Message-ID: <CAK9=C2U9FV6crTL1G2X6tUM=RyRnPBm1dPeFc29n3vmrFTcfHw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Linux RISC-V trace framework and drivers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Mayuresh Chitale <mchitale@gmail.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 11:56=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Oct 02, 2025 at 11:37:21AM +0530, Anup Patel wrote:
> > This series adds initial support for RISC-V trace framework and drivers=
.
> > The RISC-V trace v1.0 specification is already ratified and can be foun=
d at:
> > https://github.com/riscv-non-isa/e-trace-encap/releases/tag/v1.0.0-rati=
fied
> > https://github.com/riscv-non-isa/tg-nexus-trace/releases/tag/1.0_Ratifi=
ed
> >
> > The RISC-V trace framework and drivers are designed to be agnostic to t=
he
> > underlying trace protocol hence both RISC-V E-trace and RISC-V N-trace =
should
> > work fine. The discovery of trace protocl parameters are left to user-s=
pace
> > trace decoder.
> >
> > In ther future, there will be subsequent series adding:
> > 1) Sysfs support
>
> why does "trace" need sysfs support?  No other cpu platform uses that
> today, so why is a new user/kernel api needed?

We saw trace support for other architectures (e.g. ARM coresight) allowing
trace start/stop through sysfs. If this is an obsolete or not preferred app=
roach
then we will deprioritize and possibly never add it.

Regards,
Anup

