Return-Path: <linux-kernel+bounces-786138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A50B3558E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1BD3AD35D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28E2FF653;
	Tue, 26 Aug 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hBURJdCh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDDE2F7466
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192935; cv=none; b=YkViBwgXH9TrjoeL6Khm617u0QCV2f3iD2cxONwf2QjC1Cod1ILfArjBX8r8XtpZC722fG76apbp3XXyzODFXfA7Wo0DU6q0BUdIP9xtTUWJd5FdJysj0ahncK5LAyw8TH8JtpaWrdS4gvpv8MtSssLf2ayZwjOKmTLxU06fU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192935; c=relaxed/simple;
	bh=tpAopQcJlUm5aGXuC6C52OU2Xq7w2r75PhlUpyWQKWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RibTcwVBHOsGZU1CRaxZLkUeYbuTQ4rrfidOCM4pnXUxoyKl7be75TPqL8CvF75WeRhQ1naQ2IiUWO3k/qPCKlcQzdrEKhFhHT2M/rfKVJAujfp+JUCkO6SjHBx5iC2S0YaIxirdmktf75KILKF0eZ19iry6hms6FT/g0U+/rsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hBURJdCh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afe9358fe77so212327366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756192931; x=1756797731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+Eeg5T1lgi/IZJGN2U97jLj4V4n1crk0Ak7gDI/JlY=;
        b=hBURJdCheoOrOGdh3Z2Mk1upcd1iVz/OadICNJ0I5v1AUj7qPkhqMbCMNoqLXn3BI1
         Kh8Z4/yqmavwyp4F2C3wt6oxJCySJdV/yj2kajwaplKFAdFhLsSEwGP82qrKjWEWtLH0
         QTv+jOw5GxJ8ZAQP9w6PKHan+HsXhrwRoo0j0FzZhU9RgXxYBqkX0Pf9T1SDMCoTvwRU
         1+xuzpvhLWS0KCgFdbA6zNNbQmZeuHhID1/O/08z0BxONSMcWlNX1/Rn14PPsGWrlCpv
         ydSSO8IwrbbtKTd51pycuWNfB3IGt4Iy4fVU5DUb89L34NJur1p3eTOhoRU99cWqr4jV
         WihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192931; x=1756797731;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+Eeg5T1lgi/IZJGN2U97jLj4V4n1crk0Ak7gDI/JlY=;
        b=edUoJYaeyCwYAHQ+RL6eM4v3iWE3huGfpCdw65G2r2xeoDlp2/NZyc9BJvmA7ZWM03
         3JTT21w2ZjcWw70EtbSC2gfhpFhpxjb91KaI/c6IQbWvK+77R2PHct8WTnPdxEOJjIQC
         gEVXoKyM/m2K5QbGci0LHGZDerVvf4kXb8Nzf38O5LNvLgpoV/m8qE+H4RXZ9xWJdGPR
         y6PlQM3xpTXSeACQNgu/qpIZ1y77PhD1w1lRMlLkcGGSOJLs3fskjFaqG34UXG021Ong
         D1SYlWlvue6zB8tipgfJzu7uRDPZF6MWEVkx+qFrsYVKaU15KpyzkRvBSqfV4L/L+JR4
         SEsA==
X-Forwarded-Encrypted: i=1; AJvYcCUzUfCkWRn/jG9J/RQyu6hV1nedboy2CMFdgUMOba4bDvIqvohiYExm2s3tBdtWUzBmmNCxsshetEi710g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUXcntbMLSe5ohKdeNxt1mYn4/hVi8K1fdkcSMMfsW1l45+bBb
	ry2AApbdksyZT2BdT60e2qjY7CpE6IV8kvZW3odyDM+3EB6cxesa6Wu3Eq3yED7UEQ==
X-Gm-Gg: ASbGnctcjsP7Z9ZdaBkPvrK593fU+I1wZzpzaBnzJ5MccqL1FuwKbiJhSYpp0EylKCP
	E63AsmATGAL+h0s35ZreK7OwLMmKmIu1A+aexnZZVdOhlPL+MHox8pHnBfvHMy3BFVxAFQZ68UQ
	48/XRzqB+K26avaHFqMxyeezYgKvdB8G3oQFe2HhAZ2vhiEUMJeiwZPzTnq35eA72e1C34PNLeL
	ib+GWsqC+98/VJwXACigATJ6eLmVKAcgGqfXHkftQBRa4stCc4L2vqC4mKCtu+L8aO7TgDDjrXC
	8TtmYjiUuRLZ2Q/hwpXl33CcNKC1Y3NjhrEECjAcWSqtP40nXo+tk4GTkc8pZwzeSd/d+E+s3Zr
	eOs42IViyuX9mVneitF1qJtZ0bwQZy4f59Iu27OLNLrZpUbFso1SG/xOyeh3m5cNSg3voZClTqI
	07s7utyGzR7GDWO5s/BA==
X-Google-Smtp-Source: AGHT+IFq1+7gcPtTI/IHi1JY64n9+doFUXl5uDLjIxRHGK9YksCbPbbha1xbHm9UUItiA/okK1Se8A==
X-Received: by 2002:a17:907:72d4:b0:af9:3019:6aef with SMTP id a640c23a62f3a-afe28feabb8mr1416475866b.10.1756192931337;
        Tue, 26 Aug 2025 00:22:11 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afeae4ca4bdsm58985366b.5.2025.08.26.00.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:22:11 -0700 (PDT)
Message-ID: <de9005bf-c858-4e7e-bea8-33e5ea2424fc@suse.com>
Date: Tue, 26 Aug 2025 09:22:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] xen/events: Cleanup find_virq() return codes
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20250826005517.41547-1-jason.andryuk@amd.com>
 <20250826005517.41547-2-jason.andryuk@amd.com>
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
In-Reply-To: <20250826005517.41547-2-jason.andryuk@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.08.2025 02:55, Jason Andryuk wrote:
> rc is overwritten by the evtchn_status hypercall in each iteration, so
> the return value will be whatever the last iteration is.

Which may even be a false "success". Especially for that it feels like ...

>  Change to an
> explicit -ENOENT for an un-found virq and return 0 on a successful
> match.
> 
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

... this also wants a Fixes: tag and perhaps a Cc: to stable@.

> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -1318,7 +1318,7 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
>  {
>  	struct evtchn_status status;
>  	evtchn_port_t port;
> -	int rc = -ENOENT;
> +	int rc;

Maybe best to also move this into the more narrow scope (loop body)?
Either way:
Reviewed-by: Jan Beulich <jbeulich@suse.com>

>  	memset(&status, 0, sizeof(status));

Having this outside of the loop is a little odd, too: It makes assumptions
on the behavior of the hypervisor (like not altering the structure upon
error). Yet likely not something to deal with right here.

Jan

