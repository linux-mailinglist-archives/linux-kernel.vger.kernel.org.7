Return-Path: <linux-kernel+bounces-829890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F24AB9820D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DE12E5BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798F22A7F9;
	Wed, 24 Sep 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b="Sg+V4z7A"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B12264BA;
	Wed, 24 Sep 2025 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683914; cv=none; b=snvt1ZGD6BHDQiZuNMzNweuH3MwPkKyKgTYS5BunneYHqwmXLwQjTJzkejhXYb6FvYVpuBOtrhAPGt5z6V3Q+Y0EDAPMarBpi6aoNAQ8ZQMNMLTW4FXrQUPNhK1t9lPRRiDIm9ZqLA+rd3KM5mJ58OqL5jXRk/4Ct2ORYZK4EPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683914; c=relaxed/simple;
	bh=Ik9FZBrBLeV/X7izHvyRJypllGM/y+8FN3vMk4M2pLs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=jZKkTslCjV0JaOLSfVp70vVwqVuY41xvcm0BY2kDabynK6HdWHF5ckvw1EJk2FGQTA44DUK1QqpAAPUaormTqMJr5JUQtMr9OwNDoOyLP+AHWf9WH2L20w/MzMOZ9Is6jaaVfBXLL0Up6rg031LfruAhQLn8IPXLf2Dqp9Len2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com; spf=pass smtp.mailfrom=simcom.com; dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b=Sg+V4z7A; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simcom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simcom.com;
	s=oxqy2404; t=1758683889;
	bh=nMYEhoSAqoAMgJGRcoEG8HUuNnPiAX+olgk9i29gR4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Sg+V4z7AZjc8lfGK2OLnDPbJDWpemesmX0dmjKWAX4MFv/DNvbo5geGLTP+8Azo84
	 NBmF1QlECg4ZGapV0xYueQd8hpwcMq49eklCfa6KqiWCUHv7ca1iqSn6oJIILgyoBM
	 Ltbi7I+AWhXSON5ufu76FTsbIq1ys8j5c08+BWII=
