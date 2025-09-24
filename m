Return-Path: <linux-kernel+bounces-830945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63382B9AF83
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D581643F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67540314A90;
	Wed, 24 Sep 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="LpPZtKVn"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258053148D9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733438; cv=none; b=oxyLmC+Jw+MrzekWBrqhz9mj8F74eGoKb78pntmfEYoxfxHPtumc4Q1s1OCH/ET9aHZZLpHB8xzKwsesz+xaPvVupMsIMEX7YZB94Q+idb6JTSJFeeDEa07WYVD42gIETJfEf5/cVweP+CQ1djcz+eMnEEsTcSPsIo8Hq/wy1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733438; c=relaxed/simple;
	bh=CFe5INxZHk/zg4tBwFi2LAVVet3K2yzAoMppLFFFJ9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/7u8wunE3+LmUcYmKEOGO+OXVKgntkMyIQz2EAkwu7IP3TxbhvxoeqBd0VhySWjhJzs6J0/WotCwnitVs9QZBwklZlrKwQ/TbLo62hybfwoi6IWr6a7pHdGt83frdrX2LHdDPKR94uUF8Ykl98cRQQLGeKOyoZxeNpo0fIksG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=LpPZtKVn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f3405c38aso85256b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1758733436; x=1759338236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YwBkd41sTD3rLHkZ2O0eRif7ESkJYPHv5ge7YMF2z9I=;
        b=LpPZtKVnxkiI3Pi4upQDhJeBnycjbh2/Bhp0p8LvkFVsf+X7r7YS4/6hE1YiWU6Ogb
         +llZw65I7Z+0lXEmJqZwMGZpBO9geYUwGJJkuWC9E8mDMzucwwMba6OuLq5XDn7xdlur
         aypWxg9bbYeZu2vWW11FktjM/82hJLQkpFy3OP8i6f+2AYw9OK/RtMHxID4YA8UwkV8p
         IOdXoPji8gFNjT2NrlALLyG/M2ZKiblsrIY81j2LnN9brMxP3yxiHJ0VrMspdC+0lkdU
         ZgcEGS2yVo9F7KCUMhzDknrYNCGQusylLknlOWhRZleaXGlbK1yO+WMN/E5/pDLjkIGe
         bhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733436; x=1759338236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwBkd41sTD3rLHkZ2O0eRif7ESkJYPHv5ge7YMF2z9I=;
        b=UGZEuXU7uuHS4HgsZKa3NcFrdpQUx4OG395vV977KID8ihR2WJVb4iDFLvhPwYMnN0
         ujcZhGmum5JCc9Vn6JgHJUP95EyRhTz6ZVWUkyTUsZp6rgqoAN92p6X6+guORbujcuzS
         CpQZAs59U+vLjh4doHFG5SREtiYgYJoJchzdt2VQrUGB0eA5Tfj0OpDBBFeGOypj636c
         i9WOB+NAB0Hq/zkJNK27ma8Vs0RnhgfSWLJwTjiG73DcBsPMY8vY230IFJt9FZtkmeBr
         CTuVjBjCZU8s6HJmnAuxpyBDk7wiRzqlBW9N3sCA7nlAypo0/Y4ThuZlRwRNppXCfgdD
         GnVg==
X-Forwarded-Encrypted: i=1; AJvYcCUrr23k6sUP6njeCiNDdQeLfgmSpKo8FtVQ+Fxoocy70uav+FFGDNvm0PJenJsSMbZ+JO9blNId3bqRFms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsw43QAjMD1R0Pam1ogxsENlWY6qp7ICs3Oq6X9Rv4j/NHztSK
	e+gKVn/1wu/o1z75tdaV5MtG6dvOyDlmgappPrqwGGl5PZd39slRHtAX2bwZhsgsgQ==
X-Gm-Gg: ASbGncutEUOh2xW3rYqQJrToC18/vFwZaRRk56lL3vfcEgFCxwo5SE2C5J/VqLLkMGt
	HpwlZMitDXlelkj+qDvDtbyDSSWMxEk64X6P95T0eHGOy+IO6IoON8h1+fwhQ4JRNpI+6IC8/Zu
	mQ4d8UH6+Cn0jI7m3j7ZGHZTj7zxokF3yd/Ki2HzxgTpxMKDpXxUUFsT16zrXT1SSiRucHUMa/w
	kiKTPo2dF60+STdbdhkqbXkLHJMwoOsH9QDTQta+NG+uuAw+3WOMNw6JWpuIXjP8AyQr0DKJ/XA
	GISnb1su7qTwT4B0OoGQVW0hEYhHPu1y5yDodaG/zQz7aIkSa0I/Hg1jU00+vXysCNFpkGScwD3
	g9zIzXeWBrxdlZvLBrxZJx14I/u5GECiW3GgW7ibRH1O0h4FnuqqCJdYo0OMACqDoEdeX02fGbu
	lR7g==
