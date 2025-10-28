Return-Path: <linux-kernel+bounces-872995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EDBC12CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF133189B842
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32BC27EFEF;
	Tue, 28 Oct 2025 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KxGpfoRm"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877E27F18F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623132; cv=none; b=HuVAE0aS1WlL120M8gPR+PoWsHE0Hg64YGP5G6azAYNxHG2jHzMg0Yvj9IANzraABVZeLuaj5q+zSPwYJArK1xczF8ELLt68QzbfxYOEE8U/cC+YDBhOSIzBsTxzFcszXIjE4ddf0HhC1yWj/z7CsZ5F3fMp4z6OyeKVvOJyrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623132; c=relaxed/simple;
	bh=KidjVKGLgarQNpGF00q4EvUkNmscuvzAOEAk0l1/r60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nmb4d9UpHBMyhdc7wgG/PapxpV1QlBMK5EDk26CLloFukX0co1YMLofnQ0G5yalFL8sc/UZeDgZG+aezO0wtwTZZ0laiCuvDEwYyxhH3c+rdlr2ay0aTisIcq+B0CpdtZzRpFRyiEmsKl5NwOVJJedgCLvRQ99j57sjG4N1WI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KxGpfoRm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso8105115a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761623129; x=1762227929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7GVt1v7G0WDNnH1zdoaYHuIyxA4YtNvwpKhFghPiGA=;
        b=KxGpfoRmNSQqiBOpeaLnJC/buXlD93KIbdqDC2GtbePPFGdKCU8miwgFdE8u2w0gFZ
         j7sTsJy7MNviCFHpzMfQ81CkoeLHRLD8XMRyBmN0ySEs1ks4uL2Q8SI+XjoTbqpRiM+b
         QcStL5fD0KTAZwX0dc2RNrOFw7m+uAtDtKFztK8m/pFRTc1g17bDXT5mMaH58w8QYlTc
         WDilPkFa2lnNqUhpVMCoxGLdE19DikrbLqPPb0i5+Fc+DQZvDhSMDsC+p4+gC6uz5QsB
         lXOeTmvJgSGx1NnjpRgw8AZU5CZLYQBcEcAQC2aBixnVC5K+iaJK5skt/6xSodJYwXWY
         FFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761623129; x=1762227929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7GVt1v7G0WDNnH1zdoaYHuIyxA4YtNvwpKhFghPiGA=;
        b=h8Qc5hxyMwnRgmiTQF6tG6sGwsfogDZKBvz0ESoDheZfY7wLNsKY6fUh1WyTaJuphW
         WegOUXykI3gAenpbXljmfnUSbka7Y3S5PhFNvmPiqQEPKpDdjbdUDlGNlPyp4qLpFCxS
         DN8dPQ9a9aC8eM0oPCu7eCuWhxlVOTApsL2kUwv2Jvxk1TsPmxvzx1jgKvbK7CiT93T8
         c1OtyVtp6zG+qGklZEAdx789lMttOOwN2h3aH8g5mNeUWbYfwIUG9wQcQOdJbNiSSpka
         pNDUbJPiaWOtYQRVym9mQu+lMLyhs7KIcYQR3F7knCzmDTLXZwyWPHbliz15Xd0bl4+E
         BAmg==
X-Forwarded-Encrypted: i=1; AJvYcCW6NUmz0hlo7jzV0p8tKj594LKFk22U4qQiqim9jxdyTo1YtMEyBdPlD4yohBMxsYUNp7TwS7hS1Ntg3cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZtt092V7rvzFJpbUkRW9ngCTcolNFULh03dbWoGTsc/PEoa3
	+3QaKZcT3n6hD/Dp9TPJBKZCxALk+h0fZ0+iVDljRzc84frejSSfJ9Q=
X-Gm-Gg: ASbGnctqQEsVtcxj2xtVGttJAFS9to0OJA02WAzbeZSlNlZSIRY57QtLv/rScSHuZzZ
	6mkGTD6J5naFL7AXgzi4DG+ZK7Ttc72c3KeiI1i+gUE2kjy+8ZO5rUpr2Yu2s6rNJOh8LjEfel+
	NsJoThGTTNvML+eEf/u/d5GAXwttdKMSyUBwf6pNY6tBrjqYggcCUUm8CEVFS6fvKnQColw6Kiv
	t47cv9QHJ1Zgs5bIfUtx201HqmGpTKc2YRyHuiE6jq6cVPYZWy0Rj+BspI4zuHgnblu62c2078p
	j3eIY2dNOC1V9pKxIiwGZSh77vDTM/p4KTWSL2cn6E+UxmTta9oAaLwrK9sS/e1Uj46RZqWbA1L
	32mTAMghcWn5iuovjvdWWLz1qx1d8RBfILfTBld2jgyrbSgl8D100o8upz39/7YwScsSHjoF2g/
	QdbQ8kcpoXRyT6dYoJxxNc+fFQK2QZBwFy4ZCXGj2Ewh9hDuNY+dc12hNRdTtgrg==
X-Google-Smtp-Source: AGHT+IEgy5yJL7k/IoRzMRfSxNY+mDkwZoZ4I8NMwRQxjmEkNkrb1HgCSFuIbsQrLU16vjMdJiSsag==
X-Received: by 2002:a05:6402:5cb:b0:639:720d:743 with SMTP id 4fb4d7f45d1cf-63ed8269cb7mr1758049a12.31.1761623128606;
        Mon, 27 Oct 2025 20:45:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a53.dip0.t-ipconnect.de. [91.5.122.83])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e86c6d7d3sm7445083a12.27.2025.10.27.20.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 20:45:28 -0700 (PDT)
Message-ID: <cbc3e356-9d9b-4aab-9a2d-4e2b96d76987@googlemail.com>
Date: Tue, 28 Oct 2025 04:45:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/84] 6.6.115-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183438.817309828@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.10.2025 um 19:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.115 release.
> There are 84 patches in this series, all will be posted as a response
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

