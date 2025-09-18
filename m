Return-Path: <linux-kernel+bounces-823670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E319B871DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C37583025
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043512F4A0A;
	Thu, 18 Sep 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz0/xb20"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF72820DB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230694; cv=none; b=bnnFtXgsqSqLVYNEhy/nNgxU8m1joGAER1Fj5vU/hLXoazxSY1NqQKmAiyyD+qIzSR9UglcqqQCIFl/Mmo2kiJqNxxTP5o/ftGtAizIZ8J82AOfrDbDmiFd3wz15yfxbnsdoe6+S26FzEe4hOlLUlH+e3b5tsQWxoIVn68XjVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230694; c=relaxed/simple;
	bh=lW0zTdNY7jL+psecSiYTdrPn5JkxVIFF1eRhab2r6Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXA3I8zsEjD1g9EWICvvFRfJjVXumx6ZwAZXBfcIjjra05bJPsoIQQPwukfRRYGB9m/jMVDZYAhVppzHXzyD9lGMlztqCRdI8KmNfp/uAYdRG51sZhCCco3pHrpIyZprAGhnQDcjTa3cqyl2lgW4Pe1HGqeFtjIJaWL1lcp/AMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz0/xb20; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ef166e625aso60427f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758230691; x=1758835491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlFCbhCTpOXXCa+leD0aC1fFvORDxKQ+b7Z61x2UmGs=;
        b=iz0/xb20OYqyXmSHgpP3aZwc4KXeRBOeo2qov15bnPKijMt7az9R4MXzxAGEVMDAAM
         rqL2S9laUhhyl5AkRP5cPb0wO1YM6CrA2O4k2/aC+xzWWGcUTO532RvJXbUIzZnLDujx
         VvMy6YCS7BaGPdMqxQMAlFUmBXXNrcS8hlGcq1QYlnsDLDYS0T9PZu0Q7oBGplly8EH5
         948bHE89d0qJB6vHFGtBptMJIie1Dt3FGZB6NpulHw4z6FIf/4tg7TD0qixVXcTFYbY5
         EyeJOpUm5yUNx8kkEudARelguV0TcxwV9rjgWyli9fhrjNy8M9f6zAVgxCOjAlxT5IxK
         z54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758230691; x=1758835491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlFCbhCTpOXXCa+leD0aC1fFvORDxKQ+b7Z61x2UmGs=;
        b=vv/DqLOViOLxKaYcz400gPqCblidgFtp6ljCQ8djwlrBtE6KvUHsKVKKWtvzLgzjKr
         /dguK5PCTcVtWafiUExaZpQEsQyRtDhZuo6P5D+W9er3mk1rNy/WKVOeSCHyfx2x+Jqq
         hMX+R89Xwhqct5eDunPuP23ERLWD05/kTFK+xsHQnA2KBnAaj+hIWJ9tKnomrNq+RHrz
         dRsAAgV/EnaKn6NBzelu7zvt+uHK1+yuniM2yG44NG+SNVg+1xavc/AlBoLoQcmYBk/j
         DD2+ugQTegoT/rS9elGeFxtIEO1Y6vrZe581Y55mPSwwTztWC/1P8QW2naPJMmU+Cn5S
         5Cfw==
X-Forwarded-Encrypted: i=1; AJvYcCUFpE/GRc7PQ2SvACUYg/a+gsrq9GKB2rqhCSY1fE7T+Tx6woxowFxttysa8y8NeOmRGLfsUwIRwARYzNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6TYzSqAZJdDHxOcWt4RThP7aw4v4igXNrSE7oQq3UGYs8J8BC
	RCkKyPxd1vAl0g4Uz2C0YygHlp7CVBkAQHXIZA2TO9MSZ1T9yJ+fEh0L
