Return-Path: <linux-kernel+bounces-789873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E07B39BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5D83AA231
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29BE30EF89;
	Thu, 28 Aug 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PkWx0Cdo"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6D30E0F3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381807; cv=none; b=m54nI/MET92QY0wDmeTaQDWhawBc/q8IeHrscska5yUAX18ejW2+en1ZQrJXr3OoXEWleUcxC3tjLKdSCESnPmJVYXdRhvKEha6tn7rUZRCwmjmzUmYtNVY0E6GiEe2ewXBvLkjc9SqpER9HjEaBwtCHHbHmO0S5ldt7Gfm2vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381807; c=relaxed/simple;
	bh=/wf8U5IKj+z3YPZwIzpnehBZFZealmv3pS9JcwfsdIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIkeRbhm5iXYAtKNcH468RUg9EkIDoAb32yJhzroM6qOOi8JCbyofifyaD6uQkdA8mvEY9V/aPvlX1QE2xDfsYvuY5R2rLZOIRHsYO7r5T6UpsIFts6cggqKhEim07ct7arcemne6pFabcUsHXN0k//dH0p12RJ2CgRW82rO4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PkWx0Cdo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so860214b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756381803; x=1756986603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjwNXVfVIbch6ui2Lije+o4C0nxjdug1cxVSvsXhRV8=;
        b=PkWx0CdoSUkpozQkkN6b92dwJk6kGsB1oNuweji4vy5hAxK2eDby7hQUzqD6kA25zx
         HHu2rvl6eWPo4+rguJVqtQIIyKwqoccph2UKkCaaV4Fjem9AOkS9XjZByqYm14DwLB9z
         8KArWmMz1rIyOyK5AxJ+SqQBMSMqhbm87s7h758FUzwl3BqKaPrdo+nsa+lFeoxt2jU9
         ZueFOpD8pdaMj6YTzpoNqHI8yAQ8HW4uJcgYG8du1kv9VhwTXufMlA8yn5cFAbdU5ZX9
         899uRtUgKnfTP5nmrXNJkxkKw69tbYK5CJSbpuUyZXe6OUWczHQFScQkQQADPY0VJ4+Y
         v1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381803; x=1756986603;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjwNXVfVIbch6ui2Lije+o4C0nxjdug1cxVSvsXhRV8=;
        b=KwfMZ65VGEOlqj7VBEOOpuIJKy6qGLzF7ArZ5GRx34C9+FGii1t+GnoFr5YvASxTpf
         eoEo/UBLrPOOuFdvg4A0E6heiDdRWdEIl6RF2i3aZfDtZCvFAqmTe2nieAuTAAba/7bX
         tuffDEpYZUdPhAXDMVF34sDshMrKSaRmv20kgJklJ5V8Me8hlQXQMvznOLjHCaKQE/Gr
         IyamyCOfO0aoRgWfyAsGHycQUc+2BpbYHnXFPmnWOuJ05/W0ZTGVwRIJPNfucBFthkKU
         EvDOErT2gtcvVW302w4b3D7ObIP/K3Q+7qiP9LwlMEtqP7S8GmwpH2VjHNmK0Rp2HcRK
         jTig==
X-Forwarded-Encrypted: i=1; AJvYcCVb0pm6pCshdbU8V7+fW4d0i7Yn0d65Ah61MISZ2zXfBNgdUBKrXyCymYmDs+xTRu/Don2Kiimd1syZnnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpweLNc/eEg2axjaEFdaIgqXOLK/GYm7itPOoKVQF2358WVzi
	StN82g1sCYL0zq4Bc9HPpZRJbqlLpalHZqvoZx8Hj7F3XeeN9ij3smfomyMaRB2h+Jo=
X-Gm-Gg: ASbGncvwD63zgWCmjtnDAgFt9Xvngh/KmgaOKfpZiAe3AuX2GT9Jj8nWgXPDTV0Wki1
	+iTBX/EOIyuhbnQRvVCHi1C4ExL9AHI+TQ2RYMYspTVvxGk07bgKJ36og4YC7DnWb2YOObXT/2z
	obqzuX0lkjVXGPC2rxONrBRr+4nG8mxPo6wNKrXGe9zW4I4GTl91TIZDyzCXan1zcScX3HZBXzy
	s+SzLV0oGIRFVsdWN553PbeiVbaZ8mp/bstlk4QuoliE8LqQcZvjLsyiJATfbsQSZEZtpxbX1IM
	+9dB4fPcGzDun5uq/Tr2tm5w6Lj2bioHsbV1qND1aiDK+SL4RBeR/J9mZX7HQuLRzM7AX7Yn1UB
	Rpf6rZuK+7zgDN/kvXNcj
X-Google-Smtp-Source: AGHT+IGezOevIvE7/Nrz9LwifFeXlERPcAuSJuc4DRgcIe+ZiJiG+BpjvRh20H6Ivk7bP2zeqoIoMA==
X-Received: by 2002:a05:6a00:4b55:b0:76b:fab4:6456 with SMTP id d2e1a72fcca58-7702fadbb34mr29937177b3a.21.1756381802961;
        Thu, 28 Aug 2025 04:50:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fb852dedsm7163605b3a.88.2025.08.28.04.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 04:50:02 -0700 (PDT)
Message-ID: <3aba1ff4-4e8b-4f34-b300-5e7aeb18ec15@kernel.dk>
Date: Thu, 28 Aug 2025 05:50:01 -0600
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
References: <8f4a4090-78ed-4cf1-bd73-7ae73fff8b90@kernel.dk>
 <tencent_2DDD243AE6E04DB6288696AC252D1B46EF06@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <tencent_2DDD243AE6E04DB6288696AC252D1B46EF06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 9:27 PM, Qingyue Zhang wrote:
> Thanks for taking care of this report!
> 
> Regarding tags, it would be nice to add a 
> 'Reported-by: Suoxing Zhang <aftern00n@qq.com>'
> tag too, as this report and reproducer are
> developed by both of us.

Done!

> And absolutely, please feel free to use our 
> reproducer for a test case! I'm glad it can 
> be useful. Your version with idiomatic 
> liburing looks great.

Perfect, will do.

> This is my first contribution to the Linux 
> Kernel, and I really appreciate your patience 
> and quick responses throughout this process!

Let's hope it's the first of many!

-- 
Jens Axboe

