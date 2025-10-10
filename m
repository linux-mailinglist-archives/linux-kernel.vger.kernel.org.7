Return-Path: <linux-kernel+bounces-848733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67315BCE730
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7C03BA7E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB5D302148;
	Fri, 10 Oct 2025 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T5n+v+Jp"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D33019D7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126968; cv=none; b=umh74TyOf6MVsW4djt4cZ9xE3PEBXAxL4mQrPA8JpoYEX7U0c5wSXLwGu7Cyiaf++/ydD+QZJSAgixCYQzUfVtEJQ0n07p7x7DoenPNX+VOnC5MlvOwJ0FP+9ym6rnr3LywOh5ECchEFFz11xzDFrWBx8oqqbT/JEtQj3uPY4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126968; c=relaxed/simple;
	bh=a0SX8kSR784b6penl5yfwzGgEtxTJ3kl50tCJ9L+ytw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsHYc1FEuMC/8DqjR5F9kbrQnsBYELssQuTb6btLlBZDfw2VfW5dnk5hD/M6uq2IJHRGCQpfgE9SNXx6ldU11OYCSQkhMLb30oMoYbYwacspmvo2fMQmRoTO5YW58HqDuVCtZXOFzyFELvWi6TCW0UtCYJ+5PkUdUEQB9cbtljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T5n+v+Jp; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42f8d7f116eso9560615ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760126966; x=1760731766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73mJei37SDLNEjyuCvIowUQets2tMYT4DQzAwbNhePI=;
        b=T5n+v+Jp+qZgMzYubWXECWkEGY2kgzcaZRcfs9igBfebL44D82Z5Rf8GeodIzNZSLU
         nz1a6zXbYWE1mLKjNhubqc/ngdzK+WxSFKyCb9GJ9JBPKtjl7TkjiZJ+yDXpGLUWxgBM
         /ph5J1JQySF31p9NKEnWpDESgyRVwC+nD3S0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126966; x=1760731766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73mJei37SDLNEjyuCvIowUQets2tMYT4DQzAwbNhePI=;
        b=csvJJ79568641otxiPF+AiqUi+sEP7gPKcVCIoJJLqal7yQ3KWjZjS5G+vXcQWNtx9
         YwKyII8YLP1QSp/Jo1TcDUcT6KfbK1JrcdUyT36e8Y9mv0fswMPuJlR6AUEOSkU8Zoaa
         pErhEopX3DWEB64gOs4R3REFgi+avEQ/PJATBJDedeKFC07gCTXbrHLuji96QO4OrygP
         MDhSnU/qc4huaELKiHeQEgL54S98NoKjJxn/RFmJMS2+xd7mBFXaoQeiH/tKcJwYFFEe
         3afU27hNgj99lPcimmgrr0LDJisHTFxubEgbxcoBCeeR6nS8mP8habjK20Gc0W+mrOaO
         eXsA==
X-Forwarded-Encrypted: i=1; AJvYcCVzkGTuQ9fYwCxFhJS4Tx6C6Vui5UVT7mk69lMZa9FRDk0yfXrLN41QWDTr4rQeDieskggvPA70dLRYiHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8ouYVxSjXrfLkRAmWAO4ejVYqpEY7BWw1n6P6C1KApq0EU9l
	vYcKN7tgwTt8lKigNIxArQ2hhu9qp3SoL7SqxIsXuBaLNswp539Hpnv1RxdWbq6dOYV2Qr6mJvd
	4B0xz
X-Gm-Gg: ASbGncuE5IXot8nA6uMJwL1ZIkL4aHHvkIgUMcz+FZuZ2+MPW4Cys4jhEpzqtb6qowm
	mvPflMu/nDqAr8bOZXd05dVqMaO/TomeeHjtJ77CzaWrvPefFLCTYpaH3SWsHGuo+k7Z5Re9maY
	1gGCy/X73Lr4tl2YDdfCoGMXdugHyDywjBp0Q6oxQeGigef8/V6/C9HseClYIzoGC/O1UaHJm3c
	ozdW1C8d5G5Rdt1CQI8Nyzj4ucfkp6AjAEah6+PVP+ABdswa6JjqazpZSor58mxSN08uwZLLvz+
	mhy7p5GNx5aEDl3nqiBCoRyS7yDIQiiOOf9VnykQtd1vnKHbeP59KVsTmRjGzK2prXDpNmw0vb2
	BJSJN6/0rJ7SuqQzPmiiROci3p8r117rh14qby5f9S0hcBy8IVrkczg==
X-Google-Smtp-Source: AGHT+IExfJ0SVNgKWSwK5nNYw70xExw5FwCwh1H8nQ16YOiFXCm7eW1/r+CH+IjqW338c6moXSgE4w==
X-Received: by 2002:a05:6e02:318a:b0:42f:8ee7:6494 with SMTP id e9e14a558f8ab-42f8ee76610mr112903845ab.9.1760126965990;
        Fri, 10 Oct 2025 13:09:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42fa5b44b58sm4846745ab.5.2025.10.10.13.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 13:09:25 -0700 (PDT)
Message-ID: <a28d1c19-9d93-46eb-81ef-9fa4a39581bc@linuxfoundation.org>
Date: Fri, 10 Oct 2025 14:09:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/30] selftests-dyndbg: add a dynamic_debug run_tests
 target
To: jim.cromie@gmail.com
Cc: shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
 <20251009175834.1024308-19-jim.cromie@gmail.com>
 <CAJfuBxw4G-6Ro06VkF_0K4hZ_=W1YqwJaN5=owvQiax1ShJwow@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAJfuBxw4G-6Ro06VkF_0K4hZ_=W1YqwJaN5=owvQiax1ShJwow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/25 13:20, jim.cromie@gmail.com wrote:
> cc'g Shua
> 
> On Thu, Oct 9, 2025 at 11:59 AM Jim Cromie <jim.cromie@gmail.com <mailto:jim.cromie@gmail.com>> wrote:
> 
>     Add a selftest script for dynamic-debug.  The config requires
>     CONFIG_TEST_DYNAMIC_DEBUG=m and CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m,
>     which tacitly requires either CONFIG_DYNAMIC_DEBUG=y or
>     CONFIG_DYNAMIC_DEBUG_CORE=y
> 
>     ATM this has just basic_tests(), which modify pr_debug() flags in the
>     builtin params module.  This means they're available to manipulate and
>     observe the effects in "cat control".
> 
>     This is backported from another feature branch; the support-fns (thx
>     Lukas) have unused features at the moment, they'll get used shortly.

Please resend this patch - I don't have the patch in my inbox.

thanks,
-- Shuah

