Return-Path: <linux-kernel+bounces-870673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A89C0B6D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9263B7D86
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DF12FFFA1;
	Sun, 26 Oct 2025 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="A1azr4O1"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B602F7AA0;
	Sun, 26 Oct 2025 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520233; cv=none; b=JZsVg2AEY6CrtyD41EicjVc3eCRjQHBzx+RrX2vXtD7Swh5QnTRDYppKBEDVvE6MUyX+AgXzr5S/5ruxg5ceONpHoEBWKbcQQM25fYPSbtnCSFEPTHXPazgfht7PlJaP2DlgKOXw8Bni5mJ1wAjm9D06gwOeRilNNt523BqZ4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520233; c=relaxed/simple;
	bh=dfVR9ycCRUOjfF49zgYS2XJH9XNp+wt9GOVMSGtWyjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDFBPAAXnVK9PKKO2Uq2f2IqWhYLE4hwYUmKeq4yToSwjyEOsl1IKtQGoY1CxgAvTG311IKg8mWUMwTIC9HrrqeM8EFQpQZynC2KyP74iNDDhQYFGWEysH5vHzVBK9+RyXUEPdrExY7xP4TTo5DCt8sLa/bbOdzac0kylgfivGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=A1azr4O1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761519582; x=1762124382; i=w_armin@gmx.de;
	bh=So6fnkiTCqFYKSE4jxw7wiQy+SqtklIy20RzDBGvsUo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A1azr4O1WEl4FPQrOc4CdtTGZ+Gc29OZyXtIg6ZILP5hAoAhJ1ObMGhkcLosNntG
	 7NRK7RLWWoJBTAeD9HgmYgBdtvPsN2DUACPpAP8U2Xbon5l5/lPyQE/8GL1j62DZU
	 XWIyv3b8frv7XTWYw2ndcgmhROBvAg0QExts4ybaCCuxpwA7Dcu0obJ8UmrpO7d6A
	 PGsFHnfZ+9ukLsiNjKCs5q/KehvLu312aBHb8ni8ZghWXi+of7kPh2H3rO3Wn6JtT
	 zJTw0W6eoiQpviPsXXkKqwlmw95YikZjBNzmXR8im3ktMMTU1FJWbVSzB5lGQHK+Y
	 ChLFMwO7viWMA0L44w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1uRgsk0dXI-00kjpO; Sun, 26
 Oct 2025 23:59:42 +0100
Message-ID: <f1787927-b655-4321-b9d9-bc12353c72db@gmx.de>
Date: Sun, 26 Oct 2025 23:59:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] platform/x86: lenovo-wmi-{capdata,other}: Add HWMON
 for fan speed
To: Rong Zhang <i@rong.moe>, Derek John Clark <derekjohn.clark@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20251019210450.88830-1-i@rong.moe>
 <CAFqHKTkBbtSHfu1bXn8tyjvPSmCOMoWdLyNMv=DRQke679SEPA@mail.gmail.com>
 <1cebf2340386adf52bde31b05238199a201e9882.camel@rong.moe>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <1cebf2340386adf52bde31b05238199a201e9882.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Av9L4VnIkRElyfP/UdttrGzOTsaHbtU3vJQboc8+/yF6oH3gHh
 wi78H4aZmlT/XBrIsPamyHiuw0D3aT2xdQtr68EIBbhs0VrBywoU3LUV+HamJ4nbpdomRYs
 ggb99tm7TFo869BkeGXLqowXsBMJsskEGRWbBjFXFnInZU7wLVSowztv0+wlZ+OQsTLFNDK
 LcZLPe460cunzkAvbjyoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OOJ7oVKQkiQ=;0pdaj6dnfwiYFOiVZaTh15pWbPj
 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

Am 26.10.25 um 18:11 schrieb Rong Zhang:

