Return-Path: <linux-kernel+bounces-799968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B9B431BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F3D565BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094FC23ABB9;
	Thu,  4 Sep 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="R2nAWOu8"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097461A76BC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964754; cv=none; b=aeQo6Yq1lcAxP9gQoY/OWNsg2tjN/6jZUmQ2Oyk2a0QFmgyI1xASpMlGmAlD5nLwroRP0BtpSl78ZVPUTS8/nyOZgkDAxw83YIPIsYKl4gLeIoez3pfjA10fsTL3qDbEgPIoaAhms0aCEZZskXkZFDlEEMsv+w8Y/tYu9Cv2bEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964754; c=relaxed/simple;
	bh=JgH8Iwk889L8PR8q2W6YzSXypZ950buuZ3tCkWLq41A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+YSxXbg/4OJwhYWaFUPQNuMEvvGzUpB3QuEVfXgsuvpN+N6CDgYoe648DFngKYo+hAVzSAwwqCH2w93Ya1+b5LoWFY5jGQ7KmaSNAZIHqRpgDNmCgq0j75qCMIAFgfzOKVvK7QgicDJJBJlCMkOdp1WW27QDSm6TrNluBF+eu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=R2nAWOu8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329b760080fso641734a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 22:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1756964752; x=1757569552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5YGG4nuGu3lwoQw6peZ8To1oVtanSTvA4C4KW+QrcY=;
        b=R2nAWOu8EEBKQ4ugTCLZ9N9hRX8+4j55yiuPzjn11Ld3a1xZcmm1rfgttJZ+UNiAxS
         /AvqeFYRadMoRjsH3LzvHXHf9px0GIYB4q1Rm1VeuT+Xd2I2B/H5vHOt9tMZOz2p1NkW
         BxDEBaDUzsGbAiR+spPRsmAWLORIAi1DQ7jIeCDtVPVA6ImIHi5yZCpKDIey692JB6wW
         JVuPbopYtQg/yocYFqkY5DxZ4/pHkZ7sLvjdhGr8yG95fHFIfdNw/YQJGCQbhHxvYpru
         Mue7ZGSgTLMv4GDFO/9woyOriIa/0op9NAS645tg6R+r+YYURdqTksHYGZKeBUzU6d6N
         pmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756964752; x=1757569552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5YGG4nuGu3lwoQw6peZ8To1oVtanSTvA4C4KW+QrcY=;
        b=qXCVyfaIcpHumVh79GJ8lvh8Z+C0/jcTrGAFk6ICMSKWrUKF0sdXVmlMJtuYn1d3ci
         z6vobvvccVBCulr7FmvqAy4FIrLHhCfp4sXfhI7+vxtCNXoHd3wJ4S8ZXTXc4FiPxNZ2
         0mrITUAqhW0+B2ptd2T+Y1r+aUHZAofrK0DgSrMWIX0aZP/gbFDzuWAO2cj9olrxsLxB
         zY+JaLAvQvgxoT0IoO0mBmHongVeWk1Q7fouvY4JJxoN3EfBP068NrzRKLFC4hOQ6GWn
         s/vcqY4rkK6XzeLyMb9s7FilyXnEyFmO0vdfEPsiOgnWRHMxb0URUUb1XnCST1+fWCFP
         mXIw==
X-Forwarded-Encrypted: i=1; AJvYcCUHFs04BV3bYsaT4saHON6yTwuygVzv99jLxZTnx1VX/FIjz/wcJD2nYmc1jftUCxRURCdSE129RSv+uoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybvwXWg71zpkZarTHBP1vitfnkMU3PqY6eT0QrpvW0kKevwtDY
	phubZcIqO+iIZhGwfGaiZ05P7jZmvW3kKdfp/E1G9ZUyTKz0z+2ohCWKnFS5m1U03g==
X-Gm-Gg: ASbGnct6hDwnvBBg0aZSc/vKlT7XhWDAa1oy0redoaqu+P6DBQ2JejeG9OMRRvc5HOO
	dqnxW87l+fMK9q8Njf50+usfIh+jMWLJwk15ggys8fm5yTJikMsubq7lkWmjRJo/9yD0tqrDy2L
	Ocj6R9344eVbHAFSgPSoN04QKaTTbO19uHjdF1P1WBCbRDwZ89F6VSzliirXWAKOO4NGnmEsAjn
	A2Y0zcdrzWwVC8Xy/zO62WpouOoNd6CJZDeBCbRVdeZsCYunFIcpLuJF6XGo/dQYw8rLuNqNqLb
	wfnzEiMRsj4T/09qO8/praE663afwBUHo9TMfAWLv78QmaAlmxzLFyiwt+aW5rN3IeS8jkVv0bG
	uYWAfrPyyQJh7WXhqMxbknVIMscrAui78CypX/cBu8k46bnOGdCm65fVle+Unsp9M3OO8KXENQK
	Y0L5wBqjbG
