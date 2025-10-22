Return-Path: <linux-kernel+bounces-865597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D34BFD957
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D1B3AD78E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06D25E824;
	Wed, 22 Oct 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sQnweMMP"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC0226D02
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153431; cv=none; b=RbMZzKZi9GzVkezmnF20hrAWxoewyCAXuDQUjaeHxi8JTYwK5KjkIJLBmt29zy5Qly97PoHkrNF+Qkz/+Q7yedrwT6kCMVu7l18179p277j1AD3VbrYLNQtClOZzncrcj+RO7jB/4SmURhZHAjM2eK7QJw1sKYn44XASyGT+s54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153431; c=relaxed/simple;
	bh=cX31mC1L5QeuvgXHfSdRp6tkkzvVsV4FrGOl48ObzNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pB0hAUkIatCpUg6kPa3c6tViBF7vRtTXd9wvfxztE+iQX3lLyXQ3+SVxpwVoMJPJ78KJ5kGif8uZjDNCmy6RhPVVA4sv7yzq9hb9mnH4cVjLraHR8b4TWQHYm0wi4N+arGCS/rZjo8XBzYquP5wTP+eqBsJDMHv9gsmeobSXOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sQnweMMP; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e9b5bafa5so175397739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761153429; x=1761758229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oM0p7h+Z2nS57Gy1ZwM4EQuA8iN1fOsBzNSYLHluowU=;
        b=sQnweMMP8CHMyL/HofxPazvE2sQZqBbJyLLpS22VnD4YxdW0kOi9lAABioRKBGCUA4
         tKTf1OWgqwDKmOsqvxkHItgzLpjp5cSk9kbOIwVvTVHAKFVv/l39ptgHMID8ikMSqoNO
         LdRECG/pOqp8aAgysKgTmF/iOy5PjFyZ11SnOGR/qv7qkxfkaYc9jJPCOMXxpRl9yRTm
         TE0ZmOwAMezyksZfTncysBTDg+BTxhy2NqnjCxrtNpd8FmFgXd05LuT5tYMvUxSFXSA/
         PNrAtz5LsjBRo/GBnzAWAxIsRxJPgxhPPAnLRht1UikO4p9BvVMnd8fDYCCJWb4qOBLw
         RnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153429; x=1761758229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oM0p7h+Z2nS57Gy1ZwM4EQuA8iN1fOsBzNSYLHluowU=;
        b=m8xFfsiaQL73aWnRct+7rCrncE3n9DypTIjtUKoAwTrQsdusCyF0OTRymqgioaWZHI
         P6jiIM8W0pE8tvEqdnoCeTVhujDIaTWMM1Y5plarKImrIWMSc9HmtRG6lpTNkaAwSXI1
         y2eu8A1uflbhAadX7d9OOGfWv3Nhtxcncw6uF39r1AtJqZqf+5Y+fmTYfoIgc5zbf/J2
         DRzmWh3XQ7ymhUfkBMLWDQKtgHcRU4TbfWSIHpbtpwTZ9L+3qvYL0whIpDz6TvEzWe6/
         fwdl74hEPWAnfPon2j/3qh1oWMcBdyR5sPUcUv3Xw/PQ1sjF5bfodQjFjhS9LtNfcAzX
         aErQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5gqIkYMytGwkcS5GaZv/IcRKn26Oho4E+FHOWo47fH5rgL32xPz/9oyr1BmiM3Y9t8SZcGTvqAkw7sXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9y/5wczFhyRJH2tvLb9R0bkOotse16HoL1zQqMWlrUwjmHgA7
	PQ5EQ5CRyXvhRJYqX0gmAa0QuQF90Y9Ye2Td+QstfEMJBeU8IndIB+UgelPd7bi35q4=
X-Gm-Gg: ASbGncs0DFi3TVfmxcwMtumWjXvYZP+RcSu9cMVIZE+2s35Zqa6WtDUGRYXhqxnuE5g
	5jqF6OVgxXvRbAXakYz9fqmk39I4W7H7a4N8mp6QdVgeHc5evyLi9bfLGnNDnuVK8sENcB5V0zo
	S+2ITqVwyw0bEafH8ln/CW8m8g3ft9OqDYd8Nz0MYAAt581gnsyHkNZ6sbxPnonX/GsDxNg8lPQ
	Cggp47CFJZWhkDmJgzLhBz7g8DIC8xV1C33OkiURcnSOwg5ST9WWePgTTeCWVaX0fgC4jOCOquF
	e7mRM5MNKaxthnsdni4dv8pr4C1JSC/1XWRZ0EtHviAywB7f8ygznKOLa3nWk/5hNt6zTzbSbSn
	2nbKG7lxZmoVfRLtX6cRZPbPtBjI88cpwlOMm4czYWhXMpZw6Kh58isxRuas2RsAcVH48EMCFjD
	F1bqvKR4U=
X-Google-Smtp-Source: AGHT+IFUrihliDU05HOaF3fbvtBAn1yJOynaHNfNlRjVB5r/r069hQQXDKG1Iw5Jmp0bDAblcl9BMQ==
X-Received: by 2002:a05:6e02:1565:b0:430:b59b:5f2b with SMTP id e9e14a558f8ab-430c5268fd7mr274791525ab.16.1761153428803;
        Wed, 22 Oct 2025 10:17:08 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9630bf1sm5375401173.17.2025.10.22.10.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:17:08 -0700 (PDT)
Message-ID: <a9074897-4bbc-4b46-8783-0084c5ab5d4d@kernel.dk>
Date: Wed, 22 Oct 2025 11:17:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Keith Busch <kbusch@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 "kernelci.org bot" <bot@kernelci.org>
References: <20251022162553.5dfb4df9@canb.auug.org.au>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251022162553.5dfb4df9@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 11:25 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64 defconfig
> clang-17) failed like this:
> 
> io_uring/fdinfo.c:103:22: error: variable 'sqe' is uninitialized when used here [-Werror,-Wuninitialized]
>   103 |                 opcode = READ_ONCE(sqe->opcode);
>       |                                    ^~~
> ./include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
>    50 |         __READ_ONCE(x);                                                 \
>         AR      drivers/irqchip/built-in.a
> |                     ^
> ./include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
>    44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
>       |                                                                         ^
> io_uring/fdinfo.c:92:27: note: initialize the variable 'sqe' to silence this warning
>    92 |                 struct io_uring_sqe *sqe;
>       |                                         ^
>       |                                          = NULL
> 1 error generated.
> 
> Introduced by commit
> 
>   31dc41afdef2 ("io_uring: add support for IORING_SETUP_SQE_MIXED")

Yep sorry about that, the current tree should be fine.

-- 
Jens Axboe


