Return-Path: <linux-kernel+bounces-729711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B2B03AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3890D189F4E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3C6241674;
	Mon, 14 Jul 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="lvdeWwVj"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D35246791
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484603; cv=none; b=JHVs10BSnx5MJFXuAZFMjfevgAeWGOOksD8dUHuHGIjPPTIGlhf/9GykMtsIkZJEtqhl2bZZdCCxD4Dpn3K6XCCPLV2CCG8VdVa0i00BrENQgg8uklWeTd4vvWewZjyPaHMzJ0MefTgh7mUXBt0TyY8N695HviBRIZXs0G2EMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484603; c=relaxed/simple;
	bh=nG2jwbcLk7SXQKXcTmNSqdZ+/DC2xEkEzu3JnMvQfYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAT/+1spIOuZyIWna6fJ3CXlDRXaGjIgV2x6ojks8yPmln6efs7UTux8OZRIewlppxRyh/jZJxFdqaB16KQ4EpPuhGWr+LzcAgTyl62jtjqqvIBAir+qouTZwOglFokgfVIlvNY4WCdmQavB1r4QFoGsYCC7mwfk1smlqdyb4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=lvdeWwVj; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e3c6b88dbso27852617b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1752484601; x=1753089401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nG2jwbcLk7SXQKXcTmNSqdZ+/DC2xEkEzu3JnMvQfYw=;
        b=lvdeWwVjKR1Pf7nmoNWj3Dn90ESTbhWvKog7RDq9VtpFOsTClHn5MejmUsdBFqCTyU
         PApnZGWdkWbnOGsMx+VnXgXd8Azc6ijPCAiePwHefBCwVIEE7Uq0jkRJxqrdh11MiT8N
         yk382KQjVGqdCLWE0oZoWBmmzd4+LpDkuHZKIK2nrM0jswMxhGnmqqKXGsoc21iP3oer
         Bw/io/VZjAPsOmOYtgASop8OfKVBsONPS+v4Ltlxp/0llxov1WwmK5eSppqwUU51S0s7
         yYEtgjseZaAFmtUsN6oHWkNfiafLKn18F1RAg60G2mWQxEcAbSYruHyj+acEVNyngwxz
         XlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752484601; x=1753089401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG2jwbcLk7SXQKXcTmNSqdZ+/DC2xEkEzu3JnMvQfYw=;
        b=UNm6lkHh2kakRgaUWj0KKTtHoPV+PjxslYrOJlgR4sPWPc7FJZQFwjsOHy3deoRynS
         qym9ZqpIDxuxcIF4TJ59Zpl+BQ7lR5+j8FlZlCCi+zQ2NmbY3tubUtYu/KCVibC7eW4V
         dgEcXfdJ5oFrP/zgmPYM3PYxpFc3L+PLC+jUtzI3/Wc156yssZ+1PxJk8kXqQS3RcAB1
         fm1zE2HqNeZOCTMBa7jHVFfYo3WGftaf5Q5W556Vbk4nxyhLAxfziHIh9mV9J7oXKPbF
         LgCfgJD/98GSK3L62wa+lPp032QzKaZRp5EyWP7mj4ugvC1AEbH+WJSRdeGjdmA3Q/M4
         8u/A==
X-Forwarded-Encrypted: i=1; AJvYcCWoQ39maRTyjV89kt1d36956d9+gwsbZKHW0cNnZsjNnYMoPOmjauhcq8ncLkLp/NfVMHrKpHEXh1X8KYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGkJ0oDS4/B82gySlw5uJfHuZIfs+UgMmE4kvPWYS8leSBUzVS
	NgYWjCqf3+X9ehrRS9w+Ss91faZGIU6IQCVi2bSGBVKWP4NCW6+RhTskJ1bPPbOmFPwmUBPKEbY
	qTbiX5VtuLi6ZVLB+jq3uNkOAGfBW3Vm3Uk/Va2Fr+g==
X-Gm-Gg: ASbGncsnChJI5SldJFA2VQH4capJG4NGGL1sgxbl1JQWsvrn91E7xkfhUTXkyZeMbci
	tuegCATMs42hpXE/VUCasjaIFuouH6fh3lRYB8nMGyAXeiBzUWieZySRwvejrOqOf9+JP55pr78
	p9lMdiAOT6zAHKmhDG8ecfFikP1dlukpEbEVjdw6G1Bq4qYe3deis0ks5VW/aeE2UzZL45BGNN8
	CcxBxp2Sc43x7umBREmiP7JpguOd/feBoWF0tmMmg==
X-Google-Smtp-Source: AGHT+IGGKVZL2gi3YF6dcBpVJCqmCTegzTcKiJ9fHmRZqlNYn7Bg2+Yd24bFWr79pSRo5RVmMmRv+MnI7JAH4UVwWPA=
X-Received: by 2002:a05:690c:ec6:b0:70d:fe09:9b18 with SMTP id
 00721157ae682-717d5c373a9mr204630517b3.2.1752484600812; Mon, 14 Jul 2025
 02:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-leds-is31fl3236a-v3-0-d68979b042dd@thegoodpenguin.co.uk>
 <20250708-leds-is31fl3236a-v3-2-d68979b042dd@thegoodpenguin.co.uk> <20250709-happy-gazelle-of-fascination-fe0fd4@krzk-bin>
In-Reply-To: <20250709-happy-gazelle-of-fascination-fe0fd4@krzk-bin>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 14 Jul 2025 10:16:29 +0100
X-Gm-Features: Ac12FXyAnSttrQTxfZ3hyjQUCceH_uU_FETUA29_qdO6yKKW6bWWhuKLl-Sbr54
Message-ID: <CAA6zWZKRA2Qn3ajN9f9o_oBTZAgrx22gP28A5CHgx=+0jFrOKg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: leds: is31fl32xx: convert the binding
 to yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
	Lucca Fachinetti <luccafachinetti@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Driver as Linux driver or LED driver? If the first, then drop.
LED driver, might not be obvious, could change to controller,
however the datasheet refers to the device "LED driver".

> These should be people interested in this hardware, not subsystem
> maintainers.

I will let maintainers decide who should be included here perhaps ?

> Keep consistent quotes, either " or '. You made different choice for the
> same properties even...

Copied over from original poster, have not spotted that before, thanks.

> Pattern does not match entirely the reg constraints. 36 is 0x24.

Pattern allows for one or more hexadecimal values starting from 1,
so the second number should start from zero is the second error here.

Thanks !

