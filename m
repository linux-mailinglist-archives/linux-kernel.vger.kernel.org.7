Return-Path: <linux-kernel+bounces-841092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B447ABB63E2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A370F18877D6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3993D26E711;
	Fri,  3 Oct 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSj+X3hk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543226C3A8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759480572; cv=none; b=V6FvNhszAxgd5ALN48haS1IlDSgYfShcZprRAdwK/m7xkSqIs9kLS3C+kaY6sv04jC1nfAgPi57XYnB5KxDRoimzpwVIn91WtM2QcKNJ5+5mgfS60owIjnzuxYS4o9YFvURPSQ0A5mlPHW2e4mQf7IRICbds+Xqkk8vLJU+BnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759480572; c=relaxed/simple;
	bh=PKc37E4toOI+coMwxopVyqNk25skEmj4ksL4V0/afI0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PcqE6Z1z5mA/0SHwB1yHJR8WWa+7ZRIKnDFYbAbO1hqFFjKjCbS617FoqMQZ463NyvfVMXUstQKkpisP/XyFa5GWEQ4GjHGTlAlcfnYvqX7dQG4MspwcnLpQT8ZL8dnKF9YYEj8EetpVxJ9cIeotAlQ3U4jID99k0OuAe9YyXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mSj+X3hk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso12805505e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759480568; x=1760085368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSviWDocZr7eRFQ1iMDzT5Qi5FWE3ORY1UYGHnObtBk=;
        b=mSj+X3hkHQqL9nxLy8hobaLpuddY4uGLoWu2Z8d8cma35a5a79B39Z32JcJHXx61cH
         mpYyPa21aCT2/MA3qtyUr4Q+0wM5YZ9+OEDd26OXzN2UlIJe5uEmiT16kiQOLjS0w4Qh
         XcT8mO6RGQI/m6Ibca9EnCwAnMGrkVZurjQNU0LMiGtj7VO21E/QbCdWoRX95LPPYpTR
         w2rAIdPEsAl6GqSYkC0FC913LoWXpSKqJ2522ZJx8GnhDBQB5J/ZhQBBQXkmPyTkQbJx
         HiLFpKjQBqHG5hVSLEoIvdUHYpLuKWE92Vy3yRS5q8DiED35vumgcGnR/EyYU+hveFzk
         T2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759480568; x=1760085368;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSviWDocZr7eRFQ1iMDzT5Qi5FWE3ORY1UYGHnObtBk=;
        b=MNy2+yoEy7QJXaneEuY0bOjwXNkxAjCNWKOEhJRxMm/w4QiI6FMIC+hTtIyRC310IK
         5KpHkJN9Vb457XOZGDM37pin2JOkJFQTWQmHCNeJDEDRxRYiZDNoolyoXxhZ+xapG9yB
         3rkdeeRZEAyJh4yJUk0KIn1+NE2eUkyxn7R4+LmJ3cK0LeyRUon+PtJ6olvUB0vPy7ZZ
         1vv3CGXiqAmXkcE+iblWj2cAPnlBEK0RY68sRs+gOyvPuEkqzPxOAVWHKJyjWhozDKNU
         k+XASEgd3y8sM8oq4NoDVnOrBM7ON/8GZrzS9raj6wi9sXDgNBqLC8CBeLRasLTBUWZV
         Ej3A==
X-Forwarded-Encrypted: i=1; AJvYcCU0HEStfdVCk++8pmFp/0W/89PytipPjt915lKLSgFaGAoyh/b+KCq0KffNkPYXxwqMDhwCxblR/MQin9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYOP1rW1kTRWVlwzD20oiZ4C5vvdZE3Ggnf4ndIT+yy5o1WImw
	pwX5bvbgviBS33gCTEENnMrzBNS54uYs4cf0E56/EWl4NNZLhVy2G7XH38xZfIbXTKk=
X-Gm-Gg: ASbGncsm4qobGbezOApTCqlV7029BfSl+IZy7Ub1z3PufaoR2w69dxnjjOaTXxf9jt4
	fCuUDw4dBKriwOZSLJ5IC7EaFj8Iq7V/yFq45ZRuC/LgXUP2AJ2w/d76YEwa/2ozs2x4yNgcKgS
	SXmj5klLHPdvdM+liXUWmUipjuRemzzNK60i2A/eZ18HkupiLi2gEtcxITrzKYk/8xlx8pn7xkf
	6rYYbKwk/hi8ZVA8tQofRTY4IKjfJb/TO6ErAuMrBiTELGdP4QlqvUQ4gEx7lDTbfVx5Ii6L6b1
	3+D5x2iqq1ddhg9s7ei/wGDvEt0YprHRqUYAqIP93zwPKbv9/PQUJ6oLBn4IqfkRaNVCypSQM4V
	hhFSEUKtg48SoCFscZZxwkgRB1twLuXr0AsC3yP5fqwf77Jfl2WxAYPpP
X-Google-Smtp-Source: AGHT+IE76AssVOnYZ6flrpm/T7LxOGT/eMAoKYwNOlcK4L0ObcJKZqXObYnm2Ncd1mks7lx/eY9Deg==
X-Received: by 2002:a05:6000:2887:b0:3ee:126a:7aab with SMTP id ffacd0b85a97d-425671c3abemr1117681f8f.57.1759480567855;
        Fri, 03 Oct 2025 01:36:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8abf0bsm6826213f8f.17.2025.10.03.01.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:36:07 -0700 (PDT)
Date: Fri, 3 Oct 2025 11:36:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, lee@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v7 6/9] regulator: Add support for MediaTek MT6373 SPMI
 PMIC Regulators
Message-ID: <202510030902.aQS5rL8n-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002090028.1796462-7-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-regulator-Document-MediaTek-MT6316-PMIC-Regulators/20251002-170532
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20251002090028.1796462-7-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v7 6/9] regulator: Add support for MediaTek MT6373 SPMI PMIC Regulators
config: arm-randconfig-r071-20251003 (https://download.01.org/0day-ci/archive/20251003/202510030902.aQS5rL8n-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510030902.aQS5rL8n-lkp@intel.com/

smatch warnings:
drivers/regulator/mt6373-regulator.c:664 mt6373_regulator_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +664 drivers/regulator/mt6373-regulator.c

910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  645  static int mt6373_regulator_probe(struct platform_device *pdev)
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  646  {
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  647  	struct irq_fwspec fwspec = {
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  648  		.param_count = 2,
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  649  		.param = { 0, IRQ_TYPE_LEVEL_HIGH },
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  650  	};
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  651  	struct device_node *interrupt_parent;
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  652  	struct regulator_config config = {};
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  653  	struct mt6373_regulator_info *info;
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  654  	struct device *dev = &pdev->dev;
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  655  	struct regulator_dev *rdev;
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  656  	struct irq_domain *domain;
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  657  	bool is_vbuck4_hw_ctrl;
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  658  	bool is_cw_variant;
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  659  	int i, ret;
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  660  	u32 val;
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  661  
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  662  	config.regmap = mt6373_spmi_register_regmap(dev);
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  663  	if (!config.regmap)

This should be if (IS_ERR(config.regmap)) ...

910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02 @664  		return dev_err_probe(dev, PTR_ERR(config.regmap)i,
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  665  				     "Cannot get regmap\n");
910ce1c7c9122a AngeloGioacchino Del Regno 2025-10-02  666  	config.dev = dev;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


