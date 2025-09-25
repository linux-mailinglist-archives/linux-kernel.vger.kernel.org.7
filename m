Return-Path: <linux-kernel+bounces-833116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB7EBA1412
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55CF4C85ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3531CA46;
	Thu, 25 Sep 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GYH8pmio"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E931D74E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829482; cv=none; b=Fs82Ne6JyZFSu2cjKaRL/BNRYQEiHOpuZFquAe/bCK92EHwhq+edE7QFe/qV3mQn8wtq9souS0WzkyKsGU8wQ44lLAfYg34q4wsoBVR78CdqZ+4ek6p15U7ux3iKyxXkkSsFoD2nikPUvVU8XMhI5MS38xp3oFfwidJxA7Rsp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829482; c=relaxed/simple;
	bh=hlXPqA9leDXyKU+a+StNvMRXfLd7Oiz0q/nTjQYZxBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZjNISNWWqH18qyNnUSjG28HvFvsId3P+eGpgoa5KOomNO2Mi24Jhd0Q9P8Wz9frA5hnGkUDvUZHVv/J3D39dOZ8YBenppal0vtqomZCaeZtfsIrxv/2vp+wrlbuApWuEr97rYFdyLlc8Ah9mQhbCVI1rnVZJeysR4h2lFrzCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GYH8pmio; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42576a07eeeso12083785ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758829480; x=1759434280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=or54vQrDlSCc4oUoPw4bOHl4mIflQax8gxz1ImqODMU=;
        b=GYH8pmiom14ZpZtigjGxS20dZbUrgA0wHsSkqgPWK69dQGxtZrQdYc1HTSts3cI/B8
         9QPV62PzEGKjGvKKfwSsi57ZVtnRgWY2XQnPkj0FXyCFRPAjOILwu8X4rCMwP+lSybHb
         1CiuHILRKzG+OH0yWwbsQ8gbJyNMeIhY7qDqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829480; x=1759434280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or54vQrDlSCc4oUoPw4bOHl4mIflQax8gxz1ImqODMU=;
        b=FI3kocaoOHBsZ7gxgv0kUfti9Z1XlEBAdK/T0BdipLh3SQDL9qAeM12BJbQVn5C8RX
         wAdfihnCzNO4zcCfvA09seOJDgP6U5BFRxPXp0EaOvxlN+NRarhmZMegFJvEmW5MSJ0+
         yWt+WReh+r2lJwooxUYuyMlXUNyLnExwhKpMs1CHKk9sc01ZDxDTkyDD1Fdm9/6X+ECo
         Lt5jU3ybKKkEpWW+09cdhuv7Scp8jbh5JgwLrC8YbdfTNJfPGHnTDVBdYVcrxKcXpvaN
         h+2GnOhqdEEN7Vk2Wf4AXcIAejn9GyVHnIXWQIf6gK3h5jjHbcnQ9hH4IcvthoFerGy7
         XLtg==
X-Forwarded-Encrypted: i=1; AJvYcCWSeQWg/f9Pkgtjt5MqoJALCz6cXPRNiAbyrnG0nm7sg/WZ6yqZ26I3j/BL4kmTNHo3dDyBxOKijr8dljc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKo0gsUpWt7NnbZxaxT4VdNMFqYnVzNpo9/lJaPpUZUxdpnsm
	PaTO8T6Wc5QSODYWi+HT9h/IwSXp8dDVkXIAJgILsI8hfQ1tnb6umFAxbYWD9pWVQUY=
X-Gm-Gg: ASbGnctpu/w4xEZ1o9btXbwxjhino3fM/+EwLIv0Z1YU/fG0rVoXYi+mz2hUbkKeFU/
	VlD96XbWwBVl/0AjMkrFhdIfPanDFfuooRKZX4GR7x7t1G1oJzpHM9laV7Ch7KvSbBMrUwctTev
	OrXOGTxsei07KemxozzwR9M+UgoZptiImwUPULgLQ0uESFOEaI15zMwUG1r+mj+3vUHYTRrbJQm
	Y/JfFgxFiksrhBVd9EwXPeT79ges+LMoG9Dw4PdNNXewAGO90aKG+venHhlxmQ+qBnYHk7IYIMM
	RwAagAXCa5o+hQ6ood8N7n1UOuyfheyITJ0aU4rg11lA6zoAG1Wvge6ACoJyVwZ3CZHlmdQBGP7
	ez1E2G5GojQIRSNgwTS0RVUwPqV3cAeqywgbsIPltmuQWvg==
X-Google-Smtp-Source: AGHT+IEPVyp7JzGHapxNvv4LYOPSv8tJ+j6O50sbKDaIYjBItoXAtC7pX4vo8bCfw1S4ZxWm8QkoJA==
X-Received: by 2002:a05:6e02:1fe8:b0:424:64c7:ffae with SMTP id e9e14a558f8ab-425955ed735mr80558725ab.12.1758829480118;
        Thu, 25 Sep 2025 12:44:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6ae6ec6esm1116952173.76.2025.09.25.12.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:44:39 -0700 (PDT)
Message-ID: <3fe5d44f-cf33-42b2-bb91-6a4238f83470@linuxfoundation.org>
Date: Thu, 25 Sep 2025 13:44:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/kexec: Ignore selftest binary
To: Sohil Mehta <sohil.mehta@intel.com>, Shuah Khan <shuah@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Cc: Simon Horman <horms@kernel.org>, Dylan Yudaken <dyudaken@gmail.com>,
 Moon Hee Lee <moonhee.lee.ca@gmail.com>,
 Ricardo Canuelo <ricardo.canuelo@collabora.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250919170139.3452889-1-sohil.mehta@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250919170139.3452889-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/25 11:01, Sohil Mehta wrote:
> From: Dylan Yudaken <dyudaken@gmail.com>
> 
> Add a .gitignore for the test case build object.
> 
> Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> The binary creates some noise. The patch to fix that seems to have
> fallen through the cracks. Sending another revision with an expanded Cc
> list.
> 
> v2:
>   - Pick up the review tag
> 
> v1: https://lore.kernel.org/all/20250623232549.3263273-1-dyudaken@gmail.com/
> ---

Applied to linux-kselftest next for Linux 6.18-rc1.

thanks,
-- Shuah

