Return-Path: <linux-kernel+bounces-835896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A273BBA847D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0A616D3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6D12C0F95;
	Mon, 29 Sep 2025 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlBc16oY"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5962C0287
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131846; cv=none; b=bI2a7AJur4g8fam3z/+RQArESEdjgea77og/ar8KJpKwz8oyFrP2yWQzRLkABkHOmH6awv7f3spsrB2QNwPHOCtCrjoKAnm+ub5Uq3/V9TxtOSdZuGPwXNOD6RJ1X9fQW/RwWVbJ4i+O5TiwmRdoyRAkMAYfuO0+7KGbkDA4QAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131846; c=relaxed/simple;
	bh=losOm9kNhx8UB0MkS+d+hChRheC7eo4iF79p3q3CMLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCsLWC1GocROPi1Ole7Poy9+U0e+fp6ISSS6UgH9gewjcV9xqZk0TW6AKglWRhclz4hexwLeguaVpnQ2GqzrekhOkkgTuGN4jfIQa0YtvVK50YnvsIbjXXSnsVQf56COVhf5EyhtpgC3fO1u/zw5LCjrOKutiy5Q2npABV5MbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlBc16oY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b57bffc0248so3353060a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759131845; x=1759736645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IugYQww6ZMP7fZxYkyvyMGRoB8H1RfKni966hm3Oic=;
        b=IlBc16oYE6ITESlb78iByhRa+iXx161iOZQsGYoWdNGq5vCrOBHvmAWAOj40HekT5D
         /i08oXYmFLnILbwzteK2NM9HBxN+YTv7JLV5ClpVdJHL7OQ+6etWYu2pb1DqSvchZWph
         MfcUuBNXxNkaNryc530Yfdu6layxxPjLV2cxkJkpPWupHYvWus+9jL2QKAzpdqz2zPDf
         pe8/sKAGKUPePLTD0xtpSiBnaKkyssrIJIBruhg1VItW2OkE/YociWa84pMsrYRZvJJ4
         vFSsXbOHyITYrV87e1e90FlAh42DfB7U47UhuJTMi84/ou8IhO7TfWpM6oKnVr7VA/ml
         Esdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759131845; x=1759736645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IugYQww6ZMP7fZxYkyvyMGRoB8H1RfKni966hm3Oic=;
        b=HPjFyPw188zgSG1X7d26R5/MxXOy/SvN4kLxAiA17SEFVbXTiYivLhd7kv6lZI5P09
         mLy8cesiIjZiNJowiOZ4gI1i3+66m4HIzVDVzAJmaxfR0z5WU+sPy49/MvCUKfk8Dk/K
         ern0ZXCWS3I0oWgfhRrZJCxlTfRtrjwGT9LZZS7cV61hf4+LTS+l9EicuTRbD2xEXzbt
         PlW5p6jXWKgIhFCleukotTp18O4dQ1BkL3nBRgtCzuwvHErCuXUPIL9uqxaNSr7mgmYb
         HVaSMR8opbU5+UoTZrfxTOhC2qxg+8VUiwybgIxaH2IYZxR71AOudjfeM1BkObMAVkN3
         YNCg==
X-Forwarded-Encrypted: i=1; AJvYcCWaa1vqkhE1yqKG71Pn9PaSsX4pfZ5UurjbbICkcqe5EQdirJgZhmOLpq33P31nNG6b9CYv+EcxK+DaS7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YztacT//GqQmD2VL/FlA7wWHgcYc/Az2/TILjKe5tgYYLc+arH9
	buk/clMDqRtopf+I1MTaf6Eer8+TyPK6jbWGcaOnmt9O/okkhTCSkBe/
X-Gm-Gg: ASbGnctKuTvsT8GBDOqHIoQKGGmERTu7Nm4ngtEMNSzkyTY3kBxgTr4dXAyG+i8C68C
	6AQJZRy/DnF9WYwFuaZdZ6BI/9NUm1nne/211mWEWqYlNhSjZdbSWV+Wc/tASw6maJIZ5a3GHpX
	w8jiMYlFNS0b599Qinlamm/HAL2J2wgUFrPQWpkhk+/TN8fat7p6cudzkJDpoCbpj2PenLCQ7gF
	gPNcv5+qXLW5O1gJV6Xp3nUUaQvXx2i/LoX1Of9oXUDzAloAQqA/eTcn9oNZbdkgrAsSFa+Trra
	YZBXojNZsLgQ5bh3o1iGoethyZBx7s86Y1I9IXz7jWB54uzPyN9B4Y4Uw1NMGcPJKym5TAdxopS
	P6OXVMoO0gZZ7B+78pHfpGJxrRQ3vRS9FJ379J2Qh5pApzTebZdNLAxdIG9T9NLN387MW+GKLQC
	fS
X-Google-Smtp-Source: AGHT+IGYbzLtndPlp4Q3FPkBFfn1YLlMmp9JRJofGAotrhQINUZyvBL0AAPnW2NjXrzXu64Iv6JAsg==
X-Received: by 2002:a17:902:e84b:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-27ed7222952mr159612065ad.29.1759131844132;
        Mon, 29 Sep 2025 00:44:04 -0700 (PDT)
Received: from [192.168.68.63] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3fe7sm123321985ad.7.2025.09.29.00.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 00:44:03 -0700 (PDT)
Message-ID: <b01ed528-8b29-4a6a-bdff-88f2e3b5dd2e@gmail.com>
Date: Mon, 29 Sep 2025 00:44:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Upstreaming Pinephone Pro Patches
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ondrej Jirman <megi@xff.cz>, "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
 <53eabe34a310ea9c74315fa09a604e4a@manjaro.org>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <53eabe34a310ea9c74315fa09a604e4a@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,


> Thanks for submitting these patches.  However, please expand the patch
> descriptions, because their current forms are too terse and, as such,
> simply not acceptable.  This applies to all patches in this series.

Gotcha, will do! I've added the testing that I did. From 
https://docs.kernel.org/process/submitting-patches.html

 > The text should be written in such detail so that when read weeks, 
months or even years later, it can give the reader the needed details to 
grasp the reasoning for why the patch was created.

It felt like saying more than "adding x sensor" seemed like adding fluff 
to me, so that is why I kept it short. Let me know if there is something 
else I should add beside the tests I have done.


> I'm also under impression that you're submitting these patches upstream
> blindly and without researching the rules that apply well enough, which
> may not be the best possible approach.

Sorry! I've read https://docs.kernel.org/process/submitting-patches.html 
a bunch of times during the years I have contributed to the Linux kernel 
and inevitably forget something. Please feel free to tell me what I've 
done wrong! I've corrected my mistakes in v4 (and undoubtedly probably 
introduced more, but feel free to tell me that ;) )


>
> Finally, please refrain yourself from sending multiple versions of the
> same patch series in the same day.  Doing so makes reviewing the patches
> unnecessarily hard. 

Sorry about that once again! I'm mostly a hobbyist that loves working on 
Linux over the weekend. I wanted to get correct my mistakes so that I 
can get reviews over the week. I wish lkml used a forge, so I didn't 
have to spam you, but I digress. I will keep this in mind moving forward.


Rudraksha


