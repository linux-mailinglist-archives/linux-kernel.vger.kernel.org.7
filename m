Return-Path: <linux-kernel+bounces-881793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25DC28EED
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 13:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10661188AA2C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B2524886A;
	Sun,  2 Nov 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fo2THDm0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B034D39C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762085394; cv=none; b=BWinPdswIbKFYPIa7+xTUf100gcZoMNzKAQkooufJQsNqOvN7Yawde2/7RCSPAJCRTygnh93WCG3by3vaxufifHrQwK3gYyJu/ddzP7rGjiEdfJGfdiT7XF4hAkX9vX6rfzdfAzMTdCWwPG8sATZy2gA2hg/zem1SMo5RuJy20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762085394; c=relaxed/simple;
	bh=kYY7U7pS3H03BMzTuVjOg6m+6/nYhcFlrgpd5Sjym7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl4Dv9Lp/qkwiABmqVBsjiYxKI5HSHFqEqINiqQ5otCoLVRs5hpslpxcTe/X4DNPdVkf8pZy/6ZUtdt6wOvbHKD/W17G+hSpGKnvHE/cLEPlNWclGMLZ+rui3oaE5wj+jl2CyFdo/DOH/xhB0SXdiqeuLFOCqRZU5NDnwJ0fwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fo2THDm0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CF35740E0191;
	Sun,  2 Nov 2025 12:09:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ua72yWXg4D3Z; Sun,  2 Nov 2025 12:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762085376; bh=x6Mx0hsZ3l/i6WLivy/Af6FUYZm5euxEpNmvS2outEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fo2THDm0+InRhoSpLXmOeBHRVfMz0XXNi77IQ5DMSFrSRkn+Ry2efDBmWJ7jBY8WT
	 n1UdqtCapPjvZhhsuKbIUwKuw0J/9nRw19ag/OaPvflP5fvaysIpfacKS4OllSo5it
	 TjqYnLABeA/pO2vbPR4iTCdAhdCnSrup/kEBD1GCQ7jMeZxSz75AkquVLoGAvZbTdv
	 SZOXSV13Njo6+LhF3JokaDDJaYrswSJI2TKD49wf3cRyxbrEwyOMZdD3FS25P7jCam
	 EfuftWJd7Y0GS6+vpkmpgS2Cjyv7O1oFqRDjQxb//rdL5E+oRuCjGqicBfqKWAsiaj
	 QNSgx7Loy1yqlmPElBfl6UIZ8pieFUZfVs2/MkL6wyzPnzzaLuaG/6ayDAZGHsKxVc
	 Vwsg/t0EDt9VhMRRyzLlmBKPUoxaE0QFr9Zzyjn5zFQO7FkDh2hF2GL1TswY7F9uvz
	 zpKCmCvZ98LjD/3Sf9GdjWQEvFCDhZwFGVzkEdJRXxivR1iSJ1ueIVS+ftMEBV9+gj
	 7n0cLL+luelDbxDad4hpsSde7TUFillwGeihoYmKRzXUFPEChFIG6bslY+VWo1raUD
	 LnPPKGCt7GuQzUOxD8iiuPgb48ZqS2DQFBbJPW3lZ22V6nZZoWAq1O7eun80wtZJl7
	 jCVJLhOzC4t8jAUWSwUOQkJo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1F61140E00DA;
	Sun,  2 Nov 2025 12:09:29 +0000 (UTC)
Date: Sun, 2 Nov 2025 13:09:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marc Herbert <marc.herbert@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/msr: add CPU_OUT_OF_SPEC taint name to
 "unrecognized" pr_warn(msg)
Message-ID: <20251102120922.GAaQdJ8noSCgyoTE2F@fat_crate.local>
References: <20251101-tainted-msr-v1-1-e00658ba04d4@linux.intel.com>
 <20251101100325.GAaQXa7UF-Ru2yqdI1@fat_crate.local>
 <m2bjll15q8.fsf@kvalverd-mobl1.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m2bjll15q8.fsf@kvalverd-mobl1.amr.corp.intel.com>

Hi,

On Sat, Nov 01, 2025 at 08:19:27PM -0700, Marc Herbert wrote:
> I just struggled to make sense of some unrelated crash logs and that's
> really all from my point of view. I mean all for now at least.

There's the answer to my question! :-)

>   pr_warn( "... (pid: %d), tainting CPU_OUT_OF_SPEC.\n",

Right, or simply "tainting kernel" suffices. Like other code does. So that you
can find the word "taint" in the logs and you know where it comes from. As
this is what you want.

> This patch is not "really necessary". Its purpose is only to save hours
> or even days for people trying to make sense of crash logs. In my ideal
> world, it should always be easy to tell "who tainted what when" from the
> logs without an corresponding expert and/or searching the source code.

Yap, makes sense.

> I admit this could harm job security ;-)

Yeah, although there are always other, more interesting things to hack on. :-)

So yeah, v2 with the agreed upon changes sounds good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

