Return-Path: <linux-kernel+bounces-744987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C4B1134D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F967172780
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C78239E77;
	Thu, 24 Jul 2025 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqAYOTFG"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422321858A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394039; cv=none; b=p/tOUmRkOnLDeGMnXxefFOsuhoT/Y1X/5n3RKlmK8n9f4XRw70HV8Oo8gECq1aL7FUC9+9RMqGH5Kn5QGaXNxAmkZMyz05xy42JBEjTPBNWi0wAx9b/Y/3QJarbwUSEPsBw8M9U7o5i25qHvyV/ZIkkB0NF1PEhbiaTWlKP0Rlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394039; c=relaxed/simple;
	bh=cONpRMMRR0j8+5IMSCW+w3Dv5UbjFMlpzxjvfBz12sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq5qZ2a/bwsSJWPPcpXFunJJOjOujP1JpW/E5bFY24qPxY+DuGzgVK/Rsm7rhwVa7XJwA9/P2GZH68maTJiISJGXQh993datPubTZu5DH8onC9dexKQqugaAc1TTnXS9rmFff/Up2cNqsj+SbvtpT4fclhd8RmOz+x7A6bm3FXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WqAYOTFG; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-615a4b504b2so385455eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753394037; x=1753998837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ec+I/bNfYceVzsyoj94ElkmRmpTwfXXUO1soT24vA9Y=;
        b=WqAYOTFG5W0pBbtUTx1mY5uINZDOF3UvPO27BIGeBgYRA1RzZMeHHCsX+4BGWhWnKi
         ZDTt7FYgHtI1sCw9Lwl5SfsPwRjTV16l/2vXS4FJAj/Apoy0XiJLKr4xHsTdIUJ+a8we
         wUNBYdkI0c7BOjn3NoIko9W0ws5jxZTjr6Z3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753394037; x=1753998837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec+I/bNfYceVzsyoj94ElkmRmpTwfXXUO1soT24vA9Y=;
        b=TjbpLQj1OEzq+Uban4DNpM/adn/wIRt7Vy7TF77uWsxkwu7cNQmb2YAaxtmyy8b763
         hTYK3kLXg3thnAvuif4BeENVgblwrlg+7xxh/snXiEGfayvKLu6DtaFannVRisgv4DRL
         AxfQafOXCHrXy2zgZEIDv34w4vQY8VO0xWTJ5+qEhGkQFmGn86XbBzBK6gT8xxzgJjM5
         cfpsqwpqGVYsQzX6QFBEPkm60aqPhufZuteWqovo36EXB0Xbxpimqi/bvOu6JgNPqPWs
         1y4OjoUqjKeNAnEVCUK4egbdTX0/XWYxfPTsQugKoNQzRI2AX4Z3Ow1Xm5GCa0DunBSN
         1jVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZZC/XT1ekC0BS6A9vVKaCN1UoZDTyeKZMNI17hgSqMljdvgrHfzzt/C8phM3HJLKCC9gCkdm1zr66sKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylKQ6uV1zwRRtZ1dq4o31HCupSves6NM1cB1Kdz5gGQiUdUlrW
	FWB+ixvJm5kIhkQyH9zb9LDnzvtmmiAqJWJF3R2LdpeDQvIHeKEmADiWBVj2isoSodw=
X-Gm-Gg: ASbGncshPf+4i61pCJjefiCjCFryyiDPzKlLht0QRNLkaFiQiyHZsfBYc7+/g2ZD6OE
	JpAHN5XJRKYXJMoUsPWI+l9Zkal6/a0UJ5qjSnIZyjaueq4q+7/C9b0zdCh6GfuvugCziODF+Zp
	oXu74LFkh+y31itbm2ddu8JPlIg9V0ICNdb2enCPpCCJ3JjoryTq8hyg7CQ5bRBvUaX3nYqPeRT
	4cG7j9Nbp9QltHg382tSj/sYAQJRbbKuLWY0WufQD1W1KqAoCBKzS7DjwjoSqrPltQLi+5azyC0
	JY3qaxGSQR3ltePdSRqXPnYbaOGcMj3aTZnYzKjGToFba6tOIf/LTCbuxBfTvF7cYCJUJeMLq4g
	kqGgtDMWIZ61m1bxT/s7goYr3bwuQXw3ssg==
X-Google-Smtp-Source: AGHT+IEjVIBgoKwU7JAUm1idxYByEHXiDmed8r9RKzj3gIzufCwMdyKungjHAWAI3Qak8OLj+PIjsA==
X-Received: by 2002:a05:6870:a550:b0:2e8:7953:ece7 with SMTP id 586e51a60fabf-306c72032afmr5665997fac.24.1753394036875;
        Thu, 24 Jul 2025 14:53:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7412cf44fa9sm424813a34.0.2025.07.24.14.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:53:56 -0700 (PDT)
Message-ID: <94813f6a-e789-460c-a898-7c7fdfdfad2f@linuxfoundation.org>
Date: Thu, 24 Jul 2025 15:53:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Fix false failure of subsystem event
 test
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuahkhan@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tengda Wu <wutengda@huaweicloud.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250721134212.53c3e140@batman.local.home>
 <20250724095309.480882c8@batman.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250724095309.480882c8@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 07:53, Steven Rostedt wrote:
> Shuah,
> 
> Can you take this patch?

Done.

> 
> Thanks,
> 
> -- Steve
> 
> 
> On Mon, 21 Jul 2025 13:42:12 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>

Applied to linux-kselftext next for Linux 6.17-rc1.

thanks,
-- Shuah

