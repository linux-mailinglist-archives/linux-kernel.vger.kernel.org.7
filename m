Return-Path: <linux-kernel+bounces-782570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131DCB32242
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAE56400C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76A2BEC5A;
	Fri, 22 Aug 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ey0WUtmv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778CB2472A5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755887117; cv=none; b=H4gIGP1R1Rf+4xLyJH/k1i/cSfYq5lww7taYWw6FPyRDXhXa9s3RwMevrZZL8Ub5XJSzmAWjVb4/KCQh6z7uZk1VgHFaqn+EulvHg1NQ8fmBCIDKQcOH4fmrayD4yYy1Yx478QN9MtoiZddJcu2Icbkl5/+JvgAGdsIOyQ2Cipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755887117; c=relaxed/simple;
	bh=cbKmKy0iBHpTRbJzwtSbOiVWO9oG07TiQMQIO8wr9Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUhGAhWAB7mfFswLsRrVGQ9EO9KG91zzniXtgQfAlkm0tF4I9O+tUk11DRXqf2JVdOzDjK+69Z7EC6GPWanodA7XSl4bUPmdZSJI2ZzAAgQyQ5lzlRZMW3+GsG/BT+//R+cB6fKPERpzc8yuuO4JChN4kFowjazZq1AgYUWFopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ey0WUtmv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C66A140E0286;
	Fri, 22 Aug 2025 18:25:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EL-by-ElyA08; Fri, 22 Aug 2025 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755887107; bh=5acX+7mTcLOk+sQMe4lTifi6Z5g903V4QSU1hTxOLUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ey0WUtmvAyK6lGGZFWCx0R0lsk6m7ZqXm9Sif4dX/NC0DyoZ7mS0WAsGhiSVXcjF6
	 jUS5K+gzUdp8nbNO7Lgk3fn8Dtb8N9MCK5muc71HrHi3R6BxaI6TT4/ZS/7Vbz24C7
	 kyh04e56sEmkCAd5jvG3e3P5uYzKvvV14FGNwqllsLuMYCTOWi1nfakCvCZlqd23oW
	 Dgg223DCju4XNDF/Mjhs5ibbkVMUxm64sy2zCJwwfrpM02ScuGVxrzd9jL+86LB95I
	 oS1I3OiQ2vAcu3Gx1k4/5+8RBxNLZcv/IgRhhiXCfBLoUax+7lJyYuODyTyK7KGWxG
	 Y8TujESieuJb8hMT+8isxC0+7hThhcxcSjgWfxcRFk+J/seHtNgjYTMltaRB3acSx0
	 TgfNUmomVNdnLUOh20Ctr6Ew6B7rRm+vRgEZ5a1x7u02yTfOsxhcfEmdNZS4QYahVj
	 8kuW3/o31NFzICuwvQVC/0oDjcB2XVY8FIvhvn4Z+J6yEJW3U7AiG0QQrIES4a0YDr
	 C6H+n7cFpnu5Mv8fa/p5xEJ5lrSoJUeQp3n6ruyUaBcRhZll8n1pLxlZlwmeExTgfn
	 Lm3umI7xmAjH3jYOkAihy7jPDxC+SuwmctId3Bkz9A0jwtXjBlewsDNeCWPYk7iXos
	 A935OIOcpU20OzGG0KeaGXCQ=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98BDA40E016D;
	Fri, 22 Aug 2025 18:24:54 +0000 (UTC)
Date: Fri, 22 Aug 2025 20:24:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/x86/intel: Add a script to update the minimum
 ucode revisions
Message-ID: <20250822182447.GHaKi176wVuSsNMmi4@fat_crate.local>
References: <20250822004422.2908427-1-sohil.mehta@intel.com>
 <20250822100949.GAaKhB7ZlYxjpfcIit@fat_crate.local>
 <aaed72a9-8dc8-4744-96ae-ac3db9fb4d01@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaed72a9-8dc8-4744-96ae-ac3db9fb4d01@intel.com>

On Fri, Aug 22, 2025 at 11:03:10AM -0700, Sohil Mehta wrote:
> Currently, we have a static list of microcode revisions that determine
> old_microcode. So, it needs to be periodically updated as and when new
> microcode releases are made.

Who is expected to do that and when?

> Also, some folks might want to have a custom enforcement of the minimum
> microcode revisions (be it stricter or relaxed).

I don't understand how that relates to the script.

> The script makes it easier to update intel-ucode-defs.h by generating
> output in the specific format it needs. Having this live in the kernel
> makes it easier to find whenever needed

What?! -ENOPARSE.

> and also be in sync with the header format if it ever changes.

I have a big problem with people being able to willy-nilly update this header
and then things starting to fail because someone updated the header but it was
wrong and then we have to go debug that too.

Update to the header needs to happen in very controlled manner, when you have
released tested microcode and have decided to deprecate old microcode.

Not just lightheartedly shoot out a new header version out because shit got
updated somewhere.

So, actually, this script should NOT be in the kernel but in some repo
internal in Intel.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

