Return-Path: <linux-kernel+bounces-771277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAF1B28502
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628AD5E3DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF36B30DEC6;
	Fri, 15 Aug 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JPFy6QXi"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1930F524
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278936; cv=none; b=fWgXmc8mwS5OKKnXcRktOovpxEwDNVnp3pu0A7pSu7UPsCzPr3O17U/SLaPId4Bn3XLaO2oDaHOpHfwY7kEUCRZs+sRfyuShzd3WcPy8nWcejYfD5XwE8dswozHZZilB1rjdGzU9wn9SPSwJ963VrvoR/xeX8gw9DYbyEnU8llg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278936; c=relaxed/simple;
	bh=rlu8tdmhOAUdI4UELJLEF+Q1Ukrf2EpGPzu38KwC42s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tMMOYWMJjM/hiUgme53MZCXq4ikOaW2JvHeI4Gilv5UttWF0sddtLXI0hL62HIqa31JourZhmeGu8dw2dQWl3CV9/Q3PgJtsEN7C8n44hfY+r8WGCml3MAuZeFWkXq54jhd9URKi5zPS+ZzlJieL8FqRAhRAPDohHDQOODormmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JPFy6QXi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57FHSgXj2018221
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 15 Aug 2025 10:28:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57FHSgXj2018221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755278923;
	bh=rlu8tdmhOAUdI4UELJLEF+Q1Ukrf2EpGPzu38KwC42s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JPFy6QXi7yhgozBYJN9Gt+Fjc5LRyVnoT+ZCXfnFN4/bKSfDNJD6YF7ddHlkYHzcV
	 Y891SxFe/VxoV4Ya4YZOv7da0lZzJzccNAaVQ4EU5P5QEgWpEkaQ8FILzEMvwvl5ZR
	 wb2g7hd+hgaHllyNNPO8od0fsXn4HTxgaLGU/d+zkdAWatwjA+9VU815UCng5K62ub
	 JkxbiW0JEKnW0QQ9BQv4pzpn3TSV+RKJxRHEGZKh10FQaAn0vJ7JTm071DWIc4ZdGr
	 g9TLjoww02X13cndu4IVtcgq12AhSf9CFp2QiBQ4yK8ECHpUrmNeRNmoU9VLCqvGET
	 VXaEqPDo3RxHg==
Date: Fri, 15 Aug 2025 10:28:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: x86@kernel.org, kees@kernel.org, alyssa.milburn@intel.com,
        scott.d.constable@intel.com, joao@overdrivepizza.com,
        samitolvanen@google.com, nathan@kernel.org,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
User-Agent: K-9 Mail for Android
In-Reply-To: <7594ecd7-994d-4cb8-9f8a-b6c1d4b01e17@citrix.com>
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net> <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com> <20250815074939.GA3419281@noisy.programming.kicks-ass.net> <20250815102839.GD4068168@noisy.programming.kicks-ass.net> <20250815103055.GE4068168@noisy.programming.kicks-ass.net> <fc0715e0-42f2-4b5d-be31-ac44657afc56@citrix.com> <20250815105908.GB3245006@noisy.programming.kicks-ass.net> <055f4c2b-0e7f-44ae-92ff-a1025a217208@citrix.com> <78bd985a-a59e-4469-a84d-a0eb7faa20c3@zytor.com> <7594ecd7-994d-4cb8-9f8a-b6c1d4b01e17@citrix.com>
Message-ID: <880F0E7C-86AE-4007-863F-E58B4C3C131C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 15, 2025 10:21:48 AM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=
=2Ecom> wrote:
>On 15/08/2025 6:14 pm, H=2E Peter Anvin wrote:
>> On 2025-08-15 04:19, Andrew Cooper wrote:
>>>> CS Jcc, decodes to Jcc,pn for non-taken
>>>> DS Jcc, decodes to Jcc,pt for taken
>>> Ah, thanks=2E=C2=A0 I was looking at the hex in one of the comments an=
d still
>>> couldn't figure it out=2E
>>>
>>> So with this notation, we also have the dual meaning of ,pt between th=
e
>>> P4 and LNC=2E=C2=A0 At least the encoding is the same=2E
>>>
>> What "dual meaning?"
>
>Well, it has different semantics now it's been reintroduced in LNC=2E=C2=
=A0
>(Only has any effect on a prediction miss, and causes a proactive decode
>resteer)=2E
>
>Sure, it's "just perf" so can be argued as "compatible behaviour", but
>people caring about the ,pt / ,pn properties do need to know the differen=
t=2E
>
>~Andrew

The architectural semantics are "hint to the microarchitecture that this b=
ranch is strongly biased in one specific direction", and that has been true=
 since the P4=2E

There are no other semantic guarantees, including, of course, that the har=
dware will do anything at all with it=2E

Performance tuning at the uarch level changes over time and will continue =
to do so, so if you don't distinguish between architectural behavior and pe=
rformance you have to define pretty much every instruction as semantically =
different in each generation=2E

