Return-Path: <linux-kernel+bounces-759434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454FAB1DD7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F4A1AA5924
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946922D9F7;
	Thu,  7 Aug 2025 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fYz35ZHx"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24521FF2E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754594658; cv=none; b=YHV1E6b7B4hmE0eB8chcrYekeoaAnVDHMJXwKtK10I97nJatRJEayVnMhqlSs2hy605krwgQh+j8InaVlUterONRfgOJXLHIm5gcD0TgMMUKrHPfAgGCEk074C4uMP3WSVgTqcXMzqOcYdVYFwid7Vemkj3eCgPBymkc91g6WCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754594658; c=relaxed/simple;
	bh=pzHBDInygcdOKBfQvKEjuYzCE+/IqHTxKAUzOeC7wQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Krw6GtUh1ZVvpxycSsKae44AxwgixFHkUqTqMXazuKpSYrFsL+Yz3nvjjrDhQz9LDBzdDVErhlTYeP8EJ3+fc1nYADNL352fUmHrk9Ime0+jloDf6V3xDWZ9jVdfpZkqGxqyDP+iigZ3lnAdYNTCfM6yx9OCY0jqOfqOjLJ/920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fYz35ZHx; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-87653e3adc6so38438539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754594656; x=1755199456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jl5D6R6RZF9DkicOBmstuJsbsDkcHhXJQHJNQd84i6M=;
        b=fYz35ZHxWe8eSABuh/402btKgpL7hUgl4pkPXmtiIHVNu9nbNl6hLwz/cHbZDoT8LV
         k/86Puos4BC/BbfWjRX2n4zV7iHg+Er0+ld6WIN9YP74bD5kJcSCtHvNKSkY/Npg7IgN
         RJHQfn0cdNMkBQSG6UzHEqX/UmJm0GAT7e06A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754594656; x=1755199456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl5D6R6RZF9DkicOBmstuJsbsDkcHhXJQHJNQd84i6M=;
        b=SNNE9wZnbmwjEHdf8cBXU96OCw4WFKuLrHnOlW5RvW3r8KUiZOlZLvfHOYLbQ+os59
         eJ0mDIIDEJ9LUqZmIO0KQ4AkeFSrfiXK/5uBQxG7DW5tfla4i5fAB4UcWlbKytElcGPZ
         RC0hPKIR5pDXfPfV/tGVY8z5KJ47qRP5mHFcwrX4z8WTdIC2gPIWmYk2rJbair0VA0Zq
         ntYR5AyLGlVrBDnp9izrgxoRDDhpjUTBGy9+6gAeUhQzivDI3Hxf5Pt4e2Gt/gr57lin
         C+/f7k3uaz8bil4ioZ0JEmWP2nH6jzoif9WZ8LyfWif+dSlhfu6EOzXXBSiFf+kRTEq7
         A4pA==
X-Forwarded-Encrypted: i=1; AJvYcCX6FcW38hdRj8UZt3WMHNzNfMmVGVSUh5qHmlXgEpscqSl+XesnPq9bBHY6xLRNVq4iRY09MbTHBqkAut4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMANfQmk1zkmSUV6tbZ/dfIuILhY0Zhej2QogWE3ESTDFsa9K
	vzgLP0G7YgUdPbQFa3aoJEAPcTlf+xFGh+2PpJjz8wFGrJf9vOnp5h9auP5CvQIJbrM=
X-Gm-Gg: ASbGnct6Lz+DKXXLg2nfBhXUvXV0LV6DfIn1A1s3XShvN3909S14YZw4gV98+KzZI4d
	BtI0KMu1MLi5KX6sYcudqcFENDj9UMJfyslFrmsxHJUx+3py2sbWBnQ0kQ9bRaqRhP5AdC+++Cg
	qmU3waBVlQNamtjDTwYL2xOGNyrvakDCysvRdqLuMIDuWJn+9chDwptYUE1xJ48KdmVSxuC6Jot
	ZWRIQxyRL6PYFtODLR1qZFWEEAF2i8f/lpekqcFn3leoXoXEoEtyciVz9oYCoCIDn9ScEFNJ4bC
	A38rboYdo/0484a52ak7VsBYqcjIiyH3FgCBir/HLLGija84LLALzH7alv/7GekuVncr9OPSSTz
	aa6whiit6zU1urikxByggVh7wM8c79JhUlQ==
X-Google-Smtp-Source: AGHT+IGAE1UjB51pwYkcQd9y5uvmXhfe3+scq5aPcFnybQ5b4AuyjT/BKg4xuh+4FQvzaegUS9xSmQ==
X-Received: by 2002:a05:6602:6d11:b0:86c:fdb3:2798 with SMTP id ca18e2360f4ac-883f1255c00mr36334439f.11.1754594655628;
        Thu, 07 Aug 2025 12:24:15 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8817a0640d0sm348464439f.27.2025.08.07.12.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 12:24:14 -0700 (PDT)
Message-ID: <38bbacc3-625d-4071-889c-a5b4d59ec456@linuxfoundation.org>
Date: Thu, 7 Aug 2025 13:24:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/filesystems/binderfs: Skip tests if user
 namespaces are unavailable
To: Wake Liu <wakel@google.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250807134510.1818025-1-wakel@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250807134510.1818025-1-wakel@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 07:45, Wake Liu wrote:
> The binderfs selftests, specifically `binderfs_stress` and
> `binderfs_test_unprivileged`, depend on user namespaces to run.
> 
> On kernels built without user namespace support (CONFIG_USER_NS=n),
> these tests will fail.

Why not add CONFIG_USER_NS to config file instead to indicate the
dependency.

tools/testing/selftests/filesystems/binderfs/config which has these
as dependencies at the moment.

CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_IPC=y
> 
> To prevent these failures, add a check for the availability of user
> namespaces by testing for the existence of "/proc/self/ns/user". If
> the check fails, skip the tests and print an informative message.]

Can you try adding the dependency first?

thanks,
-- Shuah

