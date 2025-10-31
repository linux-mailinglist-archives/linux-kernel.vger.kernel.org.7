Return-Path: <linux-kernel+bounces-880514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507AEC25F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C5461434
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF12EACF9;
	Fri, 31 Oct 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fwN9tres"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB282EAB61
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926245; cv=none; b=KQrMUF+8CTC9q6oepBXNX8exmsli2G6F9hE/lAH2ZsjeGCwFNYJFUKLQyiyjLEl3wj3yIs5S7hsuPvgdBk4Ftsrxm7a2guSiZm18jgxAUXWgTFXjanOkHO9M2YBgzc5bEzli3qnXmnsAyw9+Oc7vBswCnm68/lx2Hggl3XuYAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926245; c=relaxed/simple;
	bh=yjHBWC05s3h3HRSExiyGSQQjmN1twKVXh2uNlBYdM2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLxgJiyJrgPDcBEJTU6ohdGDIYcehuIWJVCVTVDgEk9pdYM9dymiioB5G6GH0XhW0OICL4DFsnGoXEpABabM5l69ekgh3r5oK4pmh9GEExawv8zMzp415f7o31kmx9oTnpTL1wjNAAZ4SnqA74kFrvSiZ4HSiZUp/dhtXfw3tCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fwN9tres; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so3725227a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761926242; x=1762531042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nI+jUGUgrFwdA9J/BWhhFb2SDMktkHvnyj/zPRmzijE=;
        b=fwN9tresWOg1cdG3fZ4c832HvC+AZylVC3VBLWrDNFN3FFKqS/zy00NjcRBsU330ja
         VtiGrF3fS2pFsapADEgh9ShqU0GLfx/KNe9qd93uE6nVYUNjtHGq6pyPKgNOZptFXKH7
         6PabjL45+5URVvEJOoPoW15fkrNjGvxzBr7aqIrM2DFkasr+Q7/1wFl7iPvkfHvxYTwd
         TFe9igj9rQKn8xEXOrjrLp+jZVOxY6Rtx+4Z1ve2bmyVZKUf/phig2/fJMabRKHMRo3+
         z0gpvFJx7KJRb2Wxvg5onj0dcAdpyoJL4Bg1c8dAs9aKe+izobD63sAqv6VZksX/cEAQ
         STVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926242; x=1762531042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nI+jUGUgrFwdA9J/BWhhFb2SDMktkHvnyj/zPRmzijE=;
        b=VSubyOFbTNLTNHy98Td03kXBJ9zpDoawP/qrQ6yBHCGJrVWq1NVJ1FovGyIbSj0kAz
         oAEx6dJ2djEX/+zpzH6yJwrXs8M9FQ6mZYjEcZev0oTy7uUL3iPBnPe6Bmg4AXCFqB5M
         93Uo8Q8eU/Eq9aTGv5MPRQya8kV/1cP/Eg/Zhuuvf9OMgPxjjyjpf4uI84md9b389zOB
         k932rzMp8KHIbk9mWLu/QR46uMHv7Qp7003nfWWBeJUcqYTt4VqeV5Hk1ZXsYDj8L68W
         3B66qEv8LQOw2ILYT/gvgD54FxKZvuTyWH7FJYRvjV7Iead+LM+h12CaKy6SV/6HkY/X
         Lh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmeHFcC7bMSalWENMqF9lidLe7WsgLadkFMl4GlXGisN3/NApuwOUQrX56A5rouTalsZEl3bYmq33ltYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+c2lMCN8FHkcX3D/NtAs2i2n2EChgiEXrSCis/qVQhH22bmC
	P1cPvPsoMvdJSjIOthLhxRBjgLeUklqmBqJspwuHkUkh1oIykxMUZqo=
X-Gm-Gg: ASbGncsv4uddoJtche6ni0X5qXofyxQvWv1aSjAQVQV8FuFu3WQUwidNS22PyiEch43
	pEtx8LihaqibQ7hk49bxwxfDm9HqOH+yt3ptqCFx8oq6mbieHKuXLUKXPalzI/h2qvD9ctpHem0
	GrFccsoSL5qkRhdYywzvmVPY3NzOl/YJYf4XZE/SFJrsRpyU0c4zVE4Z+KaqMmQ9tC/prXm+ugz
	F8dOiKkKtyXpduGBr47OIAIPMvVPkL743SANHOU+EL190qFys41G/xGjtA/+mvmW8beORGjtmef
	WtJqvmUKBp5zY3Iu6BYNvHPgtpaLB/knXaVjDieyxIniZ5k02rurDlc2M7uSd5ragNiSkQdSuXb
	lEQW6E6tFcVmicHZLXt2aBW85QrKOh99ePiJGzZTvAGYGodBclrZ8606RCAyxx9jgmD8uN5SnVG
	UGgBdz1RksbjvjCah7kejNa7yFh9qyHjZjmd34cCW37nLayDcbA3YrUw==
X-Google-Smtp-Source: AGHT+IHdC5nEkh3EIsfe801CuOexng04liN2h1LnrXQkauZMgdGcyum5TaU1FRbxBKL0FAJSkSNDMg==
X-Received: by 2002:a17:906:478b:b0:b6d:603b:490f with SMTP id a640c23a62f3a-b70704c40b5mr378182466b.35.1761926241353;
        Fri, 31 Oct 2025 08:57:21 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3bb.dip0.t-ipconnect.de. [91.42.195.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077d065fesm206856066b.72.2025.10.31.08.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 08:57:20 -0700 (PDT)
Message-ID: <19689e2c-5dd1-4c3f-a243-84b69a552f91@googlemail.com>
Date: Fri, 31 Oct 2025 16:57:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251031140043.939381518@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.10.2025 um 15:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
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

