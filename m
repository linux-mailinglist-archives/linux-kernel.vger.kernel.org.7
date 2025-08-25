Return-Path: <linux-kernel+bounces-784713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE2B34033
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328661A84264
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BBE26059B;
	Mon, 25 Aug 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdMz6ZKv"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E8393DCA;
	Mon, 25 Aug 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126687; cv=none; b=U7yQuVLYhAS9PeTDkHpW6rh6A5uGo9H5oQ2b5bFffkfC4SMVISoznCCQBuXznWfwANzKOCmztCUHj1VySRlupld2XNWACxJH1lU0VJgOxENmZKR0gebjHLjRcETdEIBhSael1qv/T8klDRpwZFnIu/UYOIwlOFwuCybd7CrNvHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126687; c=relaxed/simple;
	bh=11VHbwvlKQoLCv/nWEKxikxqyFyxL4l99GtfkKSEPNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDKSLxJcK0itBgQi6tj5RX3FyqXRi7D5eMG02F5q/5gj1YsOhc3hSPoLj5dd+sSq/6GRDoqdxn6EORu0UeItFHI8ph3ANvVB5qzqk6rId4LBbQ40noG5T8EdtzObASQ/QM5/b6Hr0nqMfo2jqjj6DxM5uZFj+X0QaOECq7L67M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdMz6ZKv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61c51e5e826so2340059a12.2;
        Mon, 25 Aug 2025 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756126682; x=1756731482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OarwR/ERDNc0Ml+9OWlKLdmjV+iAjoP8ec7vM3/HCIc=;
        b=OdMz6ZKvFrZhTtPdU4XbJI/bQvPQyN6mIZxMe8CYWPgnhZgYG4GxzEg5/l5rIYh04N
         5LbymGwz6Bh9i1caz9/uJRjinXSwnAfnTYoyR6YKRmlu88O7JL093TFZ2rzik737rpqm
         8X5cR+pKL7mBv3Fm9cruazjxHruMGNzbdHpTQ2+Izg2/q+zxdL+vTWQscRMPs0s7p4/4
         ptCcJKBJyAQMWnIemoUTh9PPlJ8U3z6xXDkBWAy0x+1DEftw9aXSVlN/Je1CBKt14R/0
         652uAVhyvaYRUkqSd6hTZJg7vWS5Uk1Rx0580e+TnJfv2O+fhGe35LIuUqjYIKwECbgH
         vxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126682; x=1756731482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OarwR/ERDNc0Ml+9OWlKLdmjV+iAjoP8ec7vM3/HCIc=;
        b=byuq2xUlDy9QzmSfDDb/IjBVkFaCKMyNnmd/0hVIQOObeZQ48rGYjzgBMiobPBPrzo
         dsjfVHvO6u57D6piauxBT5K0z3GaAEaEQxjvgo+z2Cxyi++/v1uK2/o8UY7XmpquPbZc
         4E4vWORECT7jtAkxAW4BfUhcr7GA3smTdlnFo1CtIEkeBwQt+Mer0eeINVG14DMnUDFT
         bhQaWh1Bk2zFaWjrRcR3OCLvUmMleBHKZRgkdd2mlIEesN4Vo2QPEmNO8Ku3TPLGN4yW
         6PUlwmIbUuWiSllojM918wfsjLSO2j+wFuXdEidtNPsvKKBUjHZ4mnXvQ7J86Jy2ZUVA
         rohw==
X-Forwarded-Encrypted: i=1; AJvYcCU3yugIxMauEskSHouvZgquvuJMROr6ioSSwc4iIckOmucIg1U+4R7sEtzC61DPakrSMuHrfX02NxsX@vger.kernel.org, AJvYcCWzzm70pM36fSngIU3vIJ1GeiPjUpPqPOKWyNbOf5A462LEzUxDkyJ0YgHLx3kVXL+RKHACSAJy6NXVcrPL@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfMRRON3RY12gLol4klXQsFzR/IK3eQDkcJoSfuJkCYdK6jCC
	ip26oQZfpP+eMkyzs8N+J1u4v8VCa4fVqjiqxyh1t5Gs19NKAeTUVSqptW0sWieryQjfq75y2pm
	7Af7W2QzBH78zgfhyJ9fR7KG+eC4c/rU=
