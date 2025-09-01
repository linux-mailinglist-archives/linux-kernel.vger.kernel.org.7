Return-Path: <linux-kernel+bounces-794451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B276AB3E1F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164421A81AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B131A563;
	Mon,  1 Sep 2025 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBCZlxgU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2422147E6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727175; cv=none; b=Kh8Z96RwjV0LZY3F52zPMHAqobxZRNI+eai1P1Jta6OUFAoT6bx/iPoUKNvtnrEcnJFTnSnT0aeUEF0+ZnAUS1XyUahNaVS8RdXEULmYq7C3/J/7UoJ5IsLSLTWWKNvPbD43d9+vZBdmBUwUo2kBSzXMzxXsY1nXmqNojE11Jno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727175; c=relaxed/simple;
	bh=oa8yFhR4MOVlIbCKi2lAbxZI5mMl7NxHerF/PDAor2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NxAoAqvZA02fSN/JybZyMBLWwgMACY1f5COGs85SCusLSCyjK4bjWhknCodlC7O091etx0nOER0vc+4+AUmM6sZbR7QOKCcVwsAhEbYHFQbMsN8HkI2vDiUk5S+Tcgn7EH0K37Y3meKJfmAJyFF6vR6NPu8AKK74wVhi/0TvYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TBCZlxgU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so28840685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756727172; x=1757331972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CXP5PchANxZqGp3Gssb1xnZMCk6ZZsq9Lr1RRv1yS0=;
        b=TBCZlxgUq7a7e7BMZfF4odwCpAQfqCeDeRS8T/S75CEQJkEQFYC27HnpE/MXUYPMol
         97m7N8nCyEuuznESYp9/Mc02tS3qsfTjljQiMUJcHVZSUTrKJBX0WVQ9iXrjH5LLTuBb
         zMZUxK1WlgWszjyXCvG6oks/jhE1AY4/70oj2WemXgQO9m5sYc1fFVyUqauC06y0BviP
         bfGnNb5FN0wOj7keAbowHBDtj717ZzyUB8kM/EKwCCeGLCPZ6Ogag79VQSvBsuiHZt1z
         gDcVwpCWY60HX2CiFuewpjPKbHEOVrcqC32EdJxrW/NMOrU+gPuqONsCI/Sl4OaAxiQW
         QRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756727172; x=1757331972;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CXP5PchANxZqGp3Gssb1xnZMCk6ZZsq9Lr1RRv1yS0=;
        b=Pl9IHhOOoUHhTQjX8/TakdFj4Ipf65tlAxJnHPs93+/jReFEpxpYtFs9Z8fq0g9mwz
         VhDm9BA+dXhVbyAHeOMeb7jR+e/OcOrBMaL0clAQoPfRKTNoRtyaoCdnjASkbMcukgwq
         WZGCwwAaeS/RU2wiCm3mphO8MH5yY2V1xSls7sSU9cT93R0pSpgDuesIFNEjfh57akcQ
         fQIYhcgKmZIGcI9wAz4ZIpPQhDJuBJtMmTihqqJp6Cbp557uMNULdJ5r+/YNz8SpTfLI
         XbZ+AuZaVJDJQeY7fW0PJ4/8g4FL+FSL+z75qtCKdBmwLQ4f4aGsY9d9waYCKTcoKkWa
         S1/g==
X-Forwarded-Encrypted: i=1; AJvYcCVhDgCK5pdnO3kGjOS1VD6v0RpR1AM4BL+XjFAbQyE9U1h8jsX6gmNVX9hPvl4+7Yf1x07EIBn3MMry4/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfeXF00XoHDf9i7Y9Cy/N4xkxiXuSoTE42WM3JFFT3ZtNZSflZ
	USgqGdB3afyc6d3k5o1Ux65K5R0GmLBBVEybHzxslBfjaZp5H8zvDRTchBk/a0xrjy8=
X-Gm-Gg: ASbGncuVX3Gj50nKSEshMeqPypNL2l+wok/QOVQtHubrsHg388M1Oc+YI2oWHwJVckf
	n/6QH8NqQ+BhnjEMEdUTXrYgHYo0C05wOn30L8y2lM2Rw8f/uODjg3SQjt3USLvfmCyw+m59CMV
	Vc97+BwuAjccrk1KGfdnl/ZiCSvXhpaWYLLOel2vNSL7QJvqFRZWkHOogQCzreF+lyuhaHsIyAQ
	WSePovQkPw6ancz4WsJLKLf6atyhLotfQl53q5dZdDWdvEMZPrjljZy3oGTH2EgmaeEq/lOxPyi
	CUjWbJe4CM6bXlQQtNr7tM5VlWvzAk03/7r2FIiRne2QQgO30EYNUop0tsqaw8ow0X7KjgCpS1w
	h5l4/TiR8g+U1EOTxlIuHkr/o9IKF6VBEqa5x5g==
X-Google-Smtp-Source: AGHT+IHlqFyBokSnfRsgCUq7ALQSf4KtqVA34zcf/hmeCVs/UatcVoPMPEKEgVaN9VTTEzBEDFIuLA==
X-Received: by 2002:a05:6000:24c1:b0:3c8:95b0:945e with SMTP id ffacd0b85a97d-3d1e01d4c59mr5678053f8f.43.1756727171860;
        Mon, 01 Sep 2025 04:46:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf276d643dsm15226323f8f.26.2025.09.01.04.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:46:11 -0700 (PDT)
