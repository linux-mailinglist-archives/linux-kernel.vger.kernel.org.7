Return-Path: <linux-kernel+bounces-709810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60836AEE2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 17:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0531897341
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5028DF44;
	Mon, 30 Jun 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6wjQM31"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD128C854
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297928; cv=none; b=JLdnW7VPj5iEHUxDzOIp4Ez15Kq6FPmKHzZYzmjMzxprN0E6fkFl5n9eKzteosaxC7MitpMyqaE3WVDuD+//RUydDuYt5O5zloVIQBiJ+DW6/X8OWNira9IL/iHOWY2vyjoKrlI/4c5T04vtSob83otTqfsyT/UVlvqMQSUm7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297928; c=relaxed/simple;
	bh=YJtneUSRYE/YcZtnrONC52bBke/mflK3Z7IJ4jYkVv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUzd8rJ9tIjMPBLvqYMrV/LkinyZsA7ZGkFTx6m31wzUUXV3V0i0JGstxlKKIHDSsa4Eig5dNkU1abXZsWt/YMPoJ2eNxzCxeDQsMvo4mLCY1yQWVR/vv1FR4Fkyy6s0TzxcRuKNkyVkFUB7bbxULBU8CcsqRRxC2RPaMvO3P10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6wjQM31; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so489365ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751297926; x=1751902726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8pHTrUEcGe6WdpAUlyhQvIpo4p8iXNvnGE/h+atsss=;
        b=G6wjQM31cYpVaTanzjuKK4S2BXOH9q9mYkZfBZ90/VjT1zoVxyWjTDy/ItN5XTM7sS
         2QQp/kdAk87elI+RHDbpDjXqde/ENtaqBwYyJ+uCna0SQB6DV5tQUErRPGj6Qpg/Bvk1
         XvdERTpK6yliAMKX9ZQsff+gGzkjrA34XJ/pPli6Os5GAzxQ75l7TZiMZ1TSrxl3yaqg
         71zwTT4uGI3s3AEhD+JSGo8MyACUTiNxZZ9eU4wGh+b36IEVCe+wQki+dvl1670OYtTg
         k+uTV9j6M+bB9YNiHRBPyLw2iY2YF/4St9FAvTwjVUDT21bJF5Jgh0DgMw+bJm+SZY1g
         bybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297926; x=1751902726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8pHTrUEcGe6WdpAUlyhQvIpo4p8iXNvnGE/h+atsss=;
        b=HslWv0Vf2cNFAIAFHDSXgPcusAfTOnY3wHz4Naml91PjDY9iR8KiwTCQY5QC3q8HPR
         HdCfeavm6uKzjqUYbqHh6S+FRABbKyiPMoEQSFWzFXUbXZkdKdXdxdhVpp8RMi++GIzt
         WBbWgQUx7TvrwKXx+5NTQNGAthn5VTmVFfXDVUyiXkwbH5r/CeGPITUSMOBJqjtsjnuD
         R/bPcTArQ1Hs/METUo/N1UMMwX7z1Tg7sSJvE0xaKGFkvrdrGZOBHx2B0Q8wQVcUYw1e
         k9nSuX5iaR5CT95suV7vkVFefey4cWYuEOfVhEZgQHe+VI5IQmufZwx6aygvY+3h4lqB
         yxFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWqvEAnu4fU94PWQIuWc45Jj9kMNw7/w9jsdx/ypwD8O0Z2xymb8k3twoi8aLY40nyyGMXDm2JQaazV8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0V/Mqk2J3i37cKSQducSWHrWasQCLJVnxJ04MA0MzWjFoofO
	D8pY+5ENhlqS4NOtKbJ133nspeThqeF3qklptYADu8EGlwUe2qDorHHJMzonzGLGCq7WiA0wmEI
	Kzmx3OYVaUPA9ATHsLmI1W+rHO4gon76mPLImNt7y
X-Gm-Gg: ASbGncv72KJj2fv7WTRYBi/oVQryqAyNY2sA/5A4Rg6xNp/q2Du2EGWTfOuvgpYlS3+
	ypIjtvjDHjFXKoVIgn+JNJv8WbiDdocSnReGDFrN3N/I9dBQpyCZeBnrF1v0X6zd/jzo3D9G6xF
	oPa91hj/dW0LK5moAiFiXWvDyvE+mh8ofQtPrwPoTRGgYBvJhW+Q3aHwiShR9/IA4UzvueQP38q
	2V/T7aZPw==
X-Google-Smtp-Source: AGHT+IHWAVAMI8QT9eGJcy1Dz/MUqM4kKkgHbIFGRnRbpDP3mlZrGKmhK69cnZjnige15KSJimxL8+8uvBWPiDVJgMM=
X-Received: by 2002:a92:c265:0:b0:3dd:d288:eead with SMTP id
 e9e14a558f8ab-3df5587f1f2mr7193765ab.18.1751297925487; Mon, 30 Jun 2025
 08:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org> <20250605-james-perf-feat_spe_eft-v3-10-71b0c9f98093@linaro.org>
