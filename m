Return-Path: <linux-kernel+bounces-729914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2AEB03D83
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB18189B550
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A47246BA8;
	Mon, 14 Jul 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEUTrbVJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E2243369
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493329; cv=none; b=PcSg+oJ+Kj51XOA/qtOUqiAxkrivKr7O67DpeyvCZfg7ZQ8ycrS9uAVz6Ithl+A7j0y9O19GrKdOdvsj6I8tVLurKMfUOrHz9fUDbjpnp+UB9ORe4WsVp6d9o+Enh2ln66NHqWNAslvwU3lS+mQBeWdMR+lx1n77xeI2N6vNwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493329; c=relaxed/simple;
	bh=FYgST6pQFD9uW71/0fSwDSrVyJfCLOXNbI+aU9yF7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3p/z56iqLk7ZIC6vu4hccW4JU8jXsxIl8ewxPTSK0jHWOlgN1FB6vBMFOnacuD8/f4YjntpPCk87J2f0ZffgzYriNUfMZTffRWUhIlcK43koRAe52yBGk3yiKCst+rMON2J4FmJPk0e+viryC7ZJdhaOTB0+90QRBQhNQM6PVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEUTrbVJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752493327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y731NRnwNIgogYJawkSk0h9B9WtguA4mG+59dmJ2OSE=;
	b=YEUTrbVJNQBSHKPjUOGATImgirQRYiM67WnNckPiHBvdhvhtEKOhIWgYYqog1NTsCB83kG
	UFJT4Kd1MejkipQs55CLAwRB3AjZnzLsvSZzJ54THKBowyjHygG+3nnlHGAdfk6rExt1/K
	S4KFjxF/VWCPnEo9G0QlsXPm7PNVSGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-Z5JsUmPcMcS-ZE-M3BH0Ww-1; Mon, 14 Jul 2025 07:42:05 -0400
X-MC-Unique: Z5JsUmPcMcS-ZE-M3BH0Ww-1
X-Mimecast-MFC-AGG-ID: Z5JsUmPcMcS-ZE-M3BH0Ww_1752493324
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso2191143f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752493324; x=1753098124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y731NRnwNIgogYJawkSk0h9B9WtguA4mG+59dmJ2OSE=;
        b=h3MRuXL4/Bqewf8Os138d2pu9U+QqLP+ZT9TPC9WERPGZ9dmqmyy7g9wMb/V+wuph9
         mDqXTWhsN83UA2gzkOuylw9OxOk9VhcUojWDnPFvjQaLdN/1kcamZ5357o5XZHYn1LJy
         hpSDlhsmSUU8D5lqlqubvL/bM/UI3wfaSXQa7UaBp03rRC/6FuWFKoMeTeQOdMeJcg6K
         EaN03ax0ktoUSChMXo7mN+KF92tJyGmUD9gboBOTTQa1iFrWVnc487mtBVh8BP9/nzIS
         FMoIx1MgsanMGefhDw10IvTzkOY4Gqr0GbiMmtCE6+6BVtgtmMuSVuq66GtQq78KWRjy
         YaYA==
X-Forwarded-Encrypted: i=1; AJvYcCV/j4E77ZvcJ9OhXtXYOIb+ImfqpcsNK1Fqcr4P6nUbNg6UkDQyfBIUNSLVMGKDd/Z8S82SAUvod26P4yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmqR69ee0sPKfvL0plGGD1ZFWqmMalZmqFSAg2AHX6AtQNmbP
	xNFp89PN55KM+7QfrevSDrO8wP0mvE6pGxRuaT55xk4q/FA5pmP35wDg0rkysDJ/Ewv0Tb9QkjO
	sXFSeLT9ijty8BMshO+WGY0Kj+PYQOSGH1dVe2+NFEhnhVFC6ylbylRAFdpIRHqvg7g==
X-Gm-Gg: ASbGncsuVM0RY9A02nCMa6Km7IcjH8xf5UATRtUuwWcBXoiEpyuTm5zjgQhyA1sxeIP
	K6YnKsD/gYzWnOrZWR2lmXnfAjA5nGo5ApNfa/2VoZZ/i5kjUv8Gsxjyld2apUWdmEahcWsrYVj
	9zFFTnc5EgZHhgkFhBuK4Q+ebURTK7aW1V3xkDDpEgTAoyKwAYKQoBNji8jNI96DapHvYNgCNlZ
	rQHZUMS/9yysN2GqfFBUVBdfvoq8u7wyhav3Lif/NiLQWcIFDf8ihZE2KlZNF8tKED05gMTAO34
	cLmdEN4LRPJCR9lg+OR87ixKWyE=
X-Received: by 2002:a05:6000:26ca:b0:3a4:fc3f:ed28 with SMTP id ffacd0b85a97d-3b5f18d99a9mr10479316f8f.29.1752493324338;
        Mon, 14 Jul 2025 04:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQH0V/iMOxtMz9uQz0A7Zu8CheLlThnVAI8whDJVkBgC2ZF166O9rwFbccdktxmhQ3vNNKlg==
X-Received: by 2002:a05:6000:26ca:b0:3a4:fc3f:ed28 with SMTP id ffacd0b85a97d-3b5f18d99a9mr10479295f8f.29.1752493323904;
        Mon, 14 Jul 2025 04:42:03 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26ff9sm12194718f8f.93.2025.07.14.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 04:42:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:42:00 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy() with
 strscpy()
Message-ID: <aHTtCGGlrvOZvnsW@debian>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714075436.226197-2-thorsten.blum@linux.dev>

On Mon, Jul 14, 2025 at 09:54:33AM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Since the destination buffer has a fixed length, strscpy() automatically
> determines its size using sizeof() when the size argument is omitted.
> This makes the explicit size argument unnecessary - remove it.
> 
> Now, combine both if-else branches using strscpy() and the same buffer
> into a single statement to simplify the code.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/trace/events/fib6.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
> index 8d22b2e98d48..903a18836bc6 100644
> --- a/include/trace/events/fib6.h
> +++ b/include/trace/events/fib6.h
> @@ -64,11 +64,9 @@ TRACE_EVENT(fib6_table_lookup,
>  			__entry->dport = 0;
>  		}
>  
> -		if (res->nh && res->nh->fib_nh_dev) {
> -			strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
> -		} else {
> -			strcpy(__entry->name, "-");
> -		}
> +		strscpy(__entry->name, res->nh && res->nh->fib_nh_dev ?
> +				       res->nh->fib_nh_dev->name : "-");
> +

Acked-by: Guillaume Nault <gnault@redhat.com>


