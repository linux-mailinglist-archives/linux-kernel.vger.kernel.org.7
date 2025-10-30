Return-Path: <linux-kernel+bounces-877631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C09C1E9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2131F4E6C17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AC2F8BD9;
	Thu, 30 Oct 2025 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZ6sI+nV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EBB2749E4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806928; cv=none; b=pZI3CT/QqvGlg5yCiK8d/P0iBEVd4Qq5PjOu/vJ3+uFLNz5APXFdeWbu9rHJr9r2MeKpsg012rNAnvhM90gICxrn/yOVJ/fT3786u/LFWka+P/M6Lg4/yFnMnGkhOzmZfk5nkk4lIobHI/2E1hcIxRLu7EszG9hS4csJj3y+tLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806928; c=relaxed/simple;
	bh=VT8DCqnuMaoAKIQCBEXymaNS9EaXJv1AURFFRSuJNRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASNw5mRNYxChRxOlkp1wKhj8M6PlzXIv2y68BtZh/vlSS+JUjGA6L0JMcAr/MneWuGvnspVTj1Lb9uCvhXCMwQCDNJu0FnpmBtgErqGVdZkgIMrkaRNRanvyYhKAtozFErCnZs/LBt5YZwHZZwTyIqltVgUDEHUvGtG4zd0XjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZ6sI+nV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761806927; x=1793342927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VT8DCqnuMaoAKIQCBEXymaNS9EaXJv1AURFFRSuJNRc=;
  b=mZ6sI+nVIzadv9ICh1yYLr2WcZCk2UpAeTI+Xw7suPQaIWWGU8aIoKyc
   EI6wTxamHvh2G/E1eRCnCQKoGFuKFUygB3jZfOYLDR4iteEW48f4EGJm3
   9rW+im/nE9L9yi8D3P6HGKlFIc8qUZLUItYnlrWKvazs2gwY2Frm9L3xK
   i955f2TchzDbas8hiTc4c0ZqnO8bLbvxf+OEUcIRm9kfcRmWV6AzRG9Qn
   bZjusD3WGh/KYpHTCF8yLRRuW1K34ygeUy+BEkatc7KF/7H6GPbR7hEGK
   voSnmc2IgEQZG1AAkijN2EmNply67RZMentaL+2UnX1vewjofLXv6PSRA
   g==;
X-CSE-ConnectionGUID: 9QBcyvlBRYqOmXcm7Z/V2w==
X-CSE-MsgGUID: OxsXg3EnStmuehtemG8k4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75389195"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="75389195"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 23:48:46 -0700
X-CSE-ConnectionGUID: cGDv/ppBTLGa5Nk9bwVlHA==
X-CSE-MsgGUID: JsX6mo3YTJW2/pwkI8EbBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185130287"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 29 Oct 2025 23:48:44 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEMSf-000LYe-0y;
	Thu, 30 Oct 2025 06:48:41 +0000
