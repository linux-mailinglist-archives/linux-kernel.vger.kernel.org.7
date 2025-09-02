Return-Path: <linux-kernel+bounces-795892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18696B3F907
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83E21889709
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3E2E92DE;
	Tue,  2 Sep 2025 08:46:24 +0000 (UTC)
Received: from torres.zugschlus.de (torres.zugschlus.de [81.169.166.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430DC26D4E5;
	Tue,  2 Sep 2025 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.169.166.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802784; cv=none; b=EhNHBv88KHYmkSGjCdawTHZlMp5toncj/KbLTHt/ITF6BSHy+2v398F8nTpLeM1FiTnJa8nU6BkUpZLsmyAkd5uxwrA2okvDI94dzRIAb20nXsKwf3GlVeyUtk+5yIDk0DRwOq3RKTdxT+dDbv5tGEZtwd894FW1Y/hmxLnG3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802784; c=relaxed/simple;
	bh=/r2PYX8AzH/Sk+8rMQN79jtRjPYZvl8PzfR8FRjrsEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7/2yEIcAhvotLUXFe7WHfpYPb1epfvwZHNxqsX7qQmw3MFfpPyq3PbuYV66k6xSXAEwc9FGebkmBUELAd4/6HbXTn4oxf0R1tkT/Hhh/htscz1azgoj4N0JvKI+mFI2lxeRcVP+6gousVNm+J1KOAva4cfE/I1hyhYSuohURtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=pass smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=81.169.166.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+debian-kernel@zugschlus.de>)
	id 1utMCD-0022mg-2L;
	Tue, 02 Sep 2025 10:16:53 +0200
Date: Tue, 2 Sep 2025 10:16:53 +0200
From: Marc Haber <mh+debian-kernel@zugschlus.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Marcos Del Sol Vives <marcos@orca.pet>,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH v2] x86: add hintable NOPs emulation
Message-ID: <aLan9S_47ERx69xO@torres.zugschlus.de>
References: <202508291620.bcfb3924-lkp@intel.com>
 <0ffa7c6e-f32f-4966-85df-3ee5f2426e9e@orca.pet>
 <33A549B7-B442-402C-A82C-862C0F509274@zytor.com>
 <51c25fb7-46be-4364-9371-6a7cb6b07625@orca.pet>
 <772C4DE8-8564-430D-9304-A39F88E07EBF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <772C4DE8-8564-430D-9304-A39F88E07EBF@zytor.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

Hello,

I am one of the maintainers of sudo in Debian. The submitter of this 
kernel patch has been lobbying for changes to sudo for a longer time, 
asking me to disable -fcf-protection in the Debian packages for i386.

I am reluctant do doing so because I don't want to disable a security 
feature for the complete distribution just because it doesn't work for a 
rather exotic CPU family, that - to my understanding but please correct 
me if I'm wrong - claims to be i686 but actually isn't.

On Mon, Sep 01, 2025 at 02:28:04PM -0700, H. Peter Anvin wrote:
>On September 1, 2025 4:43:15 AM PDT, Marcos Del Sol Vives <marcos@orca.pet> wrote:
>>I assume the kernel is currently simply ignoring the CET flag on ELF for
>>all 32-bit x86 binaries and libraries?
>>
>>Anyhow, seeing this is indeed becoming more tricky and error-prone, I'm
>>contating the sudo developer which is, so far, the only software that
>>has this issue.
>
>Yep.

So you're saying that -fcf-protection is basically a no-op on i386 and 
will never have an effect?

For me, as the maintainer of the Debian package, this is an academic 
question. The change that the submitter wants in Debian will not happen 
in Debian unless the technical committee overrides my decision. And 
Debian oldstable is the last release that had full support for the i386 
architecture anyway. We reduced i386 support to be a "partial 
architecture" in current stable, targeting that architecture for 
containers and multi-arch systems with an amd64 kernel.

Will -fcf-protection have an effect when an i386 sudo is being executed 
with a amd64 kernel?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

