Return-Path: <linux-kernel+bounces-855428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD36ABE12FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD0E34E3D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCA11A314B;
	Thu, 16 Oct 2025 01:50:04 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA31624D5
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760579404; cv=none; b=qXBaVxfgVbuAQktwcK3zD9kYS5LsBPMuXT5+wwSs18tEnUCvniZb8xaP9f98/Rpq5wmSPsAReFmGrLq33DFDH33jkFqREC8t03Jal5CKmGuKNGowBnxfaGtuiN93wjItvLL8UnosQwgpiDaL1rpR2sLh7ZXwxOZ7QyQ4VgUpTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760579404; c=relaxed/simple;
	bh=smR6v+ff/r0coSvOcaPEQ0oDal1iOPDs8EprmE7tLI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYZzl0oaWhAA27vjep9LCXF6HPtABz2gwZrNQ3oQP4RLJ8CWZDAuIFXg7H86hx2SRxdMi9CrqPtnf2+5JD03avC74nll4TF9GOYSoPAf4IzvNww1zv9ua6RxL2ZFmhkYxDbR2omDZSgn80RSFTDAibE3jbGLjJ7CyuM3LaTsqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1760579391tb10b6e15
X-QQ-Originating-IP: yqCawthjtTuw90dLvCzQouxE5b7tCEkQY6aMY/TtTzg=
Received: from [IPV6:240f:10b:7440:1:8198:2f89 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 09:49:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7959665287398781306
Message-ID: <AE0735A6C797CCFF+10496d73-7c0a-4884-9561-24721305a24f@radxa.com>
Date: Thu, 16 Oct 2025 10:49:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add Radxa CM5 module and IO board dts
To: Joseph Kogut <joseph.kogut@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jimmy Hon <honyuenkwun@gmail.com>, Steve deRosier <derosier@cal-sierra.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250617-rk3588s-cm5-io-dts-upstream-v5-0-8d96854a5bbd@gmail.com>
 <57969F385B5AF318+653dac83-8227-4987-84c6-f3e08b10085c@radxa.com>
 <CAMWSM7iHtAxewW4JkRqRsifVnccqeFviaCgeOyprKDr92FOurg@mail.gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <CAMWSM7iHtAxewW4JkRqRsifVnccqeFviaCgeOyprKDr92FOurg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OSjQccS6YHkH6Tny5937SKGZBr7mu+FWh9K9Eiz1QB4Hvs0VpyoaKNbY
	+dT8pkCV/D8MG5OYlqM2QGgEdoMIber7EoW/py52twUw8QyFA60LUB8jYBseSAc+b9IRTr0
	N5jXbdkUcHdHArB6d3jqCNhyZnMRTUB4XNeihlvHxE3/hWhhXHeDCJLw8DOMSfmd6AeNLXP
	rXUhKcIXAGQwFJyZZHChVoKneys56+PI7uz/iuGQspwyovesDxWV3jx4FEwqJYRrq+1VSGN
	DjGPYl1UYdUU8eFakUHVO/gq0rfHfysE/juSndQyOk8eYL0R/ctdnfp/TRWdbWFmqeQ6PN3
	2gdsbHwKpHHYAxWKuE/c6CcEFT2BBT6mSNOiQ2ENp2+CugfTpuyEFn/ZvEZ49mML+R1W4Tn
	i4IT52btMfCt6cT5f+t8FZWTPXcI8ayscN5n05kyLmIiSoIOTErK5nYAUAk7V3jCMrT3Bi0
	0DNG/3lKZP/sMc5b/vct+YtayfWLik75QCa4YL7kS2x+TJ8OtUJdaacwBPNLckAEZjXl8fQ
	4/iI0qOAAMOBsML44K4ISXqZE8Sa6opzFr8cQHKAh9WDjab3vT5CwRReqfvroAH1CFZWhb0
	KYl2ZU9t49G4HWPaSc8RqFKU4O/0Aunrj4N59MpxaPS4jS+t+iHVxR1Y9q0yRXejkWnS/hm
	BIOQQoOH6UPJuVBEFSu6wiitYPRDM77pOB3htzRcV6Nn4IfmGakJBb5ejLBi7eG/Pmp/Ra2
	VYhr2iB/PM2WMlOp9N0a0e9GNqNdHcVsmrKZnVBObQYbQZ/OqV85o0depY1yNl99sBEaVRA
	vxWgBWtVaytUibTk6c4c4Y9wjRIWEOzX+STf6LcpBBK1tB+8xjNN60hho9I5wTr5F2257YI
	kQuhTDz9ChXjRc0fpvNIFIW7XtadBpcqcXl5HqswUQsMgUd+O1g9oElzzOQWDYq1w8XdeOs
	h0LIWl0aTO31pedj7FeTrqz87jWzFU6gsnoAcsIbAkDyMNny2dXn7OP0vddv7NwwUULoy0+
	R3raLdzarDrzzmaEtXkJ236jMF7J5ZszA9eb1Vhw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hi Joseph,

On 10/16/25 08:39, Joseph Kogut wrote:
> Hello Naoki,
> 
> 
> On Wed, Sep 3, 2025 at 1:28 AM FUKAUMI Naoki <naoki@radxa.com> wrote:
>>
>> Hi Joseph,
>>
>> I'm thinking of continuing your work, so if you've already done
>> something, please let me know.
>>
> 
> I've not followed up on this series yet, but I'm planning on picking
> it back up this week. I'm happy to collaborate with you, do let me
> know if you've made any progress or improvements, and thank you for
> your review earlier.

I've already almost finished the work. Unfortunately, a problem(*1) 
caused the work to stop for a few weeks, but the problem has been 
resolved(*2), so I can continue working. I'll post a patch soon once 
some minor tweaking and testing is complete.

By the way, at some point I switched from "continuing your work" to 
"recreating a new one based on my current work." The results of my 
current work(*3) have changed significantly.

*1 
https://patchwork.kernel.org/project/linux-pci/patch/20250922-pci-dt-aspm-v2-1-2a65cf84e326@oss.qualcomm.com/#26603499
*2 
https://patchwork.kernel.org/project/linux-rockchip/patch/20251015123142.392274-2-cassel@kernel.org/
*3 https://github.com/RadxaNaoki/u-boot/commits/radxa-cm5-io/

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Best,
> Joseph
> 
>> Best regards,
>>
>> --
>> FUKAUMI Naoki
>> Radxa Computer (Shenzhen) Co., Ltd.
>>
>> On 6/18/25 07:11, Joseph Kogut wrote:
>>> This patch series adds initial device tree support for the Radxa CM5 SoM
>>> and accompanying IO board.
>>>
>>> V4 -> V5:
>>>     Patch (2/3), per Jimmy:
>>>     - Alias eMMC to mmc0
>>>     - Remove unused sdio alias
>>>     - Move gmac, hdmi0 nodes to carrier board dts
>>>
>>>     Patch (3/3), per Jimmy:
>>>     - Enable hdmi0_sound and i2s5_8ch
>>>     - Remove redundant enablement of sdhci
>>>     - Enable usb_host2_xhci
>>>
>>>     - Tested HDMI audio
>>>
>>> V3 -> V4:
>>>     - Fixed XHCI initialization bug by changing try-power-role from source
>>>       to sink
>>>
>>> V2 -> V3:
>>>     - Addressed YAML syntax error in dt binding (per Rob)
>>>     - Fixed whitespace issue in dts reported by checkpatch.pl
>>>     - Split base SoM and carrier board into separate patches
>>>     - Added further details about the SoM and carrier to the commit
>>>       messages
>>>
>>> V1 -> V2:
>>>     - Added copyright header and data sheet links
>>>     - Removed non-existent property
>>>     - Sorted alphabetically
>>>     - Removed errant whitespace
>>>     - Moved status to the end of each node
>>>     - Removed pinctrl-names property from leds (indicated by CHECK_DTBS)
>>>     - Removed delays from gmac with internal delay
>>>
>>> - Link to v4: https://lore.kernel.org/r/20250605-rk3588s-cm5-io-dts-upstream-v4-0-8445db5ca6b0@gmail.com
>>>
>>> Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>
>>> ---
>>> Joseph Kogut (3):
>>>         dt-bindings: arm: rockchip: Add Radxa CM5 IO board
>>>         arm64: dts: rockchip: Add rk3588 based Radxa CM5
>>>         arm64: dts: rockchip: Add support for CM5 IO carrier
>>>
>>>    .../devicetree/bindings/arm/rockchip.yaml          |   7 +
>>>    arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>>>    .../boot/dts/rockchip/rk3588s-radxa-cm5-io.dts     | 486 +++++++++++++++++++++
>>>    .../arm64/boot/dts/rockchip/rk3588s-radxa-cm5.dtsi | 135 ++++++
>>>    4 files changed, 629 insertions(+)
>>> ---
>>> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
>>> change-id: 20250605-rk3588s-cm5-io-dts-upstream-f4d1e853977e
>>>
>>> Best regards,
>>
> 



