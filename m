Return-Path: <linux-kernel+bounces-884338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F24C2FF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BFD3A5F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FC0298CCF;
	Tue,  4 Nov 2025 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eJyXJ66O"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E319CCF5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245160; cv=none; b=XiArgmbofjeKUykrP6ncWBhZMmqUVJq2RS8RhJzxqan0Uo3TsDqPrWTm8IJmBFHnf3mX91MxopqKf3dNvBfk09B6hOqe1n2s/d+taEqXkTtU0HAlo8uGJZhdXUJBE+c4P8uL8B+DYRkpzelyGmHoiG7UBbAw1IqO7hFMKgB8GBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245160; c=relaxed/simple;
	bh=bbnG7EOudrl7NhtpBRMP0fZ+Ba2d12lorrOsYxk1lZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fnp9H473cJKcIAVAX4Gr7rqmppVaWKZQvoO9mJ74lz8++nWaz2866bvNGxTl9E6mUoa4A+jmS10o+qdJ1fyT7KWtlw/d2vZIERjWvo1xi13hTyqueJdjJ9qPSl7MpgI/iMVkdv+qoBLYnxdRMKIWwXsGF0kZjPWTbm9YvCBSJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eJyXJ66O; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775895d69cso900115e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762245156; x=1762849956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/O1TSTyTcVC+LZvOe26uYzr4lGVu8ZW4bCxIjulEb4=;
        b=eJyXJ66OWArUwoYcMG+aXKELa0bZRm51zlmx159+hIVkcJUrgW/AV9NMbM8SD8dAL0
         QNJSeSyvvGTCDtaD77jCr6JEPvJoWrexJ2mJ4KaWbf8RzOUekgiA0DuMvzkcx7QIgn50
         hn6FvZMeZ9T3d11gN1A55t9QBMc3YwjATZz917NaC4lx3EDDo+SrnTAew6vWksSMayEi
         X4UJ/DxdTcdmZzT/wuqeVSt3V8GaTNjnDq5PccT2xfiOmFP+tLI5c8XGwVEPvlsiOWJ2
         kuqy5hTdrDyv551wz2874QuzrExPTdF0xg8uKEZ12u066LC2L6P/xWK2H/0ahlnTpzup
         qPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245156; x=1762849956;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/O1TSTyTcVC+LZvOe26uYzr4lGVu8ZW4bCxIjulEb4=;
        b=I6rGBvXgAjlcmgqvN9DJ8xcbFnJEt6BsSR34hlaRvP7TBpgaDyey+wqGvPoTahDxFI
         AvLFX7XbdXyZeX8uQMygiyrsS9TsvMWnQL+JOtgR8/Di86NYO1+gRAzUmAEUHcXEk6Ry
         bj7K0xQe5RuvadYfxlxh5C7dUsZtKivckz4JdR5pZFnn1quyZiOMe97eUh/fw4InPIhJ
         qVxxtXgfM1u9/IDjidSbgfET7QurgIaDgYh/VsMz8OXSDoorSaSBCIwBEb+Yz4pG7yTm
         D98dykxXWEhYT+GFTkxCcEv1KplsY5JgcNgJj85lMTI7s96she1/JdyS9Sgka2bmpfcn
         hp6g==
X-Forwarded-Encrypted: i=1; AJvYcCWc3LNVKZ4d+38Q1K9YQXUq5DaYRCRqdd+YERXx+Vb6L4iDabg6xubFDnnyCkm4J0DpY3/H2UE/cuCWurg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvlKsj56p55pKrzFKDTKCr1wtqFNQ6Z5tKw9gTca4Gh4Fot1n
	V41N72RBLvw3vjiRqi3PcW/ikbCM1KmpuyXQt+gcynNkdYNiTsjEaA2eBr7reDU6imM=
X-Gm-Gg: ASbGncuOt0ojHSmPn313fdR/U1OdJ16tiotdHvQDcsCvH+GMaXfqgqPDfamgvNnXPek
	q88/rGP3MmVTi0s8K2ru7N9+NxY3aSMZL+U9DkOT+431vzouY3t0gzvhrb2596G7LmlQL1lwIL3
	WSJ1QGBKItmBHZowO5NBKbWf7E5lQeERm8Yl+ZOsaMRCQaOkE7eC3SPlN3hVrJNUUKKGRmza6f0
	mhe19yglYkDCUAFSX2CuCH9Rd6TM+EDTp6LJdPqj6viSL2mQp+hVkaoCIWpiKyAko31TsNlI1cT
	dYRanGwNf74nEJ5aprrsd9T/yypQ0Xc5V3826gb8Y/aYwgFuKospfb1ApJqj4WWBioleAX6mL71
	gEOnSa8+KrTum5ewPx18Ux3w+sFIf8Wbt+kWTPFm4T19Ju/lXWVJ4QQ/CjN3LaJ7rFD8qzrflOi
	xh3XWZD/5O
X-Google-Smtp-Source: AGHT+IEyhEqP/V11SA3HoR4U1HIXN+k13COmzT5HOb54Zc5gCin00HHaDach4NErIK6LqUlRHnvjuA==
X-Received: by 2002:a05:600c:820f:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-477308a07e5mr152274095e9.21.1762245155770;
        Tue, 04 Nov 2025 00:32:35 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5f8csm3188952f8f.23.2025.11.04.00.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 00:32:34 -0800 (PST)
Message-ID: <4cb0e6bf-4c46-4e41-861e-9fa80e652e86@tuxon.dev>
Date: Tue, 4 Nov 2025 10:32:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Redo PolarFire SoC's mailbox/clock devicestrees
 and related code
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 pierre-henry.moussay@microchip.com, valentina.fernandezalanis@microchip.com,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/25 18:11, Conor Dooley wrote:
>   dt-bindings: clk: microchip: mpfs: remove first reg region
>   clk: microchip: mpfs: use regmap for clocks

Applied to clk-microchip, thanks!

