Return-Path: <linux-kernel+bounces-774269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24FB2B0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE40A5E672E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428F26FD8F;
	Mon, 18 Aug 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tZdRi83b"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC621CFFA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542777; cv=none; b=fBn8WfbyJMlHxhBnSaBqIGpqsbsc2ujA4Re9+EuAXsY846RccVo9B71bWx4LFQRxKrgezNt71EX8Em1B/NQvVU6GcvIDs7LUGnxwOeoXFktcPVZzfmOHPj75NEFcxI7kMfb/PaGfAQN+wItErsnEyUxHnBtY0wJ9bV3+mHkmAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542777; c=relaxed/simple;
	bh=C53WQThecyRHyG2y2doWAd9gG6VnMVqKUiUacXtVys8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GumB+KPIo92To9ZXZxiAtqEkr+gZRVIxZP4GNrU/Gxqri8MaRT4RATo2JFaYYnRm5LKIVLFSf662+V8nMzQzC1gQYdSUvyv23dZFcB7vG+nOhcLKeLNJrMClMCJRhf8AlZJy1vIgfwzBGqSgXY1pQW5LIIKAcOQqV82P5Hqfs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tZdRi83b; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cce90227aso1595240fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755542774; x=1756147574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKwtzpSJXdc0i1E4Lfs0SQasfYwFsWMXD3Ma/0/zLOY=;
        b=tZdRi83b5/lGbwbqyUZCK7mV3MvjoGwbpVAVo5cHe0Gc1e985xD0G30vgFM2AUaHEB
         VdJF/MhJxmANr9c8mxvnVxPnwUJIgtJo2Dzt8uXEH1JpV/N8xRqv51PVAcNGeuqxsXX7
         NnM50nB+DU0YJGKj6uu04yy6Mc5h93ZuDhco+6InF1NiUDy7Gw7S0tMRCAuXdiTzs6F/
         nbSYac0zzv9AOxOI5URwnD8GkPNDIVhHkveb5syE4Pw/23bBiGzS/jgGyST0NiuR1ASu
         PVlmgBMIXrps4XE/ydhNswnSSCYI00Vnlwy6QPlV1YHeCh0Zd7TFDJCcYLXX0hRUNSBR
         ohaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755542774; x=1756147574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKwtzpSJXdc0i1E4Lfs0SQasfYwFsWMXD3Ma/0/zLOY=;
        b=K3ZaRBAN1yKIbf47GbSaCMI745sNp6Mep8IxrgGDtyeA5951yx9Eb/c+6mSZGaaJTj
         EpyNGff6PBTW/F3qz+/9gLGpk4Np6bAcQnYCQNwYJ/8GgHMyNudakLgkV8QL66Qi4m4D
         IMasfBj+tA6KDFMrJvlF7ljs2R112jre09EIjvFyONtjcrZgbMU+1/GKHnFybkpIabsj
         6Bwm7E2uE2q90mpJV8lE2XgRvHO3sfpDgLzQGHroD5fnU0xFz5EhLNcc8S4SoeRgnnw9
         ZqDUSmkhJ1X4QpX0eFfG76AQjNbNg7c1SyXI+OirRYPQIdGRyjajsyea3ARxSCgHE/Az
         nIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH8aOyFQEMJLKQwsRdu7PwN8qvc9GHvWCSjMBeemRpb0vhL6RDA2nae7Im1DotgMxbK1QXWuvPa3grMiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnunLZr3cDatYw/I11Q2p66MRuyhmbdd1IK0yLn9oDEVWUa1o
	O3mUq/jxDz/1kklKE8S85mZFiDMDj0nN5QTBKzGJZqRtqlNvfxaBo6LTMbjQtxxicSCzQspW2OR
	sSHTd
X-Gm-Gg: ASbGncsxPMpWt7lmFnj/L1fGojK3M8jxIB0W7y9ZTK5ZRwtmQDLcpuPQmbF/hpPG/f0
	Utn6/VxlFhKQNSWXtt5EOEjnqGQ3jGO7SK1klkKaUxVBw4H5ld0jMBgJJ2kIjbeiFbxjDMqpsQ1
	XECqaPoDdDOmBuLSCsNYh+uI3/uPhrFPADH7YSBhN5iKd8PmeB2jgLV+qcRs/VHjbKYdlZgZDpr
	baogJu9YbWQlV5AGNtgz9+XjZz+PqDIjJd5KWA2U1Fcrz3C3IXIe+D6+6/Ox7UxHmXOammShxD7
	7iu4mc7Y0NDTo45/JuHaQvX+3Pe1fWZksrimr4/jt2WzWs0kQZH9IOTFQHvem7b/U3VTvLp/Kpe
	DpdEmcW20k0cC6gs580gn494Numla4VHqm6LDpleV3ivfikcwxTJLsgl5sJQZ1mLP2gooCH+SpA
	I=
X-Google-Smtp-Source: AGHT+IFa8rtZwWPOCpTppRhVyDky9XeYSaC4LBjLvLnOvIueLM8NbOrIzbBeJn1GmEaCymt6Vt/peA==
X-Received: by 2002:a05:6870:789:b0:2e9:4038:83d7 with SMTP id 586e51a60fabf-310be4c509emr5219307fac.11.1755542774067;
        Mon, 18 Aug 2025 11:46:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204e556sm1987755a34.43.2025.08.18.11.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 11:46:13 -0700 (PDT)
Message-ID: <8127b81f-d2a1-4dfc-b8c6-45615ba9e431@baylibre.com>
Date: Mon, 18 Aug 2025 13:46:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Support ROHM BD7910[0,1,2,3]
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>,
 Lothar Rubusch <l.rubusch@gmail.com>
References: <cover.1755504346.git.mazziesaccount@gmail.com>
 <20250818191932.42c22df3@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818191932.42c22df3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:19 PM, Jonathan Cameron wrote:
> On Mon, 18 Aug 2025 11:11:56 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Add support for ROHM BD7910[0,1,2,3] ADCs.
>>
>> The ROHM BD79100, BD79101, BD79102 and BD79103 are ADCs derived from the
>> BD79104. According to the data-sheets, the BD79103 is compatible with the
>> BD79104. Rest of the ICs have different number of analog input channels.
>>
>> This series adds support for these ICs using the ti-adc128s052.c.
>>
>> NOTE: There has been work on couple of other patch series [1][2] touching
>> this same driver. I haven't considered those changes because, AFAICS,
>> there has been no new revisions of these series since mid June.
>>
>> [1]: https://lore.kernel.org/all/20250614091504.575685-1-sbellary@baylibre.com/
>> [2]: https://lore.kernel.org/all/20250625170218.545654-2-l.rubusch@gmail.com/
> 
> Pretty simple replies to the changes requested in v1 reviews and nice and clean
> so I'll gamble (a tiny bit) that everyone is happy with this and at least
> queue it up for build testing.
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>


