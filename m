Return-Path: <linux-kernel+bounces-842560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D0BBD035
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 05:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 336654E03FF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 03:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076211D63EF;
	Mon,  6 Oct 2025 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq1VseOm"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34413B280
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759722937; cv=none; b=FJc55NEsjd96vFrXQ2r3MO8rI8A78WP9utb7qkALM727TR1mbwzIw2i/wFzOA1LbM4+/rcqKdsDkKGgMHPYc/zmgTV81axQW1RF1/+L2eHXOWeW17o9ZSpvKYYQYMeeQEBZ2xkOEmbI76sXWSbvy7v7W+70VXvaMgCZitQhTVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759722937; c=relaxed/simple;
	bh=IVzci8UetoGcUjNzr9XskC+74VZiAYmvJdcqtTP8EHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oslfq/cEi1TtDg4ZYvXK6JMyKm76bMcKXkIwuRlDJgvJLfbRKHISQkzVKDcWTrI7a7yfUEVxAhULsPbh47gTQ+LFs48ufMrgsmlUbKc81uelKx8uxhg3lGKqPM1abDhlUJhzTegiUCEXNf58HOijxjFaMDeOQFagoFyWKA9Ofzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq1VseOm; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5a0d17db499so4309628137.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 20:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759722935; x=1760327735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4nyrG89q4JAPsozaOvAY1jJU52pK5NiRjM5aVZTpKE=;
        b=nq1VseOmDCFOR65PPSRuycvbH/2N+tdXKp34soo9CtpK7L8Qw0W5HIV0A2QRk5B4RJ
         QVDyxB0gX7vfS3FBCiALzzFGLIYZ6rkVVsbOAvfLMvjFXVT2747NWI89uqv/aG37I+wq
         pDDDUtlF+m70K9h+zud6MJHYcC5Ksx4uqEodqq/UkDKggNvMqZ7rbeD1+df2h5FPIylg
         6dP+CiNz6QID5DM0tEdYcPqGyuQUXtNmqvZuZxVsh3s67MbNIp8XwfCOLVU6gWkr2bvN
         QQy28PpVBv46e0e+9/g1ldNLqIMQgEqorreUfedsNp5LUKWcWAyXX+ogzy9IB3JiC8c7
         LcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759722935; x=1760327735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4nyrG89q4JAPsozaOvAY1jJU52pK5NiRjM5aVZTpKE=;
        b=IdN/0HH1xermIIFRpYBxDqzevVTUpky7U/N94s0qQ1/gug/tsm3EP1tveyF8AhxyHs
         y856U4PhO5Eyc5DTQxn/ZH+9iXM46AxQF3MYBXRCdTgnEtONmHcFcoqzqUYS+uSe4Sso
         EBnzmeAHHxcrwc3KEOzbkIZEmEs6CgtFg/pg4WprCTW+WIpQ1ZGkAqDP+Kha2d3Z67oM
         H/g+CTpcQN7niEmofNLDJozmcLxAt8PsT5KIu8Kh0qeITksJ9SArZSYSZsNE1GAj0lnt
         Tuxtzikda1eXCJznSc4PO9P3GVCphC9/BEPV79bOOTJAy5P4E2FWWqQh9arxH9hiQCEu
         yFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUdq6bstDognB991ER/suRlfIbY0EljNxc2OTBcNdYSCbjYH0U0Em9Fm0CFpljfWo/iW3RgqPBm019Nfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcbn9C5A9xFotHzHZtEgaFJUnzSMKbCC/5Ycw0nE/N6BrGPOX
	0VeLkom+DjpMHryMYIUaPqUCEOfCXEoYFscvxeVA7g69w+COEt0OUpg4
X-Gm-Gg: ASbGnctnwpOneRe8Q2HqT9MqYIMauzxZLhFc8EaAhhFUAIt5DhEsKgp16TODWkWTOkK
	vnHi4m5WHf1JYkg+ZVj9piEqqBhwB6Tbo35IUEPCBL737MCJWR1yoRImZnQxQOeofBpdYbMi8+W
	wj2knkGoQqW6NLHweTXv6HnQY2Xf3ErO1E0XqXWtz2D/4J7VLKagLm4iVkudT5yGkq/sBAoIXam
	ZPlA9KpYUAJfBq4wJtNt/V+g0okqaft6mlXLqLtIo373JU5U2d6/jdb/bF3HXEd1nDzV7rDyEji
	+ndTBysPWZlCOHVA/HO2X/yYodT8B284VtiG3dJ2Vtb3QzkQs1bocF3lDbX11HwrkawfPdnfD/g
	lGfU8dsworrKFytANNHNEJl801TK2o1Zh5px4Guc4MEgH7iNzRs+7lCQ5v6i2Li9sN4WOvyUuPQ
	==
X-Google-Smtp-Source: AGHT+IEM8YkzBfOFCcp56tbV9hhF70WPBySWeJNMA9HNLTpJu46u5ZW+1WmuFW5gSBnLYg5FkBvDOg==
X-Received: by 2002:a05:6102:5347:b0:5ba:4f5c:874e with SMTP id ada2fe7eead31-5d41d16e253mr4258765137.31.1759722934712;
        Sun, 05 Oct 2025 20:55:34 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c6c7e73sm3130870137.15.2025.10.05.20.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 20:55:34 -0700 (PDT)
Message-ID: <a6526df2-2861-4142-95e7-1c6a83321ac3@gmail.com>
Date: Sun, 5 Oct 2025 23:55:29 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound/core/seq: Initialize structure pointer to NULL to
 prevent undefined behavior
To: hariconscious@gmail.com, perex@perex.cz, tiwai@suse.com
Cc: khalid@kernel.org, shuah@kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251002174301.15512-1-hariconscious@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251002174301.15512-1-hariconscious@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 13:43, hariconscious@gmail.com wrote:
> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> This change ensures the structure pointer is explicitly initialized to
> NULL,preventing potential access to uninitialized memory. It improves
> code safety and avoids undefined behavior during pointer dereferencing.
> 
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>

Hi Harikrishna,

Thank you for detailing your attempt at testing. Unfortunately, your
patch makes no substantive change. The variable you are setting to NULL
is assigned before use, so there is no risk of undefined behavior.

I know this can seem discouraging to hear, but I do want you to
encourage you to keep looking for ways you can make contributions.

Thanks,
David

