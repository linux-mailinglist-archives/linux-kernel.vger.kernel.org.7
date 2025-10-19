Return-Path: <linux-kernel+bounces-859583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A676BEE01B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97549189E70B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAC23506A;
	Sun, 19 Oct 2025 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBxVUYZW"
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB022ACE3
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860664; cv=none; b=D2RsPCJ5RrJ/6ZKkw8cl1N57fc+ha3izR37rOFI4XAMu9NVzINov3f02bVBG7GR45bchFrUwl5eVqfnaBB4sUrS90TqQm/1tmbgOdpRr+vdL2jim2d04gz4+kYtZIPzuLWk9Y2kEN0l3FDfnmNtdvBBfDc0RIRfVLgRTENtUgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860664; c=relaxed/simple;
	bh=ZeXiHDdkFTyro4m7D8rDRiv+zdFWHvj8rUH/gYwzb8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMRB8nYIya071MqJvHwlGvV9CNq0mOJBz1DYTh2DRa2W7rIBWTrx5G/Yia/rOb7q/gqYFMelCN+qmc6QQv9AOBpLv483mRzkkVZ5XaKerkC4Njcx7R4xfXuKCotGBLpk8zkEY/9tM5g9ID4ctWlAQa/gurrA+hf344/2IYaaG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBxVUYZW; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so28606201fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760860660; x=1761465460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrZ+RYXA/gbsIxlipZ39/D3iY8XlMP2fmr07JQCelQo=;
        b=gBxVUYZWUODalB7m5eGxDnApG808Hm5kr8A0WMvQq5n2TFPfEZqHbRUmt82n8EHfAm
         xW7mAjoBSzJR8VgX149TKIPpFxUurIJMbw0AkcErp7weg6fr6Owv7n2shsS4g4S7xVS4
         MNm2uytdX/ktpCREAP6gf7X304Bs3T77vSNRwYrffEDlmNd1Zn4OGqzan+3zKWY4xxkF
         CLN2TSO+eaIhUTCU0gT68spxC6gtcssraFZAOpbtt7TH3uQi95niqBvEy6WycrOvqj7s
         uojZeiCeTNb/X6GzHpvqdjYCht2Wfp40V0IkHHsWmQ3wkKWp2GoKR+AFsbJXj0BTy0A/
         bPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860660; x=1761465460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrZ+RYXA/gbsIxlipZ39/D3iY8XlMP2fmr07JQCelQo=;
        b=TuWBtNH/oAVQPotrDiBU4zbRs5bHYQsjodLqbfdMHTO2d8kkWMZ9fy+4oYJInsUsK0
         EIKz5nbz2Wr6yrLhganCG4Qihem2si949fOr7lPErvSEJMoBsPnfn3CSp2uWIZPqoIMm
         l40Z6bKcg3X7cBQ2drft88QnVofcu0/FvBn4F9yvedm4+vLlclFArxWp93X6g+CRLOWQ
         MHAOMw7U6yJXmK3Jaip72gl0cM9G0Zx6DwUsMGmDGeblsqq48Kpio7DPxpcymSWmOsVF
         CoWIPgvUtIF3iNalsrbIorD5PSR921/xRjEo8yq7V0hPKo3FtEzJEbS7L8H4fjFbtTEL
         3f1w==
X-Forwarded-Encrypted: i=1; AJvYcCXNf2dfbh0cHVtbdnpcx2blw6jwrXHhS7zOSDPSCKJr1isJlhf510OLA/szkJ7cWxqvamvT9rnELS63nK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScan2RFyLv2Gm8g5y9tvpdQkO2tHXbtjGan3xJrsED7ZoWmna
	naRvh6Tv3hSlJgrBh6ryYVdoNve4azg17FyxXWq030e4VDZahNFbjeDrxCSIsLhlLzvWn/XNw4U
	9xVGHOadztFcSjwx1z/16ErrSIGUufNc=
X-Gm-Gg: ASbGncvCSHsFpylDHqmsdRB3EvqqoZbnJdjLKNYx+ijYFmFYIBIuw/vOkLys9BTnQXW
	JUBWgfy/ipd4NA05yrwN4j06bXqPTO4zN8Ef6xH6WxAlEA4wmCU3yjqdWwH9p0p2O7OYqr3EI5n
	H3a12ArNxo4ACuHm9PT2cKgVXMJDvaPhBXgbjplLRihXvCKdcQrZ2IGTsQ7WtODJ/vtwg+pe3O/
	8YXSsivNhM8CEkvA/EUMGKnWALRR+IS5nNRv1dmfgXjJ+OEexXPMwh18fnMwoaQ/NHloHE=
