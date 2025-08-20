Return-Path: <linux-kernel+bounces-777467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1CB2D9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A229A1890DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA72DECC5;
	Wed, 20 Aug 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZaTG3BvN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD42D4816
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684522; cv=none; b=msO2tLap9o5+ulPEsSR+hSRPllwwN3zEs/p8seiXRAQDlBCF4feiDJoDswWQRTvmTW08hheeq4Fk5nr2VvH2jdXgrInrHCQ8JwH5rGXkUIBhMtARQoc9LJFDODwXCPI7++PtQWWCF495/8gYoeshNg+Y6obrOF5ZWVW6UzDFWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684522; c=relaxed/simple;
	bh=mwTP7TXo7bhpX8PXSFHrgLv6FCeN0wiH8F/6+WtedzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovNU4AlQ0AtAQ1haNjALrlPRUZbQp1V3DQx7hHy+f6mD+e1IBRQIJIS2Q7cm+ZholJRU+wWnSyCFyEeBZHzB201jB0rcMwrEIBsv3cQmo/lO+iY/XifWZsUBYStTZ6OOknG3ZVn8L7fiHzLP5r8jIfg2Mx6oyvEt5LM6EkOT7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZaTG3BvN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0097A40E0286;
	Wed, 20 Aug 2025 10:08:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PUkKV75C_p3f; Wed, 20 Aug 2025 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755684515; bh=npNf42C7Vj4TBsjN4PzadidMVWGU5giR5QJBdLC8SCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZaTG3BvNQN/31hOAOfJCdItO2aq9kizZxFa0HBpj8cUkXrhyqK8u+5kLatn2LuVBE
	 F+aWjokpoRK3ECr7GI2Woo2UfXkuZp/JqeYULK7C1uzlSwlFJHqkXf55Lbo+tXecGD
	 EkVHARrXTAMlY40HjE+V7ACgzS9tZFlZFQyk9mfuP1QOG0Sy1EETeecElBaZD1uWtD
	 ociqsNu2h2T4XomuQrqFX8JI7hU0derOIrdq53eTFSmTLprIV895wgOobSS2u/dvc4
	 iBMJwvuvOJEgltR1b5aOVn7tQBEMFdwww3PdTsWlpO88szTd423BSzCzBy1B6NXe69
	 5zrCI6hpP6vGCz6PV7pYVBlkG+o2aH+gMEKjMLOVZPMcVF35bVzv4B6i+dM2CRty60
	 0dsUzlN9vwgkUPHBH+iv92wH6w+N8dsMytRA2SFi1UTLnW5QfRF/uQK+mqa2X6lQ1h
	 kovB8YXcWdvQiJ7lD18dhemAFEjGvclKl+i0OIlsI/NirAGuPY0F8LLZwz4o9zzip2
	 pdyYd3X7LkOtvZlMHS46IJXqO1KH+62OkXTL6bl6Z1Vs26tt14qN/QtA171zJWGNfO
	 5U4ZcTIA5zKVMax6QbLMY4Sae0+sEM2nXdUJpLMkcA+nXQZ3o241glB7WdK7ZLLVqu
	 r9O0WOEP52oXEBJ1W4Z/Ljes=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8558840E0232;
	Wed, 20 Aug 2025 10:08:17 +0000 (UTC)
Date: Wed, 20 Aug 2025 12:08:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>, Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <20250820100812.GFaKWejCFMSAS6QIfS@fat_crate.local>
References: <20250820013452.495481-1-marcos@orca.pet>
 <aKWR8e6VUEZEgbkw@lx-t490>
 <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>
 <20250820094347.GDaKWY02hR3AAoT7la@fat_crate.local>
 <be242e65-b056-4e12-93e7-9a297aaf231a@orca.pet>
 <20250820095556.GEaKWbrMh24T7jTfBg@fat_crate.local>
 <3db7d599-c2a7-4bec-94b1-4872649dde8d@orca.pet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3db7d599-c2a7-4bec-94b1-4872649dde8d@orca.pet>

On Wed, Aug 20, 2025 at 12:01:30PM +0200, Marcos Del Sol Vives wrote:
> Please define "once". Once per what? Per boot? Per executable? Per process?

pr_err_once(). Per boot.

> Once per boot would mean they'd need to reboot to see if any other executables
> are affected.

We'll cross that bridge when we get to it.

> (again, like IOPL emulation which was already deemed okay a couple years ago
> and merged into the kernel)

When it is flooding dmesg for no good reason, I wouldn't mind toning that down
too.

IOW, I wanna see a real, actual use case which justifies flooding dmesg. If
you don't have one, then we'll do it only when it is really warranted.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

