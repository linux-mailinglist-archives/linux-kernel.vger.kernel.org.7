Return-Path: <linux-kernel+bounces-784391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B4B33AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB3F4865E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF6A2C0263;
	Mon, 25 Aug 2025 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM9N10BA"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4DB2D372C;
	Mon, 25 Aug 2025 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113880; cv=none; b=jtmNoxPC+EblRV27yLU/NN+diVvATruvMA5SbSUXmAAecDSeqEGUBq1kXFyN74zvv6o7Fw9QL2xXUa1rU4g9LHamVtZOybIrGOHIQ0TbeLikWhtifqIbm0iwYbFGsS9Ito208iw+mYXXMFS72HwWGSOO7w2r1rgGP11lpvuMfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113880; c=relaxed/simple;
	bh=J+EH/7RDxPq+xAlt0TRQnGUGW8nNs7BWa86kYwJc8xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJGMJr53xBtQWHJXZgZDIVS6uxK1R3AHJZ0Du8ZLxnNDKjqDPhN00KAogPMo1r128nVGH6xhb7730KaICmsKuTXloAL+qay35C1FLshaWPa7hDMs6f8BDukEANh72tm0YlNWqGQ+vRtNRR6jLv+THlBlXXL1Pxs/kc4iThWk7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM9N10BA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso958646b3a.2;
        Mon, 25 Aug 2025 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113877; x=1756718677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sM4hZ1puiRHKUqzwGkov59Rx7fxdUJpK7AlV9haEfhw=;
        b=cM9N10BAXB4QgcGm3/TD1jTKtniEOTKflAnyp+ftaHlqRmM8/cFbtOvZCb0Eq/94ZM
         P3Txqbj3fccAQGQmMrh9lIpqXEUSePFbX/PgQJFhXTY56a2f+NkNcQSj1OtWDLyEcl8y
         hlmWMv4jyjpIRkiUgJj2z2agET6vxnErlxY3jIHnjakfDEQkGoDSsYJHPG8parpP7Nyt
         BTfdrQtxbfGLnLWM84zkDIMKX4nandggml8+D7IBBC9SntY07ePdJ1zJoMuUTH0EEcWH
         AbYZKuGgn/stU8UbjFoETMPcOMJ6VxyuF0KFvFFzEm2qHb8BeGT38Dt9xYTnjKwPaXdC
         KLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113877; x=1756718677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sM4hZ1puiRHKUqzwGkov59Rx7fxdUJpK7AlV9haEfhw=;
        b=frnl4cOP0xkuvf54QbUqQ34zYtuaa6gYAmLblaDmY0yk4YStRbTjjC8DLxxmP18QOd
         PspttMxWmxs3ye3u5+TUTzlvW4BLFN59CyxqBT4nRslKzcRi8KhK4cjkfPW089g1S2Dl
         +FlhJTrx4fXx6XRvU8uEN1gLJe6D5b7Vi2R1FIzPBhB/apQYLtePfUOZdXgT0zg1wft4
         DS4QVmnrMwbFE0eZIg1gG+a7Cb57f3yRGFjB5g4wDxlQhSlIK0LhCfS2cZ7I2hIe1Mrr
         lRaIv3SBh+AeGY+HVHoDQwoexxMFZV1A/gUl5q3nNnuIxdh6TG/VhRP8chIk/tTVwK98
         gF/w==
X-Forwarded-Encrypted: i=1; AJvYcCWLuFCXiUuDqnqW+rXgymJCH5NkrAffIzORBdbBYPBZo9R2EKzpSviCDCMwReWGLJvcPiRG/rT3z2X37bbC@vger.kernel.org, AJvYcCWV8Oz7nUBamCd2jOGUbFzKUxly/amTVpTNGolC+I3Dvel1FA01w1LD0zvm6ylWSOz/EcvJSCLqDhdD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54Mz2/yU9bmUIxvX8/ySnWRjixGpMxGdhzwiLGtqgVm6P5zqy
	DIRYY28I2IBpC/jmnP1raNVs7WCfBx8d16ofXVx/6ele5fxSB8t6D50+
X-Gm-Gg: ASbGnct71IPb094+aZ9Fuj+cL9c+bWerhkqj1yW/0TIdWHKtzc8m5AmYA3pXkfgrhqx
	i1f1j9D0E51fPRmDUEvXbwNGbUIAuZq0Ub7w1mPNUtd8LonOHeeFQmT5IOPrN3a07xpKWInJMBB
	/Xr3fkUxlHx3HyNizO7k14MOIvs6vNSF2xdKrGQZ+Veg4bGWJM/EiTxVDZ8/w7BxWL4P2wQV9Ne
	R2TUXLbkqqCAvXtzmvx2u0K7WD6smXJHpWNgPmrIlV8HoifSysmRuL4gXAg3BCzMHoy0dVZnpEL
	3emRa/JvH0VYGIb1Me69WTxKA1Vtc3vTerZdPHduEf6H9ZyDHytLMkVGpQBcPwudTZV/yfqglqL
	SJLs5GeF1QUoNTHMWOUiBl6yINnTdOOV0
X-Google-Smtp-Source: AGHT+IF2Lj1I/oMHmRomgFUcdk/gVeJ+3cAJcySQ+eYOGXApg2tOeqaENjSgPcrhwsxhI+VbRT5g3A==
X-Received: by 2002:a05:6a20:7286:b0:240:3ebe:ea34 with SMTP id adf61e73a8af0-24340d2bf18mr16359852637.33.1756113877525;
        Mon, 25 Aug 2025 02:24:37 -0700 (PDT)
Received: from [192.168.1.111] ([59.188.211.98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7b375sm6121879a12.29.2025.08.25.02.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 02:24:37 -0700 (PDT)
Message-ID: <89826428-4a54-435b-b564-b0be49b8c7bc@gmail.com>
Date: Mon, 25 Aug 2025 17:24:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support ANS2 NVMe on Apple A11
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 25/8/2025 17:15, Nick Chan wrote:


[...]
> Patch 6-7 adds support for the NVMe controller found in Apple A11 SoC> Patch 8-9 adds the required device tree nodes.

A correction since patches are removed:

Patch 1-2 adds support for the NVMe controller found in Apple A11 SoC
Patch 3-4 adds the required device tree nodes.


> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
> Changes in v4:
> - Remove the remaining added long line in drivers/nvme/host/apple.c
> - Drop already applied SART and mailbox patches (based on top of
>   apple-soc/drivers-6.18)
> - Link to v3: https://lore.kernel.org/r/20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com
[...]

