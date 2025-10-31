Return-Path: <linux-kernel+bounces-879443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F534C23205
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41CD04EA972
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181B2749D5;
	Fri, 31 Oct 2025 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="CG1zqaI9"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB42475C7;
	Fri, 31 Oct 2025 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880167; cv=none; b=GInNTIRdmQnjYy85QOUuAw///+9pb0Jisrng721m5ZcnTQjD0KxQn3qnWwPlCV7pGD4d2dHxlTc+YyP+4a0s1sT2Fxa2/EO6LwTbou3W1wsR9JYIPUj9W9jW3DOU5Q7Ue2TWs6qTXG4D1Ne6aImy46HZkhVPFEhMGxEiR9sQvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880167; c=relaxed/simple;
	bh=5/rFO+lmhQuZBjyqy33qezkQngpGb5CYoWmqtJv5tT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsFT7DsYFE1X/fcoV5pNBCyq3jXcJWIGKb5+ijRBjKrvuE3zRps5iIPyeLSCkki8VefFg02ijvjLl3auysUPAnU8N7uVDluypuDrPQi0aDXBS3zmr0kZWIR1frqw/Topiy9g/8K982mdL3Dtl4ELJUXRBkQpNpY9eV4VNgBxaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=CG1zqaI9; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1761880146;
	bh=1G8+5WzT60YZleXus4Jt3zOnBZzSs6MoxWhzcmRf0Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=CG1zqaI93b2gYqwZoBo6tF84/OiTsrQATnCL57ksSqCkBNFTZ3Ym3ZM49GsR+Rrwr
	 mDYzTeI5/1NjIwNzWeo8GztmMIEq0EyKRxpIfYx/mP1DBOm5aHEAptQHOIOAHAEc4x
	 twMHrDIdPLOzZczoqhlKxvHTQj78KCUV+uoW+xCw=
X-QQ-mid: zesmtpsz3t1761880144tff90455e
X-QQ-Originating-IP: lwY1pcwxR8OcqDz4GZ7fQefy6NjIwogU9iy5TKjSJ/M=
Received: from [172.16.12.149] ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Oct 2025 11:09:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 429858561965377722
Message-ID: <9073605CE6F29EE7+088ed0de-536b-425a-9942-3b5d6c096e3f@airkyi.com>
Date: Fri, 31 Oct 2025 11:08:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] arm64: dts: rockchip: rk3399-evb-ind: Add
 support for DisplayPort
To: "Peter Chen (CIX)" <peter.chen@kernel.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Peter Chen <hzpeterchen@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20251029071435.88-11-kernel@airkyi.com>
 <CAL411-o6mF71oBeRsJ-OPZNbLegn4iJ_ELN9xVdppTM3ssUPOw@mail.gmail.com>
 <cc8b583a-77ec-4a7f-97cc-2d148f7fee9f@rock-chips.com>
 <e0c5bda3-7428-49e0-9955-fa23f1e4f35d@rock-chips.com>
 <CAL411-oXfvp-iqN+uRmFHijdmW=1omKwozKOoZ2shxukMHmwPg@mail.gmail.com>
 <C6253E8254C80B0F+839b71d0-1bd8-40b7-9515-7ce4a1eb8673@airkyi.com>
 <CAL411-pULVu4AYybW9oW7kmr4M_kJhdytgBjLPb4y6w_2dj+0w@mail.gmail.com>
 <7853bbf0-34e5-4880-a2f4-2d73f25cd5e6@rock-chips.com>
 <CAL411-rFK0o_cxBO_yJFHWurGFKxZGxw6=kpqxRipMetJskTaQ@mail.gmail.com>
 <e2fcc437-0650-4fdf-bb75-3463a80299fe@rock-chips.com>
 <20251031025712.GA1284354@nchen-desktop>
