Return-Path: <linux-kernel+bounces-811650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB66DB52C16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334F016FCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9DE2E7647;
	Thu, 11 Sep 2025 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKiVFuVz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="frCjNW5L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKiVFuVz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="frCjNW5L"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67072E718E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580317; cv=none; b=SWSz/cvwMF4YA0oOi36oLSH7kKBexTTRm7TnOig5R7lDTZBiowbIoOcRDGW3oystV8AD2dcM9fxhpvpmMITOBTXXUmhOIjq2qm9UfpmsqeGuuGcmPXik8269ItvrVHnnPe0nlnEnl9xl03rColoGejUfg8Suu2NKYiwN9J+T49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580317; c=relaxed/simple;
	bh=ZQIJIOP5IaFNP+FW+nqdBwFuwdPyRVPSvu2e6eR4fcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLCUctZkqbYIb3lBM8zmjD7JmmRJG2lRBPupqkM8sUFGe/IHUfd7DgWx75bOST2K4hGKAGd9nycXFCwhFWVNJ+11p/S7Of/hgElhLwYZLV0ORTTeXEPThPqccHPT2W/iAbJtKUTvTNVLJLitqVBkj1Y28YOHoJ9yypes5AD7fJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kKiVFuVz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=frCjNW5L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kKiVFuVz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=frCjNW5L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2223268672;
	Thu, 11 Sep 2025 08:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757580312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ry8cOkx2zIlc+wzBeJkoq6Du2FeV1h0pV2EEvMd6IT0=;
	b=kKiVFuVzB2MFbKNbBxuMO/vdrJXFFEgaNcBH2B46AGhSVHk2/ZnKWIf69HLa5IGMUjp69C
	XEzZMfv70JELhdn6BT1bCtpqEEqfjlrkexP5uj/eBTJgM+bersPdjPeF2eswgeGUcXVMZl
	Ie0QRoLgf3jfIRXx4chmQ17+PtMfwqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757580312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ry8cOkx2zIlc+wzBeJkoq6Du2FeV1h0pV2EEvMd6IT0=;
	b=frCjNW5LAXoegNDf3SQAYBIHJxfHVfoJlpDY7dN+SbqS0SRxmsSTxM2NmRgK+Nwmdf3EdP
	pwXBRCcvu4VqKIDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757580312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ry8cOkx2zIlc+wzBeJkoq6Du2FeV1h0pV2EEvMd6IT0=;
	b=kKiVFuVzB2MFbKNbBxuMO/vdrJXFFEgaNcBH2B46AGhSVHk2/ZnKWIf69HLa5IGMUjp69C
	XEzZMfv70JELhdn6BT1bCtpqEEqfjlrkexP5uj/eBTJgM+bersPdjPeF2eswgeGUcXVMZl
	Ie0QRoLgf3jfIRXx4chmQ17+PtMfwqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757580312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ry8cOkx2zIlc+wzBeJkoq6Du2FeV1h0pV2EEvMd6IT0=;
	b=frCjNW5LAXoegNDf3SQAYBIHJxfHVfoJlpDY7dN+SbqS0SRxmsSTxM2NmRgK+Nwmdf3EdP
	pwXBRCcvu4VqKIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA5C1372E;
	Thu, 11 Sep 2025 08:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /wxjOReMwmiedQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Sep 2025 08:45:11 +0000
Message-ID: <fa727f7b-92d5-4fd2-b9cf-a19b27303a22@suse.cz>
Date: Thu, 11 Sep 2025 10:45:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250911: mm/slub.c:3960:27: error: a function declaration
 without a prototype is deprecated in all versions of C void
 flush_all_rcu_sheaves()
Content-Language: en-US
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 clang-built-linux <llvm@lists.linux.dev>, linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Ben Copeland <benjamin.copeland@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYtUi3bnZ2zycCot6KGeZcn67JAvz=wZm=6f2w9ZnL=0Uw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+G9fYtUi3bnZ2zycCot6KGeZcn67JAvz=wZm=6f2w9ZnL=0Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:url,linaro.org:email,suse.cz:mid,tuxsuite.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 9/11/25 10:37, Naresh Kamboju wrote:
> The following build warnings / errors noticed on aram arm64 defconfig
> with clang-20 and clang-nightly toolchains on the Linux next-20250911 tag.
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> Build regression: next-20250911: mm/slub.c:3960:27: error: a function
> declaration without a prototype is deprecated in all versions of C
> void flush_all_rcu_sheaves()
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build log
> mm/slub.c:3960:27: error: a function declaration without a prototype
> is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>  3960 | void flush_all_rcu_sheaves()
>       |                           ^
>       |                            void
> 1 error generated.

Thanks, fixed already for tomorrow's -next
> ## Source
> * Kernel version: 6.17.0-rc5
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: 6.17.0-rc5-next-20250911
> * Git commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
> * Architectures: arm, arm64, i386,  mips, powerpc, riscv, s390
> * Toolchains: clang-20 and clang-nightly
> * clang: Debian clang version 20.1.8
> (++20250809043815+87f0227cb601-1~exp1~20250809163919.3)
> * Kconfigs: defconfig+lkftconfigs
> 
> ## Build
> * Build log: https://qa-reports.linaro.org/api/testruns/29853978/log_file/
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250911/build/clang-20-defconfig/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32XlFDtH7RdddaA6FHskupLDDSO
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32XlFDtH7RdddaA6FHskupLDDSO/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/32XlFDtH7RdddaA6FHskupLDDSO/config
> * Build log details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250911/log-parser-build-clang/clang-compiler-mm_slub_c-error-a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-c/
> 
> --
> Linaro LKFT
> 


