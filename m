Return-Path: <linux-kernel+bounces-742637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D634CB0F4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6425663EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D332EE604;
	Wed, 23 Jul 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="0GRqWnHh"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E32EF29A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278997; cv=none; b=UAFKHNTNJcIJkUG7T+ekyf1nwTMhyznsxjn1uhfYnpnf+r1htx7YnQjDAp/830eMUSaUSGoJ+FN57nAdkBJDf9IRpV7eSojOEPdymEcyUToAaB1g8Eh//ke/+cvTniqQ75EMZt38cw04UKaq5Z5HiWWOga0lfJznmZe8o4zKFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278997; c=relaxed/simple;
	bh=fU/APBcfC/XfQLmB1N+H1jx5bb6LCvVVTvhPnEoXAWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFlrF/DAnHwLNq6s4xVw/UjFdIxNnVhWUSUNCAXCkm/1bg5O41CgRLR2ygklKooadb93WkzjpTNv4YAZGS3bkMIUEab01S+kE2aHuUVXTBNoQWRDksYUi5EfHC7zDI+yRJQVDbRVlJryj3KNPYyMbelYIeO7GlOkEFrqSq0XIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=0GRqWnHh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab71ac933eso53856151cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753278993; x=1753883793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Neb4DMdHL9YN2qZdu5HnMhnwFlw4q4ExiBgUXTApsC8=;
        b=0GRqWnHhO3ay88oPAUoxJl8XZDjHPi8BzJvlkjTgq5HQJ3x4LiqP8ACuWAYQ9UpwTn
         +AitDW5EJImW5H5KsQVufvpuj8nzfKLDbUR+2fGbUrRHGclFYKue/+fC6PXYf5q5yWh9
         DlKcUZGBbmVknvLBUqpqVM7/8qMvDMWhIXT5CNBY1D4WvR8HvbG45OApWOKJSgOzGW4f
         BAw5tmCRNzoWfb0ulY/HqwOZahDbLR++1wTFu/gaSLOYG9xeRlUNTiB/30igi/HjyIbp
         Ewmx/T7k/kW90uCv5RXoTVOvD4jZLr2XqszPZ6XxaUzfseyeeQGrJ1kynh8E+rI5S7tr
         iZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753278993; x=1753883793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Neb4DMdHL9YN2qZdu5HnMhnwFlw4q4ExiBgUXTApsC8=;
        b=E3hPJvxp/KKPCxlT06KTNWO1N5yWgVZUbFJtWQ9KEzWS70ZNWmvVboWkPHhIEYgSOl
         UdHiBlD2RoIli6fhVHAwImvgEEHn/o2/uz/awRuRYj8YafM6cwCD/etNJE6yz6+GVhhk
         i3toYZfIectpExps4gLw3Nv6noSdcCpKJ+a8z3FVYgoSzKiFuloXYaCSYbNij6lrmTq4
         MBTnbkDZbk6nQc9YP31YfvMs00bd403WY5avDjlJAC3AqgEYig8iub1KQ/Q6kmLO4WYI
         Kv/UixAHbPFD5uUc+tAEiOl5GtiK0dW6jlfod+HHC2O1qjFqdBRHaJF7tuQvIHAT2bxc
         /5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBoY/uR5yxULfC2SOpAzvcRBoiwXCIMKgV4oVDGwxq1NqXjzQ91y0Tzpo+A3+Z1RSP2pR+GW8EuU9iDN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gMBYoOQ2i2ySx49Riv7JPro8I8/zKJLIX9Ix6Wk4LnF1U0Ri
	QFnQWOgGH4BKMUaXywk+k9fUXLfJIsn/dug4stlapJTmQymb+EkvYWlOga9NglOU3+HKXsvJ1Rz
	R632zavW9op4tKXhIqDy/wBSDqY2OCz1bIdSyOMbV9w==
X-Gm-Gg: ASbGncsMWtwQlphDL3ZH8qHP+C7STkq+tIAp1SmQSRSUjw05UU2zYIxnqdVCcnx9F8w
	FJ3W4hsuf1z6pJONGk8nH7ng3OKZRjnOqxJEA5DLvkEaq5bGhcZQf82gnUpmS/mxjKkVJSxDMpx
	e1hZotPtiFaCUdnJKXPLye8Q9VDcHh/82W+xkg/APsoYvPrRePLgwDmaq529zKzf+3LULiWA2BL
	rBS
X-Google-Smtp-Source: AGHT+IGrYMZ5lZ4waeYztYzZWeus2W5lvUIGBJomoilBWhgY/xZwdg1u51Z0y6Byizn2RRUk43nSuTfOAFLec5SGqvE=
X-Received: by 2002:ac8:7fd3:0:b0:4ab:6c5a:1fe7 with SMTP id
 d75a77b69052e-4ae6dfc4f62mr48555621cf.52.1753278993220; Wed, 23 Jul 2025
 06:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-22-pasha.tatashin@soleen.com> <829fa3b2-58be-493f-b26c-8d68063b96ed@infradead.org>
In-Reply-To: <829fa3b2-58be-493f-b26c-8d68063b96ed@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Jul 2025 13:55:56 +0000
X-Gm-Features: Ac12FXwxkGX-ZyVenfoKJwxXGBSrng0apcRfW2jRFbfKFQccJBpZH-g5RuQibpg
Message-ID: <CA+CK2bDi+urd9FRftrDn3bwp2VCvb1f3rFsD+dhegLrMRPC4Zw@mail.gmail.com>
Subject: Re: [PATCH v1 21/32] liveupdate: add selftests for subsystems un/registration
To: Randy Dunlap <rdunlap@infradead.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:06=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 6/25/25 4:18 PM, Pasha Tatashin wrote:
> > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > index 75a17ca8a592..db7bbff3edec 100644
> > --- a/kernel/liveupdate/Kconfig
> > +++ b/kernel/liveupdate/Kconfig
> > @@ -47,6 +47,21 @@ config LIVEUPDATE_SYSFS_API
> >
> >         If unsure, say N.
> >
> > +config LIVEUPDATE_SELFTESTS
> > +     bool "Live Update Orchestrator - self tests"
>
>                                          self-tests"
>
> as below...

Done.

