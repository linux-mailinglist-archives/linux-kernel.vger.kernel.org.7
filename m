Return-Path: <linux-kernel+bounces-886823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0657CC369E4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371C41A23694
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182732E147;
	Wed,  5 Nov 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLXXnzPh"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD4329E5F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358030; cv=none; b=i6BZny5ZilRCnuyEhZsvZ807qubSYcTztCVzZn4+d66Lr6hAaTowu6O0tuRKle4gDD6GNiDkMHS4unYjeE9z2uWw3BBV8NZpdniJbAXzKdyJggTerIw3DL6BqTISppBuwdKUCshAFTerka0jo1VNUKSudHKrf5adtXsXNdNC3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358030; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVlgQMglxoY/Kr8SsonQDs2/lhsByLcAgVgZk8t9qij/Ob/9udHi88b0V8AGjLKhc37qFvZxo7y40MTbUSSCTQR4zhkuD3tccxno04189sGphzce/ppApudlWEzD1PPDEsuR5vjYZ1UDalG9jzRBYCU4vM9gjXtjcxT6TTAuOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLXXnzPh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so6539489a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358027; x=1762962827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=QLXXnzPhRMztfm894pO1r4Trz90ensrbbofHRnMWo1o98yttPShgFz+huUa1H/OBGz
         lRaxDvN0akEwh55XNZM1JzaH/ZxG35+sT+ktFZCn8uDYZBUdk32u/YcPUT05YIfUMJUN
         mpNvEghz3QwkNLgfFalw+hjLp+Z/i+dN3UyRjPnKNCWib8vrNBtmDcftfE/03oiDWAm6
         MvDKVKLlrBSdBiaP3R97OaZiKpVDw0yKozKrHANmcw/H0b1d7hGWqVTITZ3eke9FEO4a
         gczAUbdHRVqbOWkRYjEXGHK/S7LBeFTgL3zdaLy7ruJvaq4oCLqaGbtBkX/t2AhobtuL
         10iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358027; x=1762962827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=djzNw6aEit6dPsvYKqwqQjIxeIwVMbJ73p8tu7PnBpPuUW9yMt+LJJtz4Edsf94WzW
         TsD/5ZMia486qPb9zqBS3or5L4TfHlQwAwYKEKMJztKhQ/+Ejey6nVwjvwFvH+GflPES
         0w8cYnnqERHYs0MTM4NV8i2c3TG+M/kVpdcxGOszULE4KjEsBTlRiiRbyCWIrk57ifPv
         91UpecJ2oiHzoIfQkSn5QDnhpPsb4cXu7H6ptAh9y9+XDgmCMWUvBIn+6yDfHqO9bdfP
         JSSclM/tfWhJDSnuigF+g65VN0CG0JqOpQASQV1HqxMqDq6liQtg4WilFkaulhl6K/Eq
         ZpVg==
X-Forwarded-Encrypted: i=1; AJvYcCVT/XR+etl0URSST0rlMfqSvnwtSwljU4Mfez+7AyNwmN4MVvJ8oZRO70XvtS0uDx5/tBtSB2cUSkyarGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDM12iYtanzIEd0tsp34Wl07VSUKeqPV9wzZjfUf9dLCh60lH
	SuW7LUcmOWP88D7xDma0wg9Yad1fTRliz0qQpfrcOOS+5RlwxyHX9453KRM9eQk1e7M=
X-Gm-Gg: ASbGncsvId9it0tWMmxKiZvg0eK48p73EGWmmPDxxdE9KzE529S6UJ1l9CC0oglZqgD
	CmU804NAr93z0yXDUlfad00dbGnDENUOpIorF1sB/itkdlr/EdDZkkKBmdnOPdyg3tFkp5FAuxS
	zkFMT1f14ABrM3hB3TTPMRxzhF3s9ZbrR4s64ZZq9eMYMBVOgnb/YSVUrv0pjBMVzkoyx/ATLsl
	Zg4Zr9jPSVxkdzjniFB6ce5xF8kS2q7lwJtRoRD5qn4y5ZCe6mpL7CDU9iEW5kQVXIiE5b06Xjg
	XY1wu+onXv734KIUI2Orq8GRemaFdvpxBCmaKBKZf/l2I5nXF2N11vzmeUlKKmn84BUoCp0ae+O
	7LoK8CnrNRkrqpbqe/M4B29dLvLoYrtttFgmOX2hRkErXBmL7++A6UoJNuxwsM/GZbE+CxrVKNs
	ahtUI+wHvASviHZ1I0AF2fsXo=
X-Google-Smtp-Source: AGHT+IEhBbB+aDttEEGQs9oOQQ+tXYqrRQe+D+B+YbWiBNmMQeVjILVA1dM7D5N6K2h4GWUGw/2OpA==
X-Received: by 2002:a17:907:1c2a:b0:b70:b98a:278b with SMTP id a640c23a62f3a-b72654f6507mr345447466b.38.1762358026889;
        Wed, 05 Nov 2025 07:53:46 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d91990asm513705366b.28.2025.11.05.07.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:53:46 -0800 (PST)
Message-ID: <b940a35f-2e7b-46d6-8af5-42c60263c528@linaro.org>
Date: Wed, 5 Nov 2025 16:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/28] spi: spi-mem: Limit octal DTR constraints to octal
 DTR situations
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-3-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-3-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

