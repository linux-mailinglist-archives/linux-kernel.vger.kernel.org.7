Return-Path: <linux-kernel+bounces-802024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E9B44CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AED5873E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7AD266591;
	Fri,  5 Sep 2025 04:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l13Q8uzf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393425A2BB;
	Fri,  5 Sep 2025 04:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047405; cv=none; b=UI4WDUc8ANXcsTgACFISfi1oguY39TIhZYCiii0Uv2Hyb6yKb77Gsjcp1ikoFdfHGZVvzxiiXHJtUgrD0tPjY/U26l7CgGx+OOS6iC7BZcqzwUj+1wV6uHIExiDdis16DB3rmlxnTGV9uRQlou6xcfDonHMhqDw983ew9O0c5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047405; c=relaxed/simple;
	bh=7Wo9pOKUYI5Xd3UJNYhWvwpaZil6lLw6qrUzVyrpe2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1QV9jDKLOhsI/Z6JLmFWpy1Oy7EQHCWcaKklAgdPxD9Nke4kTDs264FqNFyLCfe8fLrGolwqZFE7N4+sbcCHS0FBjkdUEACOOT892jhF5mHjt/3GT0tSgvi+LobgbJVrWy4ecBrviuobZJ6VuMDbNLoDx5PMRTe3WZ4/p9dybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l13Q8uzf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445805aa2eso17359405ad.1;
        Thu, 04 Sep 2025 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047403; x=1757652203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zdeOFZQ//FAV0qJKK0kbkrGUUYVbli4JDrPUYPF8pGo=;
        b=l13Q8uzfSFsnaEQw266hK1CPbd835v1AMwGEabfwCdzg2czDKH4mubzgHuDRPpQEaL
         9estZPaTjEKShPfdd1T+EsCsq6N/Mdp++JHl9EMz7WpPHznciN/xgVGEsLx5wvPlB1P2
         IYjsf/WtivkqoUgehmy+MGxBs4EzyWQ1HoLQUQu/su1e4FD8MzSKRcPqyGLmDUjSj/nb
         1vX8HB+AqhRiXmYWwRKJitrURkZvON8uxmrNbRe3M6XlDK6gVTyu+cQ3sEcIBd5hfiuf
         XfEnCe5ObWRATYWKCIo04LkJQI/0y2IuUOcNESsGS7Q1astbyHOAsMRcMpnbsw0Ftmjp
         MwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047403; x=1757652203;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdeOFZQ//FAV0qJKK0kbkrGUUYVbli4JDrPUYPF8pGo=;
        b=uPQqQ8Xz07qQWwMEZfMGXS5ps1P30q5oJaBRQyjLY5ygnSTglygVnLUXjLDb1oUE7s
         PuvS0xgDWC1PFg+2DJr69Yu142i0xURKCs36h4ihZIRmi/cBQUwKtuzu0UfT3M+Kf5ew
         +wR9zq2kQXUL3anybKIWtSDHsK11keb3IyMTpi36L9000NhWGy0L6HjGnEHgCcVPF07T
         cb1LLWdDf0xCYlaEtos8EPRZsrLtGm9PwT8Hf9zMttPxdr8te0kpUpnSN02noWazXGa0
         g+GAheqoOu9qMX4VUsBH/zqUTpRxP/0a92CYz58DdwbVXzcQU/WGMb/ss6TSen6iCNpK
         0mvw==
X-Forwarded-Encrypted: i=1; AJvYcCV7PROm3b8nhXKlB/iHqLmM1ofievpFUfwOC+/xNQLSfzBSMfz9hmOGlDx69ZxvLJcu/XjrOY69GpaSFw==@vger.kernel.org, AJvYcCWHKdCNay+6O7uV58VGfY4iZXDUL1NLFe7/kSZTGhfwR+bYcs5+JU7UhssBwqREkAF6ToRia69hoqjSxsRx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7MBleeeSUcz3YfjEraOU0Mc0o9iz0yoYa/fLyrtftgZ9lWBQb
	hyIMaGEMGT5RN8wxw1Mq+770KeycPfUr8lrCIZaQSuD1gb/qtqKQsZNa
X-Gm-Gg: ASbGncsFTUCzhodg+LseupvlYjkz2QgWg7fRtz3QK9LK99bE/hXd7ITv4fIObJYkmRm
	phmDC97pueWXjpDT5s6B196jtd5WUOlCtXievc8XLQsGKkfVK/PCI0gZWuCb0wOVz883qo0sDaQ
	QyMElGJGmY3mavNI5yqeNnm3F9+GwIWD88bbBkIS2pnURRkj8x3pJTUzJBwKVrlYzgrkA5HGbEl
	ngtMRmBkMBHuhCaLDPSigPRuuiKd/z1tlX/86OEaW9vd/nyJVaU9twdwjeWLa7u49ryJdKVquDo
	oh5/39dgcbcFKThrcXHE7JADtQf1T0eJ/q84xhALJzD4ZY27JQRWb9u/T2JCxha65dzmJuoU/0g
	L2esCPfWVKWrgXHoyJ2v8YYiZOLgvEdtpSa1zlTDrJ1Lcy8jy2mblkOHFAWouEC9Ii+1CNqwYbg
	lwCV1aMQ==
X-Google-Smtp-Source: AGHT+IFA8qcO6cOpX0sja+WKOmAUJCTEVHs/lv/F5YofkBZvoKczQp2A5e0LxRO5PXeg2iTgmK9uGA==
X-Received: by 2002:a17:902:ec8a:b0:24c:cb6b:105c with SMTP id d9443c01a7336-24ccb6b1339mr77885645ad.54.1757047402930;
        Thu, 04 Sep 2025 21:43:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a3948sm10696370a12.27.2025.09.04.21.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 21:43:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <07ff2b26-5518-4ccd-8509-75aab8989d24@roeck-us.net>
Date: Thu, 4 Sep 2025 21:43:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] platform/x86: portwell-ec: Add hwmon support for
 voltage and temperature
To: Yen-Chi Huang <jesse.huang@portwell.com.tw>, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, jay.chen@canonical.com
References: <a5edf505-9b77-461e-ae8d-510e6ed3f950@portwell.com.tw>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <a5edf505-9b77-461e-ae8d-510e6ed3f950@portwell.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 02:29, Yen-Chi Huang wrote:
> Integrates voltage and temperature monitoring into the driver via the hwmon
> subsystem, enabling standardized reporting via tools like lm-sensors.
> 
> Signed-off-by: Yen-Chi Huang <jesse.huang@portwell.com.tw>
> ---
> 
...

> +
> +static const struct hwmon_ops pwec_hwmon_ops = {
> +	.read = pwec_hwmon_read,
> +};

And this works ? That would be quite surprising.

Guenter


