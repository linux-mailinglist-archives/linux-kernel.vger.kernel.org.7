Return-Path: <linux-kernel+bounces-774363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F67B2B15F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257603B0E75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0233CEB6;
	Mon, 18 Aug 2025 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s1Pr1IAl"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558627703C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544065; cv=none; b=YbFbCiVv0kR3PNxsg52VTAlysG5J0RMtTyhl2c4aIxgeszHkH6LBE7Wlw4SRO/cuLCT8C8sAnohVR549PPC2xorHxiBmI+unXEOkb3amgAIivYrwJA7EaijpHEjpMtLM4fDiiup68p6mnXYkGs5rLmzC5Ph1M+V4r/fDK91d1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544065; c=relaxed/simple;
	bh=Ski4TKxNewtrUZds8NDTJNTqJtmxfNhmPkAzaqLMFSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzVUnoSw/XUWddUkrvxpCrlyBeoD+lMcYHwFXyF9GranS7uxS/q2eofO4YqzeSM7SWwN2id0k0MDmHL/LerHqkrNdKC6MQRKi7oIYM+sd3wOq78U9PHhFdt5ooGsHeoIuR2vf/oDE7C6zeuuN/rS9bsi9RPMp1AcLybSOaGdI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s1Pr1IAl; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88428cb5dfdso81063739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755544062; x=1756148862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGRep3tF7KiNS0qSwtnPInQlsC4SL0Dlef048RIg/sI=;
        b=s1Pr1IAlsKfuNxrzLr/JrOjvJyTQzIJyLgPSPqYIx67L2cu1O8ws3nY3SZ5InU1etV
         J0wM5OK55+jnhxdnuRh7wAmYkGPJkXaFrnL2yw+aIsLY0MaCXRa59qS2HVFvOByMS8mK
         duPm6KoLbkQBUZqpiyB7x2K2SQamyZDqLlzEf8TLDiIwXAtey3IznEtc7jpo7BW07Cb4
         P1Hx1cSz63c4U1XlqeuvsV3JVR1ymt3say/FPNfPmAKwz/MwMOpKBG2Xf9YPYF7hII27
         SqO+KUBWay4uKiYIlK1Es4sl5e1jUpI+hEFR89S8k0WDWO1ZUxpFY8eViuVPxxwGDHQP
         qebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755544062; x=1756148862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGRep3tF7KiNS0qSwtnPInQlsC4SL0Dlef048RIg/sI=;
        b=s+RSs7M2+bH2bSw85ypFfftmTI7qt6Sg/PxfPzs4oHUZgs7rKCyczEMR3ZOYtLmQxi
         W+zo4C+b9PJVkFlIfpvo835DVE62rG+iZXmjlWG5TT2ms/+TSTAtMFC4iS2jK3CXJUsD
         5/lUIhL/GJ0tu7rfvX7HlDcpUrPjLt8iMqhVa7XNRDkW1vVE4wvGywmMoxeMI9DOssOB
         V24reszHpQByyjcbMbhojOFyrryYdDk+9dReohyBI4WWYICYXxB6KezZ3UoP+wfbsCOs
         p1fibYBjmqECY+6JffdVgO8X4UPbygtEes0pWJjqZIJE7Ocv/Budzrsw5soGIzjw5QL9
         Tz3A==
X-Forwarded-Encrypted: i=1; AJvYcCWF6+GqJuPo70yhJbcInKJPOf+V2LpvJRH/OrZw78nWuDBy/D+sJAZVzPBtpgWRL6apizkDFv/7fNK1Euc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvm9GvEni6/df7AbEudZGsL/hTHCoj69b+AT8LrE/4c0qLJe5g
	crprheUkKx3VNTdNm4KvhdMcm7vrm3IR7u2eI4BK2we4YOViWqjIay9YsC1I7lOcJ1U=
X-Gm-Gg: ASbGncvMGjTnF8ZobY/rSg87UDqwBzHkrNjKrvtTGL2vyJ5AEJJe9ZGbAZeRVfLhFa/
	6Db3y1mD2n3UR8nXzGEMthzGgC3oKvEcJxO83cCHOMW2/r6QfkTnfFr7ThRZrsetb4QwB99Rc3s
	DkyD679CI1YJlhkyoEtlMeYXeqj7amWnT7EeHCZwndAe4RhOkGcXzASD5jvr1GqcSFGDP97oD0y
	ZVm8gEaR1ij/HHz7UUK80AOoqh0zbmGWED3BxANEWesQuWzwEKTITxRy/TXRGcM4elY7thqWx3V
	IutO/UMRYhOvm6Zfduz1NCpbNwFz0YHGTYUrAq4jdtK0yNdJYt5oyfwqrtikx2IODJzaY/cwVZm
	JQamgmSOO/pd3O6sYw2NrrxYOwJcf1Q==
X-Google-Smtp-Source: AGHT+IE9tC9UJD6l6NoEtWg3LcOH74IqDydnHLY6xV/kxFHPSmv3CwLQR71mGVEOmsylQw71cEVvNQ==
X-Received: by 2002:a05:6e02:5e02:b0:3e5:42aa:4c37 with SMTP id e9e14a558f8ab-3e674fb039fmr13629545ab.2.1755544062442;
        Mon, 18 Aug 2025 12:07:42 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e6cef44sm36568985ab.48.2025.08.18.12.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 12:07:41 -0700 (PDT)
Message-ID: <a8097b4d-cbae-417b-9608-a3512d66f8d3@kernel.dk>
Date: Mon, 18 Aug 2025 13:07:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fixed commit message
To: Rajeev Mishra <rajeevm@hpe.com>, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818184821.115033-1-rajeevm@hpe.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250818184821.115033-1-rajeevm@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 12:48 PM, Rajeev Mishra wrote:
> fixed the commit message

Still leaves something to be desired - a nit is the line length,
but most in terms of why the change is necessary. At least the
comment in the code explains why this is a needed change, but
the commit message is pretty vague.

I'll fix them up and re-add Yu's review.

-- 
Jens Axboe


