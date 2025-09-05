Return-Path: <linux-kernel+bounces-803065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92228B45A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5771C83859
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50BA3680A0;
	Fri,  5 Sep 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvFWnhZP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4463629AD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081411; cv=none; b=DI/ETRanxRNuiDGqX+P33uBQp/sMetQ7Jc13Mj/qKGrOZhlHhHrKr2P1e4jm5lYRc0+ruY/arDLg6+jPqOYWe/TUtxTmt+eiXrsDkoH0y5h0jdQgb7oK2lIz2iUPQg2BtwxZsXbMDrXdYWs83xaUODxeEy63X81KQwfOQQwSiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081411; c=relaxed/simple;
	bh=ww/6ETfiU72KFUp8K9mD6ruUhB0T8lURNzA9HoSMM38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mA+j4+8qk5mU0M5cydtP46joMDRRl5nczudOO9QyfykpZJDr8y1fCZRE5tNmkFejmubdkvhgG1gBcnhK308CPLtGuAnbgpAGY+nbMVFKQMP/7ZtrfeuNftAcYhJZHxPYLii79++ItX7dwd4jNokOfn6BjCvE2TgjI9joLVRoqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvFWnhZP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757081409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9agXDmmt+rDOvtmYXnC1tlNDnxlDBxkLIzMrNozdak=;
	b=fvFWnhZP66FJkb98n2lTlqY0tbKJzX9FNZicmcYykkYSBRSDScyAkqWR1Ujb+pgWu55FDV
	SQlK04bt4dUlbGANY2n/ZpgGGcVlXRVCyXzI8RA9iJ5Dcyz//UQvnPJXa5yZ1WhfxJBSa5
	+z07OOCPn6Tb5GF6W2nzGITBqHi4y5g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-16EdKIicMsi_MbH3U_V_Eg-1; Fri,
 05 Sep 2025 10:10:03 -0400
X-MC-Unique: 16EdKIicMsi_MbH3U_V_Eg-1
X-Mimecast-MFC-AGG-ID: 16EdKIicMsi_MbH3U_V_Eg_1757081401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8C9818004D8;
	Fri,  5 Sep 2025 14:10:00 +0000 (UTC)