X-Gm-Gg: ASbGncsCVocO73mUYB3qrYQAKFB9Bj+CPhDDUUK+IL1Kf8Te+rxjMjhiy7Q/OBflX7k
	62537e+Y4E0hPPkdPyPXVg3nd6drToUSS21kuxm64CuDet3hBm3xXjc4i8vOxuZ7OOtnagzQJnd
	1bqfahS6UjR5QO+YKsQcwxWH/0JfdOLI9SUFBnBtkrno1o8+h0fNJQGlGKXf84gG4WWxqtkdKMD
	pEGaw==
X-Google-Smtp-Source: AGHT+IHaOgzAzLmJeyLPt5DqrZUSYGHwc/5ongY9XyH18a2Jkpiqoy7KErW13Szg0Ppe2orviqO2JQkWL38+o+volS0=
X-Received: by 2002:a17:907:3e1c:b0:ae0:d4b1:b5f0 with SMTP id
 a640c23a62f3a-afe29548f25mr992674266b.35.1756126682080; Mon, 25 Aug 2025
 05:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825065240.22577-1-linux.amoon@gmail.com> <20250825065240.22577-2-linux.amoon@gmail.com>
 <19AB5D06-DEB6-4C38-B90D-FCDD9719312C@hewittfamily.org.uk>
In-Reply-To: <19AB5D06-DEB6-4C38-B90D-FCDD9719312C@hewittfamily.org.uk>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 25 Aug 2025 18:27:44 +0530
X-Gm-Features: Ac12FXwRodlBz_UjLLJd6RTuYXAAOzs3SHAzCQ_66M5mw-OW-pZnPXMBgXjfwxw
Message-ID: <CANAwSgQT7Y9_TKsYVignTOX1AWpcK6xEEU5+Dhy6Yd=ZG4qCjw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] arm64: dts: amlogic: Add cache information to
 the Amlogic GXBB and GXL SoC
To: Christian Hewitt <christian@hewittfamily.org.uk>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:ARM/Amlogic Meson SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, 25 Aug 2025 at 13:29, Christian Hewitt
<christian@hewittfamily.org.uk> wrote:
>
> > On 25 Aug 2025, at 10:51=E2=80=AFam, Anand Moon <linux.amoon@gmail.com>=
 wrote:
> >
> > As per S905 and S905X datasheet add missing cache information to
> > the Amlogic GXBB and GXL SoC.
> >
> > - Each Cortex-A53 core has 32KB of L1 instruction cache available and
> > 32KB of L1 data cache available.
> > - Along with 512KB Unified L2 cache.
> >
> > Cache memory significantly reduces the time it takes for the CPU
> > to access data and instructions, leading to faster program execution
> > and overall system responsiveness.
>
> Hello Anand,
>
> I=E2=80=99m wondering if we are =E2=80=9Cenabling caching=E2=80=9D in the=
se patches (could be
> a significant gain, as per text) or we are =E2=80=9Coptimising caching=E2=
=80=9D meaning
> the kernel currently assumes generic/safe defaults so having accurate
> descriptions in dt allows better efficiency (marginal gain)?
>
> Stats are also subjective to the workload used, but do you have any
> kind of before/after benchmarks? (for any of the SoCs in the patchset)
>

This is a fundamental feature of Arm64 CPUs that tracks active instructions
and data within cache-mapped memory pages.
Enabling it can significantly enhance overall system performance.

We can configure more l2 cache memory which is confribable as per the
Arm TRM document.
Arm Cortex - A53  - Configurable L2 cache size of 128KB, 256KB, 512KB,
1MB and 2MB.
Arm Cortex - A55  - Configurable L2 cache size of 64KB, 128KB, or 256KB
Arm Cortex - A73 -  Configurable L2 cache size of 256KB, 512KB, 1MB,
2MB, 4MB, or 8MB.

Here's an article that provides detailed insights into the cache feature.
[0] http://jake.dothome.co.kr/cache4/

I tested with a small benchmark to test factorial.

Before:>
alarm@archl-librecm:~$ sudo perf stat -e cache-references,cache-misses ./te=
st
Simulated Cache Miss Time (avg): 589 ns
Factorial(10) =3D 3628800

 Performance counter stats for './test':

           3017286      cache-references
             45414      cache-misses                     #    1.51% of
all cache refs

       0.054512394 seconds time elapsed

       0.004209000 seconds user
       0.041866000 seconds sys

After:>
 # sudo perf stat -e cache-references,cache-misses ./test
Simulated Cache Miss Time (avg): 426 ns
Factorial(10) =3D 3628800

 Performance counter stats for './test':

           2814633      cache-references
             27054      cache-misses                     #    0.96% of
all cache refs

       0.041041585 seconds time elapsed

       0.007976000 seconds user
       0.032009000 seconds sys

> Christian

Thanks
-Anand

