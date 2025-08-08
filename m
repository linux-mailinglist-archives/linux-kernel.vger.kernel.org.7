Return-Path: <linux-kernel+bounces-760389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58016B1EA90
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F75D1C22192
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81503280037;
	Fri,  8 Aug 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="LUGdjVji"
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA227FD6E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664265; cv=pass; b=FCjmOu7KyTWTalPzDP6uLlESku8IgwRWzsri7OlBbA7V3F66bEIVizMoIym7cBxDwm0nq98FV8dPY+/1VSNFj0t++Kyjen3R08g6Uknx14TA+TmYhMVZ7URCrB4yHO1unEpeIlnQSuJei/ofneXynmoafPz7O+cfB//XXYFuKDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664265; c=relaxed/simple;
	bh=Jhuqu68AtOFb7ZCOIcLxg14Rhu4Rdm9p1uVHzBmYZS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcRNdWqUosC+ycbU+TNwI4q3ubB1232605XPh3J6hBMoNj6c8XiCzypYnuELVz4n9CrXXc//0CEcEhjKUm1yKuxHRnrXLvmDOEVWjICPH56jdqeQi4RFxGTc38EK5iG9SWWsv37BdPSCncYAHBjbf8LmatcuP+566o37ntYLZc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=LUGdjVji; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F1778163C02;
	Fri,  8 Aug 2025 14:38:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a287.dreamhost.com (trex-blue-7.trex.outbound.svc.cluster.local [100.96.43.79])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 65F4E163B10;
	Fri,  8 Aug 2025 14:38:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754663917; a=rsa-sha256;
	cv=none;
	b=U5DOtUOe+EXj0k9jC2e2otGFUbw7gtlv5kLVHHvPNLp6s+RFlSsfLZVvOEOl4Qzwsmt22P
	XnQmDzpAT28DxZcjeSeNSeH0c0ZlIfF63IG9n1yTCzn9HbdCV+9Skru2h9TMHql8etmbDY
	o1q+L564EQciGjAadK4MGtJv07Ts0xR1bnn5FN2SpAvCE76N6jr2a1XUXQrCtNpWDJT2vU
	9iTdh6mRLe1f9VivpBxU+2ZZJVZtC7QT228dpQ5Z7FfbN8oIXHJqqM8jn5KgEUrMJtgotq
	u5Jl5lJATnOtuNuAuZFRc8DBVYjno44c0KzPmb8nePGN7mzvGdSjdcTmlwocQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754663917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=D1TZb3mxnOhzg2Vdcog/qlZmoNoGc345fnptq8iGJ98=;
	b=UKj+eOWxtRJ6GoVPm0GBqSteOq42xAYZIkWkyCrZMp26VjsgnkY6zJ3k25FBIm2z6PTJ/A
	cBhjlNIKSeNYuDBuNui2FLJy4P013s27amVvMu6TXaaCEORtItXQTFaig4Gtr+zEHpan3O
	8MYVyODQXObrQOk4eHx0ucuA8gho9crgIixUiFFJbrTUCAU/UfykYdSPme1XE9PGjsezBj
	0Qg8wXOUtzkiv4gMLoFcWoxYueey0lPhex4qLsxEzypSFE5eSJDNa+ANrU75m0Ytfcz8QO
	Nu7kRWhK9F10NoAfH2cVxmEQUdJfg/vYFRh8holK1ZYCFpQ5qQYMZS2lLAJQgQ==
ARC-Authentication-Results: i=1;
	rspamd-64567b6586-ljwq7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Wiry: 0facfc34247bd33c_1754663917774_3566483743
X-MC-Loop-Signature: 1754663917774:4240174711
X-MC-Ingress-Time: 1754663917774
Received: from pdx1-sub0-mail-a287.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.43.79 (trex/7.1.3);
	Fri, 08 Aug 2025 14:38:37 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a287.dreamhost.com (Postfix) with ESMTPSA id 4bz68r5kNFz9g;
	Fri,  8 Aug 2025 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1754663917;
	bh=D1TZb3mxnOhzg2Vdcog/qlZmoNoGc345fnptq8iGJ98=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=LUGdjVjizdycZ9ufsLErUENC8J5JKfno80ba2VkEv6FonVIrIUMQUH0ZWMbqVNJT/
	 FONZmqn9ezSC5jqfOxTbj87DJ1iN+Hy6JHBX8+j31Kt9+7VBU3S89jarJXCmiy7r63
	 liu0qcqQunCYH5sBJR+BJLoo5C87IByykileUb8i/xRUQliUgXsxMAJgoL+oQ1/Nml
	 kMrpmscYyoFZCIZmTeWbYKUt6QMKI14QoL/I2oNPxK+YLRTzwNnpBrqdnVldZ54pIB
	 5n41TU0EMjJaHppTNd6ML0lupy/RV8dc8HIAPt1T7i2HU77szYJmvpYdnR321yhUi+
	 RzXMttc6BtZJg==
Message-ID: <7cf546fa-d98f-4c9f-92ae-0bd26b9d1178@landley.net>
Date: Fri, 8 Aug 2025 09:38:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Dave Young <dyoung@redhat.com>, Lichen Liu <lichliu@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, weilongchen@huawei.com
References: <20250808015134.2875430-2-lichliu@redhat.com>
 <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 21:30, Dave Young wrote:
> I do see there are a few similar usages in init/do_mounts.c, probably
> it is old stuff and it just works.  But I think making rootfs_flags as
> an array and copying str into it is the right way.

The lifespan of the string ends before PID 1 gets launched. The copy 
would be unnecessary and either perform an allocation or impose a 
gratuitous length limit.

Rob

