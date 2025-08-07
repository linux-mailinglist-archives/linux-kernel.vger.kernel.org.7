Return-Path: <linux-kernel+bounces-759347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0298CB1DC6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90510189CBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7830273D7B;
	Thu,  7 Aug 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="UZUGJs/Q"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3533208
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587593; cv=none; b=E7IIT4U4FMmXZqnUCaLVOsJ1CX8W9M6zTYx5gXN+grmEclz9Fe29Ia7CsgSZ+gBxrex6oluICh19kOHHCa4OSq1pehbQ1DLl180FADppcf43mpR3ntnJxiMRAVhNd/bCqIWoFWAYr3PLtFOgoLjPFJ+XZRbHCxhynk8HByjDXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587593; c=relaxed/simple;
	bh=pb46ry44LgWLgMfVloaZqMENQPf7IeyFHi9rZVLLYzI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=g1YgE31HaYh9jNSebf00vrKkgInHXkuNG46nzi2NzR72m9HrnSrUOlyYgiI7eIy5ti+1WDLii0f1EPcVyc4+SRGXaf3NxRRZ4V/pW96AOBro3yHVhxEIJuJUcXAbCZg17A2JPP/N9F3A4tMnmI2jP5dMJJYzGDftXXqUcoNMufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=UZUGJs/Q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2403ca0313aso10650145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1754587591; x=1755192391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+h378Tf504uUiMOV37MEQKpGK3kMCBEgWjqEH4cjsGQ=;
        b=UZUGJs/Q8lX2o/yic13qITEW6hUxIqq83/i65FFVtiovjAlQIbglI7NPexzkVMjnRt
         XFCNUTkffnPGvGhwWpMWKquqvOc0xcJGVfoNtasxHaca6SH5x1SWnkcWhdhPHEIWMlyI
         y0fEGaOTMBxwVguARO6af9aX/yrmVCDanv0AC2vuyHiXkDfM6Blj0DvqqYJKkEVNBlk1
         USk31Yzl2h1ZorTIwPkz42u8mluD4w9r8SwscAKq7UPYhDoO+MslokYKpc8HZz08UBql
         2DnaZnXYAlqCrMo5Rb/nPCuywalZabfxZ+gJe+3eQcOIlZsr1WnQMA3e1A/oGbZzcJ+O
         jFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587591; x=1755192391;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+h378Tf504uUiMOV37MEQKpGK3kMCBEgWjqEH4cjsGQ=;
        b=cGdK95GnTKSe0ff+rv89/z/sSg+3xS5kSfhhihFJ/rQ8FnjvXS+bE5ISzjnG63eXwx
         rwJRaHk96quL0rBgLyYaCO1ktOlhwJVyCGKIrZUmPW8wgiRBOkbX+x+OV5Fk4tn4fmRC
         qR9IesJCkqtZQS5ujm4d7d+j+Y6vTOyEB38CFNVzNsQN1J28Qtot8qyS6Xu5la4fr54e
         PFRbz56q6/FRo5PNpz/hmlUxTdOHeua1QujKC+Etx2Zz3baAAA8OsEzC1vhjQ8TtP8FN
         izAZ3QqoKIaWlH4qRKZXKAEqxS9QUjyqGt8hVgAsHTdrtihMGLYjagO2WL3V4oJ/QV+5
         mvBw==
X-Forwarded-Encrypted: i=1; AJvYcCXzFfOLYbTW41uhCpn0NlsEZmPiJgQOPteqIiky8JZyAq+3yP6uka61D8NTYJzlSy68QumSBf73Lj0OVcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr49PSqEBDGTpTqCPyN1g+51WWcTtWCsjQTug9w/b4ZsoGM0yd
	Clrlx95TcEQB6naROhCsceuO258mM2woDLhV2vNrZ9bVhFMS8A8KXcxwN3luy2Wwx24=
X-Gm-Gg: ASbGncsPeYRwt3wfSn3OXuqueDP/XS0qEOmQeeNsHHS6kuhP/wJGDjgQz5o030slmsq
	uAK7mDyVPmVml9w0G6s+TRP4mpFjUnHnFoo4BPwBvywVf9sfPoz4M7bZqCYQEeGcynFo/EdxRcd
	VF/T0MCYgFOWycT4HM/0OMlvmwMxv2ka5w2ewfckJ4rTWvIXk27+sbllSlrtZdHWklt8UFpcx/q
	QnGLMlsJcVYBGISqcmHOrtD4bGx8AWF8PpD8QJYohQ24PtIc1U1DBuzcm6igKtMwnU+fi41V+xO
	A0cudqfDayHGEOaSj1VcErpSiNr6GWlv+rFdhLmWsfWbX3lwaUynJUKCt+NgwdmJ9NEwWupBP40
	Dtp8cAGV6t5zjciZUNphhCTjpSg==
