Return-Path: <linux-kernel+bounces-880027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45527C24B12
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBF33B56B2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9883446A5;
	Fri, 31 Oct 2025 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RrSGqP0N"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67033E342;
	Fri, 31 Oct 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908773; cv=none; b=QmNpm+KR1ydQsA8OB1sSn+ktFIp8PvFQ29S+IS+Ii9IyPRCdFCdm4XIT6veyqoPMCw9CZeZ3ZSlNRgT8u5G79Jl84LmQRjxbMci9IW+YCYz0U8BCauFUSsn9bCTwT+ihKEtz+TDkRDJYKKtVPA35bfOxU4D9kwWyXLt+yyDWJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908773; c=relaxed/simple;
	bh=4cfq1Y0TZmzepTx0z9Pc1CjL59jvmnTMAbv4K9upR68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKH0+wmyF0cZeP/kL6sOyx2rMKgQQ3Ec+cHU5SlP1+AjZO5fNu5Sl7scp8WyAeXHktYjTQymSI3CSAhMSnOl8hCn4qwIijEGUhvW5zVppalsaWDPtmk3pB/ykTFyBOsJhzjUVwTVqQyY7YzclVc3mjQUS2ERsYyh3BVw4rM0VIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RrSGqP0N; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A00840E016D;
	Fri, 31 Oct 2025 11:06:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kpIPlvlll_QW; Fri, 31 Oct 2025 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761908756; bh=owYgRO4dJWD32zXGgkyqFaKX1bq2QVFVbUwoPHZa3sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrSGqP0NH0Gsuqb7JYoCi6egmsgvE9n1L/ZRfFLHkckV/1uISWbXNiHLumwgftivY
	 /WprBV56kXnr6i2OyhZAWeoI1iL35DCHIJCILvqKzY/aLH1VPtd51OHyx063yxy8g4
	 SS4YfBFl2fc8SwtqnlStdwn4+oPqXMu7G5AzcS9drDv1ZqfpDpIyt+x89N9bDC9zwM
	 Xxcqoi6Cjt1VQxPIbMuw3lP8LthmPaPEAdTeTldCb9p7wZs6Eo2dhYOYGDt5M7rahm
	 Vr1+vcJEXbgjLTMIm9OJkLEm1gas3RYRU1l0JA/H8+9+/E3gqtrXrPQxbT+Z1/4pAG
	 u4CYwv99/ENI+Tf+3y5NI0RKn/wLze8dNoWo1sII2MQn8MQpHXCwWuHNTsk8CfSXcn
	 aLkEp9OzWjFpDfaJV+KLkmWxajwq50SpmddXgIP6DUqNfiPAYRT6FjsOuNvPrp2lQ9
	 j1uotWwr422RnKiVc72dwR6OwoBcoW6FglIIEA17NqSiwgyC5couB0fbfHP3xxmJe7
	 LHFZpmIqdYXV8nIyKC7nPHXHfeEq5gTKTne50p5b/f7eM5i79YUuDs96uM1ix60L6Y
	 5OAHeB0Zs/flJUeR4KrPHLSROggWdVQQ1PfO+ewpxe9Cqn/GMlxebhtr3CDw/5QaHH
	 TQH/R8h/uIelD6h1Di0z6sjU=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2189440E021A;
	Fri, 31 Oct 2025 11:05:41 +0000 (UTC)
Date: Fri, 31 Oct 2025 12:05:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: dave.hansen@linux.intel.com, davydov-max@yandex-team.ru,
	gpiccoli@igalia.com, hpa@zytor.com, jani.nikula@intel.com,
	joel.granados@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
	mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
	x86@kernel.org, xin@zytor.com
Subject: Re: [PATCH RESEND] x86/split_lock: Make split lock mitigation sleep
 duration configurable
Message-ID: <20251031110535.GAaQSX_0CG8MPlieEv@fat_crate.local>
References: <20251030191057.GDaQO4QYoZytxdQW_c@fat_crate.local>
 <20251031024631.86616-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031024631.86616-1-wangfushuai@baidu.com>

On Fri, Oct 31, 2025 at 10:46:31AM +0800, Fushuai Wang wrote:
> I think there are two main reasons for making the split lock mitigation
> sleep duration configurable:

IOW, you want to disable split lock.

What's the point otherwise?

Apparently you want to do some sort of a solution for a cloud environment but
you can't make everyone happy.

So you either allow split locks or you slow down offenders. Making this
configurable doesn't make a whole lotta sense to me unless you write a proper,
concrete use case which justifies this and not some AI-generated bla.

If not, you can just as well keep this in your kernels and use it there.

I do not see the point of adding this in the upstream kernel.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

