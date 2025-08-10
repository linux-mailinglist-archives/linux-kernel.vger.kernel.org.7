Return-Path: <linux-kernel+bounces-761374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF5B1F8F5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2C33BE454
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B992144B4;
	Sun, 10 Aug 2025 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnifWRqF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914D5B21A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811948; cv=none; b=ubOqy0u3OsHz7D998jX6qkEMb+RX2dj3DHdK1ek4ZrsYYTdTMexXq0q418MluV/WAH105nOwsv/JVkEgbRsyohFtxd6fw4FiB60XotX1xe+4tcaqrbAbEYGKVE/r4soDX2BlgwadwNxh/6IQBpQpCERTFZDE7be82bYdjCn4oyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811948; c=relaxed/simple;
	bh=koNTC0O56I+1mmS8V1RrSLAsQcHOPE+c4Prmjz5N4xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cjzqtBQdjPzt/3EB5GiCRKwOufJEXN/CC7U8lIP0grJK/qZnE1VwxUPqldbJFWJjFFcEVhNJvhSEAHFWf8AcxCI28usT5uI+J4WrUZITcGNsLIu8sN1xRRxYEsXCv4v3MEkC6yxAIdjkdHEQOck5buhcfDkcxw9vB0ttPUPemTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnifWRqF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754811945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVt0giKq01c+tkApRK/bOHrB953kwHQUrVwjxBxJkWY=;
	b=VnifWRqFivpwRrw+MrHsVHXYotK42py8wv7+KXDshpHpQGWfDO2x1osp7HfEEPgxeIdhEm
	ED3prd7zgHt9Ic32e6KB5Gyz16RivaRB2qpPiYKaXM7WM12rkM07Dd9j9rAdtsJipJB5Y4
	hGBG4AJZ2hfqC/72HhOhYRmkTAEFrBc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-uDWUvcvAO1ychBbt31xByw-1; Sun,
 10 Aug 2025 03:45:36 -0400
X-MC-Unique: uDWUvcvAO1ychBbt31xByw-1
X-Mimecast-MFC-AGG-ID: uDWUvcvAO1ychBbt31xByw_1754811934
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 509571956087;
	Sun, 10 Aug 2025 07:45:34 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.37])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6AF01800280;
	Sun, 10 Aug 2025 07:45:29 +0000 (UTC)
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
In-Reply-To: <aJe8ZW5LEtBK7Jmj@x1> (Drew Fustini's message of "Sat, 9 Aug 2025
	14:23:49 -0700")
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
	<lhuo6so7ur5.fsf@oldenburg.str.redhat.com> <aJe8ZW5LEtBK7Jmj@x1>
Date: Sun, 10 Aug 2025 09:45:45 +0200
Message-ID: <lhuqzxjy5zq.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

* Drew Fustini:

> On Sat, Aug 09, 2025 at 10:40:46AM +0200, Florian Weimer wrote:
>> * Drew Fustini:
>> 
>> > From: Drew Fustini <dfustini@tenstorrent.com>
>> >
>> > Clobbering the vector registers can significantly increase system call
>> > latency for some implementations. To mitigate this performance impact, a
>> > sysctl knob is provided that controls whether the vector state is
>> > discarded in the syscall path:
>> >
>> > /proc/sys/abi/riscv_v_vstate_discard
>> >
>> > Valid values are:
>> >
>> > 0: Vector state is not always clobbered in all syscalls
>> > 1: Mandatory clobbering of vector state in all syscalls
>> >
>> > The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
>> 
>> Can this be put into the system call number instead, or make it specific
>> to some system calls in other ways?
>
> Do you mean the control the initial state of the sysctl, or not having a
> sysctl for discard behavior at all?

It's seems rather strange to have a sysctl for such an ABI change
because it really has to be a per-process property.

>> I think C libraries can use this optimization for their system calls
>> (after adjusting the assembler clobbers) because the vector state is
>> caller-saved in the standard calling convention.  But there is backwards
>> compatibility impact for turning this on for the entire process.
>
> The focus I have right now is allowing users to avoid the delay in
> syscall entry on implementations where clobbering is slow. Palmer had
> mentioned in my v1 [1] that he has 'a patch out for GCC that enables a
> system-wide vector ABI, but I don't have time to test/benchmark it so 
> it's kind of hard to justify'. It seems like creating a new ABI where
> the vector registers are preserved across syscalls could be useful, but
> I think it would be best to handle that possiblity later on.

I'm confused.  Current glibc assumes that vector registers are preserved
across system calls because the assembler clobbers do not mention them.
Similar inline assembly probably has ended up in other projects, too.
It works by accident if glibc is compiled for a non-vector target, or if
it so happens that GCC never keeps vector registers alive across system
calls.

Thanks,
Florian


