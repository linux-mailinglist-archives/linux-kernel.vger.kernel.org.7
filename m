Return-Path: <linux-kernel+bounces-855025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CABDFF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087B919A79C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95D3009F4;
	Wed, 15 Oct 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqxZxIm3"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751042FE06D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551408; cv=none; b=L3PwRsgH5e/1lfsslSCl/yrJHFdC3iIngdlezEp8fIYqEFJTK+PtxwkaBIHzjf3FSflRYxe0tFKeYgtVtyUAgdinY/VSaTBCkP9NZFdKABDEPObw82XbuZ33rxShKW5ZHpL/aS92udu5UQIsEE8BEzy7wGpICChufjtkjPWq7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551408; c=relaxed/simple;
	bh=L+G9B7tN81rwSQPufODyTPs4I+s5vnl3h50pjA/8S+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHcKRATyQq9u5BjI5DXXteYJXxIl6v6ThbClxK2T+RgiTQVgHjU+TcOLvMLyxjQ6qKq5xCCscpbnXaneA/X6KQGuuIHVhrQuDqfVBF4UcZDXpurIwYNCVx60s0CbKBFN6t8JyoT7xHMOMGM1EC0w3dWqsXTCjTEjMXl1G+GIEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqxZxIm3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33ba37b3ff7so123984a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760551407; x=1761156207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sFRY52fCLsJM3iJuutzJe2Pl8OKrpW4KX5rl2KlcBGA=;
        b=HqxZxIm3UXgq2FInNToudIHNORqB+FDsGvckwsCopIfzC8b4hD0rP3eMUfExAcXlj4
         3v+CqR8sm1RqKOV535SBcFof9njUQdVWRwpk5Wpzct3aoBwiIrMqihFU0Oda6x/O2RWm
         nQScsqr+fMRjVKR214i/s5yN2Pyfl4zhQpRbi09e0meZptiNAzHzFXDqr6u/cjUobkIT
         1S7W2qQ1wLCevCPsV5QCZiCjh8hIuJtOJT7DHKozqwVKroyEet4VtloF9Ah778ndhkI9
         LJW7ocbT0S9dQvZ4S6XhuRT+SBmeUl+/exLja4IX9VKZpl1DApj8zDjtGDOz6ZTWeLJC
         4I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760551407; x=1761156207;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFRY52fCLsJM3iJuutzJe2Pl8OKrpW4KX5rl2KlcBGA=;
        b=BWmJpMF7SOlRjf1iYGLGSb2qieQmvClczDM/aqmjHB7S3AyzAeGE+SFmSGgsvnJdUX
         LT+iPk4TotMGkj+mKiRCuE0HG515pSDUqROAo9ZeL61eLa2pdzkVwgMSBFEqP+BnUslM
         zmNDNLfS8ZPzi8PHkQhG/RGXhQoy3RxnBTH+/7Hxnp50v108iZ97wOTnxLimdLSQFq0o
         cP3JzxJ3N4ydh6GjSQmq6r7BvNtr+SViItEtXpG20ap68GRsPyXQXo2eUlfIGrr53xoi
         t7lF8uOdjo86h3pHP7/y4fBsZil9pvAgZ4GMzc8EVAnrrgPRPlA3uEVJk0krPQm5Bh27
         GHoA==
X-Forwarded-Encrypted: i=1; AJvYcCXfi6ZmihoQAsEQ5Z65tw9+LNWD1XMXTlgFrzVJtC+jpp+ArSUGCm+GY+btu4mvZYJFxfuNrC9onZZyJfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynqgDmxG2R1rQMuKpcdsmF7lC6jBp4ycOnceMQMRkXF2MnQsdL
	A1eHxEW+utdIsTSJtfxWDJ3pJEst/XlVZf8mmln5v2Eyskp4IhVmGnr3
X-Gm-Gg: ASbGncvwJn7YnEb5pZaLIpz8oyCLnNW4P8NvCe5+DFytN2bTglDgf/3wUpK+AfWkYKm
	p8rDH9d80KLTR+ZLDRVpfXI+e9wC8Codwxc6Vlabb3qcWEcOtxss5H3yD+JPjTgCtKfp7E+Ijy/
	QrUWDXvViieC7nTqBUB7RJVcYyoL3ZkVX3WwUOvElxUw3M6JQAT/o7rEB7TORYoDBb0zYg7i/F7
	MS+EBgk0HMqdPLJ7rsD+IKi/YKEo7LUakVbbgd7htONb+bgm5kEee4WuYyoORLtWX1Rf2p1Y7bG
	4PaCBiIYNnQx/7fL7FbygHTIE1Y4Xdva4z+8WpnJCb3Ui1hxZ2CzSdEAjG8WA8wPhxkzjpwG5CV
	zEKcB97M4QTGufiYqObExVARnnj406OHYakBgz6+GopQS3NdVPFajG4+r5xl6+tY7InzfzjOnYI
	N8STTRZTASzCxLgE8Eq1hW6rpR
X-Google-Smtp-Source: AGHT+IEVI/bi3ghuzYB7QIJivMbOlY1dqDJiRRUjOSgwmyn0D843vh8YAHf44Mc57hlS0g6eBIrLjA==
X-Received: by 2002:a17:90b:4f4c:b0:32e:11cc:d17a with SMTP id 98e67ed59e1d1-33b9e08ff85mr1184192a91.4.1760551406514;
        Wed, 15 Oct 2025 11:03:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3ffsm20285156a91.1.2025.10.15.11.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 11:03:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a8f01470-0eef-4a69-b3de-2e7fd4191ec4@roeck-us.net>
Date: Wed, 15 Oct 2025 11:03:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] htmldocs: Documentation/hwmon/max17616.rst:4: WARNING:
 Title underline too short.
To: Kriish Sharma <kriish.sharma2006@gmail.com>, kimseer.paller@analog.com,
 corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251015153527.1646111-1-kriish.sharma2006@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251015153527.1646111-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 08:35, Kriish Sharma wrote:
> Fix the following warning encountered when running `make htmldocs`:
> 
>    Documentation/hwmon/max17616.rst:4: WARNING: Title underline too short.
> 
> The underline below "Kernel driver max17616" was shorter than the title
> text, violating reStructuredText formatting rules. Extended the underline
> to match the title length.
> 
> Fixes: 1fdbb3ff1233 ("Add linux-next specific files for 20251015")

That is a bit wrong.

> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Thanks for the report. Folded into the original patch.

Guenter


