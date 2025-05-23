Return-Path: <linux-kernel+bounces-660663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98038AC208F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B491E1C065F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A5229B05;
	Fri, 23 May 2025 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzAog4qi"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA152288C6
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994597; cv=none; b=iuZ30Vwu9SVKK1bgRCn/n1XYi5HKPptsuzPMoEbhVj0LpitLtutwI4M/GpvW80tUfS5TLdiikvR//UuS0chHDgZIfwnkY05bt8Nj2n/xOa4DfyZD/aGKOaOxF7VvOaUbyXD45+iiwoU6ZMdfCo2v5aNpEy7bbi8DjNamUSLGomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994597; c=relaxed/simple;
	bh=ujiOe3bOmZs9X41VUnMNWR4wflTRGuLIY5D/eQTzs5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k+IfSqfeJN4AaQdIXOIARzxHjhrIYqBNsXYgnJ7zksvWtXkuY4vlUKKf4/ykfpFCE42UthwPhcGAQyaKNb0IR747ATQuCDKbMWnde6NpO8/7sCmVb+cZXKUFFVTUmcsi3CYTYBFIwNYmznClZxFVmVAPiTY9MZwTySMpi7xvL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PzAog4qi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a36e0d22c1so3944296f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747994593; x=1748599393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/Gce1NColnWtg6ZWbw4/vDJFXeyJ5MZqm0V5eF1bt4=;
        b=PzAog4qi9mZtaoe/Za3f6YMnKqFHBp9IsGnnv37+efBn5w3dl2zdiHF6J/OCk9Pa2i
         fESEG4maqZlQqqUbjyhn7q3WWHPA8ZlYkL1FZde/6UWJ/Rh3Kc+abn+DFBl8Lx9jkdR5
         DeV5JkKVoKMFmR3hGCEeyYfvn1LYk+pgZEt/eg1RukVzl92Q5F2HtzS5yYAWe7mxnceX
         N42C6aXtitL7CAU4zCGfg0ohuOPS3mEvnjR1JTQO32XMlFUaYwDfar6k1KSUbWndUGvf
         gdFHeN0XiE4hIAaSJNuQbz74VAIId9uBI8lu/ICKeyx/5OPqFXXs362gqMSIJoBqkuMs
         ppgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747994593; x=1748599393;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/Gce1NColnWtg6ZWbw4/vDJFXeyJ5MZqm0V5eF1bt4=;
        b=l0f2RVJ/Fnu8Cg426o3++on+PkWu9M37XOfBahCwATrI4k6lXQpbCXABtbTyOoY+Ki
         6Bg4bFYRjDSbgwpuOQHHMKGnOQ1bibe7HPeNrRqtuq1ZfAD9URaPu2UYjPNnXlrCPJOd
         xUHxfoPOjpPDtfJmeeXPbWO7s5DDyqGj/kzamP25TNHcRI8ESgnVVi6N/ruhxvHjMUDT
         /GEprFwPvMitw3I7pyyeqR+ZxLk8x4jmNBEq61I5pfhI0sgLJpvXX1nFzJXItWiZV6Z9
         +2DYKrLJYLLgqQlSIkp8kdfyoJZEelIa/7jccCgRaanR7zvnWH/3LPGRs9r1QXv6TgKd
         YnRw==
X-Forwarded-Encrypted: i=1; AJvYcCUeI0uZtcC13rn5KNTFR5qFEVjPFXqT4JoPs1kPbymGUOfTiUKiPOl52oONk8odjEHO40wgBdum6We3Mbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMkdjArFEkUag1RXMkO/lR7CN6s77h6pjKXkV/eKLNQAKm0LxC
	yLIT1Ja3Cvmoq4nDaxXLZkc14TOeNc5zvU1uswAje998mOrnrV4zBLANihzlqDfpecw=
X-Gm-Gg: ASbGncvShymzAfeRZrtet+fofGn1Din0bR9TB+TaJzMTwnQH5ldjMUKZkEDWBgueOBg
	U2t1DQrT2eVmeTjAMxMZiSFcqIYr9hJMRQ4s2NsolwDfAXg0fVOTW4UEoTiLZ5TKvY7nYBPQhSF
	NvSyTa3ngnCYnKXfW9G8UZTIGL4kswLEmTuuWsy24judCOgeuN8EVI6LYcCZMONlxEnIhEDRlVA
	Lqd08FKuVU/01oskckzgx0cHP8OIq9GzSkogZaQHEKQdahjt2Uxs6bS1kimVDe67RLStol1LExx
	3EeXc9NLrStArq+S3TJ8Bj6ov0RoE6N/vdWOWPRN1OsfkjH4PLBAtPPH6+v4GN4MbtI=
