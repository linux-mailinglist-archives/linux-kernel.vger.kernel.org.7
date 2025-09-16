Return-Path: <linux-kernel+bounces-818753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3103B5960D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2668F1B2863B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D53164BC;
	Tue, 16 Sep 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="z7NfGuaM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E038315D31
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025348; cv=none; b=b4mWa09rQJYsFes/D/i/LklEzJupOiRuRiECZ32OAHSiG34xnwMF1xNwuTeMVtlQEx3/OCR7n4R2Cxb+BZJ1BL93qns0h15enDO+LiEU4ISfQir10Dpx+Kw4rf7WW8EIqmFBJF0dbNMLBnbJzqgfBzdK6UPw5AUAs/OJlyCGJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025348; c=relaxed/simple;
	bh=fqM/JGxWXDvWSyz6fzJ8EaAgZz1wCn9ix0KOBZDkuEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaogS/GF0BFtVuAoMHpnjXCK9IbPSIfQQXQ8qfldyHNV1CuqcFc//FJfoWg6r8eOP2a5bWs8L4Wk53pwg/seAxquJ1Sj6oqeKRYr/EPP/qTYnScWQxJOc2bsobNjXFmlMRZxpLPbUoJ0VtPjp5T4jdRR4DSPD+LkxEP20xR+9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=z7NfGuaM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2570bf6058aso70193625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1758025346; x=1758630146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLRhawfUOnzg917Vpj9Yo7NT/ncmZFWuu+3t8quChCY=;
        b=z7NfGuaMEujffC2agRNlu32/G1h0DuHPIXz/M39LNU4eP9bKAphTXYaMYqTcYjWPIa
         pi4FZsZpYG93Yfgk0gaN1gK4MFJ4Hmx55caMZiGpfbkIz4mTvDvZcpAk3B7Fj4KaRDZU
         UUFu27h/n1yjfh+7jOHebYPR7z6GZYGBz3iwpYkBGsAMTizyRZOkmqYVTQKni/nL38G2
         vv8+EYGgWbTQYiFLlDalG5Z8Q9lMWT97aHqZpZ+9GDxEUOzOGAY3YokiXnJMbumdVOll
         9gnBKk7PYJx+Mq6ipAg+05+WGXoDbyYQpbj48x7+h9drV5fpCVYI8CQwM246RW0dNfPK
         Mvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758025346; x=1758630146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLRhawfUOnzg917Vpj9Yo7NT/ncmZFWuu+3t8quChCY=;
        b=C027fEw2YcMnbDDXNGkDTqBBWH30m3YRNzX6bD8qYEKRFWapICkNtRoivGIEYRMIZz
         yS5jHvBuRFOK0Lc5g3j7sznHLuBFcGcPeejFHAc1kBdL9ZAaYyPRswGh97MgPW7MWksQ
         xq/omr3/dlM0IT3HujfXm0K8ehYAKfHvzKp/oPHL491edaL8W2rtJlJGTLrTVDZuxFtT
         HFHIf+2D1pQMYvdSf7xtGktJNJ4JjyM49wCSb1R9SuhuYjlPThut3PuW33V8noW2ak2D
         aJWw7ncuXMq6HCKrKEVrzddPIAou1GjOlXk7BJBjnwKLWU7kmbfbooOQZCjYU8qG7jkW
         tnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJOPl3OeM3HDOMRe/4RSz+uBnqjtOTGZGltArpqyp3/zdVJvqHEuPIeP3545mW/idqaQevTelbprboXOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX687t5Zao0iesGp30LDhveSnL3igmxA5hRjjlJD9Ut8US07Ao
	eYDlGN10IpgJ9WmD3ryS/wwSvlJhdjPyQrV3aGSMibGqrNEwUTrerTQnTvsr79IPgQ==
