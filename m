Return-Path: <linux-kernel+bounces-849459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B7BBD02C3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427C01892E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0417E188596;
	Sun, 12 Oct 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="GYdvTvuI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZk6iema"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CE2EAE3
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760276025; cv=none; b=n6WiYlqWumDeATWPLcEzQ7NpQX+y9b6Q2VOzX1yicpswT79IA5Tmg/YYbzKOjjA6kmvoEkjTfrDSvPA59+4ceNtDQsfFW0wdvefdFlxZfRVsupWvKNzhjHDrW8XcXZ/vdwOz1fjAAYB8+8PxAJWH8/jL5uWTGH+wtXI39npMk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760276025; c=relaxed/simple;
	bh=Ww5plqoNeNO1cU6mKtLyHrtk8QN93Cdv2cblf0oYPJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tdi0kbPzWlQTG4mE5Y5t1OeLdImxZMV92b7117CD8wfckcyxFK4JZCbVAtLVjLR8T614rAVoIy+3BnhnuD2P0dd04tVR2yojdn2DEoqgVBMDfzF5d6Ed9wVII/NS1jrhtnjJVYQbqHBStPDrqjL4Gq6kzLneBjK3Eo3Ks+xPOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=GYdvTvuI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JZk6iema; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1C4D7A00D4;
	Sun, 12 Oct 2025 09:33:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 12 Oct 2025 09:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760276021; x=1760362421; bh=WLOCDyMr2h
	FKeVuMRVe8+2z9soTconDeuvbennxCXRY=; b=GYdvTvuIgaxhdKELz3DLpQST4q
	dl7J2zysVb8n9tJ/BdViBKLPSG7wwEs/+0ijfEG8gtgZ4bGg5jsOMX/csm9IraC/
	4/ze8SBN+4tWT0UVuEA2qoVvYPMAjWfCZ7uLGefuMw3QMb7Q3nWJOPGp+QxNkrxE
	6Fb6iq3PdafzYOaJ9xkFYFEaCeGPHkwoVAwCJOW6a3rZD6g9iLaKMsbU1ZVLgyMe
	CpTG6wDzPEOereV+NmqO8g6syfR036Ph5FqbO0xndAMznUWJPjMQame1gPTuwUp8
	zQUk7lrYOTIBGMAqp4gNJYanipw3Xs+g2mfF+VwjJbIHMiY4KLVSWr4HLzmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760276021; x=1760362421; bh=WLOCDyMr2hFKeVuMRVe8+2z9soTconDeuvb
	ennxCXRY=; b=JZk6iemaf2Igw4rURPW39zUigWKIQw/wKkrXNTRmMW/0qeVEPC9
	xjzSLKFVNEvspRoHJw7VXW4XFZtiH2KWrZLYbZkFqLqJt29t5hMMDSKrJgR9e9I2
	AsgddeaUUjhjtF8iMXUN1fsddYkLygYc7i2cxfznOEpVhwKbuN/QzdT/RuTz/njS
	orCmyK8qSAszXvjuDAo9zuE4T6SsWCyp5325KarRVZ3rUicCNHErKDNJrS9AM89f
	8rS1HyiBTmZrsNpCI06hXQKxFydTLzhv+GJ6v2s3N7uacMPTieWM5QorWFt1AAqD
	3TcxbPTYI8spoU3OKE2F5yR0BLXc81j32FA==
X-ME-Sender: <xms:M67raO_H7_9CxSIkVVjYIxr5kajMi6G-8lH1-noCcymbZ8EKKy6gRQ>
    <xme:M67raNMYk9gK6iDYrGCamdv-_s9UTnfQBnP-8N-KFWm6nX1PlsJd2XHUAxZe5nV5q
    KPIzTK_SzTKsgvTQHV0N8Ftn4zb_ystIt1SagiJzyo0RiVNq6vRRzc>
X-ME-Received: <xmr:M67raK0_b7Haee385PeeWdbZlETWnAGqUlkl8JY55C-fJtnVmqTPx5TYyZYdgW1ln2Ldct-peo_VwfiRSlrQv9FlfwDmzmSLULw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudegledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgud
    euffelfeekgeeukedtheekjeettdfftddujefhvdehtefgiefgledtueefjeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdp
    rhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrg
    hrnhgusgdruggvpdhrtghpthhtohepphgrnhhkrghjrdguuhgsvgihsehsrghmshhunhhg
    rdgtohhmpdhrtghpthhtohephhgvihhkohesshhnthgvtghhrdguvgdprhgtphhtthhope
    hlihhvihhurdguuhgurghusegrrhhmrdgtohhmpdhrtghpthhtohepshhuuggvvghprdhh
    ohhllhgrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhpihgvrhgrlhhishhisehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:M67raGfWdQpDopDNEBK-DmDT32-jqH8nVHiR2BC8iobSZ8G_GtmA_w>
    <xmx:M67raLYRwBswDOBl2WOvODzP5eD4CuKRh9iXRhUwRcxibtqBxnHffQ>
    <xmx:M67raLWMscTU9YJoqhxDorc6TvXXphYdVeE1pf3-njdcbfLbP50ZEg>
    <xmx:M67raOSMjM-qP-9YPYqVjks970XbOLLDbrIl-Kir-OnNxMJPQJqMUQ>
    <xmx:Na7raHdNm4Mu4-irwylHsP2TIRk89KD3IJnT_RasnQdAzYfvks86i-im>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Oct 2025 09:33:38 -0400 (EDT)
