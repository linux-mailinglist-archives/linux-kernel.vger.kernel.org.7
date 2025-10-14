Return-Path: <linux-kernel+bounces-852076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB8BD81D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A3218971D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4592730F7E4;
	Tue, 14 Oct 2025 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="db9Xkwgg"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7930F53A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429503; cv=none; b=siDW59nXgtECW6moadLctv/wNVNmHff4AUeBRU4UbMyVhMB32P+YwwqfxIVH0pIjG4N8JpEuMxop+9xCV7CPpGg2qkqGV7Q5onplBeHenZgepK/lhBHvRJUbLPEQuDZ83kTmuRasemyIADRvRH4x/66gK+3KYPvN+F57r2sberc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429503; c=relaxed/simple;
	bh=jRf7YqINEV3bz3VzIw9FGruew0rkW3g2hYiZe9BkV/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSFyrJM/b4o/+NOj06kqm8YzI8y7S1zh8V5Qn0Lxhl78EGREiw0FyRVPI8eR+G9oz8egim1rzYuB4dbXocSW2OZhM5s30r7sQqSHRH1z6BzQ2s6GJXR1HxT6f+7wyf/GyBzPLzCaZ9b42JwkFzkCZnj9q5rqII9X1CI4J15uof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=db9Xkwgg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4432546a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760429497; x=1761034297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjoc325jjBewUa+PMCJv73wF7zKdUoHfwyGW6ASR27s=;
        b=db9XkwggaIFq52fj5VBy8nLGfDS+HI+EDAYvf607o/yPHKB89UxJIerJkqOEJNabu+
         n4ohwJlbREOEAs/4iH12HMCqS8f8BJhnjFwUtQyqYqXRbI6Pv8Jx69G2J6nIpADE+hBc
         dMZSme5f+jEQTwQbW6LYGqIKguWDBex1xd/lFK9UhZQ/4gpPSsArsRyWROiklwk+S6GH
         oRn2qszcW4nYpcDer9jpX5Qhka/SZSLrIgmsu7vs94TR/C/3j7isSrQRWnkHxQnfMaw9
         I7SfoWtJjVbG+N8YP0yBVYa4KlKLQBCDoRdqDL+QLQ0ApgVEmbTs53rp50LbqQzohHJ2
         tS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429497; x=1761034297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjoc325jjBewUa+PMCJv73wF7zKdUoHfwyGW6ASR27s=;
        b=s3ieVb/HLNnev7ire4BJ0lvqe/jMEs86oZbw5LPoaRXh9IoNDV7tqkrBhoXeocbDBu
         C9Qz18kcGEDCPi9kF1I9VN+GE/EssGCNCy1DSvu8hkQe+Fa+1VRBYAY+3bgFEPP7h3A6
         +mncRfs8jsaCnTJlGYjGc9AqXYSvl8s+qBGUOzGxKsPweg6f0fIk4d3SCFOI/wZZMYKt
         Sb3LmphM7OrXYdtCsy81P2UHVO03UKdjNTuKMOrHWoJm6Oybqz0tP94xxuD9s5eD9zUW
         HzlgP+TMH4JvyigmF6NS3Yi71J1kaoOLmF+lsixGq7fQfUyo737lweqLvdTPe+5W4i0f
         mBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK2j10SEUT2Ll+HJGeaBbhxsv96lRHIgfRtBdoXgIakFh54UOEebBZTa1Mcl0x1+7ndFDkwyYGtZEvhUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9GbYCVJJqssS9ITKyqk3nj1k9lsPciC/IzMGQNS6rksbwGuA
	UBljPbtiJRmXvvl6Ae/I+rNLoOuElz20ughvevxVOIUBwrF1Vq3k2r3ZTNIw5l8Lcq8IQDFZfg3
	jZJd6lCIt1iihTbZPkTDwLiugQpj1td+B6GMEjS8iYw==
