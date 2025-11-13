Return-Path: <linux-kernel+bounces-899947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE14C5916A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B53CF34467C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755136B043;
	Thu, 13 Nov 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBSu7rPg"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6A36A034
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053322; cv=none; b=RBD6+vQDu22F8Le1o7dZRur61FuDl9tdkYoKrG7RupdpkzAeA5ncJhsfK9tXc1C+fH+ZWTnAJiZG+v2cy3T/NCAMF+QwM1XdP920XbuFRbb3W9GXSMqLhxaT4wZiJBAhNstiipoEd3P7dUnBZ/AlVN8a1n5Je7Nh9RyUFcapL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053322; c=relaxed/simple;
	bh=3lMEO8PnWX9b3TwsW9iffWpNPUePVf85jIdvmHCE7j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVxnUel0DpbVnMs2+nGCYE0GKj8ZxCahXMAEniAFcVTUPJtGBIpAJeJmBy4bNB+AqTJGcwc8/83/tdUqXVIvrYjSeXgFb2kdxdktHE74QTijLl1zLuPkAZNd0qOASCraP4L1HKyKKqGO/UPUTvyRr3yZ7yi3aEVi6EXpJ2zi0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBSu7rPg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295c64cb951so241635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763053320; x=1763658120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71lVmJnPUGpleZ4mKAV+ATu2lJgo6JW7DPtl5X40bXo=;
        b=YBSu7rPgAYVImkQMvsHZtfA34E044PfSk5RUJYdfs9esn17enafWLvt0uOUieq77D2
         ILySG7CaDQGd6JBafmiA8qy+MOQdtPRtv6ZFGZpUTvjnRer6UqUhw0o939oM75ci+CD4
         9lxv7AE+pdKpJRO86PKaA3w4+xmCkY1+GcMav1erL0Q2KBf+Dfk+P19xa1LN/dp8h71a
         Vu00wX6EfHqdTdK9JI2zHdVgFHmgvi5SVaDSqYEK8RkHSMxhubJxEwXYCpb57Ew8S1Of
         aatxRRw+jf5XnPoYaSNfwZWjgZxK49pnS4mBqRGdoWN3AZc5qIiU1bx7hr/dqHplGMUK
         u5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053320; x=1763658120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71lVmJnPUGpleZ4mKAV+ATu2lJgo6JW7DPtl5X40bXo=;
        b=Pg/IjZUeAGXjWqKA4VcTROOwau6DBg+8R1ORp0V4o/EOXOY91GIiMgFI84h4cGSUnv
         G+QZIEk9tbOdyn7vWzSnXU0lYD8/nLCMghFnrwS0wxMcJUKtWvepXX6q+xj3hO0EyLS0
         z9B2DjT6O3pN65xhT300XMminefqqCOXs+n0n76dHL7UGDeiLggscYo+40fpsBVfJnWj
         iiFkl7bB08zNrpERa4m3gDmRzggFqx8ePt+liE0lKqYk0PNQk+pw8Q8dYWc46TPgra0m
         EeFFukcT2vIEdYxmcam30GJsnqLE/uY8FKq5fPRBYSEfYmGokpkeL/C0NVzjj6N/9kh9
         T/9A==
X-Forwarded-Encrypted: i=1; AJvYcCX8csblRMuIZWo4tuAXEnnvTzDYIQfO1brGp0kKRejVDGazkB5SXH1+Gqg3aCwDFgsPWNm+6EFd/7oloJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIALrmA6KaCsDZCVjQ8LNEK+2Av01Kod0vNrmTx0Y8Fn/OoQxy
	aeARRGnLWyyMmyqzH97YKQlfKu59sOtNRBTKvc+axas1DarMY1p44FqVqxiHaxIq094GsnbwoqE
	ffv0e6xHCvxskpdIjToP3CxUoPGnAXHaFAD1x3Fi5
X-Gm-Gg: ASbGncvaj+C08VYTRlW+rm0VA0R1s3u0n4oSEzbQgo0wBeiU1L744IixHPkL2bODG31
	OD79teW5wV9UC3rMbp404Lfkhh63pk0rAWkLW9bBWAyaR1g/fL+JyIfWQJ4eVeDUqhcfV+0hGQp
	F5aPi+j+qe65Y7QSRNgNJukgjDL4y5pOJuLJsmC0rQozctmexSzoZcCVjzGtFudxKUfGLE6TOrX
	uktsTVe4GMa4wrXLfIb4RnwO8BZf/blaCxYzH3r99k4MAdjp8y/ATg91tozCDv2whEMavM6UOOI
	6dKcwlfIeFmQg6rqJGWbYaLEOOtWT3cQUBUc9t907GLFkJ0=