In-Reply-To: <20250605-james-perf-feat_spe_eft-v3-10-71b0c9f98093@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Jun 2025 08:38:33 -0700
X-Gm-Features: Ac12FXz-XNRDh5SWs9KqIAss_dxekSdRnzTpiZe4QDr_HQFGVYwsbdMlOQVPWnw
Message-ID: <CAP-5=fU24cknDdD8Lxfshqei7Twf9zRA6uOrQNJqvAVyrzgi-g@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] perf docs: arm-spe: Document new SPE filtering features
To: James Clark <james.clark@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:50=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> FEAT_SPE_EFT and FEAT_SPE_FDS etc have new user facing format attributes
> so document them. Also document existing 'event_filter' bits that were
> missing from the doc and the fact that latency values are stored in the
> weight field.
>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-arm-spe.txt | 97 +++++++++++++++++++++++++=
+++---
>  1 file changed, 88 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Docum=
entation/perf-arm-spe.txt
> index 37afade4f1b2..4092b53b58d2 100644
> --- a/tools/perf/Documentation/perf-arm-spe.txt
> +++ b/tools/perf/Documentation/perf-arm-spe.txt
> @@ -141,27 +141,65 @@ Config parameters
>  These are placed between the // in the event and comma separated. For ex=
ample '-e
>  arm_spe/load_filter=3D1,min_latency=3D10/'
>
> -  branch_filter=3D1     - collect branches only (PMSFCR.B)
> -  event_filter=3D<mask> - filter on specific events (PMSEVFR) - see bitf=
ield description below
> +  event_filter=3D<mask> - logical AND filter on specific events (PMSEVFR=
) - see bitfield description below
> +  inv_event_filter=3D<mask> - logical OR to filter out specific events (=
PMSNEVFR, FEAT_SPEv1p2) - see bitfield description below
>    jitter=3D1            - use jitter to avoid resonance when sampling (P=
MSIRR.RND)
> -  load_filter=3D1       - collect loads only (PMSFCR.LD)
>    min_latency=3D<n>     - collect only samples with this latency or high=
er* (PMSLATFR)
>    pa_enable=3D1         - collect physical address (as well as VA) of lo=
ads/stores (PMSCR.PA) - requires privilege
>    pct_enable=3D1        - collect physical timestamp instead of virtual =
timestamp (PMSCR.PCT) - requires privilege
> -  store_filter=3D1      - collect stores only (PMSFCR.ST)
>    ts_enable=3D1         - enable timestamping with value of generic time=
r (PMSCR.TS)
>    discard=3D1           - enable SPE PMU events but don't collect sample=
 data - see 'Discard mode' (PMBLIMITR.FM =3D DISCARD)
> +  data_src_filter=3D<mask> - mask to filter from 0-63 possible data sour=
ces (PMSDSFR, FEAT_SPE_FDS) - See 'Data source filtering'
>
>  +++*+++ Latency is the total latency from the point at which sampling st=
arted on that instruction, rather
>  than only the execution latency.
>
> -Only some events can be filtered on; these include:
> -
> -  bit 1     - instruction retired (i.e. omit speculative instructions)
> +Only some events can be filtered on using 'event_filter' bits. The overa=
ll
> +filter is the logical AND of these bits, for example if bits 3 and 5 are=
 set
