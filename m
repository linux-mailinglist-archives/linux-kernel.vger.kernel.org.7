Return-Path: <linux-kernel+bounces-745137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A372B11584
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401DA4E00C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D26170826;
	Fri, 25 Jul 2025 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="do15tEY2"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531928371
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753405310; cv=none; b=UhWfOBrzT2+cYBZJTnV5cHqkzbJXjha/qSZAmsosmiIkk1mYeO5fPCjeaU6RuO4ykZLLPniY3T+oX2XqkqLbNW9RVBo56Uk6urg/dmojBY7zHdyvsS7KYlhEZLQq5RsA/7ljPo14cWoqn0qBhnIKAZ50gXDoxzz/cK8jWzRGW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753405310; c=relaxed/simple;
	bh=Lj1tjZBNqFFzwz6u2tgGTGGuOTZuyxTymK8SfKpxTRk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XX3WmsUL8VkpMSz6TSLPrq669h0K25FtZL6cKZVzZc/RPB9zuIXJilngao5jksWx+5BAUppKK1jtRnuIj1m+3V8nQcmOuJCfI9WvxYpKiZw+98DfyFyRWWGD+6A2mTcfALvdVr2lYU/pX4wKukGHmUQViy2HXTf1oOEsVg58rOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=do15tEY2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56P10wOS2150764
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 24 Jul 2025 18:00:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56P10wOS2150764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753405260;
	bh=4oodD+wEQKMeev7vAb+ZWX0JvocKU457D9gUtWAFs4Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=do15tEY28LH3Jok3ztMh5O+B/s18djzq87UPlv0qVV/uHvTw2Xva6N9iyIRjdU8S1
	 cibHLg3kE46hAkiCmLIYCQprHI8CcPWFWn39aeAUjb6yw7nycTXgpSWvxhkVGTqEGd
	 0yBAsvHM3PQj7YHn9rAR6y1hh1iSOb7A6BRoR1d5HcVtOrnzkrmXqUlTr0gMlLUZu+
	 luQLzQh6lj9DOYiJx6BrkZuaeiOmgf3fqCh1kqIDU30OKtt/LcS6KoDszgkXRRe87q
	 YmEoG7KXoYKSEPXRoVKzKpTYyMlbfaVOMFXL21oxe3WLUqBTM2+RIe6I7bG8+K0d8D
	 UrEefFsALr8cw==
Date: Thu, 24 Jul 2025 18:00:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Oleg Nesterov <oleg@redhat.com>,
        David Laight <david.laight.linux@gmail.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Li,Rongqing" <lirongqing@baidu.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
User-Agent: K-9 Mail for Android
In-Reply-To: <20250724111426.GA15444@redhat.com>
References: <20250721130422.GA31640@redhat.com> <20250721192053.58843751@pumpkin> <20250722105034.GA2845@redhat.com> <20250722130947.0c97c96a@pumpkin> <20250722132147.GB2845@redhat.com> <20250722230341.5a1cc5e5@pumpkin> <20250723093825.GA12884@redhat.com> <20250723224831.4492ec75@pumpkin> <20250724081125.GA10980@redhat.com> <20250724082547.GB10980@redhat.com> <20250724111426.GA15444@redhat.com>
Message-ID: <1225B7DD-BF29-4091-A956-FC312679E9BE@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 24, 2025 4:14:26 AM PDT, Oleg Nesterov <oleg@redhat=2Ecom> wrote:
>Finally=2E If we really want to optimize this function as much as possibl=
e,
>we can add the CONFIG_CC_HAS_ASM_GOTO_OUTPUT version as Peter suggests=2E
>I guess this should work:
>
>	u64 test(u64 a, u64 mul, u64 div)
>	{
>		u64 q;
>
>		asm goto ("mulq %2; 1: divq %3\n"
>			_ASM_EXTABLE(1b, %l[fail])
>			: "=3Da" (q)
>			: "a" (a), "rm" (mul), "rm" (div)
>			: "rdx"
>			: fail);
>
>		return q;
>	fail:
>		// BUG? WARN?
>		return -1ul;
>	}
>
>I agree with everything ;)
>
>Oleg=2E
>
>On 07/24, Oleg Nesterov wrote:
>>
>> On 07/24, Oleg Nesterov wrote:
>> > On 07/23, David Laight wrote:
>> > >
>> > > On Wed, 23 Jul 2025 11:38:25 +0200
>> > > Oleg Nesterov <oleg@redhat=2Ecom> wrote:
>> > > >
>> > > > to remove the conditional branch and additional variable=2E Your =
version
>> > > > is probably beterr=2E=2E=2E But this is without WARN/BUG=2E
>> > >
>> > > I wish there was a way of doing a WARN_ONCE from asm with a single =
instruction=2E
>> > > Then you could put one after your 2:
>> > > Otherwise is it a conditional and a load of inlined code=2E
>> > >
>> > > > So, which version do you prefer?
>> > >
>> > > I wish I knew :-)
>> >
>> > ;-)
>> >
>> > David, you understand this asm magic indefinitely better than me=2E P=
lus you are
>> > working on the generic code=2E Can you send the patch which looks rig=
ht to you?
>> > I agree in advance with anything you do=2E
>> >
>> > I got lost=2E Now I don't even understand if we want to add BUG and/o=
r WARN into
>> > mul_u64_u64_div_u64()=2E
>>
>> Forgot to mention=2E=2E=2E Not that I think this is a good idea, but if=
 we don't
>> use BUG/WARN, we can probably add EX_FLAG_ and do something like below=
=2E
>>
>> Oleg=2E
>>
>> --- a/arch/x86/mm/extable=2Ec
>> +++ b/arch/x86/mm/extable=2Ec
>> @@ -38,6 +38,9 @@ static bool ex_handler_default(const struct exception=
_table_entry *e,
>>  	if (e->data & EX_FLAG_CLEAR_DX)
>>  		regs->dx =3D 0;
>>
>> +	if (e->data & EX_FLAG_XXX_AX)
>> +		regs->ax =3D -1ul;
>> +
>>  	regs->ip =3D ex_fixup_addr(e);
>>  	return true;
>>  }
>

Seems good to me=2E

