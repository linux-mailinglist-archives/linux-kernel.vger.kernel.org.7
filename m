Return-Path: <linux-kernel+bounces-777020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65DB2D428
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735901C428DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC832C21E7;
	Wed, 20 Aug 2025 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q22XpNY/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581228466F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672031; cv=none; b=KaowqkjV1Ejpdwl39cnlS7G+gQk2b4j4k8Mz+jy1bf8C1JDhtfPnRbdI3BvExGm+haD3BAbaDkSFuuvgZ4K1eIYdNxFgalksQF/D9LNzj/7Xb1dPPUXdFXV8r623fWn/G9Xmmvsgx1MDKni1/S9tnINOPxJ4mVuCBTijZ+svplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672031; c=relaxed/simple;
	bh=GbYe/xr2KnaQN5qvGP3TKUQEzBohUBz2Hp6+TW9NVTs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EPg9GOgTipMWcBDPUtzMbV4cDpMr6G1ETq7vPpanOeyv+dB0wfaTZiF78UbDoQzpASyEW0hXt7WWlfX8Lze73nqaAJ1rQIdssJbHdOBTnACVDZpy/TJgdd6CaPjoADNkKA4z9iO4igNOn+oyn4ApFGKSSYYlnZKnYDZVykzN/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q22XpNY/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9edf0e4efso4016533f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755672028; x=1756276828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr7gbAs7NoWP6YIoHdlAkJ/lGPbRe6fvpSA2+GwU+Bk=;
        b=Q22XpNY/v4WFsPyqp0vCrx632aCx9GiFhSZFmFXYgc8ma4wzl8wFQ4JvJtN3X9v46d
         wzLIM2Nqs7DHNodo4wNLpCeEHEe05JD5aR4GgNqSBRwMwziXg1206Qu7ue9VKrN2gX33
         nurZdykczuJiKzfoKiplRhPlgpfynI4TAuRq6/eJTQaIm36/NzFHYaN7YyoaPjSGr3BR
         75MqsCZtD7WtupCNuvecj0/YzkgoJ/cZELggY3ITevnn4FYgFedElAX4MSlv609oVdcF
         4iv4RkD3TyyAKPAFJFF/xzyscNXgN6VvhvGKJ5T6f4yXb8WFQvZoTd9kt/Eb2xLu5Ivl
         ePAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672028; x=1756276828;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xr7gbAs7NoWP6YIoHdlAkJ/lGPbRe6fvpSA2+GwU+Bk=;
        b=cul5nBkfYbVDawP+L+JihPaEyc3WCcbvOUYYv3EZbXIEGVxpKJ1AgAx2IOTMQhOMY9
         D+33fFM/rio5zWX9GBIIs91QfNwIXJHq05bRX8BJmDd1mcUzWEM8DwtUTIRZs4lOLcAU
         XD57Vg0QK+7pVPUnIvEUyhnUVaiedbphsaEqj7/lCapYlyDy0WBWfpwpJClduDOzLnNg
         3Hg59qX/Brnpqt8GYK/CzGOid0EsH+qlxlslBGINXQya9L7WrdGE+RR0pMwm4G8anvb7
         P/ileC/27EsLFkGfqfQZia1fPlEbqf6VOfp1G1b2MIOzdS5C6UqBFaGo/C7dD8h3bzh0
         iN/A==
X-Forwarded-Encrypted: i=1; AJvYcCU+cl8xhYgFMnzaeSkLNlK97ASxh7lZ/NWNVP7kqN6IMlhrbrp7rhThEr5W+XELnOni4u0rt/LfPnzuTWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNC7j8KU5CWCHB9G+Wnc19eImHl878j0qKX5JRo161XUR6I0Vv
	08nrDNQv8oOjkx2g77cF5IZ//scj5QoHTE7qbpbF1VGu7TEzQGMSdNIEBZhLybHfbF4=
X-Gm-Gg: ASbGncvW70i59P0/mWvhyitPXVR14w9EbP5alvyCu6msPQ/Ikx8xw7kJYa/YMK6q28J
	09Pmi8x7idwso4RfqGm5kAookfFAFjgM55ro+uugHM+tiUReQD4E8YjjIHxv8bnnx1Rvj3P4EQI
	H6tUOYAV78coE7mBILMFj1KyrtVeRRcP5CB5Vqh8pqj3ScE7FF3Wt8cX0jeA/07Kc0mPDPHHYiV
	JQJ2mOa+T2iCL+z7q6m1Xtktsb5gvLIuY3i4sA/pPpnVuZ0ZQ1Hy9lw1R7aAnisaBOY4rAIoxVt
	O7UZHzs8UiScX/e6xArSHIqa2bUHOOBlFTfTKrwtygMYbwEVc1p3i0KtkXlpXJInuqfs85D6qVX
	/FC25cpT05FDdVplcW/vsiDI6zyk=
