Return-Path: <linux-kernel+bounces-774920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F65B2B938
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C4952861F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3326A0AD;
	Tue, 19 Aug 2025 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sv1HbAlq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A226A088
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584017; cv=none; b=c7CVz+tjmIKfEqKVD3m5mIOCpyXZ8nOqFRZfKQODkAWhAR5juBDToqjM6/185vQKeyYCfW07opa8LvC6Lz8iix1kV+MTZ19RA9g98zK37rgqyUn5JAyYsQBREzxeE9F4vRR5a41dQ13Fi7fe+rRAmHOG7Ip5AD9jQHh/A2ADw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584017; c=relaxed/simple;
	bh=pwnw8a9mADcH9qJIzPKa/tq1ZyVltio+a8Y2AhJ473A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G3hg9imPqQWhiK2pKg4DDZBracYLcuJ7iawn3COxw28Kx1AGfDJSJmdNzInngQcXIeZHyYdB5VL8Rm6/yoOVtBTtUDXMh4ITL1JSSSIix/8CgnwmyymKfpiimx6OdrtyHocBRKwjYBNR7TKdl/TyuaqllwKUJCAtmcJCzVOuq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sv1HbAlq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b05d252so34229185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755584013; x=1756188813; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vR2Z/WDH6gOreEopMqHmHW9u0hd60Nj5JCbNxFQ+BRU=;
        b=Sv1HbAlqLKBmTqq6WJVe2VxJ/MN9s0C6PfS8G947zFQoM7O81SVsWfOxh3iUMLLBlI
         me1tXfxcixcleUOJtKu+3+XbhglztiV6pZbfd0Ya39uGelmWeiggnnS/z5n177EjhI4R
         kG8lX2uR7yYNkAUwb6XQt/u4+e9B6YZchIP7n6wp1e9drXSNwtiBwl9zoka9WvFfmjXc
         u5aops1bgVUy3so08RwmYLKOKc4cBwrrDIJNac3j71yqZPzlBwe9+l77OpEUKp+faGWt
         FjjXL8+klPsy15IndTtwTogPQaLPhXOm+9Ex8WSFU37NAoEs4Amyo6VhO+BcJr8FcSt6
         CEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755584013; x=1756188813;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vR2Z/WDH6gOreEopMqHmHW9u0hd60Nj5JCbNxFQ+BRU=;
        b=d4Y4bW2latW1cYzljZOoI4j5ZI4Ph8gemDCUiFL1DPoYYNS1BLjqrRaY9xFRXw5Fhs
         +5W1hLHYL+bMpu74fPRsprUxSe+7c/egtqL5Pc1pnstyiCcTqU/h7fkN/SyR+YgfYuNj
         IUPhzqSUtFb6FyIjHpHjiRaNyjUkiVKqTL88KucdzK9Wgpokbu0DzoIriOgbEDSgvDYh
         Y50mqEzNbnDslsk8Opr96OXJGAuohWtUvPiMvq3rOXCDhzwBh+udNtUehunDm1naqEMp
         S/UEBuV6gA2w0KzM3+voYQz3Bs2axq/5d1v+8D3R6Lv7WY8F3SM7JJ+o7yCL0OmIeYss
         tqzA==
X-Forwarded-Encrypted: i=1; AJvYcCVMxZeq1AHZMO4rAx2kZxu+VxdUQqIjnluzgMXIH4SlX/ixYAxzvKGJm28MFbHYrbBkuDF9ZrtUx4HNB34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/qft3Z47pImN1HZKdUkey4lqYofCFgd9+ER74gzE8FgDPsY5
	EMvwbgyo90jv2ecNZ8OWAJn0uyrw3PUnoU3anCgDFLhcLL0gAz1c/c2NOStExIRlnRo=
X-Gm-Gg: ASbGnctpWsG4bwIfyb7FJtTS0VIUYFA1qkaQYMJmxOuHC84/W6XrwfWV7we8xgiWvFa
	HsCuEIWbFUPUFAhGphTT/7v//fNjc3UTJXKXfEf1gPKsTKs7cgmxtORpCE4B1WU4aYLmTqL9Ggu
	cr7rC9E5hSYtRlaOuOJ3VEyeXzoHVHIsKigHwodqmF1W1N20dBo4LGIgxxxEkApuu1M8gZlTySo
	Ts537rCdksjVDfGrEEodzLgKNzzPB1ZaEOXB9Gc3oBJsw7IW+4Lm6VPYFpP2acOthrE0Cauds3j
	TbAu2eo0Yq9jRa4gb5pq5uFhrTt/eYayr6aXoianGAeFUqsKy74wcwmSiROisO8pfZqdrVABNIb
	UfBTqa4tV3LtfR+dXGGsYoo0jpU0qiQ6OKdaXs9dId+k=
