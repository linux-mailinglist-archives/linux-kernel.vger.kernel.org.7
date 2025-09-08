Return-Path: <linux-kernel+bounces-806330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75707B49522
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BB916EA85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384D30E0C3;
	Mon,  8 Sep 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1fYaNZBE"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FD205ABA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348587; cv=none; b=aEwpaUCx8wFO4m98wMddTomOeGZPoflB1kVr9qNU9CHbfyd4VAAdWOc0VWq6CYCeO9Quwx2N7qHYrNeV3EHcnR1qxzmZ8EGKZlTsNUZ/IFefDQPw5asYxthm5HsD109rVpoAgxDH03yuL2NEoNKRQhi2iOwKoiSZFwQE+bH1HDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348587; c=relaxed/simple;
	bh=0g9z6NRTHzDEWLA43hqMOR5PkQz5vQLUSC71hzl9DxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV0m9WwJMq9IVu3M8o67RRnA3B50rPNmoXwAQHdGsabzG2tEYAasYkZLE/XlayR01BrNXdTH8DTGpz3KA5I2Z7Cd0wmcXQ1Owh4zMCqrd1aSxX6oLSZPjgq50cdN9OP2a8iD7MttlIelNibFC9tZG2TxzU2EP1V1//SyimanrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1fYaNZBE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b2d018f92so419115ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757348585; x=1757953385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZzzhyXc7/tAxoU77hY8KimTf22sjv2T0Nf3OeuRnK8=;
        b=1fYaNZBEGTnfj94LNb+eVp27LYuhY9bJ1ReWOJA5q4168AmZSl9PEXskDKt1bVznOY
         VmChppMlvRcAutXaG0xIgONZ3Fohy9Ed/yhYBh/kgt3Xnc16OLK2IMvR6Lo9INxWIxmp
         Es+tJALLTreiOUJntJTT7R02a++4eSiauB7hq6+KUQauSrCAV0OSSHihjdlrvsDVoTrq
         oVm7DIPcWN/+Nq27rHvMUFOYkV6u1L9Y3Nyh6IHGnzyARPUsqNDE1l1AlQ6wKjaCoPno
         xTYWsVKGTOfWBFz0sPLibOJpiqCLf8wW7IKuJ7PRFRERD4HsVPz0tnufE+h7mijQ1g7u
         Hc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348585; x=1757953385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZzzhyXc7/tAxoU77hY8KimTf22sjv2T0Nf3OeuRnK8=;
        b=YBlLZC3gVRTHT6CPc1Vuykw/93V60ltOKlr1RjpbDuU8OWu4BQzUy2ZVZafww25wH6
         DU8pDUdN8/4J1cKSL0Nzezp4pjg5NLUDNIImhfb1pvBMjEYa/5GewxFmIaKey8sewAUF
         IAKlaNgLnUleT84UuSGHRs+e+Wgfg4k3JhcIi2GBvCB+YuDuhqIMmvU1ZrwQFtc9gI6B
         rMU6A6cR5jUrSgce9ZCi2Ch5asmFL1HGhI0TYSWFtwerjWS7LVruIgxLezxzS20rZohJ
         AVrrZZKPwVFC6MYDuBHVXD6xLa8ezwxvdW81ad90RjLb0/h+7v+2q3WdD2jG/gyEJPT5
         W4/A==
X-Forwarded-Encrypted: i=1; AJvYcCVk5FJ7x4HWf0dEGS0puPW7Hcuci8Z1uqoz6g+G5X0JUSOmCQ3N984vImZoHAFQ8aQYMUCqUKdrjSYsWSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuwWQETkXypztsAL1HhO9+J+4QXmJxT8K8LWw/RLomltSknuw
	RwgVeL4cQoyP3x+VbQfelB5vz0gqG9YxaMH4Fl9o6dYVMboAxn02Ngn4W+CcsLl+cgYGPS/hkWP
	Oc5tFjA==
