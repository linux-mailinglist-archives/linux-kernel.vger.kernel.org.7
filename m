Return-Path: <linux-kernel+bounces-805367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1C0B487AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C133BB219
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2362ECE95;
	Mon,  8 Sep 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b0DkwHX2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CAA224891
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321920; cv=none; b=YRlzWT6WSmK0UdkYzG3kefaI4Rzd240FhG0hJ1hyXA7eynUlCyIFka1YMCy2KoNKirXf+XpcGKFwnOTjUBcjt9J97TkFT6GbLk9zlr5EB7LFp4Dm+Va8o59ZdvioGFxVQ9nLMHEPg9HrDhAAMuS6N1raMdBl3lZuoBCd6Dlej8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321920; c=relaxed/simple;
	bh=hXMqYZB+dzFdO3jGjqJYJjjQZ3ufPz/qF0Ix6++QEmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJsNs+QZI8wOOxxkJBqs0dTnoucOn+6xA7jofOLhq9q/RPE3Pesjp/ZVDIGTBKvTHvyvNaAf51Mcu5yTmqijLju3hhdRRGdbrhYJTKaMkd2wGaXGI6IAo6xkNY2L5zqsFzPbY0t+aWTxMv0WSY/GgRptDAm1ol2ISauoOzxDYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b0DkwHX2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45cb659e858so28295535e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757321917; x=1757926717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0jq9k6S1X/e5F9Xchbc7rGyj3NJPtYlYz8J30jdCq0=;
        b=b0DkwHX2psakjnW+vI0A6KQMvmeJcPq49SOBb1OaGJsX3/BDbg5Ros+CYb0eO+xIFl
         NYF9pd5Hp+T5eKHUpqkEMjP32ooF6hxPaewF/9iz3CObhT+qObXmxgs8e2sKPmrC2Ila
         /tcs4FZHuD0nWsS3eaZdgflfRSSMu1nduZ/lLgJk1Z1l8uXWpHdAPt8MiqzAUuHA1MnE
         ZULSTbCSoY0h9+2rtF+L1ZgRO6OpOO5JqET5W3vvGWDUpWuWeJlLj6hDouXrk6gl66kk
         HJNqCmxeMVqrzMOWPUl3ySrPERsXL9L/4lw83g2LR4D5Zx2O5BqXmqfgd/LWHJiQ65Mv
         glPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757321917; x=1757926717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0jq9k6S1X/e5F9Xchbc7rGyj3NJPtYlYz8J30jdCq0=;
        b=llxLYsogtBViDNe4OG639ezYtJeyOUaORtu0mIX5RA8TNHZRJA/8Pvg8Ss4rlF0/rb
         8jHC59+Yy/wUIFiqOTHwQllTMv+SIGC3HjWymgvSIZJvzO97+DRf9PhfkItF/U306213
         72HihmRdTMpS/SFbC58noM+VPmsWBlMMYaXoT2/1F0StLyTwKR4iHCu+CsxoP8yufMYU
         K7GNTejDaUBgbxzkp4uDNbUeJL0WEjN3HyXmfUhyeLz9KVpGHWgy9UsnGxN+rxZmczSL
         wYc8MylcjwUjVdQ94kIqWUIH9L+Nq9SU8XCWes7TYZ5DoCQkPbaRDRWuykFGLpXgY6FJ
         66kg==
X-Forwarded-Encrypted: i=1; AJvYcCVGrXucYAntM9y2C9rtVKtmtAvSKGqKC1LDV3Xrxa/RmQEjxoT0BVrSeCOUTJfA4RRriENiMJ4ERQM+z3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYTJ8HtMOK9AH6GRwgZ/T+mps3ek7kAxFrDJNqs1YC/UZjGbg
	Nt2evPstdDU91T1N7yz0vS1VkHyFnWibUZa6YM6iURLKL9Z/nWGREOWSmXu3uIhS+XE=
X-Gm-Gg: ASbGncvoNEn+3Zg41+/HxoyhGmFJrwcldP1oYnTznXahKUase8y0SIWUzByITYrrjcJ
	W/jBLIaav3NB8JyVYuKEMhuodi6n0vo9wlgnVQtkTO8Mk0GoyMiQZaMQ7AhVNCderQ/hNnbcTEH
	cHlHvaSG9/lydasKtDVmJ4ZQzwy1d4WSKZu5VEtjwUc07voGWGwqC/iy3KG3oeSrQZDqtsT+wHn
	Tkl47heeM0lBUeVaPV/qUCh8ThBjWmGud+9wcNc1E1qqV2PLUhLB7VVIdCQJrZ1PsXitA+1hoJw
	qLopCYBToHxowG5nwsf2pyOhhhATfeGsXwZTwB+/SgRhWMT8kXAQt5oj5RR69YXmPBDo9qdoRGm
	i34qYsCXm8iNvY9muFZNC+yAPSGawqRLolb4Bo+ql9bVFD5kyWZOaGIxSbTxvUNjyfW9zuku0qL
	ul
X-Google-Smtp-Source: AGHT+IFwnKSywr3YUucpMr3gpELSM4ZF5bkk2uEvqsnnRBInVJnpPYYORFNWuYxFNMxf8Ye8kouDJw==
X-Received: by 2002:a05:600c:3b83:b0:45d:e326:96fb with SMTP id 5b1f17b1804b1-45de3269948mr45255075e9.30.1757321916984;
        Mon, 08 Sep 2025 01:58:36 -0700 (PDT)
Received: from ?IPV6:2001:a61:13ec:c301:8f4b:c388:33a0:9bc1? ([2001:a61:13ec:c301:8f4b:c388:33a0:9bc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd05d0c43sm91396815e9.2.2025.09.08.01.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:58:36 -0700 (PDT)
Message-ID: <fb8c0ad4-0626-4d03-a7f9-a03629566b99@suse.com>
Date: Mon, 8 Sep 2025 10:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: core: notify unrecognized usb device
To: Greg KH <gregkh@linuxfoundation.org>,
 Akshay Gujar <Akshay.Gujar@harman.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 naveen.v@harman.com, sankarkumar.krishnasamy@harman.com
References: <2025022131-silo-impeach-3f24@gregkh>
 <20250826165244.22283-1-Akshay.Gujar@harman.com>
 <2025090610-donation-sprawl-f6f7@gregkh>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2025090610-donation-sprawl-f6f7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/6/25 14:28, Greg KH wrote:
> That's a very big difference.  Enumeration failures happen all the time
> due to horrible cables and other hardware issues.  If you are now going
> to flood userspace with this information, it better be ready to handle
> it and do something with it.
> 
> But, for an enumeration failure, you can't do anything with it, so why
> report it at all?

that is probably not true. For once you can try another cable in many cases.
Currently we'd log this information. That is a worse way to handle this kind
of failure.
If there is an unrecoverable IO error, user space ought to be notified.
Syslog is not the best way to do so. There ought to be a standardized way
of doing this. However, this makes me say that this issue is not really
confined to USB. Other hotpluggable busses have the same issue.

	Regards
		Oliver


