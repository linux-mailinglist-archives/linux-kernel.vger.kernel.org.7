Return-Path: <linux-kernel+bounces-616547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F80A98F95
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 17:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC5C17C667
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE61288C8E;
	Wed, 23 Apr 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRvoDM/R"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F7289344
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420615; cv=none; b=GOscSg85e0lQx3VY+ShYPii/EOJTNujZdoOOn7owQj0Ii5xmhfRM/9OHzdDg37YHlSwOMroORG389fdSUOVrQK0yohu0xWx32e0gQTTgnuCO28atJwZ6yNC9roqOugHWWJatjby2mkaVCdkZYe3+OJJdjFMqMQzoN1bKEI3tnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420615; c=relaxed/simple;
	bh=12qzKXY0BzwvID0wgiAUqMdZl3WivHrcHHDo50Rut44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8DD6dooNPJAwNAE4qVRerUSKFAufPZ5Rfu8yvDl3IJ+0+9xUsmnF69iEQ6EOTFVXpSEXuRSUqTWEVqPwLhHiGbPj4gCvcYJ0/SBECpe4nXmio52dp10zQyZHM1l9SgGrsBxJFjUn4Jqm2+FZ/VuGuKaS9IsJPYPaz4YUxRteko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aRvoDM/R; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d91a45d148so206035ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745420613; x=1746025413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeALuF8jKVLJRlKRLq/6pLCkpUuGmGPwZiC4ZXVfYlg=;
        b=aRvoDM/RNINBn3VK96HXnNtXxDRtiDDRdya/2pDvkjSoowT96C5NgLh3GC60RuMBJa
         eWkKA2gHmVXDv7LhhkBmcM3w3jE49BTDLtSOtoBYHK/SXfTNX5OMG2PBspKYKrpifNyp
         i67UuMd6ull83RONO+eUqueGWs6dJlWdZ2DiVw9Gi0n/BpS1jjBlF/T5KwPUhYHc4pwe
         EEzbNNvs5pniASJ71Qd6S851prvPbPllqcRbUhjC6Y8RwvLthrpjFFWHQ5AVHi44l6UU
         uqaXH8Tpq7TqNa1ko1A1NF4c6DtkPOL+OMyqk8mkePrODaZtU/MKJiJM1N+MSWSgt1rp
         YvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420613; x=1746025413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeALuF8jKVLJRlKRLq/6pLCkpUuGmGPwZiC4ZXVfYlg=;
        b=IyaSL0uHiqKtQBzJ1v++EFJHD6knIV30IA81/8nH59eDT7sBk6f7N+zwDFPX+pGGXr
         Ucf4qDhsfxThnqaXRFZhAr1OaNUJFdd007+l+wT24BTxsCEmbIyzgvDtr6i0WpATcO6T
         wtBHwYHMhqyjo/xUP7ESk+I0mhoB3y6W5eEY0yuDTm/yvnNThkSJIRKQjdBiYF+0kxse
         g6IKoQnsLwE3Cy5lC6NUzP87ckyKg501lt5PR/Ny1u/wUliEXiDDYJmal/OUsKxqBraD
         yJwIeM3xzyGIB20lXjiVajLcmFHY2nBD3sD8qBPS2sjt2ii7Vdg08mnV6R8AdfNYynEI
         /13g==
X-Forwarded-Encrypted: i=1; AJvYcCVUojhl+y+j9j60lkaiv0DIkaEanks3RAgdK2YgAxM5zqRbp+W5raS2Rk5gywYjf6nRYUAzSSCSSHfHBDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXA7Ese0JHt61tYNnMAWCmn44i0byzXFSE+mJQr+QklJeBqA0
	jCeUDNxd+GtSnh25iwkOm239uL1r93LymkD7Fygi5ZaZEW8dqH8eO83nhnS/G2ltsLfiRhhJSiS
	ACq7VcdBx7TYL7JP7w1zURWtir2129QVoWz8Q
X-Gm-Gg: ASbGncvVwRbGwdO1McpwZJKl3MHsog/G283FuaBfyvp2x8XQRaAuRk7pC2PNjb7CfsR
	Qjl5PRPodybCkgm6pP/cZx7386fccBweYTgKKc4/ud6K3dvpGc0v4BSrX66sbX9Wo7h/tWpcM1q
	BvGaz3N43Ds6fqZVGrRv+uX8AskssPSe7b9icsUOJVXBJZeg4Eq6w=
