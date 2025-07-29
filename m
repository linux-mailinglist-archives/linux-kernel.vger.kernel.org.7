Return-Path: <linux-kernel+bounces-749506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7BCB14F35
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BB554324F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E0E1D8E01;
	Tue, 29 Jul 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Eb+Ot/KP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF6CA4B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799139; cv=none; b=nla99OUfg/QTzSvJ2bV3cZUu3MaZkLIEMKXOxZ4Wn3zpq4pZzg0i246xkSqn0OZ2j286LQ6oJ++OnJvifps7Dh5+6OMUGumUxqD/r6SqRv9P70kYp+zIfIQFIHpr3DtKWAvuPQsZZRniuSt5XPEPVHs71zWVIPhHhbDEFjP3HZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799139; c=relaxed/simple;
	bh=nGOllIpb/iXQ5xYyy7wrj7wdhGK+r8rwyMOp0T0TWRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku1Xr+VCRpBrA9Gc1i29VeVozuMyUYIsnr0UZ9NMvmkmDrEzks9P1St5flNUMLzBbGrnOmOb63B2CuQlyZZVZQfniHn1gLHjhpiXvqr2d8DVmryVifk1owZVn+LZN8TfAGI5cx/Wp7woM0bTUaeibw2Zt1kn7CXQdufYYZj9MhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Eb+Ot/KP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5C4A740E0206;
	Tue, 29 Jul 2025 14:25:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2yeJrjBUzY-G; Tue, 29 Jul 2025 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753799127; bh=GTv0rgrw4/cVjUnmUx7TH0+Y77P3eaPZFzJeHx/KFuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eb+Ot/KPM4W/H6i+sVE/bnCAwhMcLFH8EPGUF1wqS097Gezl91/v8pWztBjVqDicf
	 9iVDVMi3IJwvL3MzRi7KpRmZ94IINu1IW6iDHAOv4qbs98VrqEkUe/Pp1fvstuDP2u
	 ZK5j9bPaPJvkDcUvnKodzs15rJSHcWiiek5tJZzaqKPjtabJpyOAGSCkaJx1bD8lad
	 eX6z1AL82a9pdCeb0sX7buLYJxId4IC4Namuhk0/q3AXbNlRQuHOLkDf58tbDpOScw
	 QbNCQgKRto6F2INHw/nPmxU6KQ2hEjxDgENiCBmoawUv3dKd0kgx1Ry+kA+Rtui8+q
	 03eZSbNGNqJ3x+QEP9/gm2gJFFRtUyCbNRSdHIcbdkBTTtkQzGA9HtEH2JOoe2byhM
	 HtpwQEBnCDxYN0q6Wznxv9X76Fpv+l35VyGiCj++Pt5dkGWRD8mputs4LsYLc0Bj0O
	 VawkHNcngylbwyWn1RiBCUrhTRC5Yx6cuKUrZr79ulqTIPY1b5eplfC3AvvVtVyCKc
	 2Ay4EWNyU3sELFkXyeNjA6cQ5DHvJr1J05mkKgP6HsHjoY0UBdXwhzMr22CPKSoWFT
	 g15o3+apHstiAjij25eELUdRSVi+GiI47kI3wY3oWFUEbGD+KWlR8NoS46UzkJpqjq
	 fUi90NkCyCQXwQhehT05vSL4=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90DF840E01FD;
	Tue, 29 Jul 2025 14:25:18 +0000 (UTC)
Date: Tue, 29 Jul 2025 16:25:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] upstream build error (23)
Message-ID: <20250729142512.GBaIjZyNHliBrvMFlo@fat_crate.local>
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>

+ Ard.

On Tue, Jul 29, 2025 at 06:43:32AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    86aa72182095 Merge tag 'chrome-platform-v6.17' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=171674a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3816ffa0a2bab886
> dashboard link: https://syzkaller.appspot.com/bug?extid=5245cb609175fb6e8122
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
> 
> arch/x86/kernel/setup.c:1251: undefined reference to `efi_mem_type'
> ld: arch/x86/kernel/setup.c:987: undefined reference to `efi_init'
> ld: arch/x86/kernel/setup.c:971: undefined reference to `efi_memblock_x86_reserve_range'
> arch/x86/kernel/cpu/mshyperv.c:496: undefined reference to `isolation_type_tdx'
> ld: arch/x86/kernel/cpu/mshyperv.c:494: undefined reference to `isolation_type_snp'
> arch/x86/kernel/kvm.c:600: undefined reference to `efi'
> ld: arch/x86/kernel/kvm.c:600: undefined reference to `efi'
> drivers/acpi/osl.c:210: undefined reference to `efi'
> ld: drivers/acpi/osl.c:210: undefined reference to `efi'

# CONFIG_EFI is not set

If that's a random config, why do we care?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

