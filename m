Return-Path: <linux-kernel+bounces-676804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5403AD1165
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 09:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D743ABF78
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 07:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC281FECAB;
	Sun,  8 Jun 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzeHcGu4"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCD179BD;
	Sun,  8 Jun 2025 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749367466; cv=none; b=tqZbxCQmge5I7kU9Q1EmGAXVI6dFkN1cL9e4ola65ftTlw6akPDZ1m7LwWOQL5qQDUeX9J215qU0DXHVGyLJnqW8g8jTdSqCQ0OurDz21rXQHahcH1p+NQxf8q+8ypcqMnIdPEquBPkOuFjdtJqRmnZovMvP+c0ZfIgxP8Aygto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749367466; c=relaxed/simple;
	bh=57hSiaTP5shRl7ezdEzQTTVn75tu6DF7CI6RglBP6D4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AqC7fEAhm09OnW1JTFPJxR5Jj6DvtxZZI5luTM3KNbxF4o5DlGa59nKJ+S+h8HVBsX4GOYTMBGSFDDtKqPa2cg2qljJQgzqvuLczaD+aaHFFAKucdWqoUgf/haQKSr0l6qc1C3Lqn2Iv7xq2B7qZeKtbwE9kHRlMQlRVNM96/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzeHcGu4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso6910157a12.0;
        Sun, 08 Jun 2025 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749367463; x=1749972263; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eME8R9QRUtbMs6yNjgukeDUBZeLszNLIRLLaAcTHowg=;
        b=EzeHcGu4H0u5AeUarGh98PNi15CCaNX9qKG5Q3S0dIqhI3yBf1GcevBwcVRGmgIwVJ
         Cumv2RWDdrY3LJo0NJlNSP2es+sd911PXimueeJLH9t2X9jBpL3GzWFsBhQEq7kEqwnU
         LslXFwFWqro/0W+smOogpB44JG3GeuHtcK58wk+9UXFBpC4ANWYgOqOgWO0XcqU8xazJ
         0ob2wypQ5eTB1jjxjmsORntCkLnVl+u92j+DNi3vksh9xKnhHb5Ee63GczpjQBese8qI
         roT9iBlW9sf2pL0i+emDlAOASfBXY3khbFGDydkh5SBeUf+h8wdZegsExfuGMbaPNjEU
         BwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749367463; x=1749972263;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eME8R9QRUtbMs6yNjgukeDUBZeLszNLIRLLaAcTHowg=;
        b=MekGArlo1aG3iiAcYwxDjA2Sycs4oRiOnxxPvZGZPC/2TbpBuRmoALIwFmCIa/BTVQ
         uAKd5iRcgKBLeQ4CMDDimxJdxydDG58UKxhybaLgW5JNS+pxM7O+5MSico3hcB+e/hoP
         laIaEUtEXl4Jf8fuZLZoD4Jyx5ErLvfJU9iti1rtSwRkUkYb80fXQpcUd3NC8X4mP+Tp
         J4SeSbMXWf8GXk5CC6LPtMup9nFjIbaeBwExayBIidqZbZdo4FYqDYDhwId74U1AEqYe
         mk05u1t46nydNY0g4ZXhN4w+kLGD0TgU4H9masJdF5Jtx8T7lJXiUbpi+MigmpSYMEdH
         PchA==
X-Forwarded-Encrypted: i=1; AJvYcCW6qlaCXrSlfj6T4wbkiqT6F9wk1ilPXCtjj7T2+2ZpS/LdJQZ6ZFZtN+KSyDGcGp0Gjmt8ThDStjS2wSsk@vger.kernel.org, AJvYcCWZKk1QCWOsZgdJYftpkiWNGxZeSldeKMtohe9mmX0nBqwmlvFpugaO0rH7h+i6tJpiO4LfhlRhsCoT@vger.kernel.org
X-Gm-Message-State: AOJu0YxndaCZY4RZBiaHJN8lE5XyKgiKqwDuX9ScVLlZLTQZ8xi9ZBts
	AvY1F9/dm12Twn5+aM5zT1ZIoM25I8h6qzGEaeFoa76ZtE7yTFguhE1m
X-Gm-Gg: ASbGncuOHBbdSFxVzq3qKo+583x7X1FHo/8MrDa3GrhTVhyxZWM8HMuk5Of/PLtHGvE
	fBKTsSTUxoQKBe27r2rC+WJ2W0dsRyHOejh1DAZyITShFUbqaAvrMME64qWlNuWBDeESUuoBZTJ
	P2DCYWZSCX9lcC822JKcUy9lTlWU4KeywmBlRvSRe2jpkCD4+8O4ke8RJ8/AfpJtB7U3OXjzET0
	ezO8aZCiHlAo03BcmdsbOfGh7U14khCYSCGapEX5a2cwZ98K0jgDpVmjtFWLhTFpgMe0ebsV1Zs
	HDPdlVjUf9O5WVTvicjM0Lkue/txvkiLQcB+VnXIQZXLKqGYFXLqaNqIEqHcJUbqRmyFUnd+kic
	=
X-Google-Smtp-Source: AGHT+IE+XmhJc7d167/vUVHeiWx4qLdJOR6bmn1GqWpi8Ro1n4e919Y0SIMV5NJqYG4wzcTnJIM2Iw==
X-Received: by 2002:a05:6402:2807:b0:607:eda0:16a0 with SMTP id 4fb4d7f45d1cf-607eda01799mr117773a12.11.1749367463336;
        Sun, 08 Jun 2025 00:24:23 -0700 (PDT)
