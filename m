Return-Path: <linux-kernel+bounces-806687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE3FB49A62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA920617E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D261FF603;
	Mon,  8 Sep 2025 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQHk0MmP"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF123536B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361338; cv=none; b=ELp4kHqbL/EuDQr4tJI6DDf7jixUgbU5SsZPbpKbVmFa4SjdJLqz9p3kKmmF6YV+AsaWUpWdPDViDoKMBWlj5anroy7Pz+CYLAPtTFft9FUFiBBfih1dj4qSoVQvOUfsF1Ea70zMG7MqVFYX8FJNfvk4oBOWuZkF/XXcDIfJ3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361338; c=relaxed/simple;
	bh=tmr9R0O7RWkWQ6LWG3LXCf5yq/w4BQPFAFSdkpU6lPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ix3Iup+LtipJTJHdDHmyCRaTKgKYg/wHBUG61qhWNIYYX6M0+Eopg2wSM+83M7B59+c+x9rdygCDbufRXf914+4xglywQbzJBlwRcMbACXV6K/hsyzC96hnglrESHQq/Y6MNhVV0OLnLADSiD/EHdd+Yxvb7fX2sDFGcgg5bKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQHk0MmP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b48fc1d998so606021cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757361336; x=1757966136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmr9R0O7RWkWQ6LWG3LXCf5yq/w4BQPFAFSdkpU6lPU=;
        b=cQHk0MmP+0v0faUSSnrU0NkpEFJ2dNGTjloMv5xgX67UB1jlSHyxgQwQF8oTOWbTcc
         L0IpkWQoYCjQ+WHwumtseebtmmNEeS1k5Fk4WoLVmxNywrpl3vWwGgmVE18SqmEuWUmA
         iDdhQDFrLnexwZEtBJyF4SWcMsnCrdalZeVMlr/6XtkMJEUxzcaSPPVQWuhGr/q3exSa
         7Eaov9uX1keLURs3GVDao2cY9AXz4LkZhQaHUUJ9ooIPzsyCpRX54n8u76dpEr7Fwbyn
         HFYlF2k8VHEzh/sQQPxQIkGm14L5Hd1aJwHRom62rG8m0fWlouPmsgS6zSnzSIXXO6be
         +v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757361336; x=1757966136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmr9R0O7RWkWQ6LWG3LXCf5yq/w4BQPFAFSdkpU6lPU=;
        b=FP4/KG/B0m8wdTLjTAguFDCcRJtcf9iEbCTEwfoydFjb94J7DNx9B6eNdb3vDB3O0a
         n0hhTQr1lDUI9BSCDJwQgFszjrdIGloJIn1l0Qm5vvcH8RDLZkOLAT4hkik12MeTGKx3
         jmOXwzWnXWD1qEcydHXQiLoZj452zXqSstaVGlJYZwS3DVfmtyM3mkzi4qPA4OFsKBmx
         UXrE6z3GEb8kDxw+4ZG/kSopoTaULnCLn96lTeMyZyVMsVrOFLUPrxyF6yWqozg2n4lR
         K0BDVP98sIovEyns7Pw42/sSwG1aQRXTup8zMlW+ohCsqJPKIo7qO476UHlWNm5dJlMc
         Y0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVx5dj7KcjH7vAOWnlqn/2VGDNwU/4HGY3z5n5s5nVbE8JQ0IHel74VbgvMakitTpNYr8dW/idopQuy3K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcI4evuXZ+p6B+zBAzNqg4xhfw0fmwkxKdllTcrLu4UFJEn8E+
	zOO6MIX15m23PW+mffu2O3X1jhcxQCvNIdrrRHifG0MIpAq2XGzlPMTKUk/EqUTwVO3YudISxz9
	+2u5FheWhgq/v75y8QCWqSdKk5v+CKt1KB+kjL5nC
X-Gm-Gg: ASbGncsgF/GyACcsgwwrADQPKDo7o0xGN5/Uj1BepR2odIDbI8KjL9TogimKTsABhfn
	cZwDb1plalCirH0J2toFGPILtJcJnSnnV+j7KRi27IcYJBvAWllrdjUN67AjqCpPed1jptwAK/D
	23uSfiBiHZ3zqUj26Wfd7NT48I7/wc6Jgq0STXtcgwveao0WpJPlphQuquI3M6GS0KIoSNF89Vm
	UAN5A==
X-Google-Smtp-Source: AGHT+IFht5pppNMMGMtPH/agZlekP76+Bq9kz9lTs1Z+7HZ8Zxgz+fKXs2YuHK6UPaXwGsTfuhgnxU+LcWW0vB3VTXg=
X-Received: by 2002:a05:622a:3d3:b0:4b3:4ed0:c6f6 with SMTP id
 d75a77b69052e-4b5f6f80a58mr13347131cf.16.1757361335849; Mon, 08 Sep 2025
 12:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com> <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com> <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>
 <aLFKHGe2loD657fu@tiehlicka> <zerazodfo2uu5az4s6vuwsgnk7esgjptygh5kdgxnb74o2lzjm@fkziy4ggxrxc>
 <CAJuCfpFynEuwBSu28UiRDjWrayN-raX4Nqqh283MwRoJLi8bMQ@mail.gmail.com>
 <uoyjzkybkqd3wkvauofmorv72gnjisoq3owvijsezpt3wbrazz@at562ngtvszd>
 <CAJuCfpG17E_yoZeqEDrN0PFn8UBKqiGT28KDwEDmBm6byFje-Q@mail.gmail.com> <cca3gvk5gco6i2vbjvtarmi77imgj5y64kqb7bebcrbjagdwca@4p6zq4iaiqr6>
In-Reply-To: <cca3gvk5gco6i2vbjvtarmi77imgj5y64kqb7bebcrbjagdwca@4p6zq4iaiqr6>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 8 Sep 2025 12:55:24 -0700
X-Gm-Features: AS18NWA5R6z4os11O0uAZbscD0giAOrKc3pAZnMY5I0U-VPDOAWS3MM6jGMGM2E
Message-ID: <CAJuCfpE-dTF_TRJkSffTxtD_P8A10MJUOHd83xBg4B7ATknGGA@mail.gmail.com>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Yueyang Pan <pyyjason@gmail.com>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sourav Panda <souravpanda@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:08=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Sep 08, 2025 at 10:51:30AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Sep 8, 2025 at 10:49=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Mon, Sep 08, 2025 at 10:47:06AM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM Kent Overstreet
> > > > <kent.overstreet@linux.dev> wrote:
> > > > >
> > > > > I think that got the memcg people looking at ways to make the acc=
ounting
> > > > > cheaper, but I'm not sure if anything landed from that.
> > > >
> > > > Yes, Roman landed a series of changes reducing the memcg accounting=
 overhead.
> > >
> > > Do you know offhand how big that was?
> >
> > I'll need to dig it up but it was still much higher than memory profili=
ng.
>
> What benchmark/workload was used to compare memcg accounting and memory
> profiling?

It was an in-kernel allocation stress test. Not very realistic but
good for comparing the overhead.

