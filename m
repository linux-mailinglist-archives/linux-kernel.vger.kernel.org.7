Return-Path: <linux-kernel+bounces-774511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAFEB2B362
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7568E189BEE2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E41EC01B;
	Mon, 18 Aug 2025 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnyjMCtj"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596553A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552623; cv=none; b=D1SDnF9x+YLbJpIfqHfPsV0IfACpfVvdgU692k3shzRFz4IVtmkvrvXaOqo8fWlKkVM7am+It0Iocj+YZ78CLMOoKR4ngCXuOa0RNIBV4D4mhfyhDVSUmb5MFJvBwc8h9Y3MxPFMGuC9GWq5MCznW15YLl2tZUpGe1zuba6DT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552623; c=relaxed/simple;
	bh=sWWwbfGZnMtusIB0fCiGSV1DGRh/FWKARAGxmZUfHqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4Ak1OVDeWoYUOsrCL1HP4Aebqo1EL4s+gvuH/Mw/A+X4JnsxP7jkyqe6KwY6IPfRV8qhZIyNnc2ZCzrEGbL0Y3ucUQla86Ot2+hY9fih6YLsrBXQ+mdamGWTLqKR862qog28u/Cl57OXiNIQewazV0FPoEMvr6HNSbr5j37nfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnyjMCtj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-242d3be6484so20615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755552622; x=1756157422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlGqJIlxYa8JPzVYG9ATkkS2RNUZQWMskrpzXY/rMK4=;
        b=TnyjMCtjrDv8JQRYEQNIvCYKhr8S/K9N1+vqxaVFnPspNqztow8vsGFObbV3Wt8g8/
         w1lqmCk20AVnpwJrqyaanhsjxHflruAFgFPBNPP7wzSIc4h1l0FlP/zk9DsvWdzkF96V
         z8uisKK1aJNV+8pnDgu80YSBCtDZcLEg/faKKV9JZ7eEfwCGOPoOu/W9LfPAF7UILxEl
         Oa6pvMCI2VnGsqr4IvSE/kzfmAJZdinw6uFyj4XdWKLxhrmjaOPoKmtaUrnK9UWhW3RL
         S1Suwg1ii89rW1M27tmlRKyv/xA9inU2RJ0as//oM9oqnAVLbNy630hHIH1cxg1+6G4R
         ty3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755552622; x=1756157422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlGqJIlxYa8JPzVYG9ATkkS2RNUZQWMskrpzXY/rMK4=;
        b=XWPfBMbqoxtPFTpjoDIdeYbC8Zq06f9/KMz39GbQji/1+cJjT3trLT8zTtOSb2ovYp
         GdxHEm01beVqumqHJXdkTkZ4bbOGkSh+YN89WmN95NZgMAp5D4N35aIqcmO98u/3HHY1
         vsUAqxj/tpLDUF7xPEq4UjBX8+uUFHWYQ2WOYyCMc71UqYTqloO18uT+5rfkiiw56U5X
         LgcMQhTA89AlLJK6ltSMcTaFGOKv6DTwHpZ1/rjp8HwRQvRCArlqVkIZq5W63L0BTMlu
         +wl9XchCQ9o+AUUmou+/k0FSDqOM8u6iSXO8SN8LN2c+DkvRQMUI7GVSwJ4KRxuXvnzL
         S4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNq8H8oPZ6D/ybMbXKxrzuKs2V4WrdehOmHiI/ap1rn/qqNI1/JTOLzO5VkwXsVRkXp+lqioVNCl5O+OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBJPXeb2Vlhtjfput36mrhpmXYbAC2XODLFaDeXYzoqgaOn52
	Jma99jGqR6lepGn+DfkrYKySt7ED7vPBlbGhgqXpaBjL7EVHtSO9EMNT6WYFEJK6JMnH6sROFtR
	aEuvEc9+kD3y65MTH0BhkHqS0gT6RQgmrPMXH8Yb4
X-Gm-Gg: ASbGnct2j0hFOe9E+FAlqQvxajb2Elb5pSpTZF9bi3hktrfIa6AAEzfYN/H15kxpCHC
	g9Oz+CUwRxfqDvZqhYO83WWFKEmMSftDabKUsG4lPGTydnVH5D30YG/sJtSJ7BiINCSIPVGh5xa
	D8R5psA7ffTm2Jr8VhkmKSdbR9n54G6hfIySGSq2HSVGJ9A4H1WbkKLIw0KyO60TEjtXW69PP8d
	sa+vtBYMz1+lvaMabIRM+TEPvSDQsG65qIVgdkYC6U=
X-Google-Smtp-Source: AGHT+IGpzjIX9dwiWXKMpvHQqGAMp7qHKE+kta0wJX1OObH6fa6pfTymKeTi3YH0pWOEbCdRHlIQ08sZYsqQ3QpK7nM=
X-Received: by 2002:a17:902:f549:b0:240:589e:c8c9 with SMTP id
 d9443c01a7336-245e00cd8c4mr568575ad.10.1755552621445; Mon, 18 Aug 2025
 14:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813033432.8943-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20250813033432.8943-1-zhaoguohan@kylinos.cn>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 14:30:10 -0700
X-Gm-Features: Ac12FXwNR5TecROABcdaMEakc_vF-IACGcE4lnxADtYA0Z1Lq05sdXbeGcof7dI
Message-ID: <CAP-5=fXkzoJJvn6h-dbTGvxkO3DEtGUfauTSZOAGPjcQMrFUpg@mail.gmail.com>
Subject: Re: [PATCH v2] perf drm_pmu: fix fd_dir leaks in for_each_drm_fdinfo_in_dir()
To: zhaoguohan@kylinos.cn
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:35=E2=80=AFPM <zhaoguohan@kylinos.cn> wrote:
>
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> Fix file descriptor leak when callback function returns error. The
> function was directly returning without closing fdinfo_dir_fd and
> fd_dir when cb() returned non-zero value.
>
> Fixes: 28917cb17f9d ("perf drm_pmu: Add a tool like PMU to expose DRM inf=
ormation")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> V1 -> V2: Added the Fixes tag in commit message
> ---
>  tools/perf/util/drm_pmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
> index 988890f37ba7..424a76d1a953 100644
> --- a/tools/perf/util/drm_pmu.c
> +++ b/tools/perf/util/drm_pmu.c
> @@ -458,8 +458,10 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void=
 *args, int fdinfo_dir_fd, c
>                 }
>                 ret =3D cb(args, fdinfo_dir_fd, fd_entry->d_name);
>                 if (ret)
> -                       return ret;
> +                       goto cleanup;
>         }
> +
> +cleanup:
>         if (fdinfo_dir_fd !=3D -1)
>                 close(fdinfo_dir_fd);
>         closedir(fd_dir);
> --
> 2.43.0
>

