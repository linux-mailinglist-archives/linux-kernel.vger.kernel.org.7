Return-Path: <linux-kernel+bounces-849918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834CBD1548
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5DF3B9E99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4ED1D5CD4;
	Mon, 13 Oct 2025 03:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MMXPlJPG"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B917A2FB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760327000; cv=none; b=tqS4TdcmCfO5p0bcjKoqzTyKTqPgv9ENBqBwlqJPb1in8FoWqilgJem0cHXmkzyNJQy83fJldssMbhaM+fsTH1GUkpV7FNIWwwAktDDay5c5n8FbsexMayINarhovi4/d0glSvA7Jg5JuTUK0eedsGN12MVLKaPD/xK3oeAAx08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760327000; c=relaxed/simple;
	bh=wygU0sZqrk4vXYgg8gA9XwdSmbzeq0efQTw0qU1MWP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIIEMZBmxwwcBWLDfzGQxWVJCGYIVvLxsvIOWIrTn47Sc2YCHfQuICcEhKq8L0SikCsmDVUbWA8H2Z2KrpRkt9Taar7NC78JNuskyBVdPk1izb+Pz/uU39gf2+n2qRlKGD7UAlHcZr9z8iVTE+kMPg+Dvdg7MxEZSfCYXUUyT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MMXPlJPG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so4101943e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760326996; x=1760931796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24h7Itp/dXPzmSzIwKkei5mOBek1A1O1faMcM0/pAdU=;
        b=MMXPlJPGTGOkhyQvDffsXW4u9m74yG9FcZ7QFm4HMH3L9ek3/9sBtzz0NP4nwwy2S/
         A3MrN6DwhKFwueXTG0E4tGYDpGjIjxgeK5Fd+asKyy1vE1g/JGNHuF9teBiV/dxwhGy1
         22fiu2L3COj4UFYV6Eo+KP4GPasljCJ7MlTG/4keXLbtJvhlUPjlau5ZsknI3hdPY4yT
         eLIBQu8WVNzAa4cXD15IlmjLE4YufFVQDuUE85G7xwU2odwZKYKMBoXUKYA079mzQCN7
         nawIJ3o+5y703L46lOZ1HfsjactwbbC3Hu2Npsd/QiXyvh8jrf3Ia5dgfrx/V9tiDcgv
         f/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760326996; x=1760931796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24h7Itp/dXPzmSzIwKkei5mOBek1A1O1faMcM0/pAdU=;
        b=dImAFbD9HSwrvfNgw38/gkGW5rEUGarCQ340ih7VHNBjU7THFe2utFP1n550lVeiwE
         rPkUeJjLhCNcHJr49c2arY8L5zKWGzEsm9uqntIZou1G9rqcqRAqyi5EeC1+vph18pvQ
         +2EA1E0nvtylgmRJAspvmqu9WMUb87bgfzXiQF8TBMimASPhq8dVq/Doyt4ararFa+kv
         KR6a09wWtjowzoWapvHG+9Wmi6EySma2StEEqmDUVaTbe99rvpqpkc9/4aY4vGrPcyQK
         qQfXbjP79fFNbf8ZXYoxjvOeQQ1D1RUwlVEe9JmcJbvzFPFIlAw2VhKPs/aVAeohNmwI
         J3TA==
X-Forwarded-Encrypted: i=1; AJvYcCUNoLziOnxfAXgAGuamERs4jPTPU0v7eUFHvqN72Z00UgWSpTu+h7VdJtXBXrvoEErl9cdp6xfgL8HddRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzMJ6JpomBtn1R1cSMOut08pxjkBepZt0e9zk/Wcdjz2MElLV
	6r4JPXjLsO9OImbhWNhkRgmH31WGhZO0VeLEfJBS+S+S+G58Cw6SWfASLOkO8pBNuFjH11B94eN
	yhh+HY1ugTyngJCTrwqo4rERYjXLLqrwls+VSYx9hVQ==
X-Gm-Gg: ASbGncvMslH2pGuxNCUgIE0H2/2RGPzmz3bGT2H4idflLMRt1veASRI0cLk+hx4dxqI
	rVUOlqUTat0qR4eFCCm09dzv34iVdDPmPd/7vRmIVc7ZFhaCX5YliDdxSFCs3zxl4ox/PJcxZGR
	GsZFCra5EGgJIaO8Hxs0sqeAj93bh+9K69bhXAOhWaN9WtzsV55/POJtuGDgDLm3um5gxglK09f
	kmetVERtb7HdIciIgT4hT2EceFQiJ1G52OD
X-Google-Smtp-Source: AGHT+IFLqPt8lp2H0oOk51fM7RvIbA2F2cktgwpcZz8FTkw5EO3QcLCoIP5IHjV7wl0Kp6w858X4FeLBGSsd7rTYW5k=
X-Received: by 2002:a05:6512:238d:b0:579:f273:190 with SMTP id
 2adb3069b0e04-5906dd5472bmr4972531e87.33.1760326996352; Sun, 12 Oct 2025
 20:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-5-apatel@ventanamicro.com> <20edc3a9-2efe-4431-b198-f00b3940777c@gmail.com>
