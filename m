Return-Path: <linux-kernel+bounces-768789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D680B2657F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833331C85F33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4545D286436;
	Thu, 14 Aug 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onMOQbb2"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110E2EA160
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175058; cv=none; b=fPqsOTTh8tSNbVuWUHOaoQm+lbcX8oDftqSaN4IXJQYU/5Ry6hONf3tVP+NaNBMRTSVD+RYxSzUxAS+N4450+VctomJW5jN07zTIUhYAdFJ25g9L2g+WG89O5JDRxTTW2NfVp9VOpyjCnFVYH/7xxK7bEFwAVBErChN77PWU3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175058; c=relaxed/simple;
	bh=c5vSJaIThkKie9e5z3BpvRyqmQ04ukIKKeNTi4Akz+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foGGsmkHlILkfwcNG2bqFsCT9O/NLyyqjbdH7pZYSWfwtbG4vsPyqjVYKbpoSROWhe1Jq1TwPh+rcZUQoIVLCajk2Zy2oToX5pQbdla4NlevyV88cK3rA9J/EOcsz9uCqHiBR/MoD1jikDhAj2VtVl1xl9BNsUtnL8TQqucRo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onMOQbb2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e7baa1so796085a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755175055; x=1755779855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l8NIrhvWA3XT+D6ry67eQSgPW4LGM+PP71oE6xphaZ8=;
        b=onMOQbb2ThzPF793qH+3DWBTmTe9n25MNQ9JcgAi0g28CddgQxGDm2E/g4CqK838d5
         gHcYtY6V1tYMlFzLrilniHZ06SON446ZyKWr5dXeuJZgpLuE8+a4nQBDC+aeSSl8z1QA
         n/Aps4JksJKJhSiraUFALXViUSgnCdaDVxbRi5iQqZf+E/NzhueXeo6zl2Crt734eUhk
         jLRGXLjiRZRNZBo+VXxZpHteJ1MQigOYUXoSsAsZUfzmZBuUCvyfohq/eXLmowjplphk
         FSzcnusa/a101g5lYwRx21uL92uagH+f8TEpppiZg89PW1+/w5e/fltn9BPmc4t5pTty
         ubcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175055; x=1755779855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8NIrhvWA3XT+D6ry67eQSgPW4LGM+PP71oE6xphaZ8=;
        b=suoL8LfzAqY2Ishooic0vzwbjSwmAotPBcHapZTbC481Fxg6fnpOL99eQX0fGyS6XU
         41IkTP65UlhvaKlsRf6RzG4gE31A1IBSmTamAPVM1MUH/+Z0+bqI1CYRpgV1MOspvIhK
         wBobma66Sadlz4jHHZbwNuHkVF72gLpAtDG2+zyKvuG51xNFVi6V2mtXdLn2PDn8tlDY
         ehJqaRUWV1gSnab/TeU4FrjnE+UyWXaad3UL4tVlxWRe1AlxZeEnl8W0S0rIok7+3eMF
         HBT7+nhvUTE5w9xEMddw0Gro3A5OnEC+SMbgvKtcea7S4jjCn254LBgszl8ct/KTUigg
         zH1A==
X-Forwarded-Encrypted: i=1; AJvYcCUAJQCECf5cnkLZD0zVygkgMaKegFzKVTa8jgnHIdZTH9WGvaIcdv8pAc7AAmrYiReUgiHkCAFY0fbQSyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywQmTk4QjCtrKgjNlRFkYCHMUoT+ea0z3ZnVAAYPdYbPMy+tP8
	stzTq/1/Ym4H2wWXGo0/5qPQEHsFfpJV+wbRRCS/Rj5FfSZjdziYfrkcKXxssUUbXyfIChkg1kn
	iJjGc60UjajX5+/JEgGWY1JI5X5xOmw7YpzYGcw6GIQ==