X-Gm-Gg: ASbGncuR8RbYfUQwX7IPX7czrRym6oLExO1J2XG5Nqv+NF5YyZgiVNTY4fOyBVbk8ma
	bahs0yoPgpnlFzpVM8f798uibwR+es9AfnRisJpiHP8sRDXTprR8BGKhB736X6cVHL8Pq1H0dE7
	+Kxg12iE2NTB6Jkxx0BWEVxYcqm7FM+B41YiK8hpBkN5Di1F5sMA3yjJM2ndXU8+Y/ael7r4V0H
	6xabO1OJ+DvQ1+oq1vvN4smRWgV7YNyvP2EEDf8/wRplsCc36COOzKLTVBf/UtBsvpH61I0QIEK
	POUqqoDDZ8dYNUneSA==
X-Google-Smtp-Source: AGHT+IGtEx/vxjLQYcfILlv2zX9NsM7oAL80JOcH+vHwVkTXyNROQzVhxfWjHb2rsJrrKGXRKWkc/te+HJHHsQEbDto=
X-Received: by 2002:a17:903:37c3:b0:269:a4ed:13c9 with SMTP id
 d9443c01a7336-290273ee214mr299435315ad.30.1760429497506; Tue, 14 Oct 2025
 01:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-5-apatel@ventanamicro.com> <20edc3a9-2efe-4431-b198-f00b3940777c@gmail.com>
 <CAK9=C2U+H5xZaK6g5qcytESyC9H8gkU_jEUDJanEs1qzcGgYCQ@mail.gmail.com> <69205060-6a47-4140-8026-6e5a50ad1512@gmail.com>
In-Reply-To: <69205060-6a47-4140-8026-6e5a50ad1512@gmail.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Tue, 14 Oct 2025 13:40:59 +0530
X-Gm-Features: AS18NWDB2JU-ih8bTEc-UVtcOhI_T3P9jU2EM9UEyVjJe9OcrAhVJmGT69VbA0s
Message-ID: <CAN37VV4jFyuEYw0cxU00FucgV=so5SfTon_1hdvbVuqX1QzYCQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] rvtrace: Add functions to start/stop tracing on a
 component path
To: Bo Gan <ganboing@gmail.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Greg KH <gregkh@linuxfoundation.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Mayuresh Chitale <mchitale@gmail.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bo,

