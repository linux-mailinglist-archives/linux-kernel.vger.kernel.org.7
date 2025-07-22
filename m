Return-Path: <linux-kernel+bounces-740944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C3B0DC60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009723AFC63
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7BC2EAB69;
	Tue, 22 Jul 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VywL/X9X"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA78288C01
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192618; cv=none; b=S97QlrqM9aoVxGUuySXsKFrRDWiWMIlxBo34N5uvcFk6GyL6PiwaL2C9Fsn8tptrMbTO75y11tfgp6CWgoywaXYz4dTXECdyg0dWL+fQOVUzoffrpK7qh5TwNhzDcpVIiuNqppCgIlsGYmqseC+F9ghBGBwZdsKsFzcEb8n8d5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192618; c=relaxed/simple;
	bh=WD4UPgWwrp87c7JvBmxtXsetEVuHqNKEul4WKe735JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EE+nc/l6uIsu+guPQMNh8Ql8dUInv/SaQBJuGOtJdTcTMp2RfTQYvQS6BE1BP4pPyv/T06JG3lnrEH2S6FKi8MRESn3qI6BsL/Ab7BPVGvUecMWNk+Rua7k9D/iBy+xqvgCp01s7ojjzewDE1kMM6OWp1wNgt3EqxpNHslMZHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VywL/X9X; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-87c14e0675dso138573239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753192616; x=1753797416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjmFlUiMS8WhvA/SoS60Dh4RJFEn5lp/yFwJABcPh+o=;
        b=VywL/X9XlLouPHqv4vY9/WsyCGZBjKEdSwRdltghOutRBpeDDfsizJbgrlBN9jDVqu
         H5xgN2/NtYPf0kt7fzAn/NtH3fR3ymSAnoSwFx7p6dd76I5+/kmwEu0xsRtzsxLajfvh
         78HxqmC93Psx0g4wmFsVeC9lw3qWAVOUVPLRsp0HW1Q7e3Ihvr8fh/HhwWqtSBp/Ictp
         kS+wClNzeGGLUYpWcc68wGSRlXjuoalINKMjDy7tocN3aimOVX6NFxxpXJsMNkYh7LJJ
         B6FWCrXWC4Gw1FKszlm1bz9g6OeXMXLwFDzwE4ApB0ttB7KwyLAuJqsbF9TN6ymqEPA5
         bSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192616; x=1753797416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjmFlUiMS8WhvA/SoS60Dh4RJFEn5lp/yFwJABcPh+o=;
        b=GWd0wAglKd9ugI4RCR3LRAehyz5k8lfs/zmPTTJ/kX5Ki10a+/blYVB1LKcLOLS12E
         0epOZ/jO1vzksGku/V3a1WYstsWiVMAsLQI60hIsJgGQ+T3I6X7eQ/e4t2TbgVuqrJtg
         PpDTUgpGeDngvgXMIVLwhgyLzYTpC1CheDFpDYfg2slYVJutuxAPpoNVi7/uUXlpR7GK
         NYxMQPeS3DNx7YP16MXMQGP5za1awCgdCDjyLszbFNLnuQD72f7AGOwn24RGBDmA9xuX
         Ip6VQuVpTTRZLGcqeyiWYdmsVqLvs0kEEVgJqrR7YtFsPrLy4FclalBvIxaOKAGayrUl
         z28w==
X-Forwarded-Encrypted: i=1; AJvYcCW3v3BCAq6b8dnoyb19ZLVr/i/+kGfudJLDigqcgufFpYEUzleesJV3oOptxVYvGeH7A3XDCIzAwYE4EmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cx6wyYk4OqpTOCndgJkxzOvk7iOsx44rU7siqfrTXNaxUZNU
	qcq8ob2HXsGL5pbDy0N2DfnbflRGAuQ7oKlHYASUqtONCyoFZjT68BsqFLVQpxFF4mExGC2H3YU
	9RCa9
X-Gm-Gg: ASbGncupmYpN8nyHO0yYTe1CyDSCjiMaS9IfB03YVhFBXarVN2KEg1PC04Auo+RPIlw
	gymw7e5/nWto/qOieKbKFdfihlh7+IeeylTxaoM9AgcYMOiG0abIYm0Wt9DYT2PZpS5j331fIkE
	CU2f6d3AnaxoNMCAqn2zemsl1WHBveJEL2nuDqmANTzm/f1dZmrFADVrQWIWuV3IWGmKEgIp0nM
	IadcQADvOltCGZpfEefQp+rDHsetFQoDQ7jxIEV1K7N+BHmcSLFyeH1Th/wogDwIs0jFD2ek/Vd
	iZBxa1ZFDXbeTGM2jB3HsCorEk0t0cHjpR+3AiGkebTigul4h7sYPVcgKJNX2iTZPBIVt68xCYW
	+Y//wj4gcvhmTnn28gATVBIviSiKhAg==
X-Google-Smtp-Source: AGHT+IFDr+fErNv5tH7IdOj2j7uUgenlIGzMOgYCLt1qeLE9jnEGv4AQM7YVl9je3Z12CEdDAW/qHw==
X-Received: by 2002:a05:6e02:1fe4:b0:3dd:cc4f:d85a with SMTP id e9e14a558f8ab-3e28d3b88bamr240624905ab.6.1753192615551;
        Tue, 22 Jul 2025 06:56:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca5f843sm2502681173.129.2025.07.22.06.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:56:55 -0700 (PDT)
Message-ID: <62b5f680-5d54-48e3-979b-8d09a876130f@kernel.dk>
Date: Tue, 22 Jul 2025 07:56:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixed several coding style issues in the efi driver as
 reported by checkpatch.pl:
To: Dishank Jogi <dishank.jogi@siqol.com>, Davidlohr Bueso
 <dave@stgolabs.net>, linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Manish Narani <manish.narani@siqol.com>
References: <20250722121927.780623-1-dishank.jogi@siqol.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250722121927.780623-1-dishank.jogi@siqol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 6:19 AM, Dishank Jogi wrote:
> - Moved assignments out of 'if' conditions.
> - Removed trailing whitespaces.
> - Fixed indentation and spacing inconsistencies.
> - Replaced 'unsigned' with 'unsigned int'.
> 
> These changes improve readability and follow kernel coding style guidelines.

Will only cause backport/stable issues. Please don't send checkpatch
fixes for existing code, it's for new patches only.

-- 
Jens Axboe


