Return-Path: <linux-kernel+bounces-892475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22807C452B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD53B188AEE5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3042E92DA;
	Mon, 10 Nov 2025 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miJwN/bl"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489722765F5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758494; cv=none; b=En73x7fQlLIu7DPAP33Fmca6fhepjdEGw3zxm1C/S251xzRrTGlmammBzAVN9gYP3P/FZ0VIzzaglqzDNvp42KxG5AoDsTQMLo+kRrR+aqgwBLXpdKg7Iq7LQ/D2mPg+RzT/gXnFeny1u4oQpwNJ+9d+C57Bn/tr5TAW5uQ8xlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758494; c=relaxed/simple;
	bh=afi+lGH86ZvrucXscTjEx1ykkeQtiCdeX71RXwxok+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JImAmhVWNtlkMiDS+kCjAO4EAjLK6KQYthsO7r82Z5mJrEJZPTj9cTCpWoiEMDrjiJ/v23jFVo5cQnIfFcoVDK2dcQ2BZe7cJMg9GrNyTU75Vi8IwJkiJ8WS4I8A6T1L55KdrfLs8KssKPTzepKmJnCmEOTTskokBtj07Hd3UqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=miJwN/bl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so260038f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 23:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762758490; x=1763363290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afi+lGH86ZvrucXscTjEx1ykkeQtiCdeX71RXwxok+s=;
        b=miJwN/bldKHaBenwJtiS19G3zs8X2T+xX5F3apdkdYPKJm9Fkfl/HSHX7SgV2LDol0
         ofCtn30ylfwn1jdxU3Y1/oCaEID6wXWSlmXHtUJILpv4jUxEwhMyNu4ZwZOgtfcKuETg
         La2l6IXMFe7GlxyQI6CczHzckCtXw5jKZWYYROVIWifgnuVf6+5njvT2yFQ50SsStFj9
         xNL0/h2X8c6muasOwBMv6WYyN4rvxGKAVkqublKtOPXiaIxPu5vdkokSbFnep/ty0qwL
         9dZ/kg8BgU6c/ra4iAoAQgC6I8Keg2ByloqizOGk8G1xL+svXg8js8eu3N/FfhCfLrzH
         Sk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762758490; x=1763363290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afi+lGH86ZvrucXscTjEx1ykkeQtiCdeX71RXwxok+s=;
        b=vG6uS1IQgclirKkPESe5CrEnQGxNL+IBBYW5Ihmd8QZX9Y5qNm4X+/SNpaKqh83Zsk
         2GFqqaBaPjBelvcJY80CNaLFM+fmKiY9mg8wrBX4T4RJMx4ho8Ya+lAoZxIMJK+D0cyC
         KznnF/0ju/ht6/lg9fMjaTh5n7VUw52Zfmo6qil3jDPqQQDP16KCo7j1svqjLPAFD+iq
         +fXuT5ewqZrXE4fDuPczjv83566LtvSQxjleyqpRCEM0vgi1XipGpXU8uKbgD+UH8a1a
         jJ0MY+952IG7Ggn9+JkkXmL1GPGRlO8qfURgG87Ez9Y3AkQE9oJDYu+UcC2mjpftySgl
         S5bg==
X-Forwarded-Encrypted: i=1; AJvYcCXChrujFxqPhDtKhhpNAWugCZeRE+JW4nZy5XBNHf6GXyySXrQL2kqnpK8vwgyZIu4B6dZ3z5Jai4IX7bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfwQbqmFTxJ2gu/i8b8CvNHjabWkEvohlW6Jvf0isPypxD3UxC
	CzuRqkxYdLPmhixWRpQkljk4f1jWyqsmIefFeVkAlTOY2ltgMTTX41cKn2ViJVwbL70=
X-Gm-Gg: ASbGncuz3sXyyDt1Zb5jH0f/hB7OoXg+sCoMEYnGw2JsoQNgw0W5VdGs+umJhzl7ouV
	ULCGN7MtiEDEcZt9aeD7XJ1S6eOcTFU45hOP+w/VQc41It/t5BAl3Kw0QPClFvAg6tH4ec3G89S
	zJRBXGqQonhPR/O0OdSCOES09QFlOs6oSB4YDfD5t/vF/B4EjILNW6HqyhSdpZ0FYVO7uKxwznc
	q22oalrCC5hgRrX2HImTHeAojWGEns1QFYYuZrpvDcgYvlITXzP0HkKIIoVPHLo2qcCQLKPPDqJ
	XZykY+Qlc/Egd44M0GpLVOsa/ek67h90csnXd6+KB3luiF+4OZvx0Ry3E+IPTfBTb4/iYNLSssg
	j13wiNuoFoVzZUQEciX1l+tqDlzCA98vPAj5yAGH1YyTwqR6iQZspo710yiXd4vY1WVFGI1oG6o
	A8sge/Mg==
X-Google-Smtp-Source: AGHT+IHnAG4TZtrzMcLkmLviBSjBeyVLT+MgLusc2bIAKEnPg4/mFzUaOQPWdmNrnp7GpHFAe9AMrw==
X-Received: by 2002:a05:6000:280b:b0:429:dde3:659d with SMTP id ffacd0b85a97d-42b2dc4a8c2mr3814529f8f.47.1762758490571;
        Sun, 09 Nov 2025 23:08:10 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm10639770f8f.16.2025.11.09.23.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 23:08:10 -0800 (PST)
Message-ID: <31d01667-e80e-423c-bdab-8d05831d575d@linaro.org>
Date: Mon, 10 Nov 2025 09:08:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
To: Sean Anderson <sean.anderson@linux.dev>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>, linux-mtd@lists.infradead.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
 <mafs0ecreontu.fsf@kernel.org>
 <4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
 <mafs05xcpo9sz.fsf@kernel.org>
 <26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
 <mafs0ikgnn07u.fsf@kernel.org>
 <d00d42ce-4262-4736-8c73-5d2544e86d33@linux.dev>
 <33cbbac1-c247-4644-b555-998eea6e8305@linaro.org>
 <92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


The locking tests look fine to me:

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Sean, if you care you can extend the documentation on how to test locking.
Also, you may drop the non SFDP data from the flash's static definition as
a follow up patch.


