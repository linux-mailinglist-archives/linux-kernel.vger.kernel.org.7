Return-Path: <linux-kernel+bounces-760178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824D2B1E76D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E786271FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F022741AC;
	Fri,  8 Aug 2025 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jwnk2lvO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783A1DC9B3;
	Fri,  8 Aug 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652983; cv=none; b=gc6M+PRup4fh8a0xq1dm/jimlv48ro5OwnReTMBKV75OSliQwGZybCJPvtB37kL8gcP6dUHdllYYlKadR2CQ0Oo7371zso+w26+LFEPIr5C8ZLsdz18c8TwiQI91WscAZ41fo3wyYXBbWm9L2EReUPfeRU/xyrNO+hk8pqfEntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652983; c=relaxed/simple;
	bh=wqjDekI/FqgVuMKcDdQW/dEhZCtWv8PfB2SrJJ73u5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YskYHkDAT/Sk63uJJVEERcn7Y2YHP1haJHc2mXHpHx7qTM5g5LZuwFHw00xUHWfbj7M3bxP39OWMOSr3GQ7kGjkrof1z9p1hY4PzTE/UXpNqpccj4DnAN5AFGyhbvwRTvJK4JjFBz4lO07Q+x6duM+EEjTt5YxTpoyzKJ4i+cJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jwnk2lvO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458bece40fcso11106425e9.3;
        Fri, 08 Aug 2025 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754652979; x=1755257779; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wqjDekI/FqgVuMKcDdQW/dEhZCtWv8PfB2SrJJ73u5s=;
        b=Jwnk2lvOU+0N2jkTf92+y8GUwSQzlT8m1ynpwaq39ruGh7fov79w43MnPVBd5FYUYh
         cvq9MtD8mntGWQjboo1gKLIkCUDA5pc38XfuVMz0abzP0VnQju6LakN8ZimYWIz3YehU
         eOPoytXCYTkklly2+lPAHUqgkflsS57tOBzaTI9EnxsyMJXPvBf2ou9hLdlxUSv0RLy9
         qQUT9xe+8qtoricdWBsT/aLlpFUCvFaFqzRKBZXZPg8FDTR1YjE43FNmVU87MGNcDLj5
         radNx1MNE4fcn2QZ0GAQlt1OMw3rM4iYWTJZ7v3/IaNpilDl5aAEkHo7i42vOFkLaJvc
         ifEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652979; x=1755257779;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqjDekI/FqgVuMKcDdQW/dEhZCtWv8PfB2SrJJ73u5s=;
        b=hy062an8HGHWpg5lF/FAwJy4T/nixnzX0j5wH4wU3Sbtbj5jImT10XRgXFTPey9azs
         q3y+MuseytGFE4kMC+ci+EdKViiM5oBylP52fALerJ5ZQi2Z/G4tK29v69GCprkXx2CH
         Bis35laqp8+6akE/0ioEjT4CrYEOatn4z+7KhasJ7bQIHRpPMn+LcCuLVRzQ0E3M82zF
         GZyeNdjD+ZBo4nwpp/xF9p821Q6n7MFCsFdrHEQPvmLatnuvXOjvmXHqEANsJgK68q3C
         OF7FQXGENclXhJE0ucuGsOJaCIgyZGAqojdLGKi15+Mn7frfYwXHZEY2qPCEDo6Gdbmh
         7E/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJnoICIi4W23C5GNHPZsmm8yB222AIhBMyrXLeJrbgXXOiIsXAZdqWVj/vQ8uOoPt73Ns/OA9//KSRkkI=@vger.kernel.org, AJvYcCWzFLN4h+Ud8+hznTN0Dv54dz2R+9NaRNmtCDubw11SCbNRpjTLMSKzoI5hJNI3vTgrW2ZHeDQf5Sf8TYsmRpc=@vger.kernel.org, AJvYcCX3psemtm8UA7d+pz4bv1DMj+FCtuyBGl0cGL/XsBHjkLGYuN/cF447QMyRDUWAxU8pAB/ImqeoZWctKukH@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaWlLyldktJS/yY6HVyvpgPMw9bAuQ3QVkborcINzGdW/5I6B
	gFQfhr3YVy2f9cjfele12Pvbw49eN16Ni8TfyzZk8p8FjDKuHwqVoJrkdN4MlNKjOyvmUQ==