X-Gm-Gg: ASbGncstmz+1Tah2XSt5U4uesM42KZ5+uHy7jWibdFP4eizE1iI0GjvTfV9UOgpPShf
	ZKrIpfVQT+EwctBF2T3MZe5pkJuln021H7G5VnrI3UWZGA/Ccg4n5Rt5GmGX0mfQVgsNQjK8CJE
	5tZk73WFrWDNNbbNrLkxs21WeUSHg6PgiG/ny28Ko8b2i2x1ADJuiWnEMsuAxo3f158E58m/ilY
	lGp6xEO0w9ysWlPTisiGeqTfqQCeCXYXKSNmxT4a3K1T/v8H97PYcVYuvxDAxAD1K65eW5F+g/J
	rHOyAgbMr6jSk/C175k7kmYkA0q/gnW36lHR5Fek/Rkutdz8CE2x0yigm1o0//+zeVcBTom3zau
	keeJz3E+vwxBheT068e49ggP5c9S+ztzjPyKRwXJPwbOwAn7wW1shehyN9tmrhQ==
X-Google-Smtp-Source: AGHT+IHlvciZ7imrKJ1NU6Q/dX78s6INKJ0MASZNAkB/fLNVb6127LWkpchnJlaG7oBkxsAPDnploA==
X-Received: by 2002:a17:903:37cf:b0:251:a3b3:1565 with SMTP id d9443c01a7336-251a3b31fa5mr7080405ad.11.1757348584623;
        Mon, 08 Sep 2025 09:23:04 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d089395esm20671596a91.1.2025.09.08.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:23:00 -0700 (PDT)
Date: Mon, 8 Sep 2025 16:22:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Breno Leitao <leitao@debian.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] scripts/decode_stacktrace.sh: symbol: preserve
 alignment
Message-ID: <aL8C375O6Spd4Vne@google.com>
References: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
 <20250908-decode_strace_indent-v1-2-28e5e4758080@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-decode_strace_indent-v1-2-28e5e4758080@kernel.org>