Content-Language: en-US
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <20251031025712.GA1284354@nchen-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MITS/U+ucPJSHLkflnBGAeBQIzAM+3T1oDR8mgel23cZn8V4dLmYofS1
	6FBI8J2FoADo85+dT+kiL1WXbWEuhE63ybHtmPgj2pwRkXCjjdTMS8MwCdVdfM0agr/89Ke
	vKyQJquTBEk88LdVLfAutq+xRs3vUEPcnP8vMlxfKJpDBeId8HTdamRq1hvfQlW3l6pjxm5
	cSpBtmVCKx8HR6jzohW0n0Zue1NeI5NRPIlnsnXypca1nfDVIq6Y5xsKjpBHgSXi6YOvChl
	I50TNYPnLxR/YettghOIUsOAf26/GkFsrifNQBPMhxsmiCXta+ebga4h+wi9VkYNL6rdEzQ
	kmNGmHpRV/BnPHl8X1ltkIrXl2znl3ytJK3vTUILEawaXDmQSEMJWXcdPzARvvLvmH5S/zg
	9wGBR0O3OG3G33BZFv6oKuOH+PWf4gkgK4kUuLfeuIZDJ7rrXCgJpcXnaLrTOQaM5LYhgN8
	VPX+MASXE5MCWQEitEreMSA1FtZGrFTRHqkUrwpAUzS4NzEEmkno8kKBzO2q8Juw+83pSoP
	xN3jRWqvY4AI0UHBBO3QDvxB1lIp5xGVKzWCYBxGZt41IqaMGyGUgKWmx79+nd9v0Ao4QnS
	ZNs1dZpj+ODZZvJCIfoHA33I2H6j49orkDGq9ST8YdKu+4nwBqeqSwaYeUfH64iFgS70Dpn
	KvVwZIMAozQjm3wwojIlMOIhXq7yKf4o7XGJb1AD89m4SD8E91bgODtj1IS4P3jqxLvqh51
	JZpHR8f5Qn3QhV6OjwbVCtrX7JhOYTYnMsrVUNb42cudUb7o46T6B94HktAMZhId02Y6yaX
	VhqcuUf7EyErk9I0jKDI8HScyCaTOGlQc2ksL2dUJHgNycY4CVhWMYV73htjmN/cJayXhp6
	/cxkjBgGfQIviU1EMfA5nEfRFw1t7hdtKGZiYgtTxguLS7L4ESVcGcmY0bW3dOc8LEIrKQy
	X0VJOoAeqCBceS2BXEF7hCjTqaGpykvEYIU587UNC4fkaxOI0Mw+LlaLP
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Hi Peter,

On 10/31/2025 10:57 AM, Peter Chen (CIX) wrote:
> On 25-10-30 14:50:33, Chaoyi Chen wrote:
>>> Hi Chaoyi,
>>>
>>> There are two questions I have still not seen the answer to:
>>> - Why USB2 PHY is related to your Type-C patch?
>> I was just following other people's approach. Sorry, this should be removed from the dts.
>>
>>
>>> - How does the USB role switch event notify the USB controller driver, eg dwc3?
>> Sorry, I misunderstood what you said before. There is indeed a missing usb-role-switch now. I referred to the approach in rk3588-evb1-v10.dts. Is the following way of writing correct?
>>
>> &usbc_connector {
>>      ports {
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>>
>>          port@0 {
>>              reg = <0>;
>>
>>              usbc_orien_sw: endpoint {
>>                  remote-endpoint = <&tcphy0_typec_orien_sw>;
>>              };
>>          };
>>
>>          port@1 {
>>              reg = <1>;
>>
>>              usbc_role_sw: endpoint {
>>                  remote-endpoint = <&dwc3_0_role_switch>;
>>              };
>>          };
>>
>>
>>          port@2 {
>>              reg = <2>;
>>
>>              usbc_dp: endpoint {
>>                  remote-endpoint = <&tcphy0_typec_dp>;
>>              };
>>          };
>>      };
>> };
>>
>> &usbdrd_dwc3_0 {
>>      status = "okay";
>>      usb-role-switch;
>>
>>      port {
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>>          dwc3_0_role_switch: endpoint@0 {
>>              reg = <0>;
>>              remote-endpoint = <&usbc_role_sw>;
>>          };
>>      };
>> };
>>
>> &tcphy0_usb3 {
>>      orientation-switch;
>>
>>      port {
>>          tcphy0_typec_orien_sw: endpoint {
>>              remote-endpoint = <&usbc_orien_sw>;
>>          };
>>      };
>> };
>>
>> &tcphy0_dp {
>>      mode-switch;
>>
>>      port {
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>>
>>          tcphy0_typec_dp: endpoint@0 {
>>              reg = <0>;
>>              remote-endpoint = <&usbc_dp>;
>>          };
>>      };
>> };
>>
> The general hierarchy is okay, just need to fix some dts coding
> style issue.

Thank you for your explanation. I will fix this in v9.


>


