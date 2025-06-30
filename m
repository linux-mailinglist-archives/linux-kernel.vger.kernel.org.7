Return-Path: <linux-kernel+bounces-709194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C51AEDA59
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 12:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0033B446F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B9258CFF;
	Mon, 30 Jun 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xeCO+hnB"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE82635897;
	Mon, 30 Jun 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281036; cv=none; b=AKc27/0Gd7Jf/L5hqmwlEHrfjpjFs+GusgBJ/cLZUvBeFrJlv19f7p6YkVdfCU9tGUSKlzM91jFyxz93lKggE3Rpp6NEacxv7VSahxTGl82wz8wgwaiP9NnL19M49VIbrBSECQ37sqeWW6MYIDGWtdSlICw+Z4oh/VPm9Las5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281036; c=relaxed/simple;
	bh=CU3lF7GpopSujcYYmQxQlRhWUpHMbM/7ONJNWP+aEhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sk/NImjWBLZ/xUfdJ5tfGkh9+bfxgPmyLzE2useeMOIYvVvu/7XGR9yQ6VI0tebIOCFtzTbI+p56jLJU9zq3AVPn4asa0q6P7FsA4dcAUu2mi+gzBUbm+ksAJpup2WaNe0zV9AMp9otxd//2ZwA69sWoHXza6Q8Ox9c3RO+gXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xeCO+hnB; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55UAuNIH2597766;
	Mon, 30 Jun 2025 05:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751280983;
	bh=acvrbpRviTNdz87CgiPJ6NZ3slsRFB/mPnj2SWFWZ4A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xeCO+hnB5HBzo4hUbt4UANhYdxGNt7R60UrAi+p3Xx9gmxJ8kbl+RuWhyxLcO193M
	 fU1V/yPlxjGGZgiTk3SfASyyVNzL2lWOFVEEhigqrHp+IPlW2oXj0dsqQeMguKnHZ8
	 AU3G2UjUWY4sV1PepGUYpt/ZY003EmB+B8yN6rZY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55UAuNXB1500319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 30 Jun 2025 05:56:23 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 30
 Jun 2025 05:56:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 30 Jun 2025 05:56:22 -0500
Received: from [172.24.227.167] (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.167])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55UAuFED3485146;
	Mon, 30 Jun 2025 05:56:16 -0500
Message-ID: <0c50d505-6d1c-4723-b3a7-740307ed9ec9@ti.com>
Date: Mon, 30 Jun 2025 16:26:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] drm/tidss: Add OLDI bridge support
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michael Walle
	<mwalle@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann
	<tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simona Vetter <simona@ffwll.ch>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Praneeth
 Bajjuri <praneeth@ti.com>,
        Udit Kumar <u-kumar1@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List
	<devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>
References: <20250528122544.817829-1-aradhya.bhatia@linux.dev>
 <20250528122544.817829-5-aradhya.bhatia@linux.dev>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20250528122544.817829-5-aradhya.bhatia@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Aradhya, Tomi,

On 28/05/25 17:55, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> The AM62x and AM62Px SoCs feature 2 OLDI TXes each, which makes it
> possible to connect them in dual-link or cloned single-link OLDI display
> modes. The current OLDI support in tidss_dispc.c can only support for
> a single OLDI TX, connected to a VP and doesn't really support
> configuration of OLDIs in the other modes. The current OLDI support in
> tidss_dispc.c also works on the principle that the OLDI output can only
> be served by one, and only one, DSS video-port. This isn't the case in
> the AM62Px SoC, where there are 2 DSS controllers present that share the
> OLDI TXes.
> 

[...]

