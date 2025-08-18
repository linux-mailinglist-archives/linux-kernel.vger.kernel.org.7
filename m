Return-Path: <linux-kernel+bounces-773063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F17CB29AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E1B201BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02427E1C5;
	Mon, 18 Aug 2025 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fthnHbbw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F42797AE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502950; cv=none; b=NI1X18/iwpL8XCsto5etunqVyOrvPCsKOhfIStWXZzZ9pGU0X9uX4+6Gqyn2QHwGy/g4OMl3PIo4vm13+w8YBaegkHJL+aTQ6jCTXI4E8yZbRoTBDWr51kGLBLeFQHLuJdCoLhI7DcmhK+3ecN+P/laDmMF7iiaNPEL/4rsb4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502950; c=relaxed/simple;
	bh=DLscWRKBqf/6Hz6eH4iltW6CedIIOrmtcVy9JxKpnEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AaR5DKlO+OFkAcaJ1C3QxNH6uiQmS6XIcQLvTjVPHWlqygYmrMYklhCDMCHhNNbPC/yonau/5DxW5pdj1ZXJ+x13uF4XwlRsfixKaJP5YPyO/1atkIQRWiKrmCUGwbkjJMi8LUGi2RdAJzB7xVXM2K1zQZ4cDYPUxBT4Wc503gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fthnHbbw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755502947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=50iptxgF76lSBHlPJpOAe74hdT1ws8yqI6TSKvItRkU=;
	b=fthnHbbw/OdfvmbU6QlniuZwWPeYYIFsFfntX4vcWiMRuM30uaUENze6Zi1Aci429YSSLX
	LEKLkda6RPxTk6Fas4SPfWK0fra6llu17tzHOdT6rxYxSNlxNBigGRhrXUqVDGr5szZvf1
	qp5hNwshr6ON6epKlOhfM84zJpBa/lg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-qSX4bN64NCKcMaVa1gzSVQ-1; Mon, 18 Aug 2025 03:42:25 -0400
X-MC-Unique: qSX4bN64NCKcMaVa1gzSVQ-1
X-Mimecast-MFC-AGG-ID: qSX4bN64NCKcMaVa1gzSVQ_1755502944
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870662c1dso1105869385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755502944; x=1756107744;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50iptxgF76lSBHlPJpOAe74hdT1ws8yqI6TSKvItRkU=;
        b=Mvx1ZOrmMHs/9E/FLTDiM1oSktp+Df5YsGkwd1E8MypmYiEzsJr0ru2hetL1gm7tcH
         KKNJQ7ag1CvrH6h0axqoP7qC+tb7AgMUidYnXZJRGw6+t84+huTrqbORsdt7+05Y/To/
         WTMtlfxY6F+s8vaiRn8X43xRGLwqdGE+mZrwo9UwNCVFGq5ihDAnkgl0DFqWxcqP5g9I
         5W0CbTNIrxkXUbY34Ds9o/e8cMYDZQ0BJcu7ZvuFHkiHo405YGnL0/HDt4PsGvqFOZR+
         KIcZbDa3LzPKnzS7YZQmAaBTjLB1cY7nyGbwPqFb99j0sAlVGoYF0rwU8huXEhwloSu1
         DtNg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0DPANWjuVjNSKaDIBzEg/85Sq447nxRki+E6g4J/Xbj99ZsrYaPGCEVF1Fn8RoooCzYtAUwd7CouJ8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnzX8BUdCJ+4ow4b334iLlx5n8THWxEb8iqJv1A+8v3G1VKpa
	McrQmExOLYBsZulx5OVIlW1dzpWEX9lVpcFYEgnLyI1mru0NETQSN4ry1gT553GPSJtkeSIITCT
	vscWYkxjcHLm7dh/xL0mO+E9edTmBHDJ0fJYS189qogrr5sBS44Xg1h2kY4Z24lJoRrUyUokUe1
	jp