X-Gm-Gg: ASbGnctOgq6NY0py4Cyei4tmnxgAYcNWltaya37vTz0HzMCgIPQ3cO1Cc4wdm839Wiw
	6fMcd1nx3nRGDrrH19LC/2BJpeOwMEjwMuovsK7Cg6VxCrS907DCFHViPl3zKVm9t9Qr42z5BXF
	ZgZaw0HXxBpNU93eYQoAtYF0CSMwYJ9slHRMeDIos2pFAECgc8Gg+d4+ZVrMAC0ZwHq2OH2To/j
	VSZY0baGPnFSlMG4dCBWFiTs2R9dAQgMip4HJiyhkmC5veKOT5AMk/DWJBo1JKHlN+aRGu1LHAP
	ExtiHamJc9hNm/WvLVR1uZ+Qlv+qekZCFXU2TOwso7RjwzvFhWhhMC8zpk4HVb06NBAnGI2jgqs
	/CbaWLwzfdzPu0L315EhpgKewPe4R
X-Google-Smtp-Source: AGHT+IGHmmOAm/gXDASpJ+2tAZ38HNOlgMaT0C75ISIEm33G3XB8rE/wEcHfhsYkWRiS2p8oAL0dvA==
X-Received: by 2002:a05:600c:444d:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-459f4faf68cmr20284395e9.23.1754652979236;
        Fri, 08 Aug 2025 04:36:19 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4595cfea56fsm143467955e9.1.2025.08.08.04.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 04:36:18 -0700 (PDT)
Message-ID: <bb06d3bf-684b-4479-8b86-72aed622e453@gmail.com>
Date: Fri, 8 Aug 2025 12:35:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ASoC: codec: sma1307: replace spelling mistake with
 new error message
