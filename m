Return-Path: <linux-kernel+bounces-814306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD15B55228
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4585608FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D64D313531;
	Fri, 12 Sep 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snSNmp5b"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8803101B9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688438; cv=none; b=JmoC4NmhWmi0QAGvb4w3UmMb+k0BoGcTVDPOvw2405xDXsSruBBq4Ui+qhKnDLv5UD/oWJh13eLvkk0NMrcx5yL+s59WgTv/bFF2MHzeO7bQUJ0LZwX8lSZAdwgOjHPBFtzK8r55vWmHTyJUJBlWsqNeAzExQIGNeIx7Q5FC9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688438; c=relaxed/simple;
	bh=oD0rg6h2s8DRnh9ZlLpSygfF8WNHefSf37xINe7C+08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JW4pI7CnpVtv/6gPovNsCc51rSpiR1wGu1XbV9qn4+u+7qO1QmWR5uX+TIDuOZPIn388Ns/mGGxqNzl2O5s08xNQuduIC6hAucq7o74wJ4/FxVb/HyXqcq4Dg74GLJuMp9lHZs/zJk7B8nWlp1S9bYfHqEJYAaLEdglo5Vh65Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=snSNmp5b; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74542b1b2bcso2109517a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757688436; x=1758293236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n5DP9lHEHxCZeRxso6ploohANo8ljFzvMmesuroyCAA=;
        b=snSNmp5bTpFGV5C9ol6/nG8CtWdeXnTO+52pJjkJgqDPt6lvlMut7byEHdds97Kl2Z
         DFVYfeGA07X2ADyhnkchcl8FLnZVtQ+QN9WkNuwFeUFCAaqcBbbg6W2feK/HzQmt/6dP
         odDZmSn1hbl625f3pfJLU3LlEHjxtmjOKMfZ43ts+2uLH1es5NFkxqIt449fU+cnizlV
         tahGe3CAfZoAK5db2Q7risuJCzqxF/ZQgY0/bz95LszWGYhVHXUzF4OPzkKDVxysAhH3
         1ntiFNAG39VV9F14WpF3U5FqVYJKLFzA/wLUCOxUrkoyo9rQOuQ39liYoXrM1+DVsAcC
         OmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688436; x=1758293236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5DP9lHEHxCZeRxso6ploohANo8ljFzvMmesuroyCAA=;
        b=SR3GoJxG4fOE+4av15jcx2G8MzNqzZAD0sic6iST6FIJH1Uj1PAGEn7tpyjPCImZzT
         hXApSCfDwsQDGRvQQLifJWflr5SZVpZSV5GgMKfKH+rK6bB7BAaAWG2moObGQwqSVX4b
         kkVdVfHX0k0OIYmxrN0I6qGgIx1YeufqKxJtlQYDsWefPwxEvfsqAVhy+KK8Zg5rfd4M
         wyyj09A0yLwbiuKdPcHI8RBDh2TWuSv5D4S1s8xwriEtU1c5aaLabJ1Lw6KgCi8QiXap
         iItXwDDcef0nfoMBuZ1cQAPpFMNYD2YyamWFFOl3FDyCm4ovJVn1bqC7cRFQneSzdHOZ
         jqjA==
X-Forwarded-Encrypted: i=1; AJvYcCU/RxRlCXSe6VgnaCPnyRSm+ge4tLTJL1EoUqLQkLSWWAW1WJgB0cet2X/mkW0974tE8FxYdmwdWU5h8Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaolp1BP4XBxS3SYmUkkpg6scQAQzBnn2UyuL5h+2jpbQHKLEq
	Z27epKj/cVmHJdmAN2r9zzrcPuOttg56o84jvKS5LKUYF47siDr+jj+e3F+S0Lwx9e4tvK82Jxj
	Qfb+ax68pB2EKPmz6Fo81uuQmGq1QNQCCeL5cfIKyNg==
X-Gm-Gg: ASbGncsRq/o9lm52w+3ilk9DsAep76ZIAqfid3xCA1IdEhAnESxkAMHF28mFcvJ2DAT
	WqBN7/RY6rr8pNNBoKKauKz35Nqbm1FZPlb9yHfmqL3KGWf/A1Lz9Gb7oJ3CGIXAmIDA7vMQViv
	zG0U7RKwiT7Y7iLP3WldgpZpHmUutVzLmccC4hkjMc7hOtq/6dY0Ojxt7hty5qvmSfbm96zZC/Y
	lnpELE=
X-Google-Smtp-Source: AGHT+IGeyQqSFM5GQBH6iCx5tixN2uUYqtRIakzVl52m5pJ6MiMjEL31OlCuxkleyE+f7rCgdWR9L9hwu0O+n0AMn+8=
X-Received: by 2002:a05:6830:2115:b0:746:d4d3:c8b3 with SMTP id
 46e09a7af769-75353b6e84bmr1706635a34.15.1757688436065; Fri, 12 Sep 2025
 07:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-acpm-dvfs-dt-v3-0-f24059e5cd95@linaro.org>
In-Reply-To: <20250903-acpm-dvfs-dt-v3-0-f24059e5cd95@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 12 Sep 2025 15:47:04 +0100
X-Gm-Features: Ac12FXyJH7pruBCqQvGbq77_X-ntri0UZ8m2NLg3fLfUFTSIie9VvPVCWn3Vxng
Message-ID: <CADrjBPqb+yw0DS9ZrGhW8XSWosWrczV=nMBG4pBPvCVFDpJQ0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] arm64: dts: exynos: gs101: add cpufreq support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willmcvicker@google.com, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 15:24, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Define the CPU clocks and OPPs.
>
> Patch #2 has a dependency on the ACPM clock bindings sent at:
> https://lore.kernel.org/linux-samsung-soc/20250903-acpm-clk-v3-1-65ecd42d88c7@linaro.org/
>
> The following error will be seen without the bindings patch:
> arch/arm64/boot/dts/exynos/google/gs101.dtsi:10:10: fatal error: dt-bindings/clock/google,gs101-acpm.h: No such file or directory
>    10 | #include <dt-bindings/clock/google,gs101-acpm.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Thanks,
> ta
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org> # on gs101-oriole

