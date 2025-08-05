Return-Path: <linux-kernel+bounces-756231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E09C8B1B185
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4241189F875
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0626CE13;
	Tue,  5 Aug 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtdA3sxX"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709D21B9CD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387630; cv=none; b=d9WAtY60xUFFh/w4Zv6eR6mCFFfAQPuidbXfScg4Vost2YbVDQqJ9Y/3VSbpLuqeTbp7/arZU2PzzJkYzyscArQqj9wN9Wf3uGaVFX1AMRMpcHGbtabHcxA0p5D/JZa2ssrrDXmEfxrbjbDXm51d97jag+BE/lbNgobr41pVSsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387630; c=relaxed/simple;
	bh=JzfGyUk5TxqhA2fUD9yFt5uBkf1NxDzIPcarqklTieM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKrPEAg0IT3MbXh6CIKJkoibLcldeY7wqx2gqUb+KvTWreNn/I6fcvHdfNcYbIJYDPYdUiq9CxHRK8sAiefQxX79JscCaTRv5pzEyj6kvTVmL9h4Ls3xW15iGMN3U9rwTlvlKFo5hjqAXKgxxbjqTvEORrBgJ41xpamSJjf0MRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wtdA3sxX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4053598a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754387628; x=1754992428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqOH/YydyeFepQj4djKoRufGWAHZEIvnHzq3g2f3Mz0=;
        b=wtdA3sxXimEi8jCHKA3tDhJx8Qj9LE+x/NhDSNqZpensoIzscfaKorTdMboYoJ6vR3
         3JXbBbDQBdd1IYVJCbNqlIzw4YMJ+0jKB15T6lKB4shrpaIw7lqmbi8nXr3Kznc3fODp
         yrJq/FEFmIAcUr3K0eYOQVA2dR5gxEBtEs6y0J4PQPTB0+EH8bFqfwEIdgv2p5aBPhHD
         VlZ3JU3UQ5QBSV8Yy8yb5qU6wz7HsQlbzTJNY+qcZE0dvt1JmIZXQpuxmQkLtTEAsvyW
         XTsAh40BWXWCsbiEmDSUtQlNE5WhzClB8jI/vMRFPAw7LrC0y4ZkHGg7KV62Wxtz3abp
         lVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387628; x=1754992428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqOH/YydyeFepQj4djKoRufGWAHZEIvnHzq3g2f3Mz0=;
        b=gixs+9Lnklx3/GTpzISTggpm+pnsF+7mbS0hncFRvRydaD+mtFHLRo2aJIdxbswQuL
         wwnqRL3DdMBgH/nVFIN6/Etj8chXLYhFOG8UJjVTYfXNv+ZWcgCJp8R1N0ZsRfl+KKjs
         T4IMA5o0Eb9ysorWjTeNarvjFq953qsajkxGHHi4TNtA+MspozIT2xq9i4okZoqFJ8gl
         Sc91Gfq60/2w+RfwuMvKO1+iOb/SJcWJbdCnuZzYpYWTGEl1iLVs4+v2rAB5F/LQDnsU
         ro3z5h/uP3nYg4r20z6/HxFx9l+cS06f3xSGrqg8G0Eihbb4B3FsYIaVydjLkbocvg6Z
         u0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnyOUo/jY1egEXZwodQvop+ouQv0NsSfSEvn6h+d0/224JfMyDkGoMcIj2KumzKuRUFU2/sBxFphn80ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXtEzQaiYQem2zKX7mn20OvEQ73CSZzMOiCApIEN8Ja9TaZRQ
	8JPDVFt/EuMlmPb4iif8gN7GmdEihAUVKOERTl9zwPiN5CghPzZOhjNsbhe2hdcQvjrj0/o+mSd
	41dSH5GI44hWs09bBc2NBUtJhWw+CWwpVDYGvnfGxHg==
