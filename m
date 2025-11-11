Return-Path: <linux-kernel+bounces-895500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A6AC4E1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF1AE4E2DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720933AD8E;
	Tue, 11 Nov 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="mZhid9DW"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4B3328277
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867784; cv=none; b=f4G1w/lg8l0R2emVH9X4qmPMA1jsolpVnFBs4tDDhJSUZub3eUfkl5n+jxi7k+tXOhcOs3qVy8T8ytR/5+tx5Lc3V4NKVcUnZhbecBa+Y8ZphtJtzjSM7xyFLJlpxvv+He5uAN8o+c+hv572rhLxR8FUgtzc5mM9U47QZ6xYVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867784; c=relaxed/simple;
	bh=bu//jfiuAwMhl+hkQrkBg3mYTFbqBMdLLj9zyIwZ0fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ug/fK/CEpK9VQlnq/jrXTEiM8yQf7n26uQd/AtpaeB22sglU4ixhjyRcA2HH4Tx+ZSVdUwGN6DiJx22i3EvWwssrtneEPa1xxe1C/lDa1oNYPgNjeB/CTnLpUy0OQI+ZB4eoHeAPR624BJkSw14qiRWYzsETv/6gjbL6RjYgd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=mZhid9DW; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-92aee734585so176668939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1762867782; x=1763472582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMgbmudOUGCxAICCM0T13uChNu/ksfI0OswL7+Y1Lgg=;
        b=mZhid9DWFhRxX5ffaNaH0fc7kzh4zWxQqRzfwYPDnCrdvFivEhfZ7mJEs5gHUdfuL9
         cfBSSsz60oytkuhTqYdyg3mLUn0m8of4Lz7UDp+edC265r2nv3YWcm9/BURPBk0T2u3V
         XdOcj7xpNMLS+RakTqetzrx4/ou0qptvXAh2VK56JGjG1Cu2OxEi+N8p0XbB5tdjzTzL
         oqpZkFlYzmlhYpHK0nwX+GuxVvex80rs8BhGhv+v4ehXDMSXF1QgyAYJlnxF+O6/PLOR
         V4X5nz6MXYzBdWNXM4IbR+OVr/ZgjppqkuNrYG4JhTVHaUeyIzkQtsH89HaWf1BMx2XO
         4S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867782; x=1763472582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMgbmudOUGCxAICCM0T13uChNu/ksfI0OswL7+Y1Lgg=;
        b=Jamw6wgpaa/i9xjpZPBOuIJCtvuHM2n2AuUbvzGyNT9bC3zz7gFoMrPEo1BxmTkR7A
         KhEk7t1cRxd6fYbi4e6yOpZGVlF1WX/K7+sqC3A5KvexpHDndM90dWgQ6MOIvEiCxx84
         VCz7EzwGsV/LqApVGW0z8tBCqAMgl5zH5qeXWcYUe0iiO5jHhmc6Ty4+fpzevTIsK3YM
         8mdyCRg4v8QbRW2Zrv1tkrOeS+Yd/d+Ekf5S55p06ni7fm8FQppi3IjNyoGWcUQA13j2
         tk0zb8m3FChEiiBaQzRc2tbAD/8wEOBUZDRiOACTqeGbj8DcVV7sq5vRoZCnIncB82Ot
         3TDA==
X-Forwarded-Encrypted: i=1; AJvYcCVtcBHjX5pnY9hHhTv37PNbwdZrGrloP9iyHJ0xgZwzrhT6+TZP/+KfKsW/pFeqqsR0ibbwHpzjljFkFsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeuX5gxZxxC+c+7+VOd+QQ0I4xR/48ZLxTJ4u3u4PHcUiekrMK
	zOJZ/peUebHlkEmIK8NBy+SKwPSwmwYRCDQgiwYtU0GKCN82lac11/MfBSeIqt70F+I=
X-Gm-Gg: ASbGncvrmjnzza16gmr7ZQm/ylECsubdg24VnXHv9mZYdAO1ne9pxfNEYwHQa1h2wGo
	10kY3dDKCvCiTTdA7aUfNZK5iHo3DevQLUUbtn26rCmr/cFvydmGxXAYekEq3igCrFF1jxhbvTH
	HoK21CePTHHGK2nm9m9Uplo6JdzRATxrN7ckl/G67NCGTF+4SK4u3S+u85jOx+lcQY30KxJw1Wh
	H5Uk6ktyB6BPHH4OjnPP+QZLByzD7YXdWUvJoIdzpqtA+Z+rwVAGXusM60V71S7Ffr35sSeEc3g
	fJ2qrRlvboxxj0Ca+EncDMtdLeiD3tgWZ/TbpT5ow7cxJJy3a6cajopcHmQbHrVKzHF0gXCAsyY
	9jqPgE1OAJasaLMFZchaFVnoJrG0LORPx4neq8C8DL2zHq5S+CRPxNWK64EsgOV+cTJuEccSolt
	d0s8keLh3hRytwuT0=
X-Google-Smtp-Source: AGHT+IFtI399GCPHo3UIXPA8nkctB8TO+xlVxynLrsqyE1KKUsZzDqNEKh0oyIwjxAJ4OEJBYNsBiw==
X-Received: by 2002:a05:6e02:3081:b0:433:3315:e9ee with SMTP id e9e14a558f8ab-43367deab79mr197235215ab.10.1762867781812;
        Tue, 11 Nov 2025 05:29:41 -0800 (PST)
Received: from [192.168.5.95] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74698ad28sm6131101173.56.2025.11.11.05.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 05:29:41 -0800 (PST)
Message-ID: <13999fda-8c3b-488e-b14d-12fadb76f9cb@sladewatkins.com>
Date: Tue, 11 Nov 2025 08:29:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251111004536.460310036@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2025 7:32 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.

6.17.8-rc1 built and run on x86_64 test system with no errors or 
regressions:

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

