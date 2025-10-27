Return-Path: <linux-kernel+bounces-872791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86968C120B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18FC7503894
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533DE32D450;
	Mon, 27 Oct 2025 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="ZlLxUQbw"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0B32E124
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607600; cv=none; b=Fa0rLIhErfvmxoPORfN7UOBYyFfV9Bf8E7+ZiZbcqRRwt1vSEM2W3UJOqc4i6IdsrhNjgqeV8zWXr8TDf5/1Pjtuo56XMYW7omy5/q9CPSrjuCZwGcTO+xCG7y+DtCRJm1Ukj/Ljd9mWMm1NEttFO5nmuFImcO3vMhHUMjEZUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607600; c=relaxed/simple;
	bh=Nbr5JRXmrsBLv/PGndUKfdr7dz6K8kLXCFBOlT6YKXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vh90VQjtxemfJZWGGonFWouN2jqigzn6z54JW7wH4WAGSAE8nImt+GdWBDF9sv2X/d4AxOmwly6+Qu/rg2tLpQyWNFyRTXsJgh33HzBdz3u9fWUMdF6vR23BzNBnbEJkb9H/o302TVKLeeEmrKduI5HzfATOpTSca+U+xM4j5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=ZlLxUQbw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-430d08d56caso22892835ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761607598; x=1762212398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iikffhOT1WMi+y0dl8K7FDqmN86CXPbZoc1p22Fu0gk=;
        b=ZlLxUQbwpTb8731TUgpoOkmMxZCfqef3isSGfOv5QSDgnoMYCxUlMCbbKBh1koLiW5
         FJr0ttmfBI8YJBlpqMGS2IcCa+6sxe5XEVeZ1yG11XRJuUxJWwg25agU2rsufC1fkI+b
         F7JcdNsILAxvpyb/IbUzfo64haQbBLoDYLnapY9b5K4CRr/6qfPTeh3eP/iUbU/hHb7h
         FvnvVEXpbcyiDF4yzpMJbVs+KxVCyEAORWQpbgKN0mOCYVbiDAXoPRKBwYLcfcC4hF/R
         OA8Yc2FBKqnV0IFl0uFxtTw5yjsf7KWkcSGI1SH4XS0dgVkMMxAUiRbbUnJpI4yfy9/w
         wXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607598; x=1762212398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iikffhOT1WMi+y0dl8K7FDqmN86CXPbZoc1p22Fu0gk=;
        b=p5iS046Kkv+OHkbNBjfLMOivy6j3vtT+D5WRK/iuuJDMiuBwi5AYk6N1ONnm0YcfjZ
         1Ku1541f72Dc0GbwXYoN9BlnyiPUCMCijXt7hKCxkx/bV9iXXvA7GtwZTdi0heHejfLQ
         WLMKsI3gsxWzYlfYZ7KRyCc3CH4ZjfhkfdE6ahBLnKTf+pdaUb1UWVD3i6hDnR+nyoTa
         PGOtDAxNXS/+w3x2bgjtTRyWg/m+pVib7EQGe7WEJalmCaiEQ7FG4bPWYPnXq9Z+0QWk
         hdOijNaDFA3wPDzMvlIjgb7lYhM2ZQnUl4dRD63FVRJxGfxjMRc5Fb47nC4PhkBIPj5B
         mw6g==
X-Forwarded-Encrypted: i=1; AJvYcCVOUDw7jewIri5zZorkdcTLN5FGKmC36HataTN4Mn0fHTTQtCbSgGP8wVgUJcyv0xiNqNCl4b8xT5zVZAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJJXgGsCXda8NP12F32XZbmSoHss/jXSgZmvF8ENCpOXYFdP8
	SF4J+ZxyF0w8XWPcG6+5+uJsR4PX/ZiNpTBoGOk0DUXxiAt+Yqf8ANQWoCIXsQn4aAw=
X-Gm-Gg: ASbGnctS4GXiDZxEaIprePm/hM6V9PEXlmO2cs64Ow/y6g1qICQRtiCo2kuJOY9RdPe
	q2RLo1W1zReuk2wBbWwSyq2OkTC0yIN+ECMiHymcDejcOJi491igUKFNyMltXjOQDEQWmvn9OmB
	2BSDRemHyx6SZA5IvzgLGWRgRKtlXyMMhyVYz7SHaxlCX3wn4UiONPQ3mqn7LtHOu1AejdkhyZe
	/DtC054xfH39wl8zmH3Bs61aAz5yazI4YrSyUPcp7ONehK+ELV3orfDJe2Q+9R/lTG4TAVBYxyR
	CsRvrL5iE7ZyPA5WFAOkeGxo4l8+pUq48dLf4NDsgvmn7PVG1tAe2IZZw/x//SVb/tkX+4+1No7
	QWsa7AYVVXxGWfQ9qXEGPtRhQLX49YzP5ckenIxqENUV/il+R7gscZWOhLgtxmvc5pBzlqX+49q
	u7EmwcoallxZD1Uqk=
X-Google-Smtp-Source: AGHT+IF5tkBwJGXPq1ayP4IuAEH9VPpB7/PafjKE6njHLWA5SWNWEajU2jWwAJH4Gs9Tr8tZJmXM+Q==
X-Received: by 2002:a05:6e02:b47:b0:431:d7da:ee5d with SMTP id e9e14a558f8ab-4320f7bbd9emr25705695ab.9.1761607598127;
        Mon, 27 Oct 2025 16:26:38 -0700 (PDT)
Received: from [192.168.5.72] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f688c085sm35588285ab.26.2025.10.27.16.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 16:26:36 -0700 (PDT)
Message-ID: <16a5f83b-c2f7-42ef-9685-38fbfd45c207@sladewatkins.com>
Date: Mon, 27 Oct 2025 19:26:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/123] 5.15.196-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183446.381986645@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183446.381986645@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2025 2:34 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

5.15.196-rc1 built and run on x86_64 test system with no errors or 
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Slade

