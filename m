Return-Path: <linux-kernel+bounces-810456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E01B51AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52707A6A42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606F334379;
	Wed, 10 Sep 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UIgyjwIK"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FBB324B08
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516242; cv=none; b=uqyDRYPjLc2pleAJ/MdxCFZOhKiX3Gu1SUeEfoufYQv15QrKXy9THZoDF5sE2wfRaUVjY0glZV1B+sEd0Jqibf4KjDQXMtkEdnu1LhaopG1WI3Jd86GJfdjH7W4sYOPicRQ+Fi5/lzZbpPNmWA7IV5mavFzSJ3j0/lD6PHXiXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516242; c=relaxed/simple;
	bh=+QrigESGpr9hgmU0mA4QuhpmdPuqTsQah12G6csugZY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Zl4DSw00/EwJgARYPL61UZBB/Wi6dbTE8vgJWQ19G7kw3dl5ZMlnUNJQLxMb9zRIaV6uMiXiSsWQqiQH0gT9elAmGqPHKArBt34YT+REtY6QIYK2BCjq1uF3UP78vSAofqDO8NBh/SOB2mwtDoo7e1sIpmJrvBxKaP48ld+4a7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UIgyjwIK; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58AEujRG2718629
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 10 Sep 2025 07:56:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58AEujRG2718629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025082201; t=1757516206;
	bh=5kLM77iWVpG9hgu9n1GirrVA1IEAql5WifnbjB8jA8I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UIgyjwIKuyj+PNSh8VBX6J1TUgaXWPkfiikK9fphyvRxEsndg8DY+GxZOW1qjPs9X
	 WYgzmsis2rNZV1eIMtzMrI5yHTBcfHFB4UKk5G2fqrYmY90nkCjMgcqgRv/aWswQJ8
	 AHHUB+7eX0O3fDBeTeAY1e8XALgbRQZc661m3dcOg1JD2QDcbC4UNGBHX4Kmi6fIu3
	 D4VbDUFABCzcnqdxpqMCH0G092Kh714II5B6ez4OByIFjdQBg8KYW/B+/ah5KsMePN
	 yDXk3n8VF+XZImzzvI4ntLqUF+Yc2s6EvOu4wVaVIp5scAjwCjmSb0GOOwPfbViiui
	 YMeDIvSDDBfSg==
Date: Wed, 10 Sep 2025 07:56:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Jinchao Wang <wangjinchao600@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/hw_breakpoint: Unify breakpoint install/uninstall
User-Agent: K-9 Mail for Android
In-Reply-To: <cae9c81e-84ac-4da4-abb5-9ff9e20c6d3d@intel.com>
References: <20250910093951.1330637-1-wangjinchao600@gmail.com> <cae9c81e-84ac-4da4-abb5-9ff9e20c6d3d@intel.com>
Message-ID: <332DA932-2A5A-48B1-AEF6-84D4CCDB7BA1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 10, 2025 7:47:06 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Eco=
m> wrote:
>On 9/10/25 02:39, Jinchao Wang wrote:
>> Consolidate breakpoint management into a single helper function to
>> reduce code duplication=2E This introduces new static helpers for
>> slot management and debug register manipulation=2E
>>=20
>> Also, add `<linux/types=2Eh>` to the header file to fix a build
>> dependency=2E
>>=20
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail=2Ecom>
>> ---
>>  arch/x86/include/asm/hw_breakpoint=2Eh |   7 +-
>>  arch/x86/kernel/hw_breakpoint=2Ec      | 151 ++++++++++++++++---------=
--
>>  2 files changed, 96 insertions(+), 62 deletions(-)
>
>That diffstat doesn't look like it's reducing code duplication=2E

He does add a *lot* of comments=2E

