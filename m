Return-Path: <linux-kernel+bounces-827893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB995B935EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10FD19C0EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79432F39DE;
	Mon, 22 Sep 2025 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="T/Vtd92I"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581062652A6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576233; cv=none; b=XwexH9o6/7KS7/L2OCTUHl6BltA22SzQOFcv2Z6nvsTMsig29BO6LaWiz7z5Zr64PbcLNHS8ObEULmjCRru39l+GsssvQx/BRRs85DqlhF1FfAfWp1i/4VUCJcZv7DKxRZgm91s4hexyGrEjPqaP+wXxm2Q7rWN3UFBjPWRWz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576233; c=relaxed/simple;
	bh=2lnFxC2hCuopFwp+eEpKVut/RzTPbk9nhoGROWJ2SSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2meAxrQ8zhua92qGl6P9qNsXiR38i1519I+6YeIjmThlHKMVVyxKGOoOI9/9+wDdX6f4xp0Em3TtpFg91SBzt74aYvHVEN78LZY41kFfao88MdTc34bJzImOZH6Tk2Xttfn496vYyVH7HzsrPVO+my0Bd3+hece5iloAWBsvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=T/Vtd92I; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b38d4de61aso57779721cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758576230; x=1759181030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lnFxC2hCuopFwp+eEpKVut/RzTPbk9nhoGROWJ2SSw=;
        b=T/Vtd92ImvDYSXIrPnoZe4VK+x2sKXdithErwv6alIQc1stg4Z0VVyqc/BIUJX2yGE
         GjOaD5A3kjQG3q8oEHw0DP1pI68TAyG86fHqQEaawC9zbcQwdua5GHzKwT0/GSUVXNyi
         8ToWfVRd4vr51ZguvI/lYolG5gFKsY3heSiIwnozDgsvCg8SPaXTbG7lKaXV1h4FaSbP
         1dmRZti4j6XKvF2RDhEX1iMvNsFYpYqBJkl0qG9qDzArl97maU1Awy6BSZiyF/dDO3zb
         bOaB95Pb3nBZg5b81co5oANDcjHUfGYP0FojsQS2lLAAmFF9XnbRwaejWOeQsK1SBoAy
         oC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758576230; x=1759181030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lnFxC2hCuopFwp+eEpKVut/RzTPbk9nhoGROWJ2SSw=;
        b=KgiGbdflhGOA3HB/9hJBF27LF7xPW6JvmbBorDNneALK3hpU3tpkEQMDAeukjpNqRS
         eqijO3VaSQro2m5VibA7ls9BSaCDZ8QSJEbQVi6YiMKR+lUqqDA43koChNDstrAE5RUD
         rFTKQtkhdJLVDmaBliKy5nkuDFQcKwFiLUW8/2GRCcdJ9CYtufNp4Jz8LNdzICpuYwQG
         /rHSYtoXD652q6ffTW8B993SkNmY5SRYPHtGdZJ6Hmrs/0mawJmjUVaABy8ICnC+dBA7
         lDxQZdtJTE8NJ/1JRJV9YdMUXtFw1TZEtikLaAxiY0fRbXSDr89x7FlRjHQ4T+y9NJd5
         uHzg==
X-Forwarded-Encrypted: i=1; AJvYcCWbendWrpnNEiBv3fq0AgbDwIT3wOTiKtekE1WizT1wmngsWNn0aKeYgGq7LslA2JfMepF/JpAj1dZNKiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqdiG1HjsJq06abVrmTr8v3WaB8A15NTaPirKO7AcQkrkr9tUd
	N27NXnqUfWGyYDqQ/p9fYOvnrCeXVMg/LlI7iy3xJKk8+BPxek1EqrQdtK63f/y2ULmpd1LNGxg
	7xpNgSFyHpiUqtw2NDQkf6q9ZXO2KL7Jl9utcMuVTQQ==
X-Gm-Gg: ASbGncuYeZwCBhIAYiM4B09Bsg8Q2gJktoj4lbG+OISCeDbqHhKUsiaH4z6kI/kdj89
	dphOZV2fNUiqKQSV9nviw5XEGgt0h3s5m+SFx8QAQEs/P4biC464+aglMhC7k12uuJPJc/qt7ox
	htna/hUa5aT6pDem7hOlNa3/J/iUwQ+6+hZtC+wxUAq9podGnFN6nADVnO+tD2LNNwS2a0GJ55C
	8f1
X-Google-Smtp-Source: AGHT+IGQ9mQPiN/GEI3fU0tJWSP0koWA24hj8YVPEmzR9zP1Ams6poNzbT8y3Id+rBzzR1NASM7cdvLBk2yOzooAwSM=
X-Received: by 2002:a05:620a:4724:b0:815:630d:2cbd with SMTP id
 af79cd13be357-8516aedb8cfmr51934685a.34.1758576230071; Mon, 22 Sep 2025
 14:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-18-pasha.tatashin@soleen.com> <mafs07byoye0q.fsf@kernel.org>
In-Reply-To: <mafs07byoye0q.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 22 Sep 2025 17:23:11 -0400
X-Gm-Features: AS18NWDQlfdhKL59fadbKNdAGgk8Zbp4-SjH2QD1Po4tMMREBwUluD3-7f8OR8s
Message-ID: <CA+CK2bD_-xwwUBnF4TBCBuX33uL6+V_1nN=0Q8_NXwhubTc8yA@mail.gmail.com>
Subject: Re: [PATCH v3 17/30] liveupdate: luo_files: luo_ioctl: Unregister all
 FDs on device close
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:34=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> Hi Pasha,
>
> On Thu, Aug 07 2025, Pasha Tatashin wrote:
>
> > Currently, a file descriptor registered for preservation via the remain=
s
> > globally registered with LUO until it is explicitly unregistered. This
> > creates a potential for resource leaks into the next kernel if the
> > userspace agent crashes or exits without proper cleanup before a live
> > update is fully initiated.
> >
> > This patch ties the lifetime of FD preservation requests to the lifetim=
e
> > of the open file descriptor for /dev/liveupdate, creating an implicit
> > "session".
> >
> > When the /dev/liveupdate file descriptor is closed (either explicitly
> > via close() or implicitly on process exit/crash), the .release
> > handler, luo_release(), is now called. This handler invokes the new
> > function luo_unregister_all_files(), which iterates through all FDs
> > that were preserved through that session and unregisters them.
>
> Why special case files here? Shouldn't you undo all the serialization
> done for all the subsystems?

Good point, subsystems should also be cancelled, and system should be
brought back to normal state. However, with session support, we will
be dropping only FDs that belong to a specific session when its FD is
closed, or all FDs+subsystems when closing /dev/liveupdate.

> Anyway, this is buggy. I found this when testing the memfd patches. If
> you preserve a memfd and close the /dev/liveupdate FD before reboot,
> luo_unregister_all_files() calls the cancel callback, which calls
> kho_unpreserve_folio(). But kho_unpreserve_folio() fails because KHO is
> still in finalized state. This doesn't happen when cancelling explicitly
> because luo_cancel() calls kho_abort().

Yes, KHO still has its states, that break the LUO logic. I think,
there is going to be some limitations until "stateless" kho patches
land.

> I think you should just make the release go through the cancel flow,
> since the operation is essentially a cancel anyway. There are subtle
> differences here though, since the release might be called before
> prepare, so we need to be careful of that.

Makes sense.

Thank you,
Pasha

