Return-Path: <linux-kernel+bounces-749863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A1B153E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884785A3124
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA123D2A2;
	Tue, 29 Jul 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mRbjEyVc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="53tQHe9R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D21F956
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818486; cv=none; b=HKVjwyRKCWcDXRVs1Ku07xxqKAXmenMBDqQDZhAR51T/6sOOlt2C/Pbt4rA3ihUHABhP/TDccldAJ3rpEY1KFigGTOHu87G+0rgrebmAen7Kdl989GrkFE1pmQwXciIE2Lkhgx22eTuuehSSb1UnVCho8XXXpmwDkliBbUQdSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818486; c=relaxed/simple;
	bh=dC9+ohN2JZmtNrEMyv+FTD4SAeHNCvW0GwuvhlbS8cI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oy3o5XNiqkJGDdhUxMSsfZpRQ5Z//xIoblNlG9/fkg18JjUyULmsFRMb8Cc2vjMRnHk7KfxjqWrxDfwohTn6+moKV7mJtgAxCpWrVjpAZAYXpvBcqLpVLAXwZAcs1bwaeAJNBPH0nzEI7m/hGmKTFhjcCgn8HJ1vEqeztKxS++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mRbjEyVc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=53tQHe9R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753818482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Z4c/A5kPha14dR/kXbtRWHU31KVGhPSeJbZD9KbxCc=;
	b=mRbjEyVcgmbP77OjlEQpxlOQcrQ+oo5LfYcJlMCoLhhQkw1hPW/VOdpJUMV1Dn/cMCqqIH
	LlNMHzNNaTITuAakzJBrleR25mJza1yLv0dELCyeCGZDUDxcZ3f2SKsA9dzqlqogOn/FVr
	nLADcpfe+sr3KpmGbJ4zllsk9fTlCm9m1Is0wmHyab1NnzaDV2RW60UKmvtajEawhvql7e
	0q7MhQvncdyaujVwn3j8BZYocAZKk0DuEr5w3OXLH6gw3kMXHLAMsQkxcV6OifVKBo9hsC
	6Ujbp+yG2F0JZKcraoAXFveuFdCQMA3BL6x2tnQHiyGerQuAagzUxD4k4f3FXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753818482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Z4c/A5kPha14dR/kXbtRWHU31KVGhPSeJbZD9KbxCc=;
	b=53tQHe9Rn6fsV2BD5YBn8FmWX8p7f7WkcqdF7HLoFqLR/Ps7pkLm8rvoaSf2GqNeu1n/mz
	avpZNn2JUy1L0ODw==
To: Yipeng Zou <zouyipeng@huawei.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, sohil.mehta@intel.com, rui.zhang@intel.com,
 arnd@arndb.de, yuntao.wang@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [BUG REPORT] x86/apic: CPU Hang in x86 VM During Kdump
In-Reply-To: <4426d19d-7f7e-411b-8573-36b8990e5d9a@huawei.com>
References: <20250604083319.144500-1-zouyipeng@huawei.com>
 <87ecu1pfnn.ffs@tglx> <87tt2vnzsv.ffs@tglx>
 <4426d19d-7f7e-411b-8573-36b8990e5d9a@huawei.com>
Date: Tue, 29 Jul 2025 21:48:01 +0200
Message-ID: <87a54mkccu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29 2025 at 21:35, Yipeng Zou wrote:
> =E5=9C=A8 2025/7/29 16:53, Thomas Gleixner =E5=86=99=E9=81=93:
>> On Sun, Jul 27 2025 at 22:01, Thomas Gleixner wrote:
>> So the patch I gave you should handle the reboot vector pending in IRR
>> gracefully. Can you please give it a try?
>
> Hi Thomas:
>
>  =C2=A0=C2=A0=C2=A0 Thanks for your time!
>
>  =C2=A0=C2=A0=C2=A0 Indeed, It invokes kdump_nmi_shootdown_cpus() and use=
s the NMI=20
> shutdown.
>
>  =C2=A0=C2=A0=C2=A0 I started the test run today, but this is a low-proba=
bility to hit=20
> this path, might take a while.

It's trivial enough to enforce that, no?

