Return-Path: <linux-kernel+bounces-806320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876DBB4950B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741D47ADE24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A23115AE;
	Mon,  8 Sep 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvvCCuyH"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE83112CF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348344; cv=none; b=OYCeHoShiQJr605/qSPdA23U8bkR8z0z8UhTFOtjGiRizncc468o9Hp7agvCatn+yZX53Yt7859h+KA+Ys3aKkjaEkvGaYpgZRcG8q9eBerMNaVG1WSdg/zgKWqOdzsgZeku4mZxfCl0QH7H3Th8PS7PLDXE/PCvW4VsYaO7vU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348344; c=relaxed/simple;
	bh=bBwWUtgXFKML7E6yZicrpMOFMmrhprvohwsczfPqm8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlpO+sdY9L5yy3eECCAU4uNh3oU//RAYgiRhheAUXrX3ETanPYcOBIunI4vUlw9R+eZ+5dOyh/cnnbtzyqc3vJ42ayg6KjpLc4nMNNYXbLBcBlx22pdIIxUjViEGU8B/dgtoXxdIdG3lkKZ18I1m4pHfuRImCG1yFtYDpIW9CuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvvCCuyH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24b2337d1bfso378125ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757348341; x=1757953141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CKW9Km5qoB4X4sWpHumCKWRFwBEUu5lnJQyMOnvlKZM=;
        b=nvvCCuyH02PSVdA9XioRTEsYGKQayG4LVagnCqDWZqplO/8pV0xCxi2HFxMbc6jbFg
         PwFuhlMZ1lrog23i1ZOY31CxMnrHYvFDMY14t77HRRFfTTHEt8xVTERFQR+1xItMOKgn
         fAiWJnWT5oUE0mHzcSKWHjVLEzWBACJAuuazHbSyXfRk/+DaJkn3EOWqlKz/2zNxpUFv
         PY++gTzhBGI5VP5yiOWbjTv0C2bWk0v6eYjfeL39sXddk5uORT8GQpodSeDOGcWdSQlC
         +rChMJnL77HMbP++WD3/tN1JNFVKy62Cyxo+FyBDsDaxw8O0tr/arUjrVoBy35nu/13J
         hqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348341; x=1757953141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKW9Km5qoB4X4sWpHumCKWRFwBEUu5lnJQyMOnvlKZM=;
        b=oZNqWPw8YFpEyQhoOvNneqstShcJNirq5JslXmdgYA/XxkAdjqcQ6Nv+sJd1AfleSh
         dgp2whLEKIqFZxFtwnfdPh+nUGDhOPx6vbFP1cWUnZ5xlUB5/4NwSsOOeyGJLA819NcG
         k4ROZMt7ceWVf3dIDjlGV9QwDamv2VIqjQSwZWpksf5Yy8miPkjm/hMklUQZJQlYN/4w
         F7Ipz+seiDySKCNUhMf2QtKj+uKIwmk4Ki/Rgde4Yv9W9GeNpiVJuzvKWVO7E8vhKX7A
         iIa/Df/iGGEMGnOyuTqHN0o18YjX/dg3X3vsV+EUOyT8ctOFcS6xTI78dFcMfOvKfsa0
         4I3g==
X-Forwarded-Encrypted: i=1; AJvYcCW17sBKGrm7SizBxugjwxO0ddS9rDlHxeoNlMR8WB59HA+wiSy+JHAuBWkhRG6dTfCn3w5eE5FTWQWR4Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwepHt7pHfz9cPANMFmpGHJ/mR2lndKgzZatwomrkeU+dPeXpfE
	hDwXZbm6uwnID88gfyUjBbRuZ1b2lhDMxeWeiCA4X+Y7VINklapnrNDXkxbBhYh1PQ==
X-Gm-Gg: ASbGncsYvj4G7Nug7eoWryKt56KGG3JkDAetlphkuPoCdylSDKLr1TH7sOs5wuD/9+k
	EG2offfNpkM6E0Z0HOCubyjY7drHHaWRibLfH8wYjX6alrQQGmAMFYhlvDcLevOSvuBN3kaJTuV
	MFQx9f9LrDQ5uiQ3KBrpuoPoVMX8W7eTR5vd6u43U+OSmbKhanu8hIVe3uO2FYw4RBLqnEkjuAR
	OxUpkY+6Jdy8lTw6ZjEe8F8S/R5Baz9/jedgzoYWHTQIM1Ly433UadYSiv2Ep9hnAGzb9UXRwo1
	+9UEdQuLW0gE45JU9YPKlJfZFylU2lHpwRhLfXbiCBgrk8obloEecl0AdQhDZkQEHNBB77UHOOR
	5CdHMs3YnfiUGjxcitwA34kF5sdU4RI8J4UvuVX859j2Peo18pTttgn8XXQo28Q==
X-Google-Smtp-Source: AGHT+IGALeDqJI4bBK7+ca8xnhgdtA37rM1ujrTFcj7NVpG6uQldYaHEZ4kn7maaD/vDb5uH/1GU/w==
X-Received: by 2002:a17:903:1a70:b0:248:aa0d:f826 with SMTP id d9443c01a7336-25114d02755mr9469975ad.6.1757348341105;
        Mon, 08 Sep 2025 09:19:01 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57b232sm36827136a91.2.2025.09.08.09.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:18:59 -0700 (PDT)
Date: Mon, 8 Sep 2025 16:18:54 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Breno Leitao <leitao@debian.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] scripts/decode_stacktrace.sh: symbol: avoid trailing
 whitespaces
Message-ID: <aL8B7gvFAthV4EX0@google.com>
References: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
 <20250908-decode_strace_indent-v1-1-28e5e4758080@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-decode_strace_indent-v1-1-28e5e4758080@kernel.org>

On Mon, Sep 08, 2025 at 05:41:57PM +0200, Matthieu Baerts (NGI0) wrote:
> Lines having a symbol to decode might not always have info after this
> symbol. It means ${info_str} might not be set, but it will always be
> printed after a space, causing trailing whitespaces.
> 
> That's a detail, but when the output is opened with an editor marking
> these trailing whitespaces, that's a bit disturbing. It is easy to
> remove them by printing this variable with a space only if it is set.
> 
> While at it, do the same with ${module} and print everything in one line.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  scripts/decode_stacktrace.sh | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 17abc4e7a9855b10e76acfdb92847e1671d6c2bd..c6b5c14412f0f6f78fb60b0b042d6e22bbb46b79 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -323,12 +323,7 @@ handle_line() {
>  	parse_symbol # modifies $symbol
>  
>  	# Add up the line number to the symbol
> -	if [[ -z ${module} ]]
> -	then
> -		echo "${words[@]}" "$symbol ${info_str}"
> -	else
> -		echo "${words[@]}" "$symbol $module ${info_str}"
> -	fi
> +	echo "${words[@]}" "${symbol}${module:+ ${module}}${info_str:+ ${info_str}}"
>  }
>  
>  while read line; do
> 
> -- 
> 2.51.0
> 

LGTM,

Reviewed-by: Carlos Llamas <cmllamas@google.com>