X-Google-Smtp-Source: AGHT+IEiVg+r9k0GPVsb58FfTecIW8FL7oqxuNIJ+9fbKQlVi8lDoMz0e9WPUX7FFI56Oddi4JpWt8CNAuFxVH5aph4=
X-Received: by 2002:a05:6e02:128f:b0:3d9:28d8:966d with SMTP id
 e9e14a558f8ab-3d928d89906mr2257965ab.5.1745420612385; Wed, 23 Apr 2025
 08:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com> <20250414174134.3095492-15-irogers@google.com>
 <aAjxkfz4rSHe5Eoi@x1>
In-Reply-To: <aAjxkfz4rSHe5Eoi@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Apr 2025 08:03:21 -0700
X-Gm-Features: ATxdqUFsWQJKyZcPwpKNBRwYmnKwjJeUY9t4bXm9rd-t6ERhHUw3S8DYw9QTfTY
Message-ID: <CAP-5=fU0N9dkJhVm4+nsBQqXNA5v4pNmTO8JGAEzRsoE0im6Fg@mail.gmail.com>
Subject: Re: [PATCH v5 14/16] perf stat: Add mean, min, max and last
 --tpebs-mode options
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 6:56=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Apr 14, 2025 at 10:41:32AM -0700, Ian Rogers wrote:
> > Add command line configuration option for how retirement latency
> > events are combined. The default "mean" gives the average of
> > retirement latency. "min" or "max" give the smallest or largest
> > retirment latency times respectively. "last" uses the last retirment
> > latency sample's time.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Weilin Wang <weilin.wang@intel.com>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-stat.txt |  7 +++++++
> >  tools/perf/builtin-stat.c              | 27 ++++++++++++++++++++++++++
> >  tools/perf/util/intel-tpebs.c          | 20 ++++++++++++++++++-
> >  tools/perf/util/intel-tpebs.h          |  8 ++++++++
> >  4 files changed, 61 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Docume=
ntation/perf-stat.txt
> > index 2bc063672486..61d091670dee 100644
> > --- a/tools/perf/Documentation/perf-stat.txt
> > +++ b/tools/perf/Documentation/perf-stat.txt
> > @@ -506,6 +506,13 @@ this option is not set. The TPEBS hardware feature=
 starts from Intel Granite
