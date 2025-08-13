Return-Path: <linux-kernel+bounces-767414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B25B253F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9526B885A56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA04D2F99A8;
	Wed, 13 Aug 2025 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E97hCxf/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8632F99A1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113508; cv=none; b=j2I9lA7iHycaoZlotcbk1VDkkXom9NLMvqDXIuxzTZEZg+zJ9yHsOWZDlEK/5pi2tSEg1Z+QXWwaIwduCDB9Lu2occiFGpZQcbIikfZclleN0i5erJVjz1MFvyo3aOLb4fCoo1Gk1hwrGuCXLTHO/iFaKHkfzdFzQ7XqRwogUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113508; c=relaxed/simple;
	bh=ioR29Pj9xpLzZiL83LiJkyB3kOiKZfb19oU1XgoYLp8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NYV0qTVStOvTh3lCgnm5wLo/IY4gdKmwjB9i7fMO4WR4XY+GzydfkMeKUmJrGoqdn5cKclFUG0Ymdata6ZEf29HUO/0ka6p+rnA7uQgspm6uuZMwasvscG6Gr9EnBOBWxCBYIldetjOpdCa9v0hUwoxcVqhBvpkwAvytH1hZAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E97hCxf/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so252354a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755113503; x=1755718303; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3UQLx4CNjygZCyhUGzWq068PCeCoGH2HeU4sWDHqdA=;
        b=E97hCxf/q1RnqmAur4oPp1IEWXXzxcNOqlQOSrO/t7Hx3mz5j+XFeZWCObwZxxSuSK
         5R4XSQs56zys316QaSwKftA6sv9ErHBsUlp1kQ+qn7MoTLitWcpynwU0NZlHjpG/0EWU
         zYEd1Ktn2x00CMECJ1ROrGEgKlvEk6J+D0Sa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755113503; x=1755718303;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3UQLx4CNjygZCyhUGzWq068PCeCoGH2HeU4sWDHqdA=;
        b=c94C9pTtuxCB7VwXGpS8Sjw94a0XKipeXEMr0rX4ENFwuz+pwxwXTgfG8MhIJLMXvv
         hF+ubGU3o1oIdNKk7fQ9OpbJvG8S+KhQD6++I4ItapAnfQmarNL+E48OwI4pxhBO4Uy0
         jIf6rDSKAmo5eTvqzhx/v6vCbGZU8xdMpck9Sv4kHG2z51sI0kNPjQ9qCqSdTJ3Zupv9
         wwPqu3rvWlcXTiRQeDx7C/dWOJxv76iEysRPcrqsLkE4lNIaHti+crt493rxeT5WZJFa
         flfdPXfLiR7IBnRaPrvfOAs5J0dAGc73zOzbFfyQXyRz4pcN+RDH8LqWiauHW/ksTDfd
         CjCg==
X-Gm-Message-State: AOJu0Yxsupdxs62HkbT2j92+lF+CDev2sqYEAOvUTJPooWf02XElD4FH
	4I21mgWU3ZNQJRao0fNc8Vjml5LiUwZOJKcabkgTgvzPezl2Kyyl43ZE0uMP7ajfEM2pE7gGs9r
	QovPwMsCt
X-Gm-Gg: ASbGnctsW61iVOXwCsboLEkuEv87wqJGfyWXvUTnccQEBYOkTfHpYllme71tRX9kcBe
	GJEfbwy8pKOGHUX84zZzKtKO2maMkf0nTXgYgLkGD81X1xfL1IqAALxgwg24pN9Ciy1xjwUp1wA
	aF/93Ru3Q3wGVqHy5WCCiAx+CVbuh3kN1gvesdmmvTqzvx6Rhs52TmxJTWet/lFUYhU6v3e2qlS
	YODSx0/KnLHZ9Df5uIxLjIqV0Exj7bBeG6Fb7eTjkL3TopQ/pwJzvlKLsmCOqCGDiqkfF6rhcpi
	INAziPSMw7dMtEaL8h9xpaUd+tz2gxdKV+RID9abo3dRqYC2bFylkcxtMoKR4FmWqGxTln/XMRu
	Rx9M1l7bsCia4YtCHFud/RYam4Itle3bjQ5xOaStUUrRFsuAVdpREuHdAaP0Ht6Vcsg5bpkLuCu
	HY7rQO5q2OnJv2
X-Google-Smtp-Source: AGHT+IFu3eQQ2dfPqWy22HN13yl5YqrNia4iQspE2AESkHtIu31Vjn8kc726NUydCxeQwmlwqnB4TA==
X-Received: by 2002:a17:907:7ea8:b0:af2:80c9:7220 with SMTP id a640c23a62f3a-afcb98ccd08mr33950566b.36.1755113503218;
        Wed, 13 Aug 2025 12:31:43 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766d1sm2459124466b.18.2025.08.13.12.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 12:31:42 -0700 (PDT)
Message-ID: <a943a7ed-7a17-4c22-a617-b327f7f302e9@broadcom.com>
Date: Wed, 13 Aug 2025 21:31:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: question about disable_irq() and free_irq()
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have gone through the "Linux generic IRQ handling" page [1] but I 
could not find a definitive answer to my question. So hopefully you can 
clarify it for me.

I was wondering whether a disable_irq() must be followed by 
enable_irq(), leaving the nested disable out of this, or could one call 
free_irq() for a disabled irq.

Regards,
Arend

[1] https://docs.kernel.org/core-api/genericirq.html

