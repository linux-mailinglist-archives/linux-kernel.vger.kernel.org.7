Return-Path: <linux-kernel+bounces-746649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3006B12972
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 09:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B69D4E84D6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9BC215F5C;
	Sat, 26 Jul 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="khI36g8W"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8849720E033
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753515288; cv=none; b=pCp2As80r/1zOKzpuQM0b6P/mEb4G08ksW6/Hrit3wEGxZfHOH3i1apTUT2tkLrXhvIgqeTEWgqV6mDSRPri5YeEsLHQH9SRXtrqILl9UWk0TiX2xUpAz9Fv0lFz/ZR95I2Ig1wnGujRxadiLqAYVqkR48VG3NmuqTIsbcAFEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753515288; c=relaxed/simple;
	bh=FMNmStjOUWVtt7cOwV8Qlv+tumSg3tiV3l++SO5dGx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNf79nGesxUxuPLEjyC1Vp4D5sWl6kyuwbxDbiOqpEGuFGwaYD7YLd3qR1aKtccbJYJB3BgkI67lkeaHzQa9KcmqrRXhuN+9AOjaGzL/x/HVxS9KlS82hHOpaUrAfGmgvtXlgB+T7t2pvY3cOuXtlV1btc9hcGU+dy1h862Cagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=khI36g8W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ab112dea41so1594830f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1753515283; x=1754120083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMNmStjOUWVtt7cOwV8Qlv+tumSg3tiV3l++SO5dGx4=;
        b=khI36g8WBD5L5T58SbErP3gsvmWIvDAjpf/72tHfCOG+ZWf8GUkTHOIxZ/yP1k9mg4
         1bG9x1mQOcsv6SKbEVWOn2dt71k3a5+Aax43Wts+R73VAviGHQ7SXLF1h6gqwa8VfBvJ
         V4OpcUUxMQ/o6ZhN3FeZWix7X9LJ7nxL6mrBVZ48OhCWwS1f89ZCV0raWbW53QbwEWUX
         Bg+wxxlFMdZyczs8JFXFR8Y0gm2I7JVhM/fe3866H4qC7Cst6jGqSQg52I4PIt5P6XOK
         XnznRJfbtV30s6EjYxnx0v16twlEvT9tGgGrkvAL+rUnBeFrPkopntpaUuGuWlTsj/Sp
         Ea4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753515283; x=1754120083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMNmStjOUWVtt7cOwV8Qlv+tumSg3tiV3l++SO5dGx4=;
        b=Ef+ntIpwMlfr1tAmTgKs9+dPoQPbCzrTveKnaArMl7c9rB6PKuJtG0s0UdDWCELw0V
         JeNRm8QqJi50khujK5YwCYf/kD85wiXMKfWy+2TLUOYLCe+jNp/4ZbNfSB0/+O/3icNf
         AK7iPhOqwVfGIWHNU6dtn9Q//cea9gRhl9VLTlasnfIWJjAbx1Am2sXBCrBdO/8sJwq8
         ftaiXYSaYC4towB+/889g0KZjx86BbYHGGP0guomY9LC+CIj/xb0eems2nhC0fDullrq
         P0XYsO7/KvKJyK2A99YyHA2HoF1ob6QehzTHSh1FXIEnukLJxXMBpCVuTy+SsCLUAejy
         3tBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyT/oorm3T5H2HjSChfkvswNG6YU3ZU8SO0ptN14iWEiFMjKQxaQyVi6tcbjR74riEELXOyg9ZLQRtixg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdR8N2ZnghtkaP8czqI6hh7AznJiEahwkhA+2/BjZIoKSTXulK
	kQgA4BGAf+WZxif4QdbPQMCAT30CuFiyoySQW+vQgqBpvbOKcATxU3sySTWSiS4ZF3k=
X-Gm-Gg: ASbGncsIAT9n80GcCtu7rJv3lf0Tu3vnst8T3jgYmQxXEnID+VjbZp7RPl76O4rMtxE
	k1waqM0hZciP3YsVN2tcPg6ynkhrb7z1WYnJtHN2tYOS8eeXdw5sb61pVic2hJkRxdbMv5hDigd
	NVt79p2WfOfiJ2jtjxZyiecEJG9U7nqFgviFGqjUQPozsBnxHQcyp8eZFyXp2FrQY3CzX4GHcYe
	pD1cqyG1WjgAYwXZwD5L8B+fY/5jHxxi9lr7mlPgODvoh/epNfkYKToBplRXAH4yFt8YRvsf6jZ
	xNrqCU/BNikfmVCw/0lBBO7lMSBmUM4eqgAY80mQMALkRlSnUZufA110vZ88TASagpW8scRJhON
	+goKvBdL+qXpXrGdcy0Dxjuaz8mEQJRFvXh9HyPQiqBYjM9tqSC2lU0mX8ZnSsQWdMK7v59cPdT
	aKO5qWPxHHFXaAKKUi+204
X-Google-Smtp-Source: AGHT+IGS1R1BLd51LhebYLPR71ELpRpxxT4MPtlRkigqh7295cnHvdHNyjtNpQNmAZYcVC1/uPyNUw==
X-Received: by 2002:a5d:588e:0:b0:3a4:d9fa:f1ed with SMTP id ffacd0b85a97d-3b776728f9dmr3020420f8f.13.1753515283332;
        Sat, 26 Jul 2025 00:34:43 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:aad:4a11:7705:31c4? ([2a02:1807:2a00:3400:aad:4a11:7705:31c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f1e760sm1991506f8f.69.2025.07.26.00.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 00:34:42 -0700 (PDT)
Message-ID: <bbe1ea08-23bf-43dc-960d-bb8a214b65fa@hammernet.be>
Date: Sat, 26 Jul 2025 09:34:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: validate commit tag ordering
To: dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com,
 corbet@lwn.net, apw@canonical.com
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jeff.johnson@oss.qualcomm.com,
 akiyks@gmail.com, konstantin@linuxfoundation.org, krzk@kernel.org
References: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/24/25 09:20, Hendrik Hamerlinck wrote:
> Modified the checkpatch script to ensure that commit tags (e.g.,
> Signed-off-by, Reviewed-by, Acked-by, Tested-by, etc.) appear in the
> correct order according to kernel conventions [1].
Hello all,

Thank you for the feedback. I wasn’t aware that the tag ordering
conventions used in the TIP tree are not universally followed across all
kernel subsystems.

My motivation for this change came from a recent mistake I made in a patch
submission, where I incorrectly placed a Fixes: tag after the
Signed-off-by: line. I realized that checkpatch.pl didn’t flag this, and I
thought a warning might be helpful, especially for newer contributors like
myself.

I now realize that my approach is too strict by trying to enforce an order
for all tags. However, I still believe that a targeted warning could be
useful. Another mentee I work with recently made the same mistake, so it
may be a common pitfall.

Is there a general consensus on placing the first Fixes: tag at the start
of the tag sequence? If so, a warning might be helpful for newer
contributors?

I was still using checkpatch as that was how I initially learned it. I'll
definitely look into using b4 as well.

Kind regards,
Hendrik