X-Gm-Gg: ASbGncvD77rm/QlVN5UiCgD5bioJcgZwwYInMwN+cXUIr0dWtmSmjLgTnLFzLWbluVH
	L/R8ClCrqHML+h7mPh+FQb9BBR9JqNMMLUEr+h8w2NMzSllolnPEQovNQu1uzeH7izQIiNIP0dG
	XKIHEKF6YP5TuSCt/nXUsmbt3AYI0jbcDixkdP2qZtlBTE6/5mEWBCxFq2WVPFlWiz2i7Ktl/3L
	wT/z1UpWQ+fQGw2rYYE+AUAKgoL5Xn4vnzKy3CdvpvohijBOEbG7bAJdIrQkPOZGZoz1G+flvWL
	3zw2dfZiUiUQeBtkHv8yYYn1i66B3dapfaE/+PNr7V6ak3QJotCNccUPvhH6K6/IBfjE1oYq9T+
	T4zDPW91+BpywC0clI7e2mpPaIQeDsCbNcmIGMIE=
X-Google-Smtp-Source: AGHT+IGVI9rYSUJl9pXRwEIpExb/jYBmQ2Wo2Ykd83GR5P8ke+XLU8cSqFTa/VqojplpA7DbaQTJvw==
X-Received: by 2002:a05:6000:2910:b0:3ec:ea73:a91e with SMTP id ffacd0b85a97d-3ee7c552a02mr532419f8f.12.1758230690687;
        Thu, 18 Sep 2025 14:24:50 -0700 (PDT)
Received: from andrea ([176.201.192.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e849a41sm96925155e9.20.2025.09.18.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:24:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 23:24:41 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Guo Ren <guoren@kernel.org>
Cc: Xu Lu <luxu.kernel@bytedance.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com,
	brs@rivosinc.com, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	apw@canonical.com, joe@perches.com
Subject: Re: [PATCH v2 0/4] riscv: Add Zalasr ISA extension support
Message-ID: <aMx4mS0K8f_aDV_q@andrea>
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
 <aLciY2putG8g2P9F@andrea>
 <aMoyntAydNMtcl+3@gmail.com>
 <aMw3504EwlnDOJI0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMw3504EwlnDOJI0@gmail.com>

[merging replies]

> > I prefer option c) at first, it has fewer modification and influence.
> Another reason is that store-release-to-load-acquire would give out a
> FENCE rw, rw according to RVWMO PPO 7th rule instead of FENCE.TSO, which
> is stricter than the Linux requirement you've mentioned.

I mean, if "fewer modification" and "not-a-full-fence" were the only
arguments, we would probably just stick with the current scheme (b),
right?  What other arguments are available?  Don't get me wrong: no a
priori objection from my end; I was really just wondering about the
various interests/rationales in the RISC-V kernel community.  (It may
surprise you, but some communities did consider that "UNLOCK+LOCK is
not a full memory barrier" a disadvantage, because briefly "locking
should provide strong ordering guarantees and be easy to reason about";
in fact, not just "locking" if we consider x86 or arm64...)


> > asm volatile(ALTERNATIVE("fence rw, w;\t\nsb %0, 0(%1)\t\n",	\
> > -			  SB_RL(%0, %1) "\t\nnop\t\n",		\
> > +			  SB_RL(%0, %1) "\t\n fence.tso;\t\n",	\
> > 			  0, RISCV_ISA_EXT_ZALASR, 1)		\
> > 			  : : "r" (v), "r" (p) : "memory");	\

nit: Why placing the fence after the store?  I imagine that FENCE.TSO
could precede the store, this way, the store would actually not need
to have that .RL annotation.  More importantly,

That for (part of) smp_store_release().  Let me stress that my option
(c) was meant to include similar changes for _every releases (that is,
cmpxchg_release(), atomic_inc_return_release(), and many other), even
if most of such releases do not currently create "problematic pairs"
with a corresponding acquire: the concern is that future changes in the
RISC-V atomics implementation or in generic locking code will introduce
pairs of the form FENCE RW,W + .AQ or .RL + FENCE R,RW without anyone
noticing...  In other words, I was suggesting that RISC-V _continues
to meet the ordering property under discussion "by design" rather than
"by Andrea or whoever's code auditing/review" (assuming it's feasible,
i.e. that it doesn't clash with other people's arguments?); options (a)
and (b) were also "designed" following this same criterion.

  Andrea

