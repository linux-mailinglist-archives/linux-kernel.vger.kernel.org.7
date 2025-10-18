Return-Path: <linux-kernel+bounces-859425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7D4BEDA32
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 21:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC3421FA9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC428643C;
	Sat, 18 Oct 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RneoAhUf"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0EE27FB1E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815204; cv=none; b=MwEGXM6RpXWXWvBlMDuVliLAny8YIhl7A1G8hTTPv7gs8BQq9k8TQTm3UsXdemo88eaMluxzCfPyQaLPvJRyqNhB3AvSdtImEwf9WUOO537ATZYKDegtbkXrsHYB4sHr29Lh5Srmst3zjshDCeYBI4KPVAHTICdI0DgKeXSlNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815204; c=relaxed/simple;
	bh=LccgdfPMDjRMzewD+obCTFVg3400OuQ7Xk5cUE3OXck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTIumyh8crTJZggV/u4RGjXhZxyBl+AzItAnLK/G8/MTjD8ssv+afmb33CrDbjJcU8Ecb2cEnV3GINbP5dGp0KRmJ15rvHW6xUOK3/67E88xiPRlXWJzbnKo19ORhEyLCAAIIh0dtr+4tXLWHiLV4cx80kS56GfvCTnCC3ZP5Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RneoAhUf; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-635401a8f5aso3007266d50.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760815201; x=1761420001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LccgdfPMDjRMzewD+obCTFVg3400OuQ7Xk5cUE3OXck=;
        b=RneoAhUf6PoF7MbMimdA9adiDI3VMOIdv/bQn14/RxOWGn98OMNP9+Cd1qDu2aTudg
         d3qaKXjDCeLE/cLsvoUKP+ANBU4K66Eg81itieM63mXumwy17BLCq6kIH1vWbihUy4Fw
         1EkSiBmaL0x9ZT+6gQlaIgxaAztRyO7s8s2QE/NXBW1mIs49yGb59vnk/7f0mdWR39tb
         qhq9C+9CncpCGIb/UNNwfdZXDvEG8TS3VX9aWsfYE/lp6btjfFKwkfuW4qMZKka9fi9R
         Od7u4Qr3VnyIO3xBOOuc+ptq2EOZldqVbACAfvJZyeZ52mCM/V2tGHmpUpm07+4x/Lae
         flkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760815201; x=1761420001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LccgdfPMDjRMzewD+obCTFVg3400OuQ7Xk5cUE3OXck=;
        b=IMdbr+kepzrtkPy32nrBxXp71UMrsiYzxzV6y+cJ6I35sO/yTMGOV/7GyhCOHepwgm
         ToLrUK5hzzSQ9lJU+uwG864QfXYa4pwBMs5pQ5UplvOuUZUMVdt3KgDG0GUXAElDn7dM
         1m20dBey5Q5L+OqU3uUFZX6myEAPDCJuwZ0iXTz5wpX1Y8UXgBHxSE7BAXWh/MgY4q+Y
         NcrGFkWL5m3Uxut845NpM9ZSQmxwkIhitblVz3npP5j5OCEkmHquqNIzYOOMu8fdFKW/
         E/44R722wx6/3KVZ4kf1T4ScO990haHvDr0Mfys4oxhp7pdtaj9Q5RMvmuvCttxtdd5M
         X8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEvt4bPsMWwYxh5tgCdQfzogvK+uUfTfNb57aGxd+BG4WPBdMgHytGHf9oqYApdnj/JP/F8b6Ii0Swwnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBGekvkK7vklPz/ELTp+DaHgcyMTB5iSbHA2hAb0X/50zM7V4
	IV0U8m6WtlRe0fPdYOblGbY2R4IaSqsZL5vRrf4kIGaQqIj672SCaDOo
X-Gm-Gg: ASbGnctqpVwxnwK+hy6ZzF2QizOHMG30newhzWTiDvyw0gonaHzeFScRWrygNjixlpf
	XuqoEIqL65cRrg2yhlBjzTPtxtSu/bkUOp6xETh3gQqluQEcoHRt5dAcDxZv/aVNeRJXDFnV01d
	NiN0y834JuPBfhSeqmuZVqSe2tNYdoQwq2xOr7Q6DDIIFYKb6z5LWpXGtnWFtdhXQK19WfWq+ss
	MJLxF+rE1wMyjOCuLCmq+J05F7HgAUU9UK4jcCrCSDbID8QAQEfNlaKu1tCfKysdeaUfB7sneam
	zSm9NqS9UHay6/UonoeLi0vk+U7Mq107VSuMO/SM4OdprtB38OFlMi+CQjq0Gs6bkrj5FB6XuMC
	zP05B3jqpANnDipxMK02LZIK5z+JR67/5INNsXvL3Bh5aAqOKFqzwplmDoGyJ6FTvi7VMWSqlYo
	5F7rFcQ80Byvn+LdnfXQ==
X-Google-Smtp-Source: AGHT+IFrXjWjoq2yIbSbSD5lPCn7X75dshizr8DHk3oHjFx0ElM9TMjMaMZW4gd177H72hiQ/ipCeQ==
X-Received: by 2002:a05:690e:1504:b0:633:b6b5:ef2c with SMTP id 956f58d0204a3-63e1619ef8emr6624550d50.27.1760815201550;
        Sat, 18 Oct 2025 12:20:01 -0700 (PDT)
Received: from [192.168.201.155] ([76.200.76.117])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63e31926201sm256249d50.3.2025.10.18.12.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 12:20:01 -0700 (PDT)
Message-ID: <c2e85681-7ce8-43e3-ba08-63f8b854c8c7@gmail.com>
Date: Sat, 18 Oct 2025 15:19:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: validate budmin to prevent shift-out-of-bounds in
 dbAllocAG()
To: Sukrut Heroorkar <hsukrut3@gmail.com>, Dave Kleikamp <shaggy@kernel.org>,
 Rand Deeb <rand.sec96@gmail.com>, Edward Adam Davis <eadavis@qq.com>,
 Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
 Nihar Chaithanya <niharchaithanya@gmail.com>,
 Vasiliy Kovalev <kovalev@altlinux.org>,
 Arnaud Lecomte <contact@arnaud-lcm.com>,
 "open list:JFS FILESYSTEM" <jfs-discussion@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
Cc: skhan@linux.foundation.org,
 syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
References: <20251018053029.226506-1-hsukrut3@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251018053029.226506-1-hsukrut3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/25 01:30, Sukrut Heroorkar wrote:
> Tested-by: syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com


Hey Sukrut,

Did you do any other testing other than syzbot testing?

Thanks,
David Hunter

