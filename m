Return-Path: <linux-kernel+bounces-888809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83064C3BF5C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA521883E35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD6337B93;
	Thu,  6 Nov 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkhYncQU"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937D342C88
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441442; cv=none; b=oJy6xjxraj2KDIW9pXab5YeoEc37Nsq+JusJ4zKIKyrMatqiAB7DDGN0C48OWod24L1Dlu6bnW4JUSyNvoY2dkN32VcL9pqDq+NE5t0AGP72uaDC2iNzKpNx7tarQYp1gV6ScxBwmegKEs5fpbW6z1qMhkFOy3iL1TQtxlvtfI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441442; c=relaxed/simple;
	bh=55SSt3Gkzzq+ugMem0J0DiZiyJVQiw2q4O9Mf2FxiCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fU+NzRN/ObSHhaJTAsudk1KRwnyBqsazfXr3p4TE6dl/7rRnGdEQfaHKqPmQntDfzNp0Idf6DUTBB4CdBopwbgPL7w9/jhKBKcrv7Fy9tKi8Vtdwn38b9mircxleMYWdTXwPSaOEsRjq3rFz7pHCF1Be5fsm30X3aRg4OSg1+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkhYncQU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b725ead5800so154924966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762441436; x=1763046236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRLohXtRGatztz+SeKrGjSMg+wc0GgYqEIBKdX3UGlY=;
        b=mkhYncQUeHCjVYQr2crN7i5XLfG1A9As//o3WZTqR39K9YDblKGXqDPyvD5AnNQEww
         /nrJ0ic2aQpRs9Fgdvz7/wSVOLRhlY7FBy4VQfP5STyHwaNieBKOajojBHExLQvk7yX8
         2VBGXM0WjNrMAB5QJKsskZYMKToyyApdFyqyIEyUTtW3Tx7U6wvxfHZv0/6VxZz+RzZB
         ZLE128WNk0WDgupMjqfhIN6ixFMXLZAz4+JXai6RLepAi0sGKqIXdVz2Ny2H/pzi3mB3
         UokyTpY7D2UiSlDNhqEd4BwK3tqCoIUuwJxJz6Ug6fwLnXwz+4b/ETLTCEU2VqZXXYXf
         C81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441436; x=1763046236;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRLohXtRGatztz+SeKrGjSMg+wc0GgYqEIBKdX3UGlY=;
        b=gjCL3JtESspe52l5cvTjnaMsJAso2gJteBdiuHMf5sBGzFjubEvWOLVzzzgOh7nHR2
         6zRPJ9Ab08QRswF/BjG5PiX+pxyjT3ZxNkvheI+RyxB2+k1TVxfucpAKzNiP7pyhsvm+
         w3sKk8ujDklbViO16NInMoTsVKU1+dyvy9M2dytuOP5SItOaLrbt31AxaN2fJJ2dP2uF
         Pd+ZtjVXDbY7mC1s9YUkNS3gt5wQ+HL/tc+8RjalneAUvwxu7frzWU3WTBpgjGeT3jg4
         xaQAW4a7UI8pPr1LdnkHGTTXIpr8Bsd1JUsfTvTKLQFNn4x3pPr+2KmMjfz/G0wcoabY
         QS4g==
X-Forwarded-Encrypted: i=1; AJvYcCVtaMSTChx0pAxkuClmoVTr71MF+G6olnuY247UiOwnMnx//kR/2ZPUmJp4N2iDZ7tPSf8x6ViqpdcjFB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxjA7kZYYgA2oSyLBx3V79m7YrTCs1588Rwxjc18bm5utNR0Va
	NXvHVFApjI4HUbzserh9ajrQ7z7b0Zus41Pvcyk4WCOPZNuWQ4558rZLv+IjUvXvjDw=
X-Gm-Gg: ASbGncscvzzBPBEIKCt0TBqL7Q1qpSlMFtApYX13hDdRucFALa2Szg64tmXFCSgQHwc
	hw9008cNXE+KtlluPpPZ8xjh9tqncR2wDl5z+0UWn+lNhwN7lhysiYklgkLDssMf60CqbQ6T3ZE
	duo80OW9kX29+RgQa5CEWnJTJPUQ0WE/Xh597Zd4L6PsToDmKwRVe0FGUGeS9n721JeGIGF0Dq/
	XewSeG1A2lF4OLCzzU6B9B5ETZwTpDzV7zW1W+pkui2y2SR0cx2NYWslypza822yzUI1NnaEXhb
	t1w43LosuM4IxTcm/3aKEFkW9woNVbo14pwaBFqeh3Poy4uK3eCEoDo1wIwLFjE0owlVFHRHIrt
	oPx5awe+456wNdRyVnUAnbCaLckCsKgEhyAHmKvgaWtHepW/f7VzvfycxnhStUsdjxG/RMr63sA
	BoXuIbvnx9Ohfu
X-Google-Smtp-Source: AGHT+IFnv2kR+7AyxozjbIcjjKi77N+kW4qDPXl6xjDKudbBmTU0vSNFCi9nDzLNKrbJlFvId55g3g==
X-Received: by 2002:a17:907:7b88:b0:b70:a9fd:1170 with SMTP id a640c23a62f3a-b72656112a3mr832404066b.65.1762441434963;
        Thu, 06 Nov 2025 07:03:54 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289377c0dsm238249566b.20.2025.11.06.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:03:54 -0800 (PST)
Date: Thu, 6 Nov 2025 18:03:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
	bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	saravanak@google.com, prakash.gupta@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
Message-ID: <3fc0cd48-91d3-401b-9102-ebc77de731c4@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla@oss.qualcomm.com>

Hi Charan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charan-Teja-Kalla/of-create-a-wrapper-for-of_map_id/20251104-170223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla%40oss.qualcomm.com
patch subject: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
config: hexagon-randconfig-r072-20251105 (https://download.01.org/0day-ci/archive/20251105/202511051256.fSouTFuY-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511051256.fSouTFuY-lkp@intel.com/

smatch warnings:
drivers/of/base.c:2130 of_iommu_map_id_cell_count() error: uninitialized symbol 'legacy_iommu_cells'.

vim +/legacy_iommu_cells +2130 drivers/of/base.c

5288ad2aeeeb419 Charan Teja Kalla 2025-11-04  2123  static int of_iommu_map_id_cell_count(const __be32 *map, int map_len, u32 cells)
c74d6f4acf99ef3 Charan Teja Kalla 2025-11-04  2124  {
5288ad2aeeeb419 Charan Teja Kalla 2025-11-04  2125  	u32 legacy_iommu_cells;
5288ad2aeeeb419 Charan Teja Kalla 2025-11-04  2126  
c74d6f4acf99ef3 Charan Teja Kalla 2025-11-04  2127  	if (map_len % 4 != 0)
5288ad2aeeeb419 Charan Teja Kalla 2025-11-04  2128  		legacy_iommu_cells = of_iommu_map_id_legacy_cell_count(map, map_len);

legacy_iommu_cells uninitialize on else path

c74d6f4acf99ef3 Charan Teja Kalla 2025-11-04  2129  
5288ad2aeeeb419 Charan Teja Kalla 2025-11-04 @2130  	return legacy_iommu_cells ? : of_iommu_map_id_actual_cell_count(map, map_len, cells);
c74d6f4acf99ef3 Charan Teja Kalla 2025-11-04  2131  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


