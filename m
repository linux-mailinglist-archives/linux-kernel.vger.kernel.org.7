Return-Path: <linux-kernel+bounces-894363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21FEC49D92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E793A7A97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798EB78F20;
	Tue, 11 Nov 2025 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM3gqAMu"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8817E4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820255; cv=none; b=pkWlKdjWd2cqHfvjEAek1NDiLMiOoWeLOK3UCJnQanQOCXVxOLgJq4dqEH4nx2oRhvjyijpYCvWXSc7+eR0m+xF/OwLfnhBfkFK/wqlSD7ZXbCufd8b/QiS1DjOFzaDezwXSd8gbQhUFJ5LQ60yQ4oMDZbGorkM/LWRm6pGsGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820255; c=relaxed/simple;
	bh=VYeamISYihInGN5Kw3V68079a/bLAI4s8drrIMsjg5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKQNPptCeA2cYPgMKYqEKzwUU4URDDu8aI9fTxripwgWDrrjxycZfXZCCpN6A5Nk923NB92c68A6UbDke70U4c7h1uaO3NHRK8TYb2+ldvZYZ7y5F4fvR47A/0WRih93kc5/z5soHJm+YlaVwwWWeUa6yTE3yvaLzYzeyn63ChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM3gqAMu; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-94861514a5cso353320439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762820253; x=1763425053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Q8HKQ4KcnH36XoiAPXuxGl+urZnJV8rIP1Qwq36EqA=;
        b=mM3gqAMuXAJcviJgnGhan0MRYneIL9TgI5l8n9QgvqJip0IafEfGkdh6MwvzcKZmc5
         Y0BlHs2CS1XPTCbXoiHY7lGFXqbwp4ViaVrINdwcgom2eTABe9Tt1wqstsWj9LE5GF+v
         TfP/y38N0sBoh1QtMCVAKsfGqYKS/5ito+BKuiONmeIYOHogwZMQSKgpKSzG/mN6oT82
         a84KFSBxLd4ZLZvQ0qmunNtZAD923RoZWsK/16f1813TywONWkRANctF6FBOCA1yJHIu
         1VuE/JT4nm6zpf2aWn7r5aT+thXb/KtEFoSORfj1MPHiKRb28pYum6pstVBMgd2zlv06
         ufIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762820253; x=1763425053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Q8HKQ4KcnH36XoiAPXuxGl+urZnJV8rIP1Qwq36EqA=;
        b=NFMgViSjKcBt1R3EMKhJ6b722XIlyuQD3vnWYIgfhfYfHaG+wfdB+HiWDVI/Vsc2Qw
         +4GYceTCkQ0CvMaHFh1oPhS4JOvNU9lbPEIcEWzIJXqC3oJASrKTSbXOn1hG6X3TXdaa
         UHKBGHB/6Q7se8c0V5v1EeVMwPdZCnmRrecAHAuzA5f5JJoKArvUeuu2AiJ8oY1ZnkqL
         ShJmeiKU1F9e9eikDJbVJsaz9PVCm2dS9Wch5XfEk6Ke8XYt+72nLMkDE7ENO5TTs3PU
         2paEOmQ3/p19Dcl/moW4rE68kbh/BIjJqRMGtHXZ+XEax7G9FOzTvItsJL2UqJb+4u8O
         u/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz5Y66LKSWxi6Ha6636C+3IDpJ5KbXT8/KWjsZ4YhiDORlj+8j+rHmNhGp5X302vRO7APDEJoM8DGGEIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAw71rPfOtLCvd6YvJsYiJry4llPOOHMNnb33gX3HePQe46SWZ
	bIWeysonvKXGcKjoUJkwbS1wpDUdPqCY5wFWLnLtk+UDYP8WDqY/QvZP
X-Gm-Gg: ASbGncveQYYB73+hYDW2qq5yNYkecXmUrlJTd7pLwa9WxfhqpU4xmfOIisHz5Qvg4bu
	Ty20S/+acDrp7iZ3YnTXZACk5koZbAlJNGJrvfjm8cyip3mMmhL5Gd04uXR1UBfaEZY4NlSJCv7
	jripaXL8MI9znB36Nf5d5MLSRozEHLkXKg6qFdFjtgQ2Vt0lK1tU/1rMLEc/5YLAkSmrvQy0o3m
	Z1YtXo/ty60wU35NTzQYegogRKmtet1wC7HUKJcvDB3+xTBpbvB8aqadQmN3xx0/XpQzMKS2h0/
	jsilG4zY9ruzn1k3WeNq+gvirYMGlY9WSsCoHNphwIscrTNG9uo+GYfnxHigtatbcBmQARQ1dMn
	H4SQWMhEcMfwNKg4OWK+KGKQXol3nzebzIiv9/7rzz971g8RzzWxCqxgGxtsV1yHliuqF5+Rmyw
	7wZl6z2mOFphyNcdPOwGzm4TsWD88SRt0nNW+wF7FZJkNIWoLGuJs=
X-Google-Smtp-Source: AGHT+IEAm+mJm6K/xigqu97Kf9Pb7DwxatHpmYK1k/IstJxUHVyghC6X6TBmTN8zYaB+T4/gOtOTNw==
X-Received: by 2002:a05:6602:6412:b0:948:5f42:32a1 with SMTP id ca18e2360f4ac-94895f8ea61mr1547811039f.5.1762820253527;
        Mon, 10 Nov 2025 16:17:33 -0800 (PST)
Received: from [100.64.0.17] (c-68-55-107-1.hsd1.mi.comcast.net. [68.55.107.1])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b746923f26sm5588519173.38.2025.11.10.16.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 16:17:33 -0800 (PST)
Message-ID: <13627c6c-f428-4520-b0d4-32fca1e7a2a0@gmail.com>
Date: Mon, 10 Nov 2025 19:17:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use static ids for ACP platform devs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, boyuan.zhang@amd.com
References: <20250325210517.2097188-1-bradynorander@gmail.com>
 <CADnq5_MNBUY=jWbnq-gZQ_4_M_sBJGAgMD0bj2cMdnkoU9G=HA@mail.gmail.com>
 <9ab05b38-6f77-4b0b-8a1b-8314e2873047@gmail.com>
 <CADnq5_No+w+tco9j35GBM3+CYBTo018eLwWec278d3VBJHPQxw@mail.gmail.com>
Content-Language: en-US
From: Brady Norander <bradynorander@gmail.com>
In-Reply-To: <CADnq5_No+w+tco9j35GBM3+CYBTo018eLwWec278d3VBJHPQxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/25 14:14, Alex Deucher wrote:
> On Tue, Mar 25, 2025 at 7:11 PM Brady Norander <bradynorander@gmail.com> wrote:
>>
>> On 3/25/25 6:12 PM, Alex Deucher wrote:
>>>
>>> While you are at it, can you take a look at
>>> drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c and
>>> drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c as well?
>>>
>>> Alex
>>
>> I think it makes more sense to handle that in a separate patch as it is
>> an unrelated ip block.
> 
> Sure. Can you send a patch to fix those up as well if needed?
> 
> Alex

I don't know if that driver needs this, and I also don't have that 
hardware to test it. If that driver needs this fix, then this can be 
revisited but I don't think it should block this patch being merged now.

