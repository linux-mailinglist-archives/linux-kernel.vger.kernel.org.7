Return-Path: <linux-kernel+bounces-827957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D813B93863
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D147544111E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BB1E502;
	Mon, 22 Sep 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpcw6JrB"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE12550AD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581857; cv=none; b=lAIkoHHo0phiWSL+bI0UI/mIwt9nTM0UxGgh6en6SQ7XXpEmB02P2LBFVBxk4YNN2gSKgZydSBRdqgLisEnfQW8AqwTHX3qFbod9x+wnrWkdEdlZaytQxYLp9XOB2UP+XfNIWUhGvRKNvMbevt2wkrf5pWGGXzyd3cYiA0qlYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581857; c=relaxed/simple;
	bh=wJcpJFENZM3XJoASue2WgV0KmkWQXXkTgGWB1tLNT3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeX5OC4fgxc3xAtF0i34bmC8cA7Zr5AKORbqKesZBg0/6v76y+w2pBJFb8ojCtaG/3HfT7K7gkqY1GhC4DgUccQdSlVoZKz4o5JSPZeN20ZZelgzq4HWAFFJeK3uHh1WhiPCXymLvtMUWWvvQHIMgPvMJGpClvcAjp3cUq1MZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpcw6JrB; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8e1d6fd99c1so1479616241.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758581855; x=1759186655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PmeTUZt1oKPH7ak6kJVKMIBti4fjRyL0GgGscNM+JY=;
        b=dpcw6JrBZONtlfbZf9OG2m5/KRfsla9uLol1Tw++vgQFsv4TrT1yqfiOFt+Opzb4sx
         UyDRxhFZfPTEhKGXkQphaBcbCYkEduUOw961fGxkhOhyQ0dMDJ3Fa7jwB/HlnuD4WNK9
         eFPod4Nweq0sRavkxwnG5bRwV/89OHwxH36A5qL7rdZuGUoaFk2K4BnwDAEnlqLc4gaA
         vjX3U1sqBImFkDs6t0XHjhhyYiISdWR9Qz4rb5hghmBGbsDxRjfPnq54xihREHycdMtn
         vN5ueZQzw7ZhKX4rE3OBtmKuCjWWU7umQQz1nBQr9Ms9IW4+Lc7SpxDZAcmdMEzf1vUz
         lFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581855; x=1759186655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PmeTUZt1oKPH7ak6kJVKMIBti4fjRyL0GgGscNM+JY=;
        b=n2dk62nOMwlSrbEL16g/TWJCBHh4PLkIalIHwNl0WnIt3fRgfKzDK0TCKFQB28EGji
         tutwfDS1D7E6nIs8J5LRCQtC1xlIpZ8kLQnuEqw9j5Zk3E4QFvwFef4FchGYCPh6WMEy
         YJjGIyKO51R4uuSrj2SBepNVttcuY7P2y5XIS8AIG8ODjb0DM30G23E+YPpk4+C5Rc2+
         E3Uz6ojNk4KBYtjaDrPws/GAzQr0Q9QuDQqswy6Mykb5kqXDl8Ca7wq0TjyO1N4WWAXJ
         cRsHtwTPhr+4/fS5570Pc1nrw7wb3HTQdYfqwav4lbho3S66qzGUXcc26XKz36egxeE0
         y6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu+zA6RxsIHyinNk56yx7bfF3MRBgxZ/TdIjyQQOsldorvHAhxeSemhwNQfVvzzf82PAiFahrx8XMbWc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlqz2L/CaXUFzT3XYSrgkAoFhA2n5BF/HNc63uiAMpwJ/ixllG
	mh0isGoyPNxLay6bghzOQtKAJw1HQHN7stvcNy0Bn5sp1OoZWjmb6Ly3
X-Gm-Gg: ASbGncv5XCV6GWvy0yx0NaK5GyiRvjXhavapQ7QfzCuwXf9TwTDsmZGoRpSuArUhFzN
	auqCW4ZiUCk2ryJofvqsGrNgXFn3IKspgPiABrRBZlhPb6Q1niUfch+4+J7XR+Z84O56RpMgwJt
	WFKOyQBtZcJWDop0kXh872PpebGl9I0XTkk9utTF1Z84YItdxmeZa4oJUb3s5TecHv8FAiZwjnw
	4dNp32zi0ImBdxUcZ+PZWe/Np8dN4DWPZ/kLRSOusfNTJR51RexKEwjXTonOiCxI0cRGXOXePRh
	xuuyAzXMNdmhGJP2GwxMVr8azEpH1EeAJ8MydquI+4rfiKoVNzzLsQSq/OeZ6BRo8kzfSjaKhSG
	mzPU3FlHN6oFvbgzJMDk60YwCE2xYxE7LpGafgvo=
X-Google-Smtp-Source: AGHT+IEvT9aPO8VQeqDviuBf3xOmqzdNdU8B4VMjX/6iETFgk5faqYljbrRsv10VslcAQOzyPiUIlA==
X-Received: by 2002:a05:6122:3187:b0:539:1dbf:3148 with SMTP id 71dfb90a1353d-54bcadf84e4mr233297e0c.2.1758581855238;
        Mon, 22 Sep 2025 15:57:35 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a72974f24sm2963990e0c.19.2025.09.22.15.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:57:34 -0700 (PDT)
Message-ID: <29f30ca3-cf45-44fc-aec7-1db6f9694e5f@gmail.com>
Date: Mon, 22 Sep 2025 18:57:33 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Fix Makefile to run targets even the ones in
 SKIP_TARGETS
To: I Viswanath <viswanathiyyappan@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
References: <20250920041914.7253-1-viswanathiyyappan@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20250920041914.7253-1-viswanathiyyappan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/25 00:19, I Viswanath wrote:

> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
> make --silent summary=1 TARGETS="bpf size" kselftest
> 
> make[3]: Entering directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/bpf'
> 
> Auto-detecting system features:
> ...                                    llvm: [ OFF ]
> 

Hi Viswaneth,

After the "---" usually the change log is placed. The change log
contains the changes from version 1. Also if this is a version 2 patch,
it is best to note it in the subject line. The v2 helps people keep up
with which patch is the most recent.

Thanks,
David Hunter