> Hi Derek,
>
> On Sat, 2025-10-25 at 21:39 -0700, Derek John Clark wrote:
>> On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>>> Lenovo WMI Other Mode interface also supports querying or setting fan
>>> speed RPM. This capability is decribed by LENOVO_CAPABILITY_DATA_00.
>>> Besides, LENOVO_FAN_TEST_DATA provides reference data for self-test of
>>> cooling fans, including minimum and maximum fan speed RPM.
>>>
>>> This patchset turns lenovo-wmi-capdata01 into a unified driver (now
>>> named lenovo-wmi-capdata) for LENOVO_CAPABILITY_DATA_{00,01} and
>>> LENOVO_FAN_TEST_DATA; then adds HWMON support for lenovo-wmi-other:
>>>
>>>   - fanX_enable: enable/disable the fan (tunable)
>>>   - fanX_input: current RPM
>>>   - fanX_max: maximum RPM
>>>   - fanX_min: minimum RPM
>>>   - fanX_target: target RPM (tunable)
>>>
>>> This implementation doesn't require all capability data to be availabl=
e,
>>> and is capable to expose interfaces accordingly:
>>>
>>>   - Having LENOVO_CAPABILITY_DATA_00: exposes fanX_{enable,input,targe=
t}
>>>   - Having LENOVO_CAPABILITY_DATA_01: exposes firmware_attributes
>>>   - Having LENOVO_FAN_TEST_DATA: exposes fanX_{max,min}
>>>
>>> Rong Zhang (6):
>>>    platform/x86: Rename lenovo-wmi-capdata01 to lenovo-wmi-capdata
>>>    platform/x86: lenovo-wmi-{capdata,other}: Support multiple Capabili=
ty
>>>      Data
>>>    platform/x86: lenovo-wmi-capdata: Add support for Capability Data 0=
0
>>>    platform/x86: lenovo-wmi-other: Add HWMON for fan speed RPM
>>>    platform/x86: lenovo-wmi-capdata: Add support for Fan Test Data
>>>    platform/x86: lenovo-wmi-other: Report min/max RPM and hide dummy f=
ans
>>>
>>>   .../wmi/devices/lenovo-wmi-other.rst          |  32 +
>>>   drivers/platform/x86/lenovo/Kconfig           |   5 +-
>>>   drivers/platform/x86/lenovo/Makefile          |   2 +-
>>>   drivers/platform/x86/lenovo/wmi-capdata.c     | 545 ++++++++++++++++=
++
>>>   drivers/platform/x86/lenovo/wmi-capdata.h     |  46 ++
>>>   drivers/platform/x86/lenovo/wmi-capdata01.c   | 302 ----------
>>>   drivers/platform/x86/lenovo/wmi-capdata01.h   |  25 -
>>>   drivers/platform/x86/lenovo/wmi-other.c       | 422 +++++++++++++-
>>>   8 files changed, 1028 insertions(+), 351 deletions(-)
>>>   create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.c
>>>   create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.h
>>>   delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.c
>>>   delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.h
>>>
>>>
>>> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
>>> --
>>> 2.51.0
>>>
>> The series' intention looks good overall. The composable methods for
>> additional capdata interfaces is a welcome change. I have a few
>> comments I'll add for a couple of the patches. My apologies for the
>> slow review timeline, I've been on travel and wanted to test the
>> changes before submitting a review.
> Thanks for you review and testing! Hope you have/had a nice trip ;)
>
>> For testing I'm using my Legion Go 2. It apparently doesn't have the
>> FAN_TEST_DATA GUID, and the hwmon interface errors on all inputs
>> despite being visible. I know for the Legion Go series they use a fan
>> table with 10 auto_set points in the Other Method interface tied to
>> the platform profile, but the documentation I have says the methods
>> you're adding here should be available on all models, so that is a bit
>> strange.
> Yeah, that sounds weird.
>
> As for the fan table on your device, did you mean
> LENOVO_FAN_TABLE_DATA/LENOVO_FAN_METHOD? My device doesn't use a fan
> table, the corresponding ACPI methods are dummy (see below).
>
> My device is ThinkBook 14 G7+ ASP (forgot to mention when submitting,
> sorry). I don't have any documentation and I finished the patchset
> according to the MOF as well as the decompiled ASL code of its ACPI
> tables. The information from the documentation (including those in your
> following replies) is very useful, thanks for that!
>
> As it's branded as ThinkBook, most GAMEZONE/WMI_OTHER interfaces on my
> device may differ from Legion devices. To summerize:
>
> - LENOVO_GAMEZONE_DATA: dummy ACPI method.
> - LENOVO_GAMEZONE_CPU_OC_DATA: presents in MOF; missing ACPI method.
> - LENOVO_GAMEZONE_GPU_OC_DATA: dummy ACPI method.
> - LENOVO_CAPABILITY_DATA_00: works fine.
> - LENOVO_CAPABILITY_DATA_01: dummy ACPI method, data still presents
>    (\_SB.GZFD.CD01).
> - LENOVO_FAN_TEST_DATA: works fine.
> - LENOVO_FAN_TABLE_DATA: dummy ACPI method.
> - LENOVO_FAN_METHOD: dummy ACPI method.
> - LENOVO_OTHER_METHOD:
>    * Despite missing LENOVO_CAPABILITY_DATA_01, SPPT/SPL/FPPT can still
>      be get/set. There is also CHTC (FEATURE_ID=3D4, get/set) which I am
>      not sure what it means.
>    * FAN1/2: get method reads data from the EC; set method for FAN1
>      updates the EC, for FAN2 is dummy (no-op, returns 0).
>
>> dmesg output:
>> [    3.995549] lenovo_wmi_cd 362A3AFE-3D96-4665-8530-96DAD5BB300E-13:
>> registered LENOVO_CAPABILITY_DATA_00 with 33 items
>> [    4.000266] lenovo_wmi_cd 7A8F5407-CB67-4D6E-B547-39B3BE018154-9:
>> registered LENOVO_CAPABILITY_DATA_01 with 80 items
>> [    4.005603] lenovo_wmi_other
>> DC2A8805-3A8C-41BA-A6F7-092E0089CD3B-3: bound
>> 362A3AFE-3D96-4665-8530-96DAD5BB300E-13 (ops lwmi_cd_component_ops
>> [lenovo_wmi_capdata])
>> [    4.005611] lenovo_wmi_other
>> DC2A8805-3A8C-41BA-A6F7-092E0089CD3B-3: bound
>> 7A8F5407-CB67-4D6E-B547-39B3BE018154-9 (ops lwmi_cd_component_ops
>> [lenovo_wmi_capdata])
>> [    4.005614] lenovo_wmi_other
>> DC2A8805-3A8C-41BA-A6F7-092E0089CD3B-3: fan capdata unavailable
>>
>> Testing results:
>> (deck@lego2 hwmon5)$ ls
>> device  fan1_enable  fan1_input  fan1_target  name  power  subsystem  u=
event
>> (deck@lego2 hwmon5)$ cat fan1_enable
>> cat: fan1_enable: No data available
>> (1)(deck@lego2 hwmon5)$ echo 1 | sudo tee fan1_enable
>> [sudo] password for deck:
>> 1
>> tee: fan1_enable: Input/output error
>> (1)(deck@lego2 hwmon5)$ echo 0 | sudo tee fan1_enable
>> 0
>> tee: fan1_enable: Input/output error
>> (1)(deck@lego2 hwmon5)$ echo 3000 | sudo tee fan1_target
>> 3000
>> tee: fan1_target: Input/output error
> -EIO was returned when the set method didn't return 1 (as long as
> lwmi_dev_evaluate_int() didn't return this due to ACPI_FAILURE).
> Despite the return value, did the fan speed change after writing?
> Otherwise the method might be dummy and LENOVO_CAPABILITY_DATA_00
> simply returned mistaken data :(
>
>> (1)(deck@lego2 hwmon5)$ cat fan1_input
>> cat: fan1_input: No such device or address
> -ENXIO was returned by lwmi_dev_evaluate_int() as the return value was
> not an integer. It's really weird. Could you check the type of the
> return value? Some clues may also lie in the ASL code of the ACPI
> method.

The Windows WMI-ACPI driver converts all ACPI objects into a common buffer
format, so returning a buffer with four bytes will look like an integer
for WMI consumers under Windows.

I already have patches for that, but for now i suggest that you handle
this inside lwmi_dev_evaluate_int() yourself.

Thanks,
Armin Wolf

>> Thanks,
>> Derek
> Thanks,
> Rong
>

