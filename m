Return-Path: <linux-kernel+bounces-829024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC8B9610B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D8417B9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC7B17A2FB;
	Tue, 23 Sep 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="imOyS2kf"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE119644B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635251; cv=none; b=qjH/AA1LGwo/znjeWyWKVMnfk/Vk+0iJZGlGD3sOMjHfF/r41eVa9eXiP1eP6ogIo5gWlhhph6p1Zb+DJpuFZ8MpRHI2l7Ld5WcasPgm5q0mVmQtz6mc6LmdzBTxvG2dGVJJRmQ1MbBSUs34Li8SJNWTMGdGETMW0kN3CI4gggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635251; c=relaxed/simple;
	bh=fEMX99a4LLdufdD4JU/OLopt+VDI9F3h9V5l+JeNSDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/Bmrx6Bq+nmoeOx+Wo9Vz+v6dgI0pdPKnPNQZasXM7zI9/NNArZFkQRnk7xU10esG48aGXeMZNu+nVfXzJqM6ubjKTcoMq9Ibf3x7oI8n+ohCRoj9eYUt1c3vC0S+ZFxgeq2GOAPqxms6c3hhwgplxzKYAdfoZ5jvnnR0Di64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=imOyS2kf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3383916f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758635248; x=1759240048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28l1fEqACwCBZqKhFY3KyPqEpdAA3HLg8xJ4dHMoe/Q=;
        b=imOyS2kfayuhpDue+BHU1FYIl9kfeBysJFX7QhZmrnlI06e6VhcKxSYCssqBh0Ur/g
         6htqDugTpG0Zs2NwkvgqGOYLqqdD9Wi4pE0t6CvTDbw/0yhrHmpWaGldwxA7g5ZW0fDF
         h8YciSfx2OQI2O1P1lrpKwyk5UnVJqRb3LX+CIvE624sDJKB0OwFwYUzXd6WA6nzzPt8
         W922NfeAg0yAUy7o5SoQ4TtSq3jTLMHFYB1u3WJOWGmAGxgne33cg0thcLY9u2ilSrUB
         SoneZMgCGPKgON9zj1WL5lkNI8yCqtjiljIAhctVUnT7MrmSOYUb2oMcHiqkvITnUgUr
         x+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635248; x=1759240048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28l1fEqACwCBZqKhFY3KyPqEpdAA3HLg8xJ4dHMoe/Q=;
        b=RYrjetNJRK9CLy2d/ZxKWkSOW9dhPMNgniuxoxCDf6NlDl80otzYmTpZlFcBmTXds6
         Jj4xjhTosAQgTSHJ6a1VPnOAe4jNhYkmwcm1F/ABQ6giQxopvxIxysWrDvykdRhRozFd
         zLIi3TU9GuCoj6DQ+e4pppA/bICgi8kjeIv/B57HWZRgwyBbfPdUU5sUrK0Ats/mdJWp
         ugZf24KwtVGe+0dHwTWUPQP279ePcirrbDHhausjdW2eqcN+2ph6QQUBVFRbm9/QdgLn
         k9/oXWZ7RVA38YL8iKwh/z6l3r+5dshu1FmrT2/O6bx3HkRsfYHKIeNFN5dOyKR2/DIg
         b0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWvG3L2GnAQaiYekUDWH3axJQpYOlqQSPlF6p5p6HcSFGiXobQ7PyEGUrKBv1xyEUMOQk5BB23aomhp8Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6nrFmFGl5tZKZPXAvFm0QION1TYKcM5+GTWUXfCoTaaIU+Iw
	7Rkh1cpqp3CD/y4Wm9L71oIaHfTJX/nmqUgN3AZliN87YmXLgbhgnSQ=
X-Gm-Gg: ASbGnctHF4EQvCFKWzwA5ivCfJcsp2/gQFBF41jatmRfITnoOwWfE/F2/zm5+Drpf/j
	AgHHE6TBtNz+qYSJp9Ydag83OXOHWaSQ+wR4n+7xYG1V2hBH0umk7CH9Ob5gpArOILXwK0Csqvu
	uBPES40ijeF4BhrpRxeLRB4X7b8ewN2kH+TsSMd57jPkvqItKi4DEz6x/4jt0jCWqM8ERUC+wit
	Z//MHnc5FWNA2e39kBQJC5BLkjxqmpWMdqHZBAWlXTVAaF+/2zLHqX8WkobafH2SqqsGPDAJbTj
	Mig7v+i/pb3ndxwPNV0GuAhGZhwMP8o7j/tSnIdpwhyG8ppjOFLrR1/7Y39tIlXjN7z7xkDedRZ
	VvSrz57nqaQDf+RqELmGU2oB0aTT04Tqw9WQWkbYm0LbDLOnmLWQyKXauWhBxtCCPcpvkcVn3qF
	O0
X-Google-Smtp-Source: AGHT+IEz0/K9oDXr/zLCHQ4dVkUmW53CD8fdbE0aFuXBqjyL0D4mn9goYVNMKiHIDqyrqbQhLjRZcg==
X-Received: by 2002:a05:600c:4692:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46e1dac9639mr27593965e9.30.1758635248308;
        Tue, 23 Sep 2025 06:47:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac1a7.dip0.t-ipconnect.de. [91.42.193.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d73sm23740097f8f.8.2025.09.23.06.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 06:47:27 -0700 (PDT)
Message-ID: <4d2d7e50-9853-4c8b-8a62-52c37004f4e4@googlemail.com>
Date: Tue, 23 Sep 2025 15:47:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192408.913556629@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.09.2025 um 21:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
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

