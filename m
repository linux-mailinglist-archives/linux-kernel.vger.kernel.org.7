Return-Path: <linux-kernel+bounces-875411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE902C18F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EB67562FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BB9330D20;
	Wed, 29 Oct 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrWxaBmB"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2D3148D0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725213; cv=none; b=LM42GT6E1VW9lvpXk/EYmZdwCCCsQQPLWhSOtbcA5dr+AiLgXdhh3JnbnrHyAnvdZypmfvlWzcxtuP91mxWv/cD4PT5L7J8DErea0PIeB2TpFn8OMTSZPiPyyPyP4+4h3yswOZymWx4mM66CjuIBWdeqB22MZMymIsbwQWVaKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725213; c=relaxed/simple;
	bh=g4k7E+V4jiEw+k7u7xcW7HqbefUtH0LfysZxURvNgF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AFvLwafaHY0tVmEaWsQFBoHlDDoSDkRNOwPR1q/0cTO5f+gKTP1gU+mbpy5T4B6Lvm7BVYIQoa3wc0WqvdjTPmbhSikZ/4D9want+10wy1djbUESbBHhO/z5nuNY8JniY4EqMaqs611vnr701eWxm3hOkhuIO56b4aLPH4BpvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PrWxaBmB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47117f92e32so63257925e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761725210; x=1762330010; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/U2hfMcjV9nJGndGjnLzRpawxN69YuqF2yw05LYjj+A=;
        b=PrWxaBmB3n6Uw4yA5U2JcjEosZGdpKxVdEtdxRfE1jNixhCWDvMMm2oIrgXL2w1knO
         wO6M1+VxiOFFc47itTeP2tkckl7fSWJbLuuoypIdCPGUkHoVRZiL8VFX4OrYmx8HvLys
         vQqo1VnC2PXwIROlgwA2/6JryjvnfhBEwgJEsMSeAK3PExsms4L3HXujeR9FO4Ix/t55
         vrNV9q5CcxEtwBtS1/uM5zguFc74oj6sPaiiyjGoH8nuP7zdl4MTtDciUEk6myjGeH2w
         gVFIq5ND4gw2Gpp3w7nZ3NS+NHxKxFhkyqSBBoqHg9BiU1ZsSLpczFuegT3b71I89E+O
         PP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725210; x=1762330010;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/U2hfMcjV9nJGndGjnLzRpawxN69YuqF2yw05LYjj+A=;
        b=VaCtuHnzQ5dZJkOwe8i/aK7Olr0AkRgWqIho5Ng3iNc3SY7GJAtM5h3dx7fIN+6pMs
         lupkKYQPvmK4j7O8OmxScZkIStMXuXj0szaYNVxh6If3Nn2sz4N5OcYd9IhOf2k70n+C
         RTzRb+YCY6tcdnqY98wHRYHma9qdowHi4KxRS+n67/758aqFYcgtZ2mOGHYTi3+HW0wz
         cIu1LKC40hdu1f8ywLwEB+zinFAF3n4oh0k6BkeG4OrNVm9rPrXCMRmWXfUC48BfhZ3q
         GXKdH+qxLDKtMX40J1KPwYelYvtlqUWe901QPUpjcIfTJPsCe281cwlxPOvVEhELKM9X
         VSSw==
X-Forwarded-Encrypted: i=1; AJvYcCUZyxk/kwAHwHWzZAD5hphuYTU6u09u8VMlXtirHq3S0qqd81IyHLLqEm8vePvZfO1j4v+WQQixSpYrmG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpu7L2uHoqr2U3sbLxcRm3dXX4N4XiNZmCeTxj7E9lW9uJfL61
	GsIbUPw4/b4HNVkbccfIVISG0Ab4jjnkoAxuJZGI99u+Mh1L4Aqw8TVn8jEM90VH2VHwo7BXBVl
	xCU+g
X-Gm-Gg: ASbGnctq0GmVY6X2Qvv/R1Vj9FlpK1YBvoabTJttVGfrLQ4uXmtKNSuEATzvBLDM0yW
	4OvAbkGzWdH4eRWS2xcdpuXS/izvs59e3VWqQg83MqWuTiNdtQTOH797rPnZQ9IiJsad0dMjAi8
	LYEmmDoOGhsA+wjPPiFbpY8Ytrnw4dsNa/WWHJ4AavvT0dnyVsdSgIK2eiVUnFYNQLafiXohFwr
	taULUJ0dSUHb4y1lRq/mK1TmDkPKWSdR8TVBnGyyhEBw6VJ4MJ7Kr0yrDEjP+xmss1oguwY5lv5
	x090Q2AaF140uSwDycY8ke9etQiF3yyYa5VnMWxU9/i7FTYD6/cpG68PcSrkg1RwJr7bO92aDWr
	uuWwOVOSykMk0tTmzheyYUmvZMUsAdDOfTBjW680llB2ygB7lgtLs8p737nka30qBDURJ0e34TI
	S7bYQ7ITMkzeAoiqL/ZXrF2fDgbT4=
