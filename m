Return-Path: <linux-kernel+bounces-856606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E2BE4978
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA225E0F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6404329C5A;
	Thu, 16 Oct 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aekr6iZz"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE832D0FA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632206; cv=none; b=RhWw81l+3JdxEO0ap2TkR6ly5PIFK528KX5U6wRdGnMS1zGU/wtdH3ZG9pcdT/Wn5xKYiUZ/2AfRjsIdu/qiIN73WNV0C23e5F2wqXkqMa478IBh/GHqT1fWPMxzztnX5mViJsRA1B1nNZkdpEQOWTJM6ur5T8T0UVVC9IikYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632206; c=relaxed/simple;
	bh=EDOCxm3GTbpxd9p/oeC8nAaBNgXM0bPq+Ky68KM3cEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExRYXPOSMPo4cmyIXHBqXh2IuT/NanRMXvVoZH284sbD75kGfXw17Iiwdb0w03sYHAEeS6j487Z3L41WoGqHDmIzq4WezAf5VcHW7YdkFqcEdDWDNOkPyd2N0iZhW8vXRpcAXdQD2v+20QdrfRJLd8mw1J4K1keJoKkWNT8j9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aekr6iZz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso1308025a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760632203; x=1761237003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6oWGb53nI6EB8t6BqTwPqkeo/AZ7STUCl8C/pS1XPU=;
        b=aekr6iZzZIqC8/pWYnaDFRoWyMC9+63hXKfOXeX/HZfii64etJd0RgxcIEur/GoT1Q
         MYEsN6C9j9fioevt0jH9/apnjzGXZDyCFyRuJJ4QsWvDckhX4t1V63NjhZ6/IzTh0Xkj
         +8nTJazR+i/a4qxsJiNNQXoJ+2SJCZaqb/LWtIT/Dfdft7zZ5eaOq7lZPP+1cwtVHnbH
         rX8XDTm8x2mJlSEBfnpvL8X2VvqvlHuGbvhjtrNhCzk4xFdYyUe3o3A/+OjhkdypFr+M
         5XmxYyqPoYzqKJVFtQLWAAcc9sf6Yt7JVvBKXHfM4cMIbuY8qaZQ+wae+tqELqyHki6d
         C1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632203; x=1761237003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6oWGb53nI6EB8t6BqTwPqkeo/AZ7STUCl8C/pS1XPU=;
        b=BnSW7rXn1rYgRfjt4/AE0ZzBpcvfQ85giAODe/zu5DPZ9EmW+1+YPbU7nuMJFVxqJo
         quCqDnvjXAmopJZRjUTQKLR+fh89UvtZBujhoPVvQK+s3LJTE/BYyHiP3z/1VSUbFl9o
         hkzsQNAy5JkLoIUsrLCPQJ7miZDxHL+GUnGygJGfOMXjxey4m27hcBrJnabOcAZhll3Q
         58dmrXu9Unh+e6wLTB0V9OEM/04r7l5/7b8nmblSucR6CPKF6+xOjv3LpSSso8YlJWiK
         EhAZsgOkdRWr9YE4jFIGHR3v4AUXQEpHwo+RP6M0uQfyZtj0dgpu4cfB9yR+kyb8Mbk/
         kmkw==
X-Forwarded-Encrypted: i=1; AJvYcCW++1WEJfMHB1VTtryopPd2FWAmzX/tdqnL1PnjRgRJuwJaiCNbM35RXWZpn3WfDo86dmeK4X/hXzKmG+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rLQxm0l9BMUd5yw2msE42JIjBwMTMhcICpfj3fsT3+LBbKuR
	6NrgFyJon4WXRGwWZtOkm9AGKJfGC/FKVqYWs5/3j3ZuIvXjnxfGv+6e
X-Gm-Gg: ASbGncu7wlgNFqdlKrVAcDqZ+u+eBdXZgnzBfUoITLKS8kY6Si3jDp8/HTvZn+g8rQe
	8dDMvtjrhisPEP9AX4i49EcMUv1Z2DPu7NwfLH45X0Em0683cIK8MxwkoZPmf5J1MMK6y5SEPjp
	bItND1QsWK5KRaf8m8QbyLOTcgaMl+P37gURGHxVIQlQm62ktDL2zzQ36hFdvaoSSvorteyh2ov
	C3qj87wxVZ27Qjqlcz7wR6KZYqFPz3X2zGwmMfsWjFD3xFPpKjgOF61HRGxCY0v26YMjDMlvcKy
	RFAfNqZv5EghwnnlalMPaBTZ7KlsktnfmTQrjbc7kqj+QjtlBXaTQR9/UV6S8I02GGTDasmwDON
	nkS+Zwyzid+49n9mWnINXKhVBCgmSbYJYum8/DOF1EMzholO0HkCTYmQ0yq3+u11pOR+M76eWpK
	oIM1uku4V6CoWqk6yL
X-Google-Smtp-Source: AGHT+IG7Y2xWlt9seBZAMG+a0nPlBM7h6lZZMqUyKqzBF3tGxwIhIFovulB8Mpu1lI1FHMqkU2XxHA==
X-Received: by 2002:a05:6402:2356:b0:63a:294:b018 with SMTP id 4fb4d7f45d1cf-63c1f650138mr533185a12.14.1760632202917;
        Thu, 16 Oct 2025 09:30:02 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235e674sm16314027a12.2.2025.10.16.09.30.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Oct 2025 09:30:02 -0700 (PDT)
Date: Thu, 16 Oct 2025 18:29:56 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: xhci: Type check xhci_dbg_trace()
Message-ID: <20251016182956.0990936d.michal.pecio@gmail.com>
In-Reply-To: <20251016182813.3d10a8a3.michal.pecio@gmail.com>
References: <20251016182813.3d10a8a3.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

xhci_dbg_trace() is a printf-like function which can be type checked
at build time. Do it to catch potential format bugs in the driver.

I found no remaining warnings on x86-64 and ARM.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 485ea7fc0433..8facba10fc9c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1788,6 +1788,7 @@ static inline bool xhci_link_chain_quirk(struct xhci_hcd *xhci, enum xhci_ring_t
 /* xHCI debugging */
 char *xhci_get_slot_state(struct xhci_hcd *xhci,
 		struct xhci_container_ctx *ctx);
+__printf(3, 4)
 void xhci_dbg_trace(struct xhci_hcd *xhci, void (*trace)(struct va_format *),
 			const char *fmt, ...);
 
-- 
2.48.1

