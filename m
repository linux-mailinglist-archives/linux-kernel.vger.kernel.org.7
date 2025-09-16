Return-Path: <linux-kernel+bounces-818614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCACB59401
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CE72A614B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FD2BF3CA;
	Tue, 16 Sep 2025 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/2JAWUF"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F41285CB3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019564; cv=none; b=MEk9hQkm9bgdjAORlznu5xihLgnGqlVuz0GRhqAOUltHN/9ZU9JfYwCurdScnqtPTXzgtnrV4XlhciNXsjcNJFGGhMUkn9mrl47qji7sfRoC6shCUBJhzqp9/HLj4uPP7Pz/QY4smGnTf+S1Om8Ev40RqWpbYZ/t8VjLcpCi6gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019564; c=relaxed/simple;
	bh=brINOGh34uv+dpJHIYG4i2LVC6eRmNVQxpODmhE0x4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pk32lsinWBVqX5MJn9n9vhhCfsvSPprHSsrMJlY38OKTjV99GP05cQgoS3CC3glc8lhFIdv9mwE9eBBPgN68eU5xcRf/zYhlezRU2IcwoPNMlj0i+6KNmKrbLMLRsVxs4DWfqhP4QWVPKj3cOZJa2xZa+kMQgW3gDPvU8Elpv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/2JAWUF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3eb3f05c35bso1508122f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758019560; x=1758624360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjrnXJtaUGoRrY4sA/QAMhII82BWLUeC+DqFsB4u81E=;
        b=a/2JAWUFT9emBipBotL5o8F+SjBa/pa+5z39YnkfSDKvsdu7s/qpbg13Ha6rGV4HVi
         VhveLEVdHc/vmq4QKDQbDhlbzgT99G3lPcjCJUdAyv+5pBGpY1Oc5aHBDNne2YlLEtks
         KjBjDM5oRJD1y+jLyvDIdx5zAFbBLxpqQBJCuOFhXeCaxZxSKhft1QeKw9SeHj6Eh4zK
         XzP9gn4LADFCN76wb37qZvUQCZ4RjdGnpehoOFimh58YE946OoUA1RR9GQ2J71vge8m8
         V09Tb0955XlQbMW469Aq2kiVNXHiAkcuP6YqTxzZiIikkDJPIwdVfWiAbNu2QUO/8rCx
         xchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019560; x=1758624360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjrnXJtaUGoRrY4sA/QAMhII82BWLUeC+DqFsB4u81E=;
        b=NTEB6B2PNzZqntywwwZXSz0+kodtCotoxHO0TZT+fxCw4SVRCTuFmKLGaW39gzD+GO
         oS5YEK1ym96eP3swTVEIQvpUfPFBN+QCPrx3tHk9uR0Ua2tFwc9t5n/ruFgGQAmFyBn9
         lojzimVmXeRIEQwlD0nZUeI1NdBvHJiSKDkxCxE1CbxgNa2i/mn28+f7tufYvRG/Thxz
         WUZibJH7ygl992bb5zpKkfqm6qGcDU+Kmo9ri4vY0EUpV1MnW/YYOUc/4teiljLRBvJX
         0fHoVJsltDFqz0WcxtxDo2YNeeIOZLbaAoOdQg10WJ6eq6QT/rx+NnvqInhGL4vKitV5
         7RhA==
X-Forwarded-Encrypted: i=1; AJvYcCUD9lFuCoz5eVN/R15UwqR8Bj3wi5bziGmSuhlUqZB5v0gJCHYWLaRjDoJX4N6zLO8/NP89o4WeMuZNYMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrVzPeQA59NRL11azeXjejMp0mp83DOiNLvQl61BMy3gGBef8N
	bLOWO03TK14k0MK4zadRfl5piVEnjq5ECnA9WIZXWWZrZ1Hcl7TyIt19
X-Gm-Gg: ASbGncu3WpLZOOrFCYIa2w0LSLfqEAVRqZDf2p1NZZSYV6jMZ5qTSgM6fP7h0SQXbUf
	IcD52AstwILY4/WJpX2jaX8xTWJETzjBbdNRjFJDfY37JgzOHQO8uqbzWaF3zavcqljZnugYHf4
	4zB9CtnYSxPc7rXcwF9CKDNrPkSaBu1mbQ5GPT6sYaYSxqO0l6ZHrk0nVg1WsSSJ9UB1UU8dw6f
	AeiQPozvJ19Y9LR65RcxojcC/CbtY4WkRhacRhICAt7Wrx+7jZDdXdcerY/Q/gzPkITde88WZxE
	Ql0rCqxDHCSeNrySGTdByx5Si2/mU3koVHGPNU1b+FLv6xC8ERAi/igUDp5NPZBEbp8Y3ZefvZa
	xTFtMQKBFJ+9BqavU8TjEioi17pmwAPJK8IBwEIHQrSQ=
X-Google-Smtp-Source: AGHT+IGoDQJoZxFXsWv5pRY0VZmVoe0AQ5fhDiO8AIYZ/RsJtBii1vkvo1eebaDW9L15Dm5Mh8rJ+w==
X-Received: by 2002:a05:6000:2282:b0:3d4:15a2:11e9 with SMTP id ffacd0b85a97d-3e765a35ee5mr12529163f8f.61.1758019559841;
        Tue, 16 Sep 2025 03:45:59 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e84de17f9bsm14647160f8f.49.2025.09.16.03.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:45:59 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:45:57 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: Jorge Marques <jorge.marques@analog.com>, Frank Li <Frank.Li@nxp.com>, 
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: adi: fix header location
Message-ID: <jmfzuymhxvxnjwk73nmsfaaadnmy5uy4uanh4jegwgdvgfr22e@2iqtifbsgxmu>
References: <20250916091252.39265-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916091252.39265-1-alexandre.belloni@bootlin.com>

On Tue, Sep 16, 2025 at 11:12:51AM +0200, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> The adi-axi-common header has been moved to the upper directory.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Jorge Marques <jorge.marques@analog.com>

  Commit: 2ad26b7bedcd4941e6dafa1851e2054b369b9d25
  Link: https://lore.kernel.org/r/20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com

> ---
>  drivers/i3c/master/adi-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
> index 162f9eed39aa..18597ba1f1c3 100644
> --- a/drivers/i3c/master/adi-i3c-master.c
> +++ b/drivers/i3c/master/adi-i3c-master.c
> @@ -10,7 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> -#include <linux/fpga/adi-axi-common.h>
> +#include <linux/adi-axi-common.h>
>  #include <linux/i3c/master.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -- 
> 2.51.0
> 

