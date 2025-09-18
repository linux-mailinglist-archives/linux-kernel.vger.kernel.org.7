Return-Path: <linux-kernel+bounces-767509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F0FB2556E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9478D7238B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598982FFDEA;
	Wed, 13 Aug 2025 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K51EcfuM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAE30AAAD;
	Wed, 13 Aug 2025 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120538; cv=none; b=orCfbeD7HiNnWm6EbDM0dg08Elu+KAJqidy0hSzbfLghcSIWqBGiETJXzfvHgZBeWLmbjNARSTAqYUQ0kLQwgSKIqQi4EtcGgwf2NSkiqGGjdORkIgVaB3JFpVH8qMq1BlXhlBCTp+QdWfHUVckloNIOpFxkgEU2VpUSE8VegME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120538; c=relaxed/simple;
	bh=ofdvNgNJdkJbmwEfKc1AUQhG3hnc8SN1vSgvqxoKNRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUntrrHEJNq7orgcWDB4OhgvNqyH8kTb2O2iaADpcqDtjbI/zAOrs7pNPAyStXzU1E1L2buIdJnnTxndMWi0N4HVJd80koFZ6PvqNL9oMbeZVNV2wj9GtUU3ROvDFgNcTGR1ZQ3Y9SM6CpVK0dNQte97pB9AJUz1phZJhA0pMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K51EcfuM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755120537; x=1786656537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ofdvNgNJdkJbmwEfKc1AUQhG3hnc8SN1vSgvqxoKNRM=;
  b=K51EcfuMji3G/PSi84SfLVCj0Rnb5cscrkb+ZxNIkyAnsDiZGayzKRBR
   HoBBLz6WIVAN+InJSZd3oguXkl5z5+LqxtCqPFefWBLUdSRWm7bFDJQti
   F0YCSTs2k7amUYqIzoolSUNEDyVdXxncf6T0DGmjZg61L5WmEnX8rsIwQ
   y34fff1LKN/Euf2zIiXAQqncqf3YZFtwWhEpXycmZZktqrD+EzmYou+Ks
   4Alh94fXQnaV1fPX67leRSAfoaZNmcl7swoJ5US87+tKMZhxf9G0owJxn
   Wt08Qqj0/oY5i2YwfwNEZnv1YBSIZhdsPMSg0enJ299StlNhXDz9dSPdF
   A==;
X-CSE-ConnectionGUID: ySZ/xGzaTCeqFP/+C3tgfQ==
X-CSE-MsgGUID: /kSYUB64Rwy1GoSQl1+MNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57351324"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57351324"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:28:57 -0700
X-CSE-ConnectionGUID: NnWqMrE8TtWi2BeCREw8Ug==
X-CSE-MsgGUID: tloz5Ue9QdSbrGoa8xCmwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="165807755"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2025 14:28:52 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umJ1d-000AKg-0i;
	Wed, 13 Aug 2025 21:28:49 +0000
Date: Thu, 14 Aug 2025 05:28:10 +0800
From: kernel test robot <lkp@intel.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Apurupa Pattapu <quic_apurupa@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, Harshal Dev <quic_hdev@quicinc.com>,
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-doc@vger.kernel.org,
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 08/11] tee: add Qualcomm TEE driver
Message-ID: <202508140527.ighXikjo-lkp@intel.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-8-ce7a1a774803@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-8-ce7a1a774803@oss.qualcomm.com>

Hi Amirreza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2674d1eadaa2fd3a918dfcdb6d0bb49efe8a8bb9]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-allow-a-driver-to-allocate-a-tee_device-without-a-pool/20250813-084152
base:   2674d1eadaa2fd3a918dfcdb6d0bb49efe8a8bb9
patch link:    https://lore.kernel.org/r/20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-8-ce7a1a774803%40oss.qualcomm.com
patch subject: [PATCH v7 08/11] tee: add Qualcomm TEE driver
config: hexagon-randconfig-r072-20250814 (https://download.01.org/0day-ci/archive/20250814/202508140527.ighXikjo-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508140527.ighXikjo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508140527.ighXikjo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tee/qcomtee/user_obj.c:384:12: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
     383 |                                        &qcomtee_user_object_ops, "uo-%lu",
         |                                                                      ~~~
         |                                                                      %llu
     384 |                                        param->u.objref.id);
         |                                        ^~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +384 drivers/tee/qcomtee/user_obj.c

   355	
   356	/**
   357	 * qcomtee_user_param_to_object() - OBJREF parameter to &struct qcomtee_object.
   358	 * @object: object returned.
   359	 * @param: TEE parameter.
   360	 * @ctx: context in which the conversion should happen.
   361	 *
   362	 * @param is an OBJREF with %QCOMTEE_OBJREF_FLAG_USER flags.
   363	 *
   364	 * Return: On success, returns 0; on failure, returns < 0.
   365	 */
   366	int qcomtee_user_param_to_object(struct qcomtee_object **object,
   367					 struct tee_param *param,
   368					 struct tee_context *ctx)
   369	{
   370		struct qcomtee_user_object *user_object __free(kfree) = NULL;
   371		int err;
   372	
   373		user_object = kzalloc(sizeof(*user_object), GFP_KERNEL);
   374		if (!user_object)
   375			return -ENOMEM;
   376	
   377		user_object->ctx = ctx;
   378		user_object->object_id = param->u.objref.id;
   379		/* By default, always notify userspace upon release. */
   380		user_object->notify = true;
   381		err = qcomtee_object_user_init(&user_object->object,
   382					       QCOMTEE_OBJECT_TYPE_CB,
   383					       &qcomtee_user_object_ops, "uo-%lu",
 > 384					       param->u.objref.id);
   385		if (err)
   386			return err;
   387		/* Matching teedev_ctx_put() is in qcomtee_user_object_release(). */
   388		teedev_ctx_get(ctx);
   389	
   390		*object = &no_free_ptr(user_object)->object;
   391	
   392		return 0;
   393	}
   394	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

