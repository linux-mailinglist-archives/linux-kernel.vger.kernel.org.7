Return-Path: <linux-kernel+bounces-773393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05769B29F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E34F74E1734
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907242765C1;
	Mon, 18 Aug 2025 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XNrfVQ/R"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F12C236C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513561; cv=none; b=ntQf3vhEpNLS0CQBkaglsIbN4a+xeaGlxhzVx32FYVwKWwScis8TzY1RyauDAa9f0lR2KnfO7E5cSWJvv2EU8/8MILmMgpnq71vk/ApKVddSfXrKgBcaADLbiX4Z2d+PCgiPJvQVloANcSnb3cjt7tHLleULPGbiLurx1hm/jIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513561; c=relaxed/simple;
	bh=4lurvmTL/vxhyC7uZfzIjOlPkzZ0y3mYQVgtrBNm/xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq8ze4NQWPV0cVdJhLFF2RZH7vvE80Mu5gkUKGkt+Sh/LZvPXp2PfGdXO38zvE31S1KcJPdIxVPbuPuN7a8NosI30VTX4Q7n3bj32Cxg5wfszNL6VaZ9+6jVCg804oGAcXn4ZS3bRXFHImss2h0U4zF4/ANJj2Y5e0Odd+yX6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XNrfVQ/R reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 097E740E023B;
	Mon, 18 Aug 2025 10:39:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7wpdnpPmb79X; Mon, 18 Aug 2025 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755513552; bh=1Levj26XMA+D8akUdtEC9aHEIt3U3memk+4H+vzIoNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNrfVQ/ROV2+WquOtBFj+p0ryv3mVsTb9lqyNLsFpS/hW1t2fgq+/xDhpr1C4X7r+
	 RZQzLDihwCsRgu+MatpSd4Nmzpiufh5CsPdcSPsAzwUgRUAeksOE5xXo8kgm3WB0Rn
	 2KmyC8e+/BwxYOt77CvngHjETTZREEyhwyDXfnZNAJ5/J247gog1rqmyWgXOcQUb7r
	 SdWqQW+NaOVN7jhmxP6JBvhGo6CHFCAAbT+hlJrrBQL2lWvmn+7xOFu6v686/x53F6
	 Qbo3ErMdgnQCbl155T9mk1Fkj2e0FawgGRmhfjtawBJxj/3eYjNUTMyg/gBAglrvzP
	 hcBhlmUtgMpsdVkV8G9iRJAMjGz3VW+HdLX/4/5ZMN5YfXetempCd4ue9fbmjybbel
	 liK7ASzT8Eki9LdAEHSGmx3rrv/CYh2zGkbGSUSnbHPoWbXQhz49SFYG+cOfNUjCjC
	 Okitd1nIvS/DhWmhBqYGg+en3HMakyfEZup3tvS1OuiqvnM6yXPzaiKNaNJnFrfzVw
	 BacIaUkdjET2VAD28dTPO+GjicUHee0/BvpVWmm76d2YD30Fw0iU/E7z0biNqzgWTa
	 xc8lNprNLksv3ID4/Y6WQztwHWwcS6oAyMKPkC1ai8MsKvwU079ib0ODaa0KvDEGnO
	 TjPIzWVHlpBysugO9bQvcx6M=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7FA840E0232;
	Mon, 18 Aug 2025 10:38:59 +0000 (UTC)
Date: Mon, 18 Aug 2025 12:38:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	linux-kernel@vger.kernel.org, Konstantin Belousov <kib@kib.kiev.ua>,
	John Baldwin <jhb@freebsd.org>,
	"<cperciva@tarsnap.com>" <cperciva@tarsnap.com>
Subject: Re: [PATCH v4] x86/bhyve: Detect FreeBSD Bhyve hypervisor
Message-ID: <20250818103853.GEaKMCvbtnA3J197yP@fat_crate.local>
References: <03802f6f7f5b5cf8c5e8adfe123c397ca8e21093.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03802f6f7f5b5cf8c5e8adfe123c397ca8e21093.camel@infradead.org>
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 11:06:32AM +0100, David Woodhouse wrote:
> +static uint32_t bhyve_features(void)
> +{
> +	if (bhyve_cpuid_max < bhyve_cpuid_base | CPUID_BHYVE_FEATURES)

Forgot those parentheses again:

arch/x86/kernel/cpu/bhyve.c: In function =E2=80=98bhyve_features=E2=80=99=
:
arch/x86/kernel/cpu/bhyve.c:42:29: warning: suggest parentheses around co=
mparison in operand of =E2=80=98|=E2=80=99 [-Wparentheses]
   42 |         if (bhyve_cpuid_max < bhyve_cpuid_base | CPUID_BHYVE_FEAT=
URES)
      |

Tztztz.

:-P

I did the below. Ok?

static uint32_t bhyve_features(void)
{
        unsigned int cpuid_leaf =3D bhyve_cpuid_base | CPUID_BHYVE_FEATUR=
ES;

        if (bhyve_cpuid_max < cpuid_leaf)
                return 0;

        return cpuid_eax(cpuid_leaf);
}

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

