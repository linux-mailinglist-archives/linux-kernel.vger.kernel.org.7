Return-Path: <linux-kernel+bounces-788948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D58B38E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700833A8573
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47B52F7468;
	Wed, 27 Aug 2025 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BWwsJX2H"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A282F6175
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333413; cv=none; b=VpCZMFwmlTLqYgK8ns3YXT7YSzGMnc0ooQ5ClNc0sCdUhrbMepUm1CpfBTEFgH7Z+X8Ty7dDGVG+JjSEBJ+n0FSi2K8sQYi0Z5qpSotaex6xxwDQw01aprQA7AJxru3L+xVB4aq4SG/9FNdY5xv2DG96A5yrF5FpQt/6CZrkFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333413; c=relaxed/simple;
	bh=Koedtw7q0lWiWCcYzjgUSinsr/wTxwCoNrsLzxhoFtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoHSGBTrlT6GPzpE1HM8lvsbjXrnEuoi2Cl49VwdtwZp4RjRXOS2yu6Nk1gJAya2P1GX/bCtExjApKQf3zs2UIaMpNnOOTIRRavdfJ90S5gXiZ2EFl1fq2y8ZBTPKdMp9BXcxB0R9Pn+7tXLjbFf2AONS2o0dujhSFF47h2pvJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BWwsJX2H; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-771e987b4e6so297709b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756333410; x=1756938210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxFYz5su5aGOBTMJArO0RJNHBnuvaDOgygQdn3ZQKyw=;
        b=BWwsJX2H9DITW32BrGbArrMOkBoMCV0xsriyFVr2hyE6XAylX2VJ4w7wuMWtZSMA1M
         XKQKOnjjPFyfwvoonK2xO0wFVEJAkVQDLBJUJHs2ETQp1Uf8j9+bci+3+B8Kxm5ehFJA
         VowsXvQxrDB0su5OsQkleRY36IH1hruM2s4NeC44vcZsLv7TKC4xJIRrsou499k9jSgj
         7TbstJX21/LPYuOggew3iI+H+qBTx14lVf6J6a48zLrZgpfaIM7DQez2qzRQZMbMxaz9
         AI+P1LtcTzmL96GsMDfikwjaG1OsIMEQMDxwd6LOk8qih0clxLBiw81DHbX42bkSuv3O
         V7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756333410; x=1756938210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxFYz5su5aGOBTMJArO0RJNHBnuvaDOgygQdn3ZQKyw=;
        b=grAFypb7yTwfERew4qXRkF+ActrtAz7ZFHVQT0n+md/kwQbwIfYh8FZVwi68e40fL9
         3i3KEsKal43OTJoA7O6MBvwznmfy7TdSc2PnvYaOiB6IMQHke/998e8U7pd5rdEaNlFv
         DAS5shALj86E2GNahMc4DwYsMmtSosm4KCOu8XI+doAYqIzT1BVI2ap1ASIzrWyMbOju
         q9qjZSSUSPiloQlkjFp4GJxaf57PQMRInbgPopARCOu5dmeL9gVX8p3kounAdDrxGJQa
         l7vN7UU1OH+Vgj/aVZmCuycvSW39psUP7eBIPur+QvoJt713gsINHfuFj6r2HiRNG78D
         rADw==
X-Forwarded-Encrypted: i=1; AJvYcCUd9nRUcxHndsWhdyXfM2MSJfZzqrE0mLaI8OIFXFpZIx6ZKZ6zWmT/AUzll60OHBPwAwO+xOlutOYiblk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLlWGwaUVQR2SnFpqfR581SBSHRTN48jVDvmqxEjk5VbRfj5b
	dVz5x0nt/kYWyDgWUJAJYH1aVlczeUP0c8NVxABH0jyLS+C+q25E5M8QiOAwn0fKAXzIL+i4CpX
	2Nfa+
X-Gm-Gg: ASbGncv1mHjM6uweaJ3k6gnHw6dtdKysJZSZRpQKswpubzFlFTATebBc6CQB9CVMVa9
	IH28HJ3wM1TXPaD37791pygdctf7uKL/kmWNp0B2xJy39VfPHg4qUBq8Ljxd/vzr/4C6LQCdqrD
	QWxGx/5ZwYUJ+953sDoIXSpU6+VWDSGKPC8LnkKe7wbNnsv4lShqH6+mPZLFumPvgNiSGwPWz/B
	4wZN1VTsfcIZpFgglO4TG4AtWoZilDVeq8rnjO0QTJJXSkeNNWFf6MkIwvZIGY2fhhBaDMviXzZ
	koTOvJQ46Mq4N9pRftcdskHsI9DizVeBPl2TM115bWuAydmxliTweKCYhsQD66KjCoK9IVvCXEG
	8viM7GWyfTON5EpuvRcUD
X-Google-Smtp-Source: AGHT+IH3o5DBqG938ns4gTHALqTiqdJfZVA/v8WB+nBjR0/wmCjbESOn8ppRetrlrQ4Ln7XLDlrgzw==
X-Received: by 2002:a17:902:f60d:b0:248:79d4:939a with SMTP id d9443c01a7336-24879d4964emr82700735ad.29.1756333410184;
        Wed, 27 Aug 2025 15:23:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b7299dd1sm15506835ad.131.2025.08.27.15.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 15:23:29 -0700 (PDT)
Message-ID: <7ac936ab-ff4f-457c-a745-56bccaa19a08@kernel.dk>
Date: Wed, 27 Aug 2025 16:23:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/kbuf: fix infinite loop in
 io_kbuf_inc_commit()
To: Keith Busch <kbusch@kernel.org>
Cc: Qingyue Zhang <chunzhennn@qq.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Suoxing Zhang <aftern00n@qq.com>
References: <20250827114339.367080-1-chunzhennn@qq.com>
 <tencent_000C02641F6250C856D0C26228DE29A3D30A@qq.com>
 <fcfd5324-9918-4613-94b0-c27fb8398375@kernel.dk>
 <4b8eb795-239f-4f46-af4f-7a05056ab516@kernel.dk>
 <aK9_u9ZK9NgKiBkE@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aK9_u9ZK9NgKiBkE@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 3:59 PM, Keith Busch wrote:
> On Wed, Aug 27, 2025 at 03:45:28PM -0600, Jens Axboe wrote:
>>> +		buf_len = READ_ONCE(buf->len);
>>> +		this_len = min_t(int, len, buf_len);
>>> +		buf_len -= this_len;
>>> +		if (buf_len) {
>>>  			buf->addr += this_len;
>>> +			buf->len = buf_len;
>>>  			return false;
>>>  		}
>>> +		buf->len = 0;
> 
> Purely for symmetry, assigning buf->len ought to be a WRITE_ONCE.

I did think about that, perhaps I should've mentioned it in the commit
message. While the reader side is important for the reasons stated, the
updating of buf->len isn't really as only the serialized kernel side
will do it. Hence the WRITE_ONCE() should not be needed on the write
side, outside of perhaps documenting that this is a shared buffer.

-- 
Jens Axboe

