Return-Path: <linux-kernel+bounces-898387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD55C552D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 076424EBA39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30CB224893;
	Thu, 13 Nov 2025 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPBaYa46"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95435971
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994762; cv=none; b=moo7pZtu1pms7NnrNaF+f0EblI02k3SlrEaPhPoQ7Y1dFUmctPMsSepPr3Ct7fxydsj5VRctfBI5N1XQxjzLuQyq5Qb3XzbfNj9C0RquVmQM7PsBsk5waszIv8TdIGORcMS2AwcuhUztVvKl/OL0NDsuProSOWYt2oDG6ovT7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994762; c=relaxed/simple;
	bh=L6MdIryciHIIdyMFc25M+QNex8Bs9rTNozsEgXpbrcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5dyzGS64iXQw4FVvP3XtPtXqbN8SCa52y40uKuUQf1UkBRV85vgv2ekBRe/pTN84wQAboIKo7u/CHw5MUVDkO8xatYg6iroswYhqbcQBWZM0u2613+TXIPFZsbhUObpGE3b2pcaZWMweqjzQf2W6QC2yPnG3VOxjc7O1nggHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPBaYa46; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso1370955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762994759; x=1763599559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6MdIryciHIIdyMFc25M+QNex8Bs9rTNozsEgXpbrcE=;
        b=kPBaYa46DcTCyF8+det4oWE7acR45Xwt4J4zRE/LTBLziV0r+frd1+Tlv0q//U2OqQ
         5E+wwDQjSFo8RR+4Llruw8bZkX+p/6cWNfNx2YxXV8X+PkZYo0/KXWXtpItYT5pmV9AF
         ZAyxGYNNUQjhWIwB686Z65C5Y1mxnWQZ9lsYcg7RatNGBvN14Lc1KQQaSsep3BWiw08W
         Hx0iT50t18tLLugjYABCayOOnHRi3mOVCcVd9t4k1V6oXFHdp5DMbjW7bc67AUS48RDy
         8CKbq8Oz9fG9Y7v06I+pttZYn2vCyaTAZJz1X6t740Mztuz0uKlPl6mJuDJrs5oYaWku
         1B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762994759; x=1763599559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6MdIryciHIIdyMFc25M+QNex8Bs9rTNozsEgXpbrcE=;
        b=hpXL6JnE+YUYQe9nsxbaQhDORiV1aTxuSKW/x1BQPumxU2wYSYCKa0OxsYV7encdl/
         Kwran8u2ddI1X6verqVmhWY5Qxc4v6t2Ed/apVJNnr80/difdVFzyLykJB/BY0u/k3ku
         ++yY8zPMDwSxNAZZrmnfNetGgYmyLfRrA3EG/u4/yb1fE9eB4hX8UIWpDi/ZwAnB+uXG
         ajs8X9vcF+CXsEhk78YZfzDvcuUqvqaQTRgP53i02IUq459xeKEbx2b2WRDQPWQgDvGQ
         GnPWDji51cIoXtEBJZAdqX/5WBiVVzAh6foh4X55o+ISiIqQI0a/nYwRLnxJLyP7uYv4
         IREA==
X-Forwarded-Encrypted: i=1; AJvYcCVnUhTEbfaGDsbiC2AtoQH+hJWfSMZ6aqXwKfqR7vGy1vXZRPgqwJacAcqsSL9xu9F5trAuum0jFrfaW7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHnd7+ywIEihkBYR/fqnR79Vdhgw8B6bJG/1LP2fuVFj+4CcX
	oOZn/wFfdZTKhn9WX8lL52w1D807oIicMZ7mekBrtDtdHJqe3DY9rccT
X-Gm-Gg: ASbGnct+yMw6J6CcPC/H2hX0CeybtF2nWLOc/01B+3XgeOFRy5W3/EjaoumufrleSef
	yskRQIyfNSP+ACHVQKz+aaFklaSwTD6d5fLtqyTOmscuMHT63Oh+9g4KnQsswMV/D/zFelHr1T1
	rFb9w9m9OHOsVeuB/NfBzutfvIHveRp0npgusfEdxfzcsIeTIQUuwy4S+xhYdkQ1sZ71Pp8pXhT
	VADQehDW3MjvnT1Qdzpy2Gea73w3fs9CET/LeZRL4MjAT9H9E4eJ/HL+6/UNLBjvdddIJaPguoG
	E9KtcZHRWDwyhErKGp+H0Qbb1iBggUvQWtATF6R5bJnhqWUxicEqd6KgMq/6ijkQE9ePQAuVom3
	n4No+owKvGapGxS/ap3BtaDOG9izhZhgZF+AlWz6DOqfL172rA7+aYTnNpw5WRGJggfb9960XOg
	ZvNoiccWdZf8wx
X-Google-Smtp-Source: AGHT+IG8UNRUrUrgXbekaKPn2Po1l5mxi8W3YJa544txuMvsGRwAmb+3uXskvL2GPN1MJkZnmeqFMg==
X-Received: by 2002:a05:600c:3550:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-477871c4762mr52607495e9.28.1762994758707;
        Wed, 12 Nov 2025 16:45:58 -0800 (PST)
Received: from [192.168.1.121] ([176.206.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm625869f8f.17.2025.11.12.16.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 16:45:58 -0800 (PST)
Message-ID: <7566a1df-35d8-4c47-adeb-4f1087a7ce0b@gmail.com>
Date: Thu, 13 Nov 2025 01:45:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>
References: <20251101104712.8011-1-lkml@antheas.dev>
 <CAGwozwE+3vkm0-amRqnNJBzxTvXabgBF9h_G_vG_L7OJj91LBg@mail.gmail.com>
 <27a74ecc-bff7-f3ae-b23e-a8362ac3a6b3@linux.intel.com>
 <CAGwozwGpacR=wYXpf3vOiwWNxaV6pJ6CdE-E-G1gRRpO4VHVMg@mail.gmail.com>
 <74f91d3c-6494-4754-a10f-4d8c1d45f7ff@gmail.com>
 <CAGwozwEKqqJxxmtjJhy2MzNVhmBTMmy8xG5TZGkKJqJCgK=X5w@mail.gmail.com>
 <CAGwozwH4_5LnJ4kt-sbdwzL5Ezt74ddPOpGqvTvKiiVzkorSMQ@mail.gmail.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwH4_5LnJ4kt-sbdwzL5Ezt74ddPOpGqvTvKiiVzkorSMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/13/25 00:22, Antheas Kapenekakis wrote:
> On Wed, 12 Nov 2025 at 23:08, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>> snip
>>>> Sure, sorry if it came out this way. Dennis had two comments on the V7
>>>> version of the series.
>>>>
>>>> The first one was that asusctl has a hang bug, which he hasn't had
>>>> time to look into yet. This should have been fixed by dropping the
>>>> HID_QUIRK_INPUT_PER_APP. I retested the series and that QUIRK was a
>>>> bit of a NOOP that does not need to be added in the future.
>>> So it is supposed to not regress it now, correct?
> I missed this. Spaces. Yes, quirk input per app created around 3 more
> input devices per USB device, plus the dynamic lighting one, so you
> went from 2 to 6, and there seems to be an issue with asusctl and a
> large number of event devices, that caused some intermittent freezing
> when the user typed on certain keyboards. I removed it. Although, not
> a problem with the kernel itself, per say.
Okay, I will ask asus-linux kernel man to load this patchset then.
> Antheas
>
>>>> The second is he is concerned with dropping the 0x5d/0x5e inits. Luke
>>>> said (back in March) that it is fine to drop 0x5e because it is only
>>>>> snip

