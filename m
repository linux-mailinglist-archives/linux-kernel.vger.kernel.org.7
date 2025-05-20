Return-Path: <linux-kernel+bounces-656075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D498ABE157
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 18:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726351BA7221
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFA026D4E6;
	Tue, 20 May 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UQ8MXIB4"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6425B1C5
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760175; cv=none; b=ntJI3pFpEYr1HuImXItCKwdDjiVVviLOceEDAqNWBD1XFoMIbW0WVRGWrVCd62tgGO8Bqc1KbG0N8UaFFcZiTOEfk9bEW+dSROyLGAn+kweCQG3OOLQh/dwX44DJsZln+//KUGIpdHPgpJi9cTKVmrv56ZJNOp2waoTKbgPbB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760175; c=relaxed/simple;
	bh=wb9jveR8gfrm/HLOmEI3ZVUiaVgfP80NHuLXY6U2rvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t1Vwouo74j7UWyozrs3JxNpqU8hChEPV6PpYzbtXTwfFjXsOCI38osfngI0bZp7E2X7Xe+ZcC3AFZSQP6xExJSO4zafiIi0Q+HuFl7EB+kbwKyzbnbAWaVLASwSIBYUOhpHU5w4ls/wdjlq859TudFmrgC/JQzHNnbRpSvt2qi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UQ8MXIB4; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da73998419so16713865ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747760170; x=1748364970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+I4gTPT9Nr19IG2h0bYwR+TaspSdeGh5uzYNeV/gxE=;
        b=UQ8MXIB4zpYUk3VPcQfuuIS+NoTEux8yivljyuzPVnqf6JFkd3ckEmgKgF4KWQWNH7
         icZffsJpuMtgrCPymTT+TuTUNPdYUh6WPUe6WQQUMYyv4dOvtm5pYrVMXWA/FNRtkyNq
         7nVS128jCoIchq+3auu5wAFRY1E8fxyWrnsp5xwvQiC9hhAJWyniF4r8z/CErreE84XA
         ifrI3NNfqpHWL1Bufd+uEaTfZ0cA4bHWbb40dOphGOm1FscwxUECRYLNm49B903nEjQf
         kLQks2zMsgp8fRdTHw8usAZQ5zvBzVfXhpsm1/N6JvbppVJX/MYrfSaekue4lYUKCKT2
         JvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747760170; x=1748364970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+I4gTPT9Nr19IG2h0bYwR+TaspSdeGh5uzYNeV/gxE=;
        b=QlYt9qCQJ/01Fx80EdJVrNoNwMH4J5OsVY3ClROrtaAkhZB+KlCw0apZiNVUiJwKKo
         uuKzdS66OcfZGDcF62VwoBbP6NytVayDPpPh3yn8ivpjYpKkFEnQGGmiCtXMf8FT7Lvc
         F70R8a1Lo343/FYW4zstRrxrR6wLTbVGCUca4m8cEOJn9bdAXXj2pYM3DMWLiN7LYIQ0
         DepZJr9fNQtUxiWmJO1SLu5ouUHYvMugh30DxjIVSQthoMAD+xdit1Q/l7rtqsBeCB9b
         kt6cTElhSwiupCsE19Scw9okn/do/BBQnick9XdX/2nf7fcfKDT7qgam7DQuG+M73Tup
         9Hpw==
X-Forwarded-Encrypted: i=1; AJvYcCUhrqz4Olc6IUOubPbqbcEuaax+cmjq9wbFzIo39L77v/Cuj20YMty/kDf85RAymxhqwPV0b+/m/7I2Dy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DwUCDuoIn/NxTKpnle0DP2yFIZGQ/pmTQrPBtRVW3XPYl2hn
	rnXql/RupEQS/bG2ard4aNs4Fgp7Famds5ui0elnrTq65CCiTroWXXmf3wOxbVJC5fQ=
X-Gm-Gg: ASbGncsYcwClbLwehOxpq0PACvPIrzsslb6HL0EhA1NlLV4SkY7jl7BTKKzQcU4PQIa
	QxoP7oe6bS2AX3NA4c+TpxNQpyCH/tVFzHtg8uPJ0yuRmn6aydBzncr8Zp8HRDU/BeZmBfNzY/i
	MSQNoXD15r/D79U/SgVoX436+pEg6+7Q6hrcYEazAv4LD0V+iQvrcefZo7KcQTzEqx5lEiR07WJ
	o1g3NADcT1vfL72L7ny2GRaNUK6+CkTsYH71Gts0BUJOxCcE5uiYtZir3iVolPSlY7Bs65tYFyG
	7g9aZq6bzl7tHM+gjnSojGFzzPH7OXVbCwS2gbQIoImRcOE=
X-Google-Smtp-Source: AGHT+IFGEk6WV38wfO2fNFtvLWC8v+J/V3qGJaKnt61cz/eASxvGslO2+1tn3+3paF9Jj9ay2Bch9Q==
X-Received: by 2002:a05:6e02:1909:b0:3dc:76ad:7990 with SMTP id e9e14a558f8ab-3dc76ad7baamr61593435ab.15.1747760170063;
        Tue, 20 May 2025 09:56:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3b1c90sm2302153173.56.2025.05.20.09.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 09:56:09 -0700 (PDT)
Message-ID: <7708ccbe-f967-4910-8a73-bb66bbca214e@kernel.dk>
Date: Tue, 20 May 2025 10:56:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rbd: replace strcpy() with strscpy()
To: Alex Elder <elder@ieee.org>, Siddarth Gundu <siddarthsgml@gmail.com>,
 idryomov@gmail.com, dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250519063840.6743-1-siddarthsgml@gmail.com>
 <f92ddea4-edf1-42f9-a738-51233ce3d45e@ieee.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f92ddea4-edf1-42f9-a738-51233ce3d45e@ieee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/20/25 10:44 AM, Alex Elder wrote:
> On 5/19/25 1:38 AM, Siddarth Gundu wrote:
>> strcpy() is deprecated; use strscpy() instead.
>>
>> Both the destination and source buffer are of fixed length
>> so strscpy with 2-arguments is used.
>>
>> Introduce a typedef for cookie array to improve code clarity.
>>
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Siddarth Gundu <siddarthsgml@gmail.com>
>> ---
>> changes since v1
>> - added a typedef for cookie arrays
>>
>> About the typedef: I was a bit hesitant to add it since the kernel
>> style guide is against adding new typedef but I wanted to follow
>> the review feedback for this.
> 
> I personally think the typedef here is the appropriate.  But
> it's really up to Ilya whether he likes this approach.  Get
> his input before you do more.

In any case, this should be 2 patches at that point, not collapsed
into one patch.

-- 
Jens Axboe