X-Google-Smtp-Source: AGHT+IGPRC+CQUBmBgdB89n61eAw0eI7sbJGyZXKLvUJxxPGOF5tt6zXBQxQuv/YyuQenUu73z2Yj6aCC42mzV1WO3c=
X-Received: by 2002:a17:903:1c6:b0:290:d7fd:6297 with SMTP id
 d9443c01a7336-2985b7b9694mr6318995ad.2.1763053319900; Thu, 13 Nov 2025
 09:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
In-Reply-To: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Nov 2025 09:01:47 -0800
X-Gm-Features: AWmQ_bmZpgw7lXxzv2FCuAKiN2hVXWb-V-IiXd3o9kNnnrnUCNcZLuky19EZHhk
Message-ID: <CAP-5=fXiiWRDPzONNNZQZc4QOBQoz=kRnJq77on5r4w9aDx-XA@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] perf arm_spe: Extend operations
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:24=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> This series enhances tooling to support new operations:
>
>   - Support for MTE tag since Arm SPE v1.3;
>   - Support for Advanced SIMD extension and SVE operations;
>   - Support memcpy, memset and GCS operations;
>   - Support extended operations for atomic, Acquire/Release and
>     Exclusive instructions.
>   - Enhance the data source for associated info, like floating-point,
>     conditional, data processing, etc.
>
> This series is divided into three parts:
>
>   Patches 01 ~ 06: Support raw dump for new operations;
>   Patches 07 ~ 17: Export the operation info into records, so that the
>                    information can be later consumed by samples.
>   Patches 18 ~ 25: Set the operation info into sample's data source and
>                    SIMD flag, and updated the document.
>
> This patch series is tested on FVP for native parsing and x86_64 for
> cross parsing.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
> Changes in v3:
> - Rebased on the latest perf-tools-next branch.
> - Link to v2: https://lore.kernel.org/r/20251017-perf_support_arm_spev1-3=
-v2-0-2d41e4746e1b@arm.com
>
> Changes in v2:
> - Refined to use enums for 2nd operation types. (James)
> - Avoided adjustment bit positions for operations. (James)
> - Used enum for extended operation type in uapi header and defined
>   individual bit field for operation details in uaip header. (James)
> - Refined SIMD flag definitions. (James)
> - Extracted a separate commit for updating tool's header. (James/Arnaldo)
> - Minor improvement for printing memory events.
> - Rebased on the latest perf-tools-next branch.
> - Link to v1: https://lore.kernel.org/r/20250929-perf_support_arm_spev1-3=
-v1-0-1150b3c83857@arm.com
>
> ---
> Leo Yan (25):
>       perf arm_spe: Fix memset subclass in operation
>       perf arm_spe: Unify operation naming
>       perf arm_spe: Decode GCS operation
>       perf arm_spe: Rename SPE_OP_PKT_IS_OTHER_SVE_OP macro
>       perf arm_spe: Decode ASE and FP fields in other operation
>       perf arm_spe: Decode SME data processing packet
>       perf arm_spe: Remove unused operation types
>       perf arm_spe: Consolidate operation types
>       perf arm_spe: Introduce data processing macro for SVE operations
>       perf arm_spe: Report register access in record
>       perf arm_spe: Report MTE allocation tag in record
>       perf arm_spe: Report extended memory operations in records
>       perf arm_spe: Report associated info for SVE / SME operations
>       perf arm_spe: Report memset and memcpy in records
>       perf arm_spe: Report GCS in record
>       perf arm_spe: Expose SIMD information in other operations
>       perf arm_spe: Synthesize memory samples for SIMD operations
>       perf/uapi: Extend data source fields
>       tools/include: Sync uapi/linux/perf.h with the kernel sources
>       perf mem: Print extended fields
>       perf arm_spe: Set extended fields in data source
>       perf sort: Support sort ASE and SME
>       perf sort: Sort disabled and full predicated flags
>       perf report: Update document for SIMD flags
>       perf arm_spe: Improve SIMD flags setting
>
>  include/uapi/linux/perf_event.h                    | 32 ++++++++-
>  tools/include/uapi/linux/perf_event.h              | 32 ++++++++-
>  tools/perf/Documentation/perf-report.txt           |  5 +-
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  | 56 ++++++++++++++--
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  | 61 +++++++++-------=
-
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 53 ++++++++-------
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     | 40 +++++++----
>  tools/perf/util/arm-spe.c                          | 77 ++++++++++++++++=
+-----
>  tools/perf/util/mem-events.c                       | 66 ++++++++++++++++=
+--
>  tools/perf/util/sample.h                           | 21 ++++--
>  tools/perf/util/sort.c                             | 21 ++++--
>  11 files changed, 359 insertions(+), 105 deletions(-)
> ---
> base-commit: da8fcfba0854dbe0b0eca465d35620c9cf4c89c1
> change-id: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>

