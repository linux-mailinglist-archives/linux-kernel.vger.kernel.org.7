Return-Path: <linux-kernel+bounces-870552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04666C0B1D3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C823A3E2D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1996C263F38;
	Sun, 26 Oct 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WBSxHODl"
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9091AAE28
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509808; cv=none; b=YlXWIcHM2+msubTDApF9QKgD53nGhA2inw+odiNOX7nb6HjErzMdvxhSmeKrBSj3HDEBVihDKwsr4MId53tRGIi5T+QCDh0UzUIxuQxUSiC83rZCgA7mF/vOtsPDyneqKQ6PSOKRQBxs/OkcAQ4mmUjH3ZpmML0nsNHne04M5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509808; c=relaxed/simple;
	bh=D1w93OIYrBq11QB4TX80HocFtZ6iK3JjI3GpcGSyjww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzhUoL9vznIO8PT498q0BSotImKW5zMHN+ynIZzS2w6bH57zA863GNNxh3yUn1VsJUlrh5oB1GU5OSpGfOYyzhng5SeNzUKtLud4J7/aNzMEprEbw4SyXTl7bOJ2doqyN3cGGoWGLXfsF+XtBW8QQOUg9L921KXxkLqWujwqe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WBSxHODl; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-63bbf5f77daso4341943d50.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761509805; x=1762114605;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX98xM5uLTwNgSn/07WIOBdC4l1s/Q8i8XO2+Sj+EJg=;
        b=MuwpiLCl/5tuoFvHUPhma5gpD1Y/hDh9LsQz/EtBAPZ8lgKXwjXoNRhw4JXYcDCYTs
         H/v7SxIHIuesx3+odq+skmLSN9omAHnoDa7J/x/BR4jqn7Pn1AYdqPh1bWGM4v1absJf
         TJxXbYyVGDv1mtHzl7dfbUaFxooadj6dz4Hye42IflTyhfq6VHhec2xjo9pQK06R8e3e
         SeYGBLlP+CaaYJYH0XmOhbFCKBwMOOkHcZil0mAsfIzflSjeWAgRwHIg3lH11Rfe4VeQ
         moUpiBbKDQ7w0ZVKTmum4yE34KjY7YeQMyPyYk9TiUeLv1RjSVm7nil5zNePa6uhN61L
         1uFg==
X-Forwarded-Encrypted: i=1; AJvYcCVqARCBWcAY/83ppioq0OhO/CpwTEjo1TUztV2zv4fCMvGgloyLZ3tXdsSXaHMI94EYylEBM4EsWY6hreY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFsmtWI8VSrqNcNjWg9mRHOnNPkobhxyVSwyF32Uj/iAnHwk4
	vsjW+85YVAfyhP0O1OY+A7CVdjDLP1c0/EgH0RfxNpmdwqfOo64WLasEjSYQLIiCMBOjCqpGP3m
	Ty+4Z4GN9hCbm7W3ukjMgTeskLTYUZSsth36QrtKzmLBd5kojMbbUoZJbhuD5YRNxGAN9O2IKPg
	uz4EqIAOP4mPMnX4gCeuz44sQhSe9Kpztg1GcdM6cxCRLMjSGki+nQpQBbIDSqBo+cct/UDgUp3
	BVynHdwbWOkF3jsPBwnVdJV
X-Gm-Gg: ASbGncs56YK4R2zWATNoed7fNq7msZWq9R8+1WGKyX0zqcn+utHogZFafR7aCxp0WSx
	GUZENzSrw2ZPB72wfrAc1bnob5x3bsay8+aq1lgpVnU+AvVI685hCJsu3cq34GL4AbRygWzyYid
	QQ9yaWcuZ5QU3QU1+MhmFeITQgoJdxh20rePStCOl/MQQzkKRhGzLSS+H8qb9G2NDgL0u/84byJ
	zF4T8GuyIqAkWT2DlkgQO7LwJx2bMI3hY/DRbDcqVKvL0GszhLWqUmmkmaitQCH0hW9XULoqbiN
	xQp0WwyuKeWlrfGuMWiuRahtvhPjok8lzuiPc4U0+k8jwCM5tI3Q1M/7GCHzaajQSfmeqi09fvm
	IzIZ0DTNsNk4hHBQ8W4J6BOwLXSSyOlmOpgeydxZ38/c1sicXl4Hbm67uiyzHnjq4SUrP2a1xw1
	xhXvpW66M8gF0OSVTbvltgoHGaX7ix466j/46knnhTdA==
X-Google-Smtp-Source: AGHT+IE8XxihwK7iN4lNWc840y7V/h2RWXD24eJlnpp6Gewad7yHvM4rAGsMHSxZkF48+unrDx4DWYVcibSX
X-Received: by 2002:a05:690e:144e:b0:63e:1d91:f54d with SMTP id 956f58d0204a3-63e1d91f657mr23053776d50.35.1761509804785;
        Sun, 26 Oct 2025 13:16:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-785ed17a5e8sm3886907b3.11.2025.10.26.13.16.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:16:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f610f7325so2889580b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761509803; x=1762114603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aX98xM5uLTwNgSn/07WIOBdC4l1s/Q8i8XO2+Sj+EJg=;
        b=WBSxHODldrxDYV3jKxrAzjOirm5651f+sane+bPQkD1QKjl3mQlMTAcamgYShE/RmV
         UeHoDHNxkf+gg824Vhj0d1zlhvrmP6RXdcch7i5DQ4PJHvj7/MNJqbu5RnhDfqNSJY5h
         lKtDdWsTYS4Wyw+HXXdombUDKi9bI3kyNDiks=
X-Forwarded-Encrypted: i=1; AJvYcCVuq1z4YQ/5/bG12THVw7OMKdmuxvw7q4FOcIVwws1/XNbgG09BvwlAZSsTZKVEtHiD7GyL7GeQShgpX9c=@vger.kernel.org
X-Received: by 2002:a05:6a00:1916:b0:77f:2f7c:b709 with SMTP id d2e1a72fcca58-7a220a083f7mr40308903b3a.5.1761509803531;
        Sun, 26 Oct 2025 13:16:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:1916:b0:77f:2f7c:b709 with SMTP id d2e1a72fcca58-7a220a083f7mr40308882b3a.5.1761509803117;
        Sun, 26 Oct 2025 13:16:43 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414032c71sm5754054b3a.25.2025.10.26.13.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:16:41 -0700 (PDT)
Message-ID: <20ca3d0e-a935-4296-8678-5903310b3712@broadcom.com>
Date: Sun, 26 Oct 2025 13:16:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] pmdomain: bcm: bcm2835-power: Prepare to support
 BCM2712
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Willow Cunningham <willow.e.cunningham@gmail.com>,
 Stefan Wahren <wahrenst@gmx.net>, Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250917063233.1270-1-svarbanov@suse.de>
 <20250917063233.1270-2-svarbanov@suse.de>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250917063233.1270-2-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/16/2025 11:32 PM, Stanimir Varbanov wrote:
> BCM2712 has a PM block but lacks asb and rpivid_asb register
> spaces. To avoid unwanted results add a check for asb existence
> during probe and also add a new register offset for bcm2712 to
> control grafx_v3d power domain. The decision to use the new
> register is implicit - if asb register base is null then the
> driver is probed for bcm2712 (the other supported SoCs have
> asb register space).
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