X-Gm-Gg: ASbGnctNegSiQ9N7c/1kEHehQDVT8AGr6m3A8Be4x+nXHnEaty/Y7lD/eXDKvivYOCh
	3W2UuR7phbYpqlSiGG+1yNhNcZGq5UbKIc3V3afsxmbuxNEZZlg477Vf125AEUWlr7ds1NPB3as
	YZ9aVWC4TuL4w4nOpO98x43f28PjJcAApNR7kZIZu0bp2fdJoT9ithoU+ClfooNeHlgxoDyOISv
	WcXkg==
X-Google-Smtp-Source: AGHT+IEzHAmi0MSWAu1rgQfjhSryD3cFVQRd7ATB9s5pY8kjz8u84GpsLjOHEKwVBL1zb+hkERMs+dO7ax4ayrjHp+c=
X-Received: by 2002:a17:90b:33ce:b0:31f:4a91:4e94 with SMTP id
 98e67ed59e1d1-321162d2237mr15476293a91.30.1754387628536; Tue, 05 Aug 2025
 02:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624095905.7609-1-jie.gan@oss.qualcomm.com>
 <c7cca483-f1d3-45b4-abef-ec5019ad57dd@oss.qualcomm.com> <c6f74d55-6ea8-498f-a05a-000599f93ac6@oss.qualcomm.com>
 <b5f8fce0-afe8-409b-b43d-fa9f413cd442@oss.qualcomm.com>
In-Reply-To: <b5f8fce0-afe8-409b-b43d-fa9f413cd442@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 5 Aug 2025 10:53:37 +0100
X-Gm-Features: Ac12FXwafHZ88AWPsVnZmJsBajP70fc8s8ykZSQl042YjN088WSulIMKoD4bYuE
Message-ID: <CAJ9a7VgZ61oL4LLxKSon3LXsYDtaHaPcGNxW=cwzhSOs3ea1PQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Enable CTCU device for QCS8300
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jie,

On Tue, 5 Aug 2025 at 05:11, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>
>
>
> On 7/28/2025 9:08 AM, Jie Gan wrote:
> >
> >
> > On 7/15/2025 8:41 AM, Jie Gan wrote:
> >>
> >>
> >> On 6/24/2025 5:59 PM, Jie Gan wrote:
> >>> Enable CTCU device for QCS8300 platform. Add a fallback mechnasim in
> >>> binding to utilize
> >>> the compitable of the SA8775p platform becuase the CTCU for QCS8300
> >>> shares same
> >>> configurations as SA8775p platform.
> >>
> >> Gentle ping.
> >
> > Gentle ping.
>
> Gentle ping.
> Hi Coresight maintainers,
>
> Can you please help to review the patch?
>
> Thanks,
> Jie
>
> >
> > Thanks,
> > Jie
> >
> >>
> >> Hi Suzuki, Mike, James, Rob
> >>
> >> Can you plz help to review the patch from Coresight view?
> >>
> >> Thanks,
> >> Jie
> >>
> >>>
> >>> Changes in V2:
> >>> 1. Add Krzysztof's R-B tag for dt-binding patch.
> >>> 2. Add Konrad's Acked-by tag for dt patch.
> >>> 3. Rebased on tag next-20250623.
> >>> 4. Missed email addresses for coresight's maintainers in V1, loop them.
> >>> Link to V1 - https://lore.kernel.org/all/20250327024943.3502313-1-
> >>> jie.gan@oss.qualcomm.com/
> >>>
> >>> Jie Gan (2):
> >>>    dt-bindings: arm: add CTCU device for QCS8300
> >>>    arm64: dts: qcom: qcs8300: Add CTCU and ETR nodes
> >>>
> >>>   .../bindings/arm/qcom,coresight-ctcu.yaml     |   9 +-
> >>>   arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 153 ++++++++++++++++++
> >>>   2 files changed, 160 insertions(+), 2 deletions(-)
> >>>
> >>
> >>
> >
>

You need to send a new patch addressing the comments made by Krzysztof..

Regards

Mike
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