X-Gm-Gg: ASbGncvXuNsPQwZqW1JhQ0Mzo9unhs+V7B/kvj8eqm3haNd9/2NuhDchuPr+o+rZXgy
	myifxoOiaYCqP5Vrzs9xgZEIfHwfDGHgPG2ohxyNSVpjRmfA9WWQDZ1wuVtlRPHJ2vTC9YHsjcE
	halKTgQNOdMKc68Y19VdxdBlG6TW1uEoncCZfqTyf2JTzPzp2dznfzWEbWZwbXJK6qweJw1klpn
	qU/WRy7JXmrTFqhUqqN4jfnUHWIUJLSMx3tchbpri3OhKD13hi+1ue0XmWUs3T0OchJu1zAY+vL
	un53E4+3Qz83Z8nSw/14NVqSzMiY4c/A+PU4fo4+PsZvdVWWpSci1jH54rFqpW96GthhHfHHDt6
	a90ySBK60X1w24h2ukAfLqLRNzactGE4AJFx/tAasWQpfRgNL7ECe7YtWuEU+GqPYhlNuOGRZIq
	4J0/S7WkFz+2U=
X-Google-Smtp-Source: AGHT+IHmBwkxP+Zhpk5HnX/FJ08tuJ9zeLX2LjBddCIb0Zkm2NtUoGbkRB7285Cr8PepXjQeRcICXA==
X-Received: by 2002:a17:903:3d05:b0:267:f131:d657 with SMTP id d9443c01a7336-267f131d9a4mr5560315ad.33.1758025345718;
        Tue, 16 Sep 2025 05:22:25 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3f:4017:94e1:4956:54cb:7de7? ([2401:4900:1f3f:4017:94e1:4956:54cb:7de7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2656a9caf7dsm66844215ad.133.2025.09.16.05.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 05:22:25 -0700 (PDT)
Message-ID: <397483db-91de-4ff2-82e3-52ae785bc343@beagleboard.org>
Date: Tue, 16 Sep 2025 17:52:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Device tree representation of (hotplug) connectors: discussion at
 ELCE
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Herve Codina <herve.codina@bootlin.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250902105710.00512c6d@booty> <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
 <aL5dNtzwiinq_geg@zatzit> <20250908145155.4f130aec@bootlin.com>
 <aL-2fmYsbexEtpNp@zatzit> <20250909114126.219c57b8@bootlin.com>
 <aMD_qYx4ZEASD9A1@zatzit> <20250911104828.48ef2c0e@bootlin.com>
 <aMebXe-yJy34kST8@zatzit> <20250916084631.77127e29@bootlin.com>
 <CAMuHMdXXi97HN-G_Ozbs7vc141GmbMTPD6Ew6U_0ERj5wh6gvg@mail.gmail.com>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <CAMuHMdXXi97HN-G_Ozbs7vc141GmbMTPD6Ew6U_0ERj5wh6gvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/25 15:44, Geert Uytterhoeven wrote:

> Hi Hervé,
>
> On Tue, 16 Sept 2025 at 08:46, Herve Codina <herve.codina@bootlin.com> wrote:
>> On Mon, 15 Sep 2025 14:51:41 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>> On Thu, Sep 11, 2025 at 10:48:28AM +0200, Herve Codina wrote:
>>>>  From the addon board point of view, the only think we can
>>>> say is "me, as an addon board, I need a connector of type 'foo' and a
>>>> connector of type 'bar'".
>>> Agreed.
>>>
>>>> Also, at base board level, statically defined in the DT
>>>> connA is described (type 'foo'), connB and connC are
>>>> described (type 'bar').
>>>>
>>>> The choice to map connA to the type 'foo' connector expected by the addon
>>>> and the choice to map connB or connC to the type 'bar' connector expected by
>>>> the addon can only be done at runtime and probably with the help of a driver
>>>> that have the knowledge of the 3 connectors.
>>> Agreed.
>>>
>>>> I have the feeling that the choice of physical connectors to which the addon
>>>> board is connected to is a human choice when the board is connected.
>>> Yes.  Although if the addons have an EEPROM, or some other sort of ID
>>> register, it may be possible for some connector drivers to probe this.
>> Right, I think we agree that a driver is needed to help in the mapping at
>> least when multiple connectors are involved.
> I agree you need a driver to read an ID EEPROM.
> But why would you need a driver if no ID EEPROM is involved?
> If the connector types on base board and add-on match, it should work.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>

How would a connector be disabled in such a setup? I guess maybe status 
property can be used while applying overlay to check if the connector is 
enabled. But maybe that goes outside the scope of fdtoverlay?

Also, I would assume that most such connectors would want to provide 
some kind of configfs based API to add/remove addon boards.


Best Regards,

Ayush Singh


