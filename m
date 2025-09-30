Return-Path: <linux-kernel+bounces-838137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDBEBAE85C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4323245F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9456A244669;
	Tue, 30 Sep 2025 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QSJ4ZWIB"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E609255E53
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263537; cv=none; b=EXvdTQquzEg2j/CUdi07/UbEP3+o7M0oQIVjzWFLHE1fJ29JcQiXhvmfGrlpvP3U3rq6T7hqt4OhDtmPaI7JMjciayaOQ3LE09oaY9pwLvSnT+zmYAFRgb+Is0lUqwVF2RyEnYmtfYjd61IlCDDbjfk22TUmgeR+f0JyBpGEhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263537; c=relaxed/simple;
	bh=MmXauHjASPTNlj0mQwEIjT/B/YzKvv+oNcG9uMvXJLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C65raRpaSm2+fCyU3g44P/i9VIvtN9NLH6avLlHdjcLvqYjWadW1SJ2I7WBsvHia6/zO8K/PusekysyrlU1b/bX1YLA0urf43hwWhGCqyH3/BPOwaBXpHda7XuqpM+XdP/M6PvEOocqLwgexS8V77ID8BQ2Pppz/YhleOiTAWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QSJ4ZWIB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so30566735e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759263533; x=1759868333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8I6dbvilgE5CwAYRRTgrE+fX48lvio4oI5BZ1CMQAEs=;
        b=QSJ4ZWIBDW2SnjY7CJWIFlctnbrcM4oPlh7TmBDhgZ+1dCgJUyOIr31f2LFWPZMI85
         gG+GMoaDMeh0ABCpg3b6JhVbEYUZEs3INLSmO9nnRJDxR3xZJO0E87Cf6FfH5dlzNdTw
         /NIhaniUMAH1zwcrjVpCLf/nOBQxDFb7K22un1J89ocbbOayVlg4SjxTttpQGI/jE7QP
         xGEJTPK1nm6X2czZUTXIKL/h5NkgOREn0JUzPwGkrcqQAsJ9RcTG3R9eRMEEFhnnPGOe
         qv9JpL8yntVK0DqPsmWnbUH1sLx6kAXew7WZK4uu2OAdXzZjiQQttbCvM+9L//rZdDE3
         48sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263533; x=1759868333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8I6dbvilgE5CwAYRRTgrE+fX48lvio4oI5BZ1CMQAEs=;
        b=kKNsVKVe3Wm0ldz2AY5w3a/aZBExVtqVR19eGmWYngYk1QvMIJOqRZ1TvGp3xox8oo
         qAFXKt2lu7rUg5DAzNvqxJCo5Zm33hwQUsiiaN1/E+T0HCfU3RcyHIpqprdiRjDAE5Ch
         IIXH5GpBag6pyWVDB1sOvQrjHaYtMjWkqz1Q0eBcpZvKbvLakWgiaUmogXeuW9nwagV2
         BN4HWnX9ANJKxbCPxdr2oyrZcG4BQWZuB9HjMEwH9OkZAIGHJjiDI1ASG34XSNPD0L5o
         mpTxecv9bj8zWYbmVTHjCntPMasIIKDlb1+/+tbjk+m19GeVrYHa5B4lAGfdoTiceFXC
         RNcg==
X-Forwarded-Encrypted: i=1; AJvYcCUrbWYKt78Wvg+yJqTCfga6Ll7o7ffp4rJysRPPY7h/7fSx2VgTuShmxWawZyWuMbB5mzF3/w7qm2eYLgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVqivluayHpV5XfdD67bNGxT5HM+os/QqSDYUfavmwEI7Tw5C
	nCHWI3nJOaaJF1/Cqr7Aq6MYc2JZVyEPkfTRoAaM7gJXF9yqgYtVuuI=
X-Gm-Gg: ASbGncuZx64Ko6qQezpXzxvEDIIrWJMYvMARe1Y8JKBj1l0PG95DQHRVNDuUBw3MkTM
	AIK+Tzu/r13YX4uVnK1CR1u9PNo2o1jSpyKGR9q0Fs9v5HOIXyPzE3ZjbxfR6qxL3+anMVapxjk
	bLc50MPfOK+IjAaF/DyJSRk7zs3f+tHhDS+p5B++tczplWm9T0/C9TtCIwPTXpT8nnHv2mXFTg8
	GNmFhv1VazzMD/DUzgHFH+qUXn4WK4tkR+O2RBo67uOVoRQcmn8AnrQkLmmZkoPCG882+49ML/s
	Oc56g8rZSOrWwvmKG0SMeVu+Xg2cpCkNMP9VPvEwMr++Rj8T7TBHCYe8dTde2awefkVi+kR8s9f
	TvJY23X+CPbzJFlns2nxEqGyzvr5aMPqjev9r+qIPh24FeT0pvoe56rKX5PhqolKjNvzVNLwfm9
	qPH8X50eTYgZiu+XoVGOS2NO4=
X-Google-Smtp-Source: AGHT+IHVX3QXQRe9EuiPExL8BKNrajYyrxG7WzB4GC1B2EjOUomUTUBpPzTUhvs5y/w6rZHI4Wb2Fg==
X-Received: by 2002:a05:6000:4312:b0:424:211a:4141 with SMTP id ffacd0b85a97d-425577ee1d3mr734255f8f.27.1759263532907;
        Tue, 30 Sep 2025 13:18:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4965.dip0.t-ipconnect.de. [91.43.73.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602df0sm24133218f8f.36.2025.09.30.13.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 13:18:52 -0700 (PDT)
Message-ID: <a7b6616d-c5ec-4f11-9c51-48551705d535@googlemail.com>
Date: Tue, 30 Sep 2025 22:18:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143821.852512002@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2025 um 16:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
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

