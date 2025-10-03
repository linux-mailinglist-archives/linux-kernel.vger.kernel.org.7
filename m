Return-Path: <linux-kernel+bounces-841013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6889BB5F76
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 07:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00694830AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B11FF1C7;
	Fri,  3 Oct 2025 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBM3Iuiy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E918C03F;
	Fri,  3 Oct 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759471059; cv=none; b=FaeolH49gLttqQKecGhEKkSyG4sPAo4Yr4aMlfX6l79XYaUGTBYisNgxnnhxAoDJWo+Z2AmQDoUHtkltad45ZISm1QEaIKkXGYrqggmSM0qRptQG7myRFXioAoMnahnGapu18OsMvacHAua8QIw4F2XK3ziKFVLQo2OgGs5RKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759471059; c=relaxed/simple;
	bh=0oNC759He1lTOqr7QDNZ5tB39O1bmD82xDV4bqLXrTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJLYfCGHRegIIKxhLkG+pSxD/wtosmFiIVarR1GRasWtKozMFJojCUUSrZJQRotvonwSAq1SVQun0+zZQWSQEJvajXgWmXlGweDOXchuDr8ElXPMvfArPFcgde8zHoaZBGFDEPqKda6D1djtodT8W3/pFELAlNl2/s/CVu1lbVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBM3Iuiy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759471056; x=1791007056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0oNC759He1lTOqr7QDNZ5tB39O1bmD82xDV4bqLXrTI=;
  b=nBM3IuiymrhctJ6e3KlVUlvPdp4HBt8ehY9yj+RNBJvOZSI62m1QE8/1
   TRk8IO/UTMSNJhjwU4cnDacGKnAtwomtarwxajhxXW1Ji/hGCJwb+Gf2Y
   tJuMQspUMnE0ktQCZ21Fg3WBDzs9XwbymkMhmr10kvPkENKLtOGEj/1Mk
   y/A16V9F4wkuilNhAxt3BiuCzRf+NxO8Vf1YoN5uSb2TtIX382NQUXFSs
   xiK5xULQ7qgj7w21wPLQULPrPzR6WUjvv5i68DAPf5QfRkFjfJHeGfPqZ
   94sZ5l27tLR3dGl1czvG2UBnrxVXhS4YZtmFsX94EPu1J38e9zmLYlK6m
   w==;
X-CSE-ConnectionGUID: ltqX3GYSSZGFnbkXSuzZuw==
X-CSE-MsgGUID: XzAokKmTT7yY2oYUCQ+Blw==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61464667"
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="61464667"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 22:57:36 -0700
X-CSE-ConnectionGUID: LZOy1VUVRR2AOhKRFoMQcA==
X-CSE-MsgGUID: 4Ml5LMX3QWuehhaZ2XbJQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="202960643"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Oct 2025 22:57:32 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4YnK-0004MF-06;
	Fri, 03 Oct 2025 05:57:30 +0000
