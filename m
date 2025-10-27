Return-Path: <linux-kernel+bounces-872795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C3C1209E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68934188B563
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DBB330334;
	Mon, 27 Oct 2025 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="YUq8R8B+"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A232E73D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607833; cv=none; b=P34g9fA7cx5rTRIn17t9IYAqaLDoTqoJkM6wvpHNUKxySjB7crY5hHbJbIxyMtdvDG+C3GAG43AMfYwMhmSB4BPcZvmEyuXV7uIKBZu8N7p/kMTjS4T2hDMXX1/EONemCy5Fxrrvs5lrMERgoiak6QW6TdzOrbWJHLfqUC/yO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607833; c=relaxed/simple;
	bh=Nnl4wmOlmjdjQpJ1AMKKTFq1A3BB/KMrnObJW1VIWVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxDtIrRGcH0diun8gT15DII1/NmBRzm1o7hFxjz2NWGqAwBzOoDFLDuVcMFMEypv0MaWDNJzZCgDNqH2YPgOez4mOHAieiMQ1DFqKjudd1OFueHBzHJ5ch+AytrboGNGy1+4CsXs9WOt/MrTd3hpJ7cUFzETHVsfARE/gLoJCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=YUq8R8B+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-430d4cf258fso20213235ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761607829; x=1762212629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldkibGRw4ckwZl2hrIKXdODRudH3hWdiwAG/LBXeHR0=;
        b=YUq8R8B+hhdEjQWZtki8XnxAHSp+KQm/nCEapsb9InbTxA///yo8/4L3Ys1YAvr8T8
         ymTYIPGOOq5TcMsN/I1uaYNEhn2GFE9Cwu3gY4EVM5r9Pv6dy29OMbmcWBS8GdcfGIZM
         rKTw49F52Q8CvUNVcl3o04M8TrFCIRbiyBsRF39yYvUC7ZtyJCkvMfhx9BGqauwiSk5E
         Bhl/WKGIG/mjFp2zP3uxbrfc9W4mHG8yKyyXAqa45y5MxUvxGYLy+HPzQpy9zE7kE44g
         lOOiL8niKTc0degt7AbBVemgs8l/Z60vBfp4CtCfC1lW3G4xbxSp/0qm4y97NBTlE8vI
         NZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607829; x=1762212629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldkibGRw4ckwZl2hrIKXdODRudH3hWdiwAG/LBXeHR0=;
        b=AoDWkjC0knNsVjZAwxvTbwC8+e1o34Bh4rsjAQRQ6YzwU9edWBiXdnbhJqQnQTMWDR
         XcH2JUw885FL5Aq//qYISttzA0oCFFfYccll2b0NHjpFOoIyGpyL1KBypzDWIdVWpHcd
         AC3tD5mWQLVR7Sx8lJ3u2uK4B32jXhiiJ+iyjja/v0741zhGGbduKG7SZ60TKGaoLvNB
         bbZWWTL4vsM4gWMZZJgCwtXVqdAVDocYlfpctqhgEGgtMUmDqhUcZCAMQHZo5zLQadyf
         Nx+0VC7SYDAn84p5LKk9GqdFdwSZYc4faabX97k2pwO2p4lxlXC/21C4YHdVOglG8gTz
         Z0ew==
X-Forwarded-Encrypted: i=1; AJvYcCUnwW+6uMT2OUZQE06BZ8qLIxpcxwOKeYmNopU1HQjqdtyCo7YcmjSZQ1Iv7w9al7Hf/K3hvZb7dD284gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjRTfXS1wEZUnhWhxaNJ0KkddeXkbt03iD1fKYzExga957CED
	jhlDBUVHLmkrs5AkxOCuXuE9YsGSTeH0iq30iPPvWcQLYhKHPA3RrDfSSIzVszsxnus=
X-Gm-Gg: ASbGncswM7STnUQ6OE/B3VcP5z5ZMOfR8yZjJ8uBUtIY0ZtqifN4GP4dTipVwnoK8qK
	p0MzkBUxwhq0Tk5fcFwa12NOJM9BBa3xA0WyIqWZFiYejPfsfiw+zTWT5f8w9BBMlsDJHHGUYM4
	+CkPHBe1ySww+g6OnXjVpby4UtH3HObzGy18hF3S0JOCbeqJpH1smgee15bmuulN4SBuyA28eq+
	JBrZViqGkuboc+dPxc+my+YD6PrOdLs/CsFeELB2nIaTtOTncP3uR5O+UB7P4xmssuMm+RoI59y
	LV6R7l7M9tOOrX8C2Vq0kF2Cr5qe+HhkSlkatPPsEEWpVmPjZkVXTrwkePetBgTId3AXLW/w6yR
	BsrjLO5rWIfxedEQH9f0fKGy64pzJiFfXsF1s/PjhHsiDilPBD0Z1OBfz0817Xw0YLdrs65ukZ0
	LsoxE/GOk6HkLYhD/7RZD7qZrc8Q==
X-Google-Smtp-Source: AGHT+IGvzhXXqslGv9MZEWsvITO+9e9W7hE2kfZZMLHX7/6QstVZpa1/aFSE39Xoa1TpQ7YAxXkmsw==
X-Received: by 2002:a05:6e02:174f:b0:42e:72ee:4164 with SMTP id e9e14a558f8ab-4320f841931mr25299905ab.23.1761607829334;
        Mon, 27 Oct 2025 16:30:29 -0700 (PDT)
Received: from [192.168.5.72] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f6874a1fsm36049655ab.18.2025.10.27.16.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 16:30:28 -0700 (PDT)
Message-ID: <a4ae843e-d401-4e25-af83-ed16ce80c2d3@sladewatkins.com>
Date: Mon, 27 Oct 2025 19:30:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183501.227243846@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2025 2:34 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.158 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

6.1.158-rc1 built and run on x86_64 test system with no errors or
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Slade

