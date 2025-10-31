Return-Path: <linux-kernel+bounces-880464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB5C25CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D24188A60C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456F283129;
	Fri, 31 Oct 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DU0F+DiL"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD862820AC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923763; cv=none; b=DYcYA478olLrWaCapwDH+AcujV/a02UMGfsKXSJzqL/zEh6nTdDz5Q+950ADn5z1PvYeEv5DrhD+KcLfgFf3qPmykYn50dR1zPCW1qbAqgl8Q8xOPiDRIGUkLSgrIYF3t/dwK3XB7cHL0haRqa+Ic9vl2niL8wSIj13nlrqUNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923763; c=relaxed/simple;
	bh=eUAb/mo9BVisGAU17xCmrbjXymc9wy6A1ns8iz/biXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9E2aHhZzuieZUUhKgFzI7KwHe1/nPb5bEJvxLWr3DTnhDej3c0BtOD6MlQjwVEoMwWWqkX938ragdvw8aOvfAn0ZXt8L5YfgJX6dDvSM0Mt/7Bfz5ZvG+BUxH9fESkV+303wXO21Iz1Gz1QgzIBN0zg8xnnsIl0SGiQ9gMiehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DU0F+DiL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d78062424so410665966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761923758; x=1762528558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eg+6eCwAbvkcpEZ+k/S4nMUzhai7WXLq+sSlmm2fOvI=;
        b=DU0F+DiLP8iFJxMqVPgcqSkglNA5fwpE84KTVwYR+EuRGHFumIwrepJBs6VEEEvIjr
         NlCFlbFeuvQbfjOPOz4ql/PwugztySw3HBFEuYJPzPY5ADmNt3eSMYusQo0hMLYEe2qt
         13zYOb275ZwN8rig8kyZdfrXAZ2mLXg/ET89/1+NUIpYPhdh7Ns46c49Q8d4UxQTuOG4
         u6IlX0ITISyZ8zS+JKx5A0diKGyKMMM5WsGrrtULVEixaPlCGFI/DqSyqUwGnpYS5DUa
         D3m8ova+bJDfBjShtXYCKRHZAxEo/6pswDJPUCDbB0PDfp+Lqr1p8dEP8OXidnYS+5xd
         ij0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923758; x=1762528558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg+6eCwAbvkcpEZ+k/S4nMUzhai7WXLq+sSlmm2fOvI=;
        b=Dh+3oI5cg+8LMadiEtcnoK5aaVzpGbOaeZMrhEkjBa25SAQnHr68LE3YErR0T3F2Nk
         8y+l/p8wp1Nq5LNSmQpxirWs/JPVNr7FMWUPM2FPy4pul7nGUrVmKz8x86jmM+8boOX/
         ASjUTj1KXlRzEC2h3Nq/7AEW6hycn0nNdcUQOT0/prZwfqkYiH6hXyOewYVGTdbUjHEo
         UVbyPot2dbX5GwX+wBr3IV4nR4JnfLuhUJwPIkOMSTwPjd4PrNrEgkUTwFawVuskzvk8
         HYTkCgaNjmCbPY7awQs/te5H6NFzLGsu/1p1zKZSHcKdNpAetaLhYenFM7gW+o7xOkqb
         y32A==
X-Forwarded-Encrypted: i=1; AJvYcCWbjzH8+rWt/lR9NaM9PbwOWFLY0z/mrmLCKt5u2p4hrqhDvO+S5+97Uk80znnwQH+qMffgkyxEbF9HlLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YT4Mqga/DXOC6NqZ5N5Rw75sIsU7wVJ5ocBu50uxkvpefCzu
	cY8niwrj1hAPtech3hk7b/4nqW5+/3e2CN0yiC9hBoWs52fOx/iAM7w=
X-Gm-Gg: ASbGnctFFf1t+sdqriwBdKzKX/s5DKX6Syhr4IemqsIeNujDN0WzmMGK5oal6hO0ngs
	PqHHkhx8d52gB7h8HZWVD2hIkWypirzL4zXysoH8c8Pr+LOcs14e1W1IWmYxSKyzO5U5tJVDe0d
	p7KBBHTdjipdVy8N7QyPw0BoHju64bY8I2SiBCEhyCXKU7aGEN4qZ9q1G+A79XknomKGAyDbLCs
	j7NnvdrU/vucFk162PI04+3zbRV6knDrP5AKd+AVLbTdoNOB1MfpP4MHHL55XAdpDZOqf0Ymo6j
	qPs/esgIOkwpFy8Du6ThERDO9j4Cf25kw8eGKa+35lYpJ4JJ2VORzLjlnOzWScnf7c8GKbxyb6M
	bGkFkXTyjF+sm3dHx7ciriJo974jW35mcp4d4fMmwtxspgBYAEMafiNYJYc3JmB/n12qEdUZF6X
	HkaQsdCR57dYdnCxFE0Dh+r2j/GYa0jc0TNpSeKyg3cu/Z3aKmwal0aSPX+zudX3lZHe9dE4TNa
	fw=
X-Google-Smtp-Source: AGHT+IGPWGMLVJL/jMtX6sIhhugNOjUcreKSa+uyd/bBl6uvEtvgd2LMiAjRe4eEUZQRMBEjqeEVJA==
X-Received: by 2002:a17:907:728c:b0:b46:abad:430e with SMTP id a640c23a62f3a-b70704b5147mr429242966b.37.1761923757598;
        Fri, 31 Oct 2025 08:15:57 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3bb.dip0.t-ipconnect.de. [91.42.195.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c9dc34sm195390566b.55.2025.10.31.08.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 08:15:56 -0700 (PDT)
Message-ID: <a72857ff-f7e5-4be7-bfca-ebfac30c37fb@googlemail.com>
Date: Fri, 31 Oct 2025 16:15:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/32] 6.6.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251031140042.387255981@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251031140042.387255981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.10.2025 um 15:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.116 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

