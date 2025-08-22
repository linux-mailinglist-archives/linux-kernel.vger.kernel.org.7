Return-Path: <linux-kernel+bounces-782758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA4B324E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F8AAC5BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C827E076;
	Fri, 22 Aug 2025 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DrqJdFUz"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7620322
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755900841; cv=none; b=EtJzf4zNnhtJXZcCtiftgjClS4tNtd0u+lJ3Zk30ncrOSSnrhHp0ptkOQoodca4kGB13KE2owh/X1baayxFy3z5FU/2M9wIcnm/n2tz/hog764SS2qbOeLGt9rAIUU+rTZn0fFsUKl624o1TP43JF+7zUIsLDpoe3fIV3XIAsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755900841; c=relaxed/simple;
	bh=GNoFskWN/XDsfbpOZ4rbYH7UgxZKXCrEqCuXK6N6GQc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MQxJhU5oSYeCWYftU9TRhf6CT4pTifYytup6831GistRUgUEwpVLOWVTrND5dTTJTTUtV7sYmUZiBtVDfBgqvdkaP0QGEVfb47XrFzEDVxogYqIWuq4Py+F4+VlYMXOPwJ9oRwgoNXFmce8vWa0lFBYDPZQdJJUETO5b8AV8glQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DrqJdFUz; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.59.163.242])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57MMD9gY2134849
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 22 Aug 2025 15:13:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57MMD9gY2134849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755900792;
	bh=l63OcdEGqYfRVzBx6EEgt5utd/dvSEkRemwDqryJ+Fo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DrqJdFUzM8zggpn1PEgISYbBKktjC6P8VkzK2u/u72oclbd0oOUJTR8tPemHHgV0e
	 067Od9VXlTXe6x/M32uQT/afRXhGv/waX1+N2iliJTVMMGPzazVxNPRGwH0wz6gWlr
	 +DbB8R8OLC+Llk3RpATF2KKvCNHx8uRK9QbIyd7N+fBxifdMTPoJ21Pdsb56SNk4KF
	 Yb2SZlU5UXt8OILZDiWszKbTd6tZgQPyXrcAfDHHPf/u1NdmUZQo8l8/tVEkvExh2R
	 SkT+paj73CikFmBEVti1St6FjUpgdAMCF7hCsiVjFIiqTxrzgFAW17FGphE5xLuHy9
	 ezzJ1TmbpM3QQ==
Date: Fri, 22 Aug 2025 15:12:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Marcos Del Sol Vives <marcos@orca.pet>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Brian Gerst <brgerst@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, David Kaplan <david.kaplan@amd.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>, Kees Cook <kees@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
        Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
User-Agent: K-9 Mail for Android
In-Reply-To: <20250821124804.GP3289052@noisy.programming.kicks-ass.net>
References: <20250820013452.495481-1-marcos@orca.pet> <20250821124804.GP3289052@noisy.programming.kicks-ass.net>
Message-ID: <C187B3AC-2582-4B07-8735-7F11B887F008@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 21, 2025 5:48:04 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> =
wrote:
>On Wed, Aug 20, 2025 at 03:34:46AM +0200, Marcos Del Sol Vives wrote:
>> +static bool handle_hnop(struct pt_regs *regs)
>> +{
>> +	struct thread_struct *t =3D &current->thread;
>> +	unsigned char buf[MAX_INSN_SIZE];
>> +	unsigned long nr_copied;
>> +	struct insn insn;
>> +
>> +	nr_copied =3D insn_fetch_from_user(regs, buf);
>> +	if (nr_copied <=3D 0)
>> +		return false;
>> +
>> +	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
>> +		return false;
>> +
>> +	/* Hintable NOPs cover 0F 18 to 0F 1F */
>> +	if (insn=2Eopcode=2Ebytes[0] !=3D 0x0F ||
>> +		insn=2Eopcode=2Ebytes[1] < 0x18 || insn=2Eopcode=2Ebytes[1] > 0x1F)
>> +		return false;
>
>FWIW, you need to check for insn=2Eopcode=2Enbytes =3D=3D 2=2E
>
>> +	if (!t->hnop_warn) {
>> +		pr_warn_ratelimited("%s[%d] emulating hintable NOP, ip:%lx\n",
>> +		       current->comm, task_pid_nr(current), regs->ip);
>> +		t->hnop_warn =3D 1;
>> +	}
>> +
>> +	regs->ip +=3D insn=2Elength;
>> +	return true;
>> +}

No, hintable noops apply to any modr/m=2E