X-Google-Smtp-Source: AGHT+IFozWV8vrd5EMGtMyKdfiS3Pbokb+TNy5cuHGj4vZa1810QnCu0am++Rh915Hc5K1tcnkuECA==
X-Received: by 2002:a17:903:41d2:b0:240:8704:fb9 with SMTP id d9443c01a7336-2429f582b30mr110618495ad.53.1754587590509;
        Thu, 07 Aug 2025 10:26:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:30b7])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241e899d21dsm188812445ad.139.2025.08.07.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 10:26:29 -0700 (PDT)
Date: Thu, 07 Aug 2025 10:26:29 -0700 (PDT)
X-Google-Original-Date: Thu, 07 Aug 2025 10:26:27 PDT (-0700)
Subject:     Re: [PATCH] arm64: Expose CPUECTLR{,2}_EL1 via sysfs
In-Reply-To: <864iuja70l.wl-maz@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>,
  Will Deacon <will@kernel.org>, oliver.upton@linux.dev, james.morse@arm.com, cohuck@redhat.com,
  anshuman.khandual@arm.com, palmerdabbelt@meta.com, lpieralisi@kernel.org, kevin.brodsky@arm.com,
  scott@os.amperecomputing.com, broonie@kernel.org, james.clark@linaro.org, yeoreum.yun@arm.com,
  joey.gouly@arm.com, huangxiaojia2@huawei.com, yebin10@huawei.com,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Marc Zyngier <maz@kernel.org>
Message-ID: <mhng-9D9CB730-A22F-43E2-A012-D51EF3C1E027@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 07 Aug 2025 01:08:26 PDT (-0700), Marc Zyngier wrote:
> On Wed, 06 Aug 2025 20:48:13 +0100,
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> From: Palmer Dabbelt <palmerdabbelt@meta.com>
>>
>> We've found that some of our workloads run faster when some of these
>> fields are set to non-default values on some of the systems we're trying
>> to run those workloads on.  This allows us to set those values via
>> sysfs, so we can do workload/system-specific tuning.
>>
>> Signed-off-by: Palmer Dabbelt <palmerdabbelt@meta.com>
>> ---
>> I've only really smoke tested this, but I figured I'd send it along because I'm
>> not sure if this is even a sane thing to be doing -- these extended control
>> registers have some wacky stuff in them, so maybe they're not exposed to
>> userspace on purpose.  IIUC firmware can gate these writes, though, so it
>> should be possible for vendors to forbid the really scary values.
>
> That's really wrong.
>
> For a start, these encodings fall into the IMPDEF range. They won't
> exist on non-ARM implementations.

OK, and that's because it says "Provides additional IMPLEMENTATION 
DEFINED configuration and control options for the processor." at the 
start of the manual page?  Sorry, I'm kind of new to trying to read the 
Arm specs -- I thought just the meaning of the values was changing, but 
I probably just didn't read enough specs.

> Next, this will catch fire as a guest, either because the hypervisor
> will simply refuse to entertain letting it access registers that have
> no definition, or because the VM has been migrated from one
> implementation to another, and you have no idea this is doing on the
> new target.

Ya, makes sense.

>> That said, we do see some performance improvements here on real workloads.  So
>> we're hoping to roll some of this tuning work out more widely, but we also
>> don't want to adopt some internal interface.  Thus it'd make our lives easier
>> if we could twiddle these bits in a standard way.
>
> Honestly, this is the sort of bring-up stuff that is better kept in
> your private sandbox, and doesn't really help in general.

So we're not doing bringup (or at least not doing what I'd call bringup) 
here, the theory is that we just get better performance on different 
workloads with different tunings.  That's all still a little early, but 
if the data holds we'd want to be setting these based on what workload 
is running (ie, not just some static tuning for everything).

That said, part of the reason I just sent this as-is is because I was 
sort of expecting the answer to be "no" here.  No big deal if that's the 
case, we can figure out some other way to solve the problem.  Happy to 
throw some time in to making some more generic flavor of this, though...

> Thanks,
>
> 	M.

