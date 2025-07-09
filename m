Return-Path: <linux-kernel+bounces-722660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0CFAFDD78
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F383A2BFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26111A2643;
	Wed,  9 Jul 2025 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cg/84xWn"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FC13C9C4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028184; cv=none; b=PMeLFY8K2toHl8KJ97yXaAhDNcKuyC5pJs1Ky7SF6AQI7oM6h2Ti7aWcwrnDN1rI0j6hAl7VaEgWXTBtGkhJpnx+RhpSexxZ5i1sadjR7bf4IKkYD+iTkgy6zYYpoQTDYzAD5KM6hhvnQ0hby8qdz49QCr8iHLooHeSNHCLUqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028184; c=relaxed/simple;
	bh=F93LWi1Fh0svB3GipHC1hnWH/q7XbV3493xIbgu4qB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ICCOmBh2mvUM/KTOatnHraYmy+d7s4dd9q0zaZhzfWryRmTan3MrP3E/6KEqIc02n8ZBj+ub/MQefFA0cFtZytcDJNlyu2MH8oga/DfPBvVBN/27XAPJtxoMyQRyubWsntetQXSIseubREJYVEYpvRUw/uBhICvRF0IjolkLjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cg/84xWn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7494999de5cso3144376b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 19:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752028182; x=1752632982; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOT3+pT1EXn0yyLq+LnilyYEqlfA9gfCLe6H0EsTrPs=;
        b=cg/84xWnCwEHSTRDbkazUAsMWCI86KkEs3MZnpPs1Ch1cmETO2WYem9G3SG7ZzrxEu
         vbCIFGdaB/HqdmXIhBwgCjnmmHjyODtlaEI2o+Dw7hNcPeI4m+dO0jyj4pp6NbFE1K1M
         0+iMBXO2nM9H57CTg0ZntuU5L1dK6EUhsnvg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752028182; x=1752632982;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOT3+pT1EXn0yyLq+LnilyYEqlfA9gfCLe6H0EsTrPs=;
        b=CPFTC+U+hCJVLRC7sLNzCKDWOM8okiY3UuyHtquzy1G2g/6chlJihHE2oEQK7l7HxG
         CDWqioIdPnCGry36QeJqyHCmfJqTKoE1dlR96ap5qFvXnE6MnAeidunebweO/pWqGwTA
         MKU6+j5B8uZx2sEQdYiyxEvXdijF7XmKD0vtq4ML17LrhJh4uIx34xktL41fraXtmSGI
         vLrdH41KHDPWhtroCJgNnHkmEum0ZWoIRsdIQTWyMQ+LclCTm1kNW0fiSGITMxe0l1sL
         BcMDZbKgOuzp74/ho3uU8eiNf7b+lqTZUN96ONr+JK7XjleVvMu0fKF3q0B/hDd+EqPk
         3M6g==
X-Forwarded-Encrypted: i=1; AJvYcCXktZZ32fnAYmlj7H/7n4AcTpUlV0w503kJJLRxJ+SgcuGcH0QdymdvBzdFqxHqaat6Zy+QVEA8JYBM9BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNKV6aJJHB59aARR5+097abzpa7qV8hxynVP0QQBlwq4nqVMi
	5wmA8qkkW2ht+66gQ5lCAwNpFvn+OlxfvWVJGbf4WdUMpzhn9eL5qX13lWUV6L1EIUcv3p/3KUn
	5rvY=
X-Gm-Gg: ASbGncs/rElkvbSEJSRqDpRDgNQDhiGBZ46VtAs4i2I+bjc0SlhbzTOAkEP/MyQRk8+
	IJpaXwqTqqWdczZbcmenfZaVYq0CK6KmhWqCrqXqyJJBYhqOY7s+YmHx9T6L1+SMEonQ3PZihkO
	2Dgx6I/oqQCYrpiXGotHi6IQD5WWYUUz0MhcaSLDaHMBtbDk0gSFPP7EAgFGNHCuPEDHMrTVVlu
	VLdNpT4oFk4OTZPL1xLMekmp5vbrPhbcIkRx+R4GhevZpBlQqOsFURlZsbquVknDCC/XzGDCI10
	8cRjkTr64Df31xjXappwGr7kFPBcxgTJeC/rHBGtjrB6PZH9wOsnfjbHlPoYB4v9kw==
X-Google-Smtp-Source: AGHT+IEYOaxoBu9VzWFUyg301H4VztPO364l+b0LqMU4bSJBSdj/J7HkpXuk6bUBUCJiUO2WsgniwQ==
X-Received: by 2002:a05:6a00:228d:b0:747:b043:41e5 with SMTP id d2e1a72fcca58-74ea6678955mr1289984b3a.16.1752028181847;
        Tue, 08 Jul 2025 19:29:41 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9611:46f8:eaa3:1a41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359ec3asm12510762b3a.2.2025.07.08.19.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:29:41 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:29:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] panic: add 'panic_sys_info' sysctl to take human
 readable string parameter
Message-ID: <ndckw7vr5zxiz2olstjaxxk4a6qgrnbo65rex4242u3swnvvhm@whxmilgtgoyd>
Reply-To: 20250703021004.42328-4-feng.tang@linux.alibaba.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[..]
>+#ifdef CONFIG_SYSCTL
> +
> +static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> +
> +int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> +                                         void *buffer, size_t *lenp,
> +                                         loff_t *ppos)
> +{
> +       char names[sizeof(sys_info_avail) + 1];
> +       struct ctl_table table;
> +       unsigned long *si_bits_global;
> +
> +       si_bits_global = ro_table->data;
[..]

Somehow this breaks the build with:

lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
   52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
      |                   ^~~~~~~~~~~~~~

Moving sys_info_avail[] inside sysctl_sys_info_handler() seems to help.

