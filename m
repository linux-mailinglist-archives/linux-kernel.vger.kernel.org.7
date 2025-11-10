Return-Path: <linux-kernel+bounces-892496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A258C45353
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1145D4E836E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDDF2EBB84;
	Mon, 10 Nov 2025 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWgMCLM/"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047D1F4CB3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759587; cv=none; b=A5B1hO4sayX8O+ykiXErgSteCg22vUD91ajg6GsAo8E82FJpj06Znf4BQSpkpd7vxoPfW0E37ectdil4oWR3PIQxV3hSxDn8quH7lmBCPXzU+lP9wFSmERvP7soKdXDC7PK9gXWyZRG9C3sooFcfLwK51bvNEbvTG62F8KmV5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759587; c=relaxed/simple;
	bh=3ilupd5XApR7rZGdr8QHBx2c+QOFvuJ/hW2wtQYbeQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+cuFxH0VbgqZMgShXFzL7yqNNWvh4BRAgpm5LAseyiZNigywJQfeWHTeSpNMbsYCXfAwaVinKBPfvZk0NDLZLcpPNqpvQbBrYz71euDV7qGoN4e6dO73jvODKf6db1/TqJSyl5K1qoM3YyNVjL77tDKXvC/eGuqGrbCV435hX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CWgMCLM/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-591c9934e0cso3404415e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 23:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762759584; x=1763364384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ilupd5XApR7rZGdr8QHBx2c+QOFvuJ/hW2wtQYbeQU=;
        b=CWgMCLM/BDNW+l1eF+WMRRBHZCmXCNfmGeNSvm2dCPnA7IfBRAB6KgN5nXLxnR2PyZ
         WjhCLgxlZ6H0ZcHrHM2qSju5B91CQwnJgAF6QwqY6uy4SnT+ez/oddLvV4C70bxdKMNN
         xBqMg2eLCfZRkZkeYF9q6O/zHwujd+KQmgFeaB0ihcz87oJB3Skh6hvQxdQJo6Vn2A+v
         XfhcCnajVP6l8Y3UaDDQY5GbsJq1IEGYCT/B672IGzz9G9VnF+WpAzwHCqqxypaEqsdp
         JK82ohuw1Xf54aBavg1WIXTLVAk3Rq6Im6OuDhQejOD8PI44lrG2dkGpwXf0MoGulJXC
         SeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762759584; x=1763364384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ilupd5XApR7rZGdr8QHBx2c+QOFvuJ/hW2wtQYbeQU=;
        b=MoLNog+wJ8NliNwsFOrTIMGATrvgs4/a60iU0Yk2zOWOSsF+b+okZ1Aycie32cLJro
         tXZ/TvkJymzYPlyEeqtiBrCSAXQ35FSv5KuQzKgBelYImdY1KFYDrirCdnl9lpKkqQ0l
         6RQYjssExE1Mwnocm2pQExTOrGan3iTbdq9jncGQ/zZePGBrXYtVd9LPjH5ghiKTb5Na
         jMwgbVvv4WLRn4ntJph0YoQ2iQ2PUWTRzmDgOLaU0NlBDtnTN9d/a60/5HbKXRNf1c3T
         wt42SNtMv98iX5a6NlHjeyLOzyCKRz6CHCYvO0c7UEjeoOGS4thQf/kQIV2O7++GAobJ
         KxZw==
X-Forwarded-Encrypted: i=1; AJvYcCWKGqSLpZlT1sgvPmJme6f40tWXPEFkLYVjjshw56MNmsCY7EhiKfUOPVcrodZr78ANGs98GEspoHhybY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKI6FgTGsfiqORrCdtFxh6Rru1m7IbS9vey44pJNJYYzva3ZjG
	e899FII4hysRuQR3rLjc/lXWY+lkHtotyMRQz/zVwxaXWoxRVZLV4/tUdwQZopmKKqUMXHAX4fe
	NFz9qRysrbeuuULF4p+G1JNDrj22SU01kuBI6psJdsQ==
X-Gm-Gg: ASbGncsiuTneJo+4FY9x+MVv0NBfVewCVBqqbpFE4jOlwg/xxEkuaovB0d+DM5esZzZ
	kZiUtHY+qd7fASbmGbYbsEv8HjSpJvJQgljHUdtSP+NNbhxw8wjCZw7lioFMZwLMef6XAz2+U0q
	d82UvkmaRjNUwkpj1LUyxS7J7GHMrwO0zBbZXVKeQxjh3SIVSZUwoXivo1rOWc6DUANagM//z/5
	oQMfuKPMKlDkZNCXgfStUZuwhC+mxxM4B2jZUrpR6w4BMES6SRIrztwbwUaUTE98+DWYk4JaABK
	S4HEwQ==
X-Google-Smtp-Source: AGHT+IFCe5dyObTA+KQ90GAxHqE1GkHQMbHN6SYfQnEa97Ekw0SysejTWzzktjK+754MJfcKm9edgZcyej4S3hFmD60=
X-Received: by 2002:a05:6512:3b12:b0:592:fe0f:d9e with SMTP id
 2adb3069b0e04-5945f1598e8mr2160449e87.7.1762759583562; Sun, 09 Nov 2025
 23:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022021149.1771168-1-huangchenghai2@huawei.com> <20251022021149.1771168-5-huangchenghai2@huawei.com>
In-Reply-To: <20251022021149.1771168-5-huangchenghai2@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 10 Nov 2025 15:26:11 +0800
X-Gm-Features: AWmQ_bkvi5aDs5CyGvLRxbcNXY8_0T-HIbk7OOyl6-s-DtjUufmygm8cvjByxuQ
Message-ID: <CABQgh9GDMohphD82y_uf0EfVMz1f3hHTnZ-fot9W0oFdq4oJPA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] uacce: ensure safe queue release with state management
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: gregkh@linuxfoundation.org, wangzhou1@hisilicon.com, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	fanghao11@huawei.com, shenyang39@huawei.com, liulongfang@huawei.com, 
	qianweili@huawei.com, linwenkai6@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 10:12, Chenghai Huang <huangchenghai2@huawei.com> wrote:
>
> Directly calling `put_queue` carries risks since it cannot
> guarantee that resources of `uacce_queue` have been fully released
> beforehand. So adding a `stop_queue` operation for the
> UACCE_CMD_PUT_Q command and leaving the `put_queue` operation to
> the final resource release ensures safety.
>
> Queue states are defined as follows:
> - UACCE_Q_ZOMBIE: Initial state
> - UACCE_Q_INIT: After opening `uacce`
> - UACCE_Q_STARTED: After `start` is issued via `ioctl`
>
> When executing `poweroff -f` in virt while accelerator are still
> working, `uacce_fops_release` and `uacce_remove` may execute
> concurrently. This can cause `uacce_put_queue` within
> `uacce_fops_release` to access a NULL `ops` pointer. Therefore, add
> state checks to prevent accessing freed pointers.
>
> Fixes: 015d239ac014 ("uacce: add uacce driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks

