Return-Path: <linux-kernel+bounces-810110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BABBB51607
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2741C8410F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732003101D2;
	Wed, 10 Sep 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xc7loY9h"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC02D63F8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504585; cv=none; b=N8/FnRjzyfkPmhRmGJlD/h68CUHAiWME9FFInW6xhcJFuizSQh9DOEzkTas1wJ1XGxS7lC811jiMttnDwbNw9YJJCTkL/1ljLybC/ZSKVNMHX0Ts88FqGc69Y0M5Vw9ergIp36eUcfaId15eo+0xax/npK5ZXz+hAyBDODZUYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504585; c=relaxed/simple;
	bh=7erkqQUfFDNDoqNZM+Y5sZuMbqsM7zA0sqkOQSUJo/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfTUVrX3/k+dTakxUc+t7kMF2d3STNBRHIOCA0NpoRjC4Q3M3EwDgML6k9zWnXUewpYmNCyf7oT15klSj0U8b7ZxnSxfsw3nNDEAcQzZFV4OZeaEBAQ3okZYxASt5Y8eZr6CM4H4IwSeepzobdgCQUdnV5/OCpznkNsGd+cRq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xc7loY9h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45de6490e74so31772795e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757504582; x=1758109382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s1jk+7UWt3/KQ4Hq0cRl7QtdnfvZdalm5MXw8hOhqCM=;
        b=Xc7loY9hkTzOWrK6R0EXfYoWqNR3zbvVOH5bZtKphLhv2RuH8/s0hge4QjCB4sXh9o
         JSEO4R6s5C2bDWTEFd8RVAuuef81Cn4+dh/42JGmYFRWaA8BvI0Gvttx2qv6obJ5Qpl9
         M+6QijJtoEjA+74I7A5MnwO6Ap6n0MEgqfsb7co/6XDPvzPLyQ+5bUM5Tfr8edOUiMuc
         fr0ZpvtOoCMHVFbuaRag3nuE1PiYQzrwkI9BP+H3w83JtGUVaTHrAQdXsD5cI633rZTp
         cblUjoagDx/xEgQRUv8BKMBjmdl9Cjj/0AMqVcDNX1zIZZKpJ5X/pBxat6hK1YK714vy
         r0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757504582; x=1758109382;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1jk+7UWt3/KQ4Hq0cRl7QtdnfvZdalm5MXw8hOhqCM=;
        b=MFqjVr7URt6xXL+gmUzpq/mQy+uV2aKvEc/2TV6wVslvch62nIfnRiJHJSee+YqNWW
         VsiaFpQCdj70eDDFEdAVC65BzWHMkUlvdYnBQoIUANnt2nNyXK44jpVjhHVkkmLf2CK+
         z732D4MSU2Pj2DQV1jfd5aqwlwtpL3vQIYpYP0YUjZ5xVoRM4gJEfT+qQqz5Lf+p9YQl
         Kj6q2rGXynNYk3s/BCnDHcM3ZJ52QtPUxpzROXnoxUhQm35SyFxxGx1O/TEi/NL7PZRY
         phAQAw0XMc9kGLxqi+XK6u6rj+cWZwrRVWQwQ+1j0EzOF3rahHinQ5X2p3Jtz6n4dc9f
         RYcg==
X-Gm-Message-State: AOJu0YwwkxMNbc4TsUstlNTsntCkMKywjadfh7X8MX3mIcPxhw8f3TnA
	XadnDiMv3RHixI3fuJ5SOhH7sWEvdKkvUfQW/bGhXHdRAXQDefAZKnKI3nEcy9fvDKEXPmElIUb
	etoJg
X-Gm-Gg: ASbGncspjhHqK3M7XcpINkkj8nFLiHy8n0FRebP5UC3hZWEr0S88X6HqBJYRzZig5Ka
	6paIHWTiCv+HRpdNe91JpcD29Qq0g9kYqa5HI6ywzYuLUWGWn1fzwAsAfZy8q3tGa/TMsoJNQBz
	HyKP06nx3w1jQ9E3VZeIpSZjLLz97ApReNjAmHY/Mv8iOi2P1dBOfxoiW9JL+gUmAzvYzX0FVpH
	Im6nvsClpRUtWWnLVXHgyHONJyOnmpWYyx94Nn2eSart1tb3JO9ax9wtRGKOj3yjDm4aveNACIR
	TsQgSKWAOw+gOxe7N+A9MC7aJAWUmVjLvFe1B9DROKSTHUf/9SXbr3DAX8zQlU3saWUxviVF27H
	8Y/oNpFAdb8NIZXD8UFV5M49yF9/sP8tLQ/iJ
X-Google-Smtp-Source: AGHT+IH+j6qH3oc+eCgDA7i2ctQtgPa5otWLi0iezAGvsKTsTpCgidwk76vRbR+9ypAywYrH/lDE0g==
X-Received: by 2002:a05:6000:2481:b0:3d9:dbe6:e613 with SMTP id ffacd0b85a97d-3e6427d8186mr13664025f8f.15.1757504582013;
        Wed, 10 Sep 2025 04:43:02 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm6411006f8f.13.2025.09.10.04.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:43:01 -0700 (PDT)
Message-ID: <96b2a8c2-3619-4f9c-8760-aa396e63e472@suse.com>
Date: Wed, 10 Sep 2025 14:43:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/15] x86/mce: Set CR4.MCE last during init
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-1-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-1-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/25 18:40, Yazen Ghannam wrote:
> Set the CR4.MCE bit as the last step during init. This brings the MCA
> init flow closer to what is described in the x86 docs.
> 
> x86 docs:
> 	AMD		Intel
> 			MCG_CTL
> 	MCA_CONFIG	MCG_EXT_CTL
> 	MCi_CTL		MCi_CTL
> 	MCG_CTL
> 	CR4.MCE		CR4.MCE
> 
> Current Linux:
> 	AMD		Intel
> 	CR4.MCE		CR4.MCE
> 	MCG_CTL		MCG_CTL
> 	MCA_CONFIG	MCG_EXT_CTL
> 	MCi_CTL		MCi_CTL
> 
> Updated Linux:
> 	AMD		Intel
> 	MCG_CTL		MCG_CTL
> 	MCA_CONFIG	MCG_EXT_CTL
> 	MCi_CTL		MCi_CTL
> 	CR4.MCE		CR4.MCE
> 
> The new init flow will match Intel's docs, but there will still be a
> mismatch for AMD regarding MCG_CTL. However, there is no known issue
> with this ordering, so leave it for now.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com> 

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

