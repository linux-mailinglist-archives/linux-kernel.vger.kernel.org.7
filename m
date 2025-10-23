Return-Path: <linux-kernel+bounces-867699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2CC034ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96F334F645D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149BD34B664;
	Thu, 23 Oct 2025 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZcO4Injm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R+iqC5+F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qKV61hF2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xm/iPv/T"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20992C21EA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249765; cv=none; b=qj3iKmIcL1KpKw23qc4CNvR/eXSfaZzaFBAXB0QD3Z6JC3ZfJB9lmaH3zYwKPiPNm3Ma6FmYZ/ZHMz6aoPH6XJA7rR7f1dTEHHKDdGSW4QUyA1b/YcdPOBfyGFnsKCUFJvjJcGyjTUJnuH8s0Stn3P/mAXhTzMJJqO/tejDWnMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249765; c=relaxed/simple;
	bh=LulGrsvuQHHRUckW5n9m0iIQV7lVfYvpx4KBlcjJZoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZgbIlmm7nG3dbkqHihDQFSUgoGOHB0J0rA3kCKn5YriiHEtgvJotr0UorDC0v7gZs5GagOaLsPDQYcCWKa2h8OYafyvEO9e97idMAitR2hzL3sk8EPZcYxBhQxlq7bcGzPp++vT/KLPVklKZP8iLLphh26k4cP0K9vTftD4E5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZcO4Injm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R+iqC5+F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qKV61hF2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xm/iPv/T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2073211C8;
	Thu, 23 Oct 2025 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761249756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4JDNZhRiPwyWEYFhKSyRh4BLLaCKF97jtf+7yMjZR4=;
	b=ZcO4InjmOJYb7+pJOgxVbEblkxS1VHeM/GdoDbhiXh4BKse+ts+lijr8S2yHdv9D+GtkQB
	fRDocDi2bcH1IKNn0W1Du1S1oJWDfV0cHSIFhlLwyJT7ZNpOTcLeMsbyTMLSEUdTL4KmGj
	Q6mT7oq5tqZ+HHvMaLu6XHL8wlcQqg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761249756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4JDNZhRiPwyWEYFhKSyRh4BLLaCKF97jtf+7yMjZR4=;
	b=R+iqC5+F5JRiOVdme1BnKWItT+UbVpTrog5loP1kTp84jIxdpMBozQrDJViX4xQDqrAsWc
	g+keTx6PaQpK7TAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qKV61hF2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="xm/iPv/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761249752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4JDNZhRiPwyWEYFhKSyRh4BLLaCKF97jtf+7yMjZR4=;
	b=qKV61hF2EmCTw58oGSViB9Mp42S7eJoHfRghZgni6LGuabFjcm8n9MFhQ01DEK6B2vxGsl
	c44xT2j5QDI4l7n6/YVj7DxYeNq+OY0nRiocE1wWzzAVoBCcJ326BfwlAi8b1cwdmeRn8B
	C2hjOENL4y93A4g73CmymZJkUo3Aed0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761249752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4JDNZhRiPwyWEYFhKSyRh4BLLaCKF97jtf+7yMjZR4=;
	b=xm/iPv/TMIYR9IZjlFhdxqOzO9ZKjnTSc/ayyIQ7/upn0y5ZCor5n0H8k52q9Up46O1J+p
	rhsO661BlUsSV+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5B58139D2;
	Thu, 23 Oct 2025 20:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ihVMJ9iJ+mgDHwAAD6G6ig
	(envelope-from <akumar@suse.de>); Thu, 23 Oct 2025 20:02:32 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it, Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: arnd@kernel.org, brauner@kernel.org, jack@suse.cz,
 regressions@lists.linux.dev, arnd@arndb.de, linux-kernel@vger.kernel.org,
 lkft-triage@lists.linaro.org, viro@zeniv.linux.org.uk,
 benjamin.copeland@linaro.org, linux-fsdevel@vger.kernel.org,
 aalbersh@kernel.org, lkft@linaro.org, dan.carpenter@linaro.org
Subject:
 Re: [LTP] [PATCH v2] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid
 errors
Date: Thu, 23 Oct 2025 22:02:32 +0200
Message-ID: <12786420.O9o76ZdvQC@thinkpad>
In-Reply-To: <20251023164401.302967-1-naresh.kamboju@linaro.org>
References: <20251023164401.302967-1-naresh.kamboju@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D2073211C8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

Hi,


On Thursday, October 23, 2025 6:44:01 PM CEST Naresh Kamboju wrote:
> Newer kernels (since ~v6.18-rc1) return ENOTTY instead of EINVAL when
> invoking ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid). Update the
> test to accept both EINVAL and ENOTTY as valid errors to ensure
> compatibility across different kernel versions.
> 
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Tested-by: Avinesh Kumar <akumar@suse.de>
Reviewed-by: Avinesh Kumar <akumar@suse.de>

Regards,
Avinesh

> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> index d20c6f074..744f7def4 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> @@ -4,8 +4,8 @@
>   */
>  
>  /*\
> - * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
> - * happens when:
> + * Verify that ioctl() raises an EINVAL or ENOTTY (since ~v6.18-rc1) error when
> + * PIDFD_GET_INFO is used. This happens when:
>   *
>   * - info parameter is NULL
>   * - info parameter is providing the wrong size
> @@ -14,6 +14,7 @@
>  #include "tst_test.h"
>  #include "lapi/pidfd.h"
>  #include "lapi/sched.h"
> +#include <errno.h>
>  #include "ioctl_pidfd.h"
>  
>  struct pidfd_info_invalid {
> @@ -43,7 +44,12 @@ static void run(void)
>  		exit(0);
>  
>  	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
> -	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
> +
> +	/* Expect ioctl to fail; accept either EINVAL or ENOTTY (~v6.18-rc1) */
> +	int exp_errnos[] = {EINVAL, ENOTTY};
> +
> +	TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid),
> +			exp_errnos, ARRAY_SIZE(exp_errnos));
>  
>  	SAFE_CLOSE(pidfd);
>  }
> 





