Return-Path: <linux-kernel+bounces-886553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C67C35ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A75C4F953E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75751321F5E;
	Wed,  5 Nov 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLWrh/gD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81594314A93
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350577; cv=none; b=aluGQ4Fi4gJuFzKEJcsPi/uoTZ8bXf3s+YKtEBoWUEkjlonKnUkrYn9xR7wG88T2iO6N8t96flt29Ri/ymzRNWq2TvgVdONUlhWtpgNEeQ6hOsJFiDkBRHZ68Bz6+TL3nSTmf9ApEKCfF5f76bEx47h+sP4bRgsQ7/CuojprBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350577; c=relaxed/simple;
	bh=YQIUAYYpT6AOrVjMBIacID0TnDXNaL+LHaWc7O4/Umk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TILpG56CT6fnI4ba9TT+DKVZGYPeU6niXnz8/B1hYbhDJbnt7v5sNvoEWtSaUZJl8BRizvkH9J2/QBARj8He1+5NNh3Sc+SJQKdKFRSkR66ws6TFg60KxgJJ4IzPlAemZ080RfDrfIdxPOn0TP8Z4hoh2ht4HxFHeKU2yaIOPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLWrh/gD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4710022571cso62360905e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762350573; x=1762955373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHphQm5cf5XJfoT0QoEw71orWJjFg1RJOwRJmwvYzAc=;
        b=aLWrh/gDuIufcOyoknLkANELF4QRubZ2+94xoO7qnMzBjdcb2qupSnnATK8Qv/Ix7t
         sOdXyw5dcAwGUrdY4FjYdy1sMS66+AXfGlU4SnaFiwRFuQAi1kBK6We7fkOnw8QbXRfk
         w08elLzJry7HPg6AlHlJ36wHSGHYvIkR6s5yXQ2YA6qy7Y2LUtbRO8nsEQYof8KN4tbh
         KN62p6XgOhsR2oDMJBU3HVKY7jiB5MuDI031Ni+YQAoER5bQBjjj+NlelXrCg4tinIqy
         kLsstuBMpJZgFhMtbEQ7+lVheU5Jai/mzNnxvS75uvi19vgnOvPPHUQGiEjpNoR5T0Ei
         IbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350573; x=1762955373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHphQm5cf5XJfoT0QoEw71orWJjFg1RJOwRJmwvYzAc=;
        b=oyTo4rJX5szVr8o2YFNe8/QtXLQKk7X2Uw3ey76lJdxqNNKresu/FQGcWw6XMFG3a+
         OVzl7ErMIGzMF9RGr8WVeAXckEDd6zMpb9dkzWoHg5XfPHQbIw55sqOLG0jynBfZWiCH
         Kd8qdiDaNMD6BdbYU2Zz8M0a+1RzSMoatYYFmmi5/f5MHqxdBQabuQAx14QI16WgrT9V
         f+JvRg9qYRuMsyMj6etrJ1VVn9RoOWTQoXIOfacoUGJ9s/Ew2w1+Bo9lCbsyL6POZcMY
         f+UiwfqE1fV6z8EUNMeSMxR7pnUQHVcySS2PtpSRyA9UwlNk1seMvo/in+EYH++r1y2a
         HsQw==
X-Forwarded-Encrypted: i=1; AJvYcCWH7v4m2IHFhiL6noCiZlqwR1ClIK0NeRne2KiyDMUQqvnjmRKT8YyW/pkyZ02wQxvIo+eNCO8/XcXYbHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIq6SsUHoj03FIKIrsslyVaBs4/sDQe7kvFFGbuYsveX4Nc8wQ
	dtDx1rhIG6FGH9NiqiUpB6a5TNCcAJMprZjKXR3S3mZ4Q48gtZ46YYX2
