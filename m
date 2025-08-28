Return-Path: <linux-kernel+bounces-789899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D222B39C56
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97ACC7B7237
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEAC30F954;
	Thu, 28 Aug 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq5n+JhH"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70F30F52A;
	Thu, 28 Aug 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382956; cv=none; b=kFpkKpm+GGJkyQy3GGFqFb48I/xbBVEHTv4gXVDlWBTJ9SFTBRbuo9l9h5uQC/+QXy/6RFEji9niZw3cq3xu7gvk0GUQptbKw9AO+cBW4JgJspGhEF7v2gUI/Lf8nFNiK0Yi8ceI4kMXUBBLnNM0qN82p3LfedSe1FM9SaU6AZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382956; c=relaxed/simple;
	bh=68j3RZae3tXtdskGBYhKOWS2516C0lenOCKQJINDUDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2qdlU+gdN5DXNWk0aOa+G4yarN8uECtmahwtuCy2CA7Hqw7hJjpkISruD2Iu83SUntcf2IlwRvNEt2Ch4oxdg7j3Wfmrfa9WIpEPMfDf5CkHYy98dPED8IsRgke2HLEkgUtXoc6kpNIm2mEKIdG6PWnreslkD4E0/tdM0P9C2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pq5n+JhH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so733677b3a.1;
        Thu, 28 Aug 2025 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756382953; x=1756987753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x6XN1t1iD6sB6HAWNyIKXI4VpqreT5hi/YqZ431JLoo=;
        b=Pq5n+JhH/5UfKl2x3rq0sPFGy/lAG8cqRvscYKkyfoL64gPya4He78ids4PhhsZgtJ
         13mFapOCz/Hqp6MU7Gr1YOknIE3EsfF6PCSUx9JU7ctbMnc0LcZ9XA2apOm3tPyaBT2L
         JhS8GSEAre0C2tI0NoEFMBNZRUA9PieIRmFtXEReas6so5SoQ7h49eTEhQyWgTBfBttY
         qMncoV2ys6LfgePtfsfg10tIGPiwqN3jFAumJcLTUNockhfIG9/AWWiMz8NpTOxd/MwI
         anV0feMpPxoyjTS7Y2mAJDim/KiZrF3vxuBQF3KsHbR+yOpeshZFvDDXbqxXcsWn1Sh8
         0V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756382953; x=1756987753;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6XN1t1iD6sB6HAWNyIKXI4VpqreT5hi/YqZ431JLoo=;
        b=O2irur0g/UKvmRaawyrc66rAa/bOF5lbNX4TqaI3I9/j8Fr6jHDvCFkoJIvJ2p3ly8
         z0eKcgcrdlhghiQz7HKqwd+OHoTwhRAkVUB8dx9nC/QNL3zWP86sanO9tcrb+njO7OpO
         pPHOexlh3NfIIatnkIwN/TRr/R+RFtlpxMWqjj9i17qW2HDg3g0nSPN7zdRJlwUACfAM
         fVDhWw2DY4I1qShutllEI2JrW8khtJssmdpAIpL/Q7mi+uukW9Yew6bppj32Oj0ONp0D
         /ynqSdUj7qyZ1njrfL75r9Fq7lRSS61h4HKMGuVJiIhdCxMMo2j3lquYQcueWWcK0Q+E
         A8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW00ET8x8xbQY0O+mBuR6809gwHSD5RbrtvhXFg8hjqpu6NbYlAGL6laik6EZmWLmhEVMljQTLT6pt2NKSg@vger.kernel.org, AJvYcCXwvMmdh3DEv0R/VQ4TKQGgWfjqhvuK8sWGz8zN1bd5nEFZeX6RkHldGnOxEFmyh0xyGx9Yj6Utquiz@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMza8NnLncS7vef8uZowfy+NqHaQ9FV2n6VbZ0e497xscT6LW
	iE8weJpwR0d0Bjnqkc0wN/lYMiRO35j8WkrsZ4wcm6d7x2Pvov22fZ31cb+dhw==
X-Gm-Gg: ASbGnctGBe3r9x2YS+VRZdnp2Z18Gfy18JbQAnsPBzbMTuMB8LNQSygHuvrY5I3nB4W
	Fs9VbjCY2dyDCSgQNFDSFso81f1Slr/+YRTv7dfdWbFTBUef7r7a/GDIv2+YnoGgvjwb4xs4hAH
	UZ9ctgMh86fGwobHaOLX20RfInqgeoGdXVUbMUsjsY56xFJWUT7tp75CX6yONDCZ2ZxYBM+9TW8
	Ub7+JaREu8B3g5GjyLrQBhsS2HyqFdUYVpPe8b7KZPVE47NdyDxNRWNOm7eckoqHnVv09S51OtU
	245mmnXCVoP6XTsiPwsFWnXMXn9gXs2phOQScE+4hWjDG+nI80b5PWmfrQPhkiGejB1J3aA4dFn
	lx4ht6LP5hZxs/nesgMp7dPO1xp5zoJTnTT7929ywMtVU2/1r3Z8qmwXycdlvP1Iwa4akKd6Hs3
	VdRzg+Rw==
X-Google-Smtp-Source: AGHT+IEVg99UW4ob/hBRTyJNwskhOBJrHlLhahTqd88VbfdTTr9jSDpEfYL4OfTtR8mEKj8mVmUoJg==
X-Received: by 2002:a05:6a20:7f94:b0:240:1e4a:64cc with SMTP id adf61e73a8af0-2438facc679mr12942006637.12.1756382953384;
        Thu, 28 Aug 2025 05:09:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c3cd9e56esm4829034a12.14.2025.08.28.05.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 05:09:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6e51d4b9-23fd-401b-afb1-2df943f85c3c@roeck-us.net>
Date: Thu, 28 Aug 2025 05:09:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: (ina238) Add support for INA780
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
 <20250808030510.552724-3-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250808030510.552724-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 20:05, Chris Packham wrote:
> Add support for the TI INA780 Digital Power Monitor. The INA780 uses
> EZShunt(tm) technology, which means there are fixed LSB conversions for
> a number of fields rather than needing to be calibrated.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Your patch does not apply, and I can't figure out its baseline. Please
reparent on top of the current mainline and resubmit.

To simplify review, the patch should be split into preparation patches
(such as adding .has_shunt and .temp_max options), followed by the actual
added chip support.

Other (not a complete review):

I don't see the value of adding INA780_COL and INA780_CUL defines;
those are really the same as the shunt voltage limits. Actually,
the current limits _are_ available for existing chips, only they
are expressed as voltage limits on the shunt voltages. For the ina_2xx
driver I was able to resolve that quite easily; we should do the same
for the ina238 driver. Maybe I have an evaluation board somewhere;
I'll need to check.

[ Sorry for being so late with this; I am being swamped at work :-( ]

Thanks,
Guenter


