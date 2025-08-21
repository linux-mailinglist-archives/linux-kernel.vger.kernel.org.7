Return-Path: <linux-kernel+bounces-779198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC0DB2F054
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07BE16806A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D302E92B6;
	Thu, 21 Aug 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="csxHAubl"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADC296BA6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763047; cv=none; b=LZE+pZ8fbscN5eMGjpGJnKO0n8RIzGuPbgbGoBMTC0Rd4mGfmHpVITMWvRFyK+0C9Pl5Qd74xJD3GBOzMKhoq2ALeA6kj6I2D+CvzUk8113w/IoD1lt6FHPFZlVd3RtKYAJ/NVUyVA5oIzVSu6C+h4CPO9y6w6cUou2AKvBUiQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763047; c=relaxed/simple;
	bh=mWlpw+fkzNl2HTOTZh9Un5HqYgwUcx6hxK0zkS34qjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpMrvjyGdg8TlDLUEe+mAsPJ+ge6FfP9J4I9CEiVRoW/jK0WhgMjpPmvEt3H/2O+Ga1ViG6PQGNRo/fJFGO7J8OXqxhTu4kC3mQx/Wn1rHwZAKOpnGcZRYo/TQ/HHx5ykyMHZS5hxspkR6qzfUpNAMCM957OZNtj2m9GB7hashA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=csxHAubl; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755763037;
	bh=sax2l/uhGaoVMc5A5beGcQGw8z9geLQ5SDB6E7o7aIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=csxHAublpdbK2DHYohWBbNPi6StCsfcsH/l274lDY8dtVPcg0VklTfSx4PMHdmICw
	 JP6hYLK9nLNRTT/q+NM+6ZCVcxnFqkbXN940+OEefWzNjGfPnZPkDNUjfr2LSbVNAd
	 GyDT2+9JhRLC79NgOFVwjDo4FafrHCwWQ+/dsjo4=
X-QQ-mid: esmtpgz15t1755763015td44f2826
X-QQ-Originating-IP: k3xqsQ6QizxKHvrmeVfM0flZPWWA4AlqFE6ixRPd+vY=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 15:56:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3014638784407985306
EX-QQ-RecipientCnt: 13
Message-ID: <C559DC784053B698+aaafc990-e62a-4b71-86ba-a1ea4ce1c069@uniontech.com>
Date: Thu, 21 Aug 2025 15:56:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: imu: bmi270: Match PNP ID found on newer GPD
 firmware
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@deepin.org>,
 Jun Zhan <zhanjun@uniontech.com>, niecheng1@uniontech.com2
