Return-Path: <linux-kernel+bounces-823690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F1B87355
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E632A7893
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B372FDC5B;
	Thu, 18 Sep 2025 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUXpodGr"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B82C0280
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758233571; cv=none; b=sBxF+1WpVApCeTrVLDdw7PpEbRNXLMwOtVI7ZAdKwtvVocvH0v+JCZopaAMyr24sKUG1h/6oHMO6JqkyibqPhfnzn5O4U9QyVxyXPqQUuHL6u0nfNm8aISqGzii2IqWmk8QJhmlnF0rz44JZ9O+lZivFVZyHFxU0b7w7Umrryjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758233571; c=relaxed/simple;
	bh=ajjHKpFPzRYGlqwcSKc2w224hArGFHptRLI5Lz1bLnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsLk/Xf6AFJBEWVE79bRt7Gp8tmXNK1bogIxxAdyliX0R9jRB7ywgWunCRLVV6GcBo8sdjlldOtQSURkbNlqoXKKlbllJ5KTdz3LM+y7fAvoJBUjUZR+aIve3UerhccjCbdC1NG4pI8Gk4Mp4pOYnywNh9O8sI0FkSMuyzxKvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUXpodGr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54f57eb7c9so847024a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758233569; x=1758838369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhJCUp3cTgiTgnYs+CkP/JmQFK0RqK1Act/0NFVgCHw=;
        b=GUXpodGrXj/yoHZYVeN6d0e9MOKEV8ab1v8+cVhZ/ISGrCRo07gFsv8lUsec33yzVV
         Z3HOqZFGJY9geSvqi6v2kHV0rA62may3yDbi7qjrmz9FVCS25mTJnHCKxiV8lSlPvr9o
         +C4AvlD53GeBvdW2JNTucBroYimBrbGZxhmlED8/n7dd68SE3GXh1VOAN1XxZEAJ5nGW
         fZfgdI2bXeF7rpRBH2sNEwk9BNdc8KwE++kiArF+L4y5x0AlQMxUimerjPauzOTH1uVy
         CkLWaU0EAyIzPHl72vnpwF1l+G9ccAxma2qPD5w2e/f1F5rPUZ3YD/0//WJYPAWFUIHu
         MOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758233569; x=1758838369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhJCUp3cTgiTgnYs+CkP/JmQFK0RqK1Act/0NFVgCHw=;
        b=LadD1u7i7ZI10eIDtjqJDPj3H0I4gQkTAKwNvGm5guaQdCkVcJulE3eKDq3sW4ZWTJ
         +keJmWutC5FSejjnoDV6QvuUUZWoKZ8QQvbuNAQOabtftCHU5pJ0pIKR/T+wXlUudZIm
         cPDzcLb4ZdX8aHAv4IjM2PbV9VIPkPzBIit7rfqCNh3JvgYpfYEwg7rX8sDqc2p1TIBA
         m20DirnFgOxef3RmCiDLYVfnoOq3gbhlogy0mJFowd09oVdg0hZ2Gqs8fD/rPEW6lymD
         UxjRMj7JaCEFqGwYgphgfyMzAa52awMKpYLckV8qCNGfN4NWeBq1Beootnd7GDi7Vlgc
         +tfw==
X-Gm-Message-State: AOJu0YxVQ4NRMIKoKg3YsrLwiasAJhoQg4pKlRipfnqW6DwQMNhbl1b7
	r8bu0BK4NgC5+OQqxWoRHuXiwP2WBciiRaH7FgXGVqzQMX0gMgenJL0R
X-Gm-Gg: ASbGnctf8KZKrDjYn4LW2j/Wns8OBiCqeB067zazFnRMr7w7ph2d7JJBhCZlHrRF9mQ
	4csFv/wT7K0VIUon4mXldXnh+mKPDOWEnjr0DgRC8w496Ro46PmHEKiRZb0o8Sm2oqT7LUWjVze
	3JQYZPGwdhDQIrHOXSfV1K9wUUbiY7N/zOK5G6yQO3031Q1wcQ0YiZh22wqtlSjlZC+Ouo8ILB0
	XU7KvRTqSqVVJBGn0Way2OVjcnLxeueJ75UlYT8IocrWGVST9iG1sKin7bs2aVGZ9242Q/BCmYX
	J8LnMyVHozMPPwmxmCYA+ZtJ4A2zO7uu87SH35yo6fgrb1/6MxPJWba81y305wYQT1AxAKBMi0O
	NnWs/1KPGgFXb2VGq6RhvcfhupA6G7Xt5h0eKe76eMzQkkY/b
X-Google-Smtp-Source: AGHT+IFAYTSeA07tapHjMoV5p7/O1tEqBeuIBo7k77XWeUxcpjF9dw26+h1YMYgD7yaS4zrWXIacDA==
X-Received: by 2002:a17:90b:2d0b:b0:32c:c40e:db12 with SMTP id 98e67ed59e1d1-3309834e3c8mr1480022a91.17.1758233569385;
        Thu, 18 Sep 2025 15:12:49 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc248fa0sm3344899b3a.30.2025.09.18.15.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 15:12:48 -0700 (PDT)
Message-ID: <034e7936-0fb8-4ae0-bd84-f1bdc3adfb3c@gmail.com>
Date: Fri, 19 Sep 2025 05:12:44 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux cgroups <cgroups@vger.kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>
References: <20250918074048.18563-2-bagasdotme@gmail.com>
 <aMwo-IW35bsdc1BM@slm.duckdns.org>
 <ul3hrtvui3wuvchludb67wy7kahsroclvppssmeuqrfwieyfv4@vd3gbuuda2xq>
 <aMwsZism0R-ZHLkq@slm.duckdns.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <aMwsZism0R-ZHLkq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/25 22:59, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 18, 2025 at 05:55:07PM +0200, Michal Koutný wrote:
>> On Thu, Sep 18, 2025 at 05:44:56AM -1000, Tejun Heo <tj@kernel.org> wrote:
>>> I don't think I'm going to apply this. Sure, it can get out of sync but I'd
>>> rather have TOC which sometimes is a bit out of sync than none at all.
>>
>> The TOC is in the generated output :-p
> 
> I know it's tongue-in-cheek but one big benefit of the doc format we use is
> that these are still very readable as a plain text document. In general, I
> don't want to make changes that worsens plain text accessibility.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

