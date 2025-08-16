Return-Path: <linux-kernel+bounces-772057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 089AEB28E56
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6D91BC0B01
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8D2E9738;
	Sat, 16 Aug 2025 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlIIwG+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD31D5150;
	Sat, 16 Aug 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353203; cv=none; b=IfE96EkHZI7KRRFz5MwqkCGiZ9z/tZc7wwse7v5Cdmq9ysTqawRi67likve6ofpfHNHcnR/PTIDxKwQKjsTlcY9m3t+JW6cX0VjkjgdNzpoUQBFJkm7zOqOTE+r4vR9QxS85SD/maOtPJE/XpmA897gL2us0l9sNKs1mX0pOK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353203; c=relaxed/simple;
	bh=n9KMFbKsDEZtJ9f9UHIfJm2mwyenMhPqIdyR4kfmItA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGYs9yeXKTA6Pp92EpX4ncP7ahccL57zttRyNex4YxWeRWGYB6XYsNiNkZatoiVT5s2oYhCx4n0IO7ZNh6rvq0/VUVoaVK5Xa7mvnNt0yJry8rQPkoVYK6IrgknUkyBtOLBDCZsnNMaDwM276E5StFN+aM1AX4HuWw1Ub1kB2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlIIwG+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF77C4CEEF;
	Sat, 16 Aug 2025 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755353201;
	bh=n9KMFbKsDEZtJ9f9UHIfJm2mwyenMhPqIdyR4kfmItA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HlIIwG+uWOt/2nZYkISORRYS9zq7FDaj9GoQJJgbP7dqAppsOmMjwm4Ps94tVf+w0
	 Kc50fxJzXlRUnk5RPI7BC+3Z0POcvmNA2bV/paTYn1KIYh36Z2Dg5Ixx3r/OD4/7Po
	 xKX/Wdy0RuWa+hKaODaGCPsb+eggnR1GGEBLmVk1xU7Lpe51EhqEtk/8i3TGqVfMSJ
	 U1IiUg9aClnjG4REaSmbVWxp0WUVddG4tSMBdOW4y//NH7uhXUBgOBeecZ5k66opfD
	 unGAukxqx8Qoji4R5m6ihb6LvW98Eh1ajHnjxNQ7rn1NPkIBQ/mk76zVILoNzWwGQw
	 bJYGHxHjafYGQ==
Message-ID: <b7491aed-8942-4dd0-b2c8-349a9db1ca39@kernel.org>
Date: Sat, 16 Aug 2025 16:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Apple device tree sync from downstream kernel
To: j@jannau.net, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>,
 Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.08.25 11:53, Janne Grunau via B4 Relay wrote:
> This series pulls changes from the downstream device trees which are
> supported in upstream kernel.
> Most importantly it fixes the PCIe description for a specific iMac model
> (iMac M1, 2 USB-C ports, 2021). This is worked around in the downstream
> kernel by not disabling the port. In preparation for submitting M2
> Pro/Max/Ultra devices trees I investigated the issue on the similarly
> affected M2 Pro Mac mini and fixed it this way.
> It completes the Wlan/BT device nodes for t600x based devices and adds
> the missing 15-inch Macbook Air (M2, 2023).
> 
> Checkpatch emits following warnings:
> 
> WARNING: DT compatible string vendor "pci14e4" appears un-documented --
> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
> 
> Which I chose to ignore. `vendor-prefixes.yaml` prefixes contains no
> other mapping for PCI vendor code and the list of ignored prefixes
> forbids extending it. Both options feel wrong though. "pci${vendor}" is
> clearly a vendor prefix but duplicating the PCI vendor data base feels
> wrong. `vendor-prefixes.yaml` currently does not contain and PCI vendor
> aliases.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

For the entire series:

Reviewed-by: Sven Peter <sven@kernel.org>



Thanks,


Sven


