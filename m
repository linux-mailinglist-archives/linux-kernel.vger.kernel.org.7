Return-Path: <linux-kernel+bounces-771077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64674B2829C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD4F189F19A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E78220F2A;
	Fri, 15 Aug 2025 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="mZKauASq"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28521CFFA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270352; cv=none; b=hp0r3tvWqYFQER05vrp0ru6hFHM9KTR5JrvSmY3rwGjdTnfBb3K3W9dInWNEvL4GnvTPzoA9Ko83RmAdpBX/2dthO9IU84drcsl31+vvo3SCrI2YQKjAvZyWbVNsGsJt2gnXZ9tqxhRj62ig5fpjN+rxeu/htkZwGeLaVmPkTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270352; c=relaxed/simple;
	bh=wNfhEAk3rnqID1OBHwaELciuLi86NZwkA7swq1t5JdI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=LkKMj6VKpd95BrWgDo5petM+P+xaW8E+Dz0aErbUGyYzTkT/ZJuMIdLDxuwIInkjFIRDeq4thrd4IKDqgzZFLhfjVcSlTm1gtTsZD6Plzue/LzVlHHHW5qwNBEbpk+04a6AX1EPaqs3Vs3kmM5kMaB2hD5lBOMQ2hxIT+7MRAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=mZKauASq; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4717543ed9so1341353a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1755270350; x=1755875150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38zqqxNHqbGz3C68JOy9Ugb8wAb711DWGVbxjNinx0U=;
        b=mZKauASq6wZkezrwzg5EsqpZPzKSyUiLiawcT9BlsvW3YiILWWbdCLQfpTP13qY6fB
         oZwx20nglnVNrDmmPfk4aePlJDu2TAg1mBu6EglTB/5H97T2cGuSu4PxV7HImr8TrepE
         68t/id3y3tOVHNYVxVkwTaIc14VHd7H1o9mUsS4bzQlMJR/z7XxZmVnGsRHSebQYgnEV
         rSZiKzLN5z5qnW2SjxlNV1Brx5GmqFnBIIZxMHmU2kyWh2/WybeT81JLEcA4kHv1QC8W
         CS8Wu00IF1ktWN/Ff/zHUzMA0yvpQqSCuCbC8nUpYkKRabnJW3fuJQ0QupC66XAb6JiG
         WqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270350; x=1755875150;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38zqqxNHqbGz3C68JOy9Ugb8wAb711DWGVbxjNinx0U=;
        b=H+E5OOd4fhCnYRjpkAgaTnXM0TdLvuPUVYuBAmiKxmIxUvyTdbhLhGr/fdfOD34eNW
         PbPDun/VDTMDLD9eukS4XY29si1JBeXA8LJSCOsDh551aCZ7SNir0O6DOrC5oXl4XPPH
         PTP3f7P3oIX5i0JvxE1U3khV9SLon8YYgthTFPjiMJj9eCD0bZSmDX5jgJ/BgA19AMtY
         ufVtNDj8ztU3EGIV30MqrI2u/m29EWXvC3ptLd+9WIlraRR2NGQf9R1kjbRYlctMDZJv
         z3gEBgGdLwLUszCj4l1ltWglSDaKTKT/UCt/TcIaI1KP+UDwquyKAuHOz1RcvzWZ0FEe
         m5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXq0757+7V7KgkknwrRV+uhnUC0Rm1LYI7qdE8wNq3gaVbDx32PU8sG4qv3QFyliZ576/kELLhWwStzmDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyG/+NClpKP4y8/GcqhEnArw37ncMKQg/bDvpE4+NaXSdPPDWP
	J48kbjAnofIed9YltB/L689fs+ygIAt6jNz1MS7T5fLtz0DyEl2BVuwdbSr2nxSEyLA=
X-Gm-Gg: ASbGncuTgFrRgAnNXyLfCFSxNACqPiDk2H2aP9bfFBNMGFdbAQR8i8Ix0uhXbi8aN5l
	Nf0msiWW1IW0knBOhbnpNd8/jVso1r77ULAilifXRKL3hd3umBqY4i2IJDmS8kfdUwmvC5QTPyS
	ALz4IwDMF5oh50Hm6NAYD0EYfKl97aMZdpxQmruqgI5l5xHXw0DwUcaDk1HjNkh+zumOvDPxAd4
	tGf/EZVuS8xGxGib7s6i+SVLmzAcUNEzVVk4ujgNW8eHimgScu70C4q+lkw9SAklB/1ZL3xeJAu
	aEZ1EKjB1jqweKIB+5YGBi3dxOPX7dyG8/4qbyamqQPyGrwQIwB57KfsQNgQokPuyuaDD4+DOk1
	13iM1Y9zZ57U6zkg2MlDO8Tkz53c3opc9mFg=
X-Google-Smtp-Source: AGHT+IG3gBMogdOr+spUGY65daTLUVfmz5lhgO/opdXo6UimhkccgL0C2Gx+F8DUbrOBq4AI/2z6Vg==
X-Received: by 2002:a17:903:198c:b0:240:a222:230c with SMTP id d9443c01a7336-2446d5af743mr41307075ad.12.1755270349908;
        Fri, 15 Aug 2025 08:05:49 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2446cadf96fsm16286885ad.41.2025.08.15.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:05:49 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:05:49 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Aug 2025 08:05:47 PDT (-0700)
Subject:     Re: [PATCH v4 06/24] riscv: elf: Move relocation constants to UAPI
In-Reply-To: <20250812-vdso-absolute-reloc-v4-6-61a8b615e5ec@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  Alexandre Ghiti <alex@ghiti.fr>, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
  justinstitt@google.com, luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com,
  kees@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
  hpa@zytor.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
  linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
  maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
  chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, gor@linux.ibm.com,
  agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, tsbogend@alpha.franken.de,
  ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
  bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
  tmgross@umich.edu, dakr@kernel.org, nicolas.schier@linux.dev, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
  linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org,
  linux-kbuild@vger.kernel.org, jstancek@redhat.com, acme@redhat.com, alexghiti@rivosinc.com,
  thomas.weissschuh@linutronix.de
From: Palmer Dabbelt <palmer@dabbelt.com>
To: thomas.weissschuh@linutronix.de
Message-ID: <mhng-5B6E084E-60EE-440E-BFF9-5E81AAC9A473@Palmers-Mini.rwc.dabbelt.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 22:44:19 PDT (-0700), thomas.weissschuh@linutronix.de wrote:
> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
>
> Move them from the kernel-private architecture-specific header to the UAPI.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/riscv/include/uapi/asm/elf.h | 66 ---------------------------------------
>  include/uapi/linux/elf-r.h        | 66 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 66 deletions(-)

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>

I'm going to assume you want to take these all together though some 
other tree, thanks!

