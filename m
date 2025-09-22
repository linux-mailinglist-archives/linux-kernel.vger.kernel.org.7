Return-Path: <linux-kernel+bounces-827837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CB1B933BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A087A4D03
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EE4257855;
	Mon, 22 Sep 2025 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="nyo6oT3T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/yyLiv+"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71797261D;
	Mon, 22 Sep 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573027; cv=none; b=MW26O1LEHEcLD0yUikZ4NXCoEgi+UwMaN5mx016GvvioOQp0MtTsmPzCuJ9q98RRczpwojWMQ4SzQS74ZXY+KM1GVCLXX8iLk81d+AX3baKdg1VekPja/IBKZ6fJ5nJ1xrE1qVj4pvfvr4FrmB4TtoWUHP0/EgT1FG+gykkvphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573027; c=relaxed/simple;
	bh=OfAHROsZ/7AD+4yQPz8CC8L4N9Jmv4p9hLytTyE08bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6cBRJlNIY5lNw47dnRZzXI8awifbA3e7Uct5KYKAGV+S4mJ/K8W/AC7e12fmmeJpHkD0DhSQhZUbwgveTKviMHDdKQodG0n6yZ0IspRbn+5Vq79Ej4Jwsit6rnxACKLXv1pycjO1n75yyTukrqSpGMOpWcSV+TA7t1fN1CKlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=nyo6oT3T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/yyLiv+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B78311400195;
	Mon, 22 Sep 2025 16:30:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 22 Sep 2025 16:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758573024;
	 x=1758659424; bh=f21DJ6iYS1AxepjbbwpyUgIz1EeYo2MNWy5iIbDBSNA=; b=
	nyo6oT3TzFlY5I0WXnpyAEAGvwZ7yrOX381aUcW9MCrYjV1HUsv9GNg3x9EVY5/Y
	QWL6QAHCBzf4jqps7hUL3qLz08wWgu5L9PApxBmv5Nq2GjC2S9Mw32eH7y5FSsrL
	mfMy+vxc2HGCVhIXq5c7ufejrBWddxrhN7H/vmBJ6lIfF2d29hXEE4guxmCGb6O2
	tAN9UZB/6gYpk3kLx+AOh7wcP9SFQxEWxTgBKNMOYxfIg694Z2HsKPnMoL+Ll5Xv
	wA9u54MFXg7WqqinMg3l/QI9rhMTX1kA1HkQpcYjsI1CL34LwrH+rbI6Q/DcrN91
	PsPP3aIPgrWohrbWxj925w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758573024; x=
	1758659424; bh=f21DJ6iYS1AxepjbbwpyUgIz1EeYo2MNWy5iIbDBSNA=; b=U
	/yyLiv+pWD3PyJ3colP+XRK6MtW9++tb2sQ00VzQVnQg92g9ccest3ombaG+YE9Z
	Krp5L8hUTSwwYZBpJHra0KTIURfdnOoyX97uyApKmoZpR+6I9N3SkjCLej4/U4LK
	W27W/vuevB1bUNXLn79QfBKen7v8V4DZpm0g34qjTPm4Th2j7O3z714F5uVU9yol
	YAOQTQVGV2eFRnFHuR0t+gdIMGUv+R5x9d/FkA6uAN01QUeF4gXdInta6cHiDpUO
	hmWokA3rolCedc/plYPHvqBVG/la2lgP/LZNJurANuWShYf7RfoIoqu2BtqcwujY
	ZqmsIN51rVyGYb1xe6s3g==
X-ME-Sender: <xms:37HRaIwsafr6gF3kyW0TLuRr05Zet02ihsvoDiCsstmJ3xvHKBm5hQ>
    <xme:37HRaIKSwoxwHK11CbSILFjipTABJQ4lz85Fs-wSsrqBypGmoJEqed1pxua3eIG4x
    RWTyUIAPiBNQ6FvK89blT_-RMo88N3Ez91tGliBzaMVDccw0QqEklnX>
X-ME-Received: <xmr:37HRaHVIHFrvchhMAVw8xJPWG_KL1xYPiWSMNivnGnuUo4hlX_T7MeUbQC7yDEsqLf51VWu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptfgvsggvtggt
    rgcuvehrrghnuceorhgvsggvtggtrgessghsughiohdrtghomheqnecuggftrfgrthhtvg
    hrnheplefhgeevleehieeuveduudfguedtieetteevhffgfffhhffhveffueegtdegkeek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsg
    gvtggtrgessghsughiohdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeiivghvsegsvgifihhluggvrhgsvggvshhtrdhnvghtpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpthhtohep
    rghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhope
    guvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsghsrdho
    rhhg
