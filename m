Return-Path: <linux-kernel+bounces-864646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBCFBFB410
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253E54244E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304C2FFF9C;
	Wed, 22 Oct 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEKHGYFB"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FEE3168EE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127038; cv=none; b=Q4lmcusx/FtnTg6QPNsvk+bjb+wxUhEDRvBBy+W1C/K3l8zYo9iXRdW9msmP9Er8Rv7/LDoT6hSpFapcLP9rwTeR0Z7onA5hPu5RyVEwFd8QCBWaGvDFV+2eorTwa880H1gPgRBPp6NJbsi23VaJv/DdbYOeoOrrepFd1CyBZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127038; c=relaxed/simple;
	bh=wN9Q3uT/APNg6OkulWgr96HuAy+oNncZUYHY5IfGeYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAKTymeOBcCdlflLRwwdkemz5vvVhMWKoeM9AXWOHwSdt71qeEHbEoFXH7Mck6Uh9XK1OcyATyHM8p7eb1EoPMa3rHrv0wUdRU9sqmN0GC9jvdFX6bbCHea2RBzGxAUhk9jp/31+MSKPo1up9yoTqW4seqKr1sDraERKBEFuuUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEKHGYFB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso193797a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761127036; x=1761731836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cl7N2ui7kr+b4udEzc4TVTWZwNlnYctrVJRWmXvgl34=;
        b=YEKHGYFB4D2FBzkWcctYg37H0ThVNUQzqnzVbB2gv1Vz8FZFwuAWGRA3KxpwAa+W9c
         uk7NwvhKh4Ur8H5pyflp6ZChBrVkdv60FwycAhExY6awzYScWIWi7ImC013ltNZuEL30
         ao64LcjgBtYwRMiPjvnQEpIKHO4BRzzZsdoS2crf4evh5v3xbWgWwA1oTLfaC/mJZTCQ
         XEqga4mFXT9PqBVy/cdrUDrAwtX2T1yQo8n1AY1bLE8zXIqgZhBwxI7qLerp2Wrh/o8B
         mNz+63/i1sD40D1CmENP0JhznIwE1JaaYAw3XbVQxvbktMDQmWSe7uxJx3OuuoTyUE3k
         1CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127036; x=1761731836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cl7N2ui7kr+b4udEzc4TVTWZwNlnYctrVJRWmXvgl34=;
        b=miAhc4xvPmpgFDkNZchvsfxBi14QvoeSqyAwncMu8KX1IiZG6ewg1uQrExIZdOG9Hs
         u28/Pp4Ue4QaN4JxSIJSpzO+inUMC/4KqDHvSswThC7NjkLYlWxcwJzakIPLnvt/tEG1
         SZkoHA2sv+i0tvcuL1Kd85OkJCtb9E9y/e14gJ8uZ6UwoOH3XstqMnsOIZRa3Dia/sPa
         oc+DWtEUhnI4N1247Kvxery7gIySz6XQN8osg1wXuiYDGVRRZY5pdScBtOp+Xb++HdnV
         9hOlQQT1eLFt8SndiWHHKlgF0xdFB2jsnJMtkjBpeUa5S6rSwW0ydwGBTTyyvZsuZ+/R
         5XYg==
X-Forwarded-Encrypted: i=1; AJvYcCXTc1P5BO4rn6iowzkiviLdGSicUjgjN1qWZBzpqddwqhf16AoJSmjAERsiN8WPD79Sca2SfnULXIN7+mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTeses0C456bzoK8t0JRhrZKXsjdsZ2Z6JrJttJrr82Tv+bK6
	gYnblZ8QAje1D84VUgq9TXGPLSHl4gIxNmVkVPj7IUUOQlyHXPzKf6nA
X-Gm-Gg: ASbGncuGiLTq7pIa7FdHlCMpP/MnMfDWCMa3tKsaWSn6ngkPr3nTpWmlohpWW7vij6Z
	pBHZ3gK2VUNrrjPydM5Smvp37z/+8jnJhHP7ctq/9h+4ccSm3bfjZISMWcX9DffB+4oHxpd8fVu
	Af0idT7tc49gK8CHP0FzM/1tbFo3MFUoI6SCnBLWm/5s6iBQvx0Bwx1mOMVazvWzir1Zyz+GUCf
	LwMWUNxQsSWwx6dgOGgEGAPmLYkKHpmUAgW2nHw0hxNOJZqXD/LuxMdy5n1XESE3DGOKTXJW8My
	iwrbxrIhHEzTztvXSVSYANpNuGdtuWa/O0Gu+qrSf8Q9XmrBdfg2rvNq9162P3hvXEbIj/WxJ59
	dIQhWKDrKJXcBX698nwhldamsIFTK1YSjYyELE4lFWhGu73GhgSvdJE09En5Xc8x4h/omHYRFt5
	Ly5LTOtrMO/QdX
X-Google-Smtp-Source: AGHT+IF3WUZDt7YSsNEXLOZBjU3UIvaUcQfsKtl1wqO3MCT2yR7YZwvkOYLt1SYpR/F97Ojif30FHg==
X-Received: by 2002:a17:902:e790:b0:292:c97c:3569 with SMTP id d9443c01a7336-292c97c35e5mr90150135ad.48.1761127035784;
        Wed, 22 Oct 2025 02:57:15 -0700 (PDT)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5c0bsm133341425ad.69.2025.10.22.02.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:57:15 -0700 (PDT)
Message-ID: <75b39774-4542-44f1-9360-524f644a409b@gmail.com>
Date: Wed, 22 Oct 2025 15:27:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add support for QCS615 talos evk
 board
To: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251014120223.1914790-1-tessolveupstream@gmail.com>
 <20251014120223.1914790-3-tessolveupstream@gmail.com>
 <89f812bc-68ec-4a88-ac58-1f6797496151@kernel.org>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <89f812bc-68ec-4a88-ac58-1f6797496151@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/10/25 18:51, Krzysztof Kozlowski wrote:
> On 14/10/2025 14:02, Sudarshan Shetty wrote:
>> Introduce the device tree support for the QCS615-based talos-evk
>> platform, which follows the SMARC (Smart Mobility ARChitecture)
>> standard. The platform is composed of two main hardware
>> components: the talos-evk-som and the talos-evk carrier board.
>>
>> The talos-evk-som is a compact System on Module that integrates the
>> QCS615 SoC, PMIC, and essential GPIO connectivity. It follows the
>> SMARC standard, which defines a modular form factor allowing the SoM
>> to be paired with different carrier boards for varied applications.
> 
> You already sent next patch so this is simply incomplete. Please squash
> other work here.

Understood!
Will squash other work here in v4 patch.
> 
> Best regards,
> Krzysztof


