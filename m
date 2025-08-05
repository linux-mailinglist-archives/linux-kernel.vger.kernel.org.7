Return-Path: <linux-kernel+bounces-756832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56865B1B9F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1685162358B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB77829826A;
	Tue,  5 Aug 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cxi2QUyk"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39C279351
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418286; cv=none; b=csVHrXzrIBNebR1H824xDwCsmuJowMMlmZKM+GhJBeuhLQ4QGm5bFHvU/RSLJGjiKArLbMrcSvAVcty8trYQu3bVXQkFyxxLGprRz3csH59rk4kuGSVnytk/NAhNhmIbh3dGKBK2cmtxjENXrgy2q+78CKgovTLVew3b8LxgLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418286; c=relaxed/simple;
	bh=OKVLqHIWmibana5VQZUJL0qfjT6gFJPBTJLNVk0SJRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2fwFgTx9aYBMbqqm6fBemRaammzWjRBDW07dSz28cUv0TOQLvOSVwsdbKb6Hfyy++59w/IrHBX2arTsCSPIWxN7Daj6x33n608wUGUCX6gT0SUonLciE429rRUejDwqH+M3yX5+ZEszGUol5NC2eyVIr7JpaoCY6MuGfCJvBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cxi2QUyk; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4aeb5eb611bso38830621cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754418284; x=1755023084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OKVLqHIWmibana5VQZUJL0qfjT6gFJPBTJLNVk0SJRY=;
        b=cxi2QUyki+j6r+AUnCw3RvWjcY8wIMjzkQZNYirvohpuOLbHcTqWGlWYsBGih7XRuF
         tFCgDzdFxy6+hDAK9GBcr0CwCPPSTwy13E2CkyC8rdhql8M8FQqKY38sbvSRrIlWDFTs
         B5P1qDdfnbnVgRUf1c0JV/ymlLzeeThbf8FhGhHQKpXUFUnDRTn1dRmQr1/397jWil1z
         MBOQ/FPyok5CCskwl9J7N9Lpeze7tBJCuK6DhWIjjRE0adMBmv58evpAHzHNds/ZuAbg
         BBlCMsogK6zHRFvWBP6ULOgAGU1WCvIVdFaB0EUTN0AA4I7Hq8BBai8Umt/V/3EVI60R
         GAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418284; x=1755023084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKVLqHIWmibana5VQZUJL0qfjT6gFJPBTJLNVk0SJRY=;
        b=GX+xsAn7NnxDtMyuktK22JOaz55BAqc/5CqyfePBEAxOjRKQ+kUz0IxG4XjuWbCWsf
         BgRoUCJiwvf37ZW5t2JR1Efyy+ZA4dLQ/h++GZkF7BAL1B5nH7c+YH+EjPxQEwbMmprn
         8qOwUUrM113wOlncj4gC4p2qtQ0UNhQXh+ST2gSVTtCswxYLw3aTuZS0LzVCLgGn+8yz
         D3yOCfll6HWFDzANrEey0yOwdfjzgUkhJAkRgp8DcuZdNiGR0rTxlNeZU5ds91J8P2OC
         whlViNhksFIPAdlPiS8esiqHgkOgzR6zbtfA0e6UjkoQQ6grhnmaJ9YzHy+Ea+QpEUN/
         IcyA==
X-Forwarded-Encrypted: i=1; AJvYcCV6uI5tlC3+XacRFvM2rCdVWF7MlbGEtPnYR+rnmbQUrSi8IyLdSMebm8O+1eO5Z3lZJdAR9ocd8qch3V4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5+Ci1FoCiTpL9O7LzvQASYWyy+XtgnO9D7A+20zrOfdS6WMd
	Xv81qoCxgNSEiJ1DeuwBJKgJKkXtUcDam8SbgJQDjGb8UXQG/y4Aa2I70jFwv3YXEseWySpoStl
	NUEaoDItyaDpwyaxs3+Vz1LW5v6xhwv1GyXd1Yqak0A==
X-Gm-Gg: ASbGncvvWUjx7ooNzRjQbovwp9oAPqNKj8cs04o0yu3niTcAqgJvSnA7Mb3MUn7S9+P
	NTT1riu9Sfpp8pitExs1cHedEEfr8TBp+cibXLhx+64X3x+wXLfTlgQDLUcrOIcfSRocZr7w1Er
	n9S/bU2EpeKHTQ8p+xAYSNrY3tSiw6Vwc5lOUlVbFFiCcSndzP/fwO1DhLbTAQefvIOMo1Naymg
	r48
X-Google-Smtp-Source: AGHT+IECP/Qxkxwml/cf3BCEf7Q2B4NHOjK/2NaPxdggrpfuJmAft+1jLFMG+N7JFiUAXv2wscgyaif0s26EEgdezVo=
X-Received: by 2002:a05:622a:191a:b0:4b0:86b4:251a with SMTP id
 d75a77b69052e-4b086b42b17mr42712121cf.25.1754418283817; Tue, 05 Aug 2025
 11:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-32-pasha.tatashin@soleen.com> <20250729161450.GM36037@nvidia.com>
 <877bzqkc38.ffs@tglx> <20250729222157.GT36037@nvidia.com> <20250729183548.49d6c2dc@gandalf.local.home>
 <mafs07bzqeg3x.fsf@kernel.org>
In-Reply-To: <mafs07bzqeg3x.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 5 Aug 2025 18:24:05 +0000
X-Gm-Features: Ac12FXzHvHvpYHaqyT4n7r9UBwaTJ5dSsQkeIlx-mzYjpvX_Sd5MnNPi6FTtCG4
Message-ID: <CA+CK2bA=pmEtNWc5nN2hWcepq_+8HtbH2mTP2UUgabZ8ERaROw@mail.gmail.com>
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Thomas Gleixner <tglx@linutronix.de>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> To add some context: one of the reasons to include it in the series as
> an RFC at the end was to showcase the userspace side of the API and have
> a way for people to see how it can be used. Seeing an API in action
> provides useful context for reviewing patches.
>
> I think Pasha forgot to add the RFC tags when he created v2, since it is
> only meant to be RFC right now and not proper patches.

Correct, I accidently removed RFC from memfd patches in the version. I
will include memfd preservation as RFCv1 in v3 submission.

>
> The point of moving out of tree was also brought up in the live update
> call and I agree with Jason's feedback on it. The plan is to drop it
> from the series in the next revision, and just leave a reference to it
> in the cover letter instead.

 I will drop libluo/luoctl and will add a pointer to an external repo
where they can be accessed from.

Pasha