> +only samples that have both 'L1D cache refill' AND 'TLB walk' are record=
ed. When
> +FEAT_SPEv1p2 is implemented 'inv_event_filter' can also be used to exclu=
de
> +events that have any (OR) of the filter's bits set. For example setting =
bits 3
> +and 5 in 'inv_event_filter' will exclude any events that are either L1D =
cache
> +refill OR TLB walk. If the same bit is set in both filters it's UNPREDIC=
TABLE
> +whether the sample is included or excluded. Filter bits for both event_f=
ilter
> +and inv_event_filter are:
> +
> +  bit 1     - Instruction retired (i.e. omit speculative instructions)
> +  bit 2     - L1D access (FEAT_SPEv1p4)
>    bit 3     - L1D refill
> +  bit 4     - TLB access (FEAT_SPEv1p4)
>    bit 5     - TLB refill
> -  bit 7     - mispredict
> -  bit 11    - misaligned access
> +  bit 6     - Not taken event (FEAT_SPEv1p2)
> +  bit 7     - Mispredict
> +  bit 8     - Last level cache access (FEAT_SPEv1p4)
> +  bit 9     - Last level cache miss (FEAT_SPEv1p4)
> +  bit 10    - Remote access (FEAT_SPEv1p4)
> +  bit 11    - Misaligned access (FEAT_SPEv1p1)
> +  bit 12-15 - IMPLEMENTATION DEFINED events (when implemented)
> +  bit 16    - Transaction (FEAT_TME)
> +  bit 17    - Partial or empty SME or SVE predicate (FEAT_SPEv1p1)
> +  bit 18    - Empty SME or SVE predicate (FEAT_SPEv1p1)
> +  bit 19    - L2D access (FEAT_SPEv1p4)
> +  bit 20    - L2D miss (FEAT_SPEv1p4)
> +  bit 21    - Cache data modified (FEAT_SPEv1p4)
> +  bit 22    - Recently fetched (FEAT_SPEv1p4)
> +  bit 23    - Data snooped (FEAT_SPEv1p4)
> +  bit 24    - Streaming SVE mode event (when FEAT_SPE_SME is implemented=
), or
> +              IMPLEMENTATION DEFINED event 24 (when implemented, only ve=
rsions
> +              less than FEAT_SPEv1p4)
> +  bit 25    - SMCU or external coprocessor operation event when FEAT_SPE=
_SME is
> +              implemented, or IMPLEMENTATION DEFINED event 25 (when impl=
emented,
> +              only versions less than FEAT_SPEv1p4)
> +  bit 26-31 - IMPLEMENTATION DEFINED events (only versions less than FEA=
T_SPEv1p4)
> +  bit 48-63 - IMPLEMENTATION DEFINED events (when implemented)
> +
> +For IMPLEMENTATION DEFINED bits, refer to the CPU TRM if these bits are
> +implemented.
> +
> +The driver will reject events if requested filter bits require unimpleme=
nted SPE
> +versions, but will not reject filter bits for unimplemented IMPDEF bits =
or when
> +their related feature is not present (e.g. SME). For example, if FEAT_SP=
Ev1p2 is
> +not implemented, filtering on "Not taken event" (bit 6) will be rejected=
.
>
>  So to sample just retired instructions:
>
> @@ -171,6 +209,31 @@ or just mispredicted branches:
>
>    perf record -e arm_spe/event_filter=3D0x80/ -- ./mybench
>
> +When set, the following filters can be used to select samples that match=
 any of
> +the operation types (OR filtering). If only one is set then only samples=
 of that
> +type are collected:
> +
> +  branch_filter=3D1     - Collect branches (PMSFCR.B)
> +  load_filter=3D1       - Collect loads (PMSFCR.LD)
> +  store_filter=3D1      - Collect stores (PMSFCR.ST)
> +
> +When extended filtering is supported (FEAT_SPE_EFT), SIMD and float
> +pointer operations can also be selected:
> +
> +  simd_filter=3D1         - Collect SIMD loads, stores and operations (P=
MSFCR.SIMD)
> +  float_filter=3D1        - Collect floating point loads, stores and ope=
rations (PMSFCR.FP)
> +
> +When extended filtering is supported (FEAT_SPE_EFT), operation type filt=
ers can
> +be changed to AND using _mask fields. For example samples could be selec=
ted if
> +they are store AND SIMD by setting 'store_filter=3D1,simd_filter=3D1,
> +store_filter_mask=3D1,simd_filter_mask=3D1'. The new masks are as follow=
s:
> +
> +  branch_filter_mask=3D1  - Change branch filter behavior from OR to AND=
 (PMSFCR.Bm)
> +  load_filter_mask=3D1    - Change load filter behavior from OR to AND (=
PMSFCR.LDm)
> +  store_filter_mask=3D1   - Change store filter behavior from OR to AND =
(PMSFCR.STm)
> +  simd_filter_mask=3D1    - Change SIMD filter behavior from OR to AND (=
PMSFCR.SIMDm)
> +  float_filter_mask=3D1   - Change floating point filter behavior from O=
R to AND (PMSFCR.FPm)
> +
>  Viewing the data
>  ~~~~~~~~~~~~~~~~~
>
> @@ -204,6 +267,10 @@ Memory access details are also stored on the samples=
 and this can be viewed with
>
>    perf report --mem-mode
>
> +The latency value from the SPE sample is stored in the 'weight' field of=
 the
> +Perf samples and can be displayed in Perf script and report outputs by e=
nabling
> +its display from the command line.
> +
>  Common errors
>  ~~~~~~~~~~~~~
>
> @@ -247,6 +314,18 @@ to minimize output. Then run perf stat:
>    perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/nu=
ll &
>    perf stat -e SAMPLE_FEED_LD
>
> +Data source filtering
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +When FEAT_SPE_FDS is present, 'data_src_filter' can be used as a mask to=
 filter
> +on a subset (0 - 63) of possible data source IDs. The full range of data=
 sources
> +is 0 - 65535 although these are unlikely to be used in practice. Data so=
urces
> +are IMPDEF so refer to the TRM for the mappings. Each bit N of the filte=
r maps
> +to data source N. The filter is an OR of all the bits, so for example se=
tting
> +bits 0 and 3 includes only packets from data sources 0 OR 3. When
> +'data_src_filter' is set to 0 data source filtering is disabled and all =
data
> +sources are included.
> +
>  SEE ALSO
>  --------
>
>
> --
> 2.34.1
>