> +}
> +
> +int tidss_oldi_init(struct tidss_device *tidss)
> +{
> +	struct tidss_oldi *oldi;
> +	struct device_node *child;
> +	struct drm_bridge *bridge;
> +	u32 parent_vp, oldi_instance;
> +	int companion_instance = -1;
> +	enum tidss_oldi_link_type link_type = OLDI_MODE_UNSUPPORTED;
> +	struct device_node *oldi_parent;
> +	int ret = 0;
> +
> +	tidss->num_oldis = 0;
> +
> +	oldi_parent = of_get_child_by_name(tidss->dev->of_node, "oldi-transmitters");
> +	if (!oldi_parent)
> +		/* Return gracefully */
> +		return 0;
> +
> +	for_each_available_child_of_node(oldi_parent, child) {
> +		ret = get_parent_dss_vp(child, &parent_vp);
> +		if (ret) {
> +			if (ret == -ENODEV) {
> +				/*
> +				 * ENODEV means that this particular OLDI node
> +				 * is not connected with the DSS, which is not
> +				 * a harmful case. There could be another OLDI
> +				 * which may still be connected.
> +				 * Continue to search for that.
> +				 */
> +				ret = 0;
> +				continue;
> +			}
> +			goto err_put_node;
> +		}
> +
> +		ret = of_property_read_u32(child, "reg", &oldi_instance);
> +		if (ret)
> +			goto err_put_node;
> +
> +		/*
> +		 * Now that it's confirmed that OLDI is connected with DSS,
> +		 * let's continue getting the OLDI sinks ahead and other OLDI
> +		 * properties.
> +		 */
> +		bridge = devm_drm_of_get_bridge(tidss->dev, child,
> +						OLDI_OUTPUT_PORT, 0);
> +		if (IS_ERR(bridge)) {
> +			/*
> +			 * Either there was no OLDI sink in the devicetree, or
> +			 * the OLDI sink has not been added yet. In any case,
> +			 * return.
> +			 * We don't want to have an OLDI node connected to DSS
> +			 * but not to any sink.
> +			 */
> +			ret = dev_err_probe(tidss->dev, PTR_ERR(bridge),
> +					    "no panel/bridge for OLDI%u.\n",
> +					    oldi_instance);
> +			goto err_put_node;
> +		}
> +
> +		link_type = get_oldi_mode(child, &companion_instance);
> +		if (link_type == OLDI_MODE_UNSUPPORTED) {
> +			ret = dev_err_probe(tidss->dev, -EINVAL,
> +					    "OLDI%u: Unsupported OLDI connection.\n",
> +					    oldi_instance);
> +			goto err_put_node;
> +		} else if ((link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) ||
> +			   (link_type == OLDI_MODE_CLONE_SINGLE_LINK)) {
> +			/*
> +			 * The OLDI driver cannot support OLDI clone mode
> +			 * properly at present.
> +			 * The clone mode requires 2 working encoder-bridge
> +			 * pipelines, generating from the same crtc. The DRM
> +			 * framework does not support this at present. If
> +			 * there were to be, say, 2 OLDI sink bridges each
> +			 * connected to an OLDI TXes, they couldn't both be
> +			 * supported simultaneously.
> +			 * This driver still has some code pertaining to OLDI
> +			 * clone mode configuration in DSS hardware for future,
> +			 * when there is a better infrastructure in the DRM
> +			 * framework to support 2 encoder-bridge pipelines
> +			 * simultaneously.
> +			 * Till that time, this driver shall error out if it
> +			 * detects a clone mode configuration.
> +			 */
> +			ret = dev_err_probe(tidss->dev, -EOPNOTSUPP,
> +					    "The OLDI driver does not support Clone Mode at present.\n");
> +			goto err_put_node;
> +		} else if (link_type == OLDI_MODE_SECONDARY_DUAL_LINK) {
> +			/*
> +			 * This is the secondary OLDI node, which serves as a
> +			 * companion to the primary OLDI, when it is configured
> +			 * for the dual-link mode. Since the primary OLDI will
> +			 * be a part of bridge chain, no need to put this one
> +			 * too. Continue onto the next OLDI node.
> +			 */
> +			continue;
> +		}
> +
> +		oldi = devm_kzalloc(tidss->dev, sizeof(*oldi), GFP_KERNEL);

I think this needs to be changed to devm_drm_bridge_alloc() to get rid
of the kernel warning. I am seeing WARNING in OLDI like:

[   10.198109] WARNING: lib/refcount.c:25 at 
refcount_warn_saturate+0x120/0x144, CPU#0: kworker/u16:0/12
[   10.198140] Modules linked in: snd_soc_simple_card mux_gpio 
snd_soc_simple_card_utils panel_simple cdns3_ti display_connector 
snd_soc_davinci_mcasp phy_can_transceiver k3_j72xx_bandgap tps6594_i2c tps6
[   10.198310] CPU: 0 UID: 0 PID: 12 Comm: kworker/u16:0 Not tainted 
6.16.0-rc3-next-20250627-00046-ga876218600d6 #197 PREEMPT
[   10.198321] Hardware name: Texas Instruments J722S EVM (DT)
[   10.198327] Workqueue: events_unbound deferred_probe_work_func
[   10.198344] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   10.198352] pc : refcount_warn_saturate+0x120/0x144
[   10.198359] lr : refcount_warn_saturate+0x120/0x144
[   10.198365] sp : ffff800082fa3a30
[   10.198368] x29: ffff800082fa3a30 x28: 0000000000000000 x27: 
0000000000000000
[   10.198377] x26: 0000000000000004 x25: 0000000000000001 x24: 
ffff80007b1edf48
[   10.198386] x23: ffff000806fa0000 x22: ffff00080c466800 x21: 
ffff00094701ec20
[   10.198395] x20: ffff00080f9cec80 x19: ffff00080f9cec90 x18: 
fffffffffffe99f8
[   10.198404] x17: ffff8008c4f5e000 x16: ffff800080000000 x15: 
0000000000000002
[   10.198414] x14: ffff0008001dc680 x13: 0000000000000021 x12: 
0000000013cbce01
[   10.198423] x11: 00000005cc209839 x10: ffff000946f68a40 x9 : 
ffff0008001dc680
[   10.198433] x8 : 0000000000000000 x7 : ffff0008001dc680 x6 : 
0000000000000002
[   10.198441] x5 : 0000000000000400 x4 : 0000000000000400 x3 : 
0000000013cbce01
[   10.198450] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff0008001dc600
[   10.198459] Call trace:
[   10.198464]  refcount_warn_saturate+0x120/0x144 (P)
[   10.198473]  drm_bridge_add+0xec/0xf0 [drm]
[   10.198733]  tidss_oldi_init+0x2e0/0x434 [tidss]
[   10.198759]  tidss_probe+0x1a4/0x2e0 [tidss]
[   10.198774]  platform_probe+0x68/0xc4
[   10.198786]  really_probe+0xbc/0x29c
[   10.198798]  __driver_probe_device+0x78/0x12c
[   10.198808]  driver_probe_device+0xd8/0x15c
[   10.198817]  __device_attach_driver+0xb8/0x134




oldi = devm_drm_bridge_alloc(tidss->dev, struct tidss_oldi, bridge,
                              &tidss_oldi_bridge_funcs);

I am posting a fix patch for this since now its merged to linux-next.

Thanks,
Jayesh

[...]

