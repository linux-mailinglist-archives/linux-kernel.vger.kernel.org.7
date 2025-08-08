Return-Path: <linux-kernel+bounces-759877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE9CB1E3D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4106618970C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAC522F77E;
	Fri,  8 Aug 2025 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+FiJUqR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49E8F6E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639480; cv=none; b=kokCRRBBBLVTI8vUL9BWq06cVK/OGVEMv+KCKmO3AAwxnaX/N+CfN19vkPNNMN9qBu4ZbDOBtzX/gxHBae8pQyJpOhW7MuDEO5xcC+kbLRPe5rKECohF7jMvxzQCGpuNeUC4I8V16pUf0xtNUiqQvyEfyfHkwWJsStB3ttF7xws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639480; c=relaxed/simple;
	bh=0QLwtbRzFV58pFlPSJRDjmlR7W/42FR+HCLIrKtftm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx3obm1qJtFtlIlZKpaz5BDwMHoIRyTTbvhKDRMg5Pyqa7eh1JfMhz5e17Qy9rYlP8RiU7ywgcdzE4Ne0sv7E7fJVcDldWFUVweBJ2yYnC1ej+kHjVHViOnoLJ5Jo9zWP1LlOP8ImENpZDovqDKHJGT934XcLyGwjzpEV7URY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+FiJUqR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754639478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NqxpoSFTAw99qFiBK7bf39dLBYitOviBnTDNGtjPZYE=;
	b=i+FiJUqRCApg1HRP6taJqap3HmdPB35UBI7qtOGR8r4af5fh8HzPxBfiYkqe9XMLkQfKb7
	yIO+RHrkW4AcvlO4AJfNiVWrRkUiQe3U7MJ2p5icWBvWcEBrZUy9z3LZ6Y1CDd5Z9Yrzj1
	8rrcBfOUmRCPvdtsexRjtvV2x+62qQY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-PBZfBMiMM92Rl-9tBR50_Q-1; Fri,
 08 Aug 2025 03:51:13 -0400
X-MC-Unique: PBZfBMiMM92Rl-9tBR50_Q-1
X-Mimecast-MFC-AGG-ID: PBZfBMiMM92Rl-9tBR50_Q_1754639470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21A3D180044F;
	Fri,  8 Aug 2025 07:51:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 589E230002C0;
	Fri,  8 Aug 2025 07:51:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  8 Aug 2025 09:49:57 +0200 (CEST)
Date: Fri, 8 Aug 2025 09:49:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Brian Gerst <brgerst@gmail.com>, Eric Biggers <ebiggers@google.com>,
	Kees Cook <kees@kernel.org>, Chao Gao <chao.gao@intel.com>,
	Fushuai Wang <wangfushuai@baidu.com>, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: Re: [PATCH v3 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
Message-ID: <20250808074948.GA29612@redhat.com>
References: <20250724013422.307954-1-sohil.mehta@intel.com>
 <20250724013422.307954-2-sohil.mehta@intel.com>
 <aJVuZZgYjEMxiUYq@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJVuZZgYjEMxiUYq@ly-workstation>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/08, Lai, Yi wrote:
>
> [   17.474769] WARNING: CPU: 1 PID: 731 at arch/x86/kernel/fpu/core.c:61 x86_task_fpu+0x76/0x90

...

> [   17.481244]  xfpregs_get+0x9c/0x1e0

...

> [   17.485304]  do_coredump+0x370e/0x5060

Damn, I was going to check the ptrace / coredump paths but didn't have
time and then forgot :/

For now, I think we need to remove PF_USER_WORKER from x86_task_fpu().
Then, we add it back later.

It is not clear what should we do if debugger does xfpregs_set()...

Oleg.


