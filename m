Return-Path: <linux-kernel+bounces-755742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0510B1AB2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE772174452
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3BC291873;
	Mon,  4 Aug 2025 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AYlBj9Vi"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D61BC4E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348480; cv=none; b=rYku6aKb7T8hDd0L3TOL2hmPQJERpDhfAQXdz6QakL/NYdNyDF+qr93INkKPvn7SMwG//b6TKD5WzudiSP+4xYUVAzF4ORxoTgUfdyEMM4lQ34V2MaL1ppHOZI8lNExJZlTHYxiJIzdDs7LHE0evYcIZaRWT+NVNcrQnvPigumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348480; c=relaxed/simple;
	bh=kh1Iqz0Yf5ok/S6yiGGNzHKbyS1kwiJn5rDTHcZSof0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOUfh6cCLANYKQiI9jzvnT3OYIlzlldMiQfUglxOKO/VCsAtczxkby115lfulgVNYaqAWjLfGWmXEjYewhr314LgroFqit7nTt+PV+ZktPdmWtDcWq1s34L9bVrE3Oq1d2H91W5j7M+dM2D14wYdSl/PXWhoXCgXaciyXlf7BB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=AYlBj9Vi; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4af12ba9800so31176251cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754348477; x=1754953277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gU7gICCtCiiOkKgytm+DZgh/C6t4tnk/oqWk65I1YqY=;
        b=AYlBj9Vi9oeeUhhAv7M5QYtp7yD49AbI2V4og/j1+jWMDyNGJYo7lda1IPfzY3cD90
         rTMlqqfgz3jszmO0x9rvF5ik6kwMO3NH5Pv93491kLWzzGoEw/KBqgysLIqgEXrMxUqT
         Ltm8yhBliuMaNAly/2dHYSjAGQjCJJvHwpW050fX3whlw1CEP05vA1b2nddYjrXK4aAr
         OWh49iDlEufQ3wSfa6dN4iu+DmtG/8ZOrXkwPCwXXVQzRoJWzi32+MO9NQXeJkEpKy4L
         +d+Ym6jGTy1WYAZTvJU3So0Uz+XA1JdFPaw8LuZ15O2bBax0WmrLBPcUG/JfBn6Ittl8
         AUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754348477; x=1754953277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gU7gICCtCiiOkKgytm+DZgh/C6t4tnk/oqWk65I1YqY=;
        b=qOIee4MQPOppePhnBtOEMbU7tcfRVR5zR6r3YKAKGRZ7wWq0ieW88quvWeabsBYwKj
         PPATNSWZyJew6ZoGy5kVMWN4gVsIOnxbYMOoaMDRRIsYzLH8/wPSm28qxnXRd/w+cPer
         is2AhmBWYctJLfJ6LWL3hRF8KfvWUnn/++ZGjdEO0dovTFTiOE3UOw7MRxXDu4RiMSAP
         1/MdL+wkRDPLSr4IENx2EgPB7RE++A4p5N/9tb7u+ho/fxHa28+6WgRbdbnNSvUh2BP/
         42aCznPE25lIzftWCRH2szu+VgZftFzTPYfZ9Dw3K3mLoPKLPfK9RlCmrzG3NZJTG3wn
         QXDg==
X-Forwarded-Encrypted: i=1; AJvYcCX93UzJfTiULQRiGfOAuV29nbYY3fuMbmIpb6jOgZMz2F66EGaTJIQXNAqfuOObA0LdBSmCy6Qne9HkvuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjNlOAutZeeWuxe3CbYvl6/2tYcpIm5QmuDYbe4qEA8t/EgjP
	+YoG8alhTmpMRSL7Yln7fO5rQ4Iemj76OrXQz0qT3YkcCHEM/HCLelD614BeMa2jgVtwUS1u5ni
	iFqWdpXZ6oPH/Bfmo8A4jf0g+CGHR3/7f2JO/V3OG0w==
