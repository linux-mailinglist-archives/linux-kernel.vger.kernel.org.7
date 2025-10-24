Return-Path: <linux-kernel+bounces-868928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B5C06851
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80553ABD7A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AEB31D368;
	Fri, 24 Oct 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mPfNsIzf"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC928643A;
	Fri, 24 Oct 2025 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312690; cv=none; b=FTY4b6HBuHZ8WRO+7hbQqgUUt6qKb8hdgOJhR5YchAj7j+fnw1sfe1A5wRhyihNxMQfdOM/FBQExOiS5Ci6R2uyR7b3rdVayhvgPDPFSEpOF5WE+4zsEXIZ6e6iybvd0OSp0t8n8wbdX0uGJfyVV9OsUo7ed1TGAh1S+RNIVhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312690; c=relaxed/simple;
	bh=u39F8WLNvyq44vB4xSRWGu/rMtKru1JoTVTHXDxB/aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edHSvGtccnVnnK2rkIfiK+tUyoa6iwHeBuJpZM8wmR6PUS+ZLlX7kevjd/aUguM75Asm2eI5TMVYiPfVuvz5fB8hoVNG+qusC4RXRimUiWrATvHVvorTnx0aqPgaWRohJn0zAN+yVg1OK8G+wYy9PCOUznGIShiewDMmrvgX9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mPfNsIzf; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761312684; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=u39F8WLNvyq44vB4xSRWGu/rMtKru1JoTVTHXDxB/aY=;
	b=mPfNsIzfDBS2qlU1hdlKQOp3NCGO9o8foPr2sVMKkKbB8NpJyXAfMhooPkfHIFAtks95S2sQ5HLdodZEoJGbGPIebG8F5ID5H9xM+jdBVdu0ifzwu3q5KlVEtGkAIplipU1y/d7TjidOHwva7i8ZUSSNuq86ZzeOL+vALcuGMOk=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WquOQXL_1761312681 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 21:31:22 +0800
From: fangyu.yu@linux.alibaba.com
To: anup@brainfault.org
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	jiangyifei@huawei.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	pjw@kernel.org
Subject: Re: Re: [PATCH] RISC-V: KVM: Remove automatic I/O mapping for VM_PFNMAP 
Date: Fri, 24 Oct 2025 21:31:16 +0800
Message-Id: <20251024133116.73803-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAAhSdy1fCCdciZLqmoeWDG_QoOHDi9j0_ZZKYkpGJmWrf14Q-g@mail.gmail.com>
References: <CAAhSdy1fCCdciZLqmoeWDG_QoOHDi9j0_ZZKYkpGJmWrf14Q-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> As of commit aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()"),
>> vm_pgoff may no longer guaranteed to hold the PFN for VM_PFNMAP
>> regions. Using vma->vm_pgoff to derive the HPA here may therefore
>> produce incorrect mappings.
>>
>> Instead, I/O mappings for such regions can be established on-demand
>> during g-stage page faults, making the upfront ioremap in this path
>> is unnecessary.
>>
>> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
>LGTM.
>
>Queued it as fix for Linux-6.18
>
>Reviewed-by: Anup Patel <anup@brainfault.org>
>
>Thanks,
>Anup
>

Hi Anup:

Thanks for the review.

Please note that this patch has two build warnings, and I have fixed
on patch V2:
https://lore.kernel.org/linux-riscv/20251021142131.78796-1-fangyu.yu@linux.alibaba.com/

Thanks,
Fangyu

