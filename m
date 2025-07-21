Return-Path: <linux-kernel+bounces-739780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B44B0CAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53F73BAA99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCB9226888;
	Mon, 21 Jul 2025 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA+1lhsk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A151E0DD8;
	Mon, 21 Jul 2025 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124792; cv=none; b=gQko07BU5NTD0W+vUj3iy+/D66OdrlMEN0XcFN5VNO6r29pwLKikisWVV9pHrG+MKV9rTbbAYd+YUTHCk3EgsRWEbzzf09JSbLzRbJJ8d/QoL/lpjXfAUX+sIw7MP2grHFbxU54LrY4F3Uj8k8RzE7VaBw+e313K27ZKEOf232w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124792; c=relaxed/simple;
	bh=Wamh0gHE9NcJWmoHNh25FMqPIjRNftLncjqnbOsx4/A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwdTue8nQCyOoYPQXYfZqmAxfP4Q+NXSc0Kkf2AHovThRGqZp4cQ3dkeLYU/oFy8YPb7dMGUTDI0U6mfys6Am+9tEgmDZFOY6vkgxlA6LBM13OGuVUfgd2yIOdpUAbpba6wNkSg2ztwgGlkjOQDgubILUiDDrNFowA6rWvCbVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA+1lhsk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d3f72391so48041795e9.3;
        Mon, 21 Jul 2025 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753124789; x=1753729589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ/RLl3admGJSZp+VkfQETMjtFkkuDrehLt1m0TEa5Q=;
        b=LA+1lhsk4SXkbOLOegG+y9GYDrKKC4PQaUQbEJbOpYIoHn6DVHhbrH4M5XcusRuh20
         JM2YSH/HS+yVnNL8xZMy3wEoUnY7DfN9b1SGR0441F+QFeDY1eTAE8wqiesyld+uu7rC
         iUxJ5fCbe8gsPATKaAUo5RpUEU+xZeZcfWhdSOXvWNe7t1Oh6zRjTWauS3M+DBF6D4AJ
         jOMEjHyD0bG0vHaz4Uq5oXk1zM0dc8sn7BffFrhlMEVmjWgSamtq9lOCN3Qmi3e/0KSs
         /OVSaM8OOC7fzVuPMlc502mecENWM9qTJwdKSMlXgZXUJdrO+BVX94Nd64D/eROtwFgf
         ty4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753124789; x=1753729589;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ/RLl3admGJSZp+VkfQETMjtFkkuDrehLt1m0TEa5Q=;
        b=ItV6zpSXJrewWifrEAK60/afGWRLXsfmHmOdSgiGLWBy5Ngg2fjHzpbrFN9iwavP9W
         W7BTMR83QqW5dgBd634mV08HXACiGzCSx9XXIAZDTOAo+DzDVKb86puMvhece/3YJjFZ
         cct9qQUK3cW8P5lUm08GcdBAR44xpxNeAoHIAH9ZbRteTlRbJwIdOhCByzGEi46SDv/A
         OzYzxlBXERIOazAQdmLBYLdFo2wR1nVORm60JKTxMyee6EV/cK/+6Hrpc1Z0hALGysKc
         w3fvX2YUtABGAVXC5G4/jUQwMpB+WqcQQIvm9Z50esejY8KKGZKxfVYtJoIcMCZFJeE8
         iWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/5HuL2k8MQloblOIPksHtLOhiGc2VNaxb+spHu7RNsSxTKZ0EFfwfqwYgz4nK90kIGg1iEVpjEgFR@vger.kernel.org, AJvYcCWrfDTun/gU6Ro84Nb/1m+LQpsrvjdYi3vx8QEmdE7pVeG43DjhxQpVqGXjCjIQK5RRrJKWACSAsUJWkeJ2@vger.kernel.org, AJvYcCWtXzNe8oCC3d+SpTd4sHAJPbz0pPqDJGFVavDNQW54Gq+P19CQ3FZGzsux9dPwi8tMOwukhtw1ZK6g@vger.kernel.org