References: <20250821-bmi270-gpd-acpi-v3-1-91a873cb87c0@uniontech.com>
 <CAHp75VeTgWifRnqYxi8P_yfMv_GMvJJi4+xJNB98gtKp0z93=A@mail.gmail.com>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <CAHp75VeTgWifRnqYxi8P_yfMv_GMvJJi4+xJNB98gtKp0z93=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OX/+6nY/vs4TfMHpF05WeJYAHoVOqQkbw6WgWJdlTn+sLkPhKtscKdFG
	ftC3k9dPyP9CyQ+RiJPiOSzLd79+1FEpWIkMk1aLz4Mz3b6LWcypN188KLDgxkkMYXM0TKm
	giYoJSUU5hkDbBjhG6Whz6vxys0ZL5YYgpI6QLO1x3sTsOhwMZOfEmRwlWimU8Fbd+D/FjD
	7TapFmcfMjxIB4u8/y20+YIYM/bgC5o/y+1nC7kYVFRp6GX/4rVhkdHO+snz/xWzawO4AZ0
	ZpTi/THBw7CFqz4QV4H7eCKa5Txn5jbgwpxNM+o9d48vCiDr2IlC4M83mowMBJhcT648Mop
	oJHAenFZA2WDIjd3K0iASjbLjDUZEK+ismKvc8Pg0k/H39kTH4aYmIUyxwbX08G4JDSWnl2
	ljRqICvVbPhR6Zw4VLG6L8Fv61Xjt0eEAuLD8YrFvQAsHms/lkbdc/p7U0yCynPTBwXLukh
	rlTdvy98qkiEBHug3VbUjEed1IDIUcut6mAjFK3dRJYW6l+hIC7PW5bveKkQHUzyezZfgg7
	lKUTWATlgDoG2zyyHUuHg3yDiNji9eFALZCw2cQq4RwVnj+cwTMVTx8eZV2qMUJlYK5SBjb
	eolpMQK2TLcq+l6n72nacOKxiiRVLdNoQ1vcSY+IN2SjueeD3+fNgKyUfndDGOPu2WIyUQI
	DKbIZe0aumpJeQ64y2AoEd0LIC9p8znar3Hqk0W0twlEmqm1hsvugOfG7YTvjf6M7IMvqYM
	2JU4gC35OFZ8LBtpx2sAcavdNU9+YEg1kQ84rayF8F799OPDGdfRPmmFdsODTHcaOf0rP2/
	2kdeskPx6TJFkhdZD8OjJ4IJHxORoPpQYURN+VBEEnpvMJmfSLsN2xFId9UZqBXpTvWPKZ+
	WDNjtnKxcQmfuOvRvFn0AVzJ0cBQKMFYAmoFJq6EBjTmQ29PcyRpZAot93Dl+Cl4DGjUoyC
	cjC8JHs35Pkq393qh9xFTer390jSiji56TWfExjDjygZvI4bL6M159Z2DoRKwvcl+U/cYWY
	Imxpuj349OPZ1+d4l/87OmaPKy7QTUEOsFTM/DQT3JUK1S6hxH
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0


On 21/08/2025 15.36, Andy Shevchenko wrote:
> On Thu, Aug 21, 2025 at 9:17 AM Cryolitia PukNgae via B4 Relay
> <devnull+cryolitia.uniontech.com@kernel.org> wrote:
>> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>>
>> GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID.
>> When they switched to BMI260 sensors in newer hardware, they reused
>> the existing Windows driver which accepts both "BMI0160" and "BMI0260"
>> IDs. Consequently, they kept "BMI0160" in DSDT tables for new BMI260
>> devices, causing driver mismatches in Linux.
>>
>> 1. GPD updated BIOS v0.40+[1] for newer devices to report "BMI0260" for
>> BMI260 sensors to avoid loading bmi160 driver on Linux. While this
> the bmi160 driver
>
>> isn't Bosch's VID;
>> 2. Bosch's official Windows driver uses "BMI0260" as a compatible ID
>> 3. We're seeing real devices shipping with "BMI0260" in DSDT
>>
>> The DSDT excerpt of GPD G1619-04 with BIOS v0.40:
>>
>> Scope (_SB.I2CC)
>> {
>>      Device (BMA2)
>>      {
>>          Name (_ADR, Zero)  // _ADR: Address
>>          Name (_HID, "BMI0260")  // _HID: Hardware ID
>>          Name (_CID, "BMI0260")  // _CID: Compatible ID
>>          Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>>          Name (_UID, One)  // _UID: Unique ID
>>          Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>          {
>>              Name (RBUF, ResourceTemplate ()
>>              {
>>                  I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
>>                      AddressingMode7Bit, "\\_SB.I2CC",
>>                      0x00, ResourceConsumer, , Exclusive,
>>                      )
>>              })
>>              Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
>>          }
>>          # omit some noise
>>      }
>> }
>>
>> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip #1
> This blank line is not supposed to be here (the tag block is
> considered as the last lines in the commit message without blank
> lines, like a text paragraph).
>
>> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ...
>
> No need to resend for these nit-picks, I hope Jonathan will tweak them
> whilst applying.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
Oops, I edited it without seeing this line before sending it out. I hope 
it won't cause too much bother. thx for your review.