X-Gm-Gg: ASbGncve+zQgzgWWdljOjcod7/IxESgVHmMuVpGfJN7XOzvV+XE3TVbXJbgEnY6z0Um
	X2H/0Lukfg9GBFe4NzLGfSITabsTseqTwbEYfquiB+72EMIDQMGT/uWXjS0o3XN5iKdIobY7uOY
	ZwBnVAGGe/8OR6LEFER1zgZbFnLiqIaypfUWHr39MMGbJa45nc6VlHiYJk/S6tuPNpgaPWs5BH8
	eJ6OttX7HWnXI5Sgg2E7urrElXTFguJXv6WoflHXCMclVogr1quQ+oKKSDbdcWc805bGYlYs3bi
	ni2G8Bvc51o3FeFay7gzdEPbpyQgWPqZwMpVG5z5uY4fzwbSxg6+INWfA1TXN784RA==
X-Received: by 2002:a05:620a:4091:b0:7e8:468e:67e2 with SMTP id af79cd13be357-7e87e022174mr1377493985a.26.1755502944537;
        Mon, 18 Aug 2025 00:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRXC2JR+1fI/my+9nPQsowb81rzv2FE65uoh0btXxA8YD6B27KnuUhBXdc6IplAFVmGWA78w==
X-Received: by 2002:a05:620a:4091:b0:7e8:468e:67e2 with SMTP id af79cd13be357-7e87e022174mr1377491885a.26.1755502944042;
        Mon, 18 Aug 2025 00:42:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de17cb4sm48380871cf.43.2025.08.18.00.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 00:42:23 -0700 (PDT)
Message-ID: <9ee2ad87e78a87d0d4ff0aee6fc7cf01c21f7cf7.camel@redhat.com>
Subject: Re: kernel/trace/rv/monitors/sleep/sleep.c:130:7: error: use of
 undeclared identifier '__NR_clock_nanosleep'
From: Gabriele Monaco <gmonaco@redhat.com>
To: kernel test robot <lkp@intel.com>, Nam Cao <namcao@linutronix.de>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>
Date: Mon, 18 Aug 2025 09:42:20 +0200
In-Reply-To: <202508160204.SsFyNfo6-lkp@intel.com>
References: <202508160204.SsFyNfo6-lkp@intel.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-16 at 02:37 +0800, kernel test robot wrote:
> tree:=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=C2=A0m=
a
> ster
> head:=C2=A0=C2=A0 ee94b00c1a648530333d9734200be7a45e6e00cd
> commit: f74f8bb246cf22f27752977da62079cb615f55b2 rv: Add rtapp_sleep
> monitor
> date:=C2=A0=C2=A0 5 weeks ago
> config: riscv-randconfig-001-20250816
> (https://download.01.org/0day-ci/archive/20250816/202508160204.SsFyNf
> o6-lkp@intel.com/config)
> compiler: clang version 22.0.0git
> (https://github.com/llvm/llvm-project=C2=A093d24b6b7b148c47a2fa228a4ef315=
2
> 4fa1d9f3f)
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20250816/202508160204.SsFyNf
> o6-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202508160204.SsFyNfo6-lkp@intel.c=
om/
>=20

Palmer, this issue is what you fix in
https://lore.kernel.org/lkml/20250804194518.97620-2-palmer@dabbelt.com/
, right?

