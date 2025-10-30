Return-Path: <linux-kernel+bounces-878566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 046CEC21021
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8245E3495AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0431DF269;
	Thu, 30 Oct 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ietJRIs4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE0273F9;
	Thu, 30 Oct 2025 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839160; cv=none; b=oSP0AeUwXdLQSYYS8Oh9o0u9W5+fCaBivd3OJEBsjUQqCSJ6D4RpNc4R/s6jCJL7i+vHEQhkS9fGa7JX6UW/rXFgGGKcpdP/yRB+QO/RCHOvv449cEx8C2IB0febqJk/yl6cj4VosJbbwHEQAfW+OjtQzdBAuj+GWxxNL9zeUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839160; c=relaxed/simple;
	bh=X9A9UOq2+Mjl0OTqSj4t+zupFy+/0ENRDEvOvmYBfa8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CXwufirOlTbLh5Ik/WS98r0zP6C/rXqx2PKIQ5pWrH6Hy7OanaYrowoEyWFbweNpaL6by+J7OMyfv5diRuhXaNE9c25YmMJ/G0uHeHjiunYZPTf3/dX/kbuZ3iIFskObfEPYei998N2lTYN7sP+TLSWb+Powp5RD/3i5EVzhjcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ietJRIs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B1AC4CEF1;
	Thu, 30 Oct 2025 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761839159;
	bh=X9A9UOq2+Mjl0OTqSj4t+zupFy+/0ENRDEvOvmYBfa8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ietJRIs4/9M/dBdm553Q2EdRXkUeOxjon3bD3uoGV1h+lDzJ/Eew400t7bPy/VEKM
	 XkDy1OcUzcChm1wOIrhzkSQOmX+54VZpcabGp9jLgO4chRiSeJYM0YkU7wWChmGKDM
	 5So6r2y4Hz8LgXnECiKjS6bZ0peOSlm13VD5Clrs7BA5TeyHmQQ3K89B1Y+450BOQB
	 SiEHSTgmCJAH+XxF5WptVANMnd+mhEiFd3lu8P/ZkX1AnJ1uEu4lWP+dJwY27I88ej
	 P1h2D5hOXpvPsLRlefkni7aEK8sHGG7tBAGYDGKPMi6ehsUTi1h5NUI1tA+FiJ4mpP
	 gxk8r+kWV1Cmw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BC017F40069;
	Thu, 30 Oct 2025 11:45:57 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 11:45:57 -0400
X-ME-Sender: <xms:NYgDaVbGnPYFDw5WmrZzXcw2pU8_NlU4iRX-cIhiZLlOidiMxuk8Hw>
    <xme:NYgDaXOKyCF9OWG91q8pYOUR4tzMEccuXg42AQUMyPRMZ_5-5m0TZgHvm32NiZ6-a
    JCba3gCAJrj6oLyOxasNGCbu2-gsmSRiXEnDfrTEUb9MgUWRCeCItSR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeejvddvtdehffdtgfejjeefgefgjeeggfeuteeiuedvtefgfffhvdej
    iefguedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhspdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepugifmhifsegrmhgrii
    honhdrtghordhukhdprhgtphhtthhopegrnhgurhgvfidrtghoohhpvghrfeestghithhr
    ihigrdgtohhmpdhrtghpthhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrughu
    nhhlrghpsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprhhitghkrdhprdgvug
    hgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhohhhilhdrmhgvhhht
    rgesihhnthgvlhdrtghomhdprhgtphhtthhopehtohhnhidrlhhutghksehinhhtvghlrd
    gtohhm
X-ME-Proxy: <xmx:NYgDaUrYTFt0wKRce5X9JeuL7scBmuByDkyBHx2PdvqO9IrkhnCQGQ>
    <xmx:NYgDaTAsh-Tr9V7fhJlEVm-PkKFo5NumPw1PzfSTTAu4CdKoGJAVfg>
    <xmx:NYgDabZIRUbW9uTtbLpGL413NTCTpArlj0H5nJr6TzZ1VvG238DgpA>
    <xmx:NYgDaTur-feDqaLSYutWQC1Ntc-ZFy5Rj1oBy1MhwdqwYU1H2B_7kQ>
    <xmx:NYgDaV9TWjPmXSJ_IMz5WtjVkkze_vYAgGef8R_-agqQWyWRiH_EzvkI>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7AE57700054; Thu, 30 Oct 2025 11:45:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuvVN0AAjWd7