Date: Fri, 3 Oct 2025 13:56:41 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
Message-ID: <202510031333.zZYEFOH0-lkp@intel.com>
References: <20251002172539.586538-3-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002172539.586538-3-krishna.kurapati@oss.qualcomm.com>

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus robh/for-next krzk-dt/for-next linus/master v6.17 next-20251002]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Kurapati/dt-bindings-usb-ti-hd3ss3220-Add-support-for-VBUS-based-on-ID-state/20251003-012933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20251002172539.586538-3-krishna.kurapati%40oss.qualcomm.com
patch subject: [PATCH 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin state
config: x86_64-buildonly-randconfig-001-20251003 (https://download.01.org/0day-ci/archive/20251003/202510031333.zZYEFOH0-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251003/202510031333.zZYEFOH0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510031333.zZYEFOH0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/typec/hd3ss3220.c:336:29: error: call to undeclared function 'gpiod_get_value_cansleep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     336 |         id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;
         |                                    ^
>> drivers/usb/typec/hd3ss3220.c:384:24: error: call to undeclared function 'devm_gpiod_get_optional'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     384 |         hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
         |                               ^
   drivers/usb/typec/hd3ss3220.c:384:24: note: did you mean 'devm_regulator_get_optional'?
   include/linux/regulator/consumer.h:163:32: note: 'devm_regulator_get_optional' declared here
     163 | struct regulator *__must_check devm_regulator_get_optional(struct device *dev,
         |                                ^
>> drivers/usb/typec/hd3ss3220.c:384:70: error: use of undeclared identifier 'GPIOD_IN'
     384 |         hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
         |                                                                             ^
>> drivers/usb/typec/hd3ss3220.c:389:23: error: call to undeclared function 'gpiod_to_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     389 |                 hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
         |                                     ^
   4 errors generated.


vim +/gpiod_get_value_cansleep +336 drivers/usb/typec/hd3ss3220.c

   326	
   327	static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
   328	{
   329		struct hd3ss3220 *hd3ss3220 = dev_id;
   330		int ret;
   331		int id;
   332	
   333		if (IS_ERR_OR_NULL(hd3ss3220->vbus))
   334			return IRQ_HANDLED;
   335	
 > 336		id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;
   337	
   338		if (!id) {
   339			ret = regulator_enable(hd3ss3220->vbus);
   340			if (ret)
   341				dev_err(hd3ss3220->dev, "enable vbus regulator failed\n");
   342		} else {
   343			regulator_disable(hd3ss3220->vbus);
   344		}
   345	
   346		return IRQ_HANDLED;
   347	}
   348	
   349	static int hd3ss3220_probe(struct i2c_client *client)
   350	{
   351		struct typec_capability typec_cap = { };
   352		struct hd3ss3220 *hd3ss3220;
   353		struct fwnode_handle *connector, *ep;
   354		int ret;
   355		unsigned int data;
   356	
   357		hd3ss3220 = devm_kzalloc(&client->dev, sizeof(struct hd3ss3220),
   358					 GFP_KERNEL);
   359		if (!hd3ss3220)
   360			return -ENOMEM;
   361	
   362		i2c_set_clientdata(client, hd3ss3220);
   363	
   364		hd3ss3220->dev = &client->dev;
   365		hd3ss3220->regmap = devm_regmap_init_i2c(client, &config);
   366		if (IS_ERR(hd3ss3220->regmap))
   367			return PTR_ERR(hd3ss3220->regmap);
   368	
   369		/* For backward compatibility check the connector child node first */
   370		connector = device_get_named_child_node(hd3ss3220->dev, "connector");
   371		if (connector) {
   372			hd3ss3220->role_sw = fwnode_usb_role_switch_get(connector);
   373		} else {
   374			ep = fwnode_graph_get_next_endpoint(dev_fwnode(hd3ss3220->dev), NULL);
   375			if (!ep)
   376				return -ENODEV;
   377			connector = fwnode_graph_get_remote_port_parent(ep);
   378			fwnode_handle_put(ep);
   379			if (!connector)
   380				return -ENODEV;
   381			hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
   382		}
   383	
 > 384		hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
   385		if (IS_ERR(hd3ss3220->id_gpiod))
   386			return PTR_ERR(hd3ss3220->id_gpiod);
   387	
   388		if (hd3ss3220->id_gpiod) {
 > 389			hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
   390			if (hd3ss3220->id_irq < 0) {
   391				dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");
   392				return hd3ss3220->id_irq;
   393			}
   394	
   395			ret = devm_request_threaded_irq(hd3ss3220->dev,
   396							hd3ss3220->id_irq, NULL,
   397							hd3ss3220_id_isr,
   398							IRQF_TRIGGER_RISING |
   399							IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
   400							dev_name(hd3ss3220->dev), hd3ss3220);
   401			if (ret < 0) {
   402				dev_err(hd3ss3220->dev, "failed to get id irq\n");
   403				return ret;
   404			}
   405		}
   406	
   407		hd3ss3220->vbus = devm_regulator_get_optional(hd3ss3220->dev, "vbus");
   408		if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
   409			hd3ss3220->vbus = NULL;
   410	
   411		if (IS_ERR(hd3ss3220->vbus))
   412			return dev_err_probe(hd3ss3220->dev,
   413					     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");
   414	
   415		if (IS_ERR(hd3ss3220->role_sw)) {
   416			ret = PTR_ERR(hd3ss3220->role_sw);
   417			goto err_put_fwnode;
   418		}
   419	
   420		typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
   421		typec_cap.driver_data = hd3ss3220;
   422		typec_cap.type = TYPEC_PORT_DRP;
   423		typec_cap.data = TYPEC_PORT_DRD;
   424		typec_cap.ops = &hd3ss3220_ops;
   425		typec_cap.fwnode = connector;
   426	
   427		ret = hd3ss3220_configure_source_pref(hd3ss3220, connector, &typec_cap);
   428		if (ret < 0)
   429			goto err_put_role;
   430	
   431		ret = hd3ss3220_configure_port_type(hd3ss3220, connector, &typec_cap);
   432		if (ret < 0)
   433			goto err_put_role;
   434	
   435		hd3ss3220->port = typec_register_port(&client->dev, &typec_cap);
   436		if (IS_ERR(hd3ss3220->port)) {
   437			ret = PTR_ERR(hd3ss3220->port);
   438			goto err_put_role;
   439		}
   440	
   441		ret = hd3ss3220_configure_power_opmode(hd3ss3220, connector);
   442		if (ret < 0)
   443			goto err_unreg_port;
   444	
   445		hd3ss3220_set_role(hd3ss3220);
   446		ret = regmap_read(hd3ss3220->regmap, HD3SS3220_REG_CN_STAT_CTRL, &data);
   447		if (ret < 0)
   448			goto err_unreg_port;
   449	
   450		if (data & HD3SS3220_REG_CN_STAT_CTRL_INT_STATUS) {
   451			ret = regmap_write(hd3ss3220->regmap,
   452					HD3SS3220_REG_CN_STAT_CTRL,
   453					data | HD3SS3220_REG_CN_STAT_CTRL_INT_STATUS);
   454			if (ret < 0)
   455				goto err_unreg_port;
   456		}
   457	
   458		if (client->irq > 0) {
   459			ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
   460						hd3ss3220_irq_handler,
   461						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
   462						"hd3ss3220", &client->dev);
   463			if (ret)
   464				goto err_unreg_port;
   465		} else {
   466			INIT_DELAYED_WORK(&hd3ss3220->output_poll_work, output_poll_execute);
   467			hd3ss3220->poll = true;
   468		}
   469	
   470		ret = i2c_smbus_read_byte_data(client, HD3SS3220_REG_DEV_REV);
   471		if (ret < 0)
   472			goto err_unreg_port;
   473	
   474		fwnode_handle_put(connector);
   475	
   476		if (hd3ss3220->poll)
   477			schedule_delayed_work(&hd3ss3220->output_poll_work, HZ);
   478	
   479		dev_info(&client->dev, "probed revision=0x%x\n", ret);
   480	
   481		return 0;
   482	err_unreg_port:
   483		typec_unregister_port(hd3ss3220->port);
   484	err_put_role:
   485		usb_role_switch_put(hd3ss3220->role_sw);
   486	err_put_fwnode:
   487		fwnode_handle_put(connector);
   488	
   489		return ret;
   490	}
   491	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