X-Google-Smtp-Source: AGHT+IGAZ6McYMCx54eY6pWpoKew3ITg2+wTSl/nURpfg3Nb30p1pBzhgzsuHH+BOzekuGd6+2v13A==
X-Received: by 2002:a05:6000:188f:b0:3b8:f358:e80d with SMTP id ffacd0b85a97d-3c32c4345d2mr1070252f8f.5.1755672027829;
        Tue, 19 Aug 2025 23:40:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b47c2865dsm17711515e9.2.2025.08.19.23.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 23:40:27 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:40:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ivan Vecera <ivecera@redhat.com>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v3 3/5] dpll: zl3073x: Add firmware loading
 functionality
Message-ID: <202508200929.zEY4ejFt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813174408.1146717-4-ivecera@redhat.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-zl3073x-Add-functions-to-access-hardware-registers/20250814-014831
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250813174408.1146717-4-ivecera%40redhat.com
patch subject: [PATCH net-next v3 3/5] dpll: zl3073x: Add firmware loading functionality
config: xtensa-randconfig-r073-20250819 (https://download.01.org/0day-ci/archive/20250820/202508200929.zEY4ejFt-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 9.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508200929.zEY4ejFt-lkp@intel.com/

smatch warnings:
drivers/dpll/zl3073x/fw.c:239 zl3073x_fw_component_load() warn: potential user controlled sizeof overflow 'count * 4' '0-u32max * 4'

vim +239 drivers/dpll/zl3073x/fw.c

cd5cfd9ddd76800 Ivan Vecera 2025-08-13  202  static ssize_t
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  203  zl3073x_fw_component_load(struct zl3073x_dev *zldev,
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  204  			  struct zl3073x_fw_component **pcomp,
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  205  			  const char **psrc, size_t *psize,
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  206  			  struct netlink_ext_ack *extack)
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  207  {
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  208  	const struct zl3073x_fw_component_info *info;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  209  	struct zl3073x_fw_component *comp = NULL;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  210  	struct device *dev = zldev->dev;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  211  	enum zl3073x_fw_component_id id;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  212  	char buf[32], name[16];
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  213  	u32 count, size, *dest;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  214  	int pos, rc;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  215  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  216  	/* Fetch image name and size from input */
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  217  	strscpy(buf, *psrc, min(sizeof(buf), *psize));
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  218  	rc = sscanf(buf, "%15s %u %n", name, &count, &pos);
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  219  	if (!rc) {
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  220  		/* No more data */
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  221  		return 0;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  222  	} else if (rc == 1) {
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  223  		ZL3073X_FW_ERR_MSG(zldev, extack, "invalid component size");
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  224  		return -EINVAL;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  225  	}
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  226  	*psrc += pos;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  227  	*psize -= pos;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  228  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  229  	dev_dbg(dev, "Firmware component '%s' found\n", name);
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  230  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  231  	id = zl3073x_fw_component_id_get(name);
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  232  	if (id == ZL_FW_COMPONENT_INVALID) {
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  233  		ZL3073X_FW_ERR_MSG(zldev, extack, "unknown component type '%s'",
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  234  				   name);
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  235  		return -EINVAL;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  236  	}
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  237  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  238  	info = &component_info[id];
cd5cfd9ddd76800 Ivan Vecera 2025-08-13 @239  	size = count * sizeof(u32); /* get size in bytes */

This is an integer overflow.  Imagine count is 0x80000001.  That means
size is 4.

cd5cfd9ddd76800 Ivan Vecera 2025-08-13  240  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  241  	/* Check image size validity */
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  242  	if (size > component_info[id].max_size) {

size is valid.

cd5cfd9ddd76800 Ivan Vecera 2025-08-13  243  		ZL3073X_FW_ERR_MSG(zldev, extack,
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  244  				   "[%s] component is too big (%u bytes)\n",
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  245  				   info->name, size);
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  246  		return -EINVAL;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  247  	}
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  248  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  249  	dev_dbg(dev, "Indicated component image size: %u bytes\n", size);
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  250  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  251  	/* Alloc component */
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  252  	comp = zl3073x_fw_component_alloc(size);

The allocation succeeds.

cd5cfd9ddd76800 Ivan Vecera 2025-08-13  253  	if (!comp) {
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  254  		ZL3073X_FW_ERR_MSG(zldev, extack, "failed to alloc memory");
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  255  		return -ENOMEM;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  256  	}
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  257  	comp->id = id;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  258  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  259  	/* Load component data from firmware source */
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  260  	for (dest = comp->data; count; count--, dest++) {

But count is invalid so so we will loop 134 million times.

cd5cfd9ddd76800 Ivan Vecera 2025-08-13  261  		strscpy(buf, *psrc, min(sizeof(buf), *psize));
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  262  		rc = sscanf(buf, "%x %n", dest, &pos);
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  263  		if (!rc)
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  264  			goto err_data;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  265  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  266  		*psrc += pos;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  267  		*psize -= pos;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  268  	}
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  269  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  270  	*pcomp = comp;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  271  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  272  	return 1;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  273  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  274  err_data:
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  275  	ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] invalid or missing data",
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  276  			   info->name);
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  277  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  278  	zl3073x_fw_component_free(comp);
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  279  
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  280  	return -ENODATA;
cd5cfd9ddd76800 Ivan Vecera 2025-08-13  281  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


