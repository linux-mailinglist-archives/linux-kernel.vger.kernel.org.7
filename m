Return-Path: <linux-kernel+bounces-850141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C6BD202C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6254B4EDA63
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD722EB5C9;
	Mon, 13 Oct 2025 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FAWUyDCo"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5B2F28EE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343779; cv=none; b=hC+iRafwm7DO1tq1AMz6cyVId7inIuHtZ2HRdhxg7RFTpJAwKax4Blg94xnatQYWSXCJU5EG0aTOD64ajwx7h8WGNuxTl0JKFPSJfWaAouuW24FE6n/dHd5kfKdXrK4KPCz01JAwkPuMABkEkwdSxq9z/1te64FoBUosriD6lGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343779; c=relaxed/simple;
	bh=THqrk7vbef/6sb/mlknZIf//xoqNMDU/tDopHIa4iPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUeRhRJ6vIK8dGUe/AOLX8odPrwn5aruQZvjr8oP9a5r4VLHcSkS4wuU1H2nklpr0qX+MXA8SSOeLrEQVH0laEhqBbcCFwfFU8LEHKmFVl6fkjpH6IJcXKdhBalcB8dmUVMaqYb4753kF5SuZisCOoJ4R/ZU+ATeaCJIY7v7MLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FAWUyDCo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso22048495e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760343776; x=1760948576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dEHYiQm5SufHmglUw98qam1ZxeS9M37DvQYw/3sx3ZI=;
        b=FAWUyDCod+wwnmVuQOpEcSyIJEUKoDLtNTiBenU4bHvBCEbE2eU2d35r0t4kNVz9LM
         W0FEsVeNWbCyATBdDiynRuzdQWgWlsLpDxGHCkE9M9yaghiizjjS/iJLNN2h0fhu3hr2
         2O/ZcmciF3dy7LbH9wFsreQpfhKbSaRYUAzAHY+2FytP2Xyjl+LFsjdODlzWNQFO06Vi
         VG/9WQh5JC8ektjgjVxgxKpF3S7UEWL4pzxiKxasvrLnGPXlasKYyXJLw4PpMTy6Lzi9
         tQW1/qtmLbkDcutFU2XYGKdk3xWO6zUwzgC26wiBkClAnspaaPsX1ctlfBnYn3appO0K
         12rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343776; x=1760948576;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEHYiQm5SufHmglUw98qam1ZxeS9M37DvQYw/3sx3ZI=;
        b=BPUbpDJQXkerX3ELt7EJJjcq5kWSnEebPlBZfLS1Hyc7vNw2aECHR7O45uCmcwWrlQ
         I8y1cHM1Hgh7DKKEYYC/tZ4tshWq3zffahLtANrOeTRTqUpDVQiC1aAaIC8IOvZVtVu8
         5JR55oqFxo8pALpCOVIXcvqbd1FqDevrurlIV/zVwFSFGS63ZuHF9m/x7Tr32av0CzyQ
         D1Y7kecsEXVlqhyI6q3wY5U6yKy1bH6ApviT+/3oiAIF8Adu+NAisnqQ7GdCK9m16bvZ
         415POk495pBiyWgs1HBOLr+TBARRJTd6+5LlE/BqMqT8behOwIpt0EICbsKrb/i+sWfW
         BsQw==
X-Forwarded-Encrypted: i=1; AJvYcCXOK7BdDvgQQ6+yL7QLNm4S+2FczO1X9+uI707p5sade6czQs97VhPTJjetQj9EHCXipoE1BofGV9vFqnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZi1zjpE4lvwPcJb9ykY108bUU1wdxs4paqeLovwKDOfX/aEMC
	4FsXoAYCJSag0aa16MJiW58GsIlVyn0kA5UqPsFvrbACYKQFG2bxzE4bFQDO84Ac9Q==
