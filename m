Return-Path: <linux-kernel+bounces-814132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF83B54FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B055A599B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168F530E852;
	Fri, 12 Sep 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffQiWbGc"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF373303A13
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684111; cv=none; b=IIyOXtNJQZkgKIsxWuoZ/yjad8ejE/7oYr2Nf2iT/6QLq1mvbh7yWKd7a+IW78nRcnWRb3Ca65J1JCPqhsY9RwjOPACDz+3frqL6GqywM8xc889l3fV9DanLrsxUo3LR0t4T+TYEq4KGFUdkQTzhIGJ8dcWtFkjNQ2AikQFH08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684111; c=relaxed/simple;
	bh=Mw1uqYx7xqErJ7dWKzMJLyxHHuWnHuDvctPdOSnJ6Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usWM+Sx1E3DjxID61R0oJWNVbrGdlwqbpi1vOsIbsTfuoHChUYHZvLfv3pw/yQI8sur0AEptqD1ky9E6B2yV48feja2s6uw9FEhVHJCedYn2SmFJ+Ozi8Mu0yZPwHA08/2rzX8YGd58Q3it51oRZuCUjVgjZ2WgxyE1IdUEno1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffQiWbGc; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e94d678e116so2009759276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684108; x=1758288908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oif+Qq/ko4e9IqPBpRdx3M/nH7onkOEoHN9rr45t7A0=;
        b=ffQiWbGc8jBI0/MMekKJOTGkZ8I5gVMNordx3lAAXmMexZijDRX/sDFrNJ3Ypu1iEM
         SHIZsWei5E7e5pkXjsTysVPt0NtxGHy6FR8zcwp58R7e0lasL+xCANzO8/WS6UeP4JRn
         pmf9tutWHLs+bL0uBzV9ttQ0x0eOTZaJs9Y2Lmx+5TKgq+ox+i2/MePnp7cUx0WpPOBD
         yOYNJudMtypBBjyesWYlU2BRbqBWFzvMoqCwhzkGiTvzxGY01RT+weROfGd9SGZgv/R1
         862GSVo1ZFhrPWa+Cji/qFWzofTLJ9zu7FAMnQ6yF8f1FNFXAfO9UjKTlI715jxsXB4k
         VweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684108; x=1758288908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oif+Qq/ko4e9IqPBpRdx3M/nH7onkOEoHN9rr45t7A0=;
        b=mZujZj9bPCVgsOX0o3HdO20TdmFCwTywGGT0OJg3NyIOXtx5HL6Ihiv1C20U0FOucm
         ZZVe8mvUdjZoAI820XuI8CB9ezEt/tzP8LFDdsk+OrO4gy0FpF4OD5+89huyKizX5IiA
         s/mv39pxGu1xQk+InojDOGgSN628XPRtL7Da34xspybyZ5d8OTS+DtM9kAbWu6KLxkQG
         rD8YD7nmSGUpEFPqCwG6euhgxo5IzzNNMGUTr1hPjZH2YkCUeLJ4gbxWIf++Num/1PjY
         rccwz9PTqjMYPx0OIIe5QEV4O33vILp1Bhx1HiPXhxEtBmyDD8gsVKEX+sIbcQUS8PJG
         ebSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXEKfzjZMB+CQWzN/eywOR6Q+aV1UlWWpA5qWUU7MjBeL2TF0JKonEaraSoEI5ls/EYUDe1l3L6Vj/nyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmoTdgXdEIPNW+Y3zNAXyjt6Iakwy584A78XokTEu8cinC0SJ
	+3JRXoRKwvN3pCJfBZY9XUdt5n7KbgJWklYiaj7/4nel0URV/dG9i6MdZXThSqRyCUVZg+5eU/w
	8/L/huj2BCt6Oio9UKPh+fH4Gi/K0SbcFPa3E0QidGQ==
X-Gm-Gg: ASbGncvRFfkk2zB4wJhs572H6EeXHoBSjFqR/is1UVXDBTKMLWvXqcZJ+BhD+j/6AsF
	dlkse0Fair4dqzZpK4jRtMzTunSrtkKNqa/IHJrs6CNMZzW6in00AGXmyeiBQNKpgWPjhNTpeHk
	p2MfsIbCkbUXxGBjhFCma+GiF5pr70Oy2jE3s0zwr7eezSIcKTmJoonivhp/RFS7mOPumk5NBHd
	cO4EBXG3rwxCM/CQ7mU4BDVUtsaxQ==
