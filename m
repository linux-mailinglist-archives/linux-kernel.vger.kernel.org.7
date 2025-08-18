Return-Path: <linux-kernel+bounces-774000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7C9B2AD79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85D06260AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C3322DA4;
	Mon, 18 Aug 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2aitdjZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72C322747
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532324; cv=none; b=ZuFZpN8wUBxZtxxN7yC8Ex3NSgMagYvCVDy39a7zg7y8SYqM3t/SkLSHrv0B3dMARxTzV5Aa6QhOYoF7wU40we0BicSkvPLbV4aVFTr+zdST93/9S9dqxxFMiFpscTAxFk+LwzXIS/kBaQsdt7B0eNk7n/yLwuU6lCCglIOC7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532324; c=relaxed/simple;
	bh=78CPDCFp5nzoxHHBT0nHL9r7Uu+5xAhmDWdsc9UL2k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvKQ6S2zPXi3gTIRexcvTx2Dz8zeDc50KWLTv8FeqRgcQEVTXJ4kVmhEVXr/OEiSNLEDhgpty5C71ndfqxVMRtNT3P8/VXjLIQpj2d7Ed/Wy1GBDIu56EVF0svltYTfRcYvMRZ0+ViWF4McuQaNXVLR/1SXA55FwGNkxg6k3HD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2aitdjZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-242d1e947feso383605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755532321; x=1756137121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhFVRc1NfpOXTxJauWn9T+QK0y3Sx+B3L8yuuFsdMS8=;
        b=l2aitdjZTmfVGfN3CJ6oVjUrXnG9bwjQJbQTINeKBQL+slq96EXgJj0C9LVI9lWldh
         wgTBUvLYELlsAOoUpWHsKmNZfqP7PFEOua3QGP2cD3HbpNRD6Oopza0kKIMdnzy7BpuD
         IQ5kSgVy4+7Icc0Sfme57vP1BFJb6sti1xG319IIgkfyp5w9j8U61Ii2cKcWFPw+PHqr
         K5nN6v6avAZRAgVcCo08UkQagqc7Il4offgobk/WPTJbCfdntAMGMeeNcXsc4KyOMIS6
         fAAta10ipcJDsSjcoDgVJKI0GkMTE+nLCpf6FUA8Uj/Xs/sYA/1uC2V78AqX4hLNpB+4
         hpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755532321; x=1756137121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhFVRc1NfpOXTxJauWn9T+QK0y3Sx+B3L8yuuFsdMS8=;
        b=jdjemAenkKCmDdwM4X+isgh2fq5FfDYxOXxqRBTLTh8nj1ku8JRqB6nJ5Veag6jjUw
         ZFrStJSDhlUGDMNcBRCBFC+AdU8KEsSznsA6rcVoSkbPxK4PWXDQUmp6PAFTmeg9esOp
         XWqlBOYVPODTn7m8M+3RG3D5wADVfPZp9P7Uj7CM5iJhkoC4GszhHPIpIEDTRxSSr66f
         wJKRo53lo0ayFSThZ0h2r1O8HtyWsd3E+A8uCxSyhD+gvsBOHs+EpzcEu9RR5rZ4N/np
         SUcYYrJDMa2vQ47p26IQCWLO/cIJkpreppPiRvcOhsXXrkHKME7wf+sz7E3bJ9dJjN6N
         Y9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7iTDfqGD907PVGj0gXyN3tPiGAtsfy5IWJzExSGUukSuZ/kQTB/UkLs4ryQCXTCOXZ6yIh3krV+wSRGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVKa1RC44OJk3ZXamqFfCGMaH5I2GaU3Ny8PA6YHOlQVbKcVF
	+B86uTXbK40P+NEMNE2HHiK93WwxW5vIwfy382AJrOs7I6BJRudgNarknRO45tuOc9skcqT3hQU
	DA3K5mhp3YZQvOszhVg/j7TemhHQySJ99cUkWvQWc
X-Gm-Gg: ASbGncte9j904JkCwqcBQWLkIezM+SbshOJZmxwkruq2ICV2stNHUCuEhwPT3MugQIW
	A1u/icUCofYwF4dRUpUBUeCZjx3Mz3ID62X3ClpZzyYAXcx2GuiLCFBWNpe9gxl/WAhnV62hms0
	G1VPyKXasuaePtovPVEDP3ikGNoGjzkFQ6ugNHqJ1Wo89u/ALDYs4IPEUcSby5ZhWskj7yexA2u
	q0DD3oyfyJfhWu+LUIAKSBkKAUhGQWmx0vurnxhCyx8JTU=
X-Google-Smtp-Source: AGHT+IFBH6QXJvRW18+gfLm+VEHNtKAKh4EWppvXhfmrKKXkPioVQ+b0Kd0ODwqL4Zd3to4i9UzRN7iKxM94h8uE8ug=
X-Received: by 2002:a17:902:e54e:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-2447a77afebmr6549035ad.13.1755532321031; Mon, 18 Aug 2025
 08:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org> <20250814-james-perf-feat_spe_eft-v7-8-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-8-6a743f7fa259@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 08:51:50 -0700
X-Gm-Features: Ac12FXyV1x2afpy-E2EhDR_cSfBMqeVdgvNI2wMfxjm0rwNa4JtVzwidrn9_Mpg
Message-ID: <CAP-5=fXBot2K0MR9t7o6J7-FihNXzKcotdF6p3bfL7DwqR9jfg@mail.gmail.com>
Subject: Re: [PATCH v7 08/12] perf: Add perf_event_attr::config4
To: James Clark <james.clark@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:26=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
> packet using another 64-bits of event filtering control. As the existing
> perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config4' field.

Somewhat off-topic, imo it would be nice if we could land:
https://lore.kernel.org/lkml/20250603181634.1362626-1-ctshao@google.com/
and show all the config values via fdinfo to better allow tools to
diagnose when PMUs are busy, etc. The patch there tries to be minimal
and just reveal config (even with being minimal the patch is stalled).

Thanks,
Ian

> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  include/uapi/linux/perf_event.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_ev=
ent.h
> index 78a362b80027..0d0ed85ad8cb 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -382,6 +382,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER6                    120     /* Add: aux_sampl=
e_size */
>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_data =
*/
>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: config3 *=
/
> +#define PERF_ATTR_SIZE_VER9                    144     /* add: config4 *=
/
>
>  /*
>   * 'struct perf_event_attr' contains various attributes that define
> @@ -543,6 +544,7 @@ struct perf_event_attr {
>         __u64   sig_data;
>
>         __u64   config3; /* extension of config2 */
> +       __u64   config4; /* extension of config3 */
>  };
>
>  /*
>
> --
> 2.34.1
>

