Return-Path: <linux-kernel+bounces-732057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11CAB06170
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A1D3AA208
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E812777F1;
	Tue, 15 Jul 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="A6bv+B6/"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654424BC07
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589723; cv=none; b=p+EW7UiDEJC/sw9di93T75cuebMU7qTJTb/nkwm34I6F0yg/4olkt8ZxfFrHzqgbM3vSiBI2tLiGITKoVWjycbxACM9xPf8Jc0ndVewkgyWsnYsNRhFRZzwYUjY40TiXbBfT2qsAblq/U6XDg3Fm8J3+uqn3bEKuIN4oC6p/wWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589723; c=relaxed/simple;
	bh=mgCkG6vkeepL8lSrCofDsp+7Zh0boNkh5n5EZGMkWTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwmJsrzceqg+T5VLAemT2i34KQC98yisgZI3HAz1b3RG2QMfT/WvNOHYKiMKQS6NGgz3ZqYX7EFREIc91MCWvXLZF0hKoJEMEd+WKAg9jlRVaMXF9c68gdOnI8wcdZFY5Mjy4GCd4R1CZwF0NVqslayY2h8UyNpyqxbu0MhhFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=A6bv+B6/; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e058c64a76so33062135ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752589719; x=1753194519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxDCw3B8lz63zePAllCoEi8/Bv/yU3K9Rjnfd8keF3w=;
        b=A6bv+B6/9aOQb1rjOKMIYjqMNF7YubzzRn+m8sOAbLFHHVG9UJnynWmEe/ED6SC8xk
         /RA0cFWy2dERUeU89+E/WbruWZPfNCw9ggkTedTY9tuPeEqAu7bEF+90L3L5/fPUzrc0
         dihZREY6LYddFFVl8oaP7h1uwPYqAhJZp0GzYv8DuB54wupYPhnGJa+zF5ojPvVB0yIu
         LVt95OQl9c9ScrFl90t0kb+T8y4NWEUz2162fUJzhuiDQ8bphxn6X/NEB8JNCg0Zcqh/
         IdKbCCnZCAUyLHN+Zhvm3T+0eSq94ITPRIS75QGKHW8WkzwZ7AujF9Hnddbdg3oPJn0u
         MT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589719; x=1753194519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxDCw3B8lz63zePAllCoEi8/Bv/yU3K9Rjnfd8keF3w=;
        b=sJyav2M6cGUd7WWg6RbI6qrvSuB3nxF5hSfcJVWqwmWqXau6VPBTzNRYO8yGA7nZnE
         CCc0agI1jPvlyhzOAzmj8ZTmlaggtijGUAPcwTMUTXWKKn/qcBwkx05zWpeJZT4ay4zv
         H5szEfOtW2WzGlXqj6dKjr+jgeGE5lWP7DOWrJmzsXJtuKV1zdm3DEbpq3EuPaVIeF44
         LZcJZkdPg0CdimxIdG7LZX3ndy6K2DVYk27c5Zu4GjiIPQuuLSPIgVuS5MnNyRMRRBI3
         H65f6SdwzFufJtlem/+fupetpTrJ/i2WEeBpXz8nHB4iFXd9vzV1zfOh3tGnRWqlx02s
         nG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6Yr2/xKW+Bussv1H2SkjT6fEsotzh1pHgALwYytjRZiwvSmOv5mBsdmvSDcmuxeru6DWQD2yJwb9dyR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzahb8zB8v4neLlFCXCih5pfQSy33sBeWSxlQ08ul0gzedj50OU
	WBS84WUlQ9oWZGu2YrcoP8Q3UNEYgUgcDzlvFaCzNGLl5DU7EfSm7O2ykqKJJn7eG5M=
X-Gm-Gg: ASbGncvYqYGi4u2uzfDA83SJoNg6kIwm/EUDbKBUtVPCzSbLcQpM7IXcPmQrwUx6pqD
	aFdTjW8ykqcME//lQFYC8PJHZf1V1psAKiFXSPKrX/4k/dCIRrQKicN3ItGgp1q458OF046dAcn
	fMGs44OuKBTE8a63YUMYUd5xm7Ex9RhVyhgp2jsnF6hNwGSrK/ippOaz3XINQ8Fd2H3zM0LYP0C
	QyDg30vm4Hd/vPuT+JB70Gse5YxHyDLHnvwDJr9TdZav8LgMa568uM8csayx4rK6poGo6UuQhcG
	AmWC3skL/MXiLmkFq5pMa2LCCVcPOy5ecgOaShC+stmP+0JHP+z3p+tu2iM7p1rOrqtHfuBMdrc
	jvxn+z1sxRPHDK9KfrIA=
X-Google-Smtp-Source: AGHT+IEX6DIBAok3abjxzf+yKdxGJWKxkOF53iju/PmUm/+4tk/eITPCBnbl9TA99RmWF6UUCIqzjw==
X-Received: by 2002:a05:6e02:1c0c:b0:3df:3271:6aba with SMTP id e9e14a558f8ab-3e254327ac0mr149854285ab.15.1752589718545;
        Tue, 15 Jul 2025 07:28:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5055697326asm2598255173.76.2025.07.15.07.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:28:38 -0700 (PDT)
Message-ID: <056e083b-8e41-45a2-9b0f-2ec47d1a9f71@kernel.dk>
Date: Tue, 15 Jul 2025 08:28:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250715031054.14404-1-hanqi@vivo.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250715031054.14404-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 9:10 PM, Qi Han wrote:
> Jens has already completed the development of uncached buffered I/O
> in git [1], and in f2fs, the feature can be enabled simply by setting
> the FOP_DONTCACHE flag in f2fs_file_operations.

You need to ensure that for any DONTCACHE IO that the completion is
routed via non-irq context, if applicable. I didn't verify that this is
the case for f2fs. Generally you can deduce this as well through
testing, I'd say the following cases would be interesting to test:

1) Normal DONTCACHE buffered read
2) Overwrite DONTCACHE buffered write
3) Append DONTCACHE buffered write

Test those with DEBUG_ATOMIC_SLEEP set in your config, and it that
doesn't complain, that's a great start.

For the above test cases as well, verify that page cache doesn't grow as
IO is performed. A bit is fine for things like meta data, but generally
you want to see it remain basically flat in terms of page cache usage.

Maybe this is all fine, like I said I didn't verify. Just mentioning it
for completeness sake.

-- 
Jens Axboe

