Return-Path: <linux-kernel+bounces-736519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D49B09DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980EE3AF2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46E6292B30;
	Fri, 18 Jul 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="f4elrr2y"
Received: from mail-m1973184.qiye.163.com (mail-m1973184.qiye.163.com [220.197.31.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EF7E107;
	Fri, 18 Jul 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827439; cv=none; b=S/K1TTJiEO4lhMMyop4IJYnu1V9tPF39T3jyLUDOl01O24lsFitB0E6koJQJm7LU5n4XTeAqEAo+CXb98bGxkCAPiCV0y9COsJXMnfUDd506nV1ScFw5bLO8JQ03EVrFKlURyNeKyY1AzeZ7kvt2mlOG8zk6NRGVxpLdT0Rddn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827439; c=relaxed/simple;
	bh=uaevTefktuGaB/uH1VgfvraKM4X9798j/JAnsTcemgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sW6yRzDs1Kre3pLXhUBcazJ7MB8BcOUdCBuUigeMnhaF1ZBjrKDZNtpEdXoAo79TinPCkmnCYmNKB97KTJBTfZOVom+AO896ckuZUa6xm06+sMWATqO//zIeSH6zId0bQpHbYkGJvEMCy0ad2d/ODNU2V+C64tSV0gEnbnx7LWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=fail (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=f4elrr2y reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c79131e1;
	Fri, 18 Jul 2025 16:30:22 +0800 (GMT+08:00)
Message-ID: <71251cf5-edf9-489f-94db-9eb74791ea54@rock-chips.com>
Date: Fri, 18 Jul 2025 16:29:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: rk3399-evb-ind: Add support
 for DisplayPort
To: Krzysztof Kozlowski <krzk@kernel.org>, Chaoyi Chen <kernel@airkyi.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250718062619.99-1-kernel@airkyi.com>
 <20250718062619.99-6-kernel@airkyi.com>
 <2691a1ca-7325-4129-999d-61d883d1bac4@kernel.org>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <2691a1ca-7325-4129-999d-61d883d1bac4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a981ca7e66903abkunmc03baa52123841
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ08eQlYaHUoZHkNKGkIfSE5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=f4elrr2yrukBrG0T2pA0xg2Zn1ijyeEtt36iL+JwKtzWgjhTbohQ23NYc1T1ISuHDdevrv8P9aJ3mpWCaVJoFWB7OQROrbmrnQL4wZlgOFRUZWKj+O1waTPK+7R2e25Wvg5cVr54ZTu5LSLmbzlhMbczTTFaqdZiBsqUs8mHr9o=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=3qLZheDap41+YH7RXHcCPq8E9eTIuAxIIHxzGTMVwQE=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

On 2025/7/18 16:14, Krzysztof Kozlowski wrote:
> On 18/07/2025 08:26, Chaoyi Chen wrote:
>> +			altmodes {
>> +				displayport {
>> +					svid = /bits/ 16 <0xff01>;
>> +					vdo = <0xffffffff>;
>> +				};
>> +			};
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					usbc0_orien_sw: endpoint {
>> +						remote-endpoint = <&tcphy0_orientation_switch>;
> How did you address feedback given here? I don't see any replies.

Sorry, I miss it. The port@0 should be used for USB HS. Will fix in v3.


>
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					dp_mode_sw: endpoint {
>> +						remote-endpoint = <&tcphy_dp_altmode_switch>;
>> +					};
>> +				};
>
>
> Best regards,
> Krzysztof
>
>

