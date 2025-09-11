Return-Path: <linux-kernel+bounces-812026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82DB531DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC69A1C25FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA37932142E;
	Thu, 11 Sep 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="nwW6MrjD"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C610320CA4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592926; cv=none; b=JoWuXctYV9Ngda9j3ovqKWgfhn3U7tiLGQsA0dUdqDGjLx+y88XUhBlsOybADsNPLGNAgPSARrNh130NR25bfRXyD2GmWIHD6t2rKQ+VSHjrTPIF0JY4DXL2WG+pF/oyVCqfCW7CTN2Q1F8Mearca/b0aU/Q48DT9C5FeGxPJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592926; c=relaxed/simple;
	bh=/DNmTsKU2YQxjE0a0HP3UiiRHt/9KrkhYaTXKbwcjD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIwIprfBmnKMhz0Wv+BWkpT5GcZCAQD+M+aFFrF9aWBqhFIsEjn9iDIs49ZFOShwkrcKT94YqjCr5ukNFRZyeMPyaEDCfHi7yFRHSvTXgDDEn1HseX3owF4dYEX6TXr/iV9KZiZslMj3l2c9zrByLpAG7+Kp/j/xUxNn6XMcur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=nwW6MrjD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77269d19280so556309b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1757592924; x=1758197724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edkglS5aPIxkVAhweNonmsQnCtG5vsLjFWEbqDByJiU=;
        b=nwW6MrjD+OZJX6mH/V9OEhjahwKuEBid/hhioKIBczUzXovjuotueUhM9+UqOmHxI/
         +dV+octOWCOYH7Y7X1/NnFN/pkV4NpDuQlwajP8Rd9ytbtR+XNkjWf1HKeQoTppEvLE0
         8vnjfq9I8MlwDpw6C09neZZMEt7jXe6azbvPeqbiSDusdkHUcpGXSLd2Dp/f1l5kTCRT
         aPOUMXQx1vVmS6uxG4Qic7HQt1Fm5kDtM5rGmJF6ovRYjmm/o+Xi9eNlWaHajKKWrtSw
         yH5ic5BQDLb3LgRIFSnoS1uZ7uqa6LxMiSD66PHM1CjTmbbsfFzk67Wb5/cOOu5BxRWH
         +iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757592924; x=1758197724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edkglS5aPIxkVAhweNonmsQnCtG5vsLjFWEbqDByJiU=;
        b=lVIOOg5iJpQJC/snBwyueXlvOoC2Jc+eXXu/uDEHXF0eIVDbIRZGhT7yO0w17jO+YD
         G0mtyQCSDmpoNQtSOpIPE4fElJi9ZKOiFH4Lu8gwvsnnzyugdW+haUtD8Zc2dpoER1yK
         ScSB4d5h3MVICAchlvrucSd2uXP06+fwHZaN/zv8+AKDQhpqBgw/OxbTSZ89ZvZH+a+P
         5X1vpCwi44W+YAjPlTnrxQJKRbrQz+LSXqZItGFT2q1kDqrOQ6QucS7VOP4n0vvIcdBY
         9TW2lgrMVyphdd63GKTqlwAexfT07FWyUE9fH+CzQ1GVBX1brIvtB3luhnkK5xCXSuPh
         bB2w==
X-Forwarded-Encrypted: i=1; AJvYcCVQaedmfWY01TTodt/ffeT1uyEtDAN6YdoL/DED/6+3+XAhP/VJhUHrv2Pab0+hPIdOj90YOZZt5IM5kJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqEwviX++tQuL13OvcpccQ9jIfWHWJahoppQKycPaC8aDJeWN
	C3lpg1JmcrWKfWcn74sPFno5Qk00R42oG1u14GzesW9LElwT60c40w922CsRuBG1EQ==
X-Gm-Gg: ASbGnctm+HRmbzZbUu/JydaSK1ymP9FxCLsM7hyP7wvTeWIMgb9pwIKaTQvFvlReCuG
	ECjNPpNuwbSiTaXPK4zK23EOdMRJAfqSbQHwa6aIdlW0kg81YH0Pae+sxIjwbk/CTiMFjnouTGr
	IGYgYmy/ly0NqMEAeLTolpzm6gZb8R0hqvOY1YIos755z4Nz63Al7+ILSGzM9Ci/B9BrZkuvy0g
	cbKGck6djsxqcQp1xA4E1sIqx+shC8x3+s9h2Snbgb3QjQhAEjVRmisRA1rtTNsvEdXyticUKLr
	/WXcv13vNYpUl4l//VLvoQZaKdtgEWGl1f6mW1W2xCWHRU+LeiwKiOEPB0fMScvDA0KX8N3zzy7
	OMAV2eNin6cR2btv2g0BCWU/aR7V0TywComVnATmUUICD6xtl5Jp0CwreMVYqo5sbmnfkV88=
X-Google-Smtp-Source: AGHT+IFgOkdGq5x9NJ+zU1c1dBgNDsfTwSsAjnSI6VcIJfup8RDIJaGYOd3IR4zKYJVMBvEDdL+5xA==
X-Received: by 2002:a05:6a00:1acb:b0:772:43a9:d587 with SMTP id d2e1a72fcca58-7742ddf13cfmr19926689b3a.20.1757592924243;
        Thu, 11 Sep 2025 05:15:24 -0700 (PDT)
