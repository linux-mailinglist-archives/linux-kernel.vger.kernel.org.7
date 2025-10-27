Return-Path: <linux-kernel+bounces-871352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C98C0D01F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003D9189BD69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA022E8DFC;
	Mon, 27 Oct 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+mPBFeo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859D6366
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562056; cv=none; b=kJWPSerLp/Y4eoo18kjT6iaSkupc8Zw65DnCe6Ai+Vj7CsUPUx2YpyANUm8N6wOLg2OdrzKeTTRCyfPGTjeEiYPZeYo764HeO7vBY7oLmqN5hwZph1d8GlL3L6+sFn9pz2EirMuOqlp4lP3rTh5/HoA2kovzyKDgebMUfV+zpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562056; c=relaxed/simple;
	bh=Q8eXXfl++E12QQqWP0Dsoj/t/8RF8OsS7SyWNGh3UqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dl0+aYWMoAtPKAk0aNnJwlgMFi8XYUpWh3rZ3hgo0FFfKHXEyrYfjIYRUp3qPQwPjwTLDWLVc6lRO2ZIG6SRHbyyg2lXaTmZTwQUBA1GbzczSjLq4Ql3+rDFrbAhic2e5SuSTxLFiy/sJqKvrX1j4dlT2qaLsF1/uFWYtmWaW2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+mPBFeo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47103b6058fso32876895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761562053; x=1762166853; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPTl9Ajy77CASesPXjv989dBjD2/ZNmvxRO79ZyFBS8=;
        b=W+mPBFeozuX3k2dhC66TrZw+nCQ+q5tvjPrBZ5tkYZn/Y9aG1nd/hB1Hd3R1XfTUSi
         6h6HfygQkKFy0A7O0fd5jQs+0hKbyP1Mk4Xe5nlE5mmttZUcBKVEqH/386naz3o96wAt
         TPc63hfilESxv1rUebz6H8JVstWhryTwSWs+MHYBfvt4TMa9bv0o9Hct0bjlm737gVay
         tjwqxchRwmHBSYfhpBy78KvbtQQBkTju1QlRK6EL0P0iJvm2be5h4zGyimPPhddHpJ5k
         TlHqxGkLgjuMzSGHkId8TCNDnvjTGUMtyRxQmV3rPrOe3m0IS8SeTRRY/jYrv+RsBe4f
         J8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761562053; x=1762166853;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPTl9Ajy77CASesPXjv989dBjD2/ZNmvxRO79ZyFBS8=;
        b=en6A8AtPBoGRCPvLZQKzHtKY2DjLT7PswO2qTt+UsAYJvRnAXbs29fJBC/X82qU+vA
         Uo/xkOn9Yau1yxJ1Q8aYL5KwlShBq2Vt5f9pGoccH7jCqVjPEBZuQNtMpN2d1YzPwhdv
         BBcZfCN06DGJnVf8k1q77NgPQRGpIIqfGmqsjXv61WR7/AMil1LNqc1qSQBVpa53xVQT
         fSbxY5a47k1IbxDLsU8TGICVJ+9chsPaGF7/80PEIpFuXJXVXflv4FQD8To8RbhTOdwG
         1V+3vrK+z0j6W0wLr37jZ8KUlmYp0Nzret5hhTt7UpwumBNkEGBCrUE5i3uSRWUbwd2C
         pRdA==
X-Forwarded-Encrypted: i=1; AJvYcCXq+UIERcaGn+P1DJ4KqrWpmhk7KvuygdGf+58DDymqahWDPuijdyVyi1AOUQmceSLNFBBqfsTH6HfcOhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqd0th+8PxHHPWHyWhQmqk1J921CUdxGuevA4uwSOvUV6KvnJe
	0gI8Otz+Llt46sdv/XvcsOwk0EOZPw8nOu38vX/fLwJmu8qMj5ZDSqOL/98c2rRiFHY=