X-QQ-mid: zesmtpsz4t1758683888tde522e7b
X-QQ-Originating-IP: 0UHpNvmzOt6JzezinOlEroZZcbXKPDWgANim4LKergw=
Received: from [127.0.0.1] ( [113.233.137.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Sep 2025 11:18:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9093758353923306593
Content-Type: multipart/mixed; boundary="------------fJ1rQJHSiz5ML7IjlmNtvQb4"
Message-ID: <B380E8AC5609CE77+6968ccb5-544a-4ddc-8e74-e5b162b4c34f@simcom.com>
Date: Wed, 24 Sep 2025 11:17:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB: serial: option: add SIMCom 8230C compositions
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250917105342.2687371-1-xiaowei.li@simcom.com>
 <aNJPuwDMsf5Pyepy@hovoldconsulting.com>
From: "xiaowei.li@simcom.com" <xiaowei.li@simcom.com>
In-Reply-To: <aNJPuwDMsf5Pyepy@hovoldconsulting.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:simcom.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NQ1SesBsQjVtSh85u9uba7wtUxUP+h8d5FoifQ0ejSp6QNU3vsgb90vW
	AVpft/w9BIEgdVOIq4ET795WcAC6CyrW3/1SszZ2VotPM5IhRFHg4+EKp55ETMLpiDXluEY
	O8CwmwB0T8z6RVC5WF5fuYzUIrh1lGzdIHwra6Kr4lfaYQ1V5T8XIeOn+ENY/iNhBi5zEZh
	/bE0om+xF8NUjd3Nu5QezT/J5GyxfpO6IQMizVGJxGRz9l8nudg1f3r06sFYJ0cJqAOHdfG
	mmpppXnUhTNZHVAyiGAgxuJTodJ6aodritmxWmit/YA4EvZGDVSZoMURY73mzniwfgfjpzG
	wLX1tdPPQhQB2ff+39igWUSZKIYWiVVJbdQY+GYb5tJLkUv92Ump+ei9hBclfJ3VOnbZ6d4
	V+lSTat5lpOmNmGh6xXOWoJUne5bgJDUwx1oLfFWWzvIU+u4zJatV4Qd7blXr6RIeeD6ph8
	RjzQoemCPhzcuDbmyras+K2yVf5VZ7j0+HlwESHF/OV2Z2/1LjAdtOAFxWnhzmS3nh5cN1d
	zQVV71ht1LNx6xFaObTCkRs1+aFXl3agdn1/WYMTX27x5jQZwTZ1ywZFw9fNBSRaATMDSQm
	1dYXBdXi0RjQf+JUPDpLUXJHx5LHhyvkWLSySYghvityUpZpfKnSHWHAZnjMssaJVT8ywXe
	RhcobLnkDCMFRs5SYEYENs3BfIZy7XMnntNCHxtTqqFGqTqqWF9EjzqlS1Ie/+wDggNJf8x
	D1eqy4o8yQuaXuXC983y39Z5xpCzcUxjuOjXpAVkT/UMh2h5avfoxZK1sJS4SvcFIQ64s2J
	dn8iQco7DoJQn1qw8vW0bXfpGBhhgq5GLuXDf2Zx0Azp5cAtUDsngi/XfsMyefIC/v/gmZ5
	ydtC8tH4YCpgEw6VQoh//O34HMqWuQXz4oesCIgbIwW/FdNppHU0FxHPwwUZekjZmnZ+jz4
	lnioL42oGTohna222Q3bB7S3z4ogXkkW3yflKk+JWbDM2GHle3wSv40MCkkX1RGRW+Mt1Zx
	DtATDMJWO3q3OX88MkU6M1ABlt0PV0/LaA7J/joQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

This is a multi-part message in MIME format.
--------------fJ1rQJHSiz5ML7IjlmNtvQb4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Johan,

Thanks for the feedback. I have addressed the issues in v2:
- Fixed the From and Signed-off-by mismatch.
- Added an introductory sentence in the commit message.
- Added comments for the new USB device entries.
- Included a changelog below the --- line.

Please find the updated patch attached. Let me know if there are any 
further comments.

Best regards,
Xiaowei Li

在 2025/9/23 15:43, Johan Hovold 写道:
> On Wed, Sep 17, 2025 at 06:53:42PM +0800, xiaowei.li wrote:
> 
> Thanks for the v2.
> 
> Checkpatch complains that your From (author) name does not match you
> SoB (a period '.' instead of space and no capitalisation). Could you fix
> your mailer (or add a From line to the patch) so that the author
> information in the logs will look correct?
> 
> Please consider adding an introductory sentence here (e.g. "Add the
> following compositions for device X:").
> 
>> USB Device Listings:
> 
>> Signed-off-by: Xiaowei Li <xiaowei.li@simcom.com>
>> ---
> 
> And when updating patches you should put a short changelog here under
> the --- line.
> 
>>   drivers/usb/serial/option.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
>> index fc869b7f803f..8eadcfe33ecd 100644
>> --- a/drivers/usb/serial/option.c
>> +++ b/drivers/usb/serial/option.c
>> @@ -2114,6 +2114,12 @@ static const struct usb_device_id option_ids[] = {
>>   	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
>>   	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
>>   	  .driver_info = RSVD(7) },
>> +	{ USB_DEVICE(0x1e0e, 0x9071),
>> +	  .driver_info = RSVD(3) | RSVD(4) },
>> +	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),
>> +	  .driver_info = RSVD(5) },
>> +	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),
>> +	  .driver_info = RSVD(5) },
> 
> And please add a comment after these entries with the device and mode
> (like the surrounding entries have).
> 
>>   	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
>>   	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
>>   	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
> 
> Looks all good otherwise.
> 
> Johan
> 

--------------fJ1rQJHSiz5ML7IjlmNtvQb4
Content-Type: text/plain; charset=UTF-8;
 name="0001-USB-serial-option-add-SIMCom-8230C-compositions.patch"
Content-Disposition: attachment;
 filename*0="0001-USB-serial-option-add-SIMCom-8230C-compositions.patch"
Content-Transfer-Encoding: base64

