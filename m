Return-Path: <linux-kernel+bounces-739843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DEB0CBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B341733CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39B23B61D;
	Mon, 21 Jul 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ga4uIzK2"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7923A9AB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129542; cv=none; b=lAMxEkjvoZx8/rF0uBBnAXMcK2sbs2JEH6LOJLsmqP1n4oKNTOt8A53fVDng/5Ceh+P4tKNoqJGiJrnQgzNhSovGDpwVDpO+orSU6LDhhpZU0x/KdaxbSzRDA7VL+bVbjH74BYtvuN+iiuAOG5YdHcHAjbnjZI2hGOjs85Itz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129542; c=relaxed/simple;
	bh=hGFN/us4PJA4Xsf/DhXn3P6fmy4Y1hnlhz5wLuKVoqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqJyoFtq18hlXI9SFMyGOArg7Uh3FLYp65yP2Lify6P1o5ypGqEoN/ijQoxzk/KzDUkuN5GPT4AMMIm9fIc9CiLSrW9x7ZWkihsOFhO4jO0L/+tV+4O9gLneUF5bUVlxCwLNoz3fvEravZzqh16U670eLK1SqWGAEys4eneWWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ga4uIzK2; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c14138668so1978568a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753129540; x=1753734340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4GRM/S7FS5n33a8EgF1WPjJ5PYFBbiyNz3lEYziTLbc=;
        b=ga4uIzK2PSMOO9pDXUSGq+vuJcXn1U3ljZdO7+FH8d+50DZs2KNiaSo66P/KGKwCpR
         ++6TO/Cu9KTpxoIQOBt8mF1TLwR8c2DI3BUn+Hal37GCtT0L+12g5v4groHj+wcRCu8h
         KQWlPwhg7VpDN+CPWq88C9UY9UvjoDTv/Ain7Jzrv9sYTbWbHpX+pZ4ukcDX4lMC5EOp
         oCD0k4WO4fqrSQkb41SToYsoyAqZf6LdDTdUowl5tzD77/kvkzjLp4nZVp1CKniOcZx7
         fmq30LncP6/lCJFmPWfr6Xx7Ja2p0tfpFmcUvPjJJMqr8qr9QX+f02j/l3OsTIXJ5KSG
         A6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129540; x=1753734340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GRM/S7FS5n33a8EgF1WPjJ5PYFBbiyNz3lEYziTLbc=;
        b=C/rEkASa7WEZp9n6FGDLLhV9cHp0ql/cp4nxUimj9d7sT0JpqjvtYgrX4Lhp2BgtYw
         3EFZ518sCi9A49WzmBKZVjn+uyyyyMUTqS5FORW7SnsNwFBWziL4/6ZpZ0kxXoF2TBHX
         kyc0qjPaP18P7xj9hJhsXs2Hh+wzr6UVN2nn+jxgVHjL7pwldnuy8kb8qb8SMYevm/WZ
         BS3ow6ZfcNFpaQWdg9hOkEiBXte7pUfJx7I80nbBKGjz4LXKuDh+i/qnOKC9G9yn1jV2
         qjwXx1Wy9yi7SIP3rkX/2tFGKvbK1MX2H2R89vHH57vgRsVk7Ak87Iz3ceWg+l3H8/Uk
         k1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnpODAcaoenYfebR5U7VBkdc3g12wEIiR2IuRLbqvFZDe63NNyenTep2QhQ4UQoTa3A5T2ZOoKHFmyQFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0N0agXuryKtGTSpeErV3gLZYNCiN2RN2qK+BGcgelJ02Stwm2
	c1L62Z8T+EmmixCk0Osz2AENTrwT+4VPAF/FvL7bP8UDnGeRb/CtSWa9WF4SK8RTPCQ=
X-Gm-Gg: ASbGncuhzK8AZPv1ovtYlBwKb/KvLXInMlzvUriFbo70pvOAbE/+EQED3SueIHaNi4g
	QISbrGM6p3BP6lcsiVW/7k3twAA5rSRYnWEefBxNfg1yvb5AXuQqXVRAdA+cpO6QTCoHL204AVA
	mufV1eBo/oDHOBdFJbUnk14R4B63jTAx6z02M+ikYO918veJVMm5dJQpzKdSSH4f4z+pvMqVRCZ
	pWZJolqSCK+gRERcI6wibXlh4mTx/m/8Ova5pQxkw25AeRflYEZsBGpm2W7FikZkj2Im7R6IoAz
	4wkwsJ8Q9BeaAY01/UUoXbD4sBB0KgTZiwicS2uIee9T9kG0DUS69fyFZHH1Kb4wmSrcchffxb3
	nCjQyJvHUaIEd3tiT+HZNf5NjB2JguEb5coLyFC8t6YNudIx7FHYik9vr1KcdsgX9VZh0Lp5kP6
	Y=
X-Google-Smtp-Source: AGHT+IGZ5R2xSYQSO+30c9/IoRg0zcaorUVpPKcfzRe0hDQV6gsrMv5yUTLMuWd7PTbmA0KUa4uNzw==
X-Received: by 2002:a05:6830:710c:b0:73c:f8be:988b with SMTP id 46e09a7af769-73e835a52bbmr13035612a34.26.1753129539787;
        Mon, 21 Jul 2025 13:25:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb? ([2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83be5d8dsm3131100a34.64.2025.07.21.13.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 13:25:39 -0700 (PDT)
Message-ID: <a88e1a8e-d29c-41e7-b3cd-5db965a055df@baylibre.com>
Date: Mon, 21 Jul 2025 15:25:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: light: ltr390: Add sysfs attribute to report
 data freshness
To: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 2:54 PM, Akshay Jindal wrote:
> Some IIO sensors provide a status bit indicating whether the current data
> register holds freshly measured data or stale data previously read.
> 
> Expose this status via a new read-only sysfs attribute, 'data_fresh',
> which returns:
>   - 1 if the data is freshly sampled
>   - 0 if the data is stale
> 
> This attribute allows userspace to observe data freshness directly, which
> can be useful for debugging or application-level filtering.

For debugging, using debugfs would make more sense.

For application level filtering, why does it matter if we have
read the same value before or not? The sampling_frequency is
available, so the application should be able to deduce when
fresh data should be available based on time.

I could see maybe polling this in the kernel in order to implement
a buffered capture mode, but not sure passing this on to userspace
is the best way to go about it.



