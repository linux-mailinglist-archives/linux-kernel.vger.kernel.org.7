Return-Path: <linux-kernel+bounces-822136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF7BB831CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A815B72185F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC52D73BA;
	Thu, 18 Sep 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qWQgH7D8"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE0217733
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758176372; cv=none; b=g56rw3nWnNKvh+7ZBhoWCuICFxpOgdjVklS2Kh6P/llzRDfTFkRcxu+m3uYkTKDtJLBj1ogBILS9MPsbYY4OyxKwfgoekSkjx9HdYoR25+zaNsqRsvy8OCjZ7T17cx+ps2dtGGoBf2KaPqqUPzu9ENppU4XE1yo8YF+NIMaGWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758176372; c=relaxed/simple;
	bh=pzON+kBMGFTS0WUAKbUrjv29vcyYX+LBhhHjNIbl2ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWXeQEgFK926+0vBtGwXRFCUqfNTFsWKwmheukaTlFKOq987hQfoeLOADNXA7aigT5BdKV+6PlRMZLvJW1KRS/h8HUbkqQf/ig+PTbgnWSel+BfRBFHJOQ790QB8x0SpckhXvIHSfHBmz0IMBwb0f9PUWPAVkNDWROguNXDmRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qWQgH7D8; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758176366; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DGA+GS60PqTglOf88J2GSxkMEWKStluL9dMmCunHxKY=;
	b=qWQgH7D8pWSog+iCeZE88+AEVfHHWWutYzQ6ZA3OA2hmSugWIr7znAET+dJJ5xqHzKKSCmFaAqAdqBWIb1ZXda8MAFDJgNRkMBS4xpqv2JmwloAFMSXO6EArhV0miedpTkczOeya6QSi5kOAelEzEbRog3D8MYa2QERBwg/yYkg=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WoF.rCr_1758176361 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 14:19:25 +0800
From: cp0613@linux.alibaba.com
To: ganboing@gmail.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	cp0613@linux.alibaba.com,
	guoren@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: Re: [RFC PATCH 0/4] riscv: tarce: Implement riscv trace pmu driver and perf support
Date: Thu, 18 Sep 2025 14:19:21 +0800
Message-ID: <20250918061921.52513-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <58439862-945d-4b7d-bf6a-6d398e6dd744@gmail.com>
References: <58439862-945d-4b7d-bf6a-6d398e6dd744@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Sep 2025 00:27:43 -0700, ganboing@gmail.com:

> > Any comments or suggestions are welcome.
> > 
> > [1] https://github.com/riscv-non-isa/tg-nexus-trace.git
> > > 

> Hi Chen, thanks for starting this series. I have done a N-trace driver
> in user space: https://github.com/ganboing/riscv-trace-umd, and I'd love
> to see someone finally taking the effort to try a proper kernel driver.> 

> My overall suggestions:> 

> 1. We need a way to expose proper topology to user-space like coresight.
>     Thus, I'm thinking of using similar logic in coresight to export the
>     topology through sysfs. Potentially we can abstract some logic out of
>     coresight and make it a common core path that can be reused by riscv
>     trace driver. Thus, we don't reinvent the wheel. This also helps
>     debugging trace driver issues if anything goes wrong.> 

> 2. IMO, The driver should be moved to drivers/hwtracing/. It's not tightly
>     coupled with arch, and there are many platform related logic where it
>     doesn't belong to arch/riscv/. Having said that, I do believe we'll need
>     something in arch/riscv/ eventually for trace once the self-hosted trace
>     spec is finalized. Self-hosted trace behaves more like Intel PT, where
>     the control will be done through some CSR(s), and it doesn't need those
>     funnel/sink topology, and can emit trace stream to virtual memory directly.
>     It's a per-hart thing with LAMBI and all that. I'd imagine that eventually
>     riscv trace will be two parts. One is more coresight-alike, where you have
>     encoders/funnel/sink/bridge that are described through DT and controlled by
>     MMIO. The other part is more PT-alike, where the feature is described by
>     ISA-string (I guess?), and it's much easier to program. For the time being,
>     IMO, a coresight-alike driver, e.g., drivers/hwtracing/rvtrace, is more
>     suited for existing platforms implementing N-trace or E-trace. Also, don't
>     assume the memory sink is available. People using this "coresight-alike"
>     driver can very-well be HW engineers who's collecting traces using external
>     probes, so again I think we may want to abstract out part of coresight's
>     logic and reuse then in riscv.> 

> 3. I've already implemented a N-trace decoder:
>     https://github.com/ganboing/libnexus-rv
>     It can decode N-trace on real HW (ESWIN EIC7700/Sifive P550). I'll try to
>     see if I have the time to code up N-trace decoding in perf tool, once the
>     driver and the perf trace collection part is stabilized. If not, I will be
>     happy to review yours. Please include me in future series.> 

> BTW, perhaps you want to also CC riscv Task Groups such as
>    - Sig-Debug-Trace-Perf-Mon (DTPM)
>    - Tech-Self-Hosted-Trace> 

> to keep people like Beeman/Robert/Bruce/Iain/Greg posted. Robert mentioned
> they tried to contact Sifive to see if they had similar driver upstreaming
> effort just like yours, but there were no reply. Keep them posted anyway to
> avoid duplicate work. We should also discuss this during riscv NA summit if
> you or Guo's attending.> 

> > Chen Pei (4):
> >    dt-bindings: riscv: Add trace components description
> >    riscv: event: Initial riscv trace driver support
> >    tools: perf: Support perf record with aux buffer for riscv trace
> >    riscv: trace: Support sink using dma buffer

Thank you very much for your review. Every suggestion and existing work is
valuable, and I will carefully evaluate it.

1. I will further investigate the technical details you mentioned in
   CoreSight, reusing existing design and code as much as possible.

2. Moving the driver to drivers/hwtracing/ is a good suggestion, and I've
   considered it before.

3. We've noticed that there are many types of sinks, such as the Lauterbach's
   Debug Probe, as you mentioned. The current code does not reflect this, I
   will consider compatibility later.

4. Your implementation of the N-trace decoder is very useful as a reference.
   I will study it carefully. We also have an internal implementation, which
   I will compare and provide feedback to you later.

5. The RISC-V Task Groups should indeed be cc'd. Thanks for the reminder.

Thank you,
Pei

