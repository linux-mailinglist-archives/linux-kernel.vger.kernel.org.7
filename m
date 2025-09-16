Return-Path: <linux-kernel+bounces-819590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D87B5A375
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B261BC1B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B103267AF2;
	Tue, 16 Sep 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsH5FtD9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EB31BC89
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055856; cv=none; b=hF96GjmOJETZI1+KOT1iK1EfDUd7a+AH/1LZWwnKuWRgEimZ6lM+3BgpufeFeoUQXk2Bu0YTMGP0vbCM/nv33R9n24ejH2fMGgMsRQ48zXBLMInfcE1TryTGR1K4jzIqFJMWFaqOYomoaSxRqnq5+yBPM3MCrs5+ALmSWv8TDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055856; c=relaxed/simple;
	bh=EmfyXqMbv2IHxRJijkMsPV3FcycOCaNmJxYKB/i4XBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g460DMeUgjhjge8EHXGz8ZD3dV1w259j0ZoIBwOQHsraUDQitkc5WfpYtCJYHpE8R1/7j0Xlucc4G6XQCFt22vkW4RKGm9R2JY1Zisv9WqLdXWWmmImbxRyESBjFTFOdxwmmf79WzZmaF+U+bTXlH7nhfl9lKz2LdlbyoeUhAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsH5FtD9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so70235615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758055853; x=1758660653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvbfcOQ83kSu2crutVh7QYmuTH9yOcGKqLy75e7Rd7s=;
        b=UsH5FtD9DJqnQyjRuQFFTNJU690xzl0QKe59PGc4xyv91g4aMwb2WTVkQfTvqVgK8y
         Wn4chZIc8LGjtWfP+jLth37+BXu3wqtqQLCbEsTD00n3i8r9eypgd/Np+Cas0s64xkhl
         XTvmhbJ9Y0uNy3K3bmZFs2VYKL3yESVWfEr1aa2IuCEScVLPN7VKa7KoPlRA6kpxdXco
         1s4i09VBRzwj8FGxOpPsWWen0FJWquIb95DHHKV1huRtinWczAbainoRyj1dAIwAWtVf
         ZUVLINQCKpwsw2Wb8HBpfAGZCla8f7EYZWoYXV44Xkqg2PuMJeEtmiAIbXvius62LQH3
         0lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758055853; x=1758660653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvbfcOQ83kSu2crutVh7QYmuTH9yOcGKqLy75e7Rd7s=;
        b=ioVzy8fYlrNnu5CtRbgmcyj8m1AXRqG/upI5ZosJCXoZerHIUr4m4mG6ZV9/GaZiBL
         yFRQJ1w00T635RgW7OG88/ZG3orIA5dS2lbX4n65pQ+jrAsGqKjUrb2xbGboRdxBv3rA
         ZYDFICvSIY+owXsCj6o/MeiBHQxN5RQXnOX0Qn02h+9lWoB77up85tSbLST4IQ2ar7Iq
         RQ1LnRC5qgv/AI+LmgnhbtiXFL/jUDREcjEXx1XkUiDExHBgu40QU+SimVgIhTr4HHPj
         kwbrLeSok05b0dDbQ0lVjA045CvUNaC+qLOR4mZX63QBDerv+G8DryOKPQrht+TzdXYP
         XxEA==
X-Forwarded-Encrypted: i=1; AJvYcCX4C/d5vJqPJMet4nRk/U/kgJyD+bMOh0xmMMQ/n6hKUmVBJWftnoU9LVjau2HwFDbPCgOmPVxS9wXs6L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyut7A7sUPZ5DBtDkmrRhG6f+Lmlo26iOilkZxOjRIkedf28b4
	K4J8RqHh2ivptczrE/SIPLnvlJ1cvEQjfmQq8hSAq8mef474taLzQ6Yx
X-Gm-Gg: ASbGnctqfN6iTruIjVM3NopoeRl3h4q5yFloHWx/zkBuhNFT9+3Hsmnhkwd2GpxEdyf
	lUeDrrbM+nF0uxjswuQcXdZpl0fTsDXPhnUUxcvUpIPGgkk/d+fWNMxbW8I6j+IRRPVVKSgrTna
	nnkYPCql4Ra4SHdFXrgI1wL1oKGRDIfesc9sDbDAZjlALN5Sg2ZFU8xqIepPIR3F8JiGJtaSTbL
	hIJNCqKgSVvQQoaJemhdsbC8EOJGmKpA0y+/6onAxEZVXam04cQe0Cj3z5fJkTUOxsxw5IME/g5
	AnYtyIlQ3+whlGVkxpkVCmqzu3k6c+Rul24h+9BFSYbtv9WDJpA5F0Lmsfe+VwGhIZcq7gGuGoF
	sYM4PfjnPy51OKUnoR0bGpu5/CklVdq/nMHUvvGbYOc9Xo78XEMnwjlmwBDALz6SpLk5omObG5u
	Yez/hublypMW9qrjGkhQ==
X-Google-Smtp-Source: AGHT+IHjaMedUvutln+TjYg3sLFd6itsoE7Nvpt3KUzyJzf+b+6hQAzmwMYEn4kLYImnrBTnPQl7sA==
X-Received: by 2002:a05:600c:6c86:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-45f211f6b0amr115679015e9.20.1758055853080;
        Tue, 16 Sep 2025 13:50:53 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613930bdd8sm7809815e9.19.2025.09.16.13.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 13:50:52 -0700 (PDT)
Message-ID: <4c4e97c1-7f93-4c09-a235-ab169a998ef0@gmail.com>
Date: Tue, 16 Sep 2025 21:50:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fixup: alloc_tag: mark inaccurate allocation counters
 in /proc/allocinfo output
Content-Language: en-GB
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
 rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
 shakeel.butt@linux.dev, 00107082@163.com, pyyjason@gmail.com,
 pasha.tatashin@soleen.com, souravpanda@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250916160110.266190-1-surenb@google.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250916160110.266190-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/09/2025 17:01, Suren Baghdasaryan wrote:
> Document new "accurate:no" marker.
> 
> Fixes: 39d117e04d15 ("alloc_tag: mark inaccurate allocation counters in /proc/allocinfo output")
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Based on mm-new
> 
>  Documentation/filesystems/proc.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 1776a06571c2..17668f82ff1c 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1014,6 +1014,14 @@ If file version is 2.0 or higher then each line may contain additional
>  For example if the counters are not accurate, the line will be appended with
>  "accurate:no" pair.
>  
> +Supported markers in v2:
> +accurate:no
> +              Absolute values of the counters in this line are not

s/values/value/ maybe? :)> +              accurate because of the failure to allocate storage required

s/storage required/memory/

> +              to track some of the allocations made at this location.
> +              Deltas in these counters are accurate, therefore counters
> +              can be used to track allocation size and count changes.
> +

>  Example output.
>  
>  ::
> 
> base-commit: 199236646ffd82b5a5bcf2bca1579ea06cb0ae74


