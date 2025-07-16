Return-Path: <linux-kernel+bounces-733605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A1B076D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC04D584B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095631A8F6D;
	Wed, 16 Jul 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HvrrFjzl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097B1A5B9E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672359; cv=none; b=E3lSKkWP5aQLoT1igg6NB/5PLk63EdC14L+tmlud8vufUDLhSC/9A8SClOREZsi9diuHIWaYyEhTaLJmAzy2zofXaIzhMzW0sY4pxInohR4ulDAVO6tekYsPfO6gIbXpv7h56PJ0U5jWd0CrmsWV1KayPrT/Z2zFzVSJP5Rn3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672359; c=relaxed/simple;
	bh=0+zCImxReXOlCaZt5r9WsCGwm5+umUGVWUe3YxjQOU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz8iIf0Xw61NyXbZFETvyLJ8v3cRs9jtZQik9RaYHa0zvebktwV8tLVCIAlW5gtTuO5qRa+6w5/B2eCTay9dg1srtCuGtQhNYiudkTvqKZil3FGxzN8dC6LkGmaNRV0+aDRO3zej6VvweTYT/bS09OVtsGdJnURR9yqH1PDJGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HvrrFjzl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7D20940E0217;
	Wed, 16 Jul 2025 13:25:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 30ul8XKi027v; Wed, 16 Jul 2025 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752672350; bh=3CHBYx1Td1VVwAhblA81o/vMGhCuwmhfT1cbjZ6pKfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvrrFjzlXAFsz+UpQOZuNR3WTCXy1AgzeGCfjM999j7WxZy1i+xOiWCjH7XmhIx8o
	 Rxv0o/DdztqzBsCKiqW/DK1albQhpjv+NPN79f0ftQwdZ93xWT0ON8XxAHOawmWqel
	 Ff0F6F6asWyYThD19UlFfaSvsh+IF+plEs67BKBh6tYSW2FFqDK5paomc6njzXzhnd
	 e1GEdHf1gT71Qu5l82bVkK6fxnneZhSDCfMdy6jP7pS/OHQR4VaWV06Pq6CKyJEPgQ
	 gLAjXjSUlhx9MxlRkv6z1WV5tvxaasJGD8hD5aJheEWn1KpCAPqyQmjL9pPx8KKplD
	 bkgn9c1HYvKMJZdhj5nlJhj4cqjsp36A6yZJ8S8cHdtM83YgYINKoIOiyGTNjT4K4c
	 NruEvDkGnOcAsaU86UKxmwjyPO+un58Hl3QUVJgeZQtXak9L9SCk6GUKfzy19orJsL
	 M3dnsg3zMhjef7VMcrkfqdh6yQr9FLZuxLM/m1idho2VtU2JfyN5NateEfu1wLXfRB
	 c9E1/Y1b0/CX9QA/yyowsN2/14JedlJPWeRHzKGBEj2LniLh6lTdaxuvTKPAGf7Pep
	 ZaMofg6FM4gpTs4/KzpKEOAPvUDA18i6/c7m1AbTFGJKUsEZYLPGrSYTQ6wI8hSz77
	 WOej4Tbll0GlDtaZHIXrR12M=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E819B40E01FC;
	Wed, 16 Jul 2025 13:25:38 +0000 (UTC)
Date: Wed, 16 Jul 2025 15:27:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Khalid Ali <khaliidcaliy@gmail.com>
Cc: andrew.cooper3@citrix.com, ardb@kernel.org, brgerst@gmail.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	ubizjak@gmail.com, x86@kernel.org
Subject: Re: [PATCH v3] x86/boot: Avoid writing to cr4 twice in startup_64()
Message-ID: <20250716132735.GAaHeox8nvd00imsIV@renoirsky.local>
References: <20250716014504.GAaHcEIIUgNOdu_n2s@fat_crate.local>
 <20250716090755.668-1-khaliidcaliy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716090755.668-1-khaliidcaliy@gmail.com>

On Wed, Jul 16, 2025 at 09:07:20AM +0000, Khalid Ali wrote:
> I think the comment is misplaced. It is better if we move starting from "from the SDM"
> to below the endif. The second move the comment above it isn't useful also everyone knows 
> what PGE bit does, so it is better if we replace with the above misplaced comment.

The comment's fine. The %cr4 writes need a comment explaining what
they do because their sequence is special.

I don't mind documenting non-obvious asm in a more detailed fashion.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