On Mon, Oct 13, 2025 at 10:23=E2=80=AFAM Bo Gan <ganboing@gmail.com> wrote:
>
> On 10/12/25 20:43, Anup Patel wrote:
> > On Wed, Oct 8, 2025 at 2:45=E2=80=AFPM Bo Gan <ganboing@gmail.com> wrot=
e:
> >>
> >> On 10/1/25 23:07, Anup Patel wrote:
> >>> From: Mayuresh Chitale <mchitale@ventanamicro.com>
> >>>
> >>> The perf driver framework needs to be able to start / stop all compon=
ents
> >>> in a trace component path during its operation. Add rvtrace_path_star=
t()
> >>> and rvtrace_path_stop() functions for this purpose.
> >>>
> >>> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> >>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> >>> ---
> >>>    drivers/hwtracing/rvtrace/rvtrace-core.c | 44 ++++++++++++++++++++=
++++
> >>>    include/linux/rvtrace.h                  |  6 ++++
> >>>    2 files changed, 50 insertions(+)
> >>>
> >>> diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtra=
cing/rvtrace/rvtrace-core.c
> >>> index 7013d50ca569..109be40d4b24 100644
> >>> --- a/drivers/hwtracing/rvtrace/rvtrace-core.c
> >>> +++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
> >>> @@ -614,6 +614,50 @@ static void rvtrace_release_path_nodes(struct rv=
trace_path *path)
> >>>        }
> >>>    }
> >>>
> >>> +int rvtrace_path_start(struct rvtrace_path *path)
> >>> +{
> >>> +     const struct rvtrace_driver *rtdrv;
> >>> +     struct rvtrace_component *comp;
> >>> +     struct rvtrace_path_node *node;
> >>> +     int ret;
> >>> +
> >>> +     list_for_each_entry(node, &path->comp_list, head) {
> >>> +             comp =3D node->comp;
> >>> +             rtdrv =3D to_rvtrace_driver(comp->dev.driver);
> >>> +             if (!rtdrv->start)
> >>> +                     continue;
> >>> +
> >>> +             ret =3D rtdrv->start(comp);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(rvtrace_path_start);
> >>> +
> >>> +int rvtrace_path_stop(struct rvtrace_path *path)
> >>> +{
> >>> +     const struct rvtrace_driver *rtdrv;
> >>> +     struct rvtrace_component *comp;
> >>> +     struct rvtrace_path_node *node;
> >>> +     int ret;
> >>> +
> >>> +     list_for_each_entry(node, &path->comp_list, head) {
> >>> +             comp =3D node->comp;
> >>> +             rtdrv =3D to_rvtrace_driver(comp->dev.driver);
> >>> +             if (!rtdrv->stop)
> >>> +                     continue;
> >>> +
> >>> +             ret =3D rtdrv->stop(comp);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(rvtrace_path_stop);
> >>> +
> >>>    struct rvtrace_path *rvtrace_create_path(struct rvtrace_component =
*source,
> >>>                                         struct rvtrace_component *sin=
k,
> >>>                                         enum rvtrace_component_mode m=
ode)
> >>> diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
> >>> index f2174f463a69..e7bd335d388f 100644
> >>> --- a/include/linux/rvtrace.h
> >>> +++ b/include/linux/rvtrace.h
> >>> @@ -273,10 +273,14 @@ struct rvtrace_path *rvtrace_create_path(struct=
 rvtrace_component *source,
> >>>                                         struct rvtrace_component *sin=
k,
> >>>                                         enum rvtrace_component_mode m=
ode);
> >>>    void rvtrace_destroy_path(struct rvtrace_path *path);
> >>> +int rvtrace_path_start(struct rvtrace_path *path);
> >>> +int rvtrace_path_stop(struct rvtrace_path *path);
> >>>
> >>>    /**
> >>>     * struct rvtrace_driver - Representation of a RISC-V trace driver
> >>>     * id_table: Table to match components handled by the driver
> >>> + * start:        Callback to start tracing
> >>> + * stop:         Callback to stop tracing
> >>>     * probe:        Driver probe() function
> >>>     * remove:       Driver remove() function
> >>>     * get_trace_id: Get/allocate a trace ID
> >>> @@ -285,6 +289,8 @@ void rvtrace_destroy_path(struct rvtrace_path *pa=
th);
> >>>     */
> >>>    struct rvtrace_driver {
> >>>        const struct rvtrace_component_id *id_table;
> >>> +     int                     (*start)(struct rvtrace_component *comp=
);
> >>> +     int                     (*stop)(struct rvtrace_component *comp)=
;
> >>>        int                     (*probe)(struct rvtrace_component *com=
p);
> >>>        void                    (*remove)(struct rvtrace_component *co=
mp);
> >>>        int                     (*get_trace_id)(struct rvtrace_compone=
nt *comp,
> >>
> >> I'd suggest add another function (*quiesce) or something like that. Tr=
ace
> >> components have a tr??Empty bit that indicates trace has been all flus=
hed
> >> out. Also along the path when you do rvtrace_path_stop, you need to en=
sure
> >> the source has stopped and quiescent before beginning to stop the sink=
.
> >> Otherwise you'll get partial or corrupted trace. In essence, follow Co=
ntrol
> >> Interface Spec 11.3 Enabling and Disabling. FYI: my userspace driver:
> >> https://github.com/ganboing/riscv-trace-umd/blob/master/rvtrace/funnel=
.py#L223
> >
> > It's better to add functions on a need basis rather than adding
> > it now without any potential user.
> >
> > Regards,
> > Anu
>
> Hi Anup, my previous comment also applies to your current use case where =
you
> have encoder->RAM sink directly connected together. Having a longer path,
> e.g., funnels in between makes it worse. The driver needs to poll the emp=
ty
> bit tr??Empty (bit 3) of the control register to check if trace has been
> completely flushed. Otherwise, you get a partial trace, possibly with las=
t
> few messages missing or truncated. So, yes, there's really a need to do s=
o.

I think this can also be implemented in the component's 'stop' callback.
>
> Bo

