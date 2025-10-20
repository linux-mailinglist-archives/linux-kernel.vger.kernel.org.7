Return-Path: <linux-kernel+bounces-859994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B02BEF1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E14D3346E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491129ACDD;
	Mon, 20 Oct 2025 02:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrvGGasA"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E729ACD8
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927912; cv=none; b=tcAiXNwmkckB94sbLJY/lkEkNk4jmWCA37Hhvh7eMHVoHYDnaNrXeBBGPQcJmjWkcxDy/K7H8Ksa0FixIo9MadugefCqLlIZpcqvdVp0V3wyIlFAimfi9aMdtxZPgeeLcAwZZGCXhXqsbDXL7XiYKhUnQRvwlwfrxTvsFeoo20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927912; c=relaxed/simple;
	bh=y0K7k6I+BV6ZAk6JhUxr7YToM6mEtXYVHMVmZVG/J34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uux+mISlDuFlRoI8vN5d1guqIXjSX3Ueo5EkvKFaExgUqCaPIlQz51czfkOo8sJFdC+8c2GQxrok/Tz+sox2sNlFuU/dmKAf6vEf4NpWRn/G2k1ljIEiTz07jMq4+fnAjCLmn7xBY7DvVQV2IoDxZ5W0LPeCUU/Rse6cQTK0YfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrvGGasA; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-57992ba129eso4489420e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760927909; x=1761532709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOhVPJvkzoAq6MTL1X4HF7I90hEeoZHpROyKquD6p5Q=;
        b=hrvGGasADJrlp4+YGHKspiFdqyAzD7Do4fV758a5XIGMWrIj3cccpvWfiGstoUkyRN
         QqWZaz0aHPthHpr2EdtuCRGe4xW24hXCoh/vUdfGv1fsVsIDg4r5OnVLmDyOukMe+vKX
         bLSow+hrdG830ky5QCSceDBc/rrGvAV1auh0UVn4bx41HmT2lrOO6dRlGsD6LjlC0Fk8
         blezrBcpO32Ivf2BjGjVMbEFgrcB2WTWIUEy1Hy7xLqOoU8dkJ85LEsIjv+kiK1ViOpL
         PShRa24cWoEK6tM3TBKPQtOFUV0DUlIXRKd/157vMA+RV8NVyEJwWpevrRtyRcIswBvA
         t14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760927909; x=1761532709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOhVPJvkzoAq6MTL1X4HF7I90hEeoZHpROyKquD6p5Q=;
        b=gzqgCwzpOFYdZLjpY4h9JPDgJWa6C3wJepl27L5IlTuNgN7y4Q3DYLBUv/SxVgveQr
         zw6e17Nzc6klEI5almLyoisymDSi1zv2uNrrmagQCJ4zSsTOsSkYVHKFGIUCWA7h2Kvj
         Esho+B+rzdP+g7lFVMcww5seDnf4+eurvFlKIh8bXQjg+DJ9CDepWMgiyD/NWUR1RYmN
         zLHVanLdtsvj9qCp1r47m3gCKepsl+wymxcgmkM9nD8k037+yth+h/a2736a1YzdYwv4
         6G1BBjB07Z8XLPLD1kXiSJppDObzbf1afEXaFjfu6eZ7h9CzjbMOSLtfWIfNqx4ldDw9
         eF/A==
X-Forwarded-Encrypted: i=1; AJvYcCXOllHpt6ODfGF3lNUM+vHgloDcl326hxGjhjNCO8/xuiPc07qBJbtBtVYGUsrUQWOsM+DNNZDUaz5QCUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm94zWj7pTAdwUQRKXlEjC6P82puf6WpUSL5pBdplEAaNy0pI4
	STicSZm9vyuFxuVRlE+u/XTc1hEUYa3D/1Bu1OmXMI4sBzagdH+/bCKXrCz2YyEdYFCEONf41vD
	HGF43abCabJ61mAQa11FIzsllm4O0XJg=
X-Gm-Gg: ASbGnctOTB0MLpa6s1qwXEto+C3jG0iNvtWpp6w1ELZBoPw3+jdIw1mzFFVnZznZcHT
	mAviocS5B8w5NsIZBH3RLkc9y3Tqt4KZ9znmDqXBFEHMw9c4/sGKDi4IXJmvAjuDbCzpicHnj2v
	PJNssaiDkEWK6YH3E+ltyja8JY/8/vlO1ABdut3hQoMXAFWHfWP4jKkvQRtiXc43EmsmJHItodK
	jflqBlz6J9u3iz8ppV8ptVuaXIi07IEhCbwkMrD3bZkoa6F5jdys4LYjfMq0GSCl9QvGYk=
X-Google-Smtp-Source: AGHT+IGNI2EEgtUcROBhmN6VjA+9ofmSu2epcoOxwdcOXI9gMiMvjfzwo0uOJIuo0RZFKxApFhagZo234h2spz5MADc=
X-Received: by 2002:a2e:9a14:0:b0:372:8d1d:6952 with SMTP id
 38308e7fff4ca-37797986b26mr40588931fa.41.1760927908956; Sun, 19 Oct 2025
 19:38:28 -0700 (PDT)
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
 <CADHxFxS3kDeSM7NvZHbdoOyqxzzcKeAc1xzr=q_f+T96G9preA@mail.gmail.com>
 <aPRNSgunb8K9boWx@google.com> <CADHxFxQ5ph5P+ihVw2Qm-f1T-OFUQziyc8fi-k+q3-YgL-XCMw@mail.gmail.com>
 <aPWNaOqocEPgAJcq@google.com>
In-Reply-To: <aPWNaOqocEPgAJcq@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 20 Oct 2025 10:38:17 +0800
X-Gm-Features: AS18NWDRgumED3s7YkkRYw0nhMLNa1cnrut_hBejIDtsUIB12B6K-JM7JMhZH8I
Message-ID: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,
Thanks for your valuable feedback.

On Mon, Oct 20, 2025 at 9:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
> >
> > I=E2=80=99ve tried using EXTRA_CFLAGS and confirm that it doesn=E2=80=
=99t work. When I
> > build perf with the following command, it still reports errors:
> >   make perf ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE
> > EXTRA_CFLAGS=3D"--sysroot=3D$SYSROOT"
>
> Thanks for checking this.
>
> >
> > In fact, by checking the code in tools/perf/Makefile.perf, we can see
> > that the EXTRA_CFLAGS variable is not passed to Clang at all:
> >
> > $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vm=
linux.h
> > $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=3Dbpf \
> >   $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> >   -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_versi=
on.h \
> >   -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> >
> >
> > As shown above, EXTRA_CFLAGS only affects the GCC cross-compilation
> > process and has no impact on the Clang build process.
> > That=E2=80=99s why I proposed introducing an EXTRA_CLANG_FLAGS variable=
 to
> > provide a way to control Clang=E2=80=99s compilation behavior more flex=
ibly.
>
> One thing I care is that we can set clang as a default compiler using CC
> variable then meaning of EXTRA_CFLAGS and EXTRA_CLANG_FLAGS may be
> confusing.  I guess EXTRA_BPF_FLAGS is clearer that we want to pass
> something when it builds BPF programs.
>

Indeed, I agree with your suggestion to rename the macro from
EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS, as it better reflects that the
options are only intended for building BPF programs.

I will soon send the updated v2 patch with this change.

Thanks,
hupu

