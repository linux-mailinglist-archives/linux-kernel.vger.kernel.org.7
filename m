Return-Path: <linux-kernel+bounces-891261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD42C42470
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7B6A4E1E75
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F942652BD;
	Sat,  8 Nov 2025 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0ue/+k2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC941F0E25
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762567674; cv=none; b=TGBP+W0TQEby0ohUMhD9DAcFbkTXPbZKs0vhag6GSMMEvv+dn8HklZNf6/0DkE/Pg5h+SDi4K9WEE9TV/mcoV4ztq04Xn/wdJW0V9u4TohfAJrUCLyRJBezKdEtjOv2QkjpajvrlOgM6fuLtkF6dTqa7GofNCR0i0oIlIfwX7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762567674; c=relaxed/simple;
	bh=w7IVZG5+ETmBOF5WD40xjYX6T3fLGd7j8+I7YPMdZtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXbUoiejT1WsSZuWlGPlI4KsTUQsnl9bvdB08S97iBX6ziQsQvv+xWhkEINejRZFswiXlQTw9w4W7pTwBjy/wDvsIu4yOIFei2JatK4Uqljy0FEyh3H1MLk7wfKeuIY5NFSkBxU1bxwoKmIYDHB7Oc1NopoRHgdYtgRnPI3Ll8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0ue/+k2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-294fe7c2e69so14571805ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 18:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762567671; x=1763172471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejBbUJWKHb/e5O1CFHfEgiz70lDXqNLE4+cjjRbq+18=;
        b=A0ue/+k2YcRN2Noqy1YNmjG8lddkK8sw4Mwp56bvofuAITmMzeraDCq1WOXEmQRe8M
         lZ3NUCfQrm3Xe/eS+3jhF2uq8sxXcGgNwPo0P9QfSSQK+CrIf/nSUwkissVlv7hE0sP+
         xBX8e/4GlyZl1u+OWGZtnam9GyLW9h8QRBBg3H8Cd+TE9r+WBBkXRh1nCgFLIlCPYdNO
         pVw4W+BxqApeDtfaccsKM/rmcfpNafSVT3YFTqNQQ3EjuECaJj7qaSEiMbByPB6I79i7
         0G4H8OAfKB/yOmD36F786h27davFC7OJn6LjeKPYpT84ffn0acdXWQdw5g12TV2A49mf
         uhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762567671; x=1763172471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejBbUJWKHb/e5O1CFHfEgiz70lDXqNLE4+cjjRbq+18=;
        b=SiMqsk5GZd4+xBDgZb3ktF2FTH16z4xtpPxwKmCudwBoBFwv4w6qadCSxFkJ4khtJh
         ciGBeKrV16AeZ9L5oiNQfH1gHShkGcu2YaRISlD0Sh3N1iCAOe60OmShItqcB/oo9qwh
         qzvdsRG7G8zlKQiyIzuezH4ADxwnulQsUo7ktj8FZOdscn8QMAP9p6gpfThIbN2oHIY+
         05Ug2wO2CXBboa3AfTxdasFKiUa3POO1rkWFY8G2ieJF3NozzGinBLbw/pCEXXeXq6cH
         Px/2+2/kYeLbYiGuA7xMmZxJCFThjJ68IqJVH9tag4/cvTrLWeCQKy/zR/egJUT0d2Q1
         hNzg==
X-Forwarded-Encrypted: i=1; AJvYcCVrPravpfBFjHbWCDNLMjjW0Pyv4Q7XEyxaZwr6rfLlxM3qJeSjXt4exUKqrXDuZ6AR6DOPpXSCt3wWm1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5KNuhegUAZlCwttePBZXf9sUJD3RYDMwsgOO3Po1CDXrqEQK5
	TKLm3dOZmMa2F0tPUt4h5MMep49tazt5IZsLfq5yp/KX34yXrv/6X4eN
X-Gm-Gg: ASbGncsVjXiOvhvzpQq7yIlMhHwjo/GDeJV8kIr3ypVho8OJNMnj6/0msyJSS8srSIk
	jGSO0tgW3yWH0Az6C8LPLCJM89Ew/U4WzyBm47EB8vV9mjXAYlFtiNj1n8LtqeYGNquVcs+i5HB
	px3ot/lK15FoDRdKps4eh6EpK8Fb9fDttCSHL8sp/aOuJp6ivuRZnUum7zWd6JQWGUTj4maklsS
	1phZI+ggAZVbq+qR4FR83oY4bugx0Vl0TkWTldSoNY2ILBh3dm20KRY9eA2SGFL7uTKNpgTqJ9x
	1XhQghwSktQry872OZn7E3bWqfJKt6j0uwzAF4/m7HUgyeBIFC/vGLShH+uTPK/pu8KcU5SEETe
	e4xgbXJGfpngZkLhegyIAAUC5W3k0TE6AJxwsZ/2y7xxbQ6qZjgucmQ2fgXvLKG+kh6/vSpHH2a
	/y66EDgrsN6fYpDw9mp6RzTBaPzm6ez2r8W9DY3u7wsH5q/QU1ftqUgEDAkkNS
X-Google-Smtp-Source: AGHT+IEha2IWEMKociwQltleeD4d+aBEHKy+YULqL0FZO7PKpd6Z1rorWPfIyem0F5mxVcCafcdU8w==
X-Received: by 2002:a17:902:f601:b0:274:3db8:e755 with SMTP id d9443c01a7336-297e56d8dc3mr14123585ad.30.1762567671233;
        Fri, 07 Nov 2025 18:07:51 -0800 (PST)
Received: from [192.168.0.6] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2964f2a9716sm75349765ad.0.2025.11.07.18.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 18:07:50 -0800 (PST)
Message-ID: <e46094b8-911d-4838-8be0-1a085e04685f@gmail.com>
Date: Sat, 8 Nov 2025 11:07:46 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mtd: spi-nor: spansion: Add SMPT fixup for S25FS-S
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20251105-s25fs-s-smpt-fixup-v2-0-c0fbd0f05ce7@infineon.com>
 <mafs04ir5bynq.fsf@kernel.org>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <mafs04ir5bynq.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Pratyush,

On 11/8/2025 1:22 AM, Pratyush Yadav wrote:
> Hi Takahiro,
> 
> On Wed, Nov 05 2025, Takahiro Kuwano wrote:
> 
>> Suggest new series as the result of discussion in the thread:
>> https://patchwork.ozlabs.org/project/linux-mtd/patch/20240914220859.128540-1-marek.vasut+renesas@mailbox.org/
>>
>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Checkpatch complains on all 3 patches:
> 
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Takahiro Kuwano <tkuw584924@gmail.com>' != 'Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>'
> 
> Take a look at why your git-send-email didn't add the extra "From:" in the patch?
> 
Thanks for pointing out. I used 'b4 send' that time.
I will check the settings.

> For this patch series, is it okay if I change the author name to
> Takahiro Kuwano <Takahiro.Kuwano@infineon.com> on all patches?
> 
Yes, please.

Thanks,
Takahiro

> [...]
> 


