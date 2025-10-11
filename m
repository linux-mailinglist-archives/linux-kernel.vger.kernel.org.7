Return-Path: <linux-kernel+bounces-849311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F422BCFCC3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 22:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C052A1899182
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE33C234963;
	Sat, 11 Oct 2025 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TOf9f4dJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629511A267
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760214685; cv=none; b=qmvli1z/6JoHKqc9ynnkXBAE8tU/4/Rf5Ocfdxod5K3w9A96Zm6b52ipnqLNklCGoYudnVe7yeqaPVlqwXE24oNUpZPBEQdBb3Z9duTXv12eEulQrX5EeYsGBzAquozRrepScHVmx6UA0WwIwijRcJrFembcVEWaybjMrHToc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760214685; c=relaxed/simple;
	bh=M/bK9ebOWAZJyTHuL/noBLXkszCxxdzm6Ql56u+fTvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDuKQvwNRYO4PHxWAfCDtV0mC3Un6oOa+t5JBVzOm4Um8ylfUvZi/oohEmyjYMUYp0AQO7PC8zBMUqH/2unXCGTXEDAv/ZIfYyx4EqXbyJKURV9NEOvDEsFGXZVJ/flLqyA/AoQZ20Ott5XsGvIreHVeWAThwak/upZrOZulNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TOf9f4dJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C0BA40E0194;
	Sat, 11 Oct 2025 20:31:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rMjn8NHSRgJ8; Sat, 11 Oct 2025 20:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760214673; bh=3X4ldvNVL+EYqRci/zsbXCnamdb8yjU+8V1O5cjy6n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOf9f4dJytIgx4QRZycmJK8lE6m5lVsjkf93+cFbA6AGt4CRGXNBd7IOk5MPpNQMt
	 sXmPnLEvrt0CyfnrZtd3ZvXJlWvFpsN46UwfVbT5KnJT7nESfKeCLbMXB6W4S3e2QO
	 FGNCCwyi5bcdSoatK01/FwMl/e5lOMoK0k/KTCWi1lv9/sPXrTtV4X+55xRMNktfOr
	 /hNwZcxAkWzMNcHPiM4ccOEcKSQDFBQt8R1CgNYIGYfYoEkcTtqowG+zd0c8Ksev2G
	 iMJhCEG7rbMsXyNpaTFivAUZgykbNyeEfadRLHdp5EdI88ftP0kaTJpCXbbN0WW2m8
	 0kwqyG1SlGDqT4PQJ+GoYq4z/X7MQNuzQXvAhuWotUPmf4eSVWHhxwJmI7s1fyIb2U
	 PVh3VmA3olWlG52iWelaPI2Wv3ViLT1FuNDflKQO4c+k/CQXMq1+VR53hqUxVXztIe
	 YmWCG3Z0KvTM9k+Muounll8hdT6ByPACt6p2+QlqqtKLJNjKaa8clsP0Jfr7f2+dcO
	 J1KJd9/l9ChDbKtIK4OBAwuZXZCtHNKFSQOSkMqzdkYYkKg1rlXBI4dRFLlM3om+03
	 U2N9HiTDBBuPR5B5WoFnNIc5N/IY7XUah0XHhj4R66A4HW07aYdX/AfmeX/4jFprkz
	 XJyXYGl9QGGgDQDTnWVm6b1A=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7D84740E00DA;
	Sat, 11 Oct 2025 20:31:08 +0000 (UTC)
Date: Sat, 11 Oct 2025 22:30:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [GIT PULL] x86/core for v6.18-rc1
Message-ID: <20251011203055.GBaOq-fzP_3_FNdZRh@fat_crate.local>
References: <20251011134629.GAaOpftWmLdD6L7bJn@fat_crate.local>
 <20251011174334.GA2929946@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251011174334.GA2929946@ax162>

On Sat, Oct 11, 2025 at 10:43:34AM -0700, Nathan Chancellor wrote:
> Please do not forget about this semantic conflict during the merge.
> 
> https://lore.kernel.org/20251003221030.GA1162775@ax162/

Whoops, thanks for paying attention.

Looks like Linus has fixed it up properly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

