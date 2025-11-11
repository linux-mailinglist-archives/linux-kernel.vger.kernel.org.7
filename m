Return-Path: <linux-kernel+bounces-894403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356AC4A418
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 023434F3A04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78695271A94;
	Tue, 11 Nov 2025 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WkQYLSwa"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE692701DC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823053; cv=none; b=eaEr+y8lIfgkHsdCe3YykqNBPZEJwjz1N6XIaOy+J/KDs7wvHfV/hPiYQqkJvlkNwcwMQ2tree1cA4lO7wGmtvET+xi+tKf6gcaGsnV3QvjUT8q3UuDgOEmmTTwFrrwLd4vyKi1gsGb6BMT0WqkRXq+7/4lKgZwye8VUWyFRXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823053; c=relaxed/simple;
	bh=DTdn+TVj4y7K+zN2UdZO2AFswxa/7GKErpCpr9EpG1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/tok391ccEJMNbW3vm3tLkoq55Qu+PHgYU9zYnWJAlQWoCDFYnQCUY0RwDawgvUTnovjHvkCR8PDk+XpGhLATSfeknBU/15Tl6Rikgp/S+QVre/6RmVOrUzoD8vo1Pi2EcoTduzWzdWMwWeUocJjpeq1dcFOgowFSHTA0HO5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkQYLSwa; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-94880628ffaso9802939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762823051; x=1763427851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MldjgzoX1SZmnBCXHrYUgqyrT5ShEUH07RGZHBRdusU=;
        b=WkQYLSwa/insdvvaKQLr3wLwer6iZ/ZXyirwn7wVeVwJU0dJ9xouFgHBxgZ3PvXlHf
         CTQuKA0cRcLAXayJu5kHZfvpWLm3dO0WGY4/0uIKI3d0EdjOilYUNOtK2q4RS6l1uG05
         C1RzK8eqMvBla/Z+V2+iYp/WkTBK78ZE+vlqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762823051; x=1763427851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MldjgzoX1SZmnBCXHrYUgqyrT5ShEUH07RGZHBRdusU=;
        b=RCEYrbf+NhXr0Amdp887/S2mgmzErXIG98gCo1NvTbKDVke3rJbbM4HVjkcsaSfj27
         d2sGee2idPGiNx3uaFIbt+yThduntCrWMEQwnEHf4Th2+TemUcI/T6+foEIZV+shU5NL
         IIPblkhLVqhsNDn4797Da92NQa38O9Opg85dSPL1t7GtGT/Uodr6S0jFF5aJCR1u3V/m
         4QCBSkRznlfr+zprJ/yeWZ984j4u8hapQIkUkf89P6d5JObyCSJoirmTPSs7ipwfKPAw
         gldPEWJYeztGYiucfiR8cnHrIte5Z57a1K0hJssP/UYhkFrFQjwAGItxO62nKj50ZuCW
         +H2g==
X-Forwarded-Encrypted: i=1; AJvYcCXFvLFNJbpbGkXJQUOY9F1/lfcNcamFmdXtM4dAeGnBazFZB6pSdaUVBfeZ4ShKVPtMZfNmWplITsXvggg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUy8xV05Z6mjSJTbRTh2+QOD1exeiFNqUxY33gjC2zg2axl7t
	oGZ+uebydw7hNXuqS+dwfyllfnGhenb+vP5bKQmaQCj3i7m3kbaBf5KwCpzPMvcULPI=
X-Gm-Gg: ASbGncti1SSMh7e9BCt2IPIQv0dKpGWzCyScuCjVvWVxAeeHPspv4k+jm5ONjzNxRCX
	4Uak0Mcr8J9CQgCcQFFLLZforOALiGcPryQjdTO4wPtafbcuZyMU5Rw/IxwjBpdwb37T162YKhN
	0FfZ4oRHREfDAKcUwWRL7vD2t1meTrfYD96wQwMxXX2ubCi9opsGMYelUFQUFdejgcVGuxPaExx
	KNANohpe1/2dkR5vZ390GrN+Y72400jmjKQ3hBq66byD40PLI9ZUJwWR1oVl4H3wxBl2CrDuHo4
	/jQ5pRKF3HtFAm81PUTarfrFf+X9jg62FeQPmdP51O64VxC2LqxiEOC3Fg5aOlGL5QA8bVcB72Y
	IheIZ2puz+ZtJ7x/NV2nxcQ66mmyPzxOOua/2ZZgTARt5sXRns6swxkJAbSYtL93tMDXAWZwdqA
	fa83Lz+YhR987Q
X-Google-Smtp-Source: AGHT+IHCAPfObFCTUaFPUpafgOR5ZP0PrhCGHCniJcUGtCxxVGCtpG3U48p6kW/uACwO8atqxsSGWw==
X-Received: by 2002:a05:6e02:1c2d:b0:433:794c:8486 with SMTP id e9e14a558f8ab-4338be50e90mr22249085ab.2.1762823051177;
        Mon, 10 Nov 2025 17:04:11 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f457610sm61159575ab.13.2025.11.10.17.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 17:04:10 -0800 (PST)
Message-ID: <87d3c405-5cff-48f1-94e5-86e30d29c5e5@linuxfoundation.org>
Date: Mon, 10 Nov 2025 18:04:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Run sample events to clear page cache
 events
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251028122724.4bff9853@gandalf.local.home>
 <20251110171432.51364be9@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251110171432.51364be9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 15:14, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your urgent branch?

Applied to linux-kselftest fixes branch. Will send it
in an urgent pr.

thanks,
-- Shuah