X-Gm-Gg: ASbGnctafoQD4u09w1hskqJsge3Zj10oIM3zMPTwk3Q4dDahBtvFbcaat4m6xV9mcri
	FuhXzKq649H6KiNmjmzRdHF1uKX9pATHtcdKRGtdcE9a94IoxrlnT8Uors5kgOvtC4vLLfZ5m9c
	encW2CaGml2gLXctV98rKtiMr8qIIgKo6KWNB7MNolgnzirdm/nKkkVbq36DyqXqnOaKiR3wlu8
	dy6fYUiTGnbwi6blkOL6pwgpD7E/9kwEAGWi/NdYOxT1xGSmVnfNRO+BEYxiwnSoZ7mS8mW64VE
	//Zm5s5C+/OzV7BDdC7iHPM2ZXPk7b+NjfHleS4gHZPzKkq7sDLV0b8rywZSZOJ2OFn5kxB7M74
	K+0Mgp/F2nM3i1gg5or3PuAXzzKzTLbS25+BGPNjyM+C05E4rmvUTqRVXQYg+9aCEP0qocVY7xK
	0w0NhgYg==
X-Google-Smtp-Source: AGHT+IHEVbGc5HitCGNNFoRKiTyqfzQerYhZHZJMMpqyEWWVdz9DdsTtcZZacNdRzwXrOTXGwX+9vQ==
X-Received: by 2002:a05:600c:4694:b0:46e:37d5:dbed with SMTP id 5b1f17b1804b1-475d2427d73mr96288195e9.12.1761562052751;
        Mon, 27 Oct 2025 03:47:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475dd4cba64sm128611865e9.14.2025.10.27.03.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:47:32 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:47:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Carolina Jubran <cjubran@nvidia.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:808
 mlx5e_xfrm_add_state() warn: missing error code 'err'
