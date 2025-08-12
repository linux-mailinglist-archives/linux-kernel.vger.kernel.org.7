Return-Path: <linux-kernel+bounces-764230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A61ACB2202D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CE0504F49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761C2E03E8;
	Tue, 12 Aug 2025 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYv3BjJp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F922DE6F7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985803; cv=none; b=RZkrvS4gLm3c656bVd4Jz681RiRuamyl3RaSk2CwgMn0qJzosYVBvrfujubNQihpKTmPLBshfdZUSrDObA8jc39fqV7/K9rgqEduzPFOtVOaq4IqJxRAflYlriaHN1t6mJDH3gKr1fAQZJDLUIANMG/5Rgz6zs9HUzhH01ttbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985803; c=relaxed/simple;
	bh=LUta36O8tyb9I3juJj/3J8ZXHJlT2V/rHRSAu5LOqgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PtvAdYMTYvrKPDEl2pbPTMrFixVmRvmTsGVkc33cin+Gg9MfmlUFKhfk73PqGuXMbV/0s8tdxXEuGPLuAQ2MF6k4WVsjB86e+rKqiv9tdeRjSbq/bVgBNt5g7UMNWL5OPmPVhlSaa/DFDHmmx/O7RZPliTRO2Ass9fmdYY99SCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYv3BjJp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754985800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPD2NvE044yYaRiCB49zIx8of/z3CQOyIqI9hVU1DHo=;
	b=QYv3BjJpQZxyNtGiH3pFCktF8FmcjimoZr3j5YCSwkoUv9T77ZBQMKBoZDZCzdWEgct6mK
	w0JSLU5tNvb7+IvN0tUaq5CZlsRCKFCPW5DwHWklsVaGNUWtWuYrKo+5ZBjSAZ4INd7WBT
	oLRNe8K5PcO6Ba5lvYpVPRKVVmrtsZ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-seZebHSoN5OZopFtpsAsRQ-1; Tue,
 12 Aug 2025 04:03:14 -0400
X-MC-Unique: seZebHSoN5OZopFtpsAsRQ-1
X-Mimecast-MFC-AGG-ID: seZebHSoN5OZopFtpsAsRQ_1754985793
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83DD31800340;
	Tue, 12 Aug 2025 08:03:12 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE4B61800280;
	Tue, 12 Aug 2025 08:03:08 +0000 (UTC)
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
In-Reply-To: <aJpUWnYEL18dk4aC@x1> (Drew Fustini's message of "Mon, 11 Aug
	2025 13:36:42 -0700")
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
	<lhuo6so7ur5.fsf@oldenburg.str.redhat.com> <aJe8ZW5LEtBK7Jmj@x1>
	<lhuqzxjy5zq.fsf@oldenburg.str.redhat.com> <aJpUWnYEL18dk4aC@x1>
Date: Tue, 12 Aug 2025 10:03:05 +0200
Message-ID: <lhua545dl1i.fsf@oldenburg.str.redhat.com>
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

>> I'm confused.  Current glibc assumes that vector registers are preserved
>> across system calls because the assembler clobbers do not mention them.
>> Similar inline assembly probably has ended up in other projects, too.
>> It works by accident if glibc is compiled for a non-vector target, or if
>> it so happens that GCC never keeps vector registers alive across system
>> calls.
>
> I wasn't trying to make any ABI changes with this sysctl patch. The
> riscv kernel documentation states vector state is not preserved across
> syscalls. I am not trying to change that policy.

Oh, then glibc is just buggy in this area.  I had no idea.  If the
vector state is already clobbered, than the sysctl for experimentation
is fine.

Thanks,
Florian