X-Google-Smtp-Source: AGHT+IFrlxZ8b1BV+14cO0Jkl6iP9ASKskEUevUR+DUKPI8hogCxqnuirxAeAY06esuqQII9DiUKcw==
X-Received: by 2002:a17:90b:1dcc:b0:327:b321:b514 with SMTP id 98e67ed59e1d1-32815412acfmr22035641a91.2.1756964751828;
        Wed, 03 Sep 2025 22:45:51 -0700 (PDT)
Received: from ?IPV6:2401:4900:8898:c0b8:e77d:566:c015:a60f? ([2401:4900:8898:c0b8:e77d:566:c015:a60f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b94a2feacsm358441a91.8.2025.09.03.22.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 22:45:51 -0700 (PDT)
Message-ID: <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
Date: Thu, 4 Sep 2025 11:15:44 +0530
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>,
 Andrew Davis <afd@ti.com>
References: <20250902105710.00512c6d@booty> <aLkiNdGIXsogC6Rr@zatzit>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <aLkiNdGIXsogC6Rr@zatzit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/25 10:53, David Gibson wrote:

> On Tue, Sep 02, 2025 at 10:57:10AM +0200, Luca Ceresoli wrote:
>> Hello,
>>
>> [this main was co-written by Hervé and Luca]
>>
>> Hervé and I are working since 1+y to allow describing hot-pluggable
>> add-ons and their connectors with device tree overlays. Our work is not
> So.. I think this is a poor way of framing the question.  Device tree
> overlays were, frankly, a quick hack to get some sort device tree
> variability happening.  They were pretty easy to implement, but they
> have a bunch of limitations.  Then, as such things so often are, they
> were used and overused.
>
> IMO, a lot of the problems being encountered now are really those
> fundamental limitations of the overlay approach.  Trying to address
> them "with device tree overlays" is constraining you to a poorly
> thought out approach, adding hacks on top of hacks.
>
> I proposed a possible "connector" format years ago (which I still
> think could do with renewed consideration) as an *alternative to*
> device tree overlays, not as an extension of them.
>
>> very much progressing because discussions about device tree bindings
>> has raised some issue that are not obvious to solve.
>>
>> This e-mail is a report of the efforts we did last week during the
>> Embedded Linux Conference Europe to try to address the currently
>> blocking issues.
>>
>> First, I gave a talk about the overall hotplug work, to provide a
>> status update but also to clarify the goals and use cases. Slides are
>> available at [2]. Goals include:
>>
>> - decoupling base board and add-on, so an addon can have a single dtbo
>>    valid for any base board, and vice versa
> Good goal.  This one can be somewhat addressed within the dtbo format
> (e.g. the 'export-symbols' proposal').  However doing so leans into
> the limitations of the dtbo format, which I think won't serve you
> well.
>
>> - supporting main boards with multiple connectors where multiple
>>    instances of the same addon model can be connected independently
> Such as right here.  The basic overlay approach is really badly
> suited to this.
>
>> - allowing overlay insertion and removal at runtime (hotplug)
> Again, I think that's poor framing.  You want to be able to insert and
> remove things into connectors.  Thinking of that as inserting and
> removing overlays hotplug limits you to crappy solutions.  The basic
> definition of overlay application is fundmentally lossy - making them
> removable requires a pile of ugly hacks.  Better to look at an
> approach at a different semantic layer.
>
>> The first goal implies that addon overlays do not refer to anything
>> (phandles) beyond the connector node.
>>
>> The talk has attracted a lot of people. All seats in the 200+ room were
>> taken, and when I asked who has a connector use case about 40-50
>> attendeed raised their hands. I also had several questions asked after
>> the talk and in the hallway.
>>
>> After the talk we had planned a discussion about the topic. Krzysztof
>> Kozlowski was present in person (thanks!), while Ayush Singh and
>> Wolfram Sang connected remotely. Jason Kridner (beagleboard.org) and
>> Geert Uytterhoeven were present and actively constributing to the
>> discussion. Unfortunately Rob Herring was not connected, but still we
>> tried to make the best out of the discussion. So we focused on
>> discussing the current proposals to go past the issues with our
>> export-symbols proposal raised mainly by Rob.
>>
>> Here is a summary of the ideas we have discussed, in order from
>> simplest discussion (looking like not doable) to most complex (which
>> look like doable).
>>
>> ---------------------------------------------------------------------
>>
>> Idea #1: Label on __overlay__
>> Proposed by Rob in [0]
>>
>>> Couldn't we make something like this work:
>>>
>>> connector: __overlay__ {
>>>     node {
>>>        foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
>>>     };
>>> };
>> This would be OK for simple cases but it only allows exporting one
>> label, for the connector (i.e. the overlay target node). More than one
>> label need to be referenced from the overlay for cases such as:
>>
>> - pinmux, where each pinmux configuration is a node, and is defined
>>    in the pinmux node outside of the connector
>> - HDMI ddc-i2c property, for HDMI chips in the overlay which needs to
>>    point at an I2C adapter in the base tree
> Even wiring up plain old interrupts could be hard with this approach.
> It's also not clear how it would be encoded in the dtb.
>   
>> ---------------------------------------------------------------------
>>
>> Idea #2: add /export/ keyword to mark labels to be exported
>> Proposed by Rob in [1]
>>
>> The idea is to mark modes in the base tree that can be referenced by
>> overlays:
>>
>>> /export/ label: node {
>>> };
>>>
>>> And then __symbols__ can be only those exported labels (unless -@ is used).
>> This is an opt-in version of the "global" __symbols__ to limit the
>> issues __symbols__ introduces. However it is not sufficient for
>> connectors because it tells what can be exported but not on which
>> connector. Also, overlays would need to refer to the nodes in the main
>> tree, thus not decoupling mainboard and addon.
> Sounds like a strictly worse version of export-symbols.
>
>> ---------------------------------------------------------------------
>>
>> Idea #3: label on empty (*) node
>> (*) until overlay applied
>> Proposed by Hervé at LPC2024 in a discussion with Krzysztof, later
>> abandoned
>>
>> This is based on Idea #1 but tries to make HDMI ddc-i2c work:
>>
>> connector1: connector1 {
>>      #gpio-cells = <2>;
>>      gpio-map = <0 0 &soc_gpio 12 0>;
>>      gpio-map-mask = <0xf 0x0>;
>>      gpio-map-pass-thru = <0x0 0xf>;
>>
>>      i2c8: i2c-hdmi {                [**]
>>        i2c-parent = <&soc_i2c8>;
>>      }
>> };
>>
>> connector: __overlay__ {
>>     node {
>>        foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
>>     };
>>     i2c_hdmi: i2c-hdmi {
>>       //empty
>>     };
>>     hdmictrl@99876 {
>>        ddc-i2c = <&i2c_hdmi>;
>>     };
>> };
> Having symbol / glue information that's local to a particular
> connector is, I think, the way to go.  But again, I think encoding
> this in terms of overlays semantics is going to make it harder than it
> needs to be.
>
>> This would leverage the i2c-bus-extension work (also under discussion
>> [3]). Since for HDMI an I2C device is not added it would have a node
>> (i2c-hdmi) that is empty in the overlay (but not in the base tree and
>> thus not in the live tree after the overlay is applied). This empty
>> node is needed to ensure we can have a label (i2c_hdmi) that can be
>> referenced from elsewhere in the overlay (ddc-i2c).
>>
>> However there are various issues with this approach:
>>
>>   - mainlin, it does not handle pinumxes nicely
>>   - if the node that is overlayed by the empty node (i2c-hdmi) has a
>>     label in the base tree (line [**]), then the overlay-provided
>>     phandle ID would screw up the base-tree phandle ID
>>   - in dtbo, the empty node (i2c-hdmi) has a property in the overlay
>>     (phandle) but the node exists in the base tree, thus the property
>>     would leak on removal
>>
>> ---------------------------------------------------------------------
>>
>> Idea #4: resolving phandle errors by the connector driver
>> Proposed by Rob in [1]
>>
>>> I'll throw out another idea. What if we make resolving phandle errors
>>> something that can be handled by the connector driver? The driver
>>> knows 'connector' resolves to the connector node it is applying the
>>> overlay to.
>> This idea looked promising, so we tried simulating the process with a
>> dts/dtso example:
>>
>> Base tree:
>>
>> connector1 {
>>      compatible = "myvendor,myconn";
>>
>>      #gpio-cells = <2>;
>>      gpio-map = <0 0 &soc_gpio1 12 0>, <1 0 &soc_gpio3 42 0>;
>>      gpio-map-mask = <0xf 0x0>;
>>      gpio-map-pass-thru = <0x0 0xf>;
>>
>>      i2c-sensors {
>>         compatible = "i2c-bus-extension";
>>         i2c-parent = <&i2c@abcd0000>;
>>      };
>>
>>      hdmi-ddc-adapter = <&soc_i2c8>;
>>
>>      // All pinctrls that addons may need
>>      pin12-pinctrl-i2c = <&pin12_mode_i2c>;
>>      pin1-pinctrl-gpio = <&pin1_mode_gpio>;
>>      pin2-pinctrl-gpio = <&pin2_mode_gpio>;
>> };
>>
>> Overlay:
>>
>> / {
>>   fragment@0 {
>>    __overlay__ {
>>     node {
>>        foo-gpios = <&connector 0 GPIO_ACTIVE_HIGH>,  <&connector 1 GPIO_ACTIVE_HIGH>;
>>     };
>>     i2c-sensors {
>>        thm: thermal@15 {reg = <15>;...};
>>     };
>>     hdmictrl@12345678 {
>>        ddc-i2c = <&ddc_adapter>;   [*]
>>     };
>>     some_other_node {
>>        pinctrl-0 = <&pin12_pinctrl_i2c>;
>>        thermal = <&thm>;
>>     };
>> };
>>
>> This is what would happen for the HDMI ddc-i2c at line [*]:
>>
>> 1. of_overlay_fdt_apply_new(..., resolve_dt_error_cb) is called;
>>     it is a variant of of_overlay_fdt_apply() (name to be defined!) that:
>>       a. takes a function pointer to invoke the connector for resolving
>>          unknown labels
>>       b. does not even try to resolve phandles beyond the connector
>>       c. if target node has no phandle, creates one with next unused
>>          number
>> 2. resolver does not find 'ddc_adapter' label
>> 3. before calling it a fatal error, resolver calls connector driver
>>     callback
>> 4. connector driver callback knows the "ddc_adapter" string must be
>>     resolved using the "hdmi-ddc-adapter" property, returns soc_i2c8
>>     phandle ID
>>
>> connector driver callback in pseudocode:
>>
>>    resolve_dt_error_cb(conn, label)
>>    {
>>      switch (label) {
>>        case "connector":
>>          return conn->of_node;
>>        case "ddc_adapter":
>>          return resolve(conn->of_node, "hdmi-ddc-adapter");
>>        case "pin12_pinctrl_i2c":
>>          return resolve(conn->of_node, "pin12-pinctrl-i2c");
>>        }
>>    }
> The idea of putting logic into a connector driver makes sense.
> However, it's unclear to me where those strings its resolving are
> actually encoded in the dtb.
>
>> We discussed some possible issues, such as: what if a label is actually
>> found in the base tree and thus resolved? This is handled by point 1.b.
>> above: the OF core does not even try to resolve phandles beyond the
>> connector, it would not make sense for connector anyway. In other words
>> it only resolves local fixups, which are internal to the overlay, such
>> as "thm" in the example above.
>>
>> This looked like the most promising approach because it handles nicely
>> HDMI DDC and pinmux and minimize pollution in the phandle ID space.
>>
>> ---------------------------------------------------------------------
>>
>> So that was what we discussed in the meeting last Tuesday. We hope this
>> will help in setting the current point and let the discussion move
>> forward.
> Let me throw a few more ideas in the pot.  None of these are total
> solutions, but I think they may make good components of solutions.
>
> 1) Connector local labels/symbols/aliases
>
> This is not a new idea - both the export-symbols proposal and my
> ancient connector proposal had this in one form or another.  I think
> something along these lines is almost essential.  Things that plug
> into connectors almost always require references to several host board
> resources (interrupt controller, gpio, ...).  In order to be pluggable
> on multiple host boards you want to refer to those symbolically.  In
> order to support multiple instances of the same connector type, you
> need those symbols to refer to different things fordifferent connector
> instances.
>
> Whhat I think is a mistake is trying to tie this too closely to the
> existing __symbols__ structure.  Those have an ugly encoding that
> requires tortured processing in a way that's not natural for dtb
> handling.  Plus they already kinda-sorta duplicate old-school aliases
> in an odd way.
>
> You want some sort of string => node mapping on the connector side,
> and a way to mark portions of properties on the plugin side as being
> resolved to some string reference.  But we can take the opportunity to
> design a better way of doing that than the ugly one we have now.


Isn't export-symbols exactly this. We do take inspiration from 
__symbols__. However, in case of export-symbols, its string => phandle 
mapping (as opposed to string => string in __symbols__).

I suppose export-symbols could follow aliase conventions, but that still 
is a string => string mapping, which seems worse to me than a phandle 
(since phandle size is constant).


>
> 2) Extend dtb itself
>
> A maor thing that makes current symbols and fixups ugly is the fact
> that they are encoded into properties in the device tree itself,
> despite being logically at a different semantic level.  Obviously you
> *can* do that, but it's not natural.  It would make more sense to add
> fixup tags into the dtb format itself.

Having something akin to fixup in dtb format itself would be nice.


>
> 3) bus-reg / bus-ranges
>
> One thing that makes connector plugins a bit awkward is that they
> often need to add things to multiple buses on the host system (MMIO &
> i2c for a simple case).  This means that once resolved the plugin
> isn't neatly a single subtree.  That's one factor making removal
> really awkward.  Here's an idea I had a while ago to allow plugins to
> be a single subtree, by extending what's allowed in the tree content:
>
> Currently a node can only really have a presence on its immediate
> parent bus, as encoded in the 'reg' and 'ranges' properties.
> 'bus-reg' and 'bus-ranges' would extend that having a similar format
> to 'reg' and 'ranges' but adding a phandle for each entry saying which
> bus it lives on - somewhat similar to interrupt-map.
>
> For example, here's an MMIO bus bridge of some sort, which has control
> registers on I2C:
>
> 	mmio-bus@... {
> 		#address-cells = < 2 >;
> 		#size-cells = < 2 >;
> 		bridge@XXXX {
> 			ranges = <...>;
> 			bus-reg = <&i2c0 0x407>
> 		}
> 	}
> 	i2c0: i2c@... {
> 		#address-cells = < 1 >;
> 		#size-cells = < 0 >;
> 	}
>
> In a sense this extends the device tree to a device DAG.
>
> Obviously this does need changes at the OS device core level, but it
> gives you a lot of flexibility having done so.


There is an i2c-bus-extension [1] and spi-bus-extension proposal to do 
the same. But, if we can figure out a common way for all buses, that 
would be great.


[1]: 
https://lore.kernel.org/all/20250618082313.549140-1-herve.codina@bootlin.com/

[2]: 
https://lore.kernel.org/all/20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org/


>
> 4) You don't necessarily need to build a "full" device tree
>
> Flattened device trees (as opposed to original IEEE1275 device trees)
> - by design - allow certain information to be omitted.  The most
> common example is that for introspectable buses, like PCI, it's normal
> to have the DT only include a node for the host bridge, with devices
> under it being discovered by their own bus specific methods.  That's
> discovery is handled by the bus/bridge driver.
>
> Connectors usually aren't introspectable, but it's still possible to
> use an approach like this where the connector driver's discovery
> method is "look at a different device tree".  So, for example,
>
> Board device tree:
>
> / {
> 	compatible = "board-with-foo-connector";
> 	. . .
> 	mmio@... {
> 		foo-connector@... {
> 			compatible = "foo-connector";
> 			ranges = < ... >;
> 		}
> 	}
> }
>
> Foo device tree:
>
> / {
> 	compatible = "foo-device";
> 	foo-port-id = < 0x1234 >;
> 	component@... {
> 		reg = < ... >;
> 	}
> }
>
> Obviously a "foo device tree" would have different conventions than a
> board device tree.  It wouldn't have /cpus, /memory, /chosen - but it
> could have its own "magic" nodes that make sense for the properties of
> the specific connector type.
>
> Again, that would require work in the device core part of the OS.  The
> bonus is that runtime addition and removal is now trivial.  No hacking
> of the base device tree is needed, and so doesn't need to be reverted.
> The connector driver just adds/removes the reference to its own
> private tree.
>
> This would, of course, need some way to refer to board resources
> (interrupt controller, gpio controller) etc.  I think that can be
> assembled using some of the previous ideas, though.
>

I would need to wrap my head around this a bit, specially in context of 
chaining connectors. It does seem like it will still require the points 
you mentioned above to be present in one form or another, i.e. some way 
to extend busses to different nodes/trees and connector (even a chained 
one) local symbols/aliases.


Best Regards,

Ayush Singh


