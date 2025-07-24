Return-Path: <linux-kernel+bounces-744424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91057B10CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3955C1BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21682DE71D;
	Thu, 24 Jul 2025 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PbQfqYEe"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB882DCBF5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365535; cv=none; b=S1Q4simQS/1qpbuQVWcbQWWHXI2OpvEZ7vP0aNzWX3luPVeRhQUslhi2ODq4TeDhAVkWDIi7gZL8Q9M4JxEWi/2O475TrA6/Te0rDStUTumAWx72dd8PkEZGihMk9/qrRCN5PmobJ8xYSM4ZcMMxA0TC50vQ/glebhpDtMHELJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365535; c=relaxed/simple;
	bh=r8m0H60OOKOoeR/NbCqxjR9n2Mi89/uUoIKCUGbAQns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aABts9Js0Pu/EPlrr7hdbNeHtm74GR9BSY+vTh7+L9hW8BJCumqqdz1fWumyrpQ/0nmcolq/GlzTX2/9mi8M1X/goDzaTfNIwG02qAqXlCMAdmZOWWoshhoP6NQziHlO3Qj9ZgnfX+hNqNowK59Tfr8WfG6TlAk87NnTJUpRAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PbQfqYEe; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6159c26766fso570961eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753365532; x=1753970332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8lhkGM6eZ06qMIeQSqBFlLSi5hic1SbTRnA9SoJkZU=;
        b=PbQfqYEe2Za1lQGP9TtLH+GROHBbNby4i5mr2IxOceP2kFqxinT9JZFFfEYiBcQjLb
         xUQF1aafLpIfMI2zOX3dZ4cChUTmDRt6ZTNFBsdMpfXXja3bRo5TENQAywKb9LBo6UAk
         DC6oxb4f7BAcusD2lnC7CftQeP7rqx/a+gXAXZyVUP0M0K6tPu/YKD1FSvBt75iSVolp
         vrkgKP7IReNhzxygWuxZezFdQNIGrAHp+tXBWKsp7eOMZNkf1nFCICx11pIlqk6LHQ7b
         ev1cI7MdOKr8mTz1UL6sStD01h8yGDABvaVeqeo8RV9KLe0GW63OkjclFG66N2O135Ut
         WFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365532; x=1753970332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8lhkGM6eZ06qMIeQSqBFlLSi5hic1SbTRnA9SoJkZU=;
        b=FjKMQN/jaeTNCoy6oCTGkLn7ecKrr0Mrd/yBBv+2XdRC6mzHHROFMopQKH2+Ns3WRG
         YTTzun5BkJgJiJIHroX4oE7KNBOjAdGsfp/ziBQMIu6zDH9RTKkji4s3gsbk8f2eLE0Y
         knkzFcpGzMHcdo/l6gB1XDiNJK0mVLu0uf6f2p/dCYouxbdTGAzDlUz0P02wmsnzc2fC
         /R1EvnKYEiIQwNcXE/YR19KWmgV5g80OJLig9OLMdmJ1sIHrf6M7e/V0mVINRxa7/qGW
         lX6I5HVeiEGH+d2CvTns+cm36KvejtTrYfL2At0JNdmtKILS8Jii44Y4u5gl/qZZ5WSd
         QQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWU0oNEyHJYkHtAS50ko7o7Ln9FtGNexmX6OF54mjHSG+6wSBjRkcwo1K3wM1A2RcZqxjdyPpQdT3x6zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hQEp+lgOclTbQ4pjva73kY9eXrvLXSrOqHHFn7xv//KQljxW
	ySAhdmdlJwzCKNfKGswiOjkXszbvc5bxf9IvAJ/aKdRo8BgKEljDjLgqeoGHXUX4I70=
X-Gm-Gg: ASbGncstKIRgWjH+RCRygO4zObLs/6H4N1/LovZsh+R91yGu2srdlB2sgD9oS7ofUhr
	o8TLLdK5Y/77iozWQaWtrny+dERW1M1GAdWVFUHFZLPcw1FRSv0yu0GLLQlSsJPYCFSIrCQ9voz
	d/i290F1D8OK744B8m9a1Ztgrvzo/mskQx5SIfCSvDTxlbOq+6up+W6WSxNh3bQv1rhMDAEpH8q
	sQ4rVs62HxlCrFUDP5aUJEZAx+si+u/BqGGfiJj43VfJHl/8LsFvNsIgRHFc3Fh+xVRJmy0thZ8
	zmep8zTAQ6XDXHTVz6A2Y28x+YzpdNf7uc32dT+3aPa9IgVL8WKmmtNXka5J6yeL9ZzSXqhapqi
	F2EGdRCuLGmF3AnpVR8d1czg/XlS5PMhkiJk0TyRT+xKXVfxI9Pb2K/MJeJbVNGZ+lfwqYqJkrP
	s=
X-Google-Smtp-Source: AGHT+IHZQzg7kaDuAlFKlh3XPZNFCAFVXmInWE92TfWbiWLHeoiep/6LdiR6Fg9xqiYfhuX5RRglmQ==
X-Received: by 2002:a05:6820:6ac1:b0:615:c215:6134 with SMTP id 006d021491bc7-61873284b83mr5671009eaf.4.1753365532107;
        Thu, 24 Jul 2025 06:58:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9829:e9f9:e475:a206? ([2600:8803:e7e4:1d00:9829:e9f9:e475:a206])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-618fb44265asm223960eaf.11.2025.07.24.06.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:58:50 -0700 (PDT)
Message-ID: <d292c93b-1ff6-43e5-9187-2ce851399bea@baylibre.com>
Date: Thu, 24 Jul 2025 08:58:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: add power and energy measurement modifiers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
 <20250711130241.159143-2-antoniu.miclaus@analog.com>
 <1ead013c-56ef-4f11-afb9-2b11e0de7eb2@baylibre.com>
 <20250724140940.2d9b4a1f@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250724140940.2d9b4a1f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 8:09 AM, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 14:23:14 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/11/25 8:02 AM, Antoniu Miclaus wrote:
>>> Add new IIO modifiers to support power and energy measurement devices:
>>>

...

> 
>>
>>>
>>> Signal quality modifiers:
>>> - IIO_MOD_RMS: Root Mean Square value  
>>
>> Suprised we don't have something like this already. altvoltageY isn't
>> clear about if the value is peak-to-peak or RMS.
> 
> Hohum.. My vague recollection is peak to peak, but oops we should
> have documented that better.  Someone want to audit existing drivers?
> 
>>

I did audit them (which is what lead to the Q/I modifier cleanup
in the ABI docs). Most drivers are just using the frequency and/or
phase components. The ads1210 uses peak-to-peak (I should know, I
wrote the driver :-p). The envelope-detector driver mentions high
and low when making an altvoltage_raw measurement so that sounds
like peak-to-peak as well. There are a couple of frequency drivers
that also have altvoltage_raw, but I didn't look as closely at
them.

