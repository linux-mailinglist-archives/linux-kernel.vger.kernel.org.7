Return-Path: <linux-kernel+bounces-862070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99113BF45C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10D4F4E7A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A200F274B40;
	Tue, 21 Oct 2025 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ChOXSPjO"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5E635
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012871; cv=none; b=Z6TO00fdiYmPSeOKkPOg4U9fmXUZMZocu589XLZWeFrEa5EfJvroYeJ3qjEgs6nRfvw9hp+T0K+iSF0iHwSXpMw8V2gfBm9HbytD20pKJc0AdDghysDfNLUr1LENk772UYp0CRnklq7/mOqPFeq4rdCGyy7LrY1eqZxJ3aQedBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012871; c=relaxed/simple;
	bh=D8WUJOgfFh0MNzP4WNZx44ugWVJNXmQNE5Zi2VnNL7o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EJ1eCp6Vc5be7xz9MTw4VqKdkTEVUFrsrVZ+yGb3eQRCHZcPqpI7S54iyCawmplyPfL94rMYfrT/87uOhTpl+KfvIokviEDdV9LH7GFJsijsZGIEfsyW+sb6PEhxLjErTMCGQFU9h0i9xaODhAmtR4++kCom5dJwTnf6Gt5stW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ChOXSPjO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59L2DEQ21371787
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 20 Oct 2025 19:13:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59L2DEQ21371787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1761012796;
	bh=4NhP6V16rVSfhMCCeaBefL0RLve1rWHFqHANLRDxBxU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ChOXSPjOWKpcLOMdsc72yFF+1LJa3R7GIbatsCesF1givEAVQYj7xazxvlsxMdK1S
	 3oFMNXJ/YHKI4Is7DTUGUUvSefHd81aFI7BdxRNYyzohuKMqthYhYaW2LzjodSlczh
	 Gg7SBywaNcUgh3tDEMakHx+3y7uW+yh6dLPevSYYBOhzZK8XuASVWuSks7INPcyCb+
	 tO2m4A1o+IxH9FgsVpeII14waGNRwXMhlDXatesoxGQ8dDfEQQ8dGh3GcCxWLJpt9h
	 49jCtTJN4CZaVAL1lKtNdDe4VX6VA1bsDvSwLbN0YwioozBbUYw0ueyJHlhTJk9rXt
	 TMbJOopN0Zj0w==
Date: Mon, 20 Oct 2025 19:13:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Kaplan, David" <David.Kaplan@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Alexander Graf <graf@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
User-Agent: K-9 Mail for Android
In-Reply-To: <LV3PR12MB9265DFD04F0F17DE7AAF204994F5A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com> <20251013143444.3999-41-david.kaplan@amd.com> <20251016103549.GD3289052@noisy.programming.kicks-ass.net> <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com> <20251016144730.GC3245006@noisy.programming.kicks-ass.net> <LV3PR12MB9265DFD04F0F17DE7AAF204994F5A@LV3PR12MB9265.namprd12.prod.outlook.com>
Message-ID: <3902CABB-184E-4E23-9458-9D62401F908F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 20, 2025 7:49:56 AM PDT, "Kaplan, David" <David=2EKaplan@amd=2Ec=
om> wrote:
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Peter Zijlstra <peterz@infradead=2Eorg>
>> Sent: Thursday, October 16, 2025 9:48 AM
>> To: Kaplan, David <David=2EKaplan@amd=2Ecom>
>> Cc: Thomas Gleixner <tglx@linutronix=2Ede>; Borislav Petkov <bp@alien8=
=2Ede>; Josh
>> Poimboeuf <jpoimboe@kernel=2Eorg>; Pawan Gupta
>> <pawan=2Ekumar=2Egupta@linux=2Eintel=2Ecom>; Ingo Molnar <mingo@redhat=
=2Ecom>; Dave
>> Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>; x86@kernel=2Eorg; H =2E Pet=
er Anvin
>> <hpa@zytor=2Ecom>; Alexander Graf <graf@amazon=2Ecom>; Boris Ostrovsky
>> <boris=2Eostrovsky@oracle=2Ecom>; linux-kernel@vger=2Ekernel=2Eorg
>> Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe(=
)
>>
>> Caution: This message originated from an External Source=2E Use proper =
caution
>> when opening attachments, clicking links, or responding=2E
>>
>>
>> On Thu, Oct 16, 2025 at 02:40:51PM +0000, Kaplan, David wrote:
>>
>> > > Can we please keep this in sync_core()? Something like:
>> > >
>> > > static __always_inline void sync_core(void)
>> > > {
>> > >         if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
>> > >                 serialize();
>> > >                 return;
>> > >         }
>> > >
>> > > +       if (repatch_in_progress) {
>> > > +               sync_core_nmi_safe();
>> > > +               return;
>> > > +       }
>> > > +
>> > >         iret_to_self();
>> > > }
>> > >
>> > > That way all the modern stuff that has SERIALIZE will still use tha=
t=2E
>> >
>> > Hmm, I can't quite do that because sync_core() is used in a number of
>> > other places too (unless we make repatch_in_progress a true global)=
=2E
>>
>> We could just out-of-line the thing; nothing using this should care
>> about cycles -- all of this is quite expensive=2E
>>
>
>Coming back to this, are you thinking we should just create something lik=
e 'text_poke_sync_core()' inside alternative=2Ec and that can use:
>   1=2E SERIALIZE (if available)
>   2=2E MOV-CR2 (if re-patching)
>   3=2E Else, IRET
>
>And maybe someday we put MFENCE into there too for AMD parts=2E
>
>Right now, of course this is the only logic that would care about an NMI-=
safe sync_core()=2E  So maybe this makes sense vs creating a generic versio=
n that nobody else is using?
>
>--David Kaplan
>

This is something that can be done with a function call=2E=2E=2E not fast =
no matter how to slice it=2E

