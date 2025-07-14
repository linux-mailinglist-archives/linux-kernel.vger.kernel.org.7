Return-Path: <linux-kernel+bounces-730260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7631AB04204
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E4C170D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C282571BE;
	Mon, 14 Jul 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q40qDfwz"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4502561A7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504144; cv=none; b=PNMBx4qyxzUu44Kg1KQ/Q8OWOsTq5GJ8d09CHRPuxMplxrg5v7wlPTW+GPYm1vmIJ9t/UeP1cWoEMqThC0A13QNGV3oCzvIoRXlAoLz60vUQ8Uec/2a41sbdxD3KmWUg8wMS7l9Np8c347JvL6F1a59MzviWYMqKj6ANqaS52fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504144; c=relaxed/simple;
	bh=I7Pxnln1BUjfe7HcY5t1QvJulXfLwXmFHrmFWRkwVbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXh9aJEDDvZVIDeAAdSk7CnPvCDVMbZIQ6+qVSxiB68z87f37QKD8jAuN7hEKB1gmTAPiCQ+50CrDUQM0cA6zsy+Unu41qmSpUqXOrUApzhnzEUXja7/HUtawj7ilVwUP1z+Uyuo+W6ioascpiTNEf6dTHf/noy+KTRtUxLno8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q40qDfwz; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so3223150f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752504142; x=1753108942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgT/ZO8DO6Wf1bRdrDifcHYIjUyKTX9Eo/tSV9XIcEY=;
        b=q40qDfwzSIA14x1r/J2rEkv6K1gxFsLR9g71YzjpsE6p6yyKnDL03XaUeaipq9qbtE
         sPSscV7zXPXPszZUWxrwFO2bmGXSxRHADAfkUMipJq5vD+gKVUVDzVPI9fX/tAosqAyW
         9e5VLaDKcTtGFlDJLH8CG+W2sj1fsnVEj5yJP9PqvcMk7KH+2MaeMRSgKRJTsyh0zky+
         UQSSKm0HPvwQ5EQnxzpi449raR24hCiotmch5uSmR6aZCoU72L4RvO+Y88A/q9YeQpQp
         eFi3WaqKBvxd/WWVjVI8UX/00lhKz8RDu8qhZo1MfAoQrPkssUCcWq3FDos4k6BkosUC
         bk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504142; x=1753108942;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgT/ZO8DO6Wf1bRdrDifcHYIjUyKTX9Eo/tSV9XIcEY=;
        b=g6JWDNnSJj6SxUIJJYpSshy/vo5yWfZQ70VJL14mLVGrm93t+HCr3V3BtYHrEsYKBg
         XAgR9Q8cbEp/XLchujrE8cj2BhLIvUNnFqLwQiVL0AaDtwOXKelxAB5EDd791niqBBw2
         0SnFi303Hxk9s8NKauONfGsW84zZ3g5+8UrvPKesdtaNtMwP61mHdWY0RJI/xL/dQhGa
         q2HwHkFxeOzKl2EmAnPgESctYvijJW2EcYzePi0ZdGfoENzUxtTobGCg54vEYuw1+zlz
         8E49H2Pf15/GDkQUjENffaSkGSuzvCbBWjtDuTDb/M5qvuJILYrTNH5Ku0RKZVUNL641
         SO+g==
X-Forwarded-Encrypted: i=1; AJvYcCUmpcctmoMsEPUcciKwVFMO8dm+tgsa3EWrkJv9XHvUW7aeAupZsm6CV/uw+T0Cg5ZvGl4vAYuSNhcKXv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZZ/Ss9ifCL/QrlFscEZUfjGmDny+XrTGmnKtU0XIEMfY+eZS
	0y63vRHAmTBekYsLeVnI0iEFH3fcQJPJWnz/mH6LVT/+djZeOlpHlQtaPqmHWauPVZw=
X-Gm-Gg: ASbGnctGRHGe1lJtskK66S0sUmB3FA5SmEWleVwaXAfT/lmya/WY9DgAl4EsgxbUSm/
	KaTooa+X2Ag8tVOs6ZAeuaXOPk5HOqV8qsA9n7Qe//rZeaDMggiz6MkZyQsLhdl6CaK9rLk8CYf
	w5byy6x3Nn4mWtduoSvwY3GwnwM4fG1SmQixRpd/Z5bhGRHB498y83wf6u7UFeH9JH9Ps8xML6b
	uq9lmbLOMYWLpORaQUaOu1FbTQ5ZEdVonGL9rdrlw8FPaZdw2qP2wDyX3+CAqQsmlVw47J9T803
	G7aFXVOvBPGK4mH6GbBVy/8aW/0unO+s4vUpIfW5k9DyBuYiQXvmCAtBB+fGN1+wPvncdhc+tSk
	e7mfMNhgQ19YMMiL9pfBEkZYQxc3GGnH3SyeVY5vDRBum60Zpcy+L5dsNKbuK0ws=
X-Google-Smtp-Source: AGHT+IEi60GCx6StklZNLN6fInXr5r58gDpnVQSjnfRk5TaJycuEkJOCyklDv2cd+DxYgwPBiYqnHQ==
X-Received: by 2002:a05:6000:240d:b0:3a5:6860:f47f with SMTP id ffacd0b85a97d-3b5f1c67c67mr12717295f8f.6.1752504141614;
        Mon, 14 Jul 2025 07:42:21 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26ee3sm12845397f8f.96.2025.07.14.07.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:42:21 -0700 (PDT)
Message-ID: <01080f5f-f3e6-4989-ac84-766c030dda35@linaro.org>
Date: Mon, 14 Jul 2025 15:42:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom: Add MIPI CSI2 C-PHY/DPHY
 Combo schema
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-1-74acbb5b162b@linaro.org>
 <8ed5eeee-78a2-4b26-989f-03676a9e5da7@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <8ed5eeee-78a2-4b26-989f-03676a9e5da7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/07/2025 15:13, Vladimir Zapolskiy wrote:
> 
> There is no ports at all, which makes the device tree node unusable,
> since you can not provide a way to connect any sensors to the phy.

data-ports should go from sensor to the consumer of the data camss/csid 
not to the PHY.

Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml

https://lore.kernel.org/linux-media/20240220-rk3568-vicap-v9-12-ace1e5cc4a82@collabora.com/

---
bod

