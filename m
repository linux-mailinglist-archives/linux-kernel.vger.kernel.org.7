Return-Path: <linux-kernel+bounces-860469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA5BF0316
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DE5A4F1C58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1273D6F;
	Mon, 20 Oct 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ULhkehzu"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEA167272
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952776; cv=none; b=LorkncwDAa6fV0kP/QZ3HWY9R3mIn5UFAB7I8B11Vo1TTr/Nr7tKjGCuuG1hpiHcI3sOF9gwwDeZkFXyYnnTARn5jQ0R3aWVyKPvJOqSd3/0vLJBVWLD5jM/B98EU+0DBVJfOmbDo5VFX+uSlid0weLiNjFlPLeuyC4Y7SZADhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952776; c=relaxed/simple;
	bh=EQQSvK9Zes0aGSRKn3lcU0vKC4Njc8y3MfnUjJQjcuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYl+7R7Mdt3dliyVW1U04NGD/I51siHU0OfjQPCkwCy6+z6K7hD66v4kcSCEzhp3nd5fmQVWry2cA68n0ec+7TCG2nH1nX5G3u0cWPS9x10Pb1kO1uDLDQtw/xQe2GxoBp8QuLdOtxnd/bgy1XSm+r+ZDKsCyH9uIgvNApj5CQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ULhkehzu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EB38C4E4120B;
	Mon, 20 Oct 2025 09:32:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BF17A606D5;
	Mon, 20 Oct 2025 09:32:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 647E9102F23A5;
	Mon, 20 Oct 2025 11:32:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760952769; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gtraHV6tD9LMKBudKXJHrkWgzDDis34qevkyGhCtEA4=;
	b=ULhkehzui4+Ze3NHhCw8OMTAHXwv4oGVtZa0hDSLkxX/UG8SvbSN0PjmVqYIdg0iX0jix5
	W4Zeq952RjF+8bdaxgfHOThl4QttcfUWbaPvfHrbHz29UEAhGpS3z0lb/iWan1+yfcx4wO
	awLEDw2RDqcNsPYcqlg0IqtPsTBNgsEP+t0zGAaV4zU3V+a4PGjnBgIZWwt0b+cA2yKR40
	5W50Pov7mZOjSJbmpm/UosEQdHDokkvAnlXm0QimgTH2qhPv7EzlMoDZo3htdoieFGV297
	yIwq1ovbcf7gGKx0bx88ZmpdC1lLiE70c6uNN8+A6dxF0wv4+9UMGzLAY5jZeQ==
Message-ID: <b2c58580-d891-4d10-b3dd-572f7f98c6fe@bootlin.com>
Date: Mon, 20 Oct 2025 11:32:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015102725.1297985-3-maxime.chevallier@bootlin.com>
 <20251017182358.42f76387@kernel.org>
 <d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
 <20251020110040.18cf60c9@kmaincent-XPS-13-7390>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251020110040.18cf60c9@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Köry,