X-Google-Smtp-Source: AGHT+IGdK/VxJH0ABNF0LzHyK1MWFjyhIxZJguh+F83ogw+n58jt7qNfiroMvD45AwtG2kR/BIJCxw==
X-Received: by 2002:a17:902:e84e:b0:269:aba0:f0a7 with SMTP id d9443c01a7336-27ed4a06c9amr5631235ad.2.1758733436143;
        Wed, 24 Sep 2025 10:03:56 -0700 (PDT)
Received: from ?IPV6:2401:4900:8899:6332:1261:ac31:d3c6:55a3? ([2401:4900:8899:6332:1261:ac31:d3c6:55a3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803601e3sm197547965ad.144.2025.09.24.10.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 10:03:55 -0700 (PDT)
Message-ID: <cd9763b7-919a-4b44-a347-f1491d9584b9@beagleboard.org>
Date: Wed, 24 Sep 2025 22:33:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Device tree representation of (hotplug) connectors: discussion at
 ELCE
To: David Gibson <david@gibson.dropbear.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Andrew Davis <afd@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org,
 Jason Kridner <jkridner@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250911104828.48ef2c0e@bootlin.com> <aMebXe-yJy34kST8@zatzit>
 <20250916084631.77127e29@bootlin.com> <aMt5kEI_WRDOf-Hw@zatzit>
 <20250918094409.0d5f92ec@bootlin.com> <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
 <aNJVqSpdAJzGliNx@zatzit> <20250923114849.2385736d@bootlin.com>
 <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
 <aNNvaN4xJtKBFmWT@zatzit>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <aNNvaN4xJtKBFmWT@zatzit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/24/25 09:41, David Gibson wrote:
> On Tue, Sep 23, 2025 at 12:29:27PM +0200, Geert Uytterhoeven wrote:
>> Hi Hervé,
>>
>> On Tue, 23 Sept 2025 at 11:49, Herve Codina <herve.codina@bootlin.com> wrote:
>>> On Tue, 23 Sep 2025 18:09:13 +1000
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>> Ah, right.  To be clear: we absolutely don't want multiple addons
>>>> altering the same nodes.  But I think we could do that in ways other
>>>> than putting everything under a connector.  This is exactly why I
>>>> think we should think this through as an end-to-end problem, rather
>>>> trying to do it as a tweak to the existing (crap) overlay system.
>>>>
>>>> So, if we're thinking of this as an entirely new way of updating the
>>>> base dt - not "an overlay" - we can decide on the rules to ensure that
>>>> addition and removal is sane.  Two obvious ones I think we should
>>>> definitely have are:
>>>>
>>>> a) Addons can only add completely new nodes, never modify existing
>>>>     ones.  This means that whatever addons are present at runtime,
>>>>     every node has a single well defined owner (either base board or
>>>>     addon).
>>> In this rule I suppose that "never modify existing ones" should be understood
>>> as "never modify, add or remove properties in existing ones". Because, of course
>>> adding a full node in a existing one is allowed (rule b).
>> What if the add-on board contains a provider for the base board.
>> E.g. the connector has a clock input, fed by an optional clock generator
>> on the add-on board.  Hooking that into the system requires modifying
>> a clocks property in the base board, cfr. [1].
>> Or is there some other solution?
> Hmm.  My first inclination would be that this case is not in scope for
> the protocol we're trying to design now.  If the widget provides
> things to the base board as well as the other way around, it's no
> longer an "addon" for the purposes of this spec.
>
> But it's possible I've underestimated how common / useful such a case
> is.
>
> Note that I'd expect the existing overlay mechanism to still be
> around.  It may be ugly and not very well thought out, but its
> drawbacks are much less severe if you're not dealing with hot unplug.
>

Well, while that was not an initial use-case in my mind, external clock 
inputs are a valid use-case when talking about connectors for board 
headers specifically (e.g. pocketbeagle connector).


Best Regards,

Ayush Singh


