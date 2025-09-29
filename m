Return-Path: <linux-kernel+bounces-836586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7711ABAA1A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375DE3B1AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDC204C36;
	Mon, 29 Sep 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewfAFgJH"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CF17B50A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759165668; cv=none; b=B1Ytm2CaD0aFENZASI0a7bYayZPMQhnpV+5pTndCm6mWN4LtGP2FEeHlElIHaGWrF+AZXwfer1s+FdYLizUKVRh09H5Z4yRMnMmqZFDm397x96e9dUFlVU56diItL9lmGFm0hdWGrx5u55Rx+u0OW3c36P7I4HruBt7lTRCJLxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759165668; c=relaxed/simple;
	bh=GHaH6xHVSsfmMOhc3Q4Uv4imU4pJ//tOMuXYRsOMut8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B23sDNIg/ENXfwIc5WK7AsdUxRuEn2RAu9pPdiHDOxhFvem2VMG4ImP6LTzfDpmeVBsNmrmNTgJkHeyPeXbk2wxRsJiAoXSUTwjuxq2JuPcqcblwAPKaQfv88pi8wV+pspQIv8tL9pgY8iqTr3s5yTZhpILUmEVxeUBK+TPVWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewfAFgJH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-414f48bd785so2597517f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759165665; x=1759770465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj9JtujIrCASOTxrqaUt0QRKvTAm0yHb0MuPSQjc/js=;
        b=ewfAFgJHx40FBB5cQCI13U9paQma0tclOSnUjz4eo7r1yCwJRaNwKOw5H88HdSUKem
         PVck37GzfTxOlPQd2Eet7e4yJLzIT4OhlDN9CmfWIcFyT4sMtdXA5+N17o3jHrZ5N8ix
         GYQbgw2kutnIic0UklpUwoQlPUdIxBETC6/f30ksnFpPZ8ZPXGATBpRWJW4WTEG9KApb
         +CHGDcNsYhiVvuVMW6KZ96BlsEmPHmbsw7Dg+LL8V7cNG8Whqh6z6wd3EKFzGP5drK7c
         BB+qLJrFR66bzrZjOVuJzJgZZIUFeCtd97IPt7IaMQOSk1lzHn3oU+73yiPqYm1T8dvf
         uzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759165665; x=1759770465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj9JtujIrCASOTxrqaUt0QRKvTAm0yHb0MuPSQjc/js=;
        b=BArmYqv1BGdI5Rtnr0VZcKXPQ/irkqBlkihj+vwjLDs0eIM2EWMfiEutZw7/0bzvb9
         HCHrOp6sAEOOf2REuLWvgFR/QX4bq9slGmzzTTF5k/vnd7xXZmKagb2OcxO2MPDcs1Nb
         RjLQhxJwNRAhDpKfCFABn1tnqar5RV+xvi+s0UktgIUQ8DicHt+rTOscNjXpkqt8+atF
         gEOwuo1s0QEKU+N2kJvu8V8+c90zOC5YRK6AjNgeiVt2poWF5kiXhdfntyp7yoDwX692
         7gdlY3X8ko7tNkrixu26k+dTCv+9byU4z8SbPmaKhRi8dgWsQ3HVIv9Lg8JJGwIPO8e9
         CXww==
X-Forwarded-Encrypted: i=1; AJvYcCXnjfIJsdn1+2G0q/7U+ZdZcMqgO1EjI4Q3sYgp6S/o67a9d1WEEfrRHAuNrrh9twsA0kjston1D+uXggA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMHSRagIRkatv4oYo8cqK4WxtJ98gsndg0bZBFz5yaEtBqu50
	GeL5IGhBOZ98x3K0Htx9+jszck9SsqhOjcjTiBBGkLOMifMe2yPOcVIg
X-Gm-Gg: ASbGncs5s0+Pnnk5K1BG4PPrN/aX2+HhiNT8TjWGfvfqxbtjxQfxBOzQUzfZPuYjYxe
	6DHEf/ehTiT1Wvnavw8JcjDK/91Bwgl1BgTY44fGbMfzJ5WvXJBdXpgpCJB+UaUjABszjV+KQ3q
	P5LGJbAJiuZgiIVhPKWhaKuzlv61jYbeq28hJAggbRlLjc2FaGjvu5Fv3F4dAOpgKwLPfUZA1vb
	5bTeWEHTreZIH5eClVQXK9Ecw/O4UssGhHU8d7XljyJZlQ5N6D8aCa687Mxbd0YjVKSete+O0tx
	WIhxPNMLQn5c6dHzWFeg7rAuK94awyTxEF4uFdVvcB9ZYea+5KhACNdfQkVRQ37Hn8IeG2ke/pk
	aQoF1dT/dhOiDFYKY1SyMJvUmU5U89oHQNC5bSxWYKN6EJTdsJf2TKxz3V4hqTQucxzq+WYKgCf
	2AmQ8e
X-Google-Smtp-Source: AGHT+IE8a0TuB4O+ROJaTBK4jhGL6wAS75qWcIM1U4/kmaIwGYyni0pYeoJGRjfNbkPbKaoBFbyg2Q==
X-Received: by 2002:a05:6000:2307:b0:408:ffb9:9f62 with SMTP id ffacd0b85a97d-40e47ee07eamr13272578f8f.29.1759165664670;
        Mon, 29 Sep 2025 10:07:44 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.71.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm232769755e9.20.2025.09.29.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:07:43 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add TMP110 and TMP113 devices
Date: Mon, 29 Sep 2025 20:07:30 +0300
Message-ID: <20250929170730.8285-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924-grievance-crisply-8c7da95946f1@spud>
References: <20250924-grievance-crisply-8c7da95946f1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 24, 2025 at 19:12:26 +0100, Conor Dooley wrote:
>On Wed, Sep 24, 2025 at 08:55:39AM -0700, Guenter Roeck wrote:
>> On 9/15/25 10:18, Conor Dooley wrote:
>> > On Mon, Sep 15, 2025 at 08:08:18PM +0300, Flaviu Nistor wrote:
>> > > Add a compatible string for TMP110 and TMP113 devices.
>> > > 
>> > > Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
>> > > ---
>> > >   Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 2 ++
>> > >   1 file changed, 2 insertions(+)
>> > > 
>> > > diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> > > index 96b2e4969f78..840b5306a8cf 100644
>> > > --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> > > +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> > > @@ -13,6 +13,8 @@ properties:
>> > >     compatible:
>> > >       enum:
>> > >         - ti,tmp102
>> > > +      - ti,tmp110
>> > > +      - ti,tmp113
>> > 
>> > The driver has no match data and no compatible based decisions added in
>> > your patch. Why is a fallback to tmp102 not suitable?
>> > 
>> 
>> That should work for tmp110. However, tmp113 does have additional registers, and it
>> might be desirable to report the content of those using debugfs. Fallback for that chip
>> would work for now, but that might have to change later if support for the additional
>> registers is added to the driver.
>
>In that case, only the driver would need to change not the binding.
>That's fine though, of course.
>

I am a little confused and I would appreciate some advice if I should leave
the series as it is or send a v2 only for documentation and Kconfig updates,
droping the binding update?

>> 
>> Guenter
>> 
>> > >     interrupts:
>> > >       maxItems: 1
>> > > -- 
>> > > 2.43.0
>> > > 
>> 