In-Reply-To: <20edc3a9-2efe-4431-b198-f00b3940777c@gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 13 Oct 2025 09:13:02 +0530
X-Gm-Features: AS18NWCkpL-Tj809xBCjmV9NdJPyzSgVvYHUUVV9e4EHlC9UmnJAO9LfIK-j1SY
Message-ID: <CAK9=C2U+H5xZaK6g5qcytESyC9H8gkU_jEUDJanEs1qzcGgYCQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] rvtrace: Add functions to start/stop tracing on a
 component path
To: Bo Gan <ganboing@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Mayuresh Chitale <mchitale@gmail.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mayuresh Chitale <mchitale@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 2:45=E2=80=AFPM Bo Gan <ganboing@gmail.com> wrote:
>
> On 10/1/25 23:07, Anup Patel wrote:
> > From: Mayuresh Chitale <mchitale@ventanamicro.com>
> >
> > The perf driver framework needs to be able to start / stop all componen=
ts
> > in a trace component path during its operation. Add rvtrace_path_start(=
)
> > and rvtrace_path_stop() functions for this purpose.
> >
> > Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> >   drivers/hwtracing/rvtrace/rvtrace-core.c | 44 +++++++++++++++++++++++=
+
> >   include/linux/rvtrace.h                  |  6 ++++
> >   2 files changed, 50 insertions(+)
> >
> > diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtraci=
ng/rvtrace/rvtrace-core.c
> > index 7013d50ca569..109be40d4b24 100644
> > --- a/drivers/hwtracing/rvtrace/rvtrace-core.c
> > +++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
> > @@ -614,6 +614,50 @@ static void rvtrace_release_path_nodes(struct rvtr=
ace_path *path)
> >       }
> >   }
> >
> > +int rvtrace_path_start(struct rvtrace_path *path)
> > +{
> > +     const struct rvtrace_driver *rtdrv;
> > +     struct rvtrace_component *comp;
> > +     struct rvtrace_path_node *node;
> > +     int ret;
> > +
> > +     list_for_each_entry(node, &path->comp_list, head) {
> > +             comp =3D node->comp;
> > +             rtdrv =3D to_rvtrace_driver(comp->dev.driver);
> > +             if (!rtdrv->start)
> > +                     continue;
> > +
> > +             ret =3D rtdrv->start(comp);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_path_start);
> > +
> > +int rvtrace_path_stop(struct rvtrace_path *path)
> > +{
> > +     const struct rvtrace_driver *rtdrv;
> > +     struct rvtrace_component *comp;
> > +     struct rvtrace_path_node *node;
> > +     int ret;
> > +
> > +     list_for_each_entry(node, &path->comp_list, head) {
> > +             comp =3D node->comp;
> > +             rtdrv =3D to_rvtrace_driver(comp->dev.driver);
> > +             if (!rtdrv->stop)
> > +                     continue;
> > +
> > +             ret =3D rtdrv->stop(comp);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_path_stop);
> > +
> >   struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *so=
urce,
> >                                        struct rvtrace_component *sink,
> >                                        enum rvtrace_component_mode mode=
)
> > diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
> > index f2174f463a69..e7bd335d388f 100644
> > --- a/include/linux/rvtrace.h
> > +++ b/include/linux/rvtrace.h
> > @@ -273,10 +273,14 @@ struct rvtrace_path *rvtrace_create_path(struct r=
vtrace_component *source,
> >                                        struct rvtrace_component *sink,
> >                                        enum rvtrace_component_mode mode=
);
> >   void rvtrace_destroy_path(struct rvtrace_path *path);
> > +int rvtrace_path_start(struct rvtrace_path *path);
> > +int rvtrace_path_stop(struct rvtrace_path *path);
> >
> >   /**
> >    * struct rvtrace_driver - Representation of a RISC-V trace driver
> >    * id_table: Table to match components handled by the driver
> > + * start:        Callback to start tracing
> > + * stop:         Callback to stop tracing
> >    * probe:        Driver probe() function
> >    * remove:       Driver remove() function
> >    * get_trace_id: Get/allocate a trace ID
> > @@ -285,6 +289,8 @@ void rvtrace_destroy_path(struct rvtrace_path *path=
);
> >    */
> >   struct rvtrace_driver {
> >       const struct rvtrace_component_id *id_table;
> > +     int                     (*start)(struct rvtrace_component *comp);
> > +     int                     (*stop)(struct rvtrace_component *comp);
> >       int                     (*probe)(struct rvtrace_component *comp);
> >       void                    (*remove)(struct rvtrace_component *comp)=
;
> >       int                     (*get_trace_id)(struct rvtrace_component =
*comp,
>
> I'd suggest add another function (*quiesce) or something like that. Trace
> components have a tr??Empty bit that indicates trace has been all flushed
> out. Also along the path when you do rvtrace_path_stop, you need to ensur=
e
> the source has stopped and quiescent before beginning to stop the sink.
> Otherwise you'll get partial or corrupted trace. In essence, follow Contr=
ol
> Interface Spec 11.3 Enabling and Disabling. FYI: my userspace driver:
> https://github.com/ganboing/riscv-trace-umd/blob/master/rvtrace/funnel.py=
#L223

It's better to add functions on a need basis rather than adding
it now without any potential user.

Regards,
Anu

