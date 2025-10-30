Return-Path: <linux-kernel+bounces-878303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F82C2038E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 383534EC23B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF1330313;
	Thu, 30 Oct 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CYRaGkUU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796332D450
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830607; cv=none; b=G88krygfcHeO2XT9M7C8k4B39Vz73fpUfJ05Ikbz3lhYxWUtQVc33W10qr/QdnngIlmDrrTK1DQXFUWhxlFuDJXfFeD1DjteXMJdtnYmMmYKC93/CZRKZ0wgevPOGzF69oRg66dK5PP25oSVBRs0mWOrSKf4RngIzjrjw+x4eDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830607; c=relaxed/simple;
	bh=+T++m0bCn8dzwoPtOBPiuLFJik8gkAN7Y5AmR5ssufM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3D03HX2ivxEr4P77n+OickN/5m5gJqKvkkk2vgvrXCc9NOIfQn3yBjGsd+GDN5VZX8JrGHuZbVGPOOBl/GpxKFPiOnFYPvX6e9bSKHFCC/cU4GPSfn+OWEVG5buldV6tbkf7LLq1mjhif08rwLDxikDIRkYJUN2HlBiJsWrBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CYRaGkUU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 51AC040E016E;
	Thu, 30 Oct 2025 13:23:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b6qXmKjPN26J; Thu, 30 Oct 2025 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761830596; bh=S0wCq4n1Evlh9ciLUjnAnI8tlm8vCuNNCRWLJx15CQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYRaGkUUJDECVox/nHGmHdMkmrsEqIZu12D0j6E5BTdPYoZ8ZE5zIIxGlh2g+Zkt4
	 2FRT1l6k6+mWo5+YQNKd0hPiAOoNps0VEvsfyWRc1tDUoMvhq3fUGTMA+YbXeslKFl
	 4Xiv8XfaTUBcQUePrnns/iqp0vzitEPfLBaxf2zv0U+G7OzZUAV0EoTvjC8XrmkzT8
	 szSYDhaZrLqq8KuEo6gPBeK2dwQyi/6DzesTAc3A/o8VzIRloacZyBqOfoIrGCTFi5
	 OvpVAw+8bzAkv+4/jMLoKFoQDvcndsfcO60MedRhW6AqLAoT8XdoaFsC5Iin5mzE4i
	 REUkf0ySZOLyaMdBx3C0NNdZ8BSf8aHyhoh0WtGNtu/rfwcyDY1qD+VmGovR+RO47M
	 cJx5IC7bOPYS8Iy38Od0EFoan/+8+QPXhp54ZMdPrIh0vjMyzXTk0rL2ecOSJrzR3n
	 kq2/taTL8M1ca3YoLKIUeMZE6Vm5lZKrbQ8OYRQ0vCiUan7rP2GNgSVyDZVwJHvkXW
	 6q+NKbuDrjIzS75HX9guNPdfeynqrUlMqaLhm4UsDyXibXHI1N88gL4SsH+zD7YH4e
	 vuuikXBnKR0cDsg3xsoVll5IiuYoNnqpwDGwxFt3kEOWtO1kYaCtf9YI3PdDhbZzAj
	 53CLAU+TPt/RpvgdjwEzE0SI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8838D40E021B;
	Thu, 30 Oct 2025 13:23:08 +0000 (UTC)
Date: Thu, 30 Oct 2025 14:23:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yu Peng <pengyu@kylinos.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.com>
Subject: Re: [PATCH v2] arch/x86/microcode: Mark early_parse_cmdline() as
 __init
Message-ID: <20251030132302.GBaQNmtgzFeZ8798t1@fat_crate.local>
References: <20251029081644.4082219-1-pengyu@kylinos.cn>
 <20251029123823.GAaQIKvz4gUk3Nsaj4@fat_crate.local>
 <2d33a48f-a43a-4ed6-a903-aff8184eebf3@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d33a48f-a43a-4ed6-a903-aff8184eebf3@kylinos.cn>

On Thu, Oct 30, 2025 at 01:03:52PM +0800, Yu Peng wrote:
> I found a minimal reproducer: i386_defconfig enable these two options:
> 
> CONFIG_GCOV_KERNEL=y
> CONFIG_GCOV_PROFILE_ALL=y
> 
> On my toolchain (GCC 13.2), this combination instruments the function and
> prevents it from being inlined, which then triggers the modpost error.

Nah, this doesn't help. Anyway, I'll take the patch as it is obvious.

Btw, please do not send your patch so many times - you can simply say what
needs to be fixed and I'll fix it up before applying. Maintainers are not in
a shooting gallery for patches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

