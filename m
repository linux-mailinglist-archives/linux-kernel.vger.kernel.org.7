Return-Path: <linux-kernel+bounces-845453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A369BC5002
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B20840360D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD6C25FA29;
	Wed,  8 Oct 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrEsVf5F"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36822576E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927998; cv=none; b=TXvq7bkOjr8C1Q0Jmg9YVtxPWeBVWNVxUisPfehNuQP44VT0JA/isc6QCSMwIzlPjXPPZZwgjusW0HneK7ifuScgTGcrNbXPJUBMeUW8w6JBrjFU642ezKqVuojuxlTkIwdNjQ1L+UqwJ9cIEw4hAv4CIcD7YehRKUMg5SnCxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927998; c=relaxed/simple;
	bh=8khQcROEcI+OrwAyWGNhme7B5/GLQwSkR2ZSgIIpX1M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=In+zF9buI+la/lETchsmDm/n8AlbwUoHmzozeu07Psb7KGE3b3XdaahCmM0KriLkvlBXF0OEsIkrY5nxlZm0ve65TiAK6ZR1NnjZ1d1wtZP/UajGRCyXrz/NMc3exn3aSHoOzx1kbaEarPyOVrhs3Ctj4eIqBAiRQJtU4jewgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrEsVf5F; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-36639c30bb7so62768441fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759927995; x=1760532795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8khQcROEcI+OrwAyWGNhme7B5/GLQwSkR2ZSgIIpX1M=;
        b=jrEsVf5FQum+4ZRet/MSKsUpABnzua2qS4/p44yAI6Q5FUbwCO1NbQb4FBlu9r4b3I
         up8vBtgm+1cq25Sr/x5wnU/wvj/+Ed6Rad8iYMp6K7lu4mK4fiZhTVNbH08IOjPZ/zFA
         WpT77Zo30tSlkPFXqHWh/aEPSrq91nOST2y9mTMhZGa+2HCYNLM0IFL97mKjIOY2Vvzt
         dv4SEu7Aq1uzwrz3WE9fWWKwZmEwn4/pRreeKWk4JuwiLWTLuQ1y8VekdsLtm1jPYFkA
         xDFCgi7XR7OsdaQYWqdaxKrOjUId30Er+grZ8m0RwX1bLWvJRIjiScCMwHrn5v4kxMqc
         OiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927995; x=1760532795;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8khQcROEcI+OrwAyWGNhme7B5/GLQwSkR2ZSgIIpX1M=;
        b=qJZhX3bOAym+dY24tOLw9jFWlpukRD5GndwM2FSw8OlJYuU43C/RnIlXj+jICYpnjt
         bdRoa1ArFRavIYbwXJ26xZlrld2CANAOeq0fYZRy7HjW+9uQ5t6INzddgiidEfiLYfK+
         DZA1vmekWJGb7SMilRsIlXVpiUq/cU06NHpFhQGZ+x0qHA8xLUnXZY2ot3er5TtaYSHQ
         MmQc79hANYeZAwaVNO/pap/b6+Jmagdb9br2gnaDi9W/DFDk86HM0oF2oDEFoS/g7mui
         dguV2SKVyYNpuZH+6QxHIE2wIt01MBF6vPU7GwTMHhz/5xWjGJM0Sh0E8jCsFGCIOtvB
         4smA==
X-Gm-Message-State: AOJu0Yw/SShfR8kWJWCJ+CxeEQ9wv4Dq/ZWwIk2oHULow681tdVHUYwW
	nuHNz97u8Qm5tmVEIrWWJ1x+Zh9fcVfItCBqFnLfXugUrijW6XqHo8wWih0J8g==
X-Gm-Gg: ASbGncutKxCMxRHv/3hWS3teVzpNzOrX5tTbaRMLCiWqIG3UB5WKjl3XAsg2NJg6gBw
	kuHPXgeiH80n+U3mg3HO0lfTt4kaSPFarxFg8XxYgDy4ikPE4bE7+z0RZhqg8JcaGE5riOOJll+
	PrDyC5cH+ixxy1yXCJEGUeiZ9tLH5NhOY6wneBx37dsLoppwMNPbAhd+hb9DDGy1Ik3+WjXkEad
	e/TwJabTKneDPUupvHWECkpjMf/O9abSwDvLZfFMJkgTcHa97fWRUTCfXqsrG+08KroA0qJun4y
	zkYovIGjB0lewevIEZw89faiCrA5Dudq8HfqDfrRdFWfAxZ+A8jZaQtI+0fZl3FgUOF4HGD774i
	aMonhQHwRwfPBoK9Lj6a3dtUQS8F4cPsPToS1PDHwQk2juMtAaw==
X-Google-Smtp-Source: AGHT+IH+48cGZsFY/aZmrDpdSo/GNdE3oOJq5NiFu4ee+GYVOtxStwgUdjbj3knOZGbnPT5XSDreLA==
X-Received: by 2002:a05:651c:b21:b0:375:f6bf:888 with SMTP id 38308e7fff4ca-37609ea35edmr9252831fa.32.1759927994450;
        Wed, 08 Oct 2025 05:53:14 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b82334sm20599341fa.49.2025.10.08.05.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:53:14 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Ulf Hansson <ulf.hansson@linaro.org>,
  Shawn Guo <shawnguo@kernel.org>,  "Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
	<87o6qjaiz7.fsf@osv.gnss.ru>
	<CAOMZO5BwoAzf36-L0uCTdKriGaUHg1MqZoKg56Fvob6S4coMBQ@mail.gmail.com>
	<87jz17afpb.fsf@osv.gnss.ru>
	<CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
	<87bjmih0nz.fsf@osv.gnss.ru>
	<CAOMZO5Cmxqq6K4k7_yPjGOtMTOgv7WmpN9O2dZiX+UWies8mow@mail.gmail.com>
	<CAOMZO5AJM-r-WnxcS4umg7_tzUemYGn3wt-_3ekG=VCot5PwAw@mail.gmail.com>
Date: Wed, 08 Oct 2025 15:53:13 +0300
In-Reply-To: <CAOMZO5AJM-r-WnxcS4umg7_tzUemYGn3wt-_3ekG=VCot5PwAw@mail.gmail.com>
	(Fabio Estevam's message of "Tue, 7 Oct 2025 18:44:01 -0300")
Message-ID: <87ecrd1rnq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Fabio Estevam <festevam@gmail.com> writes:

> On Tue, Oct 7, 2025 at 6:29 PM Fabio Estevam <festevam@gmail.com> wrote:
>
>> I saw Ulf's response about a potential regression in 6.17.
>>
>> Do you see the hang with 6.16?
>
> Another suggestion: if your eMMC operates only at 3.3V, try passing
> the "no-1-8-v" property for usdhc4.

It does use 1.8. The rest of your suggestions I'll check and then get
back, thank you!

-- Sergey Organov

