Return-Path: <linux-kernel+bounces-780950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B95B30B85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352D83BB382
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AEA1DB12E;
	Fri, 22 Aug 2025 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tarsnap.com header.i=@tarsnap.com header.b="Xfv2LuGQ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Cw1f21dR"
Received: from a8-13.smtp-out.amazonses.com (a8-13.smtp-out.amazonses.com [54.240.8.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA111A9F9B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827850; cv=none; b=acDX1oFA/9zsQQ85RcLaCRsywU9kfZEUksLakrwfD9K+UORDwq8eGMF+GY8tRd7hN5DIu6kT+o/SsYxHFJNHwopqimQydn33TXjuxfr8UjI+ePSNDAna8329d03TP5tZv10RzRTQIsJxRzWCmPZ2rSVW4E+EK2gRGJDyiP+wHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827850; c=relaxed/simple;
	bh=rcREoXze/O2IhJBABpClvHm2RJLvQexLiYrJs+z2dQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFDoJDUCS/B3ygJf26gkx4YsSKyp4f8JOZKwPW4fAyF+/p2KjUWOrLFpqR4zFB8oJRd1wm5r20RcVk+CeeTFb07KS+h6Lco1lriTzoMzOz/At0D5GJgj2fZiHOyUCit3XYA+RvRmQnspoueg7VuxQuKDC3DNzjjF2Zk1Q/EuaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tarsnap.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=tarsnap.com header.i=@tarsnap.com header.b=Xfv2LuGQ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Cw1f21dR; arc=none smtp.client-ip=54.240.8.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tarsnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=vnqrkfnvu6csdl6mwgk5t6ix3nnepx57; d=tarsnap.com; t=1755827847;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rcREoXze/O2IhJBABpClvHm2RJLvQexLiYrJs+z2dQA=;
	b=Xfv2LuGQSRbpdcnGcKo5xBeMLz2G6U6lV9QxAWd1xJ8bxOBcu89UhjnK/oDNCOa9
	XJKcHT10GAYQ1TTc384GCPO8AA1MZCwQ29qRFTeNLKpG/NCo/96yQDHeTFwHIcgYWdk
	2z2CgSkXkNaUObC3JJ3fJveEhV7tgNvHuhFHvkUo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1755827847;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=rcREoXze/O2IhJBABpClvHm2RJLvQexLiYrJs+z2dQA=;
	b=Cw1f21dRmiJvbYUkwTIGLHkGS687GyEPjfq9W7Z1YwauzLHrWrGVMNWZIzu1ybls
	HlD1OsGgHygjr4iqkuZgYDj2Qnx2dCu0LFCHV/ukDQFVuLd0qcjYyUZCFyQ4D0CmqfL
	RbT0OdN7fjcO8sn5ipJj6HeI0t7JJ5pND3wEvxT8=
Message-ID: <01000198cf7ec03e-dfc78632-42ee-480b-8b51-3446fbb555d1-000000@email.amazonses.com>
Date: Fri, 22 Aug 2025 01:57:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Support "generic" CPUID timing leaf as KVM guest
 and host
To: David Woodhouse <dwmw2@infradead.org>, 
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, graf@amazon.de, 
	Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>
References: <20250816101308.2594298-1-dwmw2@infradead.org>
 <aKdIvHOKCQ14JlbM@google.com>
 <933dc95ead067cf1b362f7b8c3ce9a72e31658d2.camel@infradead.org>
 <aKdzH2b8ShTVeWhx@google.com>
 <6783241f1bfadad8429f66c82a2f8810a74285a0.camel@infradead.org>
 <aKeGBkv6ZjwM6V9T@google.com>
 <fdcc635f13ddf5c6c2ce3d5376965c81ce4c1b70.camel@infradead.org>
Content-Language: en-US
From: Colin Percival <cperciva@tarsnap.com>
Autocrypt: addr=cperciva@tarsnap.com; keydata=
 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
In-Reply-To: <fdcc635f13ddf5c6c2ce3d5376965c81ce4c1b70.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.Lv9FVjaNvvR5llaqfLoOVbo2VxOELl7cjN0AOyXnPlk=:AmazonSES
X-SES-Outgoing: 2025.08.22-54.240.8.13

On 8/21/25 14:10, David Woodhouse wrote:
> On Thu, 2025-08-21 at 13:48 -0700, Sean Christopherson wrote:
>>> I think I'm a lot happier with the explicit CPUID leaf exposed by the
>>> hypervisor.
>>
>> Why?  If the hypervisor is ultimately the one defining the state, why does it
>> matter which CPUID leaf its in?
> [...]
> 
> If you tell me that 0x15 is *never* wrong when seen by a KVM guest, and
> that it's OK to extend the hardware CPUID support up to 0x15 even on
> older CPUs and there'll never be any adverse consequences from weird
> assumptions in guest operating systems if we do the latter... well, for
> a start, I won't believe you. And even if I do, I won't think it's
> worth the risk. Just use a hypervisor leaf :)

FreeBSD developer here.  I'm with David on this, we'll consult the 0x15/0x16
CPUID leaves if we don't have anything better, but I'm not going to trust
those nearly as much as the 0x40000010 leaf.

Also, the 0x40000010 leaf provides the lapic frequency, which AFAIK is not
exposed in any other way.

-- 
Colin Percival
FreeBSD Release Engineering Lead & EC2 platform maintainer
Founder, Tarsnap | www.tarsnap.com | Online backups for the truly paranoid


