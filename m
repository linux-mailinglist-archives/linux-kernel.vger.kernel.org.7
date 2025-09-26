Return-Path: <linux-kernel+bounces-833917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A05DBA3558
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B657AE881
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF02F3634;
	Fri, 26 Sep 2025 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ahAO3m//"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2562EFD89
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882089; cv=none; b=NbtKOF2ZuTDvpm/y+ipmdbuudPwdeXUL3Lqj50V5MZrpvqX0gtGYMCfN+MgRhzF2h2MId1ub/7GEeMDUb9roq9a13H/RxM8NEzoNbF083j0TlO5ZQn/lrJdaVnbY4zUGb6hHQZlzxA3AyT3/SrvQs24qe0Crr81TDUo4zZfPg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882089; c=relaxed/simple;
	bh=Xfj7IaQ5HkhC9IVxkvk/mqAXBYolVyDm9V12nzRaId4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5yy9PfMGNQvxX25mQsesT0JgefVromrSQ/IJPgeZscvOdynQQSvtEPPTDruupeJFGl8AVGt7WIl1jHfWplk4lOV5VwL/huuMD/wTCokjV67WwmmTonVMMRSbiGUIisZ90hVwCvCZQQ0C+GiEMLENFW0VhtrswuHAPiuOySkJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ahAO3m//; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 242AC40E016E;
	Fri, 26 Sep 2025 10:21:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v6QXJdhBucUR; Fri, 26 Sep 2025 10:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758882082; bh=RH5p//4LV7f49gUzLRTQl42PM1vrXgLM5Rk2QzJRyLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahAO3m//stwyQh8q6fq/jAlli4GRQ6XdQXStL/veJpQcoXt9/78OoglntUXKct9v6
	 sqqeZw4tHk9fiDZ8n67gQwvBRY7Vgia7tYC10SQuBdYN+O1GuxLMATdzKlnCUuCDQu
	 VcpNObJFWM56sVwXhr7LDLfLeTQuNWDyXC7hfv/gLytiqCxsXzwSxRLvWvzZi3AhJc
	 n3STygpV3z3Iet2YKWWHTKJ1flTI6ZbjEzk9TcGQqq8d4vrc7vdCJ0eeVrj8PmFivq
	 SO5QpnltliCUuUWS+RsdarVJZhjTIJZ2XIsozL2zt8ASgn3ascQ1zfGAr/g4gVi/B4
	 iRqwlG2MDX80mWHthb/SuTjD32Fg64ZFRRq/7X1LiiWQY53qeVGSls1uxgwltl2fKH
	 8ABKP4WMxn1P8IaeEEhl1mEZ5kTzBIovddlyJo6w0UKqBHzRoWq1Pe9vS3z2SLjp2l
	 2rF9tEyq8jK5w+cIh/EUFSObPE4FWbj4+Q1XeKp7jMXX4ldRio8fkAliWrvMcougAw
	 xjrHV+PHny/rkkRKI+eovHDAw2DuRh7CZhzKVG+VDXJab8LYvcYS91gJ0BY7H9Fe5j
	 f0XSw7RUO/3ZiwQd3kX7Uu88KU1aePNPyG32gzOJEEQNeKFY4EqgAih/ttgLvNNb+f
	 aVb13z13kq0t95MQngQhvXO4=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BB4BE40E00DD;
	Fri, 26 Sep 2025 10:21:19 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:21:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/cache for v6.18-rc1
Message-ID: <20250926102118.GCaNZpHl8wLoh1FDT7@fat_crate.local>
References: <20250926101649.GAaNZoEZjRzw1u4p4c@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250926101649.GAaNZoEZjRzw1u4p4c@fat_crate.local>

On Fri, Sep 26, 2025 at 12:16:49PM +0200, Borislav Petkov wrote:
> Hi Linus,
> 
> please pull the x86/cache lineup for v6.18-rc1.

Forgot to mention: this time around there are a bunch of new X86_FEATURE_ bits
getting added and coming to you from different trees and should you encounter
merge conflicts, pls pay attention to the numbering, like here for example:

https://lore.kernel.org/all/aMlPZcYlk7hRlMkE@sirena.org.uk

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

