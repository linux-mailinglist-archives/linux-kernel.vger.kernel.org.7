Return-Path: <linux-kernel+bounces-828766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A381B95695
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0654E3A6A04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016B2798FE;
	Tue, 23 Sep 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Rbpm6plZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC0A60B8A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622580; cv=none; b=fEk94gvIze1crfzbkw8BBZlQgse8Ba2JnkMUuzN6pwMB1Wi3bHl3CulxrD/mo5hyFoog9PjoseqGZL9KZehHKWM1AsNtMDGHIYDmaKc7h3bTB0Wll4uqHJPWlaGZli4cqZrSPPr22LyRLC++vMIoSe19PAFWfcJVFidqkZs8oc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622580; c=relaxed/simple;
	bh=RYzPGdtC8EGMXt14i4heCA6P0dBRkz9jYtGI/l4OWoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q31aybk5D5neNcnOTGZPD8KEWTj1BZRhMDVqUgsbvmxLC7XCSL12L40lMZUI41wY8LRPXsA/D8VZ28uzxlVcSkzH7796aIYgnzi23yIFoblKFfHeLv5Btwdo1dU/p4yd/NHmMHpiK3gFj+O2R4zhnVC4u08NdEQ8ISxlrxPU/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Rbpm6plZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46dfd711172so14888495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758622577; x=1759227377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+sf++HoPCnwTrMW6zlIxHwkbmsZIiPjDZjaq8+brNA=;
        b=Rbpm6plZ2JS9egRscvNc3aWW3moyq10S96fqkAZ+B+rF9v1tWfh5iBfntQgPEtw4q3
         33MyD8xbITgOpymFAETxxS+chWRP6VxMv/wUayrXIl+v/SVsDUKcJwBQ3Z6bjqjISgvR
         1DseIYJvk0pIpVLdhVCspVeKEeipXo0iHdMZXlveA/3XEuf3tKzopMnV+Z5d9CEraCU3
         9TVwd6r5fKnn+SoqL2AMf0HWvp6gcFeFAEgu7ItYqxJpuCncfN3P4PnG9oBe7Te/4sGl
         FClmrgfcsVw/JPnAc4+0H6sR1R9Q2DWIQJQKlebualwd0JN/Y3ajR6op0xRb6CgXakjN
         g8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758622577; x=1759227377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+sf++HoPCnwTrMW6zlIxHwkbmsZIiPjDZjaq8+brNA=;
        b=qFQqntbFi+XP7Nui20k76Pa22WudbzklqnXVDpkA0kZDwH1al/fodKBslLZYlYCNmm
         c0GBcXKdFmM6pwBCUNEE+7TLc7iwWPF3Qp8oerUrD0Xr0ZKyxpEitkG0Ytnt2PHs4cyz
         OspKK79hyf/bX5s+uPrsknxcY8qBuhcYVu0BuZgpTSLa2zk9M1k14Rqirk48N7ISo/gu
         ujcYw1OfnCslxiN00M9KPTPNa9JMLHuXak3jRblk6qi5KrPc8uLbyygX70r/7fvN1dG7
         UlKvUx2HVrV59CeVNMMQcbqmANqqBeS0zo7NIPIYmG7PhA/VLxDWKoQpBSALj44ZMIH/
         yqkw==
X-Forwarded-Encrypted: i=1; AJvYcCWbvwxtrf2u7DVW2Ndw2d1vwQ6nTMgGxlElLiZwvP0z+lek568ZTyc0H8QvvDdg/fiusn5x37JiOXppzV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZb2ANKxPQi1HV16X/VAnKIFz4w0u33g2/fBP9tMLmIsIGtCwJ
	lwd7/UHJpeu5FWGgSzE0KWtKBrIFrUntGahQa/Kgyy6ckjuVQWjIkog=
X-Gm-Gg: ASbGncsT+413nC6DxfKMMMOIFjX1pdW8eyeHLJI9+9fBhqFQTaShLOvJ+U2szaQ7O7r
	TjefDh7WSLUAH2Rz/ZvwdK34lorUdUsknlMML5+y0q4KVjK4oztIjbe8Jo7VYkZVvJ4PDNSzQPQ
	kI/8AbWy9YHfsesRfweH1kmYD7sWIq1p5JG2T8i7VCpMSkwEYe7cJNDPNfxXwYG34TIPhA71Mle
	0c1fj7JCsR7/qsy3VJvC86w6BsIk+dl/j+96dTBFg79tg4q7GWK9JBW8r3dfZyrZYrqrLbn5s9v
	XF+e8uJRPtIaRBZj+PBO0e2I4VuApPCPZuXKji2TGTyD/UqPslHEKY0A5WzctuGi7B5ksjtmIQf
	A5dey1Rka+27q5pTtGGmspH7uglqUm48ML70TNzv2aZs0emJQSjfsvNwlpjpqpKZAgyhK06U5Vj
	lQ
X-Google-Smtp-Source: AGHT+IFVoBHgZs4WjGNNOI/TU/wazag77uFfteBay5mPYzOkv/vWLLx6YVSIzFhKxrqMSBUuEzeiOg==
X-Received: by 2002:a05:600c:154b:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-46e1d98a525mr20043875e9.13.1758622576895;
        Tue, 23 Sep 2025 03:16:16 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac1a7.dip0.t-ipconnect.de. [91.42.193.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d51e5d863sm75027915e9.24.2025.09.23.03.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:16:16 -0700 (PDT)
Message-ID: <f89a5541-9f06-4696-8d05-961e4fd9a4ce@googlemail.com>
Date: Tue, 23 Sep 2025 12:16:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/70] 6.6.108-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250922192404.455120315@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.09.2025 um 21:29 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.108 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

