Return-Path: <linux-kernel+bounces-761034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343DDB1F373
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C983A638B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0C279789;
	Sat,  9 Aug 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrtSSNbh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554B1CA81
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728849; cv=none; b=YcZucS3UnAtBqBrkjKiCiiIpmQZiSGav0AOhGI34BClIksOFwtpYgUN716WNsB0U6eKDrj5r4XdXuADsc8TEfwGiS7lcLqokHl+0g1tQIyJXNSB9qLiIUXB9pIRE8C3DhfoB7l4sABUPBygcVdL8UFTxkAtegokBZYXgW8GxPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728849; c=relaxed/simple;
	bh=ZXORB9ZbProX3noVEjoq8Vm2DEk3d4HIwB9K63OLIPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PBhMT1VAuA111kIhoGth7GckC2wwaH+ctBAMOZ5wMo5Q25TbUxfOP5OI0ZSOR2/EZprlSi9NyJdrOyQDffhaVzB4tRDwPrtQEJecy4ODKvt5Mt4eT9m4YsOCrPKqdJacIw6hnQ2iUWEPazitczgAPFgrpaPzvR1YSUhG0iyjtcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrtSSNbh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754728846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z+vP3eh5eUjP7Lq+gTWgW1fmf2ENVDRoJb0qh1Cws54=;
	b=LrtSSNbhdjVqPDJqEs6xsxPEUxPS9TxYb9Gb/q8QXdfeDAClpqrF7sT9icBvDr7s19U7bu
	HRUj5XImM3T4TxGG4yBxcplM7gT2iNXp5jX+j42B9m3rFmh+tZ5DXQ1YHD1rFN/GQp6B89
	CI94T6J76cwXSHZZNOYZfTdQnAxekjk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-cCaGX3YIMmO3w5FJf_xLRA-1; Sat,
 09 Aug 2025 04:40:36 -0400
X-MC-Unique: cCaGX3YIMmO3w5FJf_xLRA-1
X-Mimecast-MFC-AGG-ID: cCaGX3YIMmO3w5FJf_xLRA_1754728834
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 330E4180048E;
	Sat,  9 Aug 2025 08:40:34 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E76E919560AD;
	Sat,  9 Aug 2025 08:40:29 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alexandre Ghiti <alex@ghiti.fr>,  Samuel Holland
 <samuel.holland@sifive.com>,  =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,  Andy Chiu
 <andybnac@gmail.com>,  Conor Dooley <conor.dooley@microchip.com>,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,  Drew
 Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH v2] riscv: Add sysctl to control discard of vstate
 during syscall
In-Reply-To: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
	(Drew Fustini's message of "Wed, 06 Aug 2025 07:03:28 -0700")
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
Date: Sat, 09 Aug 2025 10:40:46 +0200
Message-ID: <lhuo6so7ur5.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Drew Fustini:

> From: Drew Fustini <dfustini@tenstorrent.com>
>
> Clobbering the vector registers can significantly increase system call
> latency for some implementations. To mitigate this performance impact, a
> sysctl knob is provided that controls whether the vector state is
> discarded in the syscall path:
>
> /proc/sys/abi/riscv_v_vstate_discard
>
> Valid values are:
>
> 0: Vector state is not always clobbered in all syscalls
> 1: Mandatory clobbering of vector state in all syscalls
>
> The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.

Can this be put into the system call number instead, or make it specific
to some system calls in other ways?

I think C libraries can use this optimization for their system calls
(after adjusting the assembler clobbers) because the vector state is
caller-saved in the standard calling convention.  But there is backwards
compatibility impact for turning this on for the entire process.

Thanks,
Florian


