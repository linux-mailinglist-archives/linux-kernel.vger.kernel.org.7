Return-Path: <linux-kernel+bounces-720115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD9AFB746
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1EA4A35C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58442E3B0A;
	Mon,  7 Jul 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C3FgyR6u"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA52E2EF6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901944; cv=none; b=C4vBkqcBfA8EbXUS2ClA0zq31+3ZFHGwVU/ZZAYMz47dYZNXtm718N2x8g5X+VN82J90nBmF2xtfrfkmMHpzI7DcxV/aaCOLcpGyyNTAf0KAb5FZCM7YLmLoM+RuVxU+qztRqzVwyxXcsmTJfM2Jt3nu7sJOCf7fS6yIWbClN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901944; c=relaxed/simple;
	bh=RvIbt4JsfzT8sFtxZjfR7V9phnXTDlBr7TATAuTmAck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3RuwTmiFrKsXERVvqIePQ976/k4XgUTgQ78xa+6EijKS0lLPU1QI0at6ud7khjo8FfUPnDuyZKwS51NdI0n1OeCqcm2PhPKYN4hQNT/ISJcw1J9Gyufi985g0xxTCN6rep+SjN+CxrSdvzOYoRBPw31kKv3X0cTGYtTMeb8DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C3FgyR6u; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AEE5540E0205;
	Mon,  7 Jul 2025 15:25:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uENk_L4ipx_S; Mon,  7 Jul 2025 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751901936; bh=fIhd7HOTfR/kWBhN4MAo63YQ841CAFgPo5PQ21Ie9h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3FgyR6u0dIBaYYAmh6fp8C2gVqq1y0YWiTxCFzc3fqwIbDQAqZoiBw7HTThqe/3K
	 sfiuwKs1jzZRv6S9FAuQ1VYe8er8RCxqJmZotv7Zz4JJ5uXSpJ2SFKpfMFIkPPD6oR
	 zkSLgqzFn0nIQg1d7WBogCUfrbLeGlnqWbAzCBze38SOfjM45taB2ceT2d6/P1cuE+
	 0REumGRl5vycG4yCh/EZx2O9iwtf/D9a+PrVKKTjS3HRaQjPOMhBLN1T20SjtvZGv9
	 mYowAX0wjIfWdSzINVptqMEfQCS8P2Ci0kkdDHofOm0iTng90UewHQOSEsua4n1gqD
	 TfFEtnYdouItHLC4Gjq26Fb/oKTcqvtPFvYYxQbla38/oxMA2wfZjWBcZsEmFB8u7o
	 wvi7seQF0CtFm0AMWjvgfe6wnY3+Qjt6XyltGWjno984e4/xzLO+RFPsCr2+C3QdDT
	 evaiyuU2tBJ7LmtxhDzwLZjbcMOi1OWmGjXkVxiC9sRAJWFwet5FS471EH1yzzrIeX
	 p0Yv3ruTFGCHIeyfXCiQlDR4lCjWQ05JiJIKdIXhbmkCxsv5+cQZrYpvLDcCqs/lBd
	 zA4GIjm2p/sbd206YWuK42X4zg+IHekiExNwaDKiaF/4UvkhzNwnn9rjNohAJrdF8W
	 lFLibLECTn7l/r+RpdyqolrA=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29FF740E0202;
	Mon,  7 Jul 2025 15:25:28 +0000 (UTC)
Date: Mon, 7 Jul 2025 17:25:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mikhail Paulyshka <me@mixaill.net>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/rdrand: disable RDSEED on AMD Cyan Skillfish
Message-ID: <20250707152522.GCaGvm4uRwQwkflx45@fat_crate.local>
References: <20250524145319.209075-1-me@mixaill.net>
 <20250617200551.GIaFHKnyPV_XsSjlMP@fat_crate.local>
 <cfb12298-5214-4fc1-859c-2218c7da4ce3@intel.com>
 <40cd274e-a02b-450d-88df-aa2b92b51b12@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40cd274e-a02b-450d-88df-aa2b92b51b12@mixaill.net>

On Mon, Jul 07, 2025 at 01:17:41PM +0300, Mikhail Paulyshka wrote:
> On 6/17/25 11:21 PM, Dave Hansen wrote:
> > Heh, maybe if x86_init_rdrand() did RDSEED too, this wouldn't have
> > slipped through QA.
> 
> This might be interesting to you: in V1 of this patch set, there was an
> RDSEED sanity check, and Intel's CI detected broken RDSEED on Comet Lake:
> 
> https://lore.kernel.org/all/202503211421.fc83271a-lkp@intel.com/

Right, I'm being told this is preproduction hw:

[    2.823625][    T1] smpboot: CPU0: Genuine Intel(R) CPU 0000 @ 3.30GHz (family: 0x6, model: 0xa5, stepping: 0x1)

and strictly speaking, RDSEED *can* fail due to resources exhaustion etc
- doesn't necessarily mean it is broken.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

