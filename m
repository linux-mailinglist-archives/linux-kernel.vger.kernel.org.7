Return-Path: <linux-kernel+bounces-819719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE7AB7F0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C921C022F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0B32EA720;
	Tue, 16 Sep 2025 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RaJg9tNr"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E302E973F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063565; cv=none; b=UqZyT+5pEIzSTI6skJ8X/JQ1khhawle5DX4lJCclV8UENbPwe3gM+jT1NKENMr9+Cgo3+ETmmsgL/QTMMILXQ6C7rPU90wtEd3zXamo5tx8xBbLAcdF4LdMTL155mU9U+b40Lto0/INvK8VnmjrZs54mtQglWY0b1a9niQ6anmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063565; c=relaxed/simple;
	bh=kYWD/1pnHOiVcV/86OAJQo2hlBq8UVutDfZZWO+nnUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHH6Zpa6LCcPu6l0AXNmV8dKC2rqHqTSOaFoPD8rf7bHl4MqHQ1o/aQX7zd2aLQjjQ3QTABfwQQXQlb6poHw8355OAjnTF4zSGNnCMQygmRKf3GSWUAjhb0DFz8tcJzSHZ7nauX7wgYtMXqRo52m8b6TCCPkdB44XJGC4zZY/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RaJg9tNr; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80bdff6d1e4so605680285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758063563; x=1758668363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2Sobvr9+5pGFbp47+ByPtEfYFFz5lnTSyJG9VlL420=;
        b=RaJg9tNrYLCV4vFhW3l2kOjm8ZyYitbIFQi0+ddGYWu5r/uh7Ql4Hl+ELB4YG/pyim
         UI25Iza0iTfYwvoIZt2oallEWaQPBBYeD59UWr7EEpS5LkNz9ogLH9GKDBvj/jxQv4+E
         wIiBtp9zLKtjp8+tyAOulREJoddlqFqOTF6z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758063563; x=1758668363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2Sobvr9+5pGFbp47+ByPtEfYFFz5lnTSyJG9VlL420=;
        b=p1DUFAPXE8Yx0u+G2t4cdd9DBj4nrhtZ4f5mpxQi/pEzw90CYa7fBTvu72vknpOXxv
         CPl5BWmp+I6czayW76ynlrS7C7KyzRGSUiZFtM8iwvj08hxVCyQo+3xrt+8fGB0Eo9sD
         pvX2jqLqdsOZW30hnJfNFnH88Dotftu37+VBlFAU+S9AnoJwNpeRAFDQk89LzaScLXU6
         tms8CFlrv8Traql5mkXkUSQfRzgZr0KgodHOVw9l4eJOylXq83kr8vRhNW8KaEn3xc/o
         RO1mfxvLYZnMka6n0HBU/CsaakvYMi0zYmLMRMWixYh9H87KmBNRrh93IBpZlG6G8Haa
         lQSA==
X-Forwarded-Encrypted: i=1; AJvYcCWMj3nXT1gOmAzjuWGg6Bq/hQcy/8bBm0pNvErMFhrkjD+7vvRZqWoq4lfTAh4wl12G2JLd2JZ7Plk+brw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+l3mzLASddgt8sAJAd5HAsXgVKTZKGZae7IHsAh1XhRFyFLp
	q6Rqwksm+kAOv2jW5qeQtJPnrzz+GnCC3M2MN30EAl83/n4dqX1gvT4Y8IF7XNvIIvM=
X-Gm-Gg: ASbGnctCJcZb4AwTsJWdpg/UacXmEDnFi0q0dHrtdcTCPWxYKG1Uy2DxskbQZiHML3N
	Q+6w6zAZf+jefMNpmbmiiIBNmHLnwx7m1qVtVkqI6dEeYF43HWPljUb6WTLPKeBUlTuQUmoFWrZ
	pV3dYnSsLIujJaB1p5/IFJcnOVHkE/8xSRX82kUXrsFHyw5TUOrb7oVgkSDVyhuUCKW26/eI2g3
	YmEGUezeCUx/PvQekrgeRBGp7X8SLrRKpzG/018DkvgedZXJFaXyzY5J/V0fQsmB+QxGvFPoLbC
	2dg2N54k83IceowM8A+nKLQF5NlGa/BplDGYsumVqJ8iIF7jj1NA5Wf8YeZKVDG8L3M/pgCm96A
	RGxYmlt2DSEJ5aw4R3wvl2uc4sLi0xidZNC+bsL1BL4y6MAMrVt6ocn4cT7AkRFNk5ERxuefPne
	CPFbmbOcBF9s0bAaJrDmpMouciVTnrumXfbWe4jkMGFLA=
X-Google-Smtp-Source: AGHT+IHPewFSAtglBYb72x7KGBoL3MPQo1PXWAxums+c5Qp8pXMLQan4rC8XJhOv0uEYkxN+tL5s9A==
X-Received: by 2002:a05:620a:4629:b0:828:ee0c:64da with SMTP id af79cd13be357-8310f02c9fcmr5639285a.43.1758063562631;
        Tue, 16 Sep 2025 15:59:22 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8281e956653sm613334885a.32.2025.09.16.15.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:59:22 -0700 (PDT)
Message-ID: <fef87364-80e9-4cbb-909d-22b1af0e9d3f@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:59:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/Makefile: include $(INSTALL_DEP_TARGETS) in
 clean target to clean net/lib dependency
To: Jakub Kicinski <kuba@kernel.org>, Nai-Chen Cheng <bleach1827@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>
 <20250911164137.29da651f@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250911164137.29da651f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 17:41, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 19:30:32 +0800 Nai-Chen Cheng wrote:
>> The selftests 'make clean' does not clean the net/lib because it only
>> processes $(TARGETS) and ignores $(INSTALL_DEP_TARGETS). This leaves
>> compiled objects in net/lib after cleaning, requiring manual cleanup.
>>
>> Include $(INSTALL_DEP_TARGETS) in clean target to ensure net/lib
>> dependency is properly cleaned.
> 
> Shuah, please LMK if think it makes sense for netdev to take this
> (net/lib is the only DEP_TARGET today).

No problems - take this through netdev

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

