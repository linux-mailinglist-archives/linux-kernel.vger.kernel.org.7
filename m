Return-Path: <linux-kernel+bounces-899921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAAFC5920F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D05426414
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44AA35A955;
	Thu, 13 Nov 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="X/PfIDSm"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48836221F1F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052966; cv=none; b=FShJJd0uAsPSUy9WTbewAvCN+z1z64TtUtu0xY6y38ofuccNjDer8bj3HFZOUERHuSTDA3GKVcIPi3IzFk6A60oqbm7pcTQeRxGdrzGEs4uI50162CqQkIEBJWN4lbUsEEqZYRVeAugwFczVtNdbjkdyPyPDCMuuqtrW1Ri0Z28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052966; c=relaxed/simple;
	bh=uGvdD/ipW2kG9og5miefSvlr2P5i5Da/ls3E4y5uIkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZbnNMkKudAULSNspUjmUit9MvfxoknpGRcCDdEjDCvPUKK4w7WisKZob95PTB4f5ObCFni+shZxcW+eyPdmWNMWWhOwKlmQfty+SpIHASGURQ8BKBc4ZqYOh9M7NBpohae7yzZkCrxHJtlHz5GFTqHIWRpsxiqiPlWO/W9bWmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=X/PfIDSm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so1724014a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763052963; x=1763657763; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMCY5fmkZI76R3Lm7+dKka7numEpthvdX92HaVpx2Bo=;
        b=X/PfIDSmlOuIwMaKIQHVjSQJmPr5vBQyMIQCtP61fnu5WYT7WNBO+FJPzn6TNkn6uq
         Q9yuT/+NHua0KBDuwK1NBnMY00fqlSqm1thohn3JCm75hBpwylQrnO99vvH2i25W+hMS
         DuVxU37YhvLqGNsdbFQEwom8kkQnjZr0TecqNrdo28yMiPzX92JCMpXUG2hCzGpi4jBI
         V3WtpnmqYezqPxfDzSuLJMngcN55M1VT1Bq/qDqm4W3utBHY82/6CIPE+ASD/tEg6Ngu
         m/xeiJyw1kmhdnPP5KUALuPex+RTsLmYuJAmt1Fl6ZWh34yuoeryUvu54kGkTSQw1Sry
         GJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052963; x=1763657763;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMCY5fmkZI76R3Lm7+dKka7numEpthvdX92HaVpx2Bo=;
        b=FgGSBuUjp+uqcYx1RrH5DsrGlvZQmKNK1s2ePU1z4A0ysz7fGnXG1Be+t+ytW1aRms
         QCNGeyUb0tHxNVN4vJB4lzssXz7cNuGYsEg0NvTK8L7fLSLrU7SspikMFxx3GkOOkHUw
         vTH3Uf0kE04g8+VPY8uohj7jmVSubKUCxYujwhRI1ycIlVLYYHkKaWHkQ8jCm7o8KPhH
         3d6fA1TPr0edYNpW5sF/tJST6oe8vYRDIQoAYj5Hd3pQIqMAl7oe8w6LM76dfhwKKtz1
         fTPyjD+vpwdVtMv8y5FiEmYkKvpkkjVyeblBi57yVfdAISS6UDM0ylqo7UcVd1Um1SjD
         6rsg==
X-Forwarded-Encrypted: i=1; AJvYcCWi4eRoGJRyQADzu6sAIBf7TMXNVWJlyR8wjSFD40hcah7IUSr072LDxPz957wyikBcmKmVARMKV0wTFVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1Ey4ij0U27zD7iQepK6WVoJEdwEoQfvsbbmnxFoqcffZVyuy
	1hDWaqygCV5lKdwZm13ZpZD5QLqbgWKE/gB6hixP2iArWf9jU9k4o4hrYtTSCYP4bH8CR9VUjhQ
	KirZeJlanT3GwqpnNCWtYJav6Q5U4hxPPKLhuLGblYg==
X-Gm-Gg: ASbGncumExNWaJfEW1b7ed2rk75mqGpX8xVwR7MzEq4vshOuVvphPCrm8aNrE7qBWy5
	K94CQmiBcwCByhY0uqUMr8Qmi0QIT87lrXwwLrmtJV+NMP6i3IdMBY97x5Ns3DdMmROOGc24Ph1
	u94AjECf4CsXKaoFgVQVKNFpXzcPg7IVe7nltBsGRmUBA9U5BslvQP7RpwtdwpFn8fQP51hs6cQ
	aQlkL0NLeYLt0/sqxmdAxjQGNJw/ckFJNvf/AT+VEuL2HIpvZItu3SI6jfQIH591uVT
X-Google-Smtp-Source: AGHT+IF7MT7H/N1FGVv2fGcWDDSq4G0lsAr/9izNZqOxycuQNiS8y26Pa9vU+efWnOrN6wB/Co4CNJQLTQPPNB+6gYM=
X-Received: by 2002:a05:6402:20d5:20b0:640:6650:9173 with SMTP id
 4fb4d7f45d1cf-6431a5906c4mr5014541a12.33.1763052961708; Thu, 13 Nov 2025
 08:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com> <20251107210526.257742-19-pasha.tatashin@soleen.com>
In-Reply-To: <20251107210526.257742-19-pasha.tatashin@soleen.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 13 Nov 2025 11:55:25 -0500
X-Gm-Features: AWmQ_bncXGN-eqIRVfciSwqz1sfkpOsYp0SxgOx72ZS1NRyOW1CKwiM1xe3CWB4
Message-ID: <CA+CK2bBmSD_YftJ-9w1zidLz2=a4NynnLz_gLPsScF145bu5dQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/22] docs: add documentation for memfd preservation
 via LUO
To: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	pasha.tatashin@soleen.com, rppt@kernel.org, dmatlack@google.com, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> +Limitations
> +===========
> +
> +The current implementation has the following limitations:
> +
> +Size
> +  Currently the size of the file is limited by the size of the FDT. The FDT can
> +  be at of most ``MAX_PAGE_ORDER`` order. By default this is 4 MiB with 4K
> +  pages. Each page in the file is tracked using 16 bytes. This limits the
> +  maximum size of the file to 1 GiB.

The above should be removed, as we are using KHO vmalloc that resolves
this limitation. Pratyush, I suggest for v6 let's move memfd
documnetation right into the code: memfd_luo.c and
liveupdate/abi/memfd.h, and source it from there.

Keeping documentation with the code helps reduce code/doc divergence.

Pasha