X-Google-Smtp-Source: AGHT+IGxfcc5l5KQQOWN0RevjKY3b/BSjYrwRUYSA2YjiFwjMNuumeoghswiBLAvt25WHNXlgwxVkQW8W/HLrpgsLmM=
X-Received: by 2002:a2e:a553:0:b0:372:99ba:c28e with SMTP id
 38308e7fff4ca-37797a7483bmr26383751fa.36.1760860659906; Sun, 19 Oct 2025
 00:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com> <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
 <20251015093037.GA109737@e132581.arm.com> <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
 <CADHxFxS3kDeSM7NvZHbdoOyqxzzcKeAc1xzr=q_f+T96G9preA@mail.gmail.com> <aPRNSgunb8K9boWx@google.com>
In-Reply-To: <aPRNSgunb8K9boWx@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Sun, 19 Oct 2025 15:57:27 +0800
X-Gm-Features: AS18NWAg9-jBAfSX3OHLuzE-MfKsHu3RnTMDUGFD5GkY6E_1R4r3CDQEfYZw9GA
Message-ID: <CADHxFxQ5ph5P+ihVw2Qm-f1T-OFUQziyc8fi-k+q3-YgL-XCMw@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,
Thanks for your reply.

On Sun, Oct 19, 2025 at 10:30=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Sat, Oct 18, 2025 at 06:05:03PM +0800, hupu wrote:
> > Hi Leo, Ian, and fellow maintainers.
> >
> > On Wed, Oct 15, 2025 at 7:47=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
> > >
> > > Hi Leo,
> > > Thank you for your reply.
> > >
> > > On Wed, Oct 15, 2025 at 5:30=E2=80=AFPM Leo Yan <leo.yan@arm.com> wro=
te:
> > > >
> > > > Have you installed the GCC cross packages ?
> > > >
> > > >  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> > > >  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarc=
h64-cross
> > > >  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-=
cross
> > > >
> > > > My understanding is arm64 cross compilation tries to find headers i=
n the
> > > > path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/De=
bian
> > > > distros).  After install GCC cross packages, the headers should app=
ear
> > > > in the folder.
> > > >
> > >
> > > I hadn=E2=80=99t installed the packages you mentioned earlier, but af=
ter
> > > running the installation commands you provided, I was indeed able to
> > > successfully build perf.
> > >
> > > In fact, I=E2=80=99m currently working on creating an SDK package, wh=
ich
> > > includes a cross-toolchain that I built myself using crosstool-NG. My
> > > initial idea was to install certain third-party libraries (such as th=
e
> > > packages you mentioned) into the cross-toolchain=E2=80=99s sysroot di=
rectory.
> > > With this approach, even when developing on different host machines,
> > > we could simply specify the header search path (pointing to the
> > > cross-toolchain=E2=80=99s sysroot directory) during compilation, and =
the build
> > > should succeed without requiring any additional package installation
> > > on the system.
> > >
> > > Based on this, I think allowing users to extend some options via
> > > EXTRA_CLANG_FLAGS could be a flexible way to handle such cases.
> > > However, this is just my personal thought and might not be entirely
> > > correct, so I=E2=80=99d like to hear your advice.
> > >
> >
> >
> > Although installing the GCC cross packages allows me to build perf
> > successfully, I still prefer to be able to pass additional Clang flags
> > via EXTRA_CLANG_FLAGS, as this approach feels more flexible to me.
> >
> > I look forward to continuing the discussion on this topic.
>
> Doesn't EXTRA_CFLAGS work for you?
>


I=E2=80=99ve tried using EXTRA_CFLAGS and confirm that it doesn=E2=80=99t w=
ork. When I
build perf with the following command, it still reports errors:
  make perf ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE
EXTRA_CFLAGS=3D"--sysroot=3D$SYSROOT"

In fact, by checking the code in tools/perf/Makefile.perf, we can see
that the EXTRA_CFLAGS variable is not passed to Clang at all:

$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinu=
x.h
$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=3Dbpf \
  $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h=
 \
  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@


As shown above, EXTRA_CFLAGS only affects the GCC cross-compilation
process and has no impact on the Clang build process.
That=E2=80=99s why I proposed introducing an EXTRA_CLANG_FLAGS variable to
provide a way to control Clang=E2=80=99s compilation behavior more flexibly=
.

Thanks,
hupu