X-Gm-Gg: ASbGncvw1egiVwMHTJlT6YkbSmfidkK8ElrgZHPOmeU+fQDUQA95sUnicJTQkvDT30l
	q7bPvZIyC2Lg4lr27mYMpFCHA9FpXgs6FQk3IQrszBQQXj44uVrVYKwCJq1UbNw6VUXm19wyBzR
	9gcVGOqlOT5t2x2L6IAzQS4tpPCPPGgim8CDEd4kkSINJSLrwI3afXCoo5Or6sVP0CMyPj86B/h
	47kYMyc
X-Google-Smtp-Source: AGHT+IFp5bAV3mlCwQE02uvVSf6ZahrQODia4B5N0jsqEGKT7zYD/rS2C/DAdPrSOa20N/yIekDRogPj27rDkMSmcHo=
X-Received: by 2002:a17:90b:3d46:b0:321:265a:e0c2 with SMTP id
 98e67ed59e1d1-32327ad25femr3514452a91.32.1755175055180; Thu, 14 Aug 2025
 05:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org> <20250811-james-cs-syncfreq-v1-2-b001cd6e3404@linaro.org>
In-Reply-To: <20250811-james-cs-syncfreq-v1-2-b001cd6e3404@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 14 Aug 2025 13:37:23 +0100
X-Gm-Features: Ac12FXwNdxfp1DMoW8IPZs7kHmN3duHawTMxGkhLBFv3GFYUtE-A_kMdlr2VOJY
Message-ID: <CAJ9a7Vh44rYWN3mjHPBq8pkBcPuhS2pTBZNaMpWgJECmPZtupg@mail.gmail.com>
Subject: Re: [PATCH 2/6] coresight: Fix holes in struct etmv4_config
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Leo Yan <leo.yan@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi James

On Mon, 11 Aug 2025 at 10:32, James Clark <james.clark@linaro.org> wrote:
>
> Lots of u8s are mixed with u64s and u32s so repack it to save a bit
> of space because there's one of these for each ETM.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 746627476bd3..a355a1e9606d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -832,28 +832,33 @@ struct etmv4_config {
>         u32                             vipcssctlr;
>         u8                              seq_idx;
>         u8                              syncfreq;
> +       u8                              cntr_idx;
> +       u8                              res_idx;
> +       u8                              ss_idx;
> +       u8                              addr_idx;
> +       u8                              addr_type[ETM_MAX_SINGLE_ADDR_CMP];
> +       u8                              ctxid_idx;
> +       u8                              vmid_idx;
>         u32                             seq_ctrl[ETM_MAX_SEQ_STATES];
>         u32                             seq_rst;
>         u32                             seq_state;
> -       u8                              cntr_idx;
> +
>         u32                             cntrldvr[ETMv4_MAX_CNTR];
>         u32                             cntr_ctrl[ETMv4_MAX_CNTR];
>         u32                             cntr_val[ETMv4_MAX_CNTR];
> -       u8                              res_idx;
> +
>         u32                             res_ctrl[ETM_MAX_RES_SEL];
> -       u8                              ss_idx;
> +
>         u32                             ss_ctrl[ETM_MAX_SS_CMP];
>         u32                             ss_status[ETM_MAX_SS_CMP];
>         u32                             ss_pe_cmp[ETM_MAX_SS_CMP];
> -       u8                              addr_idx;
> +
>         u64                             addr_val[ETM_MAX_SINGLE_ADDR_CMP];
>         u64                             addr_acc[ETM_MAX_SINGLE_ADDR_CMP];
> -       u8                              addr_type[ETM_MAX_SINGLE_ADDR_CMP];

this is 16 x u8 - could this not just stay here?

> -       u8                              ctxid_idx;
> +
>         u64                             ctxid_pid[ETMv4_MAX_CTXID_CMP];
>         u32                             ctxid_mask0;
>         u32                             ctxid_mask1;
> -       u8                              vmid_idx;
>         u64                             vmid_val[ETM_MAX_VMID_CMP];
>         u32                             vmid_mask0;
>         u32                             vmid_mask1;
>
> --
> 2.34.1
>

These attributes have been functionally grouped for ease of
understanding. If we move the _idx values away from what they are
indexing, we probably need comments cross  referencing from where they
where and where they have gone to.

Mike


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

