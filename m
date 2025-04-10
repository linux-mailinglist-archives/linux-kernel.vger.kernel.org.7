Return-Path: <linux-kernel+bounces-597327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AE6A8381A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 07:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7B1446A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 05:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37271FC0E2;
	Thu, 10 Apr 2025 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nhyg+23K"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07A1F09B2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744261760; cv=none; b=GjAB5eRO0Lg40x+L6Gyp3y5iurYs+9JXMRQNvDalaBV30s+QR8ToeunHbbCdBOp24zYV8VhlhsQ0bKwoqfFcoZZY/H+Sv9GTQxaG0NmmveJy+XnCvGIhH7bCzz3xuTdu4GuqfnMlWefrvz0thKI2MnpN0vbHPF44ZqazO5s6q8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744261760; c=relaxed/simple;
	bh=G16oVcschOk1bCBWwdD3ZsJUcsex2zjDzFXRZC7O9eo=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fhUxBR27rahQz77ZGzQrdrcryOUdkUZHpgwot8x8RFnBj7SBRTf//ysydEeZne69NB65Xo+X2qf4zX0jPBa5YaC3KIsSaMEmMyLFtPw1zymQgMxW888A2YusBrWTt4GYH3zWl0iFrrQX7XG1bl3IedmVVrb+ei/W90NGcT/TE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nhyg+23K; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2d0920c6f96so232363fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744261757; x=1744866557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G16oVcschOk1bCBWwdD3ZsJUcsex2zjDzFXRZC7O9eo=;
        b=Nhyg+23KIvdj2ds/dNoqaEQBtAsf+l8ko22/0+4jtvRN2tw9Xc7oxEI8f8BdnYDTiE
         wy/7saWqUY6bU6A6WaAv1yLARvwdxE1XGz4cX1LXU3HkjRenBGaTqV/cwhECJall2SEs
         b3T7jLsPsW0YtLGXBqKsEw1OfECpoBHejRrc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744261757; x=1744866557;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G16oVcschOk1bCBWwdD3ZsJUcsex2zjDzFXRZC7O9eo=;
        b=asaY8kSE/fZUrJvOrAKqhNhaXyaH/LtRYexJUUyMDoiijUnj2a4a3MXy0YHSUNUITh
         BiF6x2E3kyfE0oqFAAcElZe9RNAGhj5aatEXjnsSQYgYX4+1Ql0OGIAYvGZxL3MMCGj4
         1LBgA/f4/9cMbjLoAAqCvhsOPinJwoeWUquM0oeadXVotCCo4ue88OYt1C4xKg17w66O
         LKRkNUI36oS5caHNugkZsY78NYcWT5dlb9Uwr+aidGVve7tq3n9XavbPe17xLns4IHrV
         ESG2XcDOO+yh9OxamSE84A85PfbVjfiUXDEcLKzslz1gDlS9GodHSzJwquyVkbrf528k
         isUA==
X-Forwarded-Encrypted: i=1; AJvYcCUOYkdcOq7M7stz8IaZMJtwp2Ax9r6YOFlxdZ+b2U4FC1jrzucbodpJMMsVdVaJtmNJk0JpLaNl2rViqxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNt01w3u7yYpfglacbvjerCfgCZYjM4x4flkO9QJk9WHL4bwr
	Y9v2df8DDuUv7Wqfgcq8lLGs/CTGloKd2bop6T+SRuZ17KVED/WSRJYBSLViKw==
X-Gm-Gg: ASbGnctMPHCC+aVVek2vL7AhNVXmJJxnDcCvi8pW2ijwVlqQbsK5QVCGA5aCKhxk44t
	w+mtxdxo9bMcq5+Y91XpfJ2FBBqqyn3atxvJ7UHmXbAgWrVvwAYgGgrLdhpJ54wF/aCPXa609HC
	ADQf7fdYaio2wkKTpKLhvu1pU26VLFOl1UeIHMzYXr+7Acyw+C3tdNwBlgHaL1cfYH2C5ekKzaZ
	+hnhVNZt06I7xvmVCwwURLt+2R9Zs5ufYjCQAQNL2iOHzJ3eBLhaNnmgTzoTmRb0++v/nREDVZj
	iy7SMpMyxUAE5YQxzuAIzXd1im7iemfAhqmRlvBLlpx5T8l6Mjaimu+3A9n83sTNwtFPwDMQhwL
	H6SI=
X-Google-Smtp-Source: AGHT+IHf2dIBsgMwlqUxzHqfg0izmCh/XeIh4+y37IHWa4xRZwCt6+2s0H2VCnvp55v7eCTsGxhXjQ==
X-Received: by 2002:a05:6871:3320:b0:27b:61df:2160 with SMTP id 586e51a60fabf-2d0b383616dmr840067fac.31.1744261757422;
        Wed, 09 Apr 2025 22:09:17 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096cd3764sm534917fac.31.2025.04.09.22.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 22:09:16 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, "Kuan-Wei Chiu" <visitorckw@gmail.com>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>, <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>, <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <dmitry.torokhov@gmail.com>, <mchehab@kernel.org>, <awalls@md.metrocast.net>, <hverkuil@xs4all.nl>, <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>, <louis.peens@corigine.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, <parthiban.veerasooran@microchip.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <yury.norov@gmail.com>, <akpm@linux-foundation.org>, <jdelvare@suse.com>, <linux@roeck-us.net>, <alexandre.belloni@bootlin.com>, <pgaj@cadence.com>
CC: <hpa@zytor.com>, <alistair@popple.id.au>, <linux@rasmusvillemoes.dk>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-fsi@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>, <linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>, <linux-mtd@lists.infradead.org>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-serial@vger.kernel.org>, <bpf@vger.kernel.org>, <jserv@ccns.ncku.edu.tw>, <Frank.Li@nxp.com>, <linux-hwmon@vger.kernel.org>, <linux-i3c@lists.infradead.org>, <david.laight.linux@gmail.com>, <andrew.cooper3@citrix.com>, "Yu-Chun Lin" <eleanor15x@gmail.com>
Date: Thu, 10 Apr 2025 07:08:58 +0200
Message-ID: <1961e19ee10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <740c7de894d39249665c6333aa3175762cfb13c6.camel@sipsolutions.net>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-4-visitorckw@gmail.com>
 <25b7888d-f704-493b-a2d7-c5e8fff9cfb4@broadcom.com>
 <740c7de894d39249665c6333aa3175762cfb13c6.camel@sipsolutions.net>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v4 03/13] media: pci: cx18-av-vbi: Replace open-coded parity calculation with parity_odd()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 10, 2025 12:06:52 AM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2025-04-09 at 20:43 +0200, Arend van Spriel wrote:
>>
>> This is orthogonal to the change to parity_odd() though. More specific
>> to the new parity_odd() you can now do following as parity_odd()
>> argument is u64:
>>
>> err = !parity_odd(*(u16 *)p);
>
> Can it though? Need to be careful with alignment with that, I'd think.

My bad. You are absolutely right.

Gr. AvS
>



