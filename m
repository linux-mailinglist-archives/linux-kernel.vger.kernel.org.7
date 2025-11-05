Return-Path: <linux-kernel+bounces-886896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B91C36D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2476438C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1533BBD6;
	Wed,  5 Nov 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPNjt3AB"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1033A02B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359472; cv=none; b=RJ8CC4gOXjbZBHMPvAkTOla9qHiJVbYgWXqFvZ2NAuf7r+qebt+dzwai96zGIFJFQBk5wlVRSfD9xcQCpvTqzCMvzAFLj0tzsZO0aV5oqsZHAeUazJ0Xb70SWZLQIpA2Rbveu44P3cxT0wLi4QZO6APOkar4bBtiAZUdHh+b64A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359472; c=relaxed/simple;
	bh=PhBGQ6nFBF+atfYcqmQvtOjXbckgxH+TUDCypzrRKAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aiw7Pacx5XtuVvgLitzxTLs8FiACz5UikOeS2KamTlaiXGkXYCIxyh/wJjgOBCXhmcN8XdXwlHwQZFjtZiSGqYKNlJ3eC3IeErbuoEcNZnH0mG0X84NmToRdZQXK4AT1SSaH5u3HFsh9lU0r4M795b358LpF3V7H9V7tyiIaYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HPNjt3AB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so9381942a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762359469; x=1762964269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhBGQ6nFBF+atfYcqmQvtOjXbckgxH+TUDCypzrRKAI=;
        b=HPNjt3ABeTNFI/TyciEKXRK35ZezkC3AsGqlDo6n75FNr3SyyPVc97QA+uQzfVES/0
         3blDn5Od4rYllVH1bpYnK9juCfJvOXi2+hypWX2VS12sFJJSu4n3In/x+eGhVFQG4Zk3
         lw7W0/YVZaRF5NNV8HZN+2whZJ8b0JIMbZSLTOJxL4h0F2ofa3twxAiiIiNbr/1E9WmX
         aAH/Uy2ZHuixcfjRjfUkWaVb/eoX01aX5Rirc704MOdKHc1IfoFIJys9KPpFdns+q4zl
         2A85fe2eNRdo85LHvtR0xSmjoqQZ/piAHJw+zY1pnXn32vNmDglxo5Hn9XU+8mscfdWu
         tNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359469; x=1762964269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhBGQ6nFBF+atfYcqmQvtOjXbckgxH+TUDCypzrRKAI=;
        b=Ipf0UCdEsILwO5R+0molaguAtP0DJu08CWY1wsy1v6kuaa6mGpKNRheUDeREvZjaBP
         +Ltgi6GI18NSNv5BpMn8skSRjo+Sky9cFJT+qQIfycBtcRj7CMKzz1FVfQjfiN+MBEoK
         YPjOdJeka+cB3V7N/Py6sdZSqznt+RwCyrg/e/Y4CsduO+sW09zNzAvsG6COPTOOqjUt
         SMoXw7Iz64S3RclSeCwIcs7vwkvYPybXtN9OEsHMIsWkjV7o6AwC2IBUQwqivI6GpEP+
         3/8hSdC74XtChmtkuwSnQmqKEz8cJWDzaZiR+bpConwFCSPFpTWR2iuGqsXyheeMWhcp
         6UFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN3lkC8OtAp/uSFGIHyQe7dtg5Z+iqcYmZVD5nsHSVt614ddYcfdkEGaLxxzgkMZe7ynSUGl6X7dwqhPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKHRhDfltld+rkSxBA7Yg8L6eppiog0gL4ZPX9mIAjoI02z2Bp
	SC6UiBekg/ynXU0T/yoOY+P0ZX6mrHZ9KUNb7sTRIMyl0ym41N6akUo3tQEWdDrSmGg=
X-Gm-Gg: ASbGncuUE/tw4h3Qpn4wLJM0LVDI2HinI1a/Da0H4sq4EyysJ1KBsJQ7+DiUsu1xhQJ
	V0JVeY+I8h/Bt7hkuUbXziWESbYjJh2ytJwvjnzJsJbq1gAnvMhhiPn538NScxwN7aacp9/YaLb
	jrSCqH8mEWLE8XjgUmUHalsE919FSPGExCU8GmVwZXaiRk/HGZzAGnUbGmI03KURnG76/S6NCEU
	/6k+YTy+paGkVtxTIbDIsIMbukQMaUzcelb0/hFbp/lrKw6vSoQMXZCk+vINgkPS3DyMge6PGL3
	BETb0j5zxlAIBVhhxDz3rYSQ7ZO0r9d+vQfYMU2ES8HObsyJbHjkiwpJihctGj+9WLJDGh3E2w7
	AZtp7QlV7WbrM5wVz3uGJlYHAY33aXK9ytH2mSR/N0wghj5r12fJZmT+54V8GQ4kMd6hivDWvP1
	AJZ6Delr5H3Hh4mhwKmdENXSg=
X-Google-Smtp-Source: AGHT+IFe9VgZeBsm/n9mopNlUCpQdXSC+eyg2Nz3OAP18FTVxYUDNKqmICDXSKw1lMgKMLixqXfVow==
X-Received: by 2002:a05:6402:51d1:b0:640:c3c4:45f3 with SMTP id 4fb4d7f45d1cf-6410588dba0mr3398799a12.6.1762359469142;
        Wed, 05 Nov 2025 08:17:49 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a5cd09sm4921331a12.20.2025.11.05.08.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:17:48 -0800 (PST)
Message-ID: <7b10d3f9-40fe-402e-996e-81c6684c20a0@linaro.org>
Date: Wed, 5 Nov 2025 17:17:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/28] mtd: spinand: Create an array of operation
 templates
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-9-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-9-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I like it!

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

