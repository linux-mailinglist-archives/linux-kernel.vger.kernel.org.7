Return-Path: <linux-kernel+bounces-867626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D22DC03256
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818D93A2522
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECD34C9A3;
	Thu, 23 Oct 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cJ7tAcIK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3634C990
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246706; cv=none; b=bP9aQsO+IuPs5FPevhX9QeHspczqi/BxRy44gWLAtvg/GOvjmnkc9SqpgusVcyljz1KgfPWw2JYMSob/J8GGZbarTrqPVZJsTfYMj0YmtmWn/k3qbOuHJbsE7tYKC1/8OpAGZlYg561vbgJC0V/p7iZ9xigJLv+95mf/4N1pZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246706; c=relaxed/simple;
	bh=pttWRU7/dgK2UjwSiWEkHrJdOEDz6wX/zKzFjPVx6ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYnrLVNGWbtkpv6G5hapsFZSjqEk3wjQJFtQwQUDoCHWUjYZxcmJW6eMqgbfDw5QTlmSiC8E/spEsPwVmWuKIGuMyqzSZrpGgki2WRT6M3bvfQROwmbVXPpL6xauZrRm9dRqxii+aaV/1mu9c6BUmwGkYwUWdZ6yO4s7nAwl2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cJ7tAcIK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47103b6058fso8826655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761246703; x=1761851503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YC021s3hSX0b6kL+FC7sXtMbVcQNzXKMZzcCBREO6dA=;
        b=cJ7tAcIKU89hjZAl1DbRa4SNrr4SpaI95dgst2LjXJdaLHW3Hif8Dew0Soi+H8+46G
         8krliozT5kjd/QtNDLM4RJl3lwybmTo7YVcvO7+/wP0OZMnTklPw12FP1G62FSxvj4qf
         IFye18Bz/vXXiXcAteoYXC8L8K4p/mpZJbBN2vT8m9DhTGPmeSfcYGsbJ/AjcWAQuQGd
         0lQIWNOMH7P8K+IwYrJOHLYCaucZAffWGyGpp+6rPTCIBWUQdWCCzY/gsRjnvFkonyvz
         x7kvdwkABDPg6+a3I3he2V8+kuIU9QYsAEI0HNFeZlmy/KxQEJ2D19ChakuXDd8rhDd/
         qFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761246703; x=1761851503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YC021s3hSX0b6kL+FC7sXtMbVcQNzXKMZzcCBREO6dA=;
        b=SaEln1/Dxj0S3j3nTXJTDWqArNj4swAJTb8zfvSPIc1gy1INLrOlFIPaWFjiwntHiR
         Q+r1/7/LU6UfbfccQVw22Az3T0hFI7fR7KL3+JJepzVHr/0a4Kyq9qmk8BI9ESLe9UIi
         aMjPpfVR+OHNdVULvUzjyOMfpL2+rQBM21Js57K/Af9V+AiqZKTid8S53d/qLbrI+Yzw
         PkYI/DFZKFIvFUyaACF9ETK7T0byNoMOVVeuqkO3msf3ooyCG3LrYItpa0sEwxFmmVwk
         +eZe2l4zHXZcw9qIIK9iS+0WDlJ9yaxGA309oRCCk4vLNkzzI/K1Lpq7tMQ5nKxMsq1F
         SZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp68zThfdvyQ59+ppFi98Be0DBVmVVrAwYQxUjm+H+TIXxFFISmx+5hzis4qWwITb9oIkqVL0kCjkFDPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0rc8v27O1gCch5PZWqQTcWPmpAPIPTJeH7+IYB1RisxFm+HV
	9L+6h0KgM1HdwoVm9zYW+oAVY+cZ/loNEoscfMVhg/ALEn3IohygBj8=
X-Gm-Gg: ASbGncs0RPndx2Snhixq5UeTVPUqCmse3DRsyEafN7sMHgmoeMIvicelo/ycGe/tp53
	CWqLSZcQ2XDwwIJPSRzl3xWpPiG7mM17BNAiN46RwI1mi1pJkCw2aq8vLiMZF05WFdl2caz10T6
	YF8LROE2s7dUW0SXFc2RK2QstfCeeepvSTRTa0e3tm+pUSI1I20XOFncQvR7nUiWNFK2sf0v6zE
	xo46u27BaVdC1wjp9lPX55zKMwzcFArjSrWdg9rj5RXcGeF7r1L4D5D8kFv6A2jjCS1+zXaWHOl
	9gURDyr4cQ8uSh5ybAs1layYjJ5Lat9exN+goomQA5O+utkMvE83RhQJv4c48aoJ3Y5h68e1gph
	YgSHvD7fOYr3YefHq5wWhmLv1Q+kf7lu8DtbeksPZjf/DoBONnrahK6A0ZtNX61DYJzQVRr/6kz
	jiZhgCqlvySzNzeJ2gfq0Da8goG7ygUyGgwWtx9Y1ShdQk/l0ggN/IClrckZWjo5U=
X-Google-Smtp-Source: AGHT+IFNsNEq2TdqKr0cvqPqFFbm5Iwue3LIAxDBLdoZa+wyAY95ssAJ4sXZtAPUqqOIfIkrYHRO3Q==
X-Received: by 2002:a05:600c:c3:b0:46f:cdfe:cd39 with SMTP id 5b1f17b1804b1-475c6f69890mr34045225e9.16.1761246702297;
        Thu, 23 Oct 2025 12:11:42 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4069.dip0.t-ipconnect.de. [91.43.64.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf15b10sm60824215e9.11.2025.10.23.12.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:11:41 -0700 (PDT)
Message-ID: <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>
Date: Thu, 23 Oct 2025 21:11:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
 <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
 <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
 <5f8fba3b-2ee1-4a02-9b41-e6e1de1a507a@googlemail.com>
 <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
 <3ca10b2e-fb9c-4495-9219-5e8537314751@googlemail.com>
 <329a9f97-dd66-49c2-bc42-470566d01539@suse.de>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <329a9f97-dd66-49c2-bc42-470566d01539@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

Am 23.10.2025 um 14:46 schrieb Thomas Zimmermann:
[...]
> I've been able to reproduce the problem with an AST2300 test system. The attached patch fixes the problem for me. Can 
> you please test and report on the results?

Great! - this patch on top of 6.18-rc2 fixes the issue for me, too. Thanks very much for your effort!

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