X-Gm-Gg: ASbGnctadfUBoSYv9JCV+MeSit6gkEIkVZFyKKLWlbBtEnQg3K4g9js9Pvg6BZyjFQ5
	6jjYWwONCbd18WooHNgGnDqmMHKzV3rxrqUcO5WRGUd6rHautj93Lv0Q5jJjfnokhwEQPv4h+vU
	vgATV7dcsruH0CuOe596Mv6v9eflYl2xVkZsr2GTU7GIiZ4hleZ5lkFgX+cbNsd6IMzmlgXQW21
	23aVN5SRzoYHuKYZtLVvbnFErTLr9DvulmZoGLYfQpz2CYrTZoslso3J8s+lgO1xyCWHPsj6/fK
	QAwx2iK3oQ0A2zQilx33Z0nfUcuL+PUzNucXME8YrpxK6C8c80DmmuJFuB7QvMTl0DxmwMOrkS/
	3H1Jd70Cqq7Z0EkwnR4GjlFu36mRHMeTzhRdY3XRxKIC/D1n0zxgq3J2oTUTbMMgDLDuv1WVYwv
	FDC+k87+py+Q0e4QfG4teL74B3/TtxmAG6+y2D
X-Google-Smtp-Source: AGHT+IHVl/cWr/IqalH/uVoeRFf3vc3mRN7QYao9WHRxI8lIT7f8+C/nPvoSQG6krLfu/alSF1z8Wg==
X-Received: by 2002:a05:600c:3e1a:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-46fa9af9842mr124450175e9.20.1760343775915;
        Mon, 13 Oct 2025 01:22:55 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm177963985e9.10.2025.10.13.01.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:22:55 -0700 (PDT)
Message-ID: <13cbd826-540e-4352-8e0d-ae0c9fbd2faa@suse.com>
Date: Mon, 13 Oct 2025 10:22:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: linux-hardening@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
References: <20251012195514.39003-2-thorsten.blum@linux.dev>
 <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
 <65bad926-22fc-41da-b9c4-5857a002b377@suse.com>
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
In-Reply-To: <65bad926-22fc-41da-b9c4-5857a002b377@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13.10.2025 09:36, Jürgen Groß wrote:
> On 13.10.25 08:59, Jan Beulich wrote:
>> On 12.10.2025 21:55, Thorsten Blum wrote:
>>> --- a/drivers/xen/xenbus/xenbus_xs.c
>>> +++ b/drivers/xen/xenbus/xenbus_xs.c
>>> @@ -546,16 +546,13 @@ int xenbus_transaction_start(struct xenbus_transaction *t)
>>>   EXPORT_SYMBOL_GPL(xenbus_transaction_start);
>>>   
>>>   /* End a transaction.
>>> - * If abandon is true, transaction is discarded instead of committed.
>>> + * If abort is true, transaction is discarded instead of committed.
>>>    */
>>> -int xenbus_transaction_end(struct xenbus_transaction t, int abort)
>>> +int xenbus_transaction_end(struct xenbus_transaction t, bool abort)
>>>   {
>>>   	char abortstr[2];
>>>   
>>> -	if (abort)
>>> -		strcpy(abortstr, "F");
>>> -	else
>>> -		strcpy(abortstr, "T");
>>
>> While at least in principle a compiler might be able to transform this into
>> code not using any library function at all, ...
>>
>>> +	strscpy(abortstr, abort ? "F" : "T");
>>
>> ... the use of a n on-standard function (without equivalent compiler builtin)
>> doesn't permit this. IOW why not simply switch to e.g.
>>
>>      char abortstr[2] = { [0] = abort ? 'F' : 'T' };
> 
> I would even go further and drop abortstr[] completely:
> 
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index 528682bf0c7f..c891af7165f5 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -550,14 +550,8 @@ EXPORT_SYMBOL_GPL(xenbus_transaction_start);
>    */
>   int xenbus_transaction_end(struct xenbus_transaction t, int abort)
>   {
> -       char abortstr[2];
> -
> -       if (abort)
> -               strcpy(abortstr, "F");
> -       else
> -               strcpy(abortstr, "T");
> -
> -       return xs_error(xs_single(t, XS_TRANSACTION_END, abortstr, NULL));
> +       return xs_error(xs_single(t, XS_TRANSACTION_END, abort ? "F" : "T",
> +                       NULL));
>   }
>   EXPORT_SYMBOL_GPL(xenbus_transaction_end);

Hmm, which xs_single() indeed takes a const char *, it then casts away const-
ness before handing to xs_talkv().

Jan

