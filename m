Return-Path: <linux-kernel+bounces-752326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC313B17418
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDCF7A5352
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D231DED5D;
	Thu, 31 Jul 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndPXYK4N"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C0141987
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976719; cv=none; b=eRjOeTTz1Yj24iKQtNfhG1SyM4waMjyC0U5JuFr8IC7YUppKIezjcJcKpyoY2Ff1D/Ja1XluRqSgdSsPDdhKffNTe2Uf1oqbdBy5hibiM9n9an0xtYqU6wyMVe2c6gVNTh9SiSp41tT31zKq3yxhoPFtb23L7JJbtiua0+qi1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976719; c=relaxed/simple;
	bh=jZlOt1YZkVCFwV07TI+TAfO2Qv0hXeA8f+UU9YjpSgg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l4lFXPecSQiPsP3C+N9RHkThw4Vne18HWMvykvRnQvAPeHFgh2/b00lwv0NvPCs+sDEVeWYact+oQ6hafjp/GQfLM5sKvv1a37EAA4fdq3weHjVUlGed1OIO1//BbtxbpIPkcMFDE4qHZpk0wpPmUz66oxhIRvHe6IL7tJMTRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ndPXYK4N; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b794a013bcso1274360f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753976715; x=1754581515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja/Or7TtQWbgvEBjUvVLczjO5A/ZgQzAqJjlnzQL2m4=;
        b=ndPXYK4Nim6pZVKTkxJOBdhISbo7+ye9j7qTHpv8PRfpbSgpH/MeF83RwzYVruQI1B
         Yvj/eQTRq54ZdiWAD74GU47YYQba6MZsplC5QvdpJgNZ5ZmT6dev9PBbl7aOubS3Q+C1
         /o0wtKraV0vm8UNLgl/CjG5WgWwegJyqfVNvMYmp9hnhoYkOMDKxiQk8RtwBfkcrvIjS
         2knvHOyVVwYsUFElTlGpzb1Sn8zAhuyijZz/GYjXdm5VfNrgGXVMH5zT3yotkYcPXnhE
         0+5Klo1AwyI/md+/bMhuKHTPjCq7g6aCMDSawwq8Fww+xthrRmVJiwZETajwLMLsX9Q/
         CkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753976715; x=1754581515;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ja/Or7TtQWbgvEBjUvVLczjO5A/ZgQzAqJjlnzQL2m4=;
        b=Riqq5xkyTYdpiBl74sQIbdLgDA5BPYkjkZnFaddcSTBpLm8gf1v5xVlMrutT9E2p6K
         F5MWZNWjGi3LP/fUgLQdm7LiOtwKW1PJ9U/f2Pg6gXoTjETfRPq4wo6hZ3H4TpEclc9k
         bhb8HJFGilwTJ8CyfbkfKlLhDCfXPIe09hnOflSfLQJdBm+Hiy04OjCX7XeIsZZdUZxS
         SkjVEZXmefEMGB/zcOWji+L48d6frc1b+BYMoQdSQwtMA3cNWxusZJtk8c0Kje+8nehH
         b9Iqw3GF8D8Ov1sxFnauvQavYTKxFBQddT0t6eFvA+3DHK6IsRhgzSb8jZZGoGRZaswS
         TCNw==
X-Forwarded-Encrypted: i=1; AJvYcCXUClEhZeg+M7Ke6nn13VI0sGT2GScoiJfx25hc0cyNmmR6kgYr/E3c5jWBlVRKju31WQ2TaZnda39R3EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kiOMsNtGF+eqICKEPWRhyJJGd9v7JlausUrT+HWNh+GUnp23
	6Yfv91uZrTxNwx4Q0/ezwwXpjbxC+Aq9wU/rHwLpo5V0vW4mxJ2n8bL2zSeGy53rvbQ=
X-Gm-Gg: ASbGnctWJ3TVr2k2IOJkp5A9DQDp0CwYSHTPnE1zCBzXrJIfodXxiDnPexIRKZEkZXi
	bWvg97zFi5CeoyUWKK0d3vo8PawVOKlE6OL9rLKRyf0JC1YA0CvJ7n+0UDSfXA1+8MOzoaKZIiz
	fmbC3GA/FnU3ccTXqzwXFbdznBkBzjYn2aLNWm8bWlmPznWecMS8ps+wStElqomx4VeDuTINm3f
	Gzh/M9OnjlYbnSN8MGshRXlwGZUHWS4NQ3B/1wWtSZDW4ND7H7dOIJ4IDQKGKaL/M+zU8atwHDG
	8inBSzmLBfdmaZjQEfdKQBHWKVLjCf2ze64fgvJkJPItVS4FboQmiEV1EV+5/UNxIPkIlt9BqDk
	quX6F6bNL/5HOfvBqp86heDX54VI=
X-Google-Smtp-Source: AGHT+IHhJG3LfxP6KYv87rmvm8BnH4eV9UZ3r9hVeSwsBncQIEv9CMsfvZuSXXuKKKjdvWf4dmJKKg==
X-Received: by 2002:a05:6000:188c:b0:3b7:9dde:2a8 with SMTP id ffacd0b85a97d-3b79dde085cmr2503864f8f.35.1753976714859;
        Thu, 31 Jul 2025 08:45:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453d6esm2803852f8f.37.2025.07.31.08.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:45:14 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:45:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Salomon Dushimirimana <salomondush@google.com>, bvanassche@acm.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	James.Bottomley@hansenpartnership.com, kashyap.desai@broadcom.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	salomondush@google.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, sumit.saxena@broadcom.com
Subject: Re: [PATCH v2] scsi: mpi3mr: Emit uevent on controller diagnostic
 fault
Message-ID: <ba460132-50b0-4b77-b12a-4b9097b93fd9@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717194025.3218107-1-salomondush@google.com>

Hi Salomon,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Salomon-Dushimirimana/scsi-mpi3mr-Emit-uevent-on-controller-diagnostic-fault/20250718-034234
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/20250717194025.3218107-1-salomondush%40google.com
patch subject: [PATCH v2] scsi: mpi3mr: Emit uevent on controller diagnostic fault
config: x86_64-randconfig-161-20250720 (https://download.01.org/0day-ci/archive/20250721/202507211423.eXWSnhP5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507211423.eXWSnhP5-lkp@intel.com/

New smatch warnings:
drivers/scsi/mpi3mr/mpi3mr_fw.c:1639 mpi3mr_fault_uevent_emit() error: uninitialized symbol 'env'.

vim +/env +1639 drivers/scsi/mpi3mr/mpi3mr_fw.c

8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1636  static void mpi3mr_fault_uevent_emit(struct mpi3mr_ioc *mrioc, u16 reset_type,
8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1637  	u16 reset_reason)
8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1638  {
8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17 @1639  	struct kobj_uevent_env *env __free(kfree);

This has to be initialized before we return

8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1640  
8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1641  	if (reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT)
8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1642  		return;

otherwise this is an uninitialized variable at this return.

8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1643  
8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1644  	env = kzalloc(sizeof(*env), GFP_KERNEL);
8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1645  	if (!env)
8fe63dbd42cc3b Salomon Dushimirimana 2025-07-17  1646  		return;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


