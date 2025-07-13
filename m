Return-Path: <linux-kernel+bounces-729205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD970B0334D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C63217746E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1021F560B;
	Sun, 13 Jul 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJjPqClp"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE611C6FF5
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752445325; cv=none; b=bKyI9jgn7nUjrKDjmat+KU9YOwJe9nL6Fp6ue5VasA+w3HbsP5XE/o6dEhWqleb14c6V6juKi+5+VsKvv6C+ibxZ3CMmyF6m/mPjTDX5Hh4Ri6aUos+/xbPK0Vayb761hHeCtWmIz9XBVEHBd1YmGRczQTeKTmiQuXRfHQWXkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752445325; c=relaxed/simple;
	bh=2M05FiEV9oioJZ+K+AycdJhhGPNaMof4obeYtnotUlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyogMz58Zy92zGSD35DPi8UPjxkxAR00KrsPD6zv5zoJbTCGSjGbOSc4Mq9Bh7ejK1TbSou9XsVVso77IzF5kws3OuVfQ7PN6mqfo3D8TsQl/9n7udfNhymC7sytmx41fFcjHwczvcgFYxujX7R8JdoEZyXiDgEP6dyx/Vviguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJjPqClp; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-611e20dd2ffso849152eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752445321; x=1753050121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNQNXDV+LG1KwYa30nsj5pHp/8wtAgv4sSv2jyxQ0YI=;
        b=BJjPqClpEjeAfzj+kQB4D8osc1Hzl0LmeKEcI6iyka+IDbDcvzY6ghH6cp9KXdz0fS
         9Lf3ltEWw7Tehc/SIeqzUil3yuJ/2sXpWBsSKN03FUKSjSWs4iUbldzR2ItSxsTBxGlj
         RNyeaIxqM/p/hAEobsobrq6CuTDn264EW+KzA5YHImPTWbbvsnzhCSLzY2wre3YfVLqd
         cFOUwLxa5p2YBbmuxlZ9zQ5dnhXpfbW8MCDL3PULX03XVxYFJDwPlD/nrm88UC22xNn5
         joFCahlQyrdbpQN0GJeDDyREhMTjah1fTo/idtpk9gyFvMzk04iVqxQMG6LL37iWQdPC
         q7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752445321; x=1753050121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNQNXDV+LG1KwYa30nsj5pHp/8wtAgv4sSv2jyxQ0YI=;
        b=rtnVNOoESmw1KrD1ro4Q91Fp6S3+i89LSK3sfxolI+tRJi8xd4ymh0wg3QxK7dGBgm
         nDMDLhAKauSD1/2GLVMZvGGcOiyh6c+ZDubdSJdPv8aKxkzmb0eY16tgDbLzW+Ql+7DZ
         5VRxmR84Pt5rX+9B6jvo5BCa32Jkqa+FKyvwbQUctQ4NbvQo5NwGz5iVLmnbiZc3KNUs
         7Jzb0iIhgr0Wkwhlq39rKhSFh7SGd5IlJxkbEvP4pp1ASrwW2mZ0QrW1ab6F9hkWTP4i
         9CBuAoGZqCk9kDmc5BndU6LSU8FfQ2akdGTa7gzG46gIeI2HpO9be8cmqIWTbT+ymCjF
         Un6g==
X-Gm-Message-State: AOJu0YwTOQ+mvWsJRUMwOGB4BluEGZp3WJF1JZ0U/Ms7NA2uvS+wvNdq
	1Fl0C/+UGK/a/rn75Tu5ztn5M6Jt8zXphFmsiazKWMCy4pIvsTlD5I+n61QnJBfqDh4=
X-Gm-Gg: ASbGncss0SGGxPl4k+gcZGkAAJ/akxHE9KLr9tUBSZ5Iybs04Oguxohb0MTdidkaKul
	i8MKxsf39iUs5he6QJqUqfT6hf+oUMXjtm1rVc3UdrKeAbBvqMRAPQhLcpDRz/MJ8CZKvlnAD/l
	vmIx81yICE99O0JdAZj+73LgvgpLKY9+lswT0F+Rnrm69ID3a9BiojZO5SiSgyZHAs/fydzgRqU
	K9vBySFISSqsId6q5GuzUQgO/ZRIq239tv45/z1fJwbNAqpInKw7S377wY/3eJ96nD+IwmIVAQS
	jOlh2V4P4n/5lqo9/neuEzcC7byDMVY7iL6wfnfSkhSC3rEj+APP/ezPVKyha/hHnl3tv2wxRK5
	bFn1OrQtAoZu86lfOInQD1485TmsNe3t3dozqgvA=
X-Google-Smtp-Source: AGHT+IEwQsLEd/PvvlHThIaSsW4kNZExxQdlVLZn5vrAx4CPWSh7+UlvjFpD889J6qWA4s1GSDuYiw==
X-Received: by 2002:a05:6820:2d04:b0:613:c7cd:3b2b with SMTP id 006d021491bc7-613e5f854aamr9473019eaf.2.1752445321545;
        Sun, 13 Jul 2025 15:22:01 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d836a4sm1072154eaf.14.2025.07.13.15.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 15:22:00 -0700 (PDT)
Message-ID: <ceef9e43-5591-4c03-ba51-af1ccc68a05b@linaro.org>
Date: Sun, 13 Jul 2025 16:21:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/nolibc: add support for Alpha
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
 Matt Turner <mattst88@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/13/25 14:08, Thomas Weißschuh wrote:
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -709,6 +709,10 @@ int run_startup(int min, int max)
>   	/* checking NULL for argv/argv0, environ and _auxv is not enough, let's compare with sbrk(0) or &end */
>   	extern char end;
>   	char *brk = sbrk(0) != (void *)-1 ? sbrk(0) : &end;
> +#if defined(__alpha__)
> +	/* the ordering above does not work on an alpha kernel */
> +	brk = NULL;
> +#endif

The syscall api is different for brk on alpha.
A change to sys_brk or brk in include/nolibc/sys.h is required.


r~

