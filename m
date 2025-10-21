Return-Path: <linux-kernel+bounces-862886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AD3BF6736
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93E0834F9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423452441A6;
	Tue, 21 Oct 2025 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D6NyzFZq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B235502D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049769; cv=none; b=XCcUCYLW53s+r/Z0udDfFui4jzCPlxjnF6w//u0M/RP3JbMphyIbE1/plbA/Cjb5ZH8gpWNnwzNE+Mxhkd7dTP1QOJM0s9f7p3x5LEQzDMkhgzli56sB77RiX9Dm7TBNn2GgDjKkia7oic6Iyi1DBOCdrV6zINDTtaiyIZQjZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049769; c=relaxed/simple;
	bh=4FxX4SOoXyMpZHaNWphk7xsS/z0dtEhSqeW2fEIgxno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6qZOgOv9fICoF62I4h3vlD6jcM/thSEoKG0aH0GqsHx+DPHTaveTZZoxXr/8gI4tzxIEB0PDEuci0K+xfLSqsh9hhrk9pWhZmyZeVBTMPIWAbUDt2Zi5A28XfPD4PoNSI0xYqegVclgWiyuYYsZzdKJkAEuTZufIYDQgjpOHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D6NyzFZq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 68DB340E019B;
	Tue, 21 Oct 2025 12:29:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Q28TeI9IJRJq; Tue, 21 Oct 2025 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761049761; bh=du3nF2z7pYFyug9u/5SUIAXbdnhDxdtTScUH/d8650A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6NyzFZqjI4vKijE5gfS3Eg8KVm0c3VSIpQ1eJQ0JYBbX3XGFmarjMF/nRav5lnEx
	 5pfh7y36rotINHdDgU9qu6m+I/92oXIlPyfrwQSNKd8a8/PQ+W2DeGd1xPGf8CqVVJ
	 KBIKXMA+EnY3YUDuVhpqgtbypPMp2avLbeq0b1blgSCKAs5iklMe4zORmKXRQiiJKI
	 yL+IoDH8pknDV0wVZYMktDZ2J7IVSysg0H2tT6C+qedS77tu6IwMVj+bHQSk1zg2CF
	 P3vsQ9JvTwkZjAhVKF9zBljsTtRRX3vuGxJg0Ns6T9AnQ1w7Wd8E5hwet+n49i03Dz
	 +5OvFHfogy8FtcPVJNg7FhVStvX4tSTOOAdQOeoo4K2vpmAMF6Vem/CgxipaWSCpk9
	 /VPBP9g998BU5tgXJkstk67A6gTsAbALo483GEfb21k/rpksLwkRfS/Qx0Ct4UJPHx
	 mMMbVOYwm3xEQ6QU1VPJXP8tLrr8RSdwtsk6THA9Tiqv047ama/3T/kwLMHIniUh4Z
	 7W6PSmOtKly6vpEYPFFJ73X42tMrNmRyvSNYY0+7oKWN0Yk8RKe92z++AEtkZ9XXVX
	 9TrbHUJn7Wm+jTU4ClfuH2xM6Zdo70/+avZfwdgoWgrYMm8zQpOM8JCJmvIhGHY67x
	 ER0yBNzCKOElsGALCXrPKLM4=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D815640E016E;
	Tue, 21 Oct 2025 12:29:15 +0000 (UTC)
Date: Tue, 21 Oct 2025 14:29:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Filip Barczyk <filip.barczyk@pico.net>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Message-ID: <20251021122909.GKaPd8ldoGqAf5JPfQ@fat_crate.local>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>

On Tue, Sep 30, 2025 at 04:45:45PM +0000, Yazen Ghannam wrote:
> Recent AMD node rework removed the "search and count" method of caching
> AMD root devices. This depended on the value from a Data Fabric register
> that was expected to hold the PCI bus of one of the root devices
> attached to that fabric.
> 
> However, this expectation is incorrect. The register, when read from PCI
> config space, returns the bitwise-OR of the buses of all attached root
> devices.
> 
> This behavior is benign on AMD reference design boards, since the bus
> numbers are aligned. This results in a bitwise-OR value matching one of
> the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 = 0xE0.
> 
> This behavior breaks on boards where the bus numbers are not exactly
> aligned. For example, 0x00 | 0x07 | 0xE0 | 0x15 = 0x1F.

Do I see it correctly that one of the root device's PCI bus is always 0x0 so
you can simply read that one and you can keep the current code?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