Received: from smtpclient.apple ([89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783e66e6sm3191240a12.81.2025.06.08.00.24.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jun 2025 00:24:22 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: list all CPU supplies on ArmSoM
 Sige5
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CABjd4YxGQP=rH15EX12w36b7+82Dedf+rVH3v5V6gBwNv3V3iw@mail.gmail.com>
Date: Sun, 8 Jun 2025 09:24:09 +0200
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <90218D7B-0CF5-4F5D-969A-909A44E6044F@gmail.com>
References: <20250603-sige5-updates-v1-0-717e8ce4ab77@gmail.com>
 <20250603-sige5-updates-v1-1-717e8ce4ab77@gmail.com>
 <6656934.DvuYhMxLoT@workhorse>
 <CABjd4Yx05SCm+03jWbsEP-A5AuhL14wLj=+VdKyQgqMbnxi3xQ@mail.gmail.com>
 <512E950E-E8CB-443B-8E47-79F073D217E8@gmail.com>
 <CABjd4YxGQP=rH15EX12w36b7+82Dedf+rVH3v5V6gBwNv3V3iw@mail.gmail.com>
To: Alexey Charkov <alchark@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> Wiadomo=C5=9B=C4=87 napisana przez Alexey Charkov <alchark@gmail.com> =
w dniu 5 cze 2025, o godz. 15:42:
>>=20
>>>=20
>>>=20
>>=20
>> Alexey,
>> I see you are using rk3576 board like me (nanopi-m5)
>> Have you on your board correctly working cpu dvfs?
>> I mean: [1][desired clocks reported by kernel sysfs are in pair with =
[2[]cur clocks?
>> In my case i see mine cpu lives totally on it=E2=80=99s own with =
dvfs:
>=20
> Hi Piotr,
>=20
> I haven't tried to validate actual running frequencies vs. requested
> frequencies, but subjective performance and power consumption seem to
> be in line with what I expect.

well - my subjective l&f is that  - currently - my rk3576 seems =
=E2=80=9Eslower" than i.e. 4xA53 h618.=20
This directed me to investigate this issue.
Test run was media player (mythtv) where ui has gl effects and ui gl =
transitions =E2=80=9Espeed=E2=80=9D are quite proportional to cpu speed =
(and gpu).
My overall feeling is: ux is comparable to slow socs 4xA53@1.4GHz/G31. =
This is with mainline atf + collabora uboot [1] and on-demand gov.
I done test with replacing uboot from mainline atf + collabora uboot to =
bin. dump of vendor uboot (2017.09) and with this ux become almost as =
expected (i mean comparable with i.e. rk3399).

I done test with perf gov. and

1.collabora uboot[1] + mainline atf 2.13
2.collabora uboot[1] + rockchip rkbin bl31 blob [2]
3.vendor uboot (bin dump from friendlyelec ubuntu image)  =20

[a] on vendor uboot:
Requested CPU4: 2304 MHz=20
Requested CPU0: 2208 MHz=20
Running CPU4: 1008 MHz=20
Running CPU0: 1008 MHz=20
Measured on HW: 1580.11 MHz=20

[b] on collabora uboot + mainline atf:
Requested CPU4: 2304 MHz
Requested CPU0: 2208 MHz
Running CPU4: 816 MHz
Running CPU0: 816 MHz
Measured on HW: 808.72 MHz  =20

[c] on collabora uboot + rockchip rkbin bl31 blob:
Requested CPU4: 2304 MHz
Requested CPU0: 2208 MHz
Running CPU4: 816 MHz
Running CPU0: 816 MHz
Measured on HW: 812.49 MHz

in all cases all clocks are constant as they should
Interesting that on collabora uboot [b][c] measured clock is 808 vs 1580 =
on vendor uboot [a]...
sw video decode conforms this diff: hd h264 gets cpu load: 172%[b][c] vs =
87%[a]

=E2=80=A6.

>=20
>=20
> Are these taken on the mainline kernel or Rockchip one?

I tested:

6.15 mainline + some collabora patches

1.collabora uboot[1] + mainline atf 2.13
2.collabora uboot[1] + rockchip rkbin bl31 blob [2]
3.vendor uboot (bin dump from friendlyelec ubuntu image)  =20


> Binary BL31
> from Rockchip or opensource TF-A? With big-core CPUs linked up to
> their supply regulator (as per this patch)

yes

So summarising:

1. i see kind of issue with clock values (e.g. perf gov gives 800MHz on =
mainline atf).=20
imho rot cause seems to be in collabora uboot

2. on-demand gov. seems behave much more like powersave.
this seems to be 3576 specific:=20
-on 3588 change from perf to on_demand is hardly noticeable in ux
-on 3576 such change makes ux feeling noticeable slow (like 4xA53 soc)
i think this is more related to diff between scmi mcu gov algo in 3576 =
vs. 3588
(imho 3576 algo has high latency in clock increases when demand happens =
+ too short delay for  clocks decreases to save power)
    =20


[1] =
https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot
[2] =
https://github.com/rockchip-linux/rkbin/blob/master/bin/rk35/rk3576_bl31_v=
1.15.elf


