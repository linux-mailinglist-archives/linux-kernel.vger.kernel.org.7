Return-Path: <linux-kernel+bounces-812186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0106BB53433
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A8D1C869BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC353375BD;
	Thu, 11 Sep 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eHCBZkWZ"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA23314B7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598261; cv=none; b=t4kntGQq4AVoRSoxMAvZMf/HrfcciiDF8j4TaqeE0Ely0epsvtztn2BhWcTbDov/hPSUwvdWcbIPdElaXh3xuVNt6fxYicNvIGe9/YYVgfyPXCI0ZO0HVEOllV2dOxGoqBrqrHSG/+1/8kbYrZDPiB/MYAgwB7HD6xARd0HtDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598261; c=relaxed/simple;
	bh=BgWTKfBKwv1gdZW9TeUwhiLjN7/KNn7CoOORzE/zT2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXs6IVARfvAJcC1wjQzLgQVxXXvix9r8qEamu2NMz+YqsPRzvFFYeYjeSYz+bv2/4rz0ajQT+/1fkCxqfrInZ+v207KaiDP/BT/HRdbDtCRb35r3eoEZ1k8Y9lYWuXRFxr2t1DcFx8VprENkllPOrQ11q0TreDrTUQamihrSg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eHCBZkWZ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61bd4a3f39cso173876eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757598258; x=1758203058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCstrsfwRbW6aW0tEip/c6cZxF8+5Njpu6/Zhcqq+6I=;
        b=eHCBZkWZC6S/BDWWfP+SRYOjHnppsMldn6FOlmVYHtG8R9WXAESKXHlerXsSWJgZiC
         zGG/3MC7O5SQ3te7i0ZXjMMV9t/BtDpT2I+Ru/ODm+O4IBmgXUFwurHwH8rlfLcm5maC
         RlRpXWSG6mVt+keIJrKoktz2/ivvdf2l+tcmVxLSPsGZpUtE6cdIbmnAAWS4vonQ0I4c
         31FiYIyYQTxzfGwnLaQE1XALZhTo/UX6J2Ht6/RZzGHH4W/K2jppAWto+ndxJkWnOXoN
         tTj+6P74A7GI8yigDrHBc7zcCjHVErkrG54NCV12aLDFouSQ8F3COxisgYgOQsDpwiw/
         Ckzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598258; x=1758203058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCstrsfwRbW6aW0tEip/c6cZxF8+5Njpu6/Zhcqq+6I=;
        b=oxW/EalIEULTgH096aI+53bA9pRc83u8n5iUcgWUT1PUx+aIF6cbPzghp9FygsdML8
         oLE6P4e+qn0g6BUUF6nO+62o1F4uOLqb50lQHhhPeuBf1OMeXvapn/i2+9cLJuDKeu1t
         B3cCNVasfOFpVO4l407UK6nbdXXEpiHXar6O10kcD5eWAI7qNbBTA/V8vfmBCUZdMdsg
         J82ikf0v6oq8hOxNtBM5Si3cBl5FG8Llh+ZNcE4RAlAthNAJSqmEuYbMrKiFJHKEt/pr
         t9fd0Jq32/ZX6IL4Aal1W1ws9P0X9gAEUA4a3t/lh4Q+eWmljagvElIpBuKV16OshgI2
         3T5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo9Wh21zs45D0qEqVk4ow5u1l4FoK2brF0LmIJyCHuffjO/Grdseuuyo6fSE/1tRgQSI27kU/vCjct1zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD25T2zr5oQE2eO36EzZ5yKNmHz1D2PK+Q/HZ7Osuwe+3J3EK+
	6m7+sJMw8eo9fFPm90rZncXkDzz5Dv4KHQB00Yp4Wp54j8gExGGpWJT4OIi3wPWpB7E=
X-Gm-Gg: ASbGnctuROTUAd7CNb1imEk+jG1oq7FpSdJtrifANxrDGZjJdVlGRPePCe3hgNcK0LL
	6bSNgiJTRufgVpzZ2JhnasCaMQ/3Hpkw0wN6jOB2ij6pQJ5UJCSJyRugBY8FOJIsNJ07TfXzrvI
	26dMfGYiOyBxYiE6vKt3MYauDHxmmuMNDJMmjg5+28uoiVYg4VhDXvFNNuX5HB1sKpUzznbW2RV
	9vI8unUI6coYofCpq5jY5Ap3GWgfd5z8wzovPLGTXZ6kTqr1NfEVHfAC3aZg6n2F8Q+fpjto4sF
	w71qdxw+s8pTosJCnWWHz/JTOobN12RvhXg49Xz9X69PMphTFrs+b3o+zPlh6FeeQElSlqXqYrX
	c14cWPuVN6x2CNCWxqcISO1xudQFNhuy2CPRqGLrUlQjjeYYjXiliDlAN22WupvZSIendK+XMkf
	U=
X-Google-Smtp-Source: AGHT+IEPP1d7GSlxoHGdnXD8SRk9+hawJ53fqwqLIpfGqR7eWm2LIzdvyvnCGJkNaVEwetQklDMy/g==
X-Received: by 2002:a05:6870:a982:b0:321:8f88:a3c2 with SMTP id 586e51a60fabf-32262d776d6mr10097192fac.14.1757598257793;
        Thu, 11 Sep 2025 06:44:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524bd8359esm351076a34.32.2025.09.11.06.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:44:17 -0700 (PDT)
Message-ID: <719e510e-1032-47cf-9a75-82c36de732f4@baylibre.com>
Date: Thu, 11 Sep 2025 08:44:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during init
 stage
To: Petre Rodan <petre.rodan@subdimension.ro>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno S?? <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
 <a10a2f6d-6cb7-4922-b505-dc6994f0415f@kernel.org> <aMLCWFatVkePTxCa@sunspire>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aMLCWFatVkePTxCa@sunspire>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 7:36 AM, Petre Rodan wrote:
> 

...

> Just for my curiosity, do reviewers apply the patches one by one to (a branch of)
> the tree itself or do they provide feedback directly based on the diffs?
> 

I think most reviewers are like me and only are looking at the diff in the
email. It would take too much time to apply every single patch I look at. So
I only do that in very rare cases when I have a special interest in a patch.

