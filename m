Return-Path: <linux-kernel+bounces-834205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEADABA42E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D67561F83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB6F219A67;
	Fri, 26 Sep 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXkRyRCw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8A1C8621;
	Fri, 26 Sep 2025 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896500; cv=none; b=dSQlxm0RzRZeLsPw4FTHWM4Gbdc4dpnXfsu7crZJYjEPpkna7sAV2Rqx2Lhww3fjPypI9M9sw6bV40n5canAthtZWFuno4v8JxFqQsDLla0g2K7hBCSQDY11X2OeY0b8zxBZbjhttEpwzS6ui/h3fm/xtk5LYO5w4IBZ5162Xys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896500; c=relaxed/simple;
	bh=pAmUReU8KLwvxGZCjecPfjyvszxwf4OdUVpeaF6BQYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOIUpoq45tS6XUuGZtAdO+wD68wtG1s5pa7zpOIBnBF4HT0s5ED7ocYHqbWIesAmrLb6qN5M4OeRDYdW+04Saag6hpfYnzC6gwZwzL/v6Tk1nyUgk97klGKVwmRapytEfSPQ9B0r/6eW4bIql/aYidvq8vKuTIXc0+HDkQnXjOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXkRyRCw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758896499; x=1790432499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pAmUReU8KLwvxGZCjecPfjyvszxwf4OdUVpeaF6BQYo=;
  b=bXkRyRCwOQ7k/dGhYFxsIhH0yJHHNM0YDB9fj6guPZ95AYLab1n2L8vd
   aQE3OlRUTJt8pBXk23WZNmHEM1Zn5gprFDXwItGJw+bYEFpDxoO1E76gx
   pDge4v/dJnD8q3vR3xcp6JNMXy+X3gGvoaIQdZz/RV/Y2iqD/nVxHrsAq
   kM7+rZg+kSPNIMHNRuHfuU9kazVYp1RLp65YiR8DOnGyR0Y76djX4YskJ
   3MJVCLIetzyjeOukP5GYfWDOyscpf4mi4D4beIhz6S9k4dvG36MoD0fOS
   HefML1ajM0eGeJIaau0uTKKEBqaneUJ/Ov+JgDVo+R7MBez8tCNDGTj6J
   Q==;
X-CSE-ConnectionGUID: 7dcEJOqCTs6ChSe5LgLg+Q==
X-CSE-MsgGUID: FondeurUSEuCQcqXlohKxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="60269012"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="60269012"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 07:21:38 -0700
X-CSE-ConnectionGUID: WnjxCpZ5RMuUaNGU5axoUQ==
X-CSE-MsgGUID: v4bRtakgRT+iIpDLkOlt0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="176899004"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 26 Sep 2025 07:21:32 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v29Jm-0006IX-35;
	Fri, 26 Sep 2025 14:21:18 +0000
Date: Fri, 26 Sep 2025 22:20:04 +0800
From: kernel test robot <lkp@intel.com>
To: Jeff Lin <jefflin994697@gmail.com>, jdelvare@suse.com,
	linux@roeck-us.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cedricjustine.encarnacion@analog.com, ninad@linux.ibm.com,
	andriy.shevchenko@linux.intel.com,
	johnerasmusmari.geronimo@analog.com, Mariel.Tinaco@analog.com,
	jbrunet@baylibre.com, kimseer.paller@analog.com,
	leo.yang.sy0@gmail.com, nuno.sa@analog.com,
	chiang.brian@inventec.com, gregkh@linuxfoundation.org,
	grantpeltier93@gmail.com, william@wkennington.com,
	krzysztof.kozlowski@linaro.org, tzungbi@kernel.org,
	thorsten.blum@linux.dev, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeff Lin <jefflin994697@gmail.com>
Subject: Re: [PATCH] drivers/hwmon/pmbus: Add support for raa229141 in
 isl68137