On Mon, Sep 08, 2025 at 05:41:58PM +0200, Matthieu Baerts (NGI0) wrote:
> With lines having a symbol to decode, the script was only trying to
> preserve the alignment for the timestamps, but not the rest, nor when
> the caller was set (CONFIG_PRINTK_CALLER=y).
> 
> With this sample ...
> 
>   [   52.080924] Call Trace:
>   [   52.080926]  <TASK>
>   [   52.080931]  dump_stack_lvl+0x6f/0xb0
> 
> ... the script was producing the following output:
> 
>   [   52.080924] Call Trace:
>   [   52.080926]  <TASK>
>   [   52.080931] dump_stack_lvl (arch/x86/include/asm/irqflags.h:19)
> 
>   (dump_stack_lvl is no longer aligned with <TASK>: one missing space)
> 
> With this other sample ...
> 
>   [   52.080924][   T48] Call Trace:
>   [   52.080926][   T48]  <TASK>
>   [   52.080931][   T48]  dump_stack_lvl+0x6f/0xb0
> 
> ... the script was producing the following output:
> 
>   [   52.080924][   T48] Call Trace:
>   [   52.080926][   T48]  <TASK>
>   [ 52.080931][ T48] dump_stack_lvl (arch/x86/include/asm/irqflags.h:19)
> 
>   (the misalignment is clearer here)
> 
> That's because the script had a workaround for CONFIG_PRINTK_TIME=y
> only, see the previous comment called "Format timestamps with tabs".
> 
> To always preserve spaces, they need to be recorded along the words.
> That is what is now done with the new 'spaces' array.
> 
> Some notes:
> 
> - 'extglob' is needed only for this operation, and that's why it is set
>   in a dedicated subshell.
> 
> - 'read' is used with '-r' not to treat a <backslash> character in any
>   special way, e.g. when followed by a space.
> 
> - When a word is removed from the 'words' array, the corresponding space
>   needs to be removed from the 'spaces' array as well.
> 
> With the last sample, we now have:
> 
>   [   52.080924][   T48] Call Trace:
>   [   52.080926][   T48]  <TASK>
>   [   52.080931][   T48]  dump_stack_lvl (arch/x86/include/asm/irqflags.h:19)
> 
>   (the alignment is preserved)
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  scripts/decode_stacktrace.sh | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index c6b5c14412f0f6f78fb60b0b042d6e22bbb46b79..0c92d6a7f777e1b2d5452dd894a13a71e3d58051 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -255,10 +255,11 @@ handle_line() {
>  		basepath=${basepath%/init/main.c:*)}
>  	fi
>  
> -	local words
> +	local words spaces
>  
> -	# Tokenize
> -	read -a words <<<"$1"
> +	# Tokenize: words and spaces to preserve the alignment
> +	read -ra words <<<"$1"
> +	IFS='#' read -ra spaces <<<"$(shopt -s extglob; echo "${1//+([^[:space:]])/#}")"
>  
>  	# Remove hex numbers. Do it ourselves until it happens in the
>  	# kernel
> @@ -270,19 +271,13 @@ handle_line() {
>  	for i in "${!words[@]}"; do
>  		# Remove the address
>  		if [[ ${words[$i]} =~ \[\<([^]]+)\>\] ]]; then
> -			unset words[$i]
> -		fi
> -
> -		# Format timestamps with tabs
> -		if [[ ${words[$i]} == \[ && ${words[$i+1]} == *\] ]]; then
> -			unset words[$i]
> -			words[$i+1]=$(printf "[%13s\n" "${words[$i+1]}")
> +			unset words[$i] spaces[$i]
>  		fi
>  	done
>  
>  	if [[ ${words[$last]} =~ ^[0-9a-f]+\] ]]; then
>  		words[$last-1]="${words[$last-1]} ${words[$last]}"
> -		unset words[$last]
> +		unset words[$last] spaces[$last]
>  		last=$(( $last - 1 ))
>  	fi
>  
> @@ -294,7 +289,7 @@ handle_line() {
>  	local info_str=""
>  	if [[ ${words[$last]} =~ \([A-Z]*\) ]]; then
>  		info_str=${words[$last]}
> -		unset words[$last]
> +		unset words[$last] spaces[$last]
>  		last=$(( $last - 1 ))
>  	fi
>  
> @@ -311,7 +306,7 @@ handle_line() {
>  			modbuildid=
>  		fi
>  		symbol=${words[$last-1]}
> -		unset words[$last-1]
> +		unset words[$last-1] spaces[$last-1]
>  	else
>  		# The symbol is the last element, process it
>  		symbol=${words[$last]}
> @@ -323,7 +318,10 @@ handle_line() {
>  	parse_symbol # modifies $symbol
>  
>  	# Add up the line number to the symbol
> -	echo "${words[@]}" "${symbol}${module:+ ${module}}${info_str:+ ${info_str}}"
> +	for i in "${!words[@]}"; do
> +		echo -n "${spaces[i]}${words[i]}"
> +	done
> +	echo "${spaces[$last]}${symbol}${module:+ ${module}}${info_str:+ ${info_str}}"
>  }
>  
>  while read line; do
> 
> -- 
> 2.51.0
> 

I just tried this and it works for me. From this...

  [   51.711528][ T6914] ==================================================================
  [ 51.712906][ T6914] BUG: KASAN: double-free in __kmem_cache_free (mm/slub.c:3875)
  [   51.713765][ T6914] Free of addr 85ffff8912b19f80 by task sh/6914
  [...]
  [   51.717788][ T6914] Call trace:
  [ 51.718182][ T6914] dump_backtrace (arch/arm64/kernel/stacktrace.c:236)
  [ 51.718734][ T6914] show_stack (arch/arm64/kernel/stacktrace.c:244)
  [ 51.719219][ T6914] dump_stack_lvl (lib/dump_stack.c:107)

... to now this:

  [   51.711528][ T6914] ==================================================================
  [   51.712906][ T6914] BUG: KASAN: double-free in __kmem_cache_free (mm/slub.c:3875)
  [   51.713765][ T6914] Free of addr 85ffff8912b19f80 by task sh/6914
  [...]
  [   51.717788][ T6914] Call trace:
  [   51.718182][ T6914]  dump_backtrace (arch/arm64/kernel/stacktrace.c:236)
  [   51.718734][ T6914]  show_stack (arch/arm64/kernel/stacktrace.c:244)
  [   51.719219][ T6914]  dump_stack_lvl (lib/dump_stack.c:107)

Tested-by: Carlos Llamas <cmllamas@google.com>