Date: Thu, 30 Oct 2025 14:48:07 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, hare@suse.de, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvmet-auth: update sc_c in target host hash calculation
Message-ID: <202510301404.e9AFI3TO-lkp@intel.com>
References: <20251029045327.2035337-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029045327.2035337-1-alistair.francis@wdc.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.18-rc3]
[also build test WARNING on linus/master next-20251029]
[cannot apply to linux-nvme/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/nvmet-auth-update-sc_c-in-target-host-hash-calculation/20251029-125459
base:   v6.18-rc3
patch link:    https://lore.kernel.org/r/20251029045327.2035337-1-alistair.francis%40wdc.com
patch subject: [PATCH] nvmet-auth: update sc_c in target host hash calculation
config: mips-randconfig-r132-20251030 (https://download.01.org/0day-ci/archive/20251030/202510301404.e9AFI3TO-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301404.e9AFI3TO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510301404.e9AFI3TO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/fabrics-cmd-auth.c:46:25: sparse: sparse: cast to restricted __le16

vim +46 drivers/nvme/target/fabrics-cmd-auth.c

    33	
    34	static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
    35	{
    36		struct nvmet_ctrl *ctrl = req->sq->ctrl;
    37		struct nvmf_auth_dhchap_negotiate_data *data = d;
    38		int i, hash_id = 0, fallback_hash_id = 0, dhgid, fallback_dhgid;
    39	
    40		pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d halen %d dhlen %d\n",
    41			 __func__, ctrl->cntlid, req->sq->qid,
    42			 data->sc_c, data->napd, data->auth_protocol[0].dhchap.authid,
    43			 data->auth_protocol[0].dhchap.halen,
    44			 data->auth_protocol[0].dhchap.dhlen);
    45		req->sq->dhchap_tid = le16_to_cpu(data->t_id);
  > 46		req->sq->sc_c = le16_to_cpu(data->sc_c);
    47		if (data->sc_c != NVME_AUTH_SECP_NOSC) {
    48			if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
    49				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
    50			/* Secure concatenation can only be enabled on the admin queue */
    51			if (req->sq->qid)
    52				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
    53			switch (data->sc_c) {
    54			case NVME_AUTH_SECP_NEWTLSPSK:
    55				if (nvmet_queue_tls_keyid(req->sq))
    56					return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
    57				break;
    58			case NVME_AUTH_SECP_REPLACETLSPSK:
    59				if (!nvmet_queue_tls_keyid(req->sq))
    60					return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
    61				break;
    62			default:
    63				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
    64			}
    65			ctrl->concat = true;
    66		}
    67	
    68		if (data->napd != 1)
    69			return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
    70	
    71		if (data->auth_protocol[0].dhchap.authid !=
    72		    NVME_AUTH_DHCHAP_AUTH_ID)
    73			return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
    74	
    75		for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
    76			u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
    77	
    78			if (!fallback_hash_id &&
    79			    crypto_has_shash(nvme_auth_hmac_name(host_hmac_id), 0, 0))
    80				fallback_hash_id = host_hmac_id;
    81			if (ctrl->shash_id != host_hmac_id)
    82				continue;
    83			hash_id = ctrl->shash_id;
    84			break;
    85		}
    86		if (hash_id == 0) {
    87			if (fallback_hash_id == 0) {
    88				pr_debug("%s: ctrl %d qid %d: no usable hash found\n",
    89					 __func__, ctrl->cntlid, req->sq->qid);
    90				return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
    91			}
    92			pr_debug("%s: ctrl %d qid %d: no usable hash found, falling back to %s\n",
    93				 __func__, ctrl->cntlid, req->sq->qid,
    94				 nvme_auth_hmac_name(fallback_hash_id));
    95			ctrl->shash_id = fallback_hash_id;
    96		}
    97	
    98		dhgid = -1;
    99		fallback_dhgid = -1;
   100		for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
   101			int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
   102	
   103			if (tmp_dhgid != ctrl->dh_gid) {
   104				dhgid = tmp_dhgid;
   105				break;
   106			}
   107			if (fallback_dhgid < 0) {
   108				const char *kpp = nvme_auth_dhgroup_kpp(tmp_dhgid);
   109	
   110				if (crypto_has_kpp(kpp, 0, 0))
   111					fallback_dhgid = tmp_dhgid;
   112			}
   113		}
   114		if (dhgid < 0) {
   115			if (fallback_dhgid < 0) {
   116				pr_debug("%s: ctrl %d qid %d: no usable DH group found\n",
   117					 __func__, ctrl->cntlid, req->sq->qid);
   118				return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
   119			}
   120			pr_debug("%s: ctrl %d qid %d: configured DH group %s not found\n",
   121				 __func__, ctrl->cntlid, req->sq->qid,
   122				 nvme_auth_dhgroup_name(fallback_dhgid));
   123			ctrl->dh_gid = fallback_dhgid;
   124		}
   125		if (ctrl->dh_gid == NVME_AUTH_DHGROUP_NULL && ctrl->concat) {
   126			pr_debug("%s: ctrl %d qid %d: NULL DH group invalid "
   127				 "for secure channel concatenation\n", __func__,
   128				 ctrl->cntlid, req->sq->qid);
   129			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
   130		}
   131		pr_debug("%s: ctrl %d qid %d: selected DH group %s (%d)\n",
   132			 __func__, ctrl->cntlid, req->sq->qid,
   133			 nvme_auth_dhgroup_name(ctrl->dh_gid), ctrl->dh_gid);
   134		return 0;
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

