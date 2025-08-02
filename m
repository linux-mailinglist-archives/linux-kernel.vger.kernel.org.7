Return-Path: <linux-kernel+bounces-754244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B341B190D4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 01:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7638189974E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCCA1DEFE6;
	Sat,  2 Aug 2025 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IzAEYSMQ"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE2B1D6DA9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754177627; cv=none; b=A20Vy16qRDsqIjAaeHnscXiVf+/OCtUUjYv9UZpAEli5Sef2OyyZSqk+dCdwcSkt5NNw0zZNn8Es3Tx6VxrafLZiAL1eIrqtOe+UfU78Dc/BC0jSV/jUrJctXpgjAFYuHNzpv5VqjCZsXBBO9VZwJTuoAkDVfDMEBKTImCH+Bt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754177627; c=relaxed/simple;
	bh=kJsgdU92CHKcumA558FjE09dL3p6PDIATBJc8UDK+q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dD3weEPsUNe6iMO329dMRhw0Rcv686zruqRkoWx3YI99m61/1K8zx0FqkW9DSjpaUiEM6Ge3wZQm4upqg8F2eaBjZ8NA4jCs11GKyz0I6t5bz7CRJfpvZE1kHWk9Hm9+DQcW7qWHzYHvkHZzMBagufal1dmKbIsk4kIwN8UgvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=IzAEYSMQ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab5e2ae630so27558261cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754177624; x=1754782424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJsgdU92CHKcumA558FjE09dL3p6PDIATBJc8UDK+q4=;
        b=IzAEYSMQQxBOsikic/wv4S2Ak1IkZWDRqiFN9WKskOPCYCKnFySUQlasVHApND+PMR
         OCjjIv3KDQDhiLV7iCbKECJEl0TiLe3LVTmuy6gNIAPlrHpPMvaWeAUew+pYDqxDAdq4
         cRYIk3Pk40uuINjMm25FNjXxHw1561DmTbJKWM4u2DSj995QfnrH1KmOwQGD9nFg6Tzy
         eSGc8sOAfVf6chgTuWPeRCwVLIPcObgRenylCwTmVbeWGXJ7/Ql9GaIrxyl7KD0kBpwd
         JYCDYQADCKMCdpfH8waqilxH0gttD+Wvvd/08ZapWIo6fXD3VG1lnW9cGur68EAGto5p
         gp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754177624; x=1754782424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJsgdU92CHKcumA558FjE09dL3p6PDIATBJc8UDK+q4=;
        b=xMXFG7p8lfZxxITokjLj1JbQNIc2IgDcLsh90hMkf3OfIg2bkmpx9mUKOvnxP+xp8/
         Jds2hMOgvDd/zdQDSZ9ICC5S0/rgo6imIQ9+YnCL3IaVFY469sxbmxFn9uJVwqrX0I4y
         nEBivHMubwKffzsQyV8MkDkQPBYW/CfED2GdafxR+TRCjLFHt0+D0kbhcXfb8FVI4mTG
         CZtf0Mw6C82tntDvvbhahRlt5kB0kcXegFbA4TyeWgB728K84BnyMp4w6oJiwnWSQ/GT
         /+FFNXU/MRN2g2ZynAfxHBIgmDhIjn6Gwng3bMPm0AN76EEfMGhd81Sp36+RcRy3pNSy
         1zeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6mkINkTtc4MMmofI5UVgHN7hvrXQiOqBA8g3d0V6dyTb8KYR18exxSh0FtTS23plKMQo0Exk1kMoNrYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi7CKrYxOFaD5iLnPioN92G7l/kYLU2vRw8LhsHHZKzhTA3ldN
	Ly9rfODICEMv+VgbpDOfKwEPeFefbsHc9JR6xuEs2RT+xN+uI9ZbyngbD8eShzBDo8uE67zxz2l
	pvkI+NK2ulGsPjHWkZ7VCqVWb7Gy7qASTXNSMfxVlEw==
X-Gm-Gg: ASbGncu6snFTN9Y4AjlFrC2bwihezUMHl6BA3+YQzsAxzHNI0XgQ/HT/hq9IggQJlvt
	0GgNwvHIXEI0fnVmsSbDm3BPngszGP9M270yRB1Ofxe9PQ68Nhay46BD0HY0Kzng6AeHpigCiu1
	MHGBRA4qdZJQc2SjMJfZu26L32CR/7uAHDcriaLEz5hXwVIdJdHSXxRcnKq53WpQDrDoM8fvOb+
	oC3VbU/Y4qrHbA=
X-Google-Smtp-Source: AGHT+IHK7fLZil0+YTWDez+wvKBQ8V6Jt/OxjDZMFuEzIGCH7fVFxrWmUeAnr0aeRkYb+cC5kQOxq3dgtd4ni01q4II=
X-Received: by 2002:a05:622a:8cd:b0:4ab:3ffe:409d with SMTP id
 d75a77b69052e-4af107905acmr85155491cf.0.1754177624500; Sat, 02 Aug 2025
 16:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-2-pasha.tatashin@soleen.com> <aIdNTN1qd0dTvsQm@kernel.org>
In-Reply-To: <aIdNTN1qd0dTvsQm@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 2 Aug 2025 19:33:08 -0400
X-Gm-Features: Ac12FXzhu6LQ65rG6yLekEcwlc9H74rWaGowwnkVgbEc9_PttPli4Tw81uem1BM
Message-ID: <CA+CK2bD2pyWmnzDyRA54nXQwB1ABPKqWP2yH6bVnnE09ogCHXg@mail.gmail.com>
Subject: Re: [PATCH v2 01/32] kho: init new_physxa->phys_bits to fix lockdep
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, dmatlack@google.com, rientjes@google.com, 
	corbet@lwn.net, rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, 
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
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> Just int err should be fine here, otherwise

Done

> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

Pasha

