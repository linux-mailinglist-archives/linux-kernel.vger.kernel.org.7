Return-Path: <linux-kernel+bounces-774509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F9B2B359
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A280B683465
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14CA272E6E;
	Mon, 18 Aug 2025 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJxWWGVP"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF7212B31
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552511; cv=none; b=SDGlxmtDJSGqaerhyMx+HbVxLzSEangmHxdCmftsQncw6w0/Ogc9RYD52oSwMPuZ+9L+ojz2AMrL2i6g0axMOvL7wGw6myaP4JovgKdyiOcmnp5KeWGouoNTXMwe54S17jXLgWWYQPpkv6kb2nTatc4ATW+Pf5dioZDdo9OVuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552511; c=relaxed/simple;
	bh=hs8qkxTA5j59P2IY9eFZnFm4hPrDXvyb5CjssRh6h/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CONz9kXPuZd/XX6ayGfSG8qUB2vJK954sozpgH00/ht0yUD44dl2yFjaEodu+qxGUniRmakzvZ9oC+Fe9qCrCwElDNtaMllKCNi6K55uWeuRVM6WA/nN6ZC3/QO8axoIQOq7NdFRqXO4SMDw6mB6vzHhmoFLSG9i5is9KGwkik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJxWWGVP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-242d1e9c6b4so70865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755552509; x=1756157309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tljew/FvMM+Bvz1Y1NbElAWGsKzuwgsJhb63T1N15jw=;
        b=VJxWWGVPtoM+CFtWmmWRrhBw0i6NJivRRw7UvBbjY/Vj5LcVuKQ+2yhi63/sK/arhO
         GHY1YcGCcefmp42AQpekbfcIAyBwrjIbWoGBoCm1LC9wTBpfDP8OzJ0YIA+m45vbqReq
         0gyQBbdVJENGFb9piuOTgDLwm35KdlXkVZhHkhizEiok87jcyYqow39GUfryTjr44mV+
         8jM4ZSupy+p3SR5Iies1QxURvxLlC18NWswSLTYjdoiuicoyVMGqBnwXBDAp87wiphSb
         zebtb2f1d+S/0VccEuty68BBJPFv31QEVmTA5WPqoW5Fo6Ox+Fuewol5PGKr89iSWi5k
         eYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755552509; x=1756157309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tljew/FvMM+Bvz1Y1NbElAWGsKzuwgsJhb63T1N15jw=;
        b=ZKr5P9B2DhqGLhkbsOuqPEtjx9WAROFuy6fCOF4XYUlsAVuqzXr6Z6CmRmUkJ1BD+n
         IM/G5WGCJChvri3fd7Rjrc+7rJZ/4rZIpjZBEL1UYq2lIBnT0Vfmf1qzvhNXUONCVBNd
         yuGOgWUwJQdkG/Q5DLbo/2pa2ONIQOXhzX2anKP006seefCyRZm0BZPyQIl1f2NqUPE2
         ems+dvb2+LI534gIqdCDwnyZiaHAR2Yh9VrRT2k6mfz1tuYsTlbdiXYFsWXowGzqYSOz
         iEFqf49IQnWE0eHe1s/d/2PVthfyCD3OyUOm5iyuf4m0aocjaxKVgjhToY+yhLoC8BJl
         u88A==
X-Forwarded-Encrypted: i=1; AJvYcCU/XG8lMtjaFCU1sExVcFK1EXTQHH9cS3u0SHV10O0WyLt5LKz1mlyMkS4UyY4NCINydjDAQHViaQidqms=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIbLnK7+WbKeqpykE3QgWJcjuKaZiD+XPQQLDUdYlfGKBRSun
	3WCd71Hci/Gm94XHWAfyUlHDt17SvvRwkOkxWQqQ3d3YR9gz8/+w5RIdTU785Kx2Xz/XAK4yx9q
	5J80mraqUmEXVUh+kiDTpLC2EHpBDDwOCcdDUmoVP