Date: Thu, 30 Oct 2025 08:45:34 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Kirill A . Shutemov" <kas@kernel.org>,
 "Xin Li" <xin@zytor.com>, "David Woodhouse" <dwmw@amazon.co.uk>,
 "Sean Christopherson" <seanjc@google.com>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Vegard Nossum" <vegard.nossum@oracle.com>,
 "Andrew Cooper" <andrew.cooper3@citrix.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Kees Cook" <kees@kernel.org>,
 "Tony Luck" <tony.luck@intel.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 linux-doc@vger.kernel.org,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-efi@vger.kernel.org
Message-Id: <13681100-ddc3-4ef0-bd13-744282324ff1@app.fastmail.com>
In-Reply-To: <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-10-sohil.mehta@intel.com>
 <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU initialization
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Oct 30, 2025, at 1:40 AM, H. Peter Anvin wrote:
> On October 29, 2025 2:03:10 PM PDT, Sohil Mehta <sohil.mehta@intel.com=
> wrote:
>>Linear Address Space Separation (LASS) mitigates a class of side-chann=
el
>>attacks that rely on speculative access across the user/kernel boundar=
y.
>>
>>Enable LASS by default if the platform supports it. While at it, remove
>>the comment above the SMAP/SMEP/UMIP/LASS setup instead of updating it,
>>as the whole sequence is quite self-explanatory.
>>
>>The legacy vsyscall page is mapped at 0xffffffffff60?000. Prior to LAS=
S,
>>vsyscall page accesses would always generate a #PF. The kernel emulates
>>the accesses in the #PF handler and returns the appropriate values to
>>userspace.
>>
>>With LASS, these accesses are intercepted before the paging structures
>>are traversed triggering a #GP instead of a #PF. To avoid breaking user
>>applications, equivalent emulation support is required in the #GP
>>handler. However, the #GP provides limited error information compared =
to
>>the #PF, making the emulation more complex.
>>
>>For now, keep it simple and disable LASS if vsyscall emulation is
>>compiled in. This restricts LASS usability to newer environments where
>>legacy vsyscalls are absolutely not needed. In future, LASS support can
>>be expanded by enhancing the #GP handler.
>>
>>Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>>---
>>v11:
>> - Disable LASS if vsyscall emulation support is compiled in.
>> - Drop Rick's review tag because of the new changes.
>>
>>v10
>> - No change.
>>---
>> arch/x86/kernel/cpu/common.c | 21 ++++++++++++++++++++-
>> 1 file changed, 20 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common=
.c
>>index c7d3512914ca..71e89859dfb4 100644
>>--- a/arch/x86/kernel/cpu/common.c
>>+++ b/arch/x86/kernel/cpu/common.c
>>@@ -401,6 +401,25 @@ static __always_inline void setup_umip(struct cpu=
info_x86 *c)
>> 	cr4_clear_bits(X86_CR4_UMIP);
>> }
>>=20
>>+static __always_inline void setup_lass(struct cpuinfo_x86 *c)
>>+{
>>+	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
>>+		/*
>>+		 * Legacy vsyscall page access causes a #GP when LASS is
>>+		 * active. However, vsyscall emulation isn't supported
>>+		 * with #GP. To avoid breaking userspace, disable LASS
>>+		 * if the emulation code is compiled in.
>>+		 */
>>+		if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION)) {
>>+			pr_info_once("x86/cpu: Disabling LASS due to CONFIG_X86_VSYSCALL_E=
MULATION=3Dy\n");
>>+			setup_clear_cpu_cap(X86_FEATURE_LASS);
>>+			return;
>>+		}
>>+
>>+		cr4_set_bits(X86_CR4_LASS);
>>+	}
>>+}
>>+
>> /* These bits should not change their value after CPU init is finishe=
d. */
>> static const unsigned long cr4_pinned_mask =3D X86_CR4_SMEP | X86_CR4=
_SMAP | X86_CR4_UMIP |
>> 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
>>@@ -2011,10 +2030,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>> 	/* Disable the PN if appropriate */
>> 	squash_the_stupid_serial_number(c);
>>=20
>>-	/* Set up SMEP/SMAP/UMIP */
>> 	setup_smep(c);
>> 	setup_smap(c);
>> 	setup_umip(c);
>>+	setup_lass(c);
>>=20
>> 	/* Enable FSGSBASE instructions if available. */
>> 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
>
> Legacy vsyscalls have been obsolete for how long now?


A looooong time.

I would suggest defaulting LASS to on and *maybe* decoding just enough t=
o log, once per boot, that a legacy vsyscall may have been attempted. It=
=E2=80=99s too bad that #GP doesn=E2=80=99t report the faulting address.

=E2=80=94Andy

