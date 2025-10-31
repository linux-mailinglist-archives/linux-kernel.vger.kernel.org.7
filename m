Return-Path: <linux-kernel+bounces-880768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B53AC2680F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CA7D4E34F9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DB434DCC2;
	Fri, 31 Oct 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvTPjRhV"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36296309EF8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933585; cv=none; b=C0A3rXPvIzZpo4AmZ5GikIk7ZrU7OPx0IAPShFunNs8YuH0vckvYXw34UOl6NaXJ+m9sgNoMdHfobP/JVmapArCI/SVndr6rBIlqE6NAuvBcbCIX1K9YccTchiimtJGq3hQH7ikpywuLB0NxrnEr6VZS+lsp/M5ooHA/XTJakn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933585; c=relaxed/simple;
	bh=iOnu8YXSm0hYmgtxCKnYF6BGiSqmzUrc4a0lLm+asfc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=d7aJmxUXY1R1efUFLj5YSUfc6zPtzeVQ1VM8jN4c2hOdCLZNzrweSIkcS75Uqye0cvksdNvUQ8gXRJoDpDrP59lIF3YUrJxuUsenY+KgUq3V2dvKXHHwiBxWjulOwyk0CqLtW0sA4ZM4xiL19Xc4G1vhHtlVTWk/g9jhs/fgZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvTPjRhV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-89ed2ee35bbso355881585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761933583; x=1762538383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C9TvLVEpUHB355SxMPUsmkhK3XU3SxzE+SMxZSn+ZNc=;
        b=hvTPjRhVFlGpZiVnMX3mQb8kzi4Vcjx5eYucVtRoun9kRWZH+ZODffzNS3m42Pcuhh
         32UVXzxRF9LkgYlvPygw5SP3gmtyzYZ4LMLcguU+y7z2v6arRsM67InRvsZ13GIuoOQe
         4swanEh00FKFwcXkv7bglKBgv87mfycPA8XfFSNMaS8BCn16BdOAj9H3TKRvtcuVQzgq
         Z6K+RGoDNv3byAPNiw5xwtc+pjUaNKtxAW3NPNi+Yp7s+fxBrmAkqTzK8fOGmKz/cy7j
         nlOrHP/v1YJTI9sVwOOZcjf5sWcNd5z+6n1vF15bzdzorSmGd+wk4gvTBNTAznmGpsKz
         8vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761933583; x=1762538383;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9TvLVEpUHB355SxMPUsmkhK3XU3SxzE+SMxZSn+ZNc=;
        b=gXQwSMRK2yevToVStZLZ/S6FJDnAh43Tr2Rke9nJJh9fB8XmnsJgm/8ODtiNrIMhcf
         8e12KvyQ2DhLrYXeAL++WjjiV2+JzBwE1gXkKaY9ecMVHzDkCDkEg4ThK8b+F2clppkg
         cK12Dhy0yS8u/oXts+iEeJxqY02n+uPvXB0UA4HZpJmUmuZm8WtxYQsTO1mzB/c9DmR7
         wp4NuGUhHZVJBN3i9UA2ju7uFhArnkqdGmzKLSRnCVgSB790UTrnkY8J8WlU9adVViv2
         Fxw+JutlfyDLrTF6w6YVMVGFhUhMBTt1ZE+axDe9IugfhjNjJDe7+dz8zzXa9CNb2MJd
         BV+A==
X-Forwarded-Encrypted: i=1; AJvYcCWK25Qq6lR39k9oyj0b2vYPw0REieM8rQ/HwUwnFJIdlN95BGFk1qxA9GB/Lmr+5UIhIEYimrZ2+cJZYBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8yT51Wea+EmZ0KtA1FKPzSv4YT8v2pXTQgpWrMgR646UE0rS
	/eDRRuFSR++q7FXINMSt/TjDWk/f8NaJDJICAJp/W8yT1bOYkSS2XwIb
X-Gm-Gg: ASbGncs5ZB4a467TtcAK92MohVXcQHXf7LnrYyRW/qIHcDTMLLWQFoxOGjaAaNinP/3
	xn485E1e5Ogmlr7CP9rfhK2058QDjzC4YFWGxE+nTLSAQ5Ni7WG0g+q6gFIjWdmdiyu7ZOqnPBV
	+l61pAsRZ92W8mxgCby0u43s6tn9LF0qbCLzwrPeXSDndxIG0Q782Pz8tiCmAsyI2vo/IH1YBWA
	73FJ7AIXWU3ZC2L33gJEwkmPNqSLUhcFGasWq5MYbYXCZSMwR04GCV/6e7q0Bq2w87DG/g36b4M
	tQtCs2rIJMN1OCV9njyPGTrsqPA8JwerBIBaVCNqrop7ksHfF3WaYTpv+LJ28uNSUSZ1B5p0xAY
	pAt03NAlhjkwbnNFL0DDwkHiT+XcG9EQFDQZhUmy2DYVbs3tDANkEEUNivkeRVFyheYCxAY9/HD
	eOSgofmY1Df2qOfMGP0+sgpM9zHK+st4UtYjlKoy/J3EqrhI2aGuWCD1uGUsQ=