X-ME-Proxy: <xmx:37HRaLZiMcZINQDA-uN_LIPEmV_2dg0aaXPTlLUgkpr3xZ7YeQEAKA>
    <xmx:37HRaOzEz13wT_YWvqqDiFluHmxDfIwe9y7cAe2MqgagHS8kgzgsSw>
    <xmx:37HRaL0doQA-z0ua5-aE69gyuEoO6O8YFf-A-gIHr5jrgYcwcxbgVA>
    <xmx:37HRaPkNGJxoOUR2aaf1rlJRRsI-G33G6vzTzi4gAB_GkHccQ5D49Q>
    <xmx:4LHRaF988bm42vHCFUaajGuBKhBjIO4Bn-IfDrAeVWs788Ar0EZuBfyb>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 16:30:22 -0400 (EDT)
Message-ID: <354c5977-2bab-446f-9ae0-b01d678fd74f@bsdio.com>
Date: Mon, 22 Sep 2025 14:30:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
To: Zev Weiss <zev@bewilderbeest.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <20250917180428.810751-3-rebecca@bsdio.com>
 <66c5bf80-a3ef-4984-82ce-6d1720b15d38@hatter.bewilderbeest.net>
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <66c5bf80-a3ef-4984-82ce-6d1720b15d38@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/25 00:29, Zev Weiss wrote:
> Here and on most of the other i2c busses, is there a particular reason 
> we want this bus-frequency explicitly specified?  100kHz is the 
> default according to 
> Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml (and the other 
> existing aspeed-bmc-asrock-*.dts files leave it at that implicit 
> default, FWIW).

There's no particular reason - I've deleted them.

> It looks like this device only monitors temperatures?  If so, perhaps 
> temperature-sensor@29 would be a slightly more appropriate node name.

The chip can also monitor power supply voltages and fan speeds but on 
this board it's only used as a temperature sensor, so I'll change the 
node name.

> channel@1 and channel@2 block bodies look over-indented by one level 
> here.

Thanks - fixed.

> Are these correct?  On every other ASRock board I've dealt with, the 
> eth0 address is at 0x3f80 and eth1 is at 0x3f88.
>
> If so and they are really for some reason swapped on this platform, as 
> a slight nitpick I might suggest swapping the order the nodes are 
> listed in so they go in order of increasing addresses.

After installing the latest 3.06 BMC firmware from the ASRock website, 
I'm seeing:

root@altrad8ud-1l2t:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 9C:6B:00:43:0B:F7
           inet addr:10.0.0.25  Bcast:10.0.0.255 Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:457 errors:0 dropped:0 overruns:0 frame:0
           TX packets:240 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:88379 (86.3 KiB)  TX bytes:17663 (17.2 KiB)
           Interrupt:26

eth1      Link encap:Ethernet  HWaddr 9C:6B:00:43:0B:BD
           inet addr:10.0.0.11  Bcast:10.0.0.255 Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:368 errors:0 dropped:0 overruns:0 frame:0
           TX packets:26 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:88134 (86.0 KiB)  TX bytes:3507 (3.4 KiB)
           Interrupt:27

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           inet6 addr: ::1/128 Scope:Host
           UP LOOPBACK RUNNING  MTU:65536  Metric:1
           RX packets:434 errors:0 dropped:0 overruns:0 frame:0
           TX packets:434 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:34479 (33.6 KiB)  TX bytes:34479 (33.6 KiB)

usb0      Link encap:Ethernet  HWaddr 4E:F6:84:8E:63:B9
           inet addr:169.254.0.17  Bcast:169.254.255.255 Mask:255.255.0.0
           UP BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@altrad8ud-1l2t:~# hexdump -C /sys/bus/i2c/devices/7-0057/eeprom
...
*
00003f80  9c 6b 00 43 0b bd ff ff  9c 6b 00 43 0b f7 ff ff 
|.k.C.....k.C....|
00003f90  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff 
|................|
*
00003fd0  1e 90 db 9a 13 ff cb ff  4e f6 84 8e 63 b9 8e ff 
|........N...c...|
00003fe0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff 
|................|
*
00004000


I don't know why they're swapped, but I think keeping them that way 
makes sense to avoid people's IP address changing.

> As the DTBS_CHECK lint reported and Andrew Jeffery commented on, these 
> two partitions overlapping is a bit surprising -- is that intentional?

It was intentional since I've updated the firmware update script to be 
able to program the TF-A or UEFI areas separately, or the entire code 
region (i.e. TF-A _and_ UEFI, excluding the data/configuration areas of 
the EEPROM). But I'll update the script to not depend on there being a 
'code' partition that covers both areas.


-- 

Rebecca Cran


