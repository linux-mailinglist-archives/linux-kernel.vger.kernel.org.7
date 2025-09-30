Return-Path: <linux-kernel+bounces-838050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE1BAE520
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A957C1943064
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7991EB9E3;
	Tue, 30 Sep 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dnJctcFl"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282133EC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257220; cv=none; b=jhEJ4Gcp8CPjW3qeaDJzdYbhyY76CvNd1XKF7OCavw0LhRuxaTleBAK+VED/1+eOJcNkPF0+I+IC9rCYwFnYNRXT4h8SuTXhAZW9NixIt5pglkowVT92e+yW+dDB2DzlwGhVul7+Aj22Z4RwbAMbez1bOmtYNP79OJddCZYBomc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257220; c=relaxed/simple;
	bh=zVlyMZxxHo0RNdeW4XnKVTsVN5ixAUC0opYVbEaXHnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsm4hXzWXh2TWIv9V60RWUPKlThwzzBAsMpZYSJpHpTqVX7TQLOAgNREWUYmxaT7IA5YY3/M7UmTDKfNiJYPmKSmIM/h80B1VVT2DjP9HnPKu0eAHKFUAMvDl3mp6xxilJDxotDuckILTSnvfcN3JkwTXaogj3LRPNBGCVbJrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dnJctcFl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so5586728f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759257217; x=1759862017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZ0HvTGWGNVVCxU1HIxgw6BFLuWYpp+QnQXrw9yVN8M=;
        b=dnJctcFltRIaD/rFJkQyOVbkUX73urHnXU6xneUrVlPqJGDsNm+nZ0K+i9mZ3V8IZn
         VKx2KrAkt98F/a1ryvZph0RwEqTP4FCSa+6uCwGi+TqXHcdLpLk4i2dr7uvnXGru+KH7
         Lprvg8ZQYxXLkUBCQDFD7uMTQ7LlIPV5XobE8GbrwSXd2kKY2cY/fU1jyPURy3poJVqI
         gmaHovaJQcxg3trB/OabXyyXrVsG8lg+rURTTuZ4CdPny7TvvCEeACmt9/2ZJBgrbqRk
         awr5n7RwTGospnxbfGyzvJrCjBeSfFq1Hi/T7dI+wvjMgrUZoY/44M8JlHhH0RapIAFo
         TeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759257217; x=1759862017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ0HvTGWGNVVCxU1HIxgw6BFLuWYpp+QnQXrw9yVN8M=;
        b=I/t9bX8N/jVQM9o4radbN2k7ihuvofzugrHtmwaeA6dnLA2u4z7Ez4oaH309xntZ5c
         0pH78YSIG0fKg0RhiQgo0fodYuVFBxSRViiQPJd4CUyLQBF1L88rG6LhdWLm/EDIbiu4
         rWfMhFbZkbIQ6WLJR0rPqGhPHAHW2jEjDNgOyQWD5vmW9y8Fd91FoD7xiH474RUyVPhM
         WRC2oAeRKzX4oPuY+tDiKXOnQCpGxfy3aE4YH7nT3AR2wNx2xE7iH8DOsoyL5Q3ogpAS
         yISNUrhyzDTa6AlIQd9SgJ85TYF6V7e1OXa0K3o3jDQC3CEBPdU4hemYJC4ALFlMzudp
         j4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIBmoy6c9HFKjCIJ3aFUdTwynvkFhN+IHI+LsM1gVLriunZEiLfgtWRoCfx94l6KKqyXjyAYkP92ppPSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVr8IxuI/W/INUhQR92+ky0FJZ2UhrdG/uyFm8eE6WgkYYEheU
	UjRb78+IQHyWRDYzSFP+eQjYDtUUitFikiFAG/xoA/9mwp9xZWH8Km0=
X-Gm-Gg: ASbGnctKYdwKYD+tVAk3fshUefAZwOC+vGzswZW48QRlKF+f8z5mHLMlpDnqo7YOKf/
	ZnsRgLaDmRk3ACQjNfkvGibukpLgGJSb/1fpf6/ZcKjt88uoq4tzBb4SDHeiv+3DwvbYVpEMV8/
	G8yJjQ9eXe4NIgyP070o63Dsim6n87TTpexnk9i4rPW1+zPub4Zm79w6MN3C6z1MyuaEvZYqv+5
	/aFEDaYsv+fqRtch1Fj0l/WduBZkVcH6zHOUMTC4XcGooBJX/4XQlkg5M5PQ3XsJEztWJsAqnoM
	j7NaqulDueU6TXZ7dXXWNXlA/1QOlkGX/f3qpGv8ELwpBFGJYUNHwTVL0/v8fainHieHw6KdnVy
	rRWIubyAGrRGaF8qU0rosDR3FImsFB2H2dqQaEiu8EXcSM6grtCoh+52LTCsYPV3yTGHRs9IjnU
	Tgh4yIyqk3bXb2T4Cm3RadhCg=
X-Google-Smtp-Source: AGHT+IHVmRLkFZm9HoDiRSglZ+jRCxRWITUyBjqs9WQREg0IFVK2ZE+PbWpA+KG/kULEundNbrrJDA==
X-Received: by 2002:a05:6000:2388:b0:3ea:a496:9ba8 with SMTP id ffacd0b85a97d-4255780bc4dmr538317f8f.29.1759257216984;
        Tue, 30 Sep 2025 11:33:36 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4965.dip0.t-ipconnect.de. [91.43.73.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b8507sm4930375e9.3.2025.09.30.11.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:33:36 -0700 (PDT)
Message-ID: <babd43a7-6c7d-4368-b769-8d9456121d43@googlemail.com>
Date: Tue, 30 Sep 2025 20:33:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/73] 6.1.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143820.537407601@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2025 um 16:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.155 release.
> There are 73 patches in this series, all will be posted as a response
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

