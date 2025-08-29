Return-Path: <linux-kernel+bounces-791135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC0B3B25E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590F417380F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7C1DFD96;
	Fri, 29 Aug 2025 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTvrjMh4"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C18488
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444736; cv=none; b=b2LGgf1R5M20YZjST4hsxOqM+8yD5KYyMQS7Z5IbRxaATfsaA96YR6bnihuaf3Mq6Mb17pakL4XmxyJNcW5PuKgZ5XQhnM69FxFkTcUyWk0Gp6MHFNqidn3/IgyAItAXAt5j94/vxGuakaXwFTYHCoVUwYmLV28mf2IynJc33ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444736; c=relaxed/simple;
	bh=mETEVWysb+5yCm8hyHeF+B/s1k3PP7u8CxaQ8Cg+WGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzJpM2VWf2wkdKioAC9lk6BW7Y/i2in3K3QEJCzEHZkODCvf3toH5/0Wb9Ot/qTwXviOP7ZTogSQQU2DDDcFyk6AHQQOi6NQhJcVV24vXdwfj5mpgV7a06vhcK2QPBwnCOfm6JvIIplszmG7II+svqy3Rp8aWIn8qgcA6WN55j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTvrjMh4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e67c95so1791886a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756444734; x=1757049534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hixLdvtLzKwXakjYFiKgvIvr5deLAlnG6kTAvz81yYY=;
        b=NTvrjMh4yxITwONparcCHRK8VZUJW5YKF29IVBpDy0C+sbO0m2yXE2KJmdsVClAUvX
         Bgdh9PKWOi8vbnL3WXd/PH/D7HGVBT1aJ+jVCWhaFjP6IYAGWCHBJ0TkDNXhAgohXfDX
         fVYyHHnsIovZlDDnBTgeAb1RkWqaVoFXLoFfU0nDGggI8rpcVSOPWpmDyjNqiyvgx13B
         +vXfWPL8yUVJn8y0tBx6F2FfiBnitUJPgxZy9fJ5hqLyHLzWpYpYimQrBe/O/n7bWKeE
         XUeDpInkwr+uvPjrLJvySYl2UO0rIfPQ1P8XnQd9GVnTpLMp7O8Y97Msbkll9u10LFKJ
         L76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756444734; x=1757049534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hixLdvtLzKwXakjYFiKgvIvr5deLAlnG6kTAvz81yYY=;
        b=RKwRIEg8hj744jaaPADFbPBPVyg3fhcmEPlyRfaf5I8aV26rcyf4hArPx1KugxvYjU
         otxQWBIMJGyb5IKCnBgcvPSet9mhHNcxTHne+DGoL9sb+EoxSvbVhIGFyBcyvkEpS63M
         wLtE/FzIccyPYcnmiiZSjJdM/h0FNvALVKwyVWhnyoKoFCzfHWAxE1iMvzfCzehJBJSZ
         Vg+gYtn5bZV9LAslVLPI3ykC1uHJ+53mgzADLhdmVLFWLVJHcl/KY4M1Hivg4pc8zDP6
         bjeTwNZGwaAVJB4bsePRocGw+C8WvFt/UD1y1OFSmBsyQgI6CXh2Up32b6ZsY2lfM/TD
         ka6A==
X-Gm-Message-State: AOJu0YxldPlbGN59pYd+WXaOyJyc0gTnj66kI0k/63SGFM06vuVWQOvr
	K7i/dcP1Me8KFQsnLxddMJeeFGce1R63/LlvM9l/9VnlyWgW8Oc7CIOj7C3amTUcUpufSQ==
X-Gm-Gg: ASbGnctsPbFW/tqd24ZkV0bzgcphN2QfP8iOvrDbZrXJq1m5XdYwQr/ee8wEw0nQNyu
	k28GO+DuYJ0PdUz3JQpgY5zwkHY9WG8tFnl4adW6vxFynTkCFIREyaSHVuI1Gup24qW7RjpzAMT
	UtrTI8eQX6J62zLacFzeECdFXOxtbI+5UDQICmkN7JAoXQwRJq+CRXerxFc5i+9Zq1fKi4j1rzY
	ARHp8aC1iVGEch4FgRH6avjWcOnWA/CKWxG/pKemroBTpnNOlEhGZYE4I0AwLFwwHGiI69hmwCt
	Iwo6s2na7Bxc1HJkeSvBsWxbO80p4LlUHjc6Gm/gLg0CsVP76ySjJH68wywMlzMo5FsVOU3Z9o+
	Ligfy5tsvXPkPaN4=
X-Google-Smtp-Source: AGHT+IGB0ryUVA97YS6kNW5RwDu6h1tAP08IELIEah6N4rh1nPWLvFBJ8QMI7+NH22qxU8gNiiYndw==
X-Received: by 2002:a17:90b:1c0b:b0:327:a295:320c with SMTP id 98e67ed59e1d1-327a2953816mr7376032a91.3.1756444734344;
        Thu, 28 Aug 2025 22:18:54 -0700 (PDT)
Received: from [127.0.0.1] ([2a12:a305:4::3008])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ad39csm1042474a12.27.2025.08.28.22.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 22:18:53 -0700 (PDT)
Message-ID: <35a05270-8361-484d-818b-00decc4ce202@gmail.com>
Date: Fri, 29 Aug 2025 13:18:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] panic: use angle-bracket include for panic.h
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Qianqiang Liu <qianqiang.liu@163.com>
Cc: linux-kernel@vger.kernel.org
References: <20250829051312.33773-1-wangjinchao600@gmail.com>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250829051312.33773-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/25 13:13, Jinchao Wang wrote:
> Replace quoted includes of panic.h with `#include <linux/panic.h>` for
> consistency across the kernel.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>   kernel/crash_core.c    | 2 +-
>   kernel/printk/nbcon.c  | 2 +-
>   kernel/printk/printk.c | 2 +-
This patch is based on the mm-nonmm-unstable branch, where the previous
"panic status function family" series was merged.

-- 
Best regards,
Jinchao