> >  Rapids microarchitecture. This option only exists in X86_64 and is mea=
ningful on
> >  Intel platforms with TPEBS feature.
> >
> > +--tpebs-mode=3D[mean|min|max|last]::
> > +Set how retirement latency events have their sample times
> > +combined. The default "mean" gives the average of retirement
> > +latency. "min" or "max" give the smallest or largest retirment latency
> > +times respectively. "last" uses the last retirment latency sample's
> > +time.
> > +
> >  --td-level::
> >  Print the top-down statistics that equal the input level. It allows
> >  users to print the interested top-down metrics level instead of the
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 80e491bd775b..4adf2ae53b11 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2327,6 +2327,30 @@ static void setup_system_wide(int forks)
> >       }
> >  }
> >
> > +static int parse_tpebs_mode(const struct option *opt, const char *str,
> > +                         int unset __maybe_unused)
> > +{
> > +     enum tpebs_mode *mode =3D opt->value;
> > +
> > +     if (!strcasecmp("mean", str)) {
> > +             *mode =3D TPEBS_MODE__MEAN;
> > +             return 0;
> > +     }
> > +     if (!strcasecmp("min", str)) {
> > +             *mode =3D TPEBS_MODE__MIN;
> > +             return 0;
> > +     }
> > +     if (!strcasecmp("max", str)) {
> > +             *mode =3D TPEBS_MODE__MAX;
> > +             return 0;
> > +     }
> > +     if (!strcasecmp("last", str)) {
> > +             *mode =3D TPEBS_MODE__LAST;
> > +             return 0;
> > +     }
> > +     return -1;
> > +}
> > +
> >  int cmd_stat(int argc, const char **argv)
> >  {
> >       struct opt_aggr_mode opt_mode =3D {};
> > @@ -2431,6 +2455,9 @@ int cmd_stat(int argc, const char **argv)
> >  #ifdef HAVE_ARCH_X86_64_SUPPORT
> >               OPT_BOOLEAN(0, "record-tpebs", &tpebs_recording,
> >                       "enable recording for tpebs when retire_latency r=
equired"),
> > +             OPT_CALLBACK(0, "tpebs-mode", &tpebs_mode, "tpebs-mode",
> > +                     "Mode of TPEBS recording: mean, min or max",
> > +                     parse_tpebs_mode),
> >  #endif
>
>   20     5.60 debian:experimental-x-mips    : FAIL gcc version 14.2.0 (De=
bian 14.2.0-1)
>     builtin-stat.c:2330:12: error: 'parse_tpebs_mode' defined but not use=
d [-Werror=3Dunused-function]
>      2330 | static int parse_tpebs_mode(const struct option *opt, const c=
har *str,
>           |            ^~~~~~~~~~~~~~~~
>     --
>
>
> I'm enclosing parse_tpebs_mode() under #ifdef HAVE_ARCH_X86_64_SUPPORT
> to fix this.

Thanks, I agree with the fix. Longer term I think we can remove the
HAVE_ARCH_X86_64_SUPPORT. Now that events carry the retirement latency
information and hardware isn't required, there's no reason why
retirement latency couldn't be added to architectures that aren't
Intel (HAVE_ARCH_X86_64_SUPPORT is already covering AMD which lacks
support).

Thanks,
Ian

> - Arnaldo
>
> >               OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> >                       "Set the metrics level for the top-down statistic=
s (0: max level)"),
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpeb=
s.c
> > index de9fea601964..6b00bd5b0af1 100644
> > --- a/tools/perf/util/intel-tpebs.c
> > +++ b/tools/perf/util/intel-tpebs.c
> > @@ -31,6 +31,7 @@
> >  #define PERF_DATA            "-"
> >
> >  bool tpebs_recording;
> > +enum tpebs_mode tpebs_mode;
> >  static LIST_HEAD(tpebs_results);
> >  static pthread_t tpebs_reader_thread;
> >  static struct child_process tpebs_cmd;
> > @@ -45,6 +46,8 @@ struct tpebs_retire_lat {
> >       char *event;
> >       /** @stats: Recorded retirement latency stats. */
> >       struct stats stats;
> > +     /** @last: Last retirement latency read. */
> > +     uint64_t last;
> >       /* Has the event been sent to perf record? */
> >       bool started;
> >  };
> > @@ -142,6 +145,7 @@ static int process_sample_event(const struct perf_t=
ool *tool __maybe_unused,
> >        * latency value will be used. Save the number of samples and the=
 sum of
> >        * retire latency value for each event.
> >        */
> > +     t->last =3D sample->retire_lat;
> >       update_stats(&t->stats, sample->retire_lat);
> >       mutex_unlock(tpebs_mtx_get());
> >       return 0;
> > @@ -517,7 +521,21 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu=
_map_idx, int thread)
> >                       return ret;
> >               mutex_lock(tpebs_mtx_get());
> >       }
> > -     val =3D rint(t->stats.mean);
> > +     switch (tpebs_mode) {
> > +     case TPEBS_MODE__MIN:
> > +             val =3D rint(t->stats.min);
> > +             break;
> > +     case TPEBS_MODE__MAX:
> > +             val =3D rint(t->stats.max);
> > +             break;
> > +     case TPEBS_MODE__LAST:
> > +             val =3D t->last;
> > +             break;
> > +     default:
> > +     case TPEBS_MODE__MEAN:
> > +             val =3D rint(t->stats.mean);
> > +             break;
> > +     }
> >       mutex_unlock(tpebs_mtx_get());
> >
> >       if (old_count) {
> > diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpeb=
s.h
> > index 218a82866cee..9475e2e6ea74 100644
> > --- a/tools/perf/util/intel-tpebs.h
> > +++ b/tools/perf/util/intel-tpebs.h
> > @@ -8,7 +8,15 @@
> >  struct evlist;
> >  struct evsel;
> >
> > +enum tpebs_mode {
> > +     TPEBS_MODE__MEAN,
> > +     TPEBS_MODE__MIN,
> > +     TPEBS_MODE__MAX,
> > +     TPEBS_MODE__LAST,
> > +};
> > +
> >  extern bool tpebs_recording;
> > +extern enum tpebs_mode tpebs_mode;
> >
> >  int evsel__tpebs_open(struct evsel *evsel);
> >  void evsel__tpebs_close(struct evsel *evsel);
> > --
> > 2.49.0.604.gff1f9ca942-goog