X-Gm-Gg: ASbGncuh9Ttyc/m/Rc5gwtotrCtAu8RSEBh9n9GfxskObTrIHkrp0/kyIOOejTM+PFP
	9dQ8sGI6QmOSKmuIcI1hx4Zb5wpjpIITL8jzHMom0ubGGIrXPlrQgC4byhVogi/uG9Key31Vzsg
	T78xqMAUHZr1g96RqDlbATi+uf+dbHn6rJiWsq1jgYdH3dZYuFbgYS5NmPe4hEGPeedaEGXFokc
	skAtky34HhWKzoxkd14ApWrnMtfAQ0YXGv5Q2c2I3w=
X-Google-Smtp-Source: AGHT+IEvmUsh0EpgL+byQO090hesxv5R/PZ+PvBmMG6FWHL72z8WO6btZxW4XOLbjFUvk3h4fDS79aSXDTFeQqfIIKs=
X-Received: by 2002:a17:903:230a:b0:240:2bd5:7c98 with SMTP id
 d9443c01a7336-245e0635939mr233215ad.11.1755552508729; Mon, 18 Aug 2025
 14:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815072008.20214-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20250815072008.20214-1-zhaoguohan@kylinos.cn>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 14:28:17 -0700
X-Gm-Features: Ac12FXyQ4iMHhiz0Lurau_F_zl9zOidUM5BUNSOH5PJ0ctLCgEkqCUqrqRbV9ro
Message-ID: <CAP-5=fUWP46kdXY4xaA6QzqG+Lj+b4ZGQmjrMKzXZpwSg60idQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf parse-events: Prevent null pointer dereference in __add_event()
To: zhaoguohan@kylinos.cn
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	thomas.falcon@intel.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 12:20=E2=80=AFAM <zhaoguohan@kylinos.cn> wrote:
>
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> In the error handling path of __add_event(), if evsel__new_idx() fails
> and returns NULL, the subsequent calls to zfree(&evsel->name) and
> zfree(&evsel->metric_id) will cause null pointer dereference.
>
> Extend the goto chain to properly handle the case where evsel allocation
> fails, avoiding unnecessary cleanup operations on a NULL pointer.
>
> Fixes: cd63c2216825 ("perf parse-events: Minor __add_event refactoring")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

> Changes in V2:
> - Extended the goto chain with separate error handling labels instead of =
using null pointer check
> - Reordered jump targets to avoid accessing NULL evsel members
> - Added Fixes tag
> - Updated commit subject to use "Prevent" instead of "Fix"
> ---
>  tools/perf/util/parse-events.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 8282ddf68b98..8a1fc5d024bf 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -277,18 +277,18 @@ __add_event(struct list_head *list, int *idx,
>
>         evsel =3D evsel__new_idx(attr, *idx);
>         if (!evsel)
> -               goto out_err;
> +               goto out_free_cpus;

nit: can we call this out_put_cpus rather than free?

Thanks,
Ian

>
>         if (name) {
>                 evsel->name =3D strdup(name);
>                 if (!evsel->name)
> -                       goto out_err;
> +                       goto out_free_evsel;
>         }
>
>         if (metric_id) {
>                 evsel->metric_id =3D strdup(metric_id);
>                 if (!evsel->metric_id)
> -                       goto out_err;
> +                       goto out_free_evsel;
>         }
>
>         (*idx)++;
> @@ -310,12 +310,15 @@ __add_event(struct list_head *list, int *idx,
>                 evsel__warn_user_requested_cpus(evsel, user_cpus);
>
>         return evsel;
> -out_err:
> -       perf_cpu_map__put(cpus);
> -       perf_cpu_map__put(pmu_cpus);
> +
> +out_free_evsel:
>         zfree(&evsel->name);
>         zfree(&evsel->metric_id);
>         free(evsel);
> +out_free_cpus:
> +       perf_cpu_map__put(cpus);
> +       perf_cpu_map__put(pmu_cpus);
> +
>         return NULL;
>  }
>
> --
> 2.43.0
>