X-Google-Smtp-Source: AGHT+IGXYYf0TFhQ1O+wON7w7Ui0TdCCwX28S/0fiqjwsGck85D7SHKGiXnA9KbBhPMZpeej6AwM4w==
X-Received: by 2002:a05:6000:2008:b0:3a4:79e8:cdfc with SMTP id ffacd0b85a97d-3a479e8cf38mr9971757f8f.30.1747994593532;
        Fri, 23 May 2025 03:03:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca8894csm26040832f8f.76.2025.05.23.03.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:03:13 -0700 (PDT)
Date: Fri, 23 May 2025 13:03:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Dawei Li <dawei.li@linux.dev>,
	andersson@kernel.org, mathieu.poirier@linaro.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dawei.li@linux.dev, set_pte_at@outlook.com
Subject: Re: [PATCH v3 3/3] rpmsg: ctrl: Introduce RPMSG_CREATE_EPT_FD_IOCTL
 uAPI
Message-ID: <202505211038.sqqVX8kO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519150823.62350-4-dawei.li@linux.dev>

Hi Dawei,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Dawei-Li/rpmsg-char-Reuse-eptdev-logic-for-anonymous-device/20250519-231006
base:   92a09c47464d040866cf2b4cd052bc60555185fb
patch link:    https://lore.kernel.org/r/20250519150823.62350-4-dawei.li%40linux.dev
patch subject: [PATCH v3 3/3] rpmsg: ctrl: Introduce RPMSG_CREATE_EPT_FD_IOCTL uAPI
config: powerpc64-randconfig-r072-20250521 (https://download.01.org/0day-ci/archive/20250521/202505211038.sqqVX8kO-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505211038.sqqVX8kO-lkp@intel.com/

smatch warnings:
drivers/rpmsg/rpmsg_ctrl.c:140 rpmsg_ctrldev_ioctl() warn: maybe return -EFAULT instead of the bytes remaining?

vim +140 drivers/rpmsg/rpmsg_ctrl.c

617d32938d1be0 Arnaud Pouliquen 2022-01-24   74  static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
617d32938d1be0 Arnaud Pouliquen 2022-01-24   75  				unsigned long arg)
617d32938d1be0 Arnaud Pouliquen 2022-01-24   76  {
617d32938d1be0 Arnaud Pouliquen 2022-01-24   77  	struct rpmsg_ctrldev *ctrldev = fp->private_data;
74317ea5240801 Dawei Li         2025-05-19   78  	struct rpmsg_endpoint_fd_info ept_fd_info;
617d32938d1be0 Arnaud Pouliquen 2022-01-24   79  	void __user *argp = (void __user *)arg;
617d32938d1be0 Arnaud Pouliquen 2022-01-24   80  	struct rpmsg_endpoint_info eptinfo;
617d32938d1be0 Arnaud Pouliquen 2022-01-24   81  	struct rpmsg_channel_info chinfo;
8109517b394e6d Arnaud Pouliquen 2022-01-24   82  	struct rpmsg_device *rpdev;
8109517b394e6d Arnaud Pouliquen 2022-01-24   83  	int ret = 0;
74317ea5240801 Dawei Li         2025-05-19   84  	int fd = -1;
617d32938d1be0 Arnaud Pouliquen 2022-01-24   85  
74317ea5240801 Dawei Li         2025-05-19   86  	if (cmd == RPMSG_CREATE_EPT_IOCTL || cmd == RPMSG_CREATE_DEV_IOCTL ||
74317ea5240801 Dawei Li         2025-05-19   87  	    cmd == RPMSG_RELEASE_DEV_IOCTL) {
617d32938d1be0 Arnaud Pouliquen 2022-01-24   88  		if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
617d32938d1be0 Arnaud Pouliquen 2022-01-24   89  			return -EFAULT;
617d32938d1be0 Arnaud Pouliquen 2022-01-24   90  
617d32938d1be0 Arnaud Pouliquen 2022-01-24   91  		memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
617d32938d1be0 Arnaud Pouliquen 2022-01-24   92  		chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
617d32938d1be0 Arnaud Pouliquen 2022-01-24   93  		chinfo.src = eptinfo.src;
617d32938d1be0 Arnaud Pouliquen 2022-01-24   94  		chinfo.dst = eptinfo.dst;
74317ea5240801 Dawei Li         2025-05-19   95  	} else if (cmd == RPMSG_CREATE_EPT_FD_IOCTL) {
74317ea5240801 Dawei Li         2025-05-19   96  		if (copy_from_user(&ept_fd_info, argp, sizeof(ept_fd_info)))
74317ea5240801 Dawei Li         2025-05-19   97  			return -EFAULT;
74317ea5240801 Dawei Li         2025-05-19   98  
74317ea5240801 Dawei Li         2025-05-19   99  		memcpy(chinfo.name, ept_fd_info.name, RPMSG_NAME_SIZE);
74317ea5240801 Dawei Li         2025-05-19  100  		chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
74317ea5240801 Dawei Li         2025-05-19  101  		chinfo.src = ept_fd_info.src;
74317ea5240801 Dawei Li         2025-05-19  102  		chinfo.dst = ept_fd_info.dst;
74317ea5240801 Dawei Li         2025-05-19  103  	}
617d32938d1be0 Arnaud Pouliquen 2022-01-24  104  
8109517b394e6d Arnaud Pouliquen 2022-01-24  105  	mutex_lock(&ctrldev->ctrl_lock);
8109517b394e6d Arnaud Pouliquen 2022-01-24  106  	switch (cmd) {
8109517b394e6d Arnaud Pouliquen 2022-01-24  107  	case RPMSG_CREATE_EPT_IOCTL:
8109517b394e6d Arnaud Pouliquen 2022-01-24  108  		ret = rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
8109517b394e6d Arnaud Pouliquen 2022-01-24  109  		break;
8109517b394e6d Arnaud Pouliquen 2022-01-24  110  
8109517b394e6d Arnaud Pouliquen 2022-01-24  111  	case RPMSG_CREATE_DEV_IOCTL:
8109517b394e6d Arnaud Pouliquen 2022-01-24  112  		rpdev = rpmsg_create_channel(ctrldev->rpdev, &chinfo);
8109517b394e6d Arnaud Pouliquen 2022-01-24  113  		if (!rpdev) {
8109517b394e6d Arnaud Pouliquen 2022-01-24  114  			dev_err(&ctrldev->dev, "failed to create %s channel\n", chinfo.name);
8109517b394e6d Arnaud Pouliquen 2022-01-24  115  			ret = -ENXIO;
8109517b394e6d Arnaud Pouliquen 2022-01-24  116  		}
8109517b394e6d Arnaud Pouliquen 2022-01-24  117  		break;
8109517b394e6d Arnaud Pouliquen 2022-01-24  118  
8109517b394e6d Arnaud Pouliquen 2022-01-24  119  	case RPMSG_RELEASE_DEV_IOCTL:
8109517b394e6d Arnaud Pouliquen 2022-01-24  120  		ret = rpmsg_release_channel(ctrldev->rpdev, &chinfo);
8109517b394e6d Arnaud Pouliquen 2022-01-24  121  		if (ret)
8109517b394e6d Arnaud Pouliquen 2022-01-24  122  			dev_err(&ctrldev->dev, "failed to release %s channel (%d)\n",
8109517b394e6d Arnaud Pouliquen 2022-01-24  123  				chinfo.name, ret);
8109517b394e6d Arnaud Pouliquen 2022-01-24  124  		break;
8109517b394e6d Arnaud Pouliquen 2022-01-24  125  
74317ea5240801 Dawei Li         2025-05-19  126  	case RPMSG_CREATE_EPT_FD_IOCTL:
74317ea5240801 Dawei Li         2025-05-19  127  		ret = rpmsg_anonymous_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo,
74317ea5240801 Dawei Li         2025-05-19  128  						    ept_fd_info.flags, &fd);
74317ea5240801 Dawei Li         2025-05-19  129  		if (!ret) {

You should flip this around.  if (ret)
					break;

74317ea5240801 Dawei Li         2025-05-19  130  			ept_fd_info.fd = fd;
74317ea5240801 Dawei Li         2025-05-19  131  			ret = copy_to_user(argp, &ept_fd_info, sizeof(ept_fd_info));

This should be:

	if (copy_to_user(argp, &ept_fd_info, sizeof(ept_fd_info)))
		ret = -EFAULT;


74317ea5240801 Dawei Li         2025-05-19  132  		}
74317ea5240801 Dawei Li         2025-05-19  133  		break;
74317ea5240801 Dawei Li         2025-05-19  134  
8109517b394e6d Arnaud Pouliquen 2022-01-24  135  	default:
8109517b394e6d Arnaud Pouliquen 2022-01-24  136  		ret = -EINVAL;
8109517b394e6d Arnaud Pouliquen 2022-01-24  137  	}
8109517b394e6d Arnaud Pouliquen 2022-01-24  138  	mutex_unlock(&ctrldev->ctrl_lock);
8109517b394e6d Arnaud Pouliquen 2022-01-24  139  
8109517b394e6d Arnaud Pouliquen 2022-01-24 @140  	return ret;
617d32938d1be0 Arnaud Pouliquen 2022-01-24  141  };

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


