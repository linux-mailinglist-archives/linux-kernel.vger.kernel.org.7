Return-Path: <linux-kernel+bounces-895976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427EEC4F650
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24644189C248
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D9218AAF;
	Tue, 11 Nov 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g6d9He+a"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09527254B18
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884933; cv=none; b=SeSQnbzbjHKbGvrZpwjuBFjh+A++/u93QDvdNVbO996PWKUdk43Ovu7tCpW4yGzYvVdzYu2CREo7BqI/fSU8cjJLVivCB/Nn8hXhnrrQ8yegZIFzC2FiS1AS6FnmK6xdfl0pZ1W5lg2TyJvSTZzzIc9iUbBZhshh1QfPQqfRLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884933; c=relaxed/simple;
	bh=WY0tvD3JrT6UDkw/8hTycx0qbVjC0GxEVNXJGB/A9dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oafWoADU5Vv+2BBmAqWy5L0RjOub6tY8TElRqAONqBjqgctwXca2vFPmXvvnMqyJvOBDKId8VK7H4PJiRIIRLNKGzfGNB9rG0lSnuJMwL/XQYjaP9ueElCKUP0eknkDMXW22QZWgklw6q5toq4mB9UlqG3g297qXyBv5Z8Ep4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=g6d9He+a; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so272135e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762884930; x=1763489730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYuH1i5ZoIizzTTIcboUh84PgIhPsB1tWiXRAjKgYIM=;
        b=g6d9He+affsB9ou26F19wNIOgfBWoN8nX3nYLN7pcA1Cg6+tWPE5QCoMG0YlvaKA7e
         iIsf4Br/qbqb0q7AikeX37Nc3ABIfp+rH9GlU0sIUGDvldGQzjq+oXd6LJ5lq9CuZJ0i
         3yQeUcLHzZg9xi4P4wk3QJ2ApSwZ8H3I2NL9WECisgCiH0WniAjKE+VNdIlG11WlPUy6
         jPBVlt3ZZ0ot1xBEAFLH9wW2nXQRWwzNX+vSo5JA0AWUGTZW5S6AgaYB+s6tdkEDQw+N
         CXzMwNboX4g8zLDy7sNzd7UxeQ1KyOSfLd23Fw3xn4sTvbFG0fFPL2JkfVq61VcjKkqK
         qHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884930; x=1763489730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYuH1i5ZoIizzTTIcboUh84PgIhPsB1tWiXRAjKgYIM=;
        b=Rp6Tr6bQ0LXs2yoUsSirY/zMa3AaoCCgCsD9Q4f7R/Srq9Fx1TdiM28c0V7zWkapNt
         RTRQWvEdu8NBl3C884f48H0kPC/yqs6ZiElmmH0MSpvo81cB+oeOyVNXj98swah0z6/2
         ryXRFvsaxaLJ/nuyXtbn/xE4b2XOruQq/vM9GMvWGeeGzm30Ps/8jex+RW3yHnQU3bxW
         E+0EYO50wqPF2HG6/yi4GCfFT5IuFYL0MU6Yk3k84jfsVpzkHdFLUwQU3/yKZRLGLQTs
         MfupT5XxM/VjGSPoJnZvZSepx+skCt0DBbAZjDu1Dusxna6l3qZiU0L1+pvRigewbNMT
         R4OA==
X-Forwarded-Encrypted: i=1; AJvYcCXeXxbfyO9F9ex69ogP4wAgotpyw+Og+6tmGw/r3N4+jnXKxmxJYK9JPGjws/I/R2x7WJpf/AntoOD+Yzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBNAhT88k2XT0UsLQr78KlXXpWuFNUZUHH+zjBT57EWApUCes
	f2PdqYcNLqijsG7K98Sjr7ag0Qh2M/sgxg/xP/EnyKDmXWtJcccHoUg=
X-Gm-Gg: ASbGncuLiifUK0Ickn3rAGxp8oQAqUWR5MBgY0gLHY5BxC18/gUr8MCJjQ3r/KTY/ul
	moSyP0M6d6nBZksdI/WSzJPGAq7K2eLrOhIzWlsm7RcfodDPds/0LlhNcPRw3vq3/XYxE5WdzOO
	YH1xq3FCVR0KumTAX3zODRSIXIuLUxMyKmpyWA0sn2PWWFDEAimqDg3MUi2OSm0EB3JKPmWbBZY
	itt5WrSSQB9YSyxM9l0MfYOcV2s659+6smJGFW+yvN6lcmF235DBCdwSDlQ4hBW7wqup1HSoQp9
	wbRb7oaZ2tkwHNSizozLR5V2P9FX+UB375chaItlfPGkE5Kz5hgbJKxPxA8w3DDyqBcbB+DLWV6
	ErWlp2u7cTy2mU2aw7GLUuOJ1bhOv3o020/xK7IWb4s+rJ2PomJvF2N3TQUHQlqy2aXS8SMW9rx
	/pATSp70NMScj7TTK//C9gvFpFYaBPZSEroaClkk9VDDb3AT8+xHcYjp3ym3m6vf4=
X-Google-Smtp-Source: AGHT+IHIoHZOFXMv7iwBPA10zJJM1peaNTeyWqz8HkDkOlb0lFxAYESnE/oaas1auLh1AqL4deR9OQ==
X-Received: by 2002:a05:600c:45d4:b0:46e:396b:f5ae with SMTP id 5b1f17b1804b1-47787046a95mr3297515e9.16.1762884930128;
        Tue, 11 Nov 2025 10:15:30 -0800 (PST)
Received: from [192.168.1.3] (p5b2b46e7.dip0.t-ipconnect.de. [91.43.70.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477815faadesm25345635e9.0.2025.11.11.10.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 10:15:29 -0800 (PST)
Message-ID: <870f0a18-8a5e-44c9-9270-8d3a70ce2eb7@googlemail.com>
Date: Tue, 11 Nov 2025 19:15:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251111012348.571643096@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.11.2025 um 02:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
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