Date: Sun, 12 Oct 2025 15:33:37 +0200
From: Janne Grunau <j@jannau.net>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH v2 2/3] mfd: syscon: Remove the platform driver support
Message-ID: <20251012133337.GA897177@robin.jannau.net>
References: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
 <20241217-syscon-fixes-v2-2-4f56d750541d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217-syscon-fixes-v2-2-4f56d750541d@kernel.org>

On Tue, Dec 17, 2024 at 12:11:41PM -0600, Rob Herring (Arm) wrote:
> The platform driver is dead code. It is not used by DT platforms since
> commit bdb0066df96e ("mfd: syscon: Decouple syscon interface from
> platform devices") which said:
> 
>     For non-DT based platforms, this patch keeps syscon platform driver
>     structure so that syscon can be probed and such non-DT based drivers
>     can use syscon_regmap_lookup_by_pdev API and access regmap handles.
>     Once all users of "syscon_regmap_lookup_by_pdev" migrated to DT based,
>     we can completely remove platform driver of syscon, and keep only helper
>     functions to get regmap handles.
> 
> The last user of syscon_regmap_lookup_by_pdevname() was removed in 2018.
> syscon_regmap_lookup_by_pdevname() was then removed in 2019, but that
> commit failed to remove the rest of the platform driver.

This removed the only driver claiming pmgr nodes on Apple silicon
platforms. The nodes use compatible strings of the form

compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";

The description still holds as the removal of the driver did not result
in functional changes and went unnoticed. The missing driver became 
apparent with pmdomain's sync_state() support in 6.17 which prints
following messages on a M1 mac mini

| [   11.789419] apple-pmgr-pwrstate 23b700000.power-management:power-controller@420: sync_state() pending due to 23d280000.power-management
| [   11.792414] apple-pmgr-pwrstate 23b700000.power-management:power-controller@448: sync_state() pending due to 23d280000.power-management

None of the other compatible are claimed by any driver. There is no
driver for "apple,t8103-pmgr" or "apple,pmgr" and simple-pm-bus.c binds
"simple-mfd" only if it is the first compatible string.

The easiest solution would be to probe via simple-pm-bus.c if the device
is compatible with "apple,pmgr". The generic compatible is justified by
not having any device specific code. The other option would by to add
the growing list of SoC specific "apple,*-pmgr" compatibles to the match
table.
The alternative of writing an Apple pmgr driver which does nothing
except successfully probing devices does not look appealing.

There is second problem though. The device link between
23b700000.power-management:power-controller@420 and
23d280000.power-management should not exist in the first place. See
following excerpt from arch/arm64/boot/dts/apple/{t8103,t8103-pmgr}.dtsi
omitting only unrelated child nodes.

/ {
	pmgr: power-management@23b700000 {
		compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
		#address-cells = <1>;
		#size-cells = <1>;
		reg = <0x2 0x3b700000 0 0x14000>;

		ps_atc0_common: power-controller@420 {
			compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
			reg = <0x420 4>;
			#power-domain-cells = <0>;
			#reset-cells = <0>;
			label = "atc0_common";
		};
	};

	pmgr_mini: power-management@23d280000 {
		compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
		#address-cells = <1>;
		#size-cells = <1>;
		reg = <0x2 0x3d280000 0 0x4000>;

		ps_atc0_usb: power-controller@98 {
			compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
			reg = <0x98 4>;
			#power-domain-cells = <0>;
			#reset-cells = <0>;
			label = "atc0_usb";
			power-domains = <&ps_atc0_usb_aon>, <&ps_atc0_common>;
		};
	};
}

To my understanding the fw_devlinks should only exists between
&ps_atc0_common and &ps_atc0_usb. Herve Codina reports and posts a patch
for what sounds to be the same issue in [1] for simple-pm-bus. I can't
reproduce the report though. As soon as simple-pm-bus successfully
probes the pmgr devices the spurious devlinks are gone.

So I think this needs to be fixed in either of/platform.c for all
devices handled in of_platform_default_populate() or in
driver-core/devlink considering the issue appears without driver for the
bus device.

Janne

[1]: https://lore.kernel.org/lkml/20250613134817.681832-6-herve.codina@bootlin.com/

