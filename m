Return-Path: <linux-kernel+bounces-889934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA4C3EDFA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F463A7766
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471B30F7EE;
	Fri,  7 Nov 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="PT+4v/lr"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605926F29F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502737; cv=none; b=ftphwCMy5xdpfgLw7vRjuvtJ9CjMD0D8DF75tXXLc/Sk0LISwizDYM2ZAJMhtiKJOp6zhRwxNXnWwgu87Ovb3OaEd1n9cjOzPKceIXiWuq7lyCeIvYFxQuJ0W5M3oBp2eRM5GnXOYXgnGZnDHblV2GWXZNs8P+hiA6RM87+D8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502737; c=relaxed/simple;
	bh=QzOZ0+yE/RVPWJrN2vx9s751IVv37wWeCx0D+yyShHs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o8TdJCpwx0rIHSxCCQ6ETPiYbE+pZsK/4SAb5UwNRrnEV22xF7hi0OWZxbD4o1r2IHLfW9nEQCE61lRD2k2C03Tvj+N1484fMoJ7/saidY5xKW5IaFk794eC8kvaNcjotqMDQW9DVjNicWXH9ai+88BkhzFfEAHIanR3bhzyWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=PT+4v/lr; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h62J5s12u1Z3LDBp06HlNWyDoCyt78LQdWdmaRcR/Bs=;
  b=PT+4v/lrrjmXw2vsFEn8w+x4d13E1RBqDc6hQRT0w3h59Q/m+FKLChU6
   gMG8xm9vEhbarzAhgSWkf8VjhZOGaobJAzPhJsiDi7nSK80s8GbvAINjO
   OdrV282s4pKU3SEWnLZ1B7Fg/LOvZ3+rkeauxoEojYEEiIjkiODJY14Hf
   Y=;
X-CSE-ConnectionGUID: 7EDbXYedSSenYFVhZ0PRJw==
X-CSE-MsgGUID: iNz7rgcIRZ6sKqcIqLMiJw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,286,1754949600"; 
   d="scan'208";a="248092612"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:05:24 +0100
Date: Fri, 7 Nov 2025 09:05:24 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Songwei Chai <quic_songchai@quicinc.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com, 
    quic_jinlmao@quicinc.com
Subject: Re: [cocci] [PATCH v2] scripts: coccicheck: filter *.cocci files by
 MODE
In-Reply-To: <20250606060936.2756980-1-quic_songchai@quicinc.com>
Message-ID: <f4376c72-b255-4cc-959a-8c947addb4ca@inria.fr>
References: <20250606060936.2756980-1-quic_songchai@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 6 Jun 2025, Songwei Chai wrote:

> Enhance the coccicheck script to filter *.cocci files based on the
> specified MODE (e.g., report, patch). This ensures that only compatible
> semantic patch files are executed, preventing errors such as:
>
>     "virtual rule report not supported"
>
> This error occurs when a .cocci file does not define a 'virtual <MODE>'
> rule, yet is executed in that mode.
>
> For example:
>
>     make coccicheck M=drivers/hwtracing/coresight/ MODE=report
>
> In this case, running "secs_to_jiffies.cocci" would trigger the error
> because it lacks support for 'report' mode. With this change, such files
> are skipped automatically, improving robustness and developer
> experience.

Pushed to my tree (for-6.19 branch)

>
> Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
> ---
>  scripts/coccicheck | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 0e6bc5a10320..89d591af5f3e 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -270,7 +270,11 @@ fi
>
>  if [ "$COCCI" = "" ] ; then
>      for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
> -	coccinelle $f
> +        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
> +                coccinelle $f
> +        else
> +                echo "warning: Skipping $f as it does not match mode '$MODE'"
> +        fi
>      done
>  else
>      coccinelle $COCCI
>
>

