Return-Path: <linux-kernel+bounces-762082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1040DB201F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCBF189ED30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E922DC332;
	Mon, 11 Aug 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mHe8i0Qb"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF71F76A5;
	Mon, 11 Aug 2025 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901536; cv=none; b=aN2M4Mh9zBHZVIcqpGTdTMHPCUrH9AxMC8oFcxKHmwiwwCJeTvZZRB4I/k5eTsNVWrX0g2dmJTnDYJDGe0dGh1go2ERVp1EUKT3m/JtGkAY+cw3H40ewV779XCvPg7ueACMjwsrSCEX+JdkYnVQ1InU34WKfBkXoxlULE98QnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901536; c=relaxed/simple;
	bh=I5kNPzmFS0TrQM08QzuZwvVJEvGEI9YCa4Is7YA/p+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQaiGNU8bLU4czKcoCxodTjSO69JG2aZLmVE5fa2+u/E07gmc7QI6Xr7q7vwCGhwQDwN8Jg3xyKRglwX4W+Lf4+r1skepBJjROVBTO66EDuwADPUy5gr6Y9f5JkqMVgOuXA31butWxVuzWUyY3MBVjCcFg8F032i29kT3jnVbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mHe8i0Qb; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754901522; x=1755506322; i=w_armin@gmx.de;
	bh=I5kNPzmFS0TrQM08QzuZwvVJEvGEI9YCa4Is7YA/p+U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mHe8i0QbAguLllPuZ8wLo3CSP1YeAeqe7pymZmhHsxrC0c0Q/bjx+dJ1Isrsepzv
	 TyDrpe3TEMrotLXlgF7ryCXqi2K+GcJXcOLrVqIFrWUUE+Ls9px26xBhlpaLjiB9b
	 6bIhqOXzohy5IE+WNdsHYAiA1ymL+nmcieKFzv0CYQdf5jR3mPWb3vCPd22+yuBWy
	 CsBpR6n5t5tNd6/hH1EuvvOmkWLJE6nWEryghlgc1cZME2mWuRPjENt3phDY4TcIX
	 i4WQO64ZSB9LfWYJoN9AYFI6HQ4YRBtqh0OjzyAJRzz8wCqsle0NTYfEA02xDEawj
	 kPfUzORmpZyIIUapJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([91.14.231.131]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1uywzK3dBb-00YQ8U; Mon, 11
 Aug 2025 10:38:42 +0200
Message-ID: <5531e051-ad62-4cfd-a733-21f04385e1bb@gmx.de>
Date: Mon, 11 Aug 2025 10:38:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Alok Tiwari <alok.a.tiwari@oracle.com>,
 David Box <david.e.box@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
 <20250726204041.516440-2-derekjohn.clark@gmail.com>
 <5b061220-e04a-48b5-ba2c-92ccf240798e@gmx.de>
 <CAFqHKTnkPLEbMk+NeLaSridSJBGU+P4P5PFF7VmiQbcfv7CAkg@mail.gmail.com>
 <404b9bfd-66c7-4524-a7ec-34fa9eb046eb@gmx.de>
 <CAFqHKTnO2NQ+_q_FOwT74Ukg7tx2k3B_sksEhNBzuCeZEWe3FQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAFqHKTnO2NQ+_q_FOwT74Ukg7tx2k3B_sksEhNBzuCeZEWe3FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n5xXGsRRFknq9bL6r+gn9PebfWjFHtEUJJQ58Yi5HRszTj3vCbj
 /xFhmU2S2Mo5YJzAjHsjh6Qs2KtYwJlBrUH734Q+tYwe1EsW6l8Xj7HgYyOwbA0p+CwsXfI
 d8f1UMWhRCj2Q+x8FWBYZXatUzd/lsbdnrC9r4luYTfWyOeNoTAkkhyHUyYsPR8FfWyv+q6
 myKMeOrA8Ig+kxNgCMKxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nIsSwjlLkqM=;1ncjVrOFr/WZgWnoGRQXYIoNUhG
 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

Am 11.08.25 um 00:27 schrieb Derek John Clark:

> On Mon, Jul 28, 2025 at 9:10=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 29.07.25 um 04:58 schrieb Derek John Clark:
>>
>>> On Sat, Jul 26, 2025 at 4:32=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
>>>> Am 26.07.25 um 22:40 schrieb Derek J. Clark:
>>>>
>>>>> Adds platform driver for AYN Loki and Tectoy Zeenix lines of handhel=
d
>>>>> devices. This patch implements a hwmon interface for EC provided man=
ual
>>>>> PWM fan control and user defined fan curves. A global ACPI lock is u=
sed
>>>>> when reading or writing from the EC.
>>>>>
>>>>> There are 4 fan modes implemented in this patch. Modes 0-3 act in
>>>>> accordance with the standard hwmon logic where 0 is 100% fan speed, =
1 is
>>>>> manual control, and 2 is automatic control. As the EC only provides =
3
>>>>> modes by default, mode 0 is implemented by setting the device to man=
ual
>>>>> and then setting fan speed to 100% directly. In mode 1 the PWM duty =
cycle
>>>>> is set in sysfs with values [0-255], which are then scaled to the EC=
 max
>>>>> of 128. Mode 4 is an automatic mode where the fan curve is user defi=
ned.
>>>>> There are 5 total set points and each set point takes a temperature =
in
>>>>> Celsius [0-100] and a PWM duty cycle [0-255]. When the CPU temperatu=
re
>>>>> reaches a given set point, the corresponding duty cycle is automatic=
ally
>>>>> set by the EC.
>>>>>
>>>>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>>>>
>>>>> space
>>>> Interesting, do you have access to such a device? If yes then i would=
 be very interested
>>>> in looking at the ACPI tables shipped with said device.
>>> Hi Armin,
>>>
>>> I have a Loki Max, and know someone with a Loki Zero. Do you want
>>> plain text acpidump or a decoded DSDT.dat attached?
>> I would prefer the plain text acpidump, as the SSDT tables often contai=
n important data.
>>
> Attached is the plain text acpidump, sorry for the delay. I'll also
> note that Ayn provided me with documentation of the EC commands for
> this driver.
>
> Cheers,
> - Derek

Nice :)

I also noticed that the ACPI code itself uses EC register 0xB0 to control =
the battery thermal limit. This would
conflict with your usage of register 0xB0 as the RED RGB value. Does the d=
ocumentation mention this register?

Thanks,
Armin Wolf