X-Google-Smtp-Source: AGHT+IFf2NahY6DopTmenXeCCcDiRINlBfHfCPxPEpy5h+ISp3BJFr1CxlpB+wS3kFF53KDbbHEAvQ==
X-Received: by 2002:a05:600c:1f93:b0:456:1bca:7faf with SMTP id 5b1f17b1804b1-45b43dfe5d7mr10266725e9.16.1755584012990;
        Mon, 18 Aug 2025 23:13:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c6cfed5sm193702245e9.7.2025.08.18.23.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:13:32 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:13:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Chenghao Duan <duanchenghao@kylinos.cn>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: arch/loongarch/net/bpf_jit.c:1547 __arch_prepare_bpf_trampoline()
 error: uninitialized symbol 'retval_off'.
Message-ID: <202508191020.PBBh07cK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be48bcf004f9d0c9207ff21d0edb3b42f253829e
commit: f9b6b41f0cf31791541cea9644ddbedb46465801 LoongArch: BPF: Add basic bpf trampoline support
date:   2 weeks ago
config: loongarch-randconfig-r073-20250818 (https://download.01.org/0day-ci/archive/20250819/202508191020.PBBh07cK-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508191020.PBBh07cK-lkp@intel.com/

New smatch warnings:
arch/loongarch/net/bpf_jit.c:1547 __arch_prepare_bpf_trampoline() error: uninitialized symbol 'retval_off'.

vim +/retval_off +1547 arch/loongarch/net/bpf_jit.c

f9b6b41f0cf317 Chenghao Duan 2025-08-05  1419  static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1420  					 const struct btf_func_model *m, struct bpf_tramp_links *tlinks,
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1421  					 void *func_addr, u32 flags)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1422  {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1423  	int i, ret, save_ret;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1424  	int stack_size = 0, nargs = 0;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1425  	int retval_off, args_off, nargs_off, ip_off, run_ctx_off, sreg_off;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1426  	void *orig_call = func_addr;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1427  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1428  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1429  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1430  	u32 **branches = NULL;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1431  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1432  	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1433  		return -ENOTSUPP;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1434  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1435  	/*
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1436  	 * FP + 8       [ RA to parent func ] return address to parent
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1437  	 *                    function
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1438  	 * FP + 0       [ FP of parent func ] frame pointer of parent
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1439  	 *                    function
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1440  	 * FP - 8       [ T0 to traced func ] return address of traced
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1441  	 *                    function
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1442  	 * FP - 16      [ FP of traced func ] frame pointer of traced
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1443  	 *                    function
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1444  	 *
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1445  	 * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1446  	 *                    BPF_TRAMP_F_RET_FENTRY_RET
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1447  	 *                  [ argN              ]
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1448  	 *                  [ ...               ]
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1449  	 * FP - args_off    [ arg1              ]
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1450  	 *
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1451  	 * FP - nargs_off   [ regs count        ]
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1452  	 *
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1453  	 * FP - ip_off      [ traced func   ] BPF_TRAMP_F_IP_ARG
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1454  	 *
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1455  	 * FP - run_ctx_off [ bpf_tramp_run_ctx ]
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1456  	 *
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1457  	 * FP - sreg_off    [ callee saved reg  ]
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1458  	 *
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1459  	 */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1460  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1461  	if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1462  		return -ENOTSUPP;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1463  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1464  	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1465  		return -ENOTSUPP;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1466  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1467  	stack_size = 0;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1468  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1469  	/* Room of trampoline frame to store return address and frame pointer */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1470  	stack_size += 16;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1471  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1472  	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1473  	if (save_ret) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1474  		/* Save BPF R0 and A0 */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1475  		stack_size += 16;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1476  		retval_off = stack_size;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1477  	}

retval_off is uninitialized on the else path.

