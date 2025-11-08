Return-Path: <linux-kernel+bounces-891447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ADDC42AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F993B00AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971526CE0F;
	Sat,  8 Nov 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PKKQkwkj"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205825A630
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762596376; cv=none; b=qMadj32bnCOEgoP4tk+qqIkL02Y8EBIHSkOR22AcRAUcDn1Jdt84RQjGKpm/EIVbHKbLY0SkO6hVQCjZhjslyrF2OB8Q9x3Qv+zK1MmEt091/rFjUhUiHKjftD4x5dhYRlVeyYBSZBjKvbssHL249BIcKVbaSp5ZnEIx0j6Jk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762596376; c=relaxed/simple;
	bh=VAT68V4JAW7j3YsERRqYU0IbuX+/A0bGz5WwsQ6WMMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmYf7Bp4X/jNwH1MqauLB20+8xFlLqZrE+avPawM+lCGYYI2n2SFHNXUjNf7oSEcC9caUbirn5WAPjuAd0tAgWU0SwkG0uJxR61K152XKN3mxwD5fiZ065ImW0SP9yLDmkENBT1xoEV8xlrEvPx8Rfy1PMoL3HMTKTuDpq/VUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PKKQkwkj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775895d69cso7751145e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 02:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762596372; x=1763201172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RuDirgtJC0pc2QYVGZiTYLia1kGQp76vyqI+KUDhplM=;
        b=PKKQkwkjsamMcfKaRy0ZYRydIVNhet0MLP7rW3oD6STe7h84JUJP8xadhZzWnrNq+x
         wERNFO6xfuvdbqahMfrbvSxS+Ukq+/L5spx93KP/eJgd/2KeY7aJzSHY2TumM8ALgJaL
         EsgFmJ8GGkBnVqykA7QjXKeZ9wXTHA/HrCctuNtZUYiGmS0H/Z0YA6BPqk6qyCOGksno
         DyIb3vddpwp8uSAm2u2x9y4dPBzdsF/rISo+SX1J2BbXRc8M27yd4kxTL08YXRMmfAIx
         cxlByaeOkIjmTprh+GCeuFyEqeP8Bi0sJ6aJkLzlHwN+ArOW23wgr8C+kceuPsdr0FnH
         ibVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762596372; x=1763201172;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuDirgtJC0pc2QYVGZiTYLia1kGQp76vyqI+KUDhplM=;
        b=p0ArormiMvRhOuFfLOcVWCSl7cbDziK0IW/TnKM7fqjvjnNqS5JH2xJjnpC5SxyHro
         i9hBzKKe1gJjM1U5FoBWAHTBpb1YfGqwvPDf3x3HHjcMMdvrchfbHiS/Fvca7skrQ9S5
         FOxEEBrewFbGuAbkEXjlhQ33l8pZvqNCez8gpb27/vc0V8ovcmWC5o4yhN2KISw++v8G
         mTWVZbHpBvoUiyRhkXnPUjsDCPaWQSi4XYQwHLX8gFDKmt+cb3LcoKWGZ/S8tUo+VsbE
         SgHcp6AZLGZdtYx9QmMnHiXnVrdtYgQ9bA0CT/sOInVfu7gjdAl/tk6zV7aUyuvB1lQu
         lY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvpEpw0XF7SOaXOTrgkVIMVvxMQ7J+1617hdC3wfL47HHPQhI/dw58trhghfOv2A3a6lV3MI+IU1uTK3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJaXYfz2Kl5UbaVj8+qal+CZUcj171PpqMpDiuGU7N29Hov7m
	Ax5qjW3MDuI2pX/UNLDRDm6N+FGmonpwiNumAtv9WsWDu0LMbM6KRblH+U8lE9B6Fd4=
X-Gm-Gg: ASbGncujCTDXeu79EEwXTfBW2KkN6jRmbRKrbt8sKh1bKb/3AksxIHOi0ug1saAA3fL
	U9+zL84Jmtnm807zUmgK/jj50AOO/1JwGuyUh4eK2uOr2azjthJX+U+zfV53AOL6wB6khEVnseM
	yjPCf9M8gOdBTjAHG5sECqdnUmReL0q6hDcSgDAe4cJodWFHZ8wZF3XrqQypuV7Oqdc8jirU2H9
	3j4MeBhvTwHGUHbkrU2biWIV2oCFNSNpO/Pj5GE2aLKiPj17hED55LKm/Us3DVZai0L86/KAsx/
	sXL4Vlmd6QJkYTigBtcet/ZNN5rWezoqSfClLrZzJcSzfMl50m4C34s4UYgotmV3kR3EyR/mON4
	fQ/TbYX7CoWGlHaWOKHaiIs5QWrF6EP+P3FgXIKV0ozgQr1nXbEKx47HgukYWnZZpFWNqyJCz6y
	vSz3/R5fD3UoFLs3g6/5c=
X-Google-Smtp-Source: AGHT+IEwTvJbTnqOqFEBuH//I389Jc3uyJjik9sgRzeUh7VNXL0eHgm1ckrlDuEIpXgostqWX0J+ZQ==
X-Received: by 2002:a05:600c:1c02:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-4777325b7a4mr18135395e9.15.1762596369980;
        Sat, 08 Nov 2025 02:06:09 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd084d4sm123069375e9.14.2025.11.08.02.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 02:06:08 -0800 (PST)
Message-ID: <e250fc9e-5de9-47e2-8150-0319b2453fcb@tuxon.dev>
Date: Sat, 8 Nov 2025 12:06:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: lan966x: remove unused dt-bindings include
To: Robert Marko <robert.marko@sartura.hr>, mturquette@baylibre.com,
 sboyd@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr, benjamin.ryzman@canonical.com
References: <20250924202810.1641883-1-robert.marko@sartura.hr>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250924202810.1641883-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/25 23:27, Robert Marko wrote:
> In preparation for LAN969x support, all instances referring to defines in
> the LAN966x specific header were dropped, so its safe to drop its inclusion
> in the driver.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied to clk-microchip, thanks!