X-Google-Smtp-Source: AGHT+IGATGH4zT90wO86AA8WBiOnGk/LXDY5uDAcwdw9i5ErydnHz9qSPT6Guu/RQKz7ZbqSt/y/uvpf3m3dqjiDPL4=
X-Received: by 2002:a05:690e:155a:10b0:62a:42ce:b7b9 with SMTP id
 956f58d0204a3-62a42ceb93fmr411217d50.1.1757684107248; Fri, 12 Sep 2025
 06:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908104122.2062653-1-quic_sartgarg@quicinc.com>
In-Reply-To: <20250908104122.2062653-1-quic_sartgarg@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:31 +0200
X-Gm-Features: AS18NWCooWdb8G6qEjRwFzci8cfjJRbJFJ2Ea7ro1afYf_iz88sxBWUweu1ZDLI
Message-ID: <CAPDyKFptA06Khx-9HFf9Vt+OUXRtVqmb++HQ3ZbZD0rjRkOsPg@mail.gmail.com>
Subject: Re: [PATCH V6 0/4] Add level shifter support for qualcomm SOC's.
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 12:41, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>
> Add level shifter support for qualcomm SOC's.
>
> - Changed from v5
>     - As suggested by Krzysztof Kozlowski reintroduced minimum/maximum
>     in dt bindings and avoid repeating constraints in free form
>     text.
>     - As suggested by Krzysztof Kozlowski/Konrad Dybcio update commit
>     message reflecting discussions and previous disagreements.
>
> - Changed from v4
>     - As suggested by Krzysztof Kozlowski Renamed the property from
>     `max-sd-hs-frequency` to `max-sd-hs-hz` for clarity.
>     - As suggested by Krzysztof Kozlowski remove min/max constraints
>     and add default: 50000000 in dt-bindings.
>     - As suggested by Konrad Dybcio moved max-sd-hs-hz property in the
>     SoC dtsi.
>     - Retained sdhci-caps-mask in sm8550.dtsi for now and will revisit
>     its removal for future targets after thorough validation and testing
>     from the beginning.
>
> - Changed from v3
>     - As suggested by Krzysztof Kozlowski moved the property from the
>     SoC-level DTS to the board-level DTS.
>     - Revised the commit messages to clearly explain its board-specific.
>
> - Changed from v2
>     - As suggested by Konrad Dybcio and Ulf Hansson redesigned logic
>       to introduce a new DT property max-sd-hs-frequency and override
>       the hs_max_dtr accordingly in sd.c file.
>
> - Changed from v1
>     - As suggested by Krzysztof Kozlowski redesigned logic to use
>     compatible property for adding this level shifter support.
>     - Addressed Adrian Hunter comments on V1 with resepect to
>       checkpatch.
>     - Cleared the bits first and then set bits in
>       sdhci_msm_execute_tuning as suggested by Adrian Hunter.
>     - Upated the if condition logic in msm_set_clock_rate_for_bus_mode
>       as suggested by Adrian Hunter.
>
> Sarthak Garg (4):
>   mmc: sdhci-msm: Enable tuning for SDR50 mode for SD card
>   dt-bindings: mmc: controller: Add max-sd-hs-hz property
>   mmc: core: Introduce a new flag max-sd-hs-hz
>   arm64: dts: qcom: sm8550: Limit max SD HS mode frequency by default
>
>  .../bindings/mmc/mmc-controller-common.yaml       |  8 ++++++++
>  arch/arm64/boot/dts/qcom/sm8550.dtsi              |  1 +
>  drivers/mmc/core/host.c                           |  2 ++
>  drivers/mmc/core/sd.c                             |  2 +-
>  drivers/mmc/host/sdhci-msm.c                      | 15 +++++++++++++++
>  include/linux/mmc/host.h                          |  1 +
>  6 files changed, 28 insertions(+), 1 deletion(-)
>
> --
> 2.34.1
>

Patch 1 -> 3, applied for next, thanks!

Note that, I took the liberty of amending patch3 to change the
declaration of "max_sd_hs_hz" to an u32, rather than an unsigned int.

Kind regards
Uffe

