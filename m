Return-Path: <linux-kernel+bounces-806371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF23B495A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717AF2015CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149FD31064E;
	Mon,  8 Sep 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b809fcCm"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3852310629
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349197; cv=none; b=XtKuoEN7lQg9lNvAnfVlcINSj+rSNVU5u/PtcRphya7Lefjf9nORCADiE9fa9EznbUbXVJzH2aOc+LDcM87GGbZ/+dQbWCjSKoSB6HhPCKXrLyNbqNnJCOb+yNeKzwDLeBIdoXvCJ8BfqvUvkXQ2TgoIAslLW9NWBrOAEsv0vT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349197; c=relaxed/simple;
	bh=ZLXnPXLysH+Ub/kuqneluGJLOpgsSWjfnYLRiDDfWsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM6uk2ESgkqDmQI6kJysPyX7zG6K4/V+BhHktCmXCxgi0BpfXJClaLAtslCqaavk2RLWKahm30Hkr9XxBqbHbO2dViumv+RSQDJqTzZgX6mXTNY6f75V1amVZAmV4lNCM3rHBsQ9pWC2TLt+XMuMAljtcKZYH6Mrnl7SkPpPUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b809fcCm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24b2337d1bfso382555ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757349195; x=1757953995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sn0pbJVY5hbPyMod53FD2HG6gIWxC6WbhLizUSMgZxg=;
        b=b809fcCmzbwShN6Jwq4WXC04QIrGR56ekKpuuDaX+5HBRdErcalWwmYjrwwtQJumy+
         qjDXyy4hOLj3YGONJJ4ZVZfm6odtj3fjAd5O8SsgKpZ1Ea7ObrfT9skwlVpXLb7qOcLa
         qBqftoxA8dcn24RMFp2CJpwPafWvsI0oZHUxutO7ncDMBVDe1oQuQejxCaWA+TfKWCF1
         B4FywqgXABiW1fgTjltKpcgbCdkIGTI8sBoMNrdbxHkC5rHW6Su4dVGmIVZ4oBzrwt/G
         fNo51Z9NQArQF5fBLrwQxK5y48TifwlH+VOHxbtxvgf3582MWooXbyFT+HvcN7z0qjI9
         M7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349195; x=1757953995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn0pbJVY5hbPyMod53FD2HG6gIWxC6WbhLizUSMgZxg=;
        b=vbCQd4UBOGwTXP6p4+oXDIQz/DQOkwiGjbRhxuZMgCZ2BeJHe3mW/gzWISuiRiAJUm
         SHRR/OleRujY0fPvuWG+JJV8ttFpafir0RmYyFwEqqlJVnhf1AkIsVCTRPEgV6/6OhdH
         Svf5Kxl/g+jD5evF1+QM3fi4xKjEdtd00dnKkOR8KCd59rDwrWSRQuzhyZ8sKw+jL8u+
         wLl4meLsT1FDohlsyEYK61Xf2O/5l+WWEAXki7Q3zbGUTuOAuLHAErjkHA2ueGUQskGu
         sjPD+QmUGwPZPKBJV+Oobwfc/TWcBCoGOooN9thfhY4vYBa98NnhTu9YRnWFnk40LWVJ
         iBGg==
X-Forwarded-Encrypted: i=1; AJvYcCUP998QEGWEQM6ltrFVqoXbyCbZMHFIB1e+2PVDZwfEVBfjA1gXeSK+nnr4819FOsIpeADxvCVlnlui6sI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6O1QgLAS5t3YUGKQnTIM+/0VhMAdIY8ABAcseJX9lJR+vljNq
	juHdGkPbegrEGFCfXRMbd/JfNvV0HJ9tEZbD357N/r1CqhRy9R1O7xLlOiaV5Eesmw==