Date: Mon, 1 Sep 2025 14:46:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup
 code
Message-ID: <202508310442.lBWBZ5AC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-nvme-fc-sync-v3-2-d69c87e63aee@kernel.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-fabrics-introduce-ref-counting-for-nvmf_ctrl_options/20250829-234513
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250829-nvme-fc-sync-v3-2-d69c87e63aee%40kernel.org
patch subject: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup code
config: x86_64-randconfig-161-20250830 (https://download.01.org/0day-ci/archive/20250831/202508310442.lBWBZ5AC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508310442.lBWBZ5AC-lkp@intel.com/

New smatch warnings:
drivers/nvme/host/fc.c:1492 nvme_fc_match_disconn_ls() warn: iterator used outside loop: 'ctrl'

Old smatch warnings:
drivers/nvme/host/fc.c:3180 nvme_fc_delete_association() warn: mixing irqsave and irq

vim +/ctrl +1492 drivers/nvme/host/fc.c

14fd1e98afafc0 James Smart 2020-03-31  1465  static struct nvme_fc_ctrl *
14fd1e98afafc0 James Smart 2020-03-31  1466  nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
14fd1e98afafc0 James Smart 2020-03-31  1467  		      struct nvmefc_ls_rcv_op *lsop)
14fd1e98afafc0 James Smart 2020-03-31  1468  {
14fd1e98afafc0 James Smart 2020-03-31  1469  	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
14fd1e98afafc0 James Smart 2020-03-31  1470  					&lsop->rqstbuf->rq_dis_assoc;
14fd1e98afafc0 James Smart 2020-03-31  1471  	struct nvme_fc_ctrl *ctrl, *ret = NULL;
14fd1e98afafc0 James Smart 2020-03-31  1472  	struct nvmefc_ls_rcv_op *oldls = NULL;
14fd1e98afafc0 James Smart 2020-03-31  1473  	u64 association_id = be64_to_cpu(rqst->associd.association_id);
14fd1e98afafc0 James Smart 2020-03-31  1474  	unsigned long flags;
14fd1e98afafc0 James Smart 2020-03-31  1475  
14fd1e98afafc0 James Smart 2020-03-31  1476  	spin_lock_irqsave(&rport->lock, flags);
14fd1e98afafc0 James Smart 2020-03-31  1477  
14fd1e98afafc0 James Smart 2020-03-31  1478  	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
14fd1e98afafc0 James Smart 2020-03-31  1479  		spin_lock(&ctrl->lock);
14fd1e98afafc0 James Smart 2020-03-31  1480  		if (association_id == ctrl->association_id) {
14fd1e98afafc0 James Smart 2020-03-31  1481  			oldls = ctrl->rcv_disconn;
14fd1e98afafc0 James Smart 2020-03-31  1482  			ctrl->rcv_disconn = lsop;
14fd1e98afafc0 James Smart 2020-03-31  1483  			ret = ctrl;

There should maybe be a break statement here?

14fd1e98afafc0 James Smart 2020-03-31  1484  		}
14fd1e98afafc0 James Smart 2020-03-31  1485  		spin_unlock(&ctrl->lock);
14fd1e98afafc0 James Smart 2020-03-31  1486  	}
14fd1e98afafc0 James Smart 2020-03-31  1487  
14fd1e98afafc0 James Smart 2020-03-31  1488  	spin_unlock_irqrestore(&rport->lock, flags);
14fd1e98afafc0 James Smart 2020-03-31  1489  
14fd1e98afafc0 James Smart 2020-03-31  1490  	/* transmit a response for anything that was pending */
14fd1e98afafc0 James Smart 2020-03-31  1491  	if (oldls) {
14fd1e98afafc0 James Smart 2020-03-31 @1492  		dev_info(rport->lport->dev,
14fd1e98afafc0 James Smart 2020-03-31  1493  			"NVME-FC{%d}: Multiple Disconnect Association "
14fd1e98afafc0 James Smart 2020-03-31  1494  			"LS's received\n", ctrl->cnum);

ctrl->cnum is always an invalid pointer on this line.  Another
option would be to print ret->cnum instead ctrl->nmum.

14fd1e98afafc0 James Smart 2020-03-31  1495  		/* overwrite good response with bogus failure */
14fd1e98afafc0 James Smart 2020-03-31  1496  		oldls->lsrsp->rsplen = nvme_fc_format_rjt(oldls->rspbuf,
14fd1e98afafc0 James Smart 2020-03-31  1497  						sizeof(*oldls->rspbuf),
14fd1e98afafc0 James Smart 2020-03-31  1498  						rqst->w0.ls_cmd,
14fd1e98afafc0 James Smart 2020-03-31  1499  						FCNVME_RJT_RC_UNAB,
14fd1e98afafc0 James Smart 2020-03-31  1500  						FCNVME_RJT_EXP_NONE, 0);
14fd1e98afafc0 James Smart 2020-03-31  1501  		nvme_fc_xmt_ls_rsp(oldls);
14fd1e98afafc0 James Smart 2020-03-31  1502  	}
14fd1e98afafc0 James Smart 2020-03-31  1503  
14fd1e98afafc0 James Smart 2020-03-31  1504  	return ret;
14fd1e98afafc0 James Smart 2020-03-31  1505  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


