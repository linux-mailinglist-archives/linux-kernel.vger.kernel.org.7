Return-Path: <linux-kernel+bounces-817880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0406B58804
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6079B1B24917
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F112D47EB;
	Mon, 15 Sep 2025 23:07:07 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107328BA83
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977627; cv=none; b=FUhhDYtdb8z0G0gJWZfm43oogyjWu+ezciXyTwKK/K0ptqzb/UlCaS2D5SwUCy7et3ze1hCL6hhhxrouoDugdb27jI2GBjOllswUjKtui8iYrYcP+nFOLzFmm7Gvkk5rod18NeVVDpRidfuJyPrXhLMutcy8vi01qzy4iC25UiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977627; c=relaxed/simple;
	bh=excbcDwDxrEvuwHqwKVQbW2H0N+JOeSU0RhDz8Q5Z7I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iIhTKQPAxodrvAysvpdXdgdqFei/t3rjvqZ0SkUktYtO5hyNERyEuYt1ejNN+0l0sO89xtNJN5ASnjehPPYKaQngXeH9pHjjVOReB9A6PwRxglMeskiebfM3RSesGOC/O3hQhfmiAKNNY1n27WZOWJUsb1gOexY2/FC4ZVvbMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32e78c3680dso213635a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977625; x=1758582425;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tG2/pl1HRKUlyAsj9zDa+uGnIDTNYDArMaYIOnk47U=;
        b=pkToLAbjNOj/2OylKcT7mwC1oGBuBXQqZ5jsYGgou0VuG9EJfwaUt5uzMYukM+7Z+S
         yztJETVh3xV3vHMk2UkfswyGPNo8cSDDoqEzBe+LYJF/RvYiqHEcoElU0fU7jPcXCoMy
         Z6+J0WDNNWVhZXY5hNs/ROpmXE0wwQHMBJZn36rWiqpeIbX1RTVabfPmZqfUMGIUtZUl
         ooTF3SexaBYB4atRuHhicPilDQ5AeO+Z5hRL5xXvUA326Wo+VsQ3FiOq40MBLZ5VGFgo
         lJtQ/vdBpf35DKekVfbhnY9hQ7qPRpTAu4mb+8h1+AspdPHjTfpiu+bjeW/dbc5TxMEA
         2xRw==
X-Forwarded-Encrypted: i=1; AJvYcCWiFWwBxWbKfkCkwYSWauTCiVYIt1ZTQ5yg1ypPY3tZBkdJdtQfeZawEbx85UbeiEeETn+gcvOqxm3tGog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCIAhHesPVlWz5AxQJ8n6+2v1essioePHPs9mn0NtVagsDeMqU
	W4DoooUAty4LCmvniT1/ZrZf1UAKZCOYYRmUZiOeHeb2jMKxhaqlqG5r
X-Gm-Gg: ASbGncsvcaH5S76km0wy0rrhQtlgQsnxmhrm3B+kkjWn4EjMcQ+Gp7gxtp/pevr9XRv
	uv1qdUV64d2WCF5RYsxyi0ZleUREdyGZn64kX0FQsjULtSSx3qSEN72mH2T7pq8FMt+SyblePKs
	BvjsMU6VN6gw1Euu3SFSET+UpLTEgFJhqNzxOZ8Jq6E797z5EVLLzWThOENzrYkZDxGyTWf0FGP
	R8xA4cUtto3UoOL8NY9VYlHnV+qUSqlxmW3G8KzHIOFG8OxZrtOTAzrAiIcpom6o7CNUbBBMMXX
	KJG/h/z2d0PdNG2crjwKuX63MLWg7wr9073TKkK82F1+0pmgGyBtVfUQOzxQWNUA3fzQbMcGKtW
	0M/urJYMcSuEqW8B1ak2wwDVShmTag6bbRCUpaHzjFiSQQvLuarWDVlJbIYXgqcgmpiC9DK6SWY
	8Kym6IbSKDsKc0TrXsEdXmN/6CqnWw
X-Google-Smtp-Source: AGHT+IGbqBJF/id9+qYtY3KsiDNgt+EfjytBm4qa0ZzMz3igOef+VrgCD1CGjFg5iy6cetqBPVxKGA==
X-Received: by 2002:a05:6a20:914c:b0:251:31a0:9e70 with SMTP id adf61e73a8af0-2602cb012a7mr10124077637.7.1757977625339;
        Mon, 15 Sep 2025 16:07:05 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b169f2edsm9504128a12.19.2025.09.15.16.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 16:07:05 -0700 (PDT)
Message-ID: <8da4d540-652c-4845-9feb-0d53eeb3b5ed@kzalloc.com>
Date: Tue, 16 Sep 2025 08:07:02 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>
Cc: linux-cifs@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [RFC] ksmbd: Deprecate MD5 support and enhance AES-GCM for SMB 3.1.1
 compliance
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

I'm looking into contributing to the ksmbd crypto module, specifically
around crypto handling in crypto_ctx.c. I wanted to send this RFC to gauge
interest and get feedback before preparing patches.

First, regarding MD5 support: The current code includes HMAC-MD5
(via crypto_alloc_shash("hmac(md5)")) which appears to be for legacy SMB1
compatibility. SMB1 is widely deprecated due to security issues, and MD5
itself is vulnerable to collision attacks, making it unsuitable for modern
use. I propose deprecating or removing this support entirely, perhaps with
a config option (e.g., CONFIG_KSMBD_LEGACY_SMB1) for those who absolutely
need it, but defaulting to off. This would align ksmbd with security best
practices, similar to how Windows has disabled SMB1 by default.

Second, for SMB 3.1.1 compliance: The code already supports AES-GCM via
crypto_alloc_aead("gcm(aes)"), but to fully adhere to the spec (MS-SMB2),
we should explicitly handle AES-128-GCM as the default cipher, with
AES-256-GCM as an optional stronger variant. AES-256-GCM isn't mandatory
but is recommended for higher security (e.g., in Windows Server 2022+).

This would involve:
 - Adding key length checks and setkey logic in the caller side
   (e.g., negotiate or session setup).
 - Updating the negotiate context to include cipher selection
   (0x0001 for AES-128-GCM, 0x0002 for AES-256-GCM).
 - Potentially separating signing (AES-CMAC) from encryption ciphers for
   clarity.

Is this direction worth pursuing? I'd like to prepare patches for review
if there's consensus. Any thoughts on priorities, potential pitfalls, or
related work in progress?

Thanks for your time.

Yunseong

