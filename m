Return-Path: <linux-kernel+bounces-736980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B00B0A60C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD33C7B3D79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454232DAFCC;
	Fri, 18 Jul 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxS8s3PM"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7CA2248A5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848395; cv=none; b=qIGnTKVJ1AIq9XePw9/Tcs3kCh4Iak6mU5IO4xkwfsGTS+CtGzdXc+1hCuEAZi3aRFIRx6C4kewMiMw9MtR1f0VvKybdgohr3fqq/M7linWbKdsihsD2bK64HY5T84wWwUEKACiVkjmyBpEOp3IYhjNzYUmcVp1Z3xsFBk8UCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848395; c=relaxed/simple;
	bh=tGZlQO5Bkbr9DjuWPUrAMUHMWBwWhJV9SypyM0Ntvao=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=hqDqn2ZR6a0RmCbDctYvQpHdYRcGMhFg0zNA/BUZKKKKIU4zrNEn3cpfP/iQwu25GAmuU0vwToJt/JURTvF3HLouVe6K+6vKRW8HOjJL3oK7Jz+c8HxcZMmD6ZdXG0OU9A7uBbUBGAby3geVWLUXVmWUowfYAy8VkwR0yT3rat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxS8s3PM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5561d41fc96so2494693e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752848392; x=1753453192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efZykVdwoeRsrQllopBfY5NWAmZmBZTI63YR6JHRVwo=;
        b=MxS8s3PMwxN+79MlD80bfRYe8oQwt+UhRndDWBg4kIhC5jxoyCRQxlhpzWwGJy3M9j
         bDf05lBLpbT0+nH/QNcsWWQJH2LrGkT68bByBPRiI9/MeANZjieNnj0N2aIVCkEEO43P
         728oA2kQwkphYORGm7CD8BmfYDlRq0IdVdjPOlG34ulqw3lakR4PYub+Wt6mrIAa9lxP
         OEAEyEiMExvxyf9Dlc7hwEWnqymbZ7Y1z29xqmC181B9/owXP4vfhGFUIT6+v4oCRV0g
         WiQDYcu+Gjp/8b7gNUHPFIN8sXEXdt4QmHx2GIvbdHEhr8ljaulHBZXuwxs1KnU/JMaD
         uOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848392; x=1753453192;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efZykVdwoeRsrQllopBfY5NWAmZmBZTI63YR6JHRVwo=;
        b=TDZch0DSlcYxbxQAAs6h6TVuK+2YKT4a89FnvONZngr8SEo/gtRci7h2eqUxLv8wS3
         dlYD1LMqkiBD2tiHsIajktw/r4XXkxRPeVnzQ2BvjdIqgy6IZc4NC/7yQfjBqPHLuNSl
         bGzIUIh4mGtgpWb6oJZif6GiRDpfIOLFOpWv1VSHAPEr3Kx5WvN2Ojdwu4bSH61dPTW5
         EGO1GrtFypbjnD9JCay7cCqSkjmjmzZaMd+WCLs+AbDyRkpOYd30JD/VBHahn7s+ik5i
         MczYLBiSlXcFyjaVIRUWRVFckp32RCtfPJ88G+eC/2YPH+t4DTvRj7/CAoQ3Iu1WaFo9
         YYSA==
X-Forwarded-Encrypted: i=1; AJvYcCX77IP2VXfcWnv1LhQoQ76kI5DVHu2qdJZ5pK2q+o2EnDGg3H1bYNVbn7MxQat7Emy/L9Q9gyf+zFkZXTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAl8r82bxem5AhPgFYpWWGgGwZAj4NLhMIOYAoyY420GOGJ2g
	PNbT7xZ/x5c89Hi8s7zUj6q3P+bZBmkaCzBBlip2jrwOeJjabMAcRpYD+mJwDw==
X-Gm-Gg: ASbGncuQYeiBIKFQcHJc0T5Ac4V1nMAzLdfc8bZKTwWwXCufetCIvf3Uj7su7RiHX5u
	F0WwCu437ObON6ZrMd/ilmbExbNTgho4NTC89JGsLDOttbA5mvx8nwhfgY7tbjsE8Pg3tmyXIBg
	Q489uDyQB14ohh2KehgtfxRsV+7BulyObXFsyQ6XvMX1nNOQGqbq/NcJ82OJq7ne65XXiPT2W+B
	klmlSYkXUfWhnBEdbx2oA//USWd6SB/qiqMp9IvmzzbbyB/0tuUc9IOu0Bjt1h9p6HnKVjfU5Zi
	ozKv9RtodHht87mbfPtaLLl7+TDDfVl4iV3OxzYxC3BAM1zV3O4ESzPQ43K1T1Tj3BHteaIYtFI
	CCHQa+5Zfd9755DaCvetGxJosKbrbdxwZCm+56KyaHZ9OV5mIJ9utDgSuig==
X-Google-Smtp-Source: AGHT+IEUTkwyGFJkQHSUs1CGSoB7pOHtGn+K/G2C6ixMLxo12DXdJL6OITRXjEZktNvp5E9KnQ5lqQ==
X-Received: by 2002:a05:6512:1301:b0:558:f76d:5a30 with SMTP id 2adb3069b0e04-55a23f97b2amr3456644e87.42.1752848391616;
        Fri, 18 Jul 2025 07:19:51 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-54-30.bbcust.telenor.se. [85.228.54.30])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9cb18sm271366e87.20.2025.07.18.07.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 07:19:51 -0700 (PDT)
Message-ID: <8d3513e3-6294-b6df-189a-cc3bee76f0a3@outbound.gmail.com>
Date: Fri, 18 Jul 2025 16:19:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH v3] char: xillybus: Replace deprecated MSI API
To: Salah Triki <salah.triki@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <aHmbnFJXWMWgS5Lk@pc>
Content-Language: en-US
In-Reply-To: <aHmbnFJXWMWgS5Lk@pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 18/07/2025 2:55, Salah Triki wrote:

> +static void xilly_pci_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +

I'm sorry, but I have mislead you: The call to pci_free_irq_vectors() is 
done automatically by the kernel's own pcim_msi_release() function if 
the device is managed, which it is. So the driver is functionally 
correct in this matter as is. The only remaining issue is the deprecated 
API.

I discovered this using ftrace on the relevant functions in the kernel, 
as I was preparing for testing your patch against hardware.

Regards,
   Eli

