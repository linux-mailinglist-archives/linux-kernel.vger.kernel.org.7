Return-Path: <linux-kernel+bounces-824190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B95B88509
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFC156495F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6162EC0A1;
	Fri, 19 Sep 2025 08:00:59 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EF12C031E;
	Fri, 19 Sep 2025 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268859; cv=none; b=Zy14UCtmb6zGxR5QcKPTdTk0bxNBjlu8Ex4gR96I+kXaMbzO8x5gr0aB58kRHGWc/miDVgd4XpyWk+6SDu7PTmvmn+q3oZyHDczRDJnPK3zDzPWhIpBXscrdwmKfaaTDeDIPZ+XRwtgD7GsQlWb1JEqZ3wJ15QCgbbzenY60+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268859; c=relaxed/simple;
	bh=ilMrlsi6X3QG+7U9nS+AYACEB6xUstlqw+5DzxGvBUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CuqlcFTRK7op2AFg0ebYq+WXKzeFCbXVdm7BSZAJbaL4c+tbF0dwdKekekoL0A3yqYQhZhTANu4IgFNXwC2a25b32BW6PEg3sJko6pzFsFGCgQIvJqLNUB8ZQS7xuIAd5g5wtTgLfoIMHe7HicBM5fmvJm/KWS0TmYAVXQ2DWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c1802510952e11f0b29709d653e92f7d-20250919
X-CID-CACHE: Type:Local,Time:202509191524+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:03e9983d-fa46-43cc-be17-835949e5048b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:5,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:5d6f32bc1bc70c82a7b64a1b4a6bf1ec,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:2,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: c1802510952e11f0b29709d653e92f7d-20250919
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 266452088; Fri, 19 Sep 2025 16:00:49 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 643F0160042A2;
	Fri, 19 Sep 2025 16:00:49 +0800 (CST)
X-ns-mid: postfix-68CD0DB1-298897906
Received: from [172.25.120.57] (unknown [172.25.120.57])
	by node4.com.cn (NSMail) with ESMTPA id 1698C160042A0;
	Fri, 19 Sep 2025 08:00:48 +0000 (UTC)
Message-ID: <0f9a0d5a-d51c-45f4-8f1c-050e7c609baa@kylinos.cn>
Date: Fri, 19 Sep 2025 16:00:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] thunderbolt: Re-add DP resources on resume
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20250917082456.1790252-1-lijiayi@kylinos.cn>
 <0540df54-efd6-4b79-90f9-ec305e1f5f7e@kylinos.cn>
 <20250917125017.GI2912318@black.igk.intel.com>
 <f0a04f70-5539-42bd-ac15-07054878acfb@kylinos.cn>
 <20250918162059.GL2912318@black.igk.intel.com>
 <20250918164330.GN2912318@black.igk.intel.com>
 <a3dd4fc5-4312-4c06-a6d7-645ae0f7b68b@kylinos.cn>
 <20250919073052.GO2912318@black.igk.intel.com>
From: =?UTF-8?B?5p2O5L2z5oCh?= <lijiayi@kylinos.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250919073052.GO2912318@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/9/19 15:30, Mika Westerberg =E5=86=99=E9=81=93:
> On Fri, Sep 19, 2025 at 03:24:20PM +0800, =E6=9D=8E=E4=BD=B3=E6=80=A1 w=
rote:
>>
>>
>> =E5=9C=A8 2025/9/19 00:43, Mika Westerberg =E5=86=99=E9=81=93:
>>> On Thu, Sep 18, 2025 at 06:20:59PM +0200, Mika Westerberg wrote:
>>>> Hi,
>>>>
>>>> On Thu, Sep 18, 2025 at 04:34:31PM +0800, =E6=9D=8E=E4=BD=B3=E6=80=A1=
 wrote:
>>>>>
>>>>>
>>>>> =E5=9C=A8 2025/9/17 20:50, Mika Westerberg =E5=86=99=E9=81=93:
>>>>>> On Wed, Sep 17, 2025 at 06:12:31PM +0800, =E6=9D=8E=E4=BD=B3=E6=80=
=A1 wrote:
>>>>>>>
>>>>>>> As requested, I've attached the complete dmesg output (from boot =
to after
>>>>>>> resume) reproducing the issue.
>>>>>>>
>>>>>>> Testing Methodology:
>>>>>>> 1. Start with the Targus Thunderbolt dock already connected to th=
e system
>>>>>>> 2. Enter S3 suspend (sleep) with no DP monitor connected to the d=
ock
>>>>>>> 3. Resume from S3
>>>>>>> 4. After the system has fully resumed, connect the DP monitor to =
the dock
>>>>>>
>>>>>> Thanks! It is badly line wrapped. I wonder if you can just attach =
it?
>>>>>> Anyways I found some unexpected things there:
>>>>>>
>>>>>>> [    8.647850] With USB4 patch v1.0.0
>>>>>>
>>>>>> What is this? ;-)
>>>>>
>>>>> Thanks for your help!
>>>>>
>>>>> This is a self-compiled kernel based on version 5.4 with backported
>>>>> Thunderbolt drivers. I will also attach the kernel log from a build=
 using