To: Mark Brown <broonie@kernel.org>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250808105324.829883-1-colin.i.king@gmail.com>
 <f646f36e-7835-415d-8da7-fc632c57e4e2@sirena.org.uk>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazcICSjX06e
 fanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZOxbBCTvTitYOy3bjs
 +LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2NoaSEC8Ae8LSSyCMecd22d9Pn
 LR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyBP9GP65oPev39SmfAx9R92SYJygCy0pPv
 BMWKvEZS/7bpetPNx6l2xu9UvwoeEbpzUvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3oty
 dNTWkP6Wh3Q85m+AlifgKZudjZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2m
 uj83IeFQ1FZ65QAiCdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08y
 LGPLTf5wyAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
 zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaByVUv/NsyJ
 FQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQABzSdDb2xpbiBJYW4g
 S2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEIADsCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoffxqgCJgUCY8GcawIZAQAKCRBowoffxqgC
 Jtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02
 v85C6mNv8BDTKev6Qcq3BYw0iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GO
 MdMc1uRUGTxTgTFAAsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oh
 o7kgj6rKp/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
 3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8nppGVEcuvrb
 H3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xtKHvcHRT7Uxaa+SDw
 UDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7iCLQHaryu6FO6DNDv09RbPBjI
 iC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9DDV6jPmfR96FydjxcmI1cgZVgPomSxv2J
 B1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8
 ehRIcVSXDRcMFr3ZuqMTXcL68YbDmv5OGS95O1Gs4c7BTQROkyQoARAAxfoc/nNKhdEefA8I
 jPDPz6KcxbuYnrQaZdI1M4JWioTGSilu5QK+Kc3hOD4CeGcEHdHUpMet4UajPetxXt+Yl663
 oJacGcYG2xpbkSaaHqBls7lKVxOmXtANpyAhS5O/WmB7BUcJysqJfTNAMmRwrwV4tRwHY9e4
 l3qwmDf2SCw+UjtHQ4kJee9P9Uad3dc9Jdeg7gpyvl9yOxk/GfQd1gK+igkYj9Bq76KY8cJI
 +GdfdZj/2rn9aqVj1xADy1QL7uaDO3ZUyMV+3WGun8JXJtbqG2b5rV3gxLhyd05GxYER62cL
 oedBjC4LhtUI4SD15cxO/zwULM4ecxsT4/HEfNbcbOiv9BhkZyKz4QiJTqE1PC/gXp8WRd9b
 rrXUnB8NRAIAegLEXcHXfGvQEfl3YRxs0HpfJBsgaeDAO+dPIodC/fjAT7gq0rHHI8Fffpn7
 E7M622aLCIVaQWnhza1DKYcBXvR2xlMEHkurTq/qcmzrTVB3oieWlNzaaN3mZFlRnjz9juL6
 /K41UNcWTCFgNfMVGi071Umq1e/yKoy29LjE8+jYO0nHqo7IMTuCd+aTzghvIMvOU5neTSnu
 OitcRrDRts8310OnDZKH1MkBRlWywrXX0Mlle/nYFJzpz4a0yqRXyeZZ1qS6c3tC38ltNwqV
 sfceMjJcHLyBcNoS2jkAEQEAAcLBXwQYAQgACQUCTpMkKAIbDAAKCRBowoffxqgCJniWD/43
 aaTHm+wGZyxlV3fKzewiwbXzDpFwlmjlIYzEQGO3VSDIhdYj2XOkoIojErHRuySYTIzLi08Q
 NJF9mej9PunWZTuGwzijCL+JzRoYEo/TbkiiT0Ysolyig/8DZz11RXQWbKB5xFxsgBRp4nbu
 Ci1CSIkpuLRyXaDJNGWiUpsLdHbcrbgtSFh/HiGlaPwIehcQms50c7xjRcfvTn3HO/mjGdeX
 ZIPV2oDrog2df6+lbhMPaL55A0+B+QQLMrMaP6spF+F0NkUEmPz97XfVjS3ly77dWiTUXMHC
 BCoGeQDt2EGxCbdXRHwlO0wCokabI5wv4kIkBxrdiLzXIvKGZjNxEBIu8mag9OwOnaRk50av
 TkO3xoY9Ekvfcmb6KB93wSBwNi0br4XwwIE66W1NMC75ACKNE9m/UqEQlfBRKR70dm/OjW01
 OVjeHqmUGwG58Qu7SaepC8dmZ9rkDL310X50vUdY2nrb6ZN4exfq/0QAIfhL4LD1DWokSUUS
 73/W8U0GYZja8O/XiBTbESJLZ4i8qJiX9vljzlBAs4dZXy6nvcorlCr/pubgGpV3WsoYj26f
 yR7NRA0YEqt7YoqzrCq4fyjKcM/9tqhjEQYxcGAYX+qM4Lo5j5TuQ1Rbc38DsnczZV05Mu7e
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <f646f36e-7835-415d-8da7-fc632c57e4e2@sirena.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EOqUQgryCyjXiV7Lyi8SuuNR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EOqUQgryCyjXiV7Lyi8SuuNR
Content-Type: multipart/mixed; boundary="------------ZDV4YxJGpWruhYU4cQ3NnUvB";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <bb06d3bf-684b-4479-8b86-72aed622e453@gmail.com>
Subject: Re: [PATCH][next] ASoC: codec: sma1307: replace spelling mistake with
 new error message
References: <20250808105324.829883-1-colin.i.king@gmail.com>
 <f646f36e-7835-415d-8da7-fc632c57e4e2@sirena.org.uk>
In-Reply-To: <f646f36e-7835-415d-8da7-fc632c57e4e2@sirena.org.uk>

--------------ZDV4YxJGpWruhYU4cQ3NnUvB
Content-Type: multipart/mixed; boundary="------------b1OTG31YK0yK6oIjOeBAu0f1"

