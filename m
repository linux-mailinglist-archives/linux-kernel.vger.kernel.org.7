Return-Path: <linux-kernel+bounces-761177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC75B1F557
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C063189E8AD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B32BE64C;
	Sat,  9 Aug 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4biu8Mu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FC190692
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754755502; cv=none; b=GCe1s6ZFpZd/YtPimEZgkAMusUBI+9E0B4D3SOfdSVsRLJtQXdFgaVNJhnDJETP1QrdDiBxjPKaumI7LWR2MXJpKb9S67wHMf3ECaURU+iirIyl7gfSmNyRyq5yJ7gj3MnqeyeHI+hLD1ObBzps0jFaaNycChZuRH6blGmueFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754755502; c=relaxed/simple;
	bh=hhKEkRqaprHI0rrxGfYnmGdOsHQcafkZ2chs4N9ElJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C051QDYAYDJH7lkqLciTPOd971qUx/XvfYJoayMh6W/VwBBrejQUM5kkMPS7GvMbSG6nW38Lw4cE5FRhNQYAQP46/d4YlRbGSOHpNjo+7buOPID+5mEeEqBRHa46+H68ws3X69xHRf1w6wGtrz+MDZ3rSC/yzKdAjdOcfwMWE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4biu8Mu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754755499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxzZXZ9khqyL8fNdwVgMsrfFG2YXiwPF3nzkdXzjMeA=;
	b=P4biu8MukGfFoZSZgstxESw7y4GObMn2UyVAG/AtcNsH7Q7VSNCsiCyQba4a3xUmmw8cUa
	mVfKIUX+QM7fqZs26UmDtqTjGPkzb+X5IkQ4Pv9wE0ayBE+iH0s1rYvlIwdiwNIEG+bZs5
	79VoahUD20ZDmD5TK8v5R3iAZPiP130=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-r5sfhV_oOkaQbFtmHfxCUw-1; Sat,
 09 Aug 2025 12:04:54 -0400
X-MC-Unique: r5sfhV_oOkaQbFtmHfxCUw-1
X-Mimecast-MFC-AGG-ID: r5sfhV_oOkaQbFtmHfxCUw_1754755491
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C11ED1800451;
	Sat,  9 Aug 2025 16:04:50 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62BC53001455;
	Sat,  9 Aug 2025 16:04:43 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,  Andy Lutomirski
 <luto@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,
  x86@kernel.org,  Kostya Serebryany <kcc@google.com>,  Andrey Ryabinin
 <ryabinin.a.a@gmail.com>,  Andrey Konovalov <andreyknvl@gmail.com>,
  Alexander Potapenko <glider@google.com>,  Taras Madan
 <tarasmadan@google.com>,  Dmitry Vyukov <dvyukov@google.com>,  "H . J .
 Lu" <hjl.tools@gmail.com>,  Andi Kleen <ak@linux.intel.com>,  Rick
 Edgecombe <rick.p.edgecombe@intel.com>,  Bharata B Rao <bharata@amd.com>,
  Jacob Pan <jacob.jun.pan@linux.intel.com>,  Ashok Raj
 <ashok.raj@intel.com>,  Linus Torvalds <torvalds@linux-foundation.org>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Weihong Zhang
 <weihong.zhang@intel.com>
Subject: Re: [PATCHv16 13/17] selftests/x86/lam: Add mmap and SYSCALL test
 cases for linear-address masking
In-Reply-To: <20230312112612.31869-14-kirill.shutemov@linux.intel.com> (Kirill
	A. Shutemov's message of "Sun, 12 Mar 2023 14:26:08 +0300")
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
	<20230312112612.31869-14-kirill.shutemov@linux.intel.com>
Date: Sat, 09 Aug 2025 18:04:58 +0200
Message-ID: <lhupld4zdjp.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Kirill A. Shutemov:

> From: Weihong Zhang <weihong.zhang@intel.com>
>
> Add mmap and SYSCALL test cases.
>
> SYSCALL test cases:
>
>  - LAM supports set metadata in high bits 62:57 (LAM_U57) of a user
>    pointer, pass the pointer to SYSCALL, SYSCALL can dereference the
>    pointer and return correct result.

Is this test expected to pass?

I've tried to compile the Fedora kernel (6.15.9-201.fc42) with address
masking and LAM enabled, and while basic LAM support is there (the CPU
ignores the metadata bits after the arch_prctl system call), it's not
valid to use addresses with metadata in system calls:

$ ./lam_64 -t 8
not ok 1 SYSCALL: LAM_U57. syscall with metadata
ok 2 SYSCALL:[Negative] Disable LAM. Dereferencing pointer with metadata.
not ok 3 GET_USER: get_user() and pass a properly tagged user pointer.
ok 4 GET_USER:[Negative] get_user() with a kernel pointer and the top bit cleared.
ok 5 GET_USER:[Negative] get_user() with a kernel pointer and the bottom sign-extension bit cleared.
ok 6 GET_USER:[Negative] get_user() and pass a kernel pointer.
1..6
# Totals: pass:4 fail:2 xfail:0 xpass:0 skip:0 error:0

This also happens outside the test, where write (for example) returns
EFAULT if passed an address with metadata.

Thanks,
Florian