X-Google-Smtp-Source: AGHT+IFgNUQ4crpN+QHSB0hxcM/8JVshSVJCNnrfYqxRW/4TkIjQ5SJTOS1BT/mreoy5qhKaiaWMNA==
X-Received: by 2002:a05:6000:2c03:b0:427:53e:ab25 with SMTP id ffacd0b85a97d-429aefca402mr1395557f8f.49.1761725209704;
        Wed, 29 Oct 2025 01:06:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952b7b43sm25201579f8f.6.2025.10.29.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:06:49 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:06:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Niranjan H Y <niranjan.hy@ti.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: sound/soc/codecs/tas2783-sdw.c:814 tas2783_fw_ready() error:
 uninitialized symbol 'ret'.
Message-ID: <202510291226.2R3fbYNh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8eefed8f65cc17c31fdf4ab32292b794b34893ad
commit: 4cc9bd8d7b32d59b86cb489a96aa8a7b9dd6a21b ASoc: tas2783A: Add soundwire based codec driver
config: arm64-randconfig-r073-20251029 (https://download.01.org/0day-ci/archive/20251029/202510291226.2R3fbYNh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510291226.2R3fbYNh-lkp@intel.com/

New smatch warnings:
sound/soc/codecs/tas2783-sdw.c:814 tas2783_fw_ready() error: uninitialized symbol 'ret'.

vim +/ret +814 sound/soc/codecs/tas2783-sdw.c

4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  748  static void tas2783_fw_ready(const struct firmware *fmw, void *context)
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  749  {
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  750  	struct tas2783_prv *tas_dev =
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  751  		(struct tas2783_prv *)context;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  752  	const u8 *buf = NULL;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  753  	s32 offset = 0, img_sz, file_blk_size, ret;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  754  	struct bin_header_t hdr;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  755  
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  756  	if (!fmw || !fmw->data) {
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  757  		/* No firmware binary, devices will work in ROM mode. */
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  758  		dev_err(tas_dev->dev,
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  759  			"Failed to read %s, no side-effect on driver running\n",
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  760  			tas_dev->rca_binaryname);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  761  		ret = -EINVAL;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  762  		goto out;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  763  	}
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  764  
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  765  	mutex_lock(&tas_dev->pde_lock);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  766  	img_sz = fmw->size;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  767  	buf = fmw->data;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  768  	offset += FW_DL_OFFSET;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  769  	while (offset < (img_sz - FW_FL_HDR)) {

If the firmware is too small the "ret" value might be uninitialized.

4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  770  		memset(&hdr, 0, sizeof(hdr));
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  771  		offset += read_header(&buf[offset], &hdr);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  772  		dev_dbg(tas_dev->dev,
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  773  			"vndr=%d, file=%d, version=%d, len=%d, off=%d\n",
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  774  			hdr.vendor_id, hdr.file_id, hdr.version,
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  775  			hdr.length, offset);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  776  		/* size also includes the header */
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  777  		file_blk_size = hdr.length - FW_FL_HDR;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  778  
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  779  		switch (hdr.file_id) {
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  780  		case 0:
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  781  			ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  782  					       PRAM_ADDR_START, file_blk_size,
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  783  					       &buf[offset]);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  784  			if (ret < 0)
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  785  				dev_err(tas_dev->dev,
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  786  					"PRAM update failed: %d", ret);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  787  			break;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  788  
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  789  		case 1:
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  790  			ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  791  					       YRAM_ADDR_START, file_blk_size,
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  792  					       &buf[offset]);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  793  			if (ret < 0)
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  794  				dev_err(tas_dev->dev,
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  795  					"YRAM update failed: %d", ret);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  796  
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  797  			break;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  798  
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  799  		default:
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  800  			ret = -EINVAL;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  801  			dev_err(tas_dev->dev, "Unsupported file");
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  802  			break;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  803  		}
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  804  
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  805  		if (ret == 0)
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  806  			offset += file_blk_size;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  807  		else
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  808  			break;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  809  	};
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  810  	mutex_unlock(&tas_dev->pde_lock);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  811  	tas2783_update_calibdata(tas_dev);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  812  
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  813  out:
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12 @814  	if (!ret)
                                                    ^^^^
Here.

4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  815  		tas_dev->fw_dl_success = true;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  816  	tas_dev->fw_dl_task_done = true;
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  817  	wake_up(&tas_dev->fw_wait);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  818  	if (fmw)
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  819  		release_firmware(fmw);
4cc9bd8d7b32d5 Niranjan H Y 2025-09-12  820  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