X-Gm-Message-State: AOJu0YwreX/Geoyc7hLMfW/1f1Ma2iRqpZsw86rcQwVXTPuonVBg+SSM
	WL3QURM0eCr6HRU5/2zxy5u6Q0DrRMPIkVQ5vbkB9K5KpGKygIP2z5Gq
X-Gm-Gg: ASbGnctqYaLANx53PT5VLbBchP+q0wwaAdztvzqqaW6hFhxQ+ec+nybn0yQJ/3/v/AD
	TJD1WwjwQpKvbpLw7hRQalBwGYWoTKmcAvEc7xmrm5Ut6Tc6JKsAZualAbQ82GlXKhYrhvmtjNK
	eZC6ADF3x4HYarkImgDwNaSb0Jfb2ZnA5A3Z4r2kSOXmJwVF2SG74FsPUtu0KIwlo3ynPnrquv5
	cuhzR8VPa4whwlb02/Rf2qWiWmYOjttMIBUYPS1jUabOb/46sjxSTZzxP+llCLjfCOLQzSyw+DJ
	zOLLbPE73yidFJow6ftVpicVXVx8ag6kHQQXpVtjbJyuZz4tkkL8LcmZFef2Z5YSKgeXC7YHgcA
	nniOCNMp8y9ZCCpw5DCblpQ==
X-Google-Smtp-Source: AGHT+IFBmT+05ifZR454ZsVESbdVZWfFyD6xTKLS6M8LF9x1CYyc9regqDhx1oReUGpYKvUUBLc2rA==
X-Received: by 2002:a05:600c:4fc5:b0:456:1156:e5f5 with SMTP id 5b1f17b1804b1-456359ee0a4mr171859865e9.31.1753124788877;
        Mon, 21 Jul 2025 12:06:28 -0700 (PDT)
Received: from Ansuel-XPS. ([109.52.136.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45862cf1d68sm274285e9.2.2025.07.21.12.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:06:28 -0700 (PDT)
Message-ID: <687e8fb4.050a0220.1055b2.040b@mx.google.com>
X-Google-Original-Message-ID: <aH6Pst_-oqR7AkVX@Ansuel-XPS.>
Date: Mon, 21 Jul 2025 21:06:26 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] dt-bindings: clock: airoha: Document new
 property airoha,chip-scu
References: <20250617130455.32682-1-ansuelsmth@gmail.com>
 <20250617130455.32682-7-ansuelsmth@gmail.com>
 <20250627-determined-helpful-rabbit-be2dfe@krzk-bin>
 <685e5446.df0a0220.369e9e.8cb1@mx.google.com>
 <8582dbad-c773-4f46-827a-83b00eed0882@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8582dbad-c773-4f46-827a-83b00eed0882@kernel.org>

On Wed, Jul 16, 2025 at 04:29:12PM +0200, Krzysztof Kozlowski wrote:
> On 27/06/2025 10:20, Christian Marangi wrote:
> > 
> > Here the current DTS [1]. Nothing is stable for this and we can change
> > it but I want to stress that the current HW block are VERY CONFUSING and
> > SCRAMBELED. So it's really a matter of finding the least bad solution.
> > 
> > In SCU there are:
> > - PART fot the clock register
> > - 2 MDIO controller register
> > 
> > In chip SCU:
> > - Other part of the clock register
> > - Thermal driver register
> > - PART of the pinctrl register
> > 
> > [1] https://github.com/Ansuel/openwrt/blob/openwrt-24.10-airoha-an7581-stable/target/linux/airoha/dts/an7583.dtsi#L361
> 
> 
> Thanks and it proves: that's a no. You cannot have two devices with same
> unit address. It means that chip-scu and scu ARE THE SAME devices.
> 

Thanks for checking it. Hope it's clear that

scuclk: system-controller@1fa20000

is a typo and should be

scuclk: system-controller@1fb00000
(to follow the reg property reg = <0x0 0x1fb00000 0x0 0x970>;
 with the 0x970 taken from the documentation)

With this in mind and if your comment still apply do you have any hint
how to better reorganize the 2 node?

-- 
	Ansuel

