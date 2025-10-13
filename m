Return-Path: <linux-kernel+bounces-850051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62DCBD1B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EF13A3055
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA02E6CCE;
	Mon, 13 Oct 2025 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IaqCnZ/l"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70451DE4CD
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760338755; cv=none; b=JSGGK0tNVz/bU0dkLts8RvV7A9G9s3uHrDZuUBz2lLcHQ3Cr/v1kiNotBU+NwUewTB4+UKRYP0MMFjNFiApN3C1LrxRJWDyuKlWY4a8qDnq695DcZfu87UAROg3dgs4PW3IXy5bH8FvrX7sh0jYlmF5qxDD8J3k1///jKp0XyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760338755; c=relaxed/simple;
	bh=86ECSOmfJBWcuFGxNNZ2ysv5zZ841yDUPRfso1H+2Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/GbfuwqnTAxuhD+Pqg6K1RHYhLrdQkZMYSUacFaFavxbS+p0CtjsQXr+wbemk0hjZOVZOUVsH2nYdVG1WAb7gvK+AkUKtcYcb3gQKyWEwZYFOxwUYl/uapiq+CetPd8A9woopsXvfES0SBiN3kFFDhYujquZOdTNoNnhLVgwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IaqCnZ/l; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso21495785e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760338750; x=1760943550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZpLoWSAxU2G8AVHL931DUMQsZx2voyuF6q/+oeSly4=;
        b=IaqCnZ/l5aYYQi1z4NvHoqKPUTgJBXmXITqIBH7AhnrJoj0FdHC+vOHJG0byNRxsLj
         7qSR3HGN0xwaR8PdY6ntVbDwx0zWWbT7U3K8tQzcL3PyFf+OmR6TbnTQm+TsisrvYK2v
         baJCjg93SAaSzZ5QBTBNoHyAvVaLfMj2kYaJgDMVDThDMMLHl1ejiR7i3l/h4FN0VZrj
         DFFRIgJAQMOULiYvS8tZiMCfsuNNZO1JwS1Cr+kKEIhOUnA41fBWjJ5xx84yAxL39r8s
         QbcMPfN2Av0tvU0qhsiCw5o0NnzO/ADHRBtnkYn7QCWMuXECOC81h/CqhNK3ze0h3ko5
         T/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760338750; x=1760943550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZpLoWSAxU2G8AVHL931DUMQsZx2voyuF6q/+oeSly4=;
        b=wWcgtMgyIHj1e4Tx7t2leAoKJCC2S+e4ohDP3w6xu2PioCF8uZ5k7pM6O4zeEsyKJ4
         lQsCg03wCHCikoIsTTg68llY1ytXzFvvAjhVtkSA1AQ8sHtBXYVF5ha/Jf0/SJj8fIoR
         ClWRdrKXyo5x9ODX2wbUdeFATyDNLljP+81gQhc59g7ii6Urgo/dZFgbqXC1d/Ey979i
         8J7pez1nwItMnXGDR7GQSoKP64hPu+LgD5bF0QKF8hjVgxEymI55SXNOI1rfXAj+CX8u
         AcxyquOZdTe0BIjXKT1kGMTZV9ClNdQb58gCHTagJgypECv2zHNRsfEqYg2cyc50uW1c
         PUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZQyPgOyQMOAv0rWFKAPEQMsqm2w4hCPrk7yi5oRO+HsMHVHgOk4u7TgIu+IeQdU+ea0A1DNdCUo17xbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUzu4S671J0/edPMXStLfP10+8o7MJiJHlVkZpbp0o9U1vq/Mg
	bHdgP23AUHtV56AveefBGjsKk3i1o8erdtOO0mGUblL0p4uGa0aocgrsKNCuSEoXV+2GbChTp11
	UBWI=
X-Gm-Gg: ASbGncunX4dgkYMA6y6UzWaTDltLRYxyLPw9LqIPt+4V3/ffbHOHeXs+0QzBkfbB8hH
	YCKA1qNlTuPK5glayXHVtCpxcPIv+gOTxsIoGHuraAmjKhfXx4R34f3/F8gxMGNIBj/B1NMrSD0
	syTYGS6dfL/kP2GzOMBfF6g1/wUh0JR9XlWm6bAQdI+1ZTtOSc+u7VjLCnCHmuQIfcM0nGGq6Vv
	hsk1ZIBBqysMYPGAPgacrGXTnN6bdVWul6hLBJ4nCJMfXEdBwg4KJUN5B6YX5B0JD490do/9X+i
	PC/BM8lLZy0kd+2GM6wO3x6r6eNbUmmcrTEgNIw9CQQTLvEhRKR2E3hn1Tf/pDobtQyiHMrE3n0
	hYiUhJ91SAehQ99mhxeecaeMVh9W1LU8utAIUuyTNnQ+KLA5BnoVhZP+RXTqtSffR/QNzCzC16X
	nP3wd+1Ns7cJCmGqIo+1eGMsxz/g==
X-Google-Smtp-Source: AGHT+IH5VvluhJwPowoICILvdjdM0MHl+DmVnGQ43MOA2t6u7NnLqzoJ6LIu68iyp4i8VDiHpwKChg==
X-Received: by 2002:a05:600c:5488:b0:46e:45f7:34fc with SMTP id 5b1f17b1804b1-46fa9b105ffmr133685265e9.29.1760338750080;
        Sun, 12 Oct 2025 23:59:10 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4e22d8sm118354975e9.5.2025.10.12.23.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 23:59:09 -0700 (PDT)
Message-ID: <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
Date: Mon, 13 Oct 2025 08:59:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
References: <20251012195514.39003-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20251012195514.39003-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.10.2025 21:55, Thorsten Blum wrote:
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -546,16 +546,13 @@ int xenbus_transaction_start(struct xenbus_transaction *t)
>  EXPORT_SYMBOL_GPL(xenbus_transaction_start);
>  
>  /* End a transaction.
> - * If abandon is true, transaction is discarded instead of committed.
> + * If abort is true, transaction is discarded instead of committed.
>   */
> -int xenbus_transaction_end(struct xenbus_transaction t, int abort)
> +int xenbus_transaction_end(struct xenbus_transaction t, bool abort)
>  {
>  	char abortstr[2];
>  
> -	if (abort)
> -		strcpy(abortstr, "F");
> -	else
> -		strcpy(abortstr, "T");

While at least in principle a compiler might be able to transform this into
code not using any library function at all, ...

> +	strscpy(abortstr, abort ? "F" : "T");

... the use of a n on-standard function (without equivalent compiler builtin)
doesn't permit this. IOW why not simply switch to e.g.

    char abortstr[2] = { [0] = abort ? 'F' : 'T' };

Jan