On 20/10/2025 11:00, Kory Maincent wrote:
> On Sat, 18 Oct 2025 09:42:57 +0200
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
>> Hi Jakub,
>>
>> On 18/10/2025 03:23, Jakub Kicinski wrote:
>>> On Wed, 15 Oct 2025 12:27:22 +0200 Maxime Chevallier wrote:  
>>>> The DWMAC1000 supports 2 timestamping configurations to configure how
>>>> frequency adjustments are made to the ptp_clock, as well as the reported
>>>> timestamp values.
>>>>
>>>> There was a previous attempt at upstreaming support for configuring this
>>>> mode by Olivier Dautricourt and Julien Beraud a few years back [1]
>>>>
>>>> In a nutshell, the timestamping can be either set in fine mode or in
>>>> coarse mode.
>>>>
>>>> In fine mode, which is the default, we use the overflow of an accumulator
>>>> to trigger frequency adjustments, but by doing so we lose precision on the
>>>> timetamps that are produced by the timestamping unit. The main drawback
>>>> is that the sub-second increment value, used to generate timestamps, can't
>>>> be set to lower than (2 / ptp_clock_freq).
>>>>
>>>> The "fine" qualification comes from the frequent frequency adjustments we
>>>> are able to do, which is perfect for a PTP follower usecase.
>>>>
>>>> In Coarse mode, we don't do frequency adjustments based on an
>>>> accumulator overflow. We can therefore have very fine subsecond
>>>> increment values, allowing for better timestamping precision. However
>>>> this mode works best when the ptp clock frequency is adjusted based on
>>>> an external signal, such as a PPS input produced by a GPS clock. This
>>>> mode is therefore perfect for a Grand-master usecase.
>>>>
>>>> We therefore attempt to map these 2 modes with the newly introduced
>>>> hwtimestamp qualifiers (precise and approx).
>>>>
>>>> Precise mode is mapped to stmmac fine mode, and is the expected default,
>>>> suitable for all cases and perfect for follower mode
>>>>
>>>> Approx mode is mapped to coarse mode, suitable for Grand-master.  
>>>
>>> I failed to understand what this device does and what the problem is :(
>>>
>>> What is your ptp_clock_freq? Isn't it around 50MHz typically? 
>>> So 2 / ptp_freq is 40nsec (?), not too bad?  
>>
>> That's not too bad indeed, but it makes a difference when acting as
>> Grand Master, especially in this case because you don't need to
>> perform clock adjustments (it's sync'd through PPS in), so we might
>> as well take this opportunity to improve the TS.
>>
>>>
>>> My recollection of the idea behind that timestamping providers
>>> was that you can configure different filters for different providers.
>>> IOW that you'd be able to say:
>>>  - [precise] Rx stamp PTP packets 
>>>  -  [approx] Rx stamp all packets
>>> not that you'd configure precision of one piece of HW..  
>>
>> So far it looks like only one provider is enabled at a given time, my
>> understanding was that the qualifier would be used in case there
>> are multiple timestampers on the data path, to select the better one
>> (e.g. a PHY that supports TS, a MAC that supports TS, we use the 
>> best out of the two).
> 
> No, we do not support multiple timestampers at the same time.
> For that IIUC we would have to add a an ID of the source in the packet. I
> remember people were talking about modifying cmsg. 
> This qualifier is indeed a first step to walk this path but I don't think
> people are currently working on adding this support for now. 
> 
>> However I agree with your comments, that's exactly the kind of feedback
>> I was looking for. This work has been tried several times now each
>> time with a different uAPI path, I'm OK to consider that this is out
>> of the scope of the hwprov feature.
>>
>>> If the HW really needs it, just lob a devlink param at it?  
>>
>> I'm totally OK with that. I'm not well versed into devlink, working mostly
>> with embedded devices with simple-ish NICs, most of them don't use devlink.
>> Let me give it a try then :)
> 
> meh, I kind of dislike using devlink here. As I said using timestamping
> qualifier is a fist step for the multiple timestamping support. If one day we
> will add this support, if there is other implementation it will add burden on
> the development to track and change all the other implementation. Why don't we
> always use this qualifier parameter even if it is not really for simultaneous
> timestamping to avoid any future wrong development choice.

On my side I've implemented the devlink-based approach, and I have to say i'm not
so unhappy with it :) At least I don't have the feeling this is bending
the API to fit one specific case.

The thing is that the qualifier model doesn't fully map to the situation we
have in stmmac.

The stmmac coarse/fine adjustment doesn't only changes the timestamping
behaviour, but also the ptp_clock adjustment mode. 

So changing the qualifier here will have a side effect on the PTP clock,
do we accept that as part of the hwprov timestamping API ?

Should we use this API for coarse/fine stmmac config, I agree with your
previous comment of adding a dedicated qualifier that explicitely says
that using this qualifier comes with side effects, with the risk of
paving the way for lots of modes being added for driver-specific scenarios.

Another thing with the stmmac implem is that we don't truly have 2
timestampers (1 approx and 1 precise), but rather only one whose precision
can be adjusted. Does it really make sense here to have the qualifier
writeable for the same timestamper ?

Of course the netlink tsinfo/tsconfig is more appealing due to its generic
nature, but OTHO I don't want to introduce ill-defined behaviours in that
API with this series. The multiple timestamper work still makes a ton of
sense for MAC+PHY timestamping setups :)

I'm opened for both approached TBH :)

Maxime