Message-ID: <202509262212.QaMSQytw-lkp@intel.com>
References: <20250926014552.1625950-1-jefflin994697@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926014552.1625950-1-jefflin994697@gmail.com>

Hi Jeff,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.17-rc7]
[also build test WARNING on linus/master next-20250925]
[cannot apply to groeck-staging/hwmon-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Lin/drivers-hwmon-pmbus-Add-support-for-raa229141-in-isl68137/20250926-094703
base:   v6.17-rc7
patch link:    https://lore.kernel.org/r/20250926014552.1625950-1-jefflin994697%40gmail.com
patch subject: [PATCH] drivers/hwmon/pmbus: Add support for raa229141 in isl68137
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250926/202509262212.QaMSQytw-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509262212.QaMSQytw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509262212.QaMSQytw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/pmbus/isl68137.c:66:1: error: expected identifier
      66 | +#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
         | ^
   drivers/hwmon/pmbus/isl68137.c:68:1: error: expected identifier
      68 | +#endif /* CONFIG_SENSORS_RAA229141 */
         | ^
>> drivers/hwmon/pmbus/isl68137.c:190:5: warning: no previous prototype for function 'read_isys_route_dma' [-Wmissing-prototypes]
     190 | int read_isys_route_dma(struct i2c_client *client, const char *addr)
         |     ^
   drivers/hwmon/pmbus/isl68137.c:190:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     190 | int read_isys_route_dma(struct i2c_client *client, const char *addr)
         | ^
         | static 
   1 warning and 2 errors generated.


vim +/read_isys_route_dma +190 drivers/hwmon/pmbus/isl68137.c

    25	
    26	enum chips {
    27		isl68137,
    28		isl68220,
    29		isl68221,
    30		isl68222,
    31		isl68223,
    32		isl68224,
    33		isl68225,
    34		isl68226,
    35		isl68227,
    36		isl68229,
    37		isl68233,
    38		isl68239,
    39		isl69222,
    40		isl69223,
    41		isl69224,
    42		isl69225,
    43		isl69227,
    44		isl69228,
    45		isl69234,
    46		isl69236,
    47		isl69239,
    48		isl69242,
    49		isl69243,
    50		isl69247,
    51		isl69248,
    52		isl69254,
    53		isl69255,
    54		isl69256,
    55		isl69259,
    56		isl69260,
    57		isl69268,
    58		isl69269,
    59		isl69298,
    60		raa228000,
    61		raa228004,
    62		raa228006,
    63		raa228228,
    64		raa229001,
    65		raa229004,
  > 66	+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
    67	+	raa229141,
    68	+#endif /* CONFIG_SENSORS_RAA229141 */
    69		raa229621,
    70	};
    71	
    72	enum variants {
    73		raa_dmpvr1_2rail,
    74		raa_dmpvr2_1rail,
    75		raa_dmpvr2_2rail,
    76		raa_dmpvr2_2rail_nontc,
    77	#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
    78		raa_dmpvr2_2rail_isys,
    79	#endif /* CONFIG_SENSORS_RAA229141 */
    80		raa_dmpvr2_3rail,
    81		raa_dmpvr2_hv,
    82	};
    83	
    84	struct isl68137_channel {
    85		u32 vout_voltage_divider[2];
    86	};
    87	
    88	struct isl68137_data {
    89		struct pmbus_driver_info info;
    90		struct isl68137_channel channel[MAX_CHANNELS];
    91	};
    92	
    93	#define to_isl68137_data(x)	container_of(x, struct isl68137_data, info)
    94	
    95	static const struct i2c_device_id raa_dmpvr_id[];
    96	
    97	static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
    98						     int page,
    99						     char *buf)
   100	{
   101		int val = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
   102	
   103		return sprintf(buf, "%d\n",
   104			       (val & ISL68137_VOUT_AVS) == ISL68137_VOUT_AVS ? 1 : 0);
   105	}
   106	
   107	static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,
   108						      int page,
   109						      const char *buf, size_t count)
   110	{
   111		int rc, op_val;
   112		bool result;
   113	
   114		rc = kstrtobool(buf, &result);
   115		if (rc)
   116			return rc;
   117	
   118		op_val = result ? ISL68137_VOUT_AVS : 0;
   119	
   120		/*
   121		 * Writes to VOUT setpoint over AVSBus will persist after the VRM is
   122		 * switched to PMBus control. Switching back to AVSBus control
   123		 * restores this persisted setpoint rather than re-initializing to
   124		 * PMBus VOUT_COMMAND. Writing VOUT_COMMAND first over PMBus before
   125		 * enabling AVS control is the workaround.
   126		 */
   127		if (op_val == ISL68137_VOUT_AVS) {
   128			rc = pmbus_read_word_data(client, page, 0xff,
   129						  PMBUS_VOUT_COMMAND);
   130			if (rc < 0)
   131				return rc;
   132	
   133			rc = pmbus_write_word_data(client, page, PMBUS_VOUT_COMMAND,
   134						   rc);
   135			if (rc < 0)
   136				return rc;
   137		}
   138	
   139		rc = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
   140					    ISL68137_VOUT_AVS, op_val);
   141	
   142		return (rc < 0) ? rc : count;
   143	}
   144	
   145	static ssize_t isl68137_avs_enable_show(struct device *dev,
   146						struct device_attribute *devattr,
   147						char *buf)
   148	{
   149		struct i2c_client *client = to_i2c_client(dev->parent);
   150		struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
   151	
   152		return isl68137_avs_enable_show_page(client, attr->index, buf);
   153	}
   154	
   155	static ssize_t isl68137_avs_enable_store(struct device *dev,
   156					struct device_attribute *devattr,
   157					const char *buf, size_t count)
   158	{
   159		struct i2c_client *client = to_i2c_client(dev->parent);
   160		struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
   161	
   162		return isl68137_avs_enable_store_page(client, attr->index, buf, count);
   163	}
   164	
   165	static SENSOR_DEVICE_ATTR_RW(avs0_enable, isl68137_avs_enable, 0);
   166	static SENSOR_DEVICE_ATTR_RW(avs1_enable, isl68137_avs_enable, 1);
   167	
   168	static struct attribute *enable_attrs[] = {
   169		&sensor_dev_attr_avs0_enable.dev_attr.attr,
   170		&sensor_dev_attr_avs1_enable.dev_attr.attr,
   171		NULL,
   172	};
   173	
   174	static const struct attribute_group enable_group = {
   175		.attrs = enable_attrs,
   176	};
   177	
   178	static const struct attribute_group *isl68137_attribute_groups[] = {
   179		&enable_group,
   180		NULL,
   181	};
   182	
   183	#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
   184	#define RAA_READ_DMA_DATA	0xc5
   185	#define RAA_WRITE_DMA_ADDRESS 0xc7
   186	
   187	/* DMA address for input and output */
   188	static const unsigned char dma_address_in[] = { 0xD3, 0xE0 };
   189	static const unsigned char dma_address_out[] = { 0x42, 0xEE };
 > 190	int read_isys_route_dma(struct i2c_client *client, const char *addr)
   191	{
   192		int ret;
   193	
   194		ret = i2c_smbus_write_i2c_block_data(client, RAA_WRITE_DMA_ADDRESS, 2, addr);
   195		if (ret < 0) {
   196			dev_err(&client->dev, "Set DMA address failed for address 0x%02x 0x%02x\n",
   197				addr[0], addr[1]);
   198			return ret;
   199		}
   200		// DIRECT ISYS format 10mA/LSB
   201		u8 buf[2];
   202	
   203		ret = i2c_smbus_read_i2c_block_data(client, RAA_READ_DMA_DATA, 2, buf);
   204		if (ret < 0)
   205			return ret;
   206		u16 value = ((u16)buf[1]<<8) | buf[0];
   207		return value;
   208	};
   209	#endif /* CONFIG_SENSORS_RAA229141 */
   210	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

