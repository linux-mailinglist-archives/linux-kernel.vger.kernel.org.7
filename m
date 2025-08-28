Return-Path: <linux-kernel+bounces-789168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC740B391DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2213461F14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8C26A08F;
	Thu, 28 Aug 2025 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ex5P+M77"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9518C03F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349431; cv=none; b=lm4EsucUc2BlF3FAkbTEMa2xXyIa9LuhISLgJmRANOFdPDNF6uyAg7FQXe9kyo6bw8TJV8njvodjyK4imr4yzKTlulQEFck/Rlc3cTsHSZl0pfB8gRe+gay3vywAEb1B8Loq2c/TLlZVvnG5JmvFq1cHyypzlpLwoOwnonCpMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349431; c=relaxed/simple;
	bh=UIefXmkkwDn7msQkQbZM7yZZpmCmufplx9uC9EFw3ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNMFqk+Ni00Pcve5XuXMqQxI8zqzQuJbcbPGPCJWF8oq4Lt1oMT1KHuriOtj5HVP1bAt4EvIFTy117l/05nK7BCGV7Ex3hZrhSBZWV2vXy3h3IDVQme4j2DBqLQMeMQ0N1OZs7hv1U1YyLJ6lvnYbtQiz1t8A/VmuTX54JgEF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ex5P+M77; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4c1ed55930so493058a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756349426; x=1756954226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKFhfPBKU5aFdDy6tHlTA21oqL3oEJD1QCVMEEaNa0Y=;
        b=Ex5P+M77LR/8PuPgkqPQFMzWtjPPtD1crXQCwhhUEY40JPmAplMveU3yNB1R5LPSCV
         azavNCqgt/FaUfZmaTWFwc7c0FkO6eSHKs+Cl1U+DNvjIbaPasJS1p8Vs2GBNaZrlIgo
         JvM3ELkPhr+IrB5VDn4WGjyXq38b254XlzXzGb/NzSaowWJGtM9Qdg2RHm104v9xolXk
         3cfpK+y+dEmb5y8uyf6m1+65wIMv+y5Yl9uzdi7ypL/rhGrqzh9zQI7I93i5Sq0z8WOM
         HDASTh+eNokCrDAHAu9j5akrc4DctSY+uGJDJy+wV5z/rM2Z78Mi8GQFS3JvvVhwS30D
         kJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756349426; x=1756954226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKFhfPBKU5aFdDy6tHlTA21oqL3oEJD1QCVMEEaNa0Y=;
        b=tw7qO3x70VeFZAbdWU69psVaynahe2/8zH/wSvTTR4QKCIRe19/Kuz9Xzzn/G65YL5
         uM/r88Qn7DCrpWPPRkvYHdMSdz2dpzCPq5j3PUQOc3dg5Teuy1C6Mky2juUslgLACUIJ
         CcvGrOuSPW2zKqS796UlspN4p4vUb5OdI8AhRV0SvTgAjWlJcI49fiPvRofKRIM3qgL3
         580Xy7XUayD9WB8RCHBsxBsLKoT6chZjUJf0J37PM/J69lwumIlXCrWOjuESnlTOdv/X
         P14+jRLHl8pTDgRd5LAYQm6z3+ntwcXridvZx6GA4ctnq2ALW6EpLz2sFmG3dh/fzle/
         xbQA==
X-Forwarded-Encrypted: i=1; AJvYcCXa1EgEad4t0B72saQmf3FWAo4ALzQHmOtNo7+5peq5ZIGrwHDX0kS4j1/lCzML6ySGFxhnnPxIj31p3k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzClRtUy5Ls1EMmn/0xJgi+qhLXbZ122+YaErMExcAcumFqChLD
	/oqa9y7+pIS1P1cNgKnjqtyDeqguLWtUZVC08pUUmCz4Y+lSlxbZ2YY3lev0LANT+mg=
X-Gm-Gg: ASbGncsxXsQE2/fDDdgd/ROKwNBjWflyxm/kmfrIRm1lzKPu02ooJkPq2zThV1jW3Gc
	Lbtd2JTsaccNi+w1+o+4J9s8sxGMcBSPBk0twMkBVqPBHLsGJ2eaGRqFrwTmANutO7hne4ohng6
	cm/o+xwlNOt54fxaxUu9pn4Q7pS5yNSMApYb+LKlHMUVeuJfl3wmYZYsWLx8J7pz9GXprMCU0jH
	GlpVcGeN4rH3rLRDPeG/MSSb9+XAFJILoJ3P16JBZCEYrAHzoIrqo7rt4MMHM+DSVUd28m1qGNF
	YnSHSyfWxIJJwQfQPSOHHbnoxeVYRtP54n/2yppoFfALazP0bwXc4Rg1RT626dXv3yVUxy0NVxH
	X8HBEdj2YWmEiIn7t3Uii
X-Google-Smtp-Source: AGHT+IF/97+1Ccx7YoDUnrBy72ODTzV6Lkd87S50kMzYOgYq3bil/9cBOlNAli1Lqsf0X0I8sew71g==
X-Received: by 2002:a17:902:fc47:b0:246:9a5f:839f with SMTP id d9443c01a7336-2469a5f8594mr205144055ad.21.1756349426384;
        Wed, 27 Aug 2025 19:50:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb88fac4sm12713923a12.9.2025.08.27.19.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 19:50:25 -0700 (PDT)
Message-ID: <8ed15a17-618f-4277-afc3-934939292060@kernel.dk>
Date: Wed, 27 Aug 2025 20:50:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/kbuf: fix infinite loop in
 io_kbuf_inc_commit()
To: Qingyue Zhang <chunzhennn@qq.com>
Cc: aftern00n@qq.com, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8abaf4ad-d457-422d-9e9e-932cab2588e6@kernel.dk>
 <tencent_87B68C160DC3F4AE06BD6DF0349B1B235E05@qq.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_87B68C160DC3F4AE06BD6DF0349B1B235E05@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 8:49 PM, Qingyue Zhang wrote:
> On Wed, 27 Aug 2025 20:08:05 -0600, Jens Axboe wrote:
>> I don't think there's anything wrong with the looping and stopping at
>> the other end is of course a safe guard, but couldn't we just abort the
>> loop if we see a 0 sized buffer? At that point we know the buffer is
>> invalid, or the kernel is buggy, and it'd be saner to stop at that
>> point. Something ala:
>>
>>
>> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
>> index 394037d3f2f6..19a8bde5e1e1 100644
>> --- a/io_uring/kbuf.c
>> +++ b/io_uring/kbuf.c
>> @@ -42,7 +42,8 @@ static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
>>  		buf_len = READ_ONCE(buf->len);
>>  		this_len = min_t(u32, len, buf_len);
>>  		buf_len -= this_len;
>> -		if (buf_len) {
>> +		/* Stop looping for invalid buffer length of 0 */
>> +		if (buf_len || !this_len) {
>>  			buf->addr += this_len;
>>  			buf->len = buf_len;
>>  			return false;
> 
> Good idea, it looks nice to me.

I'll send it out, I amended the commit message a bit too.

-- 
Jens Axboe


