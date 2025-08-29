Return-Path: <linux-kernel+bounces-791596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3142B3B8F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A096582547
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59C330ACFA;
	Fri, 29 Aug 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVI39CEJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352FA3093D2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756463499; cv=none; b=RJ0BumsyRHZq3VrBOrDKD7gbV1t9lsrbmWxmlWrnmz+ZVlM96+ZP2XajLCS5I2JVxKKH0JRbgMoNI/OvSUSkK7ZbyODj/9tQtu23P+CyimpqBJZtGurgjTG3loKvQXeC90gFlV97X1GUuzjH1mpAnLj/JoVMcuMZKOiIa7QveYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756463499; c=relaxed/simple;
	bh=rqjKaGnzMwGex2cVb1RmKu1TRj31agUAhMc+ewACMxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqN8BeIyC7Q5JnxSHCJFTJJlGOLYvLpIZLK15y+U3xbOMNH/iCwIq0ZVZiVfxty+g7rBh8v7qlARJrcIXe46ELcMT+pyzk6AxP5mV0uF+lWLwaYuLIYYMz9XwBUQQaPH2mkMkngVDtvEOhoIdVnYe78eE1S2k3eLFR+7gFRQuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVI39CEJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756463496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOn3KXAKXg6FOxpANWl4YcPVu6tqit8Beeg42jZjH/4=;
	b=eVI39CEJnljbNm2ZDpd2G4Cw8HdQmv4+PXGfK4dUyxBT7NybPnuQa3+dF6drG5oZPXEi/R
	umz3OjFJbiVpUdS5aTi3FYXyfHz7B1iMfw+qzz7D2hnMfo0VDFcDCk0MhZzyTdy/2SLhEH
	8UnrFSdI/PvPsvae/gPKrWW4u692Q2o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-sjlrL8IPMr-Xv3qOA09STA-1; Fri,
 29 Aug 2025 06:31:32 -0400
X-MC-Unique: sjlrL8IPMr-Xv3qOA09STA-1
X-Mimecast-MFC-AGG-ID: sjlrL8IPMr-Xv3qOA09STA_1756463491
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BFA7180035B;
	Fri, 29 Aug 2025 10:31:21 +0000 (UTC)
Received: from [10.45.224.190] (unknown [10.45.224.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2A021800952;
	Fri, 29 Aug 2025 10:31:13 +0000 (UTC)
Message-ID: <9294ad59-ac08-4666-9936-23b4e1d40c82@redhat.com>
Date: Fri, 29 Aug 2025 12:31:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] dpll: zl3073x: Add firmware loading
 functionality
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <202508200929.zEY4ejFt-lkp@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <202508200929.zEY4ejFt-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 20. 08. 25 8:40 dop., Dan Carpenter wrote:
> Hi Ivan,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-zl3073x-Add-functions-to-access-hardware-registers/20250814-014831
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250813174408.1146717-4-ivecera%40redhat.com
> patch subject: [PATCH net-next v3 3/5] dpll: zl3073x: Add firmware loading functionality
> config: xtensa-randconfig-r073-20250819 (https://download.01.org/0day-ci/archive/20250820/202508200929.zEY4ejFt-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 9.5.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202508200929.zEY4ejFt-lkp@intel.com/
> 
> smatch warnings:
> drivers/dpll/zl3073x/fw.c:239 zl3073x_fw_component_load() warn: potential user controlled sizeof overflow 'count * 4' '0-u32max * 4'
> 
> vim +239 drivers/dpll/zl3073x/fw.c
> 
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  202  static ssize_t
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  203  zl3073x_fw_component_load(struct zl3073x_dev *zldev,
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  204  			  struct zl3073x_fw_component **pcomp,
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  205  			  const char **psrc, size_t *psize,
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  206  			  struct netlink_ext_ack *extack)
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  207  {
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  208  	const struct zl3073x_fw_component_info *info;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  209  	struct zl3073x_fw_component *comp = NULL;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  210  	struct device *dev = zldev->dev;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  211  	enum zl3073x_fw_component_id id;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  212  	char buf[32], name[16];
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  213  	u32 count, size, *dest;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  214  	int pos, rc;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  215
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  216  	/* Fetch image name and size from input */
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  217  	strscpy(buf, *psrc, min(sizeof(buf), *psize));
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  218  	rc = sscanf(buf, "%15s %u %n", name, &count, &pos);
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  219  	if (!rc) {
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  220  		/* No more data */
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  221  		return 0;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  222  	} else if (rc == 1) {
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  223  		ZL3073X_FW_ERR_MSG(zldev, extack, "invalid component size");
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  224  		return -EINVAL;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  225  	}
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  226  	*psrc += pos;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  227  	*psize -= pos;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  228
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  229  	dev_dbg(dev, "Firmware component '%s' found\n", name);
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  230
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  231  	id = zl3073x_fw_component_id_get(name);
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  232  	if (id == ZL_FW_COMPONENT_INVALID) {
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  233  		ZL3073X_FW_ERR_MSG(zldev, extack, "unknown component type '%s'",
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  234  				   name);
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  235  		return -EINVAL;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  236  	}
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  237
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  238  	info = &component_info[id];
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13 @239  	size = count * sizeof(u32); /* get size in bytes */
> 
> This is an integer overflow.  Imagine count is 0x80000001.  That means
> size is 4.

Will fix this in the next version.

Thanks,
Ivan

> 
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  240
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  241  	/* Check image size validity */
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  242  	if (size > component_info[id].max_size) {
> 
> size is valid.
> 
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  243  		ZL3073X_FW_ERR_MSG(zldev, extack,
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  244  				   "[%s] component is too big (%u bytes)\n",
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  245  				   info->name, size);
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  246  		return -EINVAL;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  247  	}
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  248
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  249  	dev_dbg(dev, "Indicated component image size: %u bytes\n", size);
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  250
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  251  	/* Alloc component */
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  252  	comp = zl3073x_fw_component_alloc(size);
> 
> The allocation succeeds.
> 
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  253  	if (!comp) {
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  254  		ZL3073X_FW_ERR_MSG(zldev, extack, "failed to alloc memory");
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  255  		return -ENOMEM;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  256  	}
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  257  	comp->id = id;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  258
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  259  	/* Load component data from firmware source */
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  260  	for (dest = comp->data; count; count--, dest++) {
> 
> But count is invalid so so we will loop 134 million times.
> 
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  261  		strscpy(buf, *psrc, min(sizeof(buf), *psize));
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  262  		rc = sscanf(buf, "%x %n", dest, &pos);
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  263  		if (!rc)
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  264  			goto err_data;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  265
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  266  		*psrc += pos;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  267  		*psize -= pos;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  268  	}
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  269
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  270  	*pcomp = comp;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  271
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  272  	return 1;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  273
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  274  err_data:
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  275  	ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] invalid or missing data",
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  276  			   info->name);
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  277
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  278  	zl3073x_fw_component_free(comp);
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  279
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  280  	return -ENODATA;
> cd5cfd9ddd76800 Ivan Vecera 2025-08-13  281  }
> 


