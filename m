Return-Path: <linux-kernel+bounces-872876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B12FC127E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B54213B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2827B1F12E0;
	Tue, 28 Oct 2025 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YqWCnzOo"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA547A6B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761613754; cv=none; b=QAVaYOwuf/4llq5djThnON/JhBXx95piWaM9D7NbQHGHbal02Zzvn+JYtfi7A6PVZMdWwNW3lRQjGYiqEMZke4+gVFhsf1WN+0gnPd2yPfi5cHTClnAdoWgLw0V/YPuxGjKIL3KixEcXVZn4sF1qoYfQYCwM3pS6iUuXTMmjRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761613754; c=relaxed/simple;
	bh=pUm9xiCUI/xrjdBKVyej6cYWAqpapE1zoQBQ7lE+3zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOOdIFYTTwTeTBPL8h1RU+v/hOAuA6O4smCTLfo+zJiCcZg11OdIc4KmEod8qMpa3FzHXjqLoV3ZyfVW6vnMJjQaLFMkx+a2dK3Pgydd3jSwWHmzsfNGQrAoTe7CtHZ6Ax8EUQq5HkG+PTfssZ4szxvuxNq9uOSmW/OQGG0z1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YqWCnzOo; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430b45ba0e4so26793465ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761613751; x=1762218551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rciq0fMfQg5ykRHdo5BOaqx85Gr9r9nCGAwh1wrJfPw=;
        b=YqWCnzOoSWXBeN5aZRIbxHyK2QZ54P8+XL1Zg2rM/42Fte3WoPWAbkSRmaJ5nBwApk
         hDq3Xtz9q0oPWXwzvz4VuRi1uADRz2bOTyMLLEnmk0KLPhIbjiatHVjLgzuTEwQr65iJ
         taDfDehFEBkkiPVb8OYlKsL0NMhF+vNnOWUJ8cCDzBAUQbJKPDc/DLfHXsj4ITQcXmFm
         5uKQH00hYHfVMseTtqvVJq3qfbBL+6NKWx0ggvbqqONglO0IjukJtBZhW/wq09Ryy3/J
         td5rdp/k0yPfwLeaYeLXl4nHgg8X6iBuupBk0mv3vpbkI0dX2EixcqhNH8K1zhBxEM+B
         06Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761613751; x=1762218551;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rciq0fMfQg5ykRHdo5BOaqx85Gr9r9nCGAwh1wrJfPw=;
        b=rHN9ArIQwqiQOlgmy+yCmTJXekw0p08OhwBnmcXWWZWBz0zwY/PgRutp4Xs8QaJ33+
         nMhquewB+DMLZm2GUrNNnydcHJJh+SrkhLIBuGkkqbdmPdlO5K11iP6V8udOFwQwIwpW
         wG4miFbHss2jb9S2FWZcbTU/NAFLRmwcMd/9nWjxQfAymHsEbKSRPpfQR2TDg11boYC1
         f2IefdVRMxY//lRHvXFItD8BwhqRF1mReNxgjLKtgefnPJfndnuYLJWwqEwdUTQxKDtW
         yX6lcCCA1FrCiUgQUy/jlUBWrtLWqHdSHhEkv2r4G43QhnmB0qRWhohLUxj9u80N39VX
         Y9cA==
X-Forwarded-Encrypted: i=1; AJvYcCWU5ciaglohcIzaK5/dOcC/m3iuyaDyGld8lx2qfkENSOYdi3pACrZBJ+3XkfVnzDYiy3LkcoAMgu3B+3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNG/ZjoGvGPz734HnByfCrnJvWWKHSZd6+H96RTMAqoyF0fF1T
	5yenYK31vWoEfjSwKNYsVzArwdUPLJ1C69RKEg0K2dR7GvvNZb4wy+B1qrIdbT09BsQ=
X-Gm-Gg: ASbGncs5hd00UQ9R1Q43DZVToPtRl5XDPCh22aca7OOEaj2qv8jZwzu++VeQIQKGhqk
	IHmKgWQ0ffJSihWPMd6eJaOrLGKZdGqxwhHaV84K0I8E6SZ6y/6KeLZg2PHzZx/q77ds0wk34Yr
	hWY28nzzQOcjiRfFMQDypg+DLp/rDttLnJ5SlG91AcUq7ObIZPu6ZHZkvqK3gHaQ5vXgAeFon6N
	T05AuD6l+mFm/H2SVpyphaZnm9tDSCNG7WFKvuyRHmeVrPPG0DalccD1AKCIDQ4f/nAio3Pt5Nf
	G1Sz5qaUK0EpU3ghYnZM/dY2g5xn0v6yUv2rFtcLjZ5dwo00sfj0/H93OCnGFhddmWO9Yw6KJOF
	1871YdE8sJ+z/ZqNDrAEyYNU7ksCnWU+ConiOP62kjs6PlKMFt22GiOu1uxUnDpYVgE7T/brfDQ
	BgWcy+ypGW
X-Google-Smtp-Source: AGHT+IExH+ONq/sk2GCxVifXwkAd99wGTqxfx3DWF0CigPBYDCbVkbrMUCkN0RF51BrZL9SAPmmQaA==
X-Received: by 2002:a05:6e02:1848:b0:42f:9847:15bd with SMTP id e9e14a558f8ab-4320f860164mr25853825ab.26.1761613751385;
        Mon, 27 Oct 2025 18:09:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f67ea857sm36647365ab.10.2025.10.27.18.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 18:09:10 -0700 (PDT)
Message-ID: <d53a726a-6e77-45ed-a170-6e1463927440@kernel.dk>
Date: Mon, 27 Oct 2025 19:09:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] INFO: task hung in io_uring_del_tctx_node
 (5)
To: Keith Busch <kbusch@kernel.org>
Cc: syzbot <syzbot+10a9b495f54a17b607a6@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68ffdf18.050a0220.3344a1.039e.GAE@google.com>
 <d0cd8a65-b565-4275-b87d-51d10e88069f@kernel.dk>
 <aP_48DOFFdm4kB7Q@kbusch-mbp>
 <e6fd5269-d6c0-4925-912a-7967313d991c@kernel.dk>
 <aQAIR9DQwiySzEj-@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aQAIR9DQwiySzEj-@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 6:03 PM, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 05:15:56PM -0600, Jens Axboe wrote:
>>>> leaves fdinfo open up to being broken. Before, we had:
>>>>
>>>> sq_entries = min(sq_tail - sq_head, ctx->sq_entries);
>>>>
>>>> as a cap for the loop, now you just have:
>>>>
>>>> while (sq_head < sq_tail) {
>>>>
>>>> which seems like a bad idea. It's also missing an sq_head increment if
>>>> we hit this condition:
>>>
>>> This would have to mean the application did an invalid head ring-wrap,
>>> right?
>>
>> Right, it's a malicious use case. But you always have to be able to deal
>> with those, it's not like broken hardware in that sense.
>>
>>> Regardless, I messed up and the wrong thing will happen here in
>>> that case as well as the one you mentioned.
>>
>> Yep I think so too, was more interested in your opinion on the patch :-)
> 
> Yeah, patch looks good.

Thanks for checking! I'll send it out.

> I plowed through this thinking the mixed CQE
> showed the way, but didn't appreciate the subtle differences on the
> submission side.

Ah right, yes on the CQ side the kernel controls it as the producer. No
such risk there.

-- 
Jens Axboe