X-Gm-Gg: ASbGncsL5MlEk6pHlc7zMgamgV/+JtTRLArgr2AYS7wvRKqfMg6UdDKerMj2uuxZBmw
	BmavtudxAxErs7d976wyrDrYy81+fvEYizAYijRv2RsaNXxwPAUSF0DsvXxxx54vw0vsSSXqvqb
	ucxR5ELChrMs97y4WicXIqUmsGyTAJNWmQjuTc0H+PbrVjIycJjA5fClNHsAuT5C8LF0sfxx6qc
	iGewTB8bv3J41m+Kdf9o/tT5RSCNlVzUsaQMxSL7jnWv1qAUXzh0eua5YRZCUnDpjJnv3EojtTF
	/L6u8//yWOBHpI7+fx9dxh0hfr8hiGR6h6a5rJI8DRFRDts6Zyy9VHSP2F2dKpBnYRjiuVzSW0n
	32Y1k47MAujkr0rzRui+faX+tFXVWHwA+ef4HuSr824G0arIr5nME/zgLGrc0kjI8Bd7bggmoux
	FSxdhGPVi0ULhs5LywxD1kMi8LEc/6J2kFO7zjB80lzzbECRzm5yJiPVpKgZVMZXQcoyZ4
X-Google-Smtp-Source: AGHT+IFI/Hv7z6gEwSQuhSHY5C0CGLurNtOoGmCceph9sOrcveSWFEXsnVhv7mAq2BlAIKhbC0jfKw==
X-Received: by 2002:a05:600c:6299:b0:477:559a:1ca7 with SMTP id 5b1f17b1804b1-4775ce8e088mr25101595e9.39.1762350573031;
        Wed, 05 Nov 2025 05:49:33 -0800 (PST)
Received: from ?IPV6:2001:16a2:de8d:400:58:dbf8:dff9:4863? ([2001:16a2:de8d:400:58:dbf8:dff9:4863])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558e695esm44266295e9.2.2025.11.05.05.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 05:49:32 -0800 (PST)
Message-ID: <017b23d3-28e1-4785-8334-b3b3f9800e2a@gmail.com>
Date: Wed, 5 Nov 2025 16:49:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PR_*ET_THP_DISABLE.2const: document addition of
 PR_THP_DISABLE_EXCEPT_ADVISED
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
 ziy@nvidia.com, laoar.shao@gmail.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20251105134811.3170745-1-usamaarif642@gmail.com>
Content-Language: en-GB
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20251105134811.3170745-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/11/2025 16:48, Usama Arif wrote:
> PR_THP_DISABLE_EXCEPT_ADVISED extended PR_SET_THP_DISABLE to only provide
> THPs when advised. IOW, it allows individual processes to opt-out of THP =
> "always" into THP = "madvise", without affecting other workloads on the
> system. The series has been merged in [1]. Before [1], the following 2
> calls were allowed with PR_SET_THP_DISABLE:
> 
> prctl(PR_SET_THP_DISABLE, 0, 0, 0, 0); // to reset THP setting.
> prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0); // to disable THPs completely.
> 
> Now in addition to the 2 calls above, you can do:
> 
> prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, 0, 0); // to
> disable THPs except madvise.
> 
> This patch documents the changes introduced due to the addition of
> PR_THP_DISABLE_EXCEPT_ADVISED flag:
> - PR_GET_THP_DISABLE returns a value whose bits indicate how THP-disable
>   is configured for the calling thread (with or without
>   PR_THP_DISABLE_EXCEPT_ADVISED).
> - PR_SET_THP_DISABLE now uses arg3 to specify whether to disable THP
>   completely for the process, or disable except madvise
>   (PR_THP_DISABLE_EXCEPT_ADVISED).
> 
> [1] https://github.com/torvalds/linux/commit/9dc21bbd62edeae6f63e6f25e1edb7167452457b
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
> v1 -> v2 (Alejandro Colomar):
> - Fixed double negation on when MADV_HUGEPAGE will succeed
> - Turn return values of PR_GET_THP_DISABLE into a table
> - Turn madvise calls into full italics
> - Use semantic newlines
> ---
>  man/man2/madvise.2                      |  6 ++-
>  man/man2const/PR_GET_THP_DISABLE.2const | 20 +++++++---
>  man/man2const/PR_SET_THP_DISABLE.2const | 52 +++++++++++++++++++++----
>  3 files changed, 64 insertions(+), 14 deletions(-)
> 

Resending this for review as the patch to implement this is in merged [1]

[1] https://github.com/torvalds/linux/commit/9dc21bbd62edeae6f63e6f25e1edb7167452457b