> All errors (new ones prefixed by >>):
>=20
> =C2=A0=C2=A0 In file included from arch/riscv/include/asm/io.h:136:
> =C2=A0=C2=A0 include/asm-generic/io.h:804:2: warning: performing pointer
> arithmetic on a null pointer has undefined behavior [-Wnull-pointer-
> arithmetic]
> =C2=A0=C2=A0=C2=A0=C2=A0 804 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 insb(addr, buffer, count);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 arch/riscv/include/asm/io.h:104:53: note: expanded from macr=
o
> 'insb'
> =C2=A0=C2=A0=C2=A0=C2=A0 104 | #define insb(addr, buffer, count) __insb(P=
CI_IOBASE +
> (addr), buffer, count)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ~~~~~~~~~~ ^
> =C2=A0=C2=A0 In file included from kernel/trace/rv/monitors/sleep/sleep.c=
:2:
> =C2=A0=C2=A0 In file included from include/linux/ftrace.h:10:
> =C2=A0=C2=A0 In file included from include/linux/trace_recursion.h:5:
> =C2=A0=C2=A0 In file included from include/linux/interrupt.h:11:
> =C2=A0=C2=A0 In file included from include/linux/hardirq.h:11:
> =C2=A0=C2=A0 In file included from
> ./arch/riscv/include/generated/asm/hardirq.h:1:
> =C2=A0=C2=A0 In file included from include/asm-generic/hardirq.h:17:
> =C2=A0=C2=A0 In file included from include/linux/irq.h:20:
> =C2=A0=C2=A0 In file included from include/linux/io.h:12:
> =C2=A0=C2=A0 In file included from arch/riscv/include/asm/io.h:136:
> =C2=A0=C2=A0 include/asm-generic/io.h:812:2: warning: performing pointer
> arithmetic on a null pointer has undefined behavior [-Wnull-pointer-
> arithmetic]
> =C2=A0=C2=A0=C2=A0=C2=A0 812 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 insw(addr, buffer, count);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 arch/riscv/include/asm/io.h:105:53: note: expanded from macr=
o
> 'insw'
> =C2=A0=C2=A0=C2=A0=C2=A0 105 | #define insw(addr, buffer, count) __insw(P=
CI_IOBASE +
> (addr), buffer, count)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ~~~~~~~~~~ ^
> =C2=A0=C2=A0 In file included from kernel/trace/rv/monitors/sleep/sleep.c=
:2:
> =C2=A0=C2=A0 In file included from include/linux/ftrace.h:10:
> =C2=A0=C2=A0 In file included from include/linux/trace_recursion.h:5:
> =C2=A0=C2=A0 In file included from include/linux/interrupt.h:11:
> =C2=A0=C2=A0 In file included from include/linux/hardirq.h:11:
> =C2=A0=C2=A0 In file included from
> ./arch/riscv/include/generated/asm/hardirq.h:1:
> =C2=A0=C2=A0 In file included from include/asm-generic/hardirq.h:17:
> =C2=A0=C2=A0 In file included from include/linux/irq.h:20:
> =C2=A0=C2=A0 In file included from include/linux/io.h:12:
> =C2=A0=C2=A0 In file included from arch/riscv/include/asm/io.h:136:
> =C2=A0=C2=A0 include/asm-generic/io.h:820:2: warning: performing pointer
> arithmetic on a null pointer has undefined behavior [-Wnull-pointer-
> arithmetic]
> =C2=A0=C2=A0=C2=A0=C2=A0 820 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 insl(addr, buffer, count);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 arch/riscv/include/asm/io.h:106:53: note: expanded from macr=
o
> 'insl'
> =C2=A0=C2=A0=C2=A0=C2=A0 106 | #define insl(addr, buffer, count) __insl(P=
CI_IOBASE +
> (addr), buffer, count)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ~~~~~~~~~~ ^
> =C2=A0=C2=A0 In file included from kernel/trace/rv/monitors/sleep/sleep.c=
:2:
> =C2=A0=C2=A0 In file included from include/linux/ftrace.h:10:
> =C2=A0=C2=A0 In file included from include/linux/trace_recursion.h:5:
> =C2=A0=C2=A0 In file included from include/linux/interrupt.h:11:
> =C2=A0=C2=A0 In file included from include/linux/hardirq.h:11:
> =C2=A0=C2=A0 In file included from
> ./arch/riscv/include/generated/asm/hardirq.h:1:
> =C2=A0=C2=A0 In file included from include/asm-generic/hardirq.h:17:
> =C2=A0=C2=A0 In file included from include/linux/irq.h:20:
> =C2=A0=C2=A0 In file included from include/linux/io.h:12:
> =C2=A0=C2=A0 In file included from arch/riscv/include/asm/io.h:136:
> =C2=A0=C2=A0 include/asm-generic/io.h:829:2: warning: performing pointer
> arithmetic on a null pointer has undefined behavior [-Wnull-pointer-
> arithmetic]
> =C2=A0=C2=A0=C2=A0=C2=A0 829 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 outsb(addr, buffer, count);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 arch/riscv/include/asm/io.h:118:55: note: expanded from macr=
o
> 'outsb'
> =C2=A0=C2=A0=C2=A0=C2=A0 118 | #define outsb(addr, buffer, count) __outsb=
(PCI_IOBASE +
> (addr), buffer, count)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ~~~~~~~~~~ ^
> =C2=A0=C2=A0 In file included from kernel/trace/rv/monitors/sleep/sleep.c=
:2:
> =C2=A0=C2=A0 In file included from include/linux/ftrace.h:10:
> =C2=A0=C2=A0 In file included from include/linux/trace_recursion.h:5:
> =C2=A0=C2=A0 In file included from include/linux/interrupt.h:11:
> =C2=A0=C2=A0 In file included from include/linux/hardirq.h:11:
> =C2=A0=C2=A0 In file included from
> ./arch/riscv/include/generated/asm/hardirq.h:1:
> =C2=A0=C2=A0 In file included from include/asm-generic/hardirq.h:17:
> =C2=A0=C2=A0 In file included from include/linux/irq.h:20:
> =C2=A0=C2=A0 In file included from include/linux/io.h:12:
> =C2=A0=C2=A0 In file included from arch/riscv/include/asm/io.h:136:
> =C2=A0=C2=A0 include/asm-generic/io.h:838:2: warning: performing pointer
> arithmetic on a null pointer has undefined behavior [-Wnull-pointer-
> arithmetic]
> =C2=A0=C2=A0=C2=A0=C2=A0 838 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 outsw(addr, buffer, count);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 arch/riscv/include/asm/io.h:119:55: note: expanded from macr=
o
> 'outsw'
> =C2=A0=C2=A0=C2=A0=C2=A0 119 | #define outsw(addr, buffer, count) __outsw=
(PCI_IOBASE +
> (addr), buffer, count)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ~~~~~~~~~~ ^
> =C2=A0=C2=A0 In file included from kernel/trace/rv/monitors/sleep/sleep.c=
:2:
> =C2=A0=C2=A0 In file included from include/linux/ftrace.h:10:
> =C2=A0=C2=A0 In file included from include/linux/trace_recursion.h:5:
> =C2=A0=C2=A0 In file included from include/linux/interrupt.h:11:
> =C2=A0=C2=A0 In file included from include/linux/hardirq.h:11:
> =C2=A0=C2=A0 In file included from
> ./arch/riscv/include/generated/asm/hardirq.h:1:
> =C2=A0=C2=A0 In file included from include/asm-generic/hardirq.h:17:
> =C2=A0=C2=A0 In file included from include/linux/irq.h:20:
> =C2=A0=C2=A0 In file included from include/linux/io.h:12:
> =C2=A0=C2=A0 In file included from arch/riscv/include/asm/io.h:136:
> =C2=A0=C2=A0 include/asm-generic/io.h:847:2: warning: performing pointer
> arithmetic on a null pointer has undefined behavior [-Wnull-pointer-
> arithmetic]
> =C2=A0=C2=A0=C2=A0=C2=A0 847 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 outsl(addr, buffer, count);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 arch/riscv/include/asm/io.h:120:55: note: expanded from macr=
o
> 'outsl'
> =C2=A0=C2=A0=C2=A0=C2=A0 120 | #define outsl(addr, buffer, count) __outsl=
(PCI_IOBASE +
> (addr), buffer, count)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ~~~~~~~~~~ ^
> =C2=A0=C2=A0 In file included from kernel/trace/rv/monitors/sleep/sleep.c=
:2:
> =C2=A0=C2=A0 In file included from include/linux/ftrace.h:10:
> =C2=A0=C2=A0 In file included from include/linux/trace_recursion.h:5:
> =C2=A0=C2=A0 In file included from include/linux/interrupt.h:11:
> =C2=A0=C2=A0 In file included from include/linux/hardirq.h:11:
> =C2=A0=C2=A0 In file included from
> ./arch/riscv/include/generated/asm/hardirq.h:1:
> =C2=A0=C2=A0 In file included from include/asm-generic/hardirq.h:17:
> =C2=A0=C2=A0 In file included from include/linux/irq.h:20:
> =C2=A0=C2=A0 In file included from include/linux/io.h:12:
> =C2=A0=C2=A0 In file included from arch/riscv/include/asm/io.h:136:
> =C2=A0=C2=A0 include/asm-generic/io.h:1175:55: warning: performing pointe=
r
> arithmetic on a null pointer has undefined behavior [-Wnull-pointer-
> arithmetic]
> =C2=A0=C2=A0=C2=A0 1175 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return (port > MMIO_UPPER_LIMIT) ? NULL :
> PCI_IOBASE + port;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ~~~~~~~~~~ ^
> > > kernel/trace/rv/monitors/sleep/sleep.c:130:7: error: use of
> > > undeclared identifier '__NR_clock_nanosleep'
> =C2=A0=C2=A0=C2=A0=C2=A0 130 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 case __NR_clock_nanosleep:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~=
~~~
> > > kernel/trace/rv/monitors/sleep/sleep.c:141:7: error: use of
> > > undeclared identifier '__NR_futex'
> =C2=A0=C2=A0=C2=A0=C2=A0 141 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 case __NR_futex:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
> =C2=A0=C2=A0 7 warnings and 2 errors generated.
>=20
>=20
> vim +/__NR_clock_nanosleep +130
> kernel/trace/rv/monitors/sleep/sleep.c
>=20
> =C2=A0=C2=A0 120=09
> =C2=A0=C2=A0 121	static void handle_sys_enter(void *data, struct pt_regs
> *regs, long id)
> =C2=A0=C2=A0 122	{
> =C2=A0=C2=A0 123		struct ltl_monitor *mon;
> =C2=A0=C2=A0 124		unsigned long args[6];
> =C2=A0=C2=A0 125		int op, cmd;
> =C2=A0=C2=A0 126=09
> =C2=A0=C2=A0 127		mon =3D ltl_get_monitor(current);
> =C2=A0=C2=A0 128=09
> =C2=A0=C2=A0 129		switch (id) {
> =C2=A0> 130		case __NR_clock_nanosleep:
> =C2=A0=C2=A0 131	#ifdef __NR_clock_nanosleep_time64
> =C2=A0=C2=A0 132		case __NR_clock_nanosleep_time64:
> =C2=A0=C2=A0 133	#endif
> =C2=A0=C2=A0 134			syscall_get_arguments(current, regs, args);
> =C2=A0=C2=A0 135			ltl_atom_set(mon,
> LTL_NANOSLEEP_CLOCK_MONOTONIC, args[0] =3D=3D CLOCK_MONOTONIC);
> =C2=A0=C2=A0 136			ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI,
> args[0] =3D=3D CLOCK_TAI);
> =C2=A0=C2=A0 137			ltl_atom_set(mon,
> LTL_NANOSLEEP_TIMER_ABSTIME, args[1] =3D=3D TIMER_ABSTIME);
> =C2=A0=C2=A0 138			ltl_atom_update(current,
> LTL_CLOCK_NANOSLEEP, true);
> =C2=A0=C2=A0 139			break;
> =C2=A0=C2=A0 140=09
> =C2=A0> 141		case __NR_futex:
> =C2=A0=C2=A0 142	#ifdef __NR_futex_time64
> =C2=A0=C2=A0 143		case __NR_futex_time64:
> =C2=A0=C2=A0 144	#endif
> =C2=A0=C2=A0 145			syscall_get_arguments(current, regs, args);
> =C2=A0=C2=A0 146			op =3D args[1];
> =C2=A0=C2=A0 147			cmd =3D op & FUTEX_CMD_MASK;
> =C2=A0=C2=A0 148=09
> =C2=A0=C2=A0 149			switch (cmd) {
> =C2=A0=C2=A0 150			case FUTEX_LOCK_PI:
> =C2=A0=C2=A0 151			case FUTEX_LOCK_PI2:
> =C2=A0=C2=A0 152				ltl_atom_update(current,
> LTL_FUTEX_LOCK_PI, true);
> =C2=A0=C2=A0 153				break;
> =C2=A0=C2=A0 154			case FUTEX_WAIT:
> =C2=A0=C2=A0 155			case FUTEX_WAIT_BITSET:
> =C2=A0=C2=A0 156			case FUTEX_WAIT_REQUEUE_PI:
> =C2=A0=C2=A0 157				ltl_atom_update(current,
> LTL_FUTEX_WAIT, true);
> =C2=A0=C2=A0 158				break;
> =C2=A0=C2=A0 159			}
> =C2=A0=C2=A0 160			break;
> =C2=A0=C2=A0 161		}
> =C2=A0=C2=A0 162	}
> =C2=A0=C2=A0 163=09