>>>>> the linux-6.6.y branch of the community linux-stable repository.
>>>>
>>>> Okay but I really suggest using more recent kernel. 6.16 is current =
stable
>>>> so that would be good.
>>>>
>>>>>>> [    8.647860] ACPI: bus type thunderbolt registered
>>>>>>> [    8.664660] [7] nhi_probe:1326: thunderbolt 0000:2c:00.0: tota=
l paths: 21
>>>>>>> [    8.665209] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0: a=
llocating
>>>>>>> TX ring 0 of size 10
>>>>>>> [    8.665243] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0: a=
llocating
>>>>>>> RX ring 0 of size 10
>>>>>>> [    8.665267] [7] tb_ctl_alloc:665: thunderbolt 0000:2c:00.0: co=
ntrol
>>>>>>> channel created
>>>>>>> [    8.665272] [7] icm_probe:2549: thunderbolt 0000:2c:00.0: ICM =
not
>>>>>>> supported on this controller
>>>>>>> [    8.665285] [7] tb_ring_free:840: thunderbolt 0000:2c:00.0: fr=
eeing RX
>>>>>>> ring 0
>>>>>>> [    8.665294] [7] tb_ring_free:840: thunderbolt 0000:2c:00.0: fr=
eeing TX
>>>>>>> ring 0
>>>>>>
>>>>>> What is this?
>>>>>>
>>>>>> Is this Intel TB/USB4 controller or something else? All USB4 compl=
iant
>>>>>> controllers should go directly to tb.c as that's the part dealing =
with
>>>>>> software connection manager. The above looks like it tries first w=
ith the
>>>>>> firmware connection manager and that should not happen outside of =
Intel
>>>>>> Thunderbolt 3 hosts.
>>>>>
>>>>> Yes, there is a mistake. I discovered that during the USB4_NATIVE_C=
ONTROL
>>>>> negotiation in the firmware, an OSC_CAPABILITIES_MASK_ERROR bit was=
 being
>>>>> set incorrectly, which should not have happened.
>>>>>
>>>>> The log I will attach next has been modified to fix this issue.
>>>>
>>>> [..]
>>>>
>>>>> [    0.498976] [1] tb_switch_reset:1666: thunderbolt 0000:2c:00.0: =
0: resetting
>>>>> [    0.533329] [1] tb_add_dp_resources:217: thunderbolt 0000:2c:00.=
0: 0:10: DP IN resource available
>>>>> [    0.533959] [1] tb_add_dp_resources:217: thunderbolt 0000:2c:00.=
0: 0:11: DP IN resource available
>>>>
>>>> The DP IN resources were added here.
>>>>
>>>> [..]
>>>>
>>>>> [   19.035726] [171] tb_switch_set_wake:3445: thunderbolt 0000:2c:0=
0.0: 0: enabling wakeup: 0x3f
>>>>> [   19.037401] [171] tb_ring_stop:768: thunderbolt 0000:2c:00.0: st=
opping RX ring 0
>>>>> [   19.037412] [171] ring_interrupt_active:141: thunderbolt 0000:2c=
:00.0: disabling interrupt at register 0x38200 bit 21 (0x200001 -> 0x1)
>>>>> [   19.037439] [171] tb_ring_stop:768: thunderbolt 0000:2c:00.0: st=
opping TX ring 0
>>>>> [   19.037449] [171] ring_interrupt_active:141: thunderbolt 0000:2c=
:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
>>>>> [   19.037463] [171] tb_ctl_stop:733: thunderbolt 0000:2c:00.0: con=
trol channel stopped
>>>>
>>>> Runtime suspend.
>>>>
>>>> (and a couple more)
>>>>
>>>>> [  266.399800] [3870] tb_ctl_start:703: thunderbolt 0000:2c:00.0: c=
ontrol channel starting...
>>>>> [  266.399808] [3870] tb_ring_start:693: thunderbolt 0000:2c:00.0: =
starting TX ring 0
>>>>> [  266.399821] [3870] ring_interrupt_active:141: thunderbolt 0000:2=
c:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
>>>>> [  266.399826] [3870] tb_ring_start:693: thunderbolt 0000:2c:00.0: =
starting RX ring 0
>>>>> [  266.399837] [3870] ring_interrupt_active:141: thunderbolt 0000:2=
c:00.0: enabling interrupt at register 0x38200 bit 21 (0x1 -> 0x200001)
>>>>> [  266.399848] [3870] tb_switch_resume:3478: thunderbolt 0000:2c:00=
.0: 0: resuming switch
>>>>> [  266.399852] [3870] tb_switch_configure:2590: thunderbolt 0000:2c=
:00.0: restoring Switch at 0x0 (depth: 0, up port: 5)
>>>>> [  266.400032] [3870] tb_switch_set_wake:3447: thunderbolt 0000:2c:=
00.0: 0: disabling wakeup
>>>>
>>>> Around this time you should see the hotplug events coming to the DP =
IN
>>>> adapters. But there is none.
>>>>
>>>> There is a bit in the DP adapter config space (DHP) that can be used=
 to