Message-ID: <202510271649.uwsIxD6O-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
commit: 22239eb258bc1e6ccdb2d3502fce1cc2b2a88386 net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed
config: loongarch-randconfig-r072-20251026 (https://download.01.org/0day-ci/archive/20251027/202510271649.uwsIxD6O-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project e1ae12640102fd2b05bc567243580f90acb1135f)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510271649.uwsIxD6O-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:808 mlx5e_xfrm_add_state() warn: missing error code 'err'

vim +/err +808 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c

43eca05b6a3b91 Cosmin Ratiu    2025-04-11  770  static int mlx5e_xfrm_add_state(struct net_device *dev,
43eca05b6a3b91 Cosmin Ratiu    2025-04-11  771  				struct xfrm_state *x,
7681a4f58fb9c3 Leon Romanovsky 2023-01-24  772  				struct netlink_ext_ack *extack)
547eede070eb98 Ilan Tayari     2017-04-18  773  {
547eede070eb98 Ilan Tayari     2017-04-18  774  	struct mlx5e_ipsec_sa_entry *sa_entry = NULL;
22239eb258bc1e Carolina Jubran 2025-10-05  775  	bool allow_tunnel_mode = false;
403b383a3ce3eb Leon Romanovsky 2022-12-02  776  	struct mlx5e_ipsec *ipsec;
547eede070eb98 Ilan Tayari     2017-04-18  777  	struct mlx5e_priv *priv;
aa8bd0c9518cc5 Raed Salem      2023-03-14  778  	gfp_t gfp;
547eede070eb98 Ilan Tayari     2017-04-18  779  	int err;
547eede070eb98 Ilan Tayari     2017-04-18  780  
43eca05b6a3b91 Cosmin Ratiu    2025-04-11  781  	priv = netdev_priv(dev);
021a429bdbde93 Leon Romanovsky 2022-03-01  782  	if (!priv->ipsec)
021a429bdbde93 Leon Romanovsky 2022-03-01  783  		return -EOPNOTSUPP;
547eede070eb98 Ilan Tayari     2017-04-18  784  
403b383a3ce3eb Leon Romanovsky 2022-12-02  785  	ipsec = priv->ipsec;
aa8bd0c9518cc5 Raed Salem      2023-03-14  786  	gfp = (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ) ? GFP_ATOMIC : GFP_KERNEL;
aa8bd0c9518cc5 Raed Salem      2023-03-14  787  	sa_entry = kzalloc(sizeof(*sa_entry), gfp);
902812b81604dd Leon Romanovsky 2023-01-24  788  	if (!sa_entry)
902812b81604dd Leon Romanovsky 2023-01-24  789  		return -ENOMEM;
547eede070eb98 Ilan Tayari     2017-04-18  790  
547eede070eb98 Ilan Tayari     2017-04-18  791  	sa_entry->x = x;
43eca05b6a3b91 Cosmin Ratiu    2025-04-11  792  	sa_entry->dev = dev;
403b383a3ce3eb Leon Romanovsky 2022-12-02  793  	sa_entry->ipsec = ipsec;
aa8bd0c9518cc5 Raed Salem      2023-03-14  794  	/* Check if this SA is originated from acquire flow temporary SA */
aa8bd0c9518cc5 Raed Salem      2023-03-14  795  	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
aa8bd0c9518cc5 Raed Salem      2023-03-14  796  		goto out;
aa8bd0c9518cc5 Raed Salem      2023-03-14  797  
aa8bd0c9518cc5 Raed Salem      2023-03-14  798  	err = mlx5e_xfrm_validate_state(priv->mdev, x, extack);
aa8bd0c9518cc5 Raed Salem      2023-03-14  799  	if (err)
aa8bd0c9518cc5 Raed Salem      2023-03-14  800  		goto err_xfrm;
547eede070eb98 Ilan Tayari     2017-04-18  801  
8efd7b17a3b032 Leon Romanovsky 2023-08-24  802  	if (!mlx5_eswitch_block_ipsec(priv->mdev)) {
8efd7b17a3b032 Leon Romanovsky 2023-08-24  803  		err = -EBUSY;
8efd7b17a3b032 Leon Romanovsky 2023-08-24  804  		goto err_xfrm;
8efd7b17a3b032 Leon Romanovsky 2023-08-24  805  	}
8efd7b17a3b032 Leon Romanovsky 2023-08-24  806  
22239eb258bc1e Carolina Jubran 2025-10-05  807  	if (mlx5_eswitch_block_mode(priv->mdev))
22239eb258bc1e Carolina Jubran 2025-10-05 @808  		goto unblock_ipsec;

	err = mlx5_eswitch_block_mode(priv->mdev);
	if (err)
		goto unblock_ipsec;

22239eb258bc1e Carolina Jubran 2025-10-05  809  
22239eb258bc1e Carolina Jubran 2025-10-05  810  	if (x->props.mode == XFRM_MODE_TUNNEL &&
22239eb258bc1e Carolina Jubran 2025-10-05  811  	    x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
22239eb258bc1e Carolina Jubran 2025-10-05  812  		allow_tunnel_mode = mlx5e_ipsec_fs_tunnel_allowed(sa_entry);
22239eb258bc1e Carolina Jubran 2025-10-05  813  		if (!allow_tunnel_mode) {
22239eb258bc1e Carolina Jubran 2025-10-05  814  			NL_SET_ERR_MSG_MOD(extack,
22239eb258bc1e Carolina Jubran 2025-10-05  815  					   "Packet offload tunnel mode is disabled due to encap settings");
22239eb258bc1e Carolina Jubran 2025-10-05  816  			err = -EINVAL;
22239eb258bc1e Carolina Jubran 2025-10-05  817  			goto unblock_mode;
22239eb258bc1e Carolina Jubran 2025-10-05  818  		}
22239eb258bc1e Carolina Jubran 2025-10-05  819  	}
22239eb258bc1e Carolina Jubran 2025-10-05  820  
cb01008390bb06 Aviad Yehezkel  2018-01-18  821  	/* check esn */
f4979e2667c56f Leon Romanovsky 2023-03-30  822  	if (x->props.flags & XFRM_STATE_ESN)
cb01008390bb06 Aviad Yehezkel  2018-01-18  823  		mlx5e_ipsec_update_esn_state(sa_entry);
7f95b0247764ac Leon Romanovsky 2025-01-15  824  	else
7f95b0247764ac Leon Romanovsky 2025-01-15  825  		/* According to RFC4303, section "3.3.3. Sequence Number Generation",
7f95b0247764ac Leon Romanovsky 2025-01-15  826  		 * the first packet sent using a given SA will contain a sequence
7f95b0247764ac Leon Romanovsky 2025-01-15  827  		 * number of 1.
7f95b0247764ac Leon Romanovsky 2025-01-15  828  		 */
7f95b0247764ac Leon Romanovsky 2025-01-15  829  		sa_entry->esn_state.esn = 1;
cb01008390bb06 Aviad Yehezkel  2018-01-18  830  
b73e67287b8051 Leon Romanovsky 2022-03-09  831  	mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, &sa_entry->attrs);
4562116f8a565f Leon Romanovsky 2023-03-30  832  
4562116f8a565f Leon Romanovsky 2023-03-30  833  	err = mlx5_ipsec_create_work(sa_entry);
4562116f8a565f Leon Romanovsky 2023-03-30  834  	if (err)
22239eb258bc1e Carolina Jubran 2025-10-05  835  		goto unblock_encap;
4562116f8a565f Leon Romanovsky 2023-03-30  836  
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  837  	err = mlx5e_ipsec_create_dwork(sa_entry);
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  838  	if (err)
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  839  		goto release_work;
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  840  
d6c4f0298cec8c Aviad Yehezkel  2018-01-18  841  	/* create hw context */
b73e67287b8051 Leon Romanovsky 2022-03-09  842  	err = mlx5_ipsec_create_sa_ctx(sa_entry);
b73e67287b8051 Leon Romanovsky 2022-03-09  843  	if (err)
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  844  		goto release_dwork;
547eede070eb98 Ilan Tayari     2017-04-18  845  
c7049ca6213732 Leon Romanovsky 2022-12-02  846  	err = mlx5e_accel_ipsec_fs_add_rule(sa_entry);
5e466345291a91 Huy Nguyen      2020-06-05  847  	if (err)
5e466345291a91 Huy Nguyen      2020-06-05  848  		goto err_hw_ctx;
5e466345291a91 Huy Nguyen      2020-06-05  849  
403b383a3ce3eb Leon Romanovsky 2022-12-02  850  	/* We use *_bh() variant because xfrm_timer_handler(), which runs
403b383a3ce3eb Leon Romanovsky 2022-12-02  851  	 * in softirq context, can reach our state delete logic and we need
403b383a3ce3eb Leon Romanovsky 2022-12-02  852  	 * xa_erase_bh() there.
403b383a3ce3eb Leon Romanovsky 2022-12-02  853  	 */
403b383a3ce3eb Leon Romanovsky 2022-12-02  854  	err = xa_insert_bh(&ipsec->sadb, sa_entry->ipsec_obj_id, sa_entry,
403b383a3ce3eb Leon Romanovsky 2022-12-02  855  			   GFP_KERNEL);
7dfee4b1d79e18 Raed Salem      2019-10-23  856  	if (err)
5e466345291a91 Huy Nguyen      2020-06-05  857  		goto err_add_rule;
403b383a3ce3eb Leon Romanovsky 2022-12-02  858  
f4979e2667c56f Leon Romanovsky 2023-03-30  859  	mlx5e_ipsec_set_esn_ops(sa_entry);
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  860  
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  861  	if (sa_entry->dwork)
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  862  		queue_delayed_work(ipsec->wq, &sa_entry->dwork->dwork,
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  863  				   MLX5_IPSEC_RESCHED);
4c24272b4e2bef Leon Romanovsky 2023-04-13  864  
22239eb258bc1e Carolina Jubran 2025-10-05  865  	if (allow_tunnel_mode) {
2c3688090f8a1f Leon Romanovsky 2025-01-15  866  		xa_lock_bh(&ipsec->sadb);
2c3688090f8a1f Leon Romanovsky 2025-01-15  867  		__xa_set_mark(&ipsec->sadb, sa_entry->ipsec_obj_id,
4c24272b4e2bef Leon Romanovsky 2023-04-13  868  			      MLX5E_IPSEC_TUNNEL_SA);
2c3688090f8a1f Leon Romanovsky 2025-01-15  869  		xa_unlock_bh(&ipsec->sadb);
2c3688090f8a1f Leon Romanovsky 2025-01-15  870  	}
4c24272b4e2bef Leon Romanovsky 2023-04-13  871  
aa8bd0c9518cc5 Raed Salem      2023-03-14  872  out:
547eede070eb98 Ilan Tayari     2017-04-18  873  	x->xso.offload_handle = (unsigned long)sa_entry;
22239eb258bc1e Carolina Jubran 2025-10-05  874  	if (allow_tunnel_mode)
22239eb258bc1e Carolina Jubran 2025-10-05  875  		mlx5_eswitch_unblock_encap(priv->mdev);
22239eb258bc1e Carolina Jubran 2025-10-05  876  
22239eb258bc1e Carolina Jubran 2025-10-05  877  	mlx5_eswitch_unblock_mode(priv->mdev);
22239eb258bc1e Carolina Jubran 2025-10-05  878  
403b383a3ce3eb Leon Romanovsky 2022-12-02  879  	return 0;
547eede070eb98 Ilan Tayari     2017-04-18  880  
5e466345291a91 Huy Nguyen      2020-06-05  881  err_add_rule:
c7049ca6213732 Leon Romanovsky 2022-12-02  882  	mlx5e_accel_ipsec_fs_del_rule(sa_entry);
7dfee4b1d79e18 Raed Salem      2019-10-23  883  err_hw_ctx:
b73e67287b8051 Leon Romanovsky 2022-03-09  884  	mlx5_ipsec_free_sa_ctx(sa_entry);
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  885  release_dwork:
b2f7b01d36a9b9 Leon Romanovsky 2023-03-30  886  	kfree(sa_entry->dwork);
4562116f8a565f Leon Romanovsky 2023-03-30  887  release_work:
94edec448479e3 Leon Romanovsky 2023-04-20  888  	if (sa_entry->work)
4562116f8a565f Leon Romanovsky 2023-03-30  889  		kfree(sa_entry->work->data);
4562116f8a565f Leon Romanovsky 2023-03-30  890  	kfree(sa_entry->work);
22239eb258bc1e Carolina Jubran 2025-10-05  891  unblock_encap:
22239eb258bc1e Carolina Jubran 2025-10-05  892  	if (allow_tunnel_mode)
22239eb258bc1e Carolina Jubran 2025-10-05  893  		mlx5_eswitch_unblock_encap(priv->mdev);
22239eb258bc1e Carolina Jubran 2025-10-05  894  unblock_mode:
22239eb258bc1e Carolina Jubran 2025-10-05  895  	mlx5_eswitch_unblock_mode(priv->mdev);
8efd7b17a3b032 Leon Romanovsky 2023-08-24  896  unblock_ipsec:
8efd7b17a3b032 Leon Romanovsky 2023-08-24  897  	mlx5_eswitch_unblock_ipsec(priv->mdev);
d6c4f0298cec8c Aviad Yehezkel  2018-01-18  898  err_xfrm:
547eede070eb98 Ilan Tayari     2017-04-18  899  	kfree(sa_entry);
697b3518ebfd1d Leon Romanovsky 2023-04-20  900  	NL_SET_ERR_MSG_WEAK_MOD(extack, "Device failed to offload this state");
547eede070eb98 Ilan Tayari     2017-04-18  901  	return err;
547eede070eb98 Ilan Tayari     2017-04-18  902  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


