Return-Path: <linux-kernel+bounces-854678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6541BBDF169
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DE1E4EC1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530E2877FE;
	Wed, 15 Oct 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Wxa9nsNw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E85284894
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538812; cv=none; b=Ty7HA6rVSLOfapGSq8uTTgazLpfIY0jxY6XBLnOKrq9HJmvXdQky2DgLOYpNvKpv4yP8zdf7LmX33RopK40WFsluTB408qDSxBnns65mqGVoqlG+nwiBwLE4Y8Kjz++Um0td3giUy3Pbu2enO5aMLpQaYbmoAq/NHpZeDmsBaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538812; c=relaxed/simple;
	bh=U1g2UE2wmGVQI42z2dDFyqJNJalI9euEMg6W2sem684=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M1kPMZoNRNr3haiTMYpnPoOiMNXeWB/t4tLIJKbQ8GakZW+can8IKqmpukNE7s6jdD7s0Xifdtv2xvfPrEMdS9YbjStTXmMSdAFrtyW0Ru++m6A/ybERYJHGtkogVfJwRp8+dycrWNQollSYjJBXEtYPXWTQAf9c9ReLzsrUjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Wxa9nsNw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A83940E016E;
	Wed, 15 Oct 2025 14:33:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pDooAo90Ktqs; Wed, 15 Oct 2025 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760538796; bh=+uqgHRyhIsOO5kCL/3Cz/T4TGdaZkirPHY+FwR35Sjo=;
	h=Date:From:To:Cc:Subject:From;
	b=Wxa9nsNwa6EiioRbvquBAN3NxWRoWwbnhMqZOgIFyFaf+6kxRo3Y3yYIOC07qKNyt
	 NoszG7NXR15Fh8BFQZGpROhpajqV0GcTkndVu4IuKXBAvWrzyhdHhPzEYbRGiSaBSB
	 FLdD9Dlj9rWRFPte6vgKRAbJTjaxO6ZBzp1DyMEKKCNPw/R4aeR6/JIrXszfcHDVmc
	 9+4LmE1Nb21W/APfkOgNJpCVZJqJhtKvNXMCP8XMA8fENTPvUXVx4FY7U5KSShNHz6
	 j7lTrt0MpkqeUOvWAnMHJBwCSNqU2uHzf5vtIWGlKc9/FQWWNv3cXsn4OM+qgXbgEj
	 D3Fnp3h+ZJo+HZhkoXnUh1rDHGKBbD/jKGo0PvSFa1OE7ChO1UuOquKA/W9e5DB5zm
	 im126dscdP/mzGCaYw9qERgnR1y/pC42xQjqDpvLy0UdmC4h/xIGfqQ5TnIqIJirYs
	 w11nP9DpFhwdxipCPcUUqYw3mp9zwvnnNAhtRpdbO/mVXVzRg5gf+LZOaDTR7yJ+TE
	 1D03utdXUAIudqnq884XJzwUJCkStbkBT0ORaBmRCs/5QOL7rWtf4dwaP54pqQLW+I
	 imv692kZ+/n3PDPSPi3ClZq6pSz0Oax1L2lsmbo24C/tOFBxTmJyDx58kJqSrzZ3pw
	 A1RipNZlmhfixIlW5vY5VNVs=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BD20740E016D;
	Wed, 15 Oct 2025 14:33:13 +0000 (UTC)
Date: Wed, 15 Oct 2025 16:33:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: clang 15 build error
Message-ID: <20251015143312.GBaO-wqLdOtyEQkd1U@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey,

before I go dig into this, any ideas? The likelyhood that you know what the
issue is, is high: :-P

That's 32-bit allnoconfig of latest Linus master with Ubuntu clang version
15.0.7:

mm/maccess.c:41:3: error: invalid output size for constraint '=a'
                copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
                ^
mm/maccess.c:22:3: note: expanded from macro 'copy_from_kernel_nofault_loop'
                __get_kernel_nofault(dst, src, type, err_label);        \
                ^
./arch/x86/include/asm/uaccess.h:629:18: note: expanded from macro '__get_kernel_nofault'
        __get_user_size(*((type *)(dst)), (__force type __user *)(src), \
                        ^
mm/maccess.c:41:3: error: invalid output size for constraint '=a'
mm/maccess.c:22:3: note: expanded from macro 'copy_from_kernel_nofault_loop'
                __get_kernel_nofault(dst, src, type, err_label);        \
                ^
./arch/x86/include/asm/uaccess.h:629:18: note: expanded from macro '__get_kernel_nofault'
        __get_user_size(*((type *)(dst)), (__force type __user *)(src), \
                        ^
2 errors generated.
make[3]: *** [scripts/Makefile.build:287: mm/maccess.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:556: mm] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/amd/kernel/linux/Makefile:2010: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