X-Gm-Gg: ASbGncuc8eJJ4IaJx5xl7lNaqvEAo7ZvL9cG5laO50Vnh3I+619DievvY+CDDm32j4z
	RqfI2ApNY/WfHQ7YAHIWIj5LtvfkQPMsvp2/QWJkGLWqFZLkhvlkBjHsfiucbj7633JsdZGcaQW
	Y1ivg+6iRKJlmP7ylq8NunVHU29jpUa1e2BcDGLYamBi0/N8IrAaqY3S8NIgyxqJFswihHI4tKZ
	J+zeDmO9v+XF4t2gjEvN066WaXlw4A0iOSQp4hKDqiMov5Yp4KdwLsF1YSU8lQJJbaGPIK1CJmB
	eJFrKH979CxQN+mO5Dx+eTBX4c8KQrHxSyAMOGzyu9kHCOVLX5Xy/gTI+oDymgJzTjm8KCcIoTJ
	KTxzRlgzMc6OPx/eFdEuanLAH/eTVbJpwBIJTuihe3nIKcZm1i+URvU8hDo7JNn+w/LAQYOnQ
X-Google-Smtp-Source: AGHT+IFopQpB3o4HZrF2tsXbrLHVXsF2ljin8d0/F5LmRkok/+CVlkn8B7f1kNcB+p6X0Xb1xFqbvA==
X-Received: by 2002:a17:902:ea0e:b0:240:5c75:4d29 with SMTP id d9443c01a7336-2510acd912emr6745715ad.0.1757349194932;
        Mon, 08 Sep 2025 09:33:14 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cc919880dsm120767645ad.51.2025.09.08.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:33:13 -0700 (PDT)
Date: Mon, 8 Sep 2025 16:33:08 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Breno Leitao <leitao@debian.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] scripts/decode_stacktrace.sh: code: preserve
 alignment
Message-ID: <aL8FROiSovQDRpsm@google.com>
References: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
 <20250908-decode_strace_indent-v1-3-28e5e4758080@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-decode_strace_indent-v1-3-28e5e4758080@kernel.org>

On Mon, Sep 08, 2025 at 05:41:59PM +0200, Matthieu Baerts (NGI0) wrote:
> With lines having a code to decode, the alignment was not preserved for
> the first line.
> 
> With this sample ...
> 
>   [   52.238089][   T55] RIP: 0010:__ip_queue_xmit+0x127c/0x1820
>   [   52.238401][   T55] Code: c1 83 e0 07 48 c1 e9 03 83 c0 03 (...)
> 
> ... the script was producing the following output:
> 
>   [   52.238089][   T55] RIP: 0010:__ip_queue_xmit (...)
>   [ 52.238401][ T55] Code: c1 83 e0 07 48 c1 e9 03 83 c0 03 (...)
> 
> That's because scripts/decodecode doesn't preserve the alignment. No
> need to modify it, it is enough to give only the "Code: (...)" part to
> this script, and print the prefix without modifications.
> 
> With the same sample, we now have:
> 
>   [   52.238089][   T55] RIP: 0010:__ip_queue_xmit (...)
>   [   52.238401][   T55] Code: c1 83 e0 07 48 c1 e9 03 83 c0 03 (...)
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  scripts/decode_stacktrace.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 0c92d6a7f777e1b2d5452dd894a13a71e3d58051..c73cb802a0a3fc6559c5f53ff844e5cc6e433615 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -242,8 +242,10 @@ debuginfod_get_vmlinux() {
>  
>  decode_code() {
>  	local scripts=`dirname "${BASH_SOURCE[0]}"`
> +	local lim="Code: "
>  
> -	echo "$1" | $scripts/decodecode
> +	echo -n "${1%%${lim}*}"
> +	echo "${lim}${1##*${lim}}" | $scripts/decodecode
>  }
>  
>  handle_line() {
> 
> -- 
> 2.51.0
> 

This also worked for me. From this:

  [  143.815379][ T5218] kernel BUG at rust/helpers/bug.c:7!
  [  143.815970][ T5218] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
  [...]
  [ 143.842198][ T5218] RIP: 0010:rust_helper_BUG (rust/helpers/bug.c:7 (discriminator 4)) 
  [ 143.842231][ T5218] Code: cc cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 (...)

... to now:

  [  143.815379][ T5218] kernel BUG at rust/helpers/bug.c:7!
  [  143.815970][ T5218] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
  [...]
  [  143.842198][ T5218] RIP: 0010:rust_helper_BUG (rust/helpers/bug.c:7 (discriminator 4))
  [  143.842231][ T5218] Code: cc cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 (...)

Tested-by: Carlos Llamas <cmllamas@google.com>