f9b6b41f0cf317 Chenghao Duan 2025-08-05  1478  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1479  	/* Room of trampoline frame to store args */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1480  	nargs = m->nr_args;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1481  	stack_size += nargs * 8;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1482  	args_off = stack_size;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1483  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1484  	/* Room of trampoline frame to store args number */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1485  	stack_size += 8;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1486  	nargs_off = stack_size;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1487  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1488  	/* Room of trampoline frame to store ip address */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1489  	if (flags & BPF_TRAMP_F_IP_ARG) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1490  		stack_size += 8;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1491  		ip_off = stack_size;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1492  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1493  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1494  	/* Room of trampoline frame to store struct bpf_tramp_run_ctx */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1495  	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1496  	run_ctx_off = stack_size;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1497  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1498  	stack_size += 8;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1499  	sreg_off = stack_size;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1500  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1501  	stack_size = round_up(stack_size, 16);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1502  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1503  	/* For the trampoline called from function entry */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1504  	/* RA and FP for parent function */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1505  	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1506  	emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1507  	emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1508  	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1509  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1510  	/* RA and FP for traced function */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1511  	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_size);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1512  	emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1513  	emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1514  	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1515  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1516  	/* callee saved register S1 to pass start time */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1517  	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1518  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1519  	/* store ip address of the traced function */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1520  	if (flags & BPF_TRAMP_F_IP_ARG) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1521  		move_imm(ctx, LOONGARCH_GPR_T1, (const s64)func_addr, false);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1522  		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -ip_off);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1523  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1524  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1525  	/* store nargs number */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1526  	move_imm(ctx, LOONGARCH_GPR_T1, nargs, false);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1527  	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nargs_off);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1528  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1529  	store_args(ctx, nargs, args_off);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1530  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1531  	/* To traced function */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1532  	/* Ftrace jump skips 2 NOP instructions */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1533  	if (is_kernel_text((unsigned long)orig_call))
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1534  		orig_call += LOONGARCH_FENTRY_NBYTES;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1535  	/* Direct jump skips 5 NOP instructions */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1536  	else if (is_bpf_text_address((unsigned long)orig_call))
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1537  		orig_call += LOONGARCH_BPF_FENTRY_NBYTES;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1538  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1539  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1540  		move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1541  		ret = emit_call(ctx, (const u64)__bpf_tramp_enter);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1542  		if (ret)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1543  			return ret;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1544  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1545  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1546  	for (i = 0; i < fentry->nr_links; i++) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05 @1547  		ret = invoke_bpf_prog(ctx, fentry->links[i], args_off, retval_off,
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1548  				      run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);

It's undefined behavior to pass uninitialized data to a function (unless
the function is inlined, I suppose).

f9b6b41f0cf317 Chenghao Duan 2025-08-05  1549  		if (ret)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1550  			return ret;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1551  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1552  	if (fmod_ret->nr_links) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1553  		branches  = kcalloc(fmod_ret->nr_links, sizeof(u32 *), GFP_KERNEL);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1554  		if (!branches)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1555  			return -ENOMEM;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1556  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1557  		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off, run_ctx_off, branches);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1558  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1559  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1560  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1561  		restore_args(ctx, m->nr_args, args_off);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1562  		ret = emit_call(ctx, (const u64)orig_call);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1563  		if (ret)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1564  			goto out;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1565  		emit_insn(ctx, std, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1566  		emit_insn(ctx, std, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1567  		im->ip_after_call = ctx->ro_image + ctx->idx;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1568  		/* Reserve space for the move_imm + jirl instruction */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1569  		for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1570  			emit_insn(ctx, nop);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1571  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1572  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1573  	for (i = 0; ctx->image && i < fmod_ret->nr_links; i++) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1574  		int offset = (void *)(&ctx->image[ctx->idx]) - (void *)branches[i];
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1575  		*branches[i] = larch_insn_gen_bne(LOONGARCH_GPR_T1, LOONGARCH_GPR_ZERO, offset);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1576  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1577  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1578  	for (i = 0; i < fexit->nr_links; i++) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1579  		ret = invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off, run_ctx_off, false);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1580  		if (ret)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1581  			goto out;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1582  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1583  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1584  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1585  		im->ip_epilogue = ctx->ro_image + ctx->idx;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1586  		move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1587  		ret = emit_call(ctx, (const u64)__bpf_tramp_exit);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1588  		if (ret)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1589  			goto out;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1590  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1591  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1592  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1593  		restore_args(ctx, m->nr_args, args_off);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1594  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1595  	if (save_ret) {
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1596  		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1597  		emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1598  	}
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1599  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1600  	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1601  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1602  	/* trampoline called from function entry */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1603  	emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1604  	emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1605  	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_size);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1606  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1607  	emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1608  	emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1609  	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1610  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1611  	if (flags & BPF_TRAMP_F_SKIP_FRAME)
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1612  		/* return to parent function */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1613  		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1614  	else
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1615  		/* return to traced function */
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1616  		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0, 0);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1617  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1618  	ret = ctx->idx;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1619  out:
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1620  	kfree(branches);
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1621  
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1622  	return ret;
f9b6b41f0cf317 Chenghao Duan 2025-08-05  1623  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