--------------b1OTG31YK0yK6oIjOeBAu0f1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDgvMDgvMjAyNSAxMjozMCwgTWFyayBCcm93biB3cm90ZToNCj4gT24gRnJpLCBBdWcg
MDgsIDIwMjUgYXQgMTE6NTM6MjRBTSArMDEwMCwgQ29saW4gSWFuIEtpbmcgd3JvdGU6DQo+
IA0KPj4gVGhlcmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIGEgZmFpbHVyZSBtZXNzYWdl
LCByZXBsYWNlIHRoZQ0KPj4gbWVzc2FnZSB3aXRoIHNvbWV0aGluZyBhIGxpdHRsZSBtb3Jl
IG1lYW5pbmdmdWwuDQo+IA0KPj4gICAJaWYgKChzbWExMzA3LT5zZXQuY2hlY2tzdW0gPj4g
OCkgIT0gU01BMTMwN19TRVRUSU5HX0NIRUNLU1VNKSB7DQo+PiAtCQlkZXZfZXJyKHNtYTEz
MDctPmRldiwgIiVzOiBmYWlsZWQgYnkgZGlzbWF0Y2ggXCIlc1wiXG4iLA0KPj4gKwkJZGV2
X2VycihzbWExMzA3LT5kZXYsICIlczogY2hlY2tzdW0gZmFpbGVkIFwiJXNcIlxuIiwNCj4g
DQo+IEl0J3MgZGVmaW5pdGVseSBhbiB1bnVzdWFsIHRlcm0gYW5kIHRoZSByZXdvcmQgbWFr
ZXMgc2Vuc2UgYnV0IHRoYXQgZG9lcw0KPiBtYWtlIHNlbnNlIHRvIG1lIGFzIGEgd29yZCwg
SSBkb24ndCB0aGluayBpdCdzIGEgc3BlbGxpbmcgZXJyb3IgYXMgc3VjaC4NCg0KIkRpc21h
dGNoIiBpcyBub3QgYSBzdGFuZGFyZCBFbmdsaXNoIHdvcmQuIEl0J3MgbGlrZWx5IGEgbWlz
c3BlbGxpbmcgb2YgDQoibWlzbWF0Y2giIG9yIGEgbmVvbG9naXNtIGZvcm1lZCBieSBhZGRp
bmcgdGhlIHByZWZpeCAiZGlzLSIgdG8gIm1hdGNoIi4gDQpJIHVuZGVyc3RhbmQgaXQgYSBu
aWNoZSB0ZXJtLCBJIGp1c3QgdGhpbmsgaXQgaXMgcHJlZmVyYWJsZSBub3QgdG8gdXNlIA0K
aXQgZm9yIGZvbGsgd2hvJ3MgZmlyc3QgbGFuZ3VhZ2UgaXNuJ3QgRW5nbGlzaC4NCg0KQ29s
aW4NCg==
--------------b1OTG31YK0yK6oIjOeBAu0f1
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------b1OTG31YK0yK6oIjOeBAu0f1--

--------------ZDV4YxJGpWruhYU4cQ3NnUvB--

--------------EOqUQgryCyjXiV7Lyi8SuuNR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmiV4QwFAwAAAAAACgkQaMKH38aoAiYX
iQ//bAFPx9MlDhdy4MvVO4xXxowuRflEEQtAeOcnnrxYgwbYZgcvwLFUC5aHR4wETg+/PQZofEsj
ddGItJ4J/z7azeu9rcEc8E4ayfWyTbnKJPC/IATpZxmhcXIyZ8Qe6zjELDcJ6z3hEboJmekN1UpX
tlqp7RZ/cSle1ajXRlbSTJDswE1xaxUDAqF6MvWm903DQ+/zsJdMUjmU6y4eMDAUHN+djauR74VM
04cdE8gxNsxf8NBRapviQZ+e255sRuzE36tdKWrsj9ska7IQz8CpIkpp8xLUqpNeaiyV+T6cFhjt
not8cgkBVMEgR6yA5UcYU9P9CLLXvFNoiMjMbYRDVAuOSrdnA9SoBnZZHFJ9ENnuaOiRA+9o9Sdl
MnaBZn/obbsxtsXdI3+0p0lo14pjuhjGH4xPwOTy4e2eUt2gTM6rAFnUCQH9aymaEFbt21CKNGAj
asxFszfTsWFhnRBElFUS5HHzx0BcFD62irdRWBTNkatM80KAEwLcA7L7dGAmEF/r4m0gg4ty+Jr8
3mjCjo+f/bnjHT3THKSU443JnCORh0ww5OeoUdoLgSivTF00Zw9zY1sRyyqWrmxBrFdEKtx+Bb07
+6rc0isUf8S+t43v18RpFkuHQ3+BfT8NOfla5+Ri5IqBdHb9G76UJ0ueF+egqRPMcC4SjDZooBaC
pc8=
=Ne32
-----END PGP SIGNATURE-----

--------------EOqUQgryCyjXiV7Lyi8SuuNR--