Received: from ?IPV6:2401:4900:8898:6c44:fc6:e0b:3bf0:1af0? ([2401:4900:8898:6c44:fc6:e0b:3bf0:1af0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b17acasm1957738b3a.58.2025.09.11.05.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 05:15:23 -0700 (PDT)
Message-ID: <36a85af7-75b1-46db-8df8-e83372d33b93@beagleboard.org>
Date: Thu, 11 Sep 2025 17:45:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Device tree representation of (hotplug) connectors: discussion at
 ELCE
To: Herve Codina <herve.codina@bootlin.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
References: <20250902105710.00512c6d@booty> <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
 <aL5dNtzwiinq_geg@zatzit> <20250908145155.4f130aec@bootlin.com>
 <aL-2fmYsbexEtpNp@zatzit> <20250909114126.219c57b8@bootlin.com>
 <aMD_qYx4ZEASD9A1@zatzit> <20250911104828.48ef2c0e@bootlin.com>
 <CAMuHMdUUGoaetdsTEVx27TYQZ_khzyCn0wzi2+TibYcvkg1fXw@mail.gmail.com>
 <20250911122333.2e25e208@bootlin.com>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20250911122333.2e25e208@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/25 15:53, Herve Codina wrote:
> Hi Geert,
>
> On Thu, 11 Sep 2025 10:54:02 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> Hi Hervé,
>>
>> On Thu, 11 Sept 2025 at 10:48, Herve Codina <herve.codina@bootlin.com> wrote:
>>> On Wed, 10 Sep 2025 14:33:45 +1000
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>> On Tue, Sep 09, 2025 at 11:41:26AM +0200, Herve Codina wrote:
>>>>> Suppose a base board with 2 connectors:
>>>>>   - connA
>>>>>   - connB
>>>>>
>>>>> Case 1: Addons are independant
>>>>>                 +--------+
>>>>>    connA <----> | AddonA |
>>>>>                 +--------+
>>>>>                            +--------+
>>>>>    connB <---------------->| AddonB |
>>>>>                            +--------+
>>>>>
>>>>> With addonA and B two addon board each connected at one connector without any
>>>>> relationship between addon A and B
>>>>>
>>>>> Case 2: Only one Addons using ressources from both connector
>>>>>
>>>>>                  +------+
>>>>>    connA <-----> |Addon |
>>>>>                  |      |
>>>>>    connB <-----> |      |
>>>>>                  +------+
>>>> Case 2 is what I'm talking about.  Case 1 is the easy one.
>>>>   
>>>>> The addon is connected to both connector and uses ressources from connA and
>>>>> connB in a dependent manner.
>>>>>
>>>>>
>>>>> The Case 2 can be solved using a connector that described both connA and connB.
>>>>> Having the split connA and connB is a mechanical point of view.
>>>> I don't think that's a good solution, because it means you have to
>>>> make that decision at the board layer.  If I understand his case
>>>> correctly, you have a board where you could do either case 1 or case 2
>>>> at runtime.  We'd want the differences between these cases to only be
>>>> reflected on the addon device tree, not the base board device tree.
>>> Based on my understanding of Geer's use-case, I think decision at base
>>> board level will be needed.
>>>
>>> base board        addon board
>>>    connA +--------+conn1
>>>    connB +--------+conn2
>>>    connC +
>>>
>>> Or
>>>
>>> base board        addon board
>>>    connA +--------+conn1
>>>    connB +    ,---+conn2
>>>    connC +---'
>>>
>>> Or any other combination that would match.
>>>
>>>  From the addon board point of view, the only think we can
>>> say is "me, as an addon board, I need a connector of type 'foo' and a
>>> connector of type 'bar'".
>>>
>>> Also, at base board level, statically defined in the DT
>>> connA is described (type 'foo'), connB and connC are
>>> described (type 'bar').
>> Correct.
>>
>>> The choice to map connA to the type 'foo' connector expected by the addon
>>> and the choice to map connB or connC to the type 'bar' connector expected by
>>> the addon can only be done at runtime and probably with the help of a driver
>>> that have the knowledge of the 3 connectors.
>>>
>>> I have the feeling that the choice of physical connectors to which the addon
>>> board is connected to is a human choice when the board is connected.
>> All these choices and decisions apply to single-connector add-on boards, too.
>>
> Yes, in our use case (me and Luca), each addon has an eeprom, wired exactly the
> same on all supported addon, which allows to known the exact addon. Also addon
> insertions and removals are detected using some gpios wired to the connector.
>
> Based on that our specific driver handling our specific connector perform the
> following operations on addon insertion detection:
>    - load a first addon DT to have access to the eeprom
>    - Read the eeprom to determine the addon type
>    - load the DT matching with the addon type
>
> This part is of course connector type specific. I mean having an eeprom with
> some encoded addon type values and hotplug detection with gpio is a part of
> the contract between the board and the addon (part of connector specification).
>
> Best regards,
> Hervé
>

My usecase is a bit more complicated, since I am trying to model all the 
available headers on BeagleBoard.org sbcs (particularly PocketBeagle 2 
initially) as connectors. However, that still ends up being a single 
connector which can have multiple addon-boards simultaneously instead of 
the other way around.


Best Regards,

Ayush Singh


