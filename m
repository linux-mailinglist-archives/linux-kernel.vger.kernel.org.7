Return-Path: <linux-kernel+bounces-818153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CBFB58DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01191BC27FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8424338F;
	Tue, 16 Sep 2025 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+6hFHzD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6B22615
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998618; cv=none; b=DYpksF+g/ASJyDZNIqKR1CAmGHY/yo8CADWQ69STl7fU4uAglwSZPX/fIHe2ROzNNqxEoQfTCLO2almuRTUQx/wul8JirQ9sbOxYa6NX4ezBuGhNeOAOYy8OTZ54geXpm6AMcoh1CBTuW+PRnHbkgOeqdlXx9z2UFmTbX+giFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998618; c=relaxed/simple;
	bh=qcmb/u0/h7fVujYCrvk2eC9JZFnU0rmO/ckEWLGqQJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ujzmj5bhs08BnxYfRrup7MWBCL7Bcxqcd+p0OVarBPMa2SYfS4/DsLNn/A4BxiW+7c5XXacl9gDi/D/v4/5Js+XgSDewHFxrY2mf3lvQD30U5C0AvQM+jvuETi8SKa329ezleoTFhM42bg1OV8JejgxztdgE/IwCyIyYG0JPqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+6hFHzD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757998617; x=1789534617;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qcmb/u0/h7fVujYCrvk2eC9JZFnU0rmO/ckEWLGqQJ8=;
  b=L+6hFHzDfoXyV8nvd1I5nnxYr5Uny8x96c+TLYQynzNTX/YPlqGKlCeC
   VVGHxcyCx8RolKCUCJpHauIGuNDjjlH+MXXeCB6+zmOOnFIMw72RXO//5
   ZX+Ic5x+XC2EMV8h/go1iocb0XlmzxXawP8VoOsPtUaR+aJi8rI6yMt6L
   X3gRkNKP0m39+Tpq/hrvPeP9mUPmQkeTPoBeQp2PSZDZmfcyMmL8ws+Rh
   GZ8NfWLB8RTwMNzZSQa2xrnThmhORTHF/NS731v07mMXiF3cDaPANWSeM
   FDyEkCqaYmMQD486x5SFYiT23H4+tvYbPQ/OA2rfpn3KFdulkJdGgNzD2
   g==;
X-CSE-ConnectionGUID: VrPVaUNPRr6IvY8O7fBCGA==
X-CSE-MsgGUID: bYnyzYVkRdavB6Ow92TLtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59489703"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="59489703"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 21:56:56 -0700
X-CSE-ConnectionGUID: XOjfK0zWQ7yE45Vk36v+DQ==
X-CSE-MsgGUID: fSrB5XgfTO+stsFpw+NbWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="174382420"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 21:56:55 -0700
Message-ID: <3205569f-2870-40ab-bcc8-c99639e501ae@linux.intel.com>
Date: Tue, 16 Sep 2025 12:54:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: debugfs: fix legacy mode page table dump
 logic
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250814163026.634182-1-vineeth@bitbyteword.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250814163026.634182-1-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 00:30, Vineeth Pillai (Google) wrote:
> In legacy mode, SSPTPTR is ignored if TT is not 00b or 01b. SSPTPTR
> maybe uninitialized or zero in that case and may cause oops like:
> 
>   Oops: general protection fault, probably for non-canonical address 0xf00087d3f000f000: 0000 [#1] SMP NOPTI
>   CPU: 2 UID: 0 PID: 786 Comm: cat Not tainted 6.16.0 #191 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
>   RIP: 0010:pgtable_walk_level+0x98/0x150
>   RSP: 0018:ffffc90000f279c0 EFLAGS: 00010206
>   RAX: 0000000040000000 RBX: ffffc90000f27ab0 RCX: 000000000000001e
>   RDX: 0000000000000003 RSI: f00087d3f000f000 RDI: f00087d3f0010000
>   RBP: ffffc90000f27a00 R08: ffffc90000f27a98 R09: 0000000000000002
>   R10: 0000000000000000 R11: 0000000000000000 R12: f00087d3f000f000
>   R13: 0000000000000000 R14: 0000000040000000 R15: ffffc90000f27a98
>   FS:  0000764566dcb740(0000)GS:ffff8881f812c000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000764566d44000 CR3: 0000000109d81003 CR4: 0000000000772ef0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    pgtable_walk_level+0x88/0x150
>    domain_translation_struct_show.isra.0+0x2d9/0x300
>    dev_domain_translation_struct_show+0x20/0x40
>    seq_read_iter+0x12d/0x490
> ...
> 
> Avoid walking the page table if TT is not 00b or 01b.
> 
> Signed-off-by: Vineeth Pillai (Google)<vineeth@bitbyteword.org>
> ---
>   drivers/iommu/intel/debugfs.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)

Add the fixes tag and queue it for v6.18.

Thanks,
baolu