X-Google-Smtp-Source: AGHT+IEosKF/hSeBeiZp/vvJLPozX0TbNwZj+ymvZVV1kTVbfgpxF7BbWMYqF93HykWROEe4RFcMSQ==
X-Received: by 2002:a05:620a:4004:b0:883:7309:c0eb with SMTP id af79cd13be357-8ab9acee443mr519487285a.41.1761933583004;
        Fri, 31 Oct 2025 10:59:43 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac03f4d585sm148632985a.56.2025.10.31.10.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 10:59:42 -0700 (PDT)
Date: Fri, 31 Oct 2025 13:59:39 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Rob Herring <robh@kernel.org>
CC: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_3/7=5D_dt-bindings=3A_auxdisp?=
 =?US-ASCII?Q?lay=3A_add_Titan_Micro_Electronics_TM16xx?=
User-Agent: Thunderbird for Android
In-Reply-To: <A137AD5E-2D4E-4C1E-8A71-EF90E60D8F14@gmail.com>
References: <20250926141913.25919-1-jefflessard3@gmail.com> <20250926141913.25919-4-jefflessard3@gmail.com> <20251002024431.GA2926696-robh@kernel.org> <A137AD5E-2D4E-4C1E-8A71-EF90E60D8F14@gmail.com>
Message-ID: <7F647662-59AF-467B-8998-E870F114BDAE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Thank you for the review and Reviewed-by tag=2E I've addressed all your fe=
edback=20
except one item that's causing validation issues=2E

Le 1 octobre 2025 22 h 58 min 38 s HAE, "Jean-Fran=C3=A7ois Lessard" <jeff=
lessard3@gmail=2Ecom> a =C3=A9crit=C2=A0:
>Le 1 octobre 2025 22 h 44 min 31 s HAE, Rob Herring <robh@kernel=2Eorg> a=
 =C3=A9crit=C2=A0:
>>On Fri, Sep 26, 2025 at 10:19:04AM -0400, Jean-Fran=C3=A7ois Lessard wro=
te:
>>> Add documentation for TM16xx-compatible 7-segment LED display controll=
ers
>>> with keyscan=2E

=2E=2E=2E

>>> +
>>> +allOf:
>>> +  - $ref: /schemas/leds/common=2Eyaml#
>>> +    properties:
>>> +      color: false
>>> +      function: false
>>> +      function-enumerator: false
>>> +  - $ref: /schemas/input/input=2Eyaml#
>>> +  - $ref: /schemas/input/matrix-keymap=2Eyaml#
>>> +  # SPI controllers require 3-wire (combined MISO/MOSI line)
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - fdhisi,fd620
>>> +              - fdhisi,fd628
>>> +              - princeton,pt6964
>>> +              - titanmec,tm1618
>>> +              - titanmec,tm1620
>>> +              - titanmec,tm1628
>>> +              - titanmec,tm1638
>>> +              - wxicore,aip1618
>>> +              - wxicore,aip1628
>>> +    then:
>>> +      $ref: /schemas/spi/spi-peripheral-props=2Eyaml#
>>> +      properties:
>>> +        spi-3wire: true
>>
>>You can drop properties=2E
>>
>
>The issue is spi-3wire is defined in the child node of spi/spi-controller=
=2Eyaml,
>not in spi-peripheral-props=2Eyaml=2E
>
>Removing properties did not pass dt validation=2E Am I missing something?
>

You suggested dropping "properties:" in the SPI 3-wire section:

then:
  $ref: /schemas/spi/spi-peripheral-props=2Eyaml#
  spi-3wire: true
  required:
  - spi-3wire

However, this causes dt_binding_check to fail with:

'spi-3wire' is not one of ['$ref', 'additionalItems', =2E=2E=2E 'propertie=
s',=20
'required', 'then', =2E=2E=2E]

Unevaluated properties are not allowed ('spi-3wire' was unexpected)

It appears the schema requires "properties:" to recognize spi-3wire as a=
=20
property constraint rather than a schema keyword=2E Should I keep the prop=
erties=20
wrapper, or is there a different way to structure this that I'm missing?

>>> +      required:
>>> +        - spi-3wire
>>
>>With those nits fixed,
>>
>>Reviewed-by: Rob Herring (Arm) <robh@kernel=2Eorg>
>>

Thanks for clarifying=2E

Best regards,
Jean-Fran=C3=A7ois


