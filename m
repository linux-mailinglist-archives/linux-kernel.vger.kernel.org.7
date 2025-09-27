Return-Path: <linux-kernel+bounces-835094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A968CBA63DB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAEA4A0763
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93923909F;
	Sat, 27 Sep 2025 22:13:59 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9328371
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759011239; cv=none; b=eFAKKPl7X7ozPURLm9zc2dYVLBQvsH7N1JDSxujNWVGKJO64CqBb7Tu3ueKr73LJ49yCn0n14NmEAYpOIFwC2+8ZLMnbZm+4Z4/ciLOc9uq1RmgypE0PiyRrLQ/0PEYiR6Ek6f3yFj583f+dBrBMvRUPIwJnlovwEj8dU9cUS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759011239; c=relaxed/simple;
	bh=zbHS90uhO9L8A7rdC4/SzgZZL1SY2Cgihv2lAidt4Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeYeSjeGKewb5gL4W2ACF/ryYONq+EkyAlDHkj3Eutm5AG4o99/xXpbIgtOSMi+jsjnl4R0IoZmOYmqOqcdi4B7ubdKTtFZ88mgvs5ELpGBRsMlW0jjpnF7qPUgK5/3NhtuB8dSJdJAfX8HMc+qLUEsSVybceWxiHcWURVJi7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id BC4E6A03A3;
	Sun, 28 Sep 2025 00:08:10 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d8HZuM6vBO_3; Sun, 28 Sep 2025 00:08:10 +0200 (CEST)
Received: from begin (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 25C04A0395;
	Sun, 28 Sep 2025 00:08:09 +0200 (CEST)
Received: from samy by begin with local (Exim 4.98.2)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1v2d5N-00000000Kev-1NoZ;
	Sun, 28 Sep 2025 00:08:09 +0200
Date: Sun, 28 Sep 2025 00:08:09 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: "w.d.hubbs@gmail.com" <w.d.hubbs@gmail.com>,
	"chris@the-brannons.com" <chris@the-brannons.com>,
	"kirk@reisers.ca" <kirk@reisers.ca>,
	"speakup@linux-speakup.org" <speakup@linux-speakup.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] speakup: keyhelp: guard letter_offsets possible
 out-of-range indexing
Message-ID: <aNhgSYGg7t9tfKXH@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
	"w.d.hubbs@gmail.com" <w.d.hubbs@gmail.com>,
	"chris@the-brannons.com" <chris@the-brannons.com>,
	"kirk@reisers.ca" <kirk@reisers.ca>,
	"speakup@linux-speakup.org" <speakup@linux-speakup.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <e6dc3bce87084fca83b0a0aa99d9ce96@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6dc3bce87084fca83b0a0aa99d9ce96@kaspersky.com>
Organization: I am not organized

Hello,

Thanks for checking this.

Samuel

Pavel Zhigulin, le ven. 26 sept. 2025 20:58:44 +0000, a ecrit:
> help_init() builds letter_offsets[] by using the first byte of each
> function name as an index via `(start & 31) - 1`. If function_names are
> overridden from sysfs (root) with a name starting outside [a–z], the
> index underflows or exceeds the array, leading to OOB write.
> 
> Function names can be overridden with the following commands as root:
> 
>     modprobe speakup_soft
>     echo "0 _bad" > /sys/accessibility/speakup/i18n/function_names
>     # then press Insert+2 on /dev/tty
> 
> This fix checks the first letter in help_init(), and if it is not in the
> [a–z] range the function returns an error to the caller. Eventually this
> error is propagated to drivers/accessibility/speakup/main.c:2217, which
> causes a bleep sound.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a4efe6fd5dea ("staging: speakup: (coding style) Add spaces around operands (checkpatch checks)")

This reference is obviously wrong.

> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---
>  drivers/accessibility/speakup/keyhelp.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/keyhelp.c b/drivers/accessibility/speakup/keyhelp.c
> index 822ceac83068..df60a8b15a2f 100644
> --- a/drivers/accessibility/speakup/keyhelp.c
> +++ b/drivers/accessibility/speakup/keyhelp.c
> @@ -8,6 +8,7 @@
>   */
> 
>  #include <linux/keyboard.h>
> +#include <linux/ctype.h>
>  #include "spk_priv.h"
>  #include "speakup.h"
> 
> @@ -120,10 +121,20 @@ static int help_init(void)
>  	state_tbl = spk_our_keys[0] + SHIFT_TBL_SIZE + 2;
>  	for (i = 0; i < num_funcs; i++) {
>  		char *cur_funcname = spk_msg_get(MSG_FUNCNAMES_START + i);
> +		char first_letter;
> 
> -		if (start == *cur_funcname)
> +		if (!cur_funcname)

The function names array is not supposed to have null entries: they have
non-null defaults and cannot be cleared, at best defaulted back to the
default value.

> +			return -1;
> +
> +		first_letter = tolower(*cur_funcname);
> +
> +		/* Accept only 'a'..'z' to index letter_offsets[] safely */
> +		if (first_letter < 'a' || first_letter > 'z')
> +			return -1;

We don't want to make the help completely break just on odd function
name.

Better just continue the loop, the user will find the function in the
cur_item order anyway.

> +
> +		if (start == first_letter)
>  			continue;
> -		start = *cur_funcname;
> +		start = first_letter;
>  		letter_offsets[(start & 31) - 1] = i;
>  	}
>  	return 0;
> @@ -137,14 +148,15 @@ int spk_handle_help(struct vc_data *vc, u_char type, u_char ch, u_short key)
>  	u_short *p_keys, val;
> 
>  	if (letter_offsets[0] == -1)
> -		help_init();
> +		if (help_init())
> +			return -1;

And then this is unnecessary. Actually help_init should just return
void.

>  	if (type == KT_LATIN) {
>  		if (ch == SPACE) {
>  			spk_special_handler = NULL;
>  			synth_printf("%s\n", spk_msg_get(MSG_LEAVING_HELP));
>  			return 1;
>  		}
> -		ch |= 32; /* lower case */
> +		ch = tolower(ch);
>  		if (ch < 'a' || ch > 'z')
>  			return -1;
>  		if (letter_offsets[ch - 'a'] == -1) {
> --
> 2.43.0
> 

