Return-Path: <linux-kernel+bounces-732043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F7AB06143
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E214A0DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4678D289E0E;
	Tue, 15 Jul 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="wtTl89pM"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68126B767
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589319; cv=none; b=hb3z6Crt77kHBFuali+39R0oJLWWEphqTtcuMNB2inGewyViR0Eu/IoAa2moeLPVjuKnfBS3XMQ6NEW6cdhjc4g6mFmeYaTmbPsLmdvRxRmYBp7CENNdXeg5U6fpRh/74yAhSF71eLbDEZ4ioJU0feZmF4Ll/GoBeupE1/tYpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589319; c=relaxed/simple;
	bh=Hz35ChSUg8Djhrpvw527r9EgmUMM7Vk577nVPsZv2U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMePuQHofQkMoo3DOLxljvz5zRoQdtceSXINLEwnGApRYZG1WsJELJL9pd1FKF8mQ9fJoAHwPHNilOUCXlPMSq/0/lv2rS3vtZK+QYeU5BfBUp5hdEXb4fc+q0UXAJwAdfgXBGImnZLSa9MG5/KrwoUbI8Xwt/iB4iwoYoBths8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=wtTl89pM; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752589310;
 bh=hc3vsBfzOMAStJdYYEY+W0t5J5sQBFx3Mo+fJY+/Kfc=;
 b=wtTl89pM4xXXl5LDMuZusiNkFo49zf/iPh9ocHrUKsu5wbYEgwpOq0TbBDlucOaD0AaeeIgRi
 mlVvQMcdw0ujL2TG/KmvnVSJ9cbcFaA1QLMPooXzzp/eLg7qRadwNGPNTAqJ4yiWObPjDlZj9vO
 bObNXKi0BFmeky0HoWWTFUqNT7w4IUFq14l9ZEem833Wje0MkoRr1h4S2JmF10sLQufDlUCJ02k
 T//kMnEiY9zYAVM6bA7K2qC21fTmNpp9ajAQ2HsBxP7tJ6rDCA5Krv2hrY+eoPBBBnZUZwQjSH+
 rPqyi6GywC/O9rU0pdyI1SFjugkeb7ocWxAriOV3AL1w==
X-Forward-Email-ID: 687663ea4f06c51bcf022fb0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9050b4fe-ce69-4f93-9093-5461a6aa052f@kwiboo.se>
Date: Tue, 15 Jul 2025 16:21:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] arm64: dts: rockchip: Add ArmSoM Sige1
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: devicetree@vger.kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, ziyao@disroot.org
References: <20250712173805.584586-5-jonas@kwiboo.se>
 <20250715140115.1925358-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250715140115.1925358-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 7/15/2025 4:01 PM, Chukun Pan wrote:
> Hi,
> 
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
>> ...
>> +&sdio0 {
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	cap-sdio-irq;
>> +	disable-wp;
> 
> I don't think sdio needs disable-wp?

I thinks your are correct:

  disable-wp:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      When set, no physical write-protect line is present. This
      property should only be specified when the controller has a
      dedicated write-protect detection logic. If a GPIO is always used
      for the write-protect detection logic, it is sufficient to not
      specify the wp-gpios property in the absence of a write-protect
      line. Not used in combination with eMMC or SDIO.

It mention 'not used in combination with eMMC or SDIO', yet I see
multiple boards where disable-wp is currently used with eMMC and SDIO.

Do you have anything else to remark before I send a v4 with this prop
removed?

Regards,
Jonas

> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 