RnJvbSA1OWE0MmJiNTA1MjMwM2E1YThkMTBlNGU5ZjczNjJlZDExZmQzNmRjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBYaWFvd2VpIExpIDx4aWFvd2VpLmxpQHNpbWNvbS5j
b20+CkRhdGU6IFdlZCwgMTcgU2VwIDIwMjUgMTg6NTE6MjMgKzA4MDAKU3ViamVjdDogW1BB
VENIIHYzXSBVU0I6IHNlcmlhbDogb3B0aW9uOiBhZGQgU0lNQ29tIDgyMzBDIGNvbXBvc2l0
aW9ucwoKQWRkIHN1cHBvcnQgZm9yIFNJTUNvbSA4MjMwQyB3aGljaCBpcyBiYXNlZCBvbiBR
dWFsY29tbSBTRFgzNSBjaGlwLgpVU0IgRGV2aWNlIExpc3RpbmdzOgoweDkwNzE6IHR0eSAo
RE0pICsgdHR5IChOTUVBKSArIHR0eSAoQVQpICsgcm1uZXQgKFFNSSBtb2RlKSArIGFkYgpU
OiAgQnVzPTAxIExldj0wMSBQcm50PTAxIFBvcnQ9MDUgQ250PTAyIERldiM9IDEwIFNwZD00
ODAgIE14Q2g9IDAKRDogIFZlcj0gMi4wMCBDbHM9MDAoPmlmYyApIFN1Yj0wMCBQcm90PTAw
IE14UFM9NjQgI0NmZ3M9ICAxClA6ICBWZW5kb3I9MWUwZSBQcm9kSUQ9OTA3MSBSZXY9IDUu
MTUKUzogIE1hbnVmYWN0dXJlcj1TSU1DT00KUzogIFByb2R1Y3Q9U0RYQkFBR0hBLUlEUCBf
U046RDc0NEM0QzUKUzogIFNlcmlhbE51bWJlcj0wMTIzNDU2Nzg5QUJDREVGCkM6KiAjSWZz
PSA1IENmZyM9IDEgQXRyPWEwIE14UHdyPTUwMG1BCkk6KiBJZiM9IDAgQWx0PSAwICNFUHM9
IDIgQ2xzPWZmKHZlbmQuKSBTdWI9ZmYgUHJvdD0zMCBEcml2ZXI9b3B0aW9uCkU6ICBBZD0w
MShPKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMKRTogIEFkPTgxKEkpIEF0cj0w
MihCdWxrKSBNeFBTPSA1MTIgSXZsPTBtcwpJOiogSWYjPSAxIEFsdD0gMCAjRVBzPSAyIENs
cz1mZih2ZW5kLikgU3ViPTAwIFByb3Q9MDAgRHJpdmVyPW9wdGlvbgpFOiAgQWQ9ODIoSSkg
QXRyPTAyKEJ1bGspIE14UFM9IDUxMiBJdmw9MG1zCkU6ICBBZD0wMihPKSBBdHI9MDIoQnVs
aykgTXhQUz0gNTEyIEl2bD0wbXMKSToqIElmIz0gMiBBbHQ9IDAgI0VQcz0gMyBDbHM9ZmYo
dmVuZC4pIFN1Yj1mZiBQcm90PTQwIERyaXZlcj1vcHRpb24KRTogIEFkPTg0KEkpIEF0cj0w
MyhJbnQuKSBNeFBTPSAgMTAgSXZsPTMybXMKRTogIEFkPTgzKEkpIEF0cj0wMihCdWxrKSBN
eFBTPSA1MTIgSXZsPTBtcwpFOiAgQWQ9MDMoTykgQXRyPTAyKEJ1bGspIE14UFM9IDUxMiBJ
dmw9MG1zCkk6KiBJZiM9IDMgQWx0PSAwICNFUHM9IDMgQ2xzPWZmKHZlbmQuKSBTdWI9ZmYg
UHJvdD01MCBEcml2ZXI9cW1pX3d3YW4KRTogIEFkPTg2KEkpIEF0cj0wMyhJbnQuKSBNeFBT
PSAgIDggSXZsPTMybXMKRTogIEFkPTg1KEkpIEF0cj0wMihCdWxrKSBNeFBTPSA1MTIgSXZs
PTBtcwpFOiAgQWQ9MDQoTykgQXRyPTAyKEJ1bGspIE14UFM9IDUxMiBJdmw9MG1zCkk6KiBJ
ZiM9IDQgQWx0PSAwICNFUHM9IDIgQ2xzPWZmKHZlbmQuKSBTdWI9NDIgUHJvdD0wMSBEcml2
ZXI9KG5vbmUpCkU6ICBBZD0wNShPKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMK
RTogIEFkPTg3KEkpIEF0cj0wMihCdWxrKSBNeFBTPSA1MTIgSXZsPTBtcwoKMHg5MDc4OiB0
dHkgKERNKSArIHR0eSAoTk1FQSkgKyB0dHkgKEFUKSArIEVDTSArIGFkYgpUOiAgQnVzPTAx
IExldj0wMSBQcm50PTAxIFBvcnQ9MDUgQ250PTAyIERldiM9ICA5IFNwZD00ODAgIE14Q2g9
IDAKRDogIFZlcj0gMi4wMCBDbHM9ZWYobWlzYyApIFN1Yj0wMiBQcm90PTAxIE14UFM9NjQg
I0NmZ3M9ICAxClA6ICBWZW5kb3I9MWUwZSBQcm9kSUQ9OTA3OCBSZXY9IDUuMTUKUzogIE1h
bnVmYWN0dXJlcj1TSU1DT00KUzogIFByb2R1Y3Q9U0RYQkFBR0hBLUlEUCBfU046RDc0NEM0
QzUKUzogIFNlcmlhbE51bWJlcj0wMTIzNDU2Nzg5QUJDREVGCkM6KiAjSWZzPSA2IENmZyM9
IDEgQXRyPWEwIE14UHdyPTUwMG1BCkk6KiBJZiM9IDAgQWx0PSAwICNFUHM9IDIgQ2xzPWZm
KHZlbmQuKSBTdWI9ZmYgUHJvdD0zMCBEcml2ZXI9b3B0aW9uCkU6ICBBZD0wMShPKSBBdHI9
MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMKRTogIEFkPTgxKEkpIEF0cj0wMihCdWxrKSBN
eFBTPSA1MTIgSXZsPTBtcwpJOiogSWYjPSAxIEFsdD0gMCAjRVBzPSAyIENscz1mZih2ZW5k
LikgU3ViPTAwIFByb3Q9MDAgRHJpdmVyPW9wdGlvbgpFOiAgQWQ9ODIoSSkgQXRyPTAyKEJ1
bGspIE14UFM9IDUxMiBJdmw9MG1zCkU6ICBBZD0wMihPKSBBdHI9MDIoQnVsaykgTXhQUz0g
NTEyIEl2bD0wbXMKSToqIElmIz0gMiBBbHQ9IDAgI0VQcz0gMyBDbHM9ZmYodmVuZC4pIFN1
Yj1mZiBQcm90PTQwIERyaXZlcj1vcHRpb24KRTogIEFkPTg0KEkpIEF0cj0wMyhJbnQuKSBN
eFBTPSAgMTAgSXZsPTMybXMKRTogIEFkPTgzKEkpIEF0cj0wMihCdWxrKSBNeFBTPSA1MTIg
SXZsPTBtcwpFOiAgQWQ9MDMoTykgQXRyPTAyKEJ1bGspIE14UFM9IDUxMiBJdmw9MG1zCkk6
KiBJZiM9IDMgQWx0PSAwICNFUHM9IDEgQ2xzPTAyKGNvbW0uKSBTdWI9MDYgUHJvdD0wMCBE
cml2ZXI9Y2RjX2V0aGVyCkU6ICBBZD04NihJKSBBdHI9MDMoSW50LikgTXhQUz0gIDE2IEl2
bD0zMm1zCkk6ICBJZiM9IDQgQWx0PSAwICNFUHM9IDAgQ2xzPTBhKGRhdGEgKSBTdWI9MDAg
UHJvdD0wMCBEcml2ZXI9Y2RjX2V0aGVyCkk6KiBJZiM9IDQgQWx0PSAxICNFUHM9IDIgQ2xz
PTBhKGRhdGEgKSBTdWI9MDAgUHJvdD0wMCBEcml2ZXI9Y2RjX2V0aGVyCkU6ICBBZD04NShJ
KSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMKRTogIEFkPTA0KE8pIEF0cj0wMihC
dWxrKSBNeFBTPSA1MTIgSXZsPTBtcwpJOiogSWYjPSA1IEFsdD0gMCAjRVBzPSAyIENscz1m
Zih2ZW5kLikgU3ViPTQyIFByb3Q9MDEgRHJpdmVyPShub25lKQpFOiAgQWQ9MDUoTykgQXRy
PTAyKEJ1bGspIE14UFM9IDUxMiBJdmw9MG1zCkU6ICBBZD04NyhJKSBBdHI9MDIoQnVsaykg
TXhQUz0gNTEyIEl2bD0wbXMKCjB4OTA3YjogUk5ESVMgKyB0dHkgKERNKSArIHR0eSAoTk1F
QSkgKyB0dHkgKEFUKSArIGFkYgpUOiAgQnVzPTAxIExldj0wMSBQcm50PTAxIFBvcnQ9MDUg
Q250PTAyIERldiM9ICA4IFNwZD00ODAgIE14Q2g9IDAKRDogIFZlcj0gMi4wMCBDbHM9MDAo
PmlmYyApIFN1Yj0wMCBQcm90PTAwIE14UFM9NjQgI0NmZ3M9ICAxClA6ICBWZW5kb3I9MWUw
ZSBQcm9kSUQ9OTA3YiBSZXY9IDUuMTUKUzogIE1hbnVmYWN0dXJlcj1TSU1DT00KUzogIFBy
b2R1Y3Q9U0RYQkFBR0hBLUlEUCBfU046RDc0NEM0QzUKUzogIFNlcmlhbE51bWJlcj0wMTIz
NDU2Nzg5QUJDREVGCkM6KiAjSWZzPSA2IENmZyM9IDEgQXRyPWEwIE14UHdyPTUwMG1BCkE6
ICBGaXJzdElmIz0gMCBJZkNvdW50PSAyIENscz1lZihtaXNjICkgU3ViPTA0IFByb3Q9MDEK
SToqIElmIz0gMCBBbHQ9IDAgI0VQcz0gMSBDbHM9ZWYobWlzYyApIFN1Yj0wNCBQcm90PTAx
IERyaXZlcj1ybmRpc19ob3N0CkU6ICBBZD04MihJKSBBdHI9MDMoSW50LikgTXhQUz0gICA4
IEl2bD0zMm1zCkk6KiBJZiM9IDEgQWx0PSAwICNFUHM9IDIgQ2xzPTBhKGRhdGEgKSBTdWI9
MDAgUHJvdD0wMCBEcml2ZXI9cm5kaXNfaG9zdApFOiAgQWQ9ODEoSSkgQXRyPTAyKEJ1bGsp
IE14UFM9IDUxMiBJdmw9MG1zCkU6ICBBZD0wMShPKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEy
IEl2bD0wbXMKSToqIElmIz0gMiBBbHQ9IDAgI0VQcz0gMiBDbHM9ZmYodmVuZC4pIFN1Yj1m
ZiBQcm90PTMwIERyaXZlcj1vcHRpb24KRTogIEFkPTAyKE8pIEF0cj0wMihCdWxrKSBNeFBT
PSA1MTIgSXZsPTBtcwpFOiAgQWQ9ODMoSSkgQXRyPTAyKEJ1bGspIE14UFM9IDUxMiBJdmw9
MG1zCkk6KiBJZiM9IDMgQWx0PSAwICNFUHM9IDIgQ2xzPWZmKHZlbmQuKSBTdWI9MDAgUHJv
dD0wMCBEcml2ZXI9b3B0aW9uCkU6ICBBZD04NChJKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEy
IEl2bD0wbXMKRTogIEFkPTAzKE8pIEF0cj0wMihCdWxrKSBNeFBTPSA1MTIgSXZsPTBtcwpJ
OiogSWYjPSA0IEFsdD0gMCAjRVBzPSAzIENscz1mZih2ZW5kLikgU3ViPWZmIFByb3Q9NDAg
RHJpdmVyPW9wdGlvbgpFOiAgQWQ9ODYoSSkgQXRyPTAzKEludC4pIE14UFM9ICAxMCBJdmw9
MzJtcwpFOiAgQWQ9ODUoSSkgQXRyPTAyKEJ1bGspIE14UFM9IDUxMiBJdmw9MG1zCkU6ICBB
ZD0wNChPKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMKSToqIElmIz0gNSBBbHQ9
IDAgI0VQcz0gMiBDbHM9ZmYodmVuZC4pIFN1Yj00MiBQcm90PTAxIERyaXZlcj0obm9uZSkK
RTogIEFkPTA1KE8pIEF0cj0wMihCdWxrKSBNeFBTPSA1MTIgSXZsPTBtcwpFOiAgQWQ9ODco
SSkgQXRyPTAyKEJ1bGspIE14UFM9IDUxMiBJdmw9MG1zCgpTaWduZWQtb2ZmLWJ5OiBYaWFv
d2VpIExpIDx4aWFvd2VpLmxpQHNpbWNvbS5jb20+Ci0tLQpDaGFuZ2Vsb2c6CnYzOgotIEZp
eGVkIEZyb20gYW5kIFNpZ25lZC1vZmYtYnkgbWlzbWF0Y2guCi0gQWRkZWQgaW50cm9kdWN0
b3J5IHNlbnRlbmNlIGluIGNvbW1pdCBtZXNzYWdlLgotIEFkZGVkIGNvbW1lbnRzIGZvciBu
ZXcgVVNCIGRldmljZSBlbnRyaWVzLgoKIGRyaXZlcnMvdXNiL3NlcmlhbC9vcHRpb24uYyB8
IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2Ivc2VyaWFsL29wdGlvbi5jIGIvZHJpdmVycy91c2Ivc2VyaWFsL29w
dGlvbi5jCmluZGV4IGZjODY5YjdmODAzZi4uZDY2MTZkNjM1YzlmIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3VzYi9zZXJpYWwvb3B0aW9uLmMKKysrIGIvZHJpdmVycy91c2Ivc2VyaWFsL29w
dGlvbi5jCkBAIC0yMTE0LDYgKzIxMTQsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2Jf
ZGV2aWNlX2lkIG9wdGlvbl9pZHNbXSA9IHsKIAl7IFVTQl9ERVZJQ0VfSU5URVJGQUNFX0NM
QVNTKDB4MWUwZSwgMHg5MDAzLCAweGZmKSB9LAkvKiBTaW1jb20gU0lNNzUwMC9TSU03NjAw
IE1CSU0gbW9kZSAqLwogCXsgVVNCX0RFVklDRV9JTlRFUkZBQ0VfQ0xBU1MoMHgxZTBlLCAw
eDkwMTEsIDB4ZmYpLAkvKiBTaW1jb20gU0lNNzUwMC9TSU03NjAwIFJORElTIG1vZGUgKi8K
IAkgIC5kcml2ZXJfaW5mbyA9IFJTVkQoNykgfSwKKwl7IFVTQl9ERVZJQ0UoMHgxZTBlLCAw
eDkwNzEpLAkvKiBTaW1jb20gU0lNODIzMCBSTU5FVCBtb2RlICovCisJICAuZHJpdmVyX2lu
Zm8gPSBSU1ZEKDMpIHwgUlNWRCg0KSB9LAorCXsgVVNCX0RFVklDRV9JTlRFUkZBQ0VfQ0xB
U1MoMHgxZTBlLCAweDkwNzgsIDB4ZmYpLAkvKiBTaW1jb20gU0lNODIzMCBFQ00gbW9kZSAq
LworCSAgLmRyaXZlcl9pbmZvID0gUlNWRCg1KSB9LAorCXsgVVNCX0RFVklDRV9JTlRFUkZB
Q0VfQ0xBU1MoMHgxZTBlLCAweDkwN2IsIDB4ZmYpLAkvKiBTaW1jb20gU0lNODIzMCBSTkRJ
UyBtb2RlICovCisJICAuZHJpdmVyX2luZm8gPSBSU1ZEKDUpIH0sCiAJeyBVU0JfREVWSUNF
X0lOVEVSRkFDRV9DTEFTUygweDFlMGUsIDB4OTIwNSwgMHhmZikgfSwJLyogU2ltY29tIFNJ
TTcwNzAvU0lNNzA4MC9TSU03MDkwIEFUK0VDTSBtb2RlICovCiAJeyBVU0JfREVWSUNFX0lO
VEVSRkFDRV9DTEFTUygweDFlMGUsIDB4OTIwNiwgMHhmZikgfSwJLyogU2ltY29tIFNJTTcw
NzAvU0lNNzA4MC9TSU03MDkwIEFULW9ubHkgbW9kZSAqLwogCXsgVVNCX0RFVklDRShBTENB
VEVMX1ZFTkRPUl9JRCwgQUxDQVRFTF9QUk9EVUNUX1gwNjBTX1gyMDApLAotLSAKMi4zNC4x
Cgo=

--------------fJ1rQJHSiz5ML7IjlmNtvQb4--

