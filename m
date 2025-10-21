Return-Path: <linux-kernel+bounces-863098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE75BF701A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAE1B4EAA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2C2248BD;
	Tue, 21 Oct 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iz+cyDT1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A0126BF1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056124; cv=none; b=KyppmSFXehv11NJKnUVw67TDU6VyraCk9E06aHWVxLhiiZo6+hesfNoKjTWEOFJ6x7d/zdUjLru/xoxKTZXdbBwQJckBCv8r6NG8k0pvuFhstU8PPe6VCLj8eOBhsySq9KmIEwX9H+W3NsEkJZ/8vSuNC9gTrfhIZjM8lzG/T2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056124; c=relaxed/simple;
	bh=jnWYPn8lKtHubLYYT2BLf3SslwEf3XFxToQ3ybVTlak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZKy8o0zq1T/B6r+HQB0KCYX1BYLfFa0igdFrOOj1tu7Oe3IGAjjngwt5hQvNy3+9aTCa0HKb6akBblMEEJRwFH7lVh/QfImTa8riCPUONXWieyQk9+GehP7WS9XjCbV+Dw32tWcOrr0MMm2Il+Fwk8EUWnaeMw9ECoTrTAEQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iz+cyDT1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 983DB40E01AB;
	Tue, 21 Oct 2025 14:15:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yaXhsH--kyrq; Tue, 21 Oct 2025 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761056111; bh=HLQKbrphpD8sIJouh1H8Oq0AANqCilTjtXpa8OALooo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iz+cyDT1EfSC2PiOgRmUcgr7IZaxt/gxnPlv8D0LT0NfsNeS2B0S98mX+LzBs9S9F
	 wxgIIFxs6qUIAM8m63CVPg4AnF57f9Bynb8+anYddLNmG0XXWqh+b4Zun/pgHG9ae8
	 iWHYTQtFthneDMuQu85G/pW89Zq063GY7qut7MNFql8iwzgAA4goa3lMnvgqGCYL5T
	 7gHk9b4GKVnpfPvZudjygqPUTk1H4zHrvRfYYeuOyKsQmXwrHLm2t/XkISKZIiiaYj
	 5NguvXQPEsU042R7I4MUQeMhrdQAMKAD3NFywM/slVme5iBfgJhmm9Shpu4LWIFja0
	 AhZ2J1jd4V4YIqqMwvhtcO9821Pi9uloWgMB/Pxy/h+Ku+5jEcPr1T7ISjUk/pTgiN
	 Ai7c16PZLXf9+8KAkK3RysubBJn4WQpwF5sE4iYUGeXz8eVEn3/pYTtFB+D6vRoErV
	 9ENbH7BHKed2XeAga9xT4WSgONQGU9ahfp1XbKrEbAY/q8As+NsLqimbKa5uuAdz1S
	 AW+V9EHkdpOnVkOnx5ruhmRGNxAVyHpPSSX6vvQZ4jlwzuoSeU15QgqXaOKri4wYuG
	 mrMXeJf4FIz32lNcVQosHtdwSS8WJRNyxCCrB56AeTYNXjQqfFt7NucgY8tjOh5BC3
	 2iOLsTnhHjWqKVqjecc4p0E8=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CBCAB40E01A5;
	Tue, 21 Oct 2025 14:15:05 +0000 (UTC)
Date: Tue, 21 Oct 2025 16:15:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Filip Barczyk <filip.barczyk@pico.net>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Message-ID: <20251021141500.GDaPeVZJ8MaPbtTYv_@fat_crate.local>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
 <20251021122909.GKaPd8ldoGqAf5JPfQ@fat_crate.local>
 <20251021133745.GA3976@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021133745.GA3976@yaz-khff2.amd.com>

On Tue, Oct 21, 2025 at 09:37:45AM -0400, Yazen Ghannam wrote:
> It's correct that one of the root devices will be on bus 0x0. But that
> device will be part of AMD node 0. So we still need to pick a root
> device for the other, if any, AMD nodes in the system.
> 
> For example, a system with 2 AMD nodes could have this:
> Node 0 : 0x00 0x07 0x0e 0x15
> Node 1 : 0x1c 0x23 0x2a 0x31

Aha, so next question: isn't there a way to figure out which is the *first*
PCI bus of a AMD node? My gut feeling tells me there should be some info
somewhere which we can use...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

