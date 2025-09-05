Return-Path: <linux-kernel+bounces-802725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6587B45609
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55271BC1743
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFD034AAEA;
	Fri,  5 Sep 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UI45eGjr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976FF345739
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070854; cv=none; b=mIsP5QQ5Xmszhq2DFoVK9G91KKp6oekeR6DdjDoQZS32fVNoA0GQohQzUicemnhGuJT5B4f1ESlhlUotBpRyg4Ln8fxpPzFrulDBvut272y/kwGG4V56D9MvTOsRZK65P4UjdXrdB4Q9V/4isLm7QkNB3HNmbiec3/ASDlcBXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070854; c=relaxed/simple;
	bh=n28eJkpFB4IwxSo78MbxN7v1KZpY4uTB1SXqBvLJDr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgqcF+Z8oYjmS8O7xAhNe7W6n37U1iioIDMqx70hV3LGnQNGyCzF8ogvLZyH71RzIypA8H/5zqOFJh3wQvzGKHRnzfAzsau1PbaHSUGkfyfh6gVhr3oVLuzRv5jHHXxrzGPuYIjk4Y260pkNaxyCQuFAtjd4zmZRqYqhbSU5EtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UI45eGjr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2E84C40E0174;
	Fri,  5 Sep 2025 11:14:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qsk23-XMzoMI; Fri,  5 Sep 2025 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757070843; bh=WNHdNfsnaMtK7Yo4KkRWyo5XKhuEd7up4oW37Up6gek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UI45eGjrDoEELx7Rvvg+zLPWju85qG3ciUWcnUqkHFd3bwu4rfFOhvQp4ArwoPd1x
	 bc0I9wVZzDP6BTZASd0tn6dlWn0V3w5MEybBGAtHW2BGK1of77gk+8ZdUhyYS8MVAz
	 r1ui/yBEBazSrUJN9f9ggWADk16zezhAnDlIuTsCGR3hcb9Sv4IBq1AD87xJyAaaqJ
	 K6fJKho/SjzOENYSv9T83VMzKcw0Slic0y1zGAcXQ7RnAzIBjE5EtTVjkhEjApTOt5
	 rIefCMRrC9EIkmbMap/ymqDu9xIzyv+CtPjU3CYErCkMyqN66ittmNXGYSIZwsJMiw
	 nWa7wUuaLlnuh1xDSWvST8XcDcDPTh2vZrKIOW1dJCfPTq+sVcz6MWhzg4L2Hcyr+B
	 xy6MUpRvgGNRPyyZVFxAvesMlebKCMKEIOZBTdIflbEhkUjsmJLYQ6183l8wTVZSfC
	 4LxDSc+ubYJoueUSgVBuGwNwH+FcA9PmWsLw/O4VTQ75bEx07/p9tZazDSE0ztCH8S
	 r3C1yjXu/SF/yrZHQrDSupEdCes5NGj3Rp7ad+ChFZe+B/qtf5C5MTE6r5LY4Kl3lD
	 83u/sNOA0J+We0IO9kF6+mobFaRQewa7IdN7w9Y6MlSbjx9JaOTN9NssAWmZiynREH
	 dnmoh6m+l05NA6qzchGLTkSA=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A453C40E01A5;
	Fri,  5 Sep 2025 11:13:55 +0000 (UTC)
Date: Fri, 5 Sep 2025 13:13:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, chao.gao@intel.com,
	abusse@amazon.de
Subject: Re: [PATCH v5 3/7] x86/microcode/intel: Establish staging control
 logic
Message-ID: <20250905111349.GAaLrF7eWikC8BpiDK@fat_crate.local>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-4-chang.seok.bae@intel.com>
 <20250904121318.GKaLmCXlU4kwhsxG9h@fat_crate.local>
 <641f321d-4266-46c0-9383-d06bcb909529@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <641f321d-4266-46c0-9383-d06bcb909529@intel.com>

On Thu, Sep 04, 2025 at 05:04:24PM -0700, Chang S. Bae wrote:
> Okay, I think this 'MCU' looks a bit fuzzy. 

I mean we should try to sort them by MSR *number* so that they're easier to
find. I know, I know, the whole file needs sorting but we don't need the churn
right now. So let's put new ones where they should be, i.e.:

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6eb0c62c7fbd..87be1f815211 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -922,8 +922,6 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
-#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
-
 /* Intel SGX Launch Enclave Public Key Hash MSRs */
 #define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
 #define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
@@ -1219,6 +1217,8 @@
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
 
+#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
+
 /* Resctrl MSRs: */
 /* - Intel: */
 #define MSR_IA32_L3_QOS_CFG		0xc81

> The next two patches in this series introduce helpers that return an error
> code and *also* update this ucode_state. The latter could go away. Instead,
> the error code could be just down through here and decoded like:

You don't need the strings decoding... yet. This stuff is going to be looked
at only by us so there's no problem with simply dumping the errval and then
going to consult the sources where that value comes from.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