Received: from [10.45.224.74] (unknown [10.45.224.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 605CD180044F;
	Fri,  5 Sep 2025 14:09:53 +0000 (UTC)
Message-ID: <a20848db-868c-457b-bb6b-9959922a3d56@redhat.com>
Date: Fri, 5 Sep 2025 16:09:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "almasrymina@google.com" <almasrymina@google.com>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "kuniyu@google.com" <kuniyu@google.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Rob Herring <robh@kernel.org>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
 <20250828153157.6b0a975f@kernel.org>
 <SJ2PR11MB8452311927652BEDDAFDE8659B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
 <20250829173414.329d8426@kernel.org>
 <SJ2PR11MB8452D62C5F94C87C6659C5989B03A@SJ2PR11MB8452.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <SJ2PR11MB8452D62C5F94C87C6659C5989B03A@SJ2PR11MB8452.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 05. 09. 25 1:14 odp., Kubalewski, Arkadiusz wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Saturday, August 30, 2025 2:34 AM
>> On Fri, 29 Aug 2025 07:49:46 +0000 Kubalewski, Arkadiusz wrote:
>>>> From: Jakub Kicinski <kuba@kernel.org>
>>>> Sent: Friday, August 29, 2025 12:32 AM
>>>>
>>>> On Thu, 28 Aug 2025 18:43:45 +0200 Arkadiusz Kubalewski wrote:
>>>>> Add support for user-space control over network device transmit clock
>>>>> sources through a new extended netdevice netlink interface.
>>>>> A network device may support multiple TX clock sources (OCXO, SyncE
>>>>> reference, external reference clocks) which are critical for
>>>>> time-sensitive networking applications and synchronization protocols.
>>>>
>>>> how does this relate to the dpll pin in rtnetlink then?
>>>
>>> In general it doesn't directly. However we could see indirect relation
>>> due to possible DPLL existence in the equation.
>>>
>>> The rtnetlink pin was related to feeding the dpll with the signal,
>>> here is the other way around, by feeding the phy TX of given interface
>>> with user selected clock source signal.
>>>
>>> Previously if our E810 EEC products with DPLL, all the ports had their
>>> phy TX fed with the clock signal generated by DPLL.
>>> For E830 the user is able to select if the signal is provided from: the
>>> EEC DPLL(SyncE), provided externally(ext_ref), or OCXO.
>>>
>>> I assume your suggestion to extend rtnetlink instead of netdev-netlink?
>>
>> Yes, for sure, but also I'm a little worried about this new API
>> duplicating the DPLL, just being more "shallow".
>>
>> What is the "synce" option for example? If I set the Tx clock to SyncE
>> something is feeding it from another port, presumably selected by FW or
>> some other tooling?
>>
> 
> In this particular case the "synce" source could point to a DPLL device of EEC
> type, and there is a sense to have it together in one API. Like a two pins
> registered with a netdev, one is input and it would be used for clock recovery,
> second is output - for tx-clk control - either using the DPLL device produced
> signal or not. Probably worth to mention this is the case with 'external' DPLL,
> where ice driver doesn't control a DPLL device but it could use the output as
> is this 'synce' one doing.

Yes, this simply describes a diagram I described in my DT RFC [1] that
defines relationship between DPLL device and network card.

		   +-----------+
		+--|   NIC 1   |<-+
		|  +-----------+  |
		|                 |
		| RxCLK     TxCLK |
		|                 |
		|  +-----------+  |
		+->| channel 1 |--+
+------+	   |-- DPLL ---|
| GNSS |---------->| channel 2 |--+
+------+  RefCLK   +-----------+  |
				  |
			    TxCLK |
				  |
		   +-----------+  |
		   |   NIC 2   |<-+
		   +-----------+

Here we have 2 scenarios... The first (NIC1) is a SyncE one where NIC1
feeds some DPLL input reference with recovered clock and consumes the
synchronized signal from the DPLL output pin as Tx clock. In the second
(NIC2) case the NIC uses some DPLL output pin signal as Tx clock and
the DPLL is synchronized with some external source.

If I understand well your comment, the RxCLK above is the dpll_pin
currently present in net_device. The TxCLK for the first case (NIC1)
should be the dpll_pin you are calling as "synce" source. And TxCLK for
the second case (NIC2) should be the dpll_pin you are calling "ext-ref".
Is it correct?

If so there should be another dpll_pin in the net_device let's call it
tx_dpll_pin... The existing one should be some input pin of some DPLL 
device and the tx_dpll_pin should be some output pin of that device.

A user could set the tx_dpll_pin by ip link command like:

# ip link set eth0 txclk <dpll-pin-id>

[1] 
https://patchwork.kernel.org/project/netdevbpf/patch/20250815144736.1438060-1-ivecera@redhat.com/

>> Similar on ext-ref, there has to be a DPLL somewhere in the path,
>> in case reference goes away? We assume user knows what "ext-ref" means,
>> it's not connected to any info within Linux, DPLL or PTP.
>>
> 
> Adding control over 'ext-ref' muds up the clean story of above.. The 'ext-ref'
> source is rather an external pin, which have to be provided with external
> clock signal, not defined anywhere else, or connected directly to DPLL device.
> Purely HW/platform dependent. User needs to know the HW connections, the
> signal to this pin could be produced with external signal generator, same host
> but a different DPLL device, or simply different host and device. There can be
> a PLL somewhere between generator and TX PHY but there is no lock status, thus
> adding new dpll device just to model this seemed an overshot.
> 
> Exactly because of nature of 'ext-ref' decided to go with extending the
> net device itself and made it separated from DPLL subsystem.
> 
> Please share your thoughts, right now I see two ways forward:
> - moving netdev netlink to rt-netlink,
> - kind of hacking into dpll subsystem with 'ext-ref' and output netdev pin.

You are mentioning above the case where an external DPLL device that is
not under control of network driver (e.g. DPLL chip on motherboard and
some LOM NIC). In this case is currently impossible for the NIC driver
to report dpll_pin used for recovered clock as it does not control the
DPLL device and all dpll_devices and dpll_pins are registered by the
different driver.

There could be defined some DT schema for the relations between ethernet
controller and used DPLL device. Then the system firmware (DT/ACPI...)
could provide the wiring info (e.g. DPLL pin REF0P is used for recovered
clock from NIC1 and output pin OUT4P for the Tx clock by NIC1 etc.)

...and also there should be some DPLL API for the drivers that would
allow to access DPLL devices and pins. E.g. NIC driver reads from its
fwnode that possible tx-clock pins could be out_pin1, 3, 5 but it needs
to translate fwnode_handles of these pins to registered DPLL pin IDs.

Thanks,
Ivan


