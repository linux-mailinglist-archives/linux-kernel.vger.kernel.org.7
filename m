Return-Path: <linux-kernel+bounces-831238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3CB9C2A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7424E113E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD04D32896F;
	Wed, 24 Sep 2025 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LezvN7pK"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1D2868B5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746421; cv=none; b=XoBCAvMajxqdZpQKWXXD2FOFgwdKvszpvv+LQRk5B6EpltCCIWeEKFRhGHLQJVDZhDA+fgsbxXPYhwCWMTr7BOZ2HYSrTh4vPXXTJi97gF9vg93jCpt1rglDt75FBUFjeJ42/bzp24SXY3nJ25Le67OslR4Q0tz0CQpn7BnHTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746421; c=relaxed/simple;
	bh=GT1Z3zQ5tXrk46UXjX5RxfRkN7haq4MDk3g9uLlBYwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNFwsPSkT7V6G0Xv/z/mqCba4bMrFEv61GoUn93lPKcqwwpchhL2E3Z14l5UCKp5gj9clJpdryl5d8l/UcHt4b9WFSPKrkDcd79sqySFj2VHsezxMArKPAhvIwv6uo+/nWMxb8NpicS6N4YI1mS3TdnVjJoorS+o6I14GGgLaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LezvN7pK; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-889b846c314so13749639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758746418; x=1759351218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PDdGlP7wUqpVFvBq+vcD4g0qwNo+YCXe03tGr3XqXM=;
        b=LezvN7pKxzIth2tp1hq18bdbNdrD4EkwKMS6ncPYB85jfoFjVHSbYTbf06PRAD/9z5
         7wceSrsCoTHUTMIEgiuvu5hus4/QBfqxEoMrVzxM2XAv9mw0OMg6qSV/uKwjmpFrzBz2
         yp2qCPEETxXHt4Pdzldy9FxBihFYrBvq9gsew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746418; x=1759351218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PDdGlP7wUqpVFvBq+vcD4g0qwNo+YCXe03tGr3XqXM=;
        b=hQbQ4+P+igPtItex+2/F1Qc3RlgFVQIBknFDNpXFyvXiCaSV7y9hhva7i5pHHgXeol
         Y2qRYKsJGNNdl/hPwmW/KCYpeq0T64NaDsrNEGUfDr8fhI/pdFsgsT8t5oH30Mhm/RGK
         tY2AUPE1hrl0Yc+4uC6w5dSl5EtwVLY4Z9B7KLoUuh835ObOU1Tm5hxPmjyzTmUHuyX7
         NaNpBzhIiOTGtVZsiF/1Cpknc9GeLKS90yXcZSV6cXs08xSfiF6VWHRRswvVaMS3AcfG
         Jgro2sP22dfekSpxfiT3dfgBkP2Jw6yK0VNBlkH8izt7aTEkM140LslfsBSAxWsyHctV
         rBTw==
X-Forwarded-Encrypted: i=1; AJvYcCVWlq0s4kvrLssETLKj2AYHPSCfIgnixorm6fz3u6lPfkgshld+RFzZFINDzXcUep7NC08kxEYsWkxpOE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NjxWzxxg03iUYZek8/PmBDZbEHay5BHQhJxpXvpXv0t5CWr4
	xmGfmnrcP3OoBN/A10HbrtaQSwqpKAkEOuOzIS3CXH4SBtYiLhmy353pePUYBnSoBGI=
X-Gm-Gg: ASbGnct4tdgL7MFceofL/+UVWBfQzQRgu/VTqq11Cb/xX3/KZJFfYl/sQXpEBTmdkyy
	EsNhgQKH8rOLewuHO0S5KB9aprOfHUulWkIdWyArADE7IiIrMZf9s34QNXl5L/iXEdY8OCxzK5J
	4cUcX5y915wxOddcF5GF5G1s3DsuVCkY74HpeASKlnQmkIfjxDbSMPNK7lZ/BZxLVGAkdBBhNS6
	TI5U9dqmnPay6FoIZnmDgfPRxbE9P3ekzfdN3EOD1l67m2OusRjWDbnBq7o6A1wJ+FnrSJW5Z6u
	7tZY9Gg9G5V3BUm121PcBIVlRvjG88cDAPzLUmAICQbDk7X1zX/SL8ZB43sXJ/8IWYEL9jNyDOp
	+rY5FU8Z+rt2AnG2YjYOIwjemB3jbLc6S85M=
X-Google-Smtp-Source: AGHT+IEl66KjPbfHgezvX7WogNWPlR6drYL1cc+80f/7wHyxzxceno/Pv/D4A/ViWYjgRD45h23gsA==
X-Received: by 2002:a05:6602:2d88:b0:89a:8809:1767 with SMTP id ca18e2360f4ac-901509454b7mr162008239f.2.1758746418319;
        Wed, 24 Sep 2025 13:40:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9040fcf19eesm797539f.22.2025.09.24.13.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 13:40:17 -0700 (PDT)
Message-ID: <4cd10eda-945c-4bd6-a077-1d9a104dba6c@linuxfoundation.org>
Date: Wed, 24 Sep 2025 14:40:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] usb: vhci-hcd: Switch to dev_err_probe() in probe
 path
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
 <20250902-vhci-hcd-cleanup-v1-16-1d46247cb234@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-16-1d46247cb234@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 05:56, Cristian Ciocaltea wrote:
> Replace pr_err() calls in vhci_hcd_probe() with dev_err_probe(), to
> simplify error handling a bit and improve consistency.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