X-Gm-Gg: ASbGnctKtu4qRiOYU9R/PATa7oZ1imMsOvS7+k04eUiNY2ZZWxRccf0hYnWebc4HfVB
	10ZZFOrjZCzMyXTjhiQaSkl442OfC2MIRTFU6feaq8XUed52HLzATNSkrjum4fX4OndEiXbakJs
	3ZOBy9om19NVABDz1AVF6O6f3s/DybtnI5YyljdY9KgnYgy9DOh8CoqKOwYHSyWThiM7VUfnsRp
	p1R
X-Google-Smtp-Source: AGHT+IHe63ELG7HHSW4Jr0p22ejEnswLaJpBTfGBY8KrlhhHwCd1xtHK5nLfdWJ/GzdTJH5a222X5rXcjnstQZeQWOo=
X-Received: by 2002:ac8:57cf:0:b0:4af:c21:41b1 with SMTP id
 d75a77b69052e-4af10ad5bdbmr146282341cf.55.1754348476999; Mon, 04 Aug 2025
 16:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-15-pasha.tatashin@soleen.com> <20250729173318.GQ36037@nvidia.com>
In-Reply-To: <20250729173318.GQ36037@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 4 Aug 2025 23:00:39 +0000
X-Gm-Features: Ac12FXy6p3_gSOnGWR1VjKZIJjskzeugSY4VSrqKY12UE9gHpXQr70kL51Ej-YY
Message-ID: <CA+CK2bBEX6C6v63DrK-Fx2sE7fvLTZM=HX0y_j4aVDYcfrCXOg@mail.gmail.com>
Subject: Re: [PATCH v2 14/32] liveupdate: luo_files: add infrastructure for FDs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > +struct liveupdate_file_ops {
> > +     int (*prepare)(struct file *file, void *arg, u64 *data);
> > +     int (*freeze)(struct file *file, void *arg, u64 *data);
> > +     void (*cancel)(struct file *file, void *arg, u64 data);
> > +     void (*finish)(struct file *file, void *arg, u64 data, bool reclaimed);
> > +     int (*retrieve)(void *arg, u64 data, struct file **file);
> > +     bool (*can_preserve)(struct file *file, void *arg);
> > +};
>
> ops structures often have an owner = THIS_MODULE

Added here, and to subsystems.

>
> It wouldn't hurt to add it here too, and some appropriate module_get's
> though I didn't try to figure what happens if userspace races a module
> unload with other luo operations.

I added try_module_get()/module_put() to register/unregister functions.

> > +
> > +/**
> > + * struct liveupdate_file_handler - Represents a handler for a live-updatable
> > + * file type.
> > + * @ops:           Callback functions
> > + * @compatible:    The compatibility string (e.g., "memfd-v1", "vfiofd-v1")
> > + *                 that uniquely identifies the file type this handler supports.
> > + *                 This is matched against the compatible string associated with
> > + *                 individual &struct liveupdate_file instances.
> > + * @arg:           An opaque pointer to implementation-specific context data
> > + *                 associated with this file handler registration.
>
> Why? This is not the normal way, if you want context data then
> allocate a struct driver_liveupdate_file_handler and embed a normal
> struct liveupdate_file_handler inside it, then use container_of.

Good point. I removed arg, and added handler as an argument to the
callback functions.

> > +     fdt_for_each_subnode(file_node_offset, luo_file_fdt_in, 0) {
> > +             bool handler_found = false;
> > +             u64 token;
> > +
> > +             node_name = fdt_get_name(luo_file_fdt_in, file_node_offset,
> > +                                      NULL);
> > +             if (!node_name) {
> > +                     panic("FDT subnode at offset %d: Cannot get name\n",
> > +                           file_node_offset);
>
> I think this approach will raise lots of questions..
>
> I'd introduce a new function "luo_deserialize_failure" that does panic
> internally.
>
> Only called by places that are parsing the FDT & related but run into
> trouble that cannot be savely recovered from.

Agreed. I added a new macro in luo_internal.h:

 11 /*
 12  * Handles a deserialization failure: devices and memory is in
unpredictable
 13  * state.
 14  *
 15  * Continuing the boot process after a failure is dangerous
because it could
 16  * lead to leaks of private data.
 17  */
 18 #define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)

And use it in places where we panic during deserialization.

Pasha

