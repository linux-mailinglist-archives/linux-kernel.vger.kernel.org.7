Return-Path: <linux-kernel+bounces-803640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 463EAB46349
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6571D220E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A0522F77E;
	Fri,  5 Sep 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F8t1sIzy"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24232169AE6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099573; cv=none; b=VJA3RMin4qjTYlKfupnO203/JRic8Vxz7llAueoOEnP+rMy8W9jLPaPmMaaxIskM+Jz/6I7K8SCQW++ZHSNEMhPXpvtxR84dLA57M+HzJoJ471Z2XK2JpZLhDFg1I2oIcgtOxR56JgSNyXSlNDOTFlLDC5jzMQCh/w3/RtwQsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099573; c=relaxed/simple;
	bh=mLdEKkleOIiWpxV1JKcisV8rvb3de4+UP/9768V4zQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAB3ToeW3tycrHwGl4sEwEnAAYECLukCwtMBinADlSQiX59klKbkAxhdbp9+GC/uk9i7qn6kA0fVJUhOqq+RoHP7atygvKofbZre37ylfBO2Awxhur9eHwoI28RKaDDFu2MvEbc1qDkphZEJ1syEiOhLUqe6edLPaQ1fFtU1XJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F8t1sIzy; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74526ca7a46so998469a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757099570; x=1757704370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TioyJhhVEzIAe8f58I+kJz85e9oFUFmvW267v04uLm8=;
        b=F8t1sIzyzdw0bdUoRkazxp0+MxdZQ+Gl8lxBsWI3Y0CwmFInig9OaTxnAdJoXal2h8
         3yJ/W4HUHaIU+7dtuKQ9KDnsnFgxJDGvhNtc3Qfnhx7iVBrOjDQFlqb7nrxIaXvhjPQb
         RE/kd2MNgcKMc2wt+TqDixbCkM04JE1FyN3bTyy3G0PKj9mDayxNdlXS3ukHalvD2dCI
         1/63o6OphIk5jnasK0t2ANo2L910XMlajjYtC6pMhvzynPJo+V967VJiD2175/XfsHGo
         h83FveTUWzUfthCeLZ0n58DUoNonFz79zE966ut99ovoUi9RD8A9xgq81EAc7hOf1emy
         /N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099570; x=1757704370;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TioyJhhVEzIAe8f58I+kJz85e9oFUFmvW267v04uLm8=;
        b=ZRIMsnycZMSiOI6dnZslyF/yiTz4iLgJx8Z9UtmwrQcPfUudHS7xxF9zafPdcN4jKW
         SALNzv+Tw/X8PhnJyBI0IECE1X+WuNzbc11YBOkvjNnZGeF0udgO61/wFdLo+5dwGPQI
         F/xElxgcbCrWnHbwuJ+d4dg0NB+5u7zLymlMKLsETEI5dZogrValm16RyGISrephI8Za
         b3XFlBXDlxxbP47TtK6mOPyCvgnK+B3upqEqcVyaG7rSkRZHtTZIob2xGDQAeo9yQ94f
         /eeVsfxpIh2GbaZNbz5+msHk0AarzlCF8J1g483XcNxiOjLS2m/vlrHyP2oLPE92LVRh
         QiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3CH3nU8x9AD3j8EQKz+Gj3fZs3k/ECCZ9HHhcq59KmUfYc9cDXmddKg5JMB1MfrcjwvkVkasv1fLIWsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylheB6FI6uWK3YNS1uc2OAIghUcaT7miXwC1Xoydk8QS6RzKc2
	7Cw//mQN2yuf+PUEfjDiJAGjnySvd7RS6CIXdhGrv78By05lb6DcIWdrOBnvy+LbGbI=
X-Gm-Gg: ASbGncutYwPdMOH0GP966GFdFfGUPRjOlpEteEMusWttmRrixWqgqy+X1yRBmFbGDYM
	0lbtQQo3e3XsVSAIIHsdpKiJQ9Xrpw45W7ZCWPQQha3Dj/iwHRDkLFGwLTz1F+xZ/7ydxZV8fqY
	DBlrMljDKpvxDs00geZ7HS0zU2FBx8gsRXk0L0eV3ZK0aAxG1kJN6ZranT8asHozp8b/V/XMu6B
	9lfMncex/W2ZoTyAHmEzgQaSkVowgqpK+zwRdYudnbrpRmHU/rfZUQb3UTEd+z+3tJaLB/0cznp
	jMOZydQpLtNBKACSJhXG1V9z0lhj4bGtLvvhVdGsvOdUH4e2PZJQrJJBuEnu1p1BZRmo/V+/Fjs
	bMXyl/meoGE680vRdG2nOywayLH0PtnwwjU4jfM9J9Pnd7SFtz9abLOPYXnq1IGUDWGbUIFWvG4
	OHZR14Nfw=
X-Google-Smtp-Source: AGHT+IFvxLELwgBBkDmfox3AKDtSmZMgKfjNu8Lp70mEFRXLWgPGpfup1VXussEnIBocdizemSXW5Q==
X-Received: by 2002:a05:6830:6a91:b0:746:d9af:6664 with SMTP id 46e09a7af769-746d9af6c45mr2275715a34.20.1757099570050;
        Fri, 05 Sep 2025 12:12:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74596b1afd4sm2897852a34.20.2025.09.05.12.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:12:49 -0700 (PDT)
Message-ID: <fb550af2-37e0-40f2-a44b-52962337cea5@baylibre.com>
Date: Fri, 5 Sep 2025 14:12:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: mb1232: use stack allocated scan struct
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andreas Klinger <ak@it-klinger.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722-iio-proximity-mb1232-use-stack-allocated-scan-struct-v1-1-b4ef77e9ddea@baylibre.com>
 <20250724112628.565aac47@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250724112628.565aac47@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 5:26 AM, Jonathan Cameron wrote:
> On Tue, 22 Jul 2025 17:39:17 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Use a stack allocated struct for the scan data instead of using the
>> driver state to store the struct. The scan data is not used outside of
>> the interrupt handler function so the struct does not need to exist
>> outside of that scope.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Hi David,
> 
> Applied to the testing branch of iio.git.
> 
> I don't suppose you fancy a follow up to take that irqnr local to probe?
> If not I'll get to it at some point maybe.
> 
It is also used in mb1232_read_distance(), so this wouldn't be trivial.