>>>> disable this but the spec says it defaults to 0. Anyways I suggest t=
o check
>>>> that (and also the Plugged bit). You can dump these using tbtools [1=
]. Let
>>>> me know if you want help with that.
>>>
>>> Nevermind about the Plugged bit, that's not applicable here.
>>>
>>> Here's how to dump the DHP bit. This is from Intel host:
>>>
>>> # tbdump -vv -r 0 -N 1 -a 5 ADP_CS_5
>>> 0x0005 0x00004809 0b00000000 00000000 01001000 00001001 ..H. ADP_CS_5
>>>     [00:06]        0x9 Max Input HopID
>>>     [11:17]        0x9 Max Output HopID
>>>     [22:28]        0x0 Link Credits Allocated
>>>     [29:29]        0x0 HEC Error Enable (HEE)
>>>     [30:30]        0x0 Flow Control Error Enable (FCEE)
>>>     [31:31]        0x0 Disable Hot Plug Events (DHP)
>>
>> Thank you for your help. As you suggested, I tried kernel 6.16, but th=
e
>> issue still persists.
>>
>> The logs and device vendor information are included in the attachment.=
 I
>> also ran the tbdump command, and the result shows the DHP bit is set t=
o 0.
>> Does this indicate there might still be other issues?
>>
>> # tbdump -vv -r 0 -N 1  -a 5 ADP_CS_5
>=20
> Please run it against the DP IN adapters. That's 10 and 11. The 5 above=
 was
> just an example from Intel HW.
>=20
> # tbdump -vv -r 0 -N 1  -a 10 ADP_CS_5
>=20
> and
>=20
> # tbdump -vv -r 0 -N 1  -a 11 ADP_CS_5
>=20
> The lspci dump indicates this is ASMedia host controller. I did not eve=
n
> know that they have such thing. I thought they only have device (which
> should be working in Linux). The host side may require some additional
> enablement.

Apologies, Please find the latest results.

# tbdump -vv -r 0 -N 1  -a 10 ADP_CS_5
0x0005 0x0000d809 0b00000000 00000000 11011000 00001001 .... ADP_CS_5
   [00:06]        0x9 Max Input HopID
   [11:17]       0x1b Max Output HopID
   [22:28]        0x0 Link Credits Allocated
   [29:29]        0x0 HEC Error Enable (HEE)
   [30:30]        0x0 Flow Control Error Enable (FCEE)
   [31:31]        0x0 Disable Hot Plug Events (DHP)

# tbdump -vv -r 0 -N 1  -a 11 ADP_CS_5
0x0005 0x0000d809 0b00000000 00000000 11011000 00001001 .... ADP_CS_5
   [00:06]        0x9 Max Input HopID
   [11:17]       0x1b Max Output HopID
   [22:28]        0x0 Link Credits Allocated
   [29:29]        0x0 HEC Error Enable (HEE)
   [30:30]        0x0 Flow Control Error Enable (FCEE)
   [31:31]        0x0 Disable Hot Plug Events (DHP)

Regarding the ASMedia host controller: if hotplug events for the DP IN=20
adapter are not being generated, is it feasible to manually add the DP=20
IN resource as I initially thought, or is that approach incorrect for=20
this scenario?



