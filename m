Return-Path: <linux-kernel+bounces-841544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32514BB79F5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D25DD3473DA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C02D6E42;
	Fri,  3 Oct 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BabNHPDS"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677492D63E8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510476; cv=none; b=knfvT3l13dOpTd1lr6rkNAoyyAeNBtLjlBeyZvCF1xZss39yY01TDXAcPVB8uHCwXZeefF81YOI7c9C2+ENyNpPOBaq5b3RpL4OAw8JnAWC9ieFyM33ENPOtxBEna37iIY7UnT7GMm3jvzV23fXM3WSK5C9/DnNIwNJzKeNz7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510476; c=relaxed/simple;
	bh=39MheYmLUlrL9wszDwc2Pd2eHARvVZ7Tha1c9C3VNyc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=M5xgzLQLInUjsQffeElTBXngOgakvgPBGWObGwYOZKWOb0037yScJJbdc1oTpdIhhoDVFOOK1lcCDRZNZ/C4aNL6Ems/XKQYJgsHY1W8BIjt3677x469HM8J3dJRm+sMYkWu5Nkmkp4U25qKA7OJBsUtgrIieKdwoEgZGOzZwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BabNHPDS; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 593GrPXh1724782
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 3 Oct 2025 09:53:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 593GrPXh1724782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1759510407;
	bh=39MheYmLUlrL9wszDwc2Pd2eHARvVZ7Tha1c9C3VNyc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BabNHPDSCLA+dWiY0eVXAqN9kpmuO23fvNJ5MSgcG8eZYdiI7KDM7D0Ick5JABQ90
	 6jECfEctX7k/fG03yTZsmzRWNBzZPT0r5Zt4YwVvsC8pd5BX3P8pHlqdAXXZpJjVSW
	 ognRo3aJKrInR2ZhcZuq585HXGDDbAYVk1O9tbWPXZyYDZuBKsc5KXb+jKcY7JA6bX
	 I1PsHjegQnIG6Y324BRgGEJtAsqLun/QcClickLiD6awbjJqqWI5lerrd4l0COGgu8
	 8eWnSf1z+vhcgxx1Ii3lkAnv3VDAcPTFvUQ+9WegD0RNjzHHVDGAWWyJbbcl4IBKTM
	 oVQuKbuwqmMEg==
Date: Fri, 03 Oct 2025 09:53:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        =?ISO-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
        xin@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_09/12=5D_x86/msr=3A_Use_t?=
 =?US-ASCII?Q?he_alternatives_mechanism_for_WRMSR?=
User-Agent: K-9 Mail for Android
In-Reply-To: <4c4cce9f-3219-48f0-8606-6573339b8794@intel.com>
References: <20250930070356.30695-1-jgross@suse.com> <20250930070356.30695-10-jgross@suse.com> <20250930083137.GH3245006@noisy.programming.kicks-ass.net> <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com> <20250930085044.GK3245006@noisy.programming.kicks-ass.net> <20250930125156.GK1386988@noisy.programming.kicks-ass.net> <2ad137cb-ed38-42f6-ac0a-a81569051779@suse.com> <20251001064339.GL4067720@noisy.programming.kicks-ass.net> <20251001072340.GM3245006@noisy.programming.kicks-ass.net> <4c4cce9f-3219-48f0-8606-6573339b8794@intel.com>
Message-ID: <C595599E-0BF9-462E-A79B-E7F6C9D5F587@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 3, 2025 7:23:29 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> =
wrote:
>On 10/1/25 00:23, Peter Zijlstra wrote:
>> On Wed, Oct 01, 2025 at 08:43:39AM +0200, Peter Zijlstra wrote:
>>> Let me see how terrible it all ends up when using as macros
>> Argh, as macros are differently painful=2E I hate computers :/
>
>ALTERNATIVES are fun and all, but is there a good reason we're pulling
>out our hair to use them here?
>
>Normal WRMSR is slooooooooooow=2E The ones that aren't slow don't need
>WRMSRNS in the first place=2E
>
>Would an out-of-line wrmsr() with an if() in it be so bad? Or a
>static_call()? Having WRMSR be inlined in a laudable goal, but I'm
>really asking if it's worth it=2E

We need them to use wrmsrns immediate=2E

