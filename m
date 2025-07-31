Return-Path: <linux-kernel+bounces-752351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89274B1747B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EDDA82D45
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA02264CC;
	Thu, 31 Jul 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvfLmgI7"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC092222587
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977537; cv=none; b=i0xVbDn61rldXsgIOmQPO62VHEvGMMeZmcjFxgBVz1Sbos5f+dDJIsm9Oeq4Jw4mqccpxyVEbuin45sUUgA7yZCriwsg34T93J1EIHn4Z+agtPB+NJSlhVELMR4+oawMtA7VpwJLDkOhmNDmrxAw56ObWcorWvGwkb82xwWACe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977537; c=relaxed/simple;
	bh=U+uRCXeFeOvukHJjMenOn+Qvw1lqL1ftnetocaiGfq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aQHyxcWQPJBKawcOustnPksNCF3kXomlm+JmD9nAwbPaD8FbVrC8QoIL0B23tfNm33ONreAws4jKUULHAnNcYaNm+qB2vmGTNatwel1dLveopcwBKXleOiQw3i3VZC8SvN+391asGprCL29yelXlIVP93zJudXgmkJYSK5lO9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zvfLmgI7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e33d36491dso52576185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753977535; x=1754582335; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00UuTtqGKjcbbfk42wte8axOgzJtMx+0SDjZi+MO0EA=;
        b=zvfLmgI7SXf3oEtP8KX0XQermUiLNco9Ivt9pcedRIOgCV7IwsfAdrkMjNlB4k8Jmm
         uIhhaHEvPD1duFCtPkb4lpfIrMNbwAWJH4qu7ePJCAKhfe4AePdnr/d+e9sBE5bCMKir
         qEI9lXzdNV2ASe965k0pLrZhySjZEWbi/gVKLTt1+zyOO/gG6DHRN7j9SwRkhlYGeq8W
         FaJ3WKPkMbXHFJwZw7JJ8FrMHK9ZlxUw2DImgnZfTNb98yVK9HP0IAAfQYoNeJ0Q1jLD
         UTyPyOtLGFn5hO0pnZ24t5zdrko9piau8QbDcjOLsi1Sqi422MbCrQH9WDb00E5HtZKg
         J2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753977535; x=1754582335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00UuTtqGKjcbbfk42wte8axOgzJtMx+0SDjZi+MO0EA=;
        b=RaAAaO1zy3AEatmIzPeAkNYhXJfNznYVAKcS8uE8IaFZb/PeAGHBbPUP3hY9Ag8rFE
         1DNTTOb4jrKyiiHwJEuXNNLNtv8L17HFzaaNTGsVihp+ifHipOIyu8cbodkgaryfoOru
         T3m8MXCRIMZ+zeAJb6/v7y52RJqnR+pbqJC8VIUJ2mVTPj97Os0HNFvolOPQG/kLPbfO
         jv3XmpW9wsb3ULLMamFn7jbtKjmWgHeWyeiUZrFWGHcIC218+Ualx/T4vOx7bOrBcAn3
         /5RNVR57g58nSLSEQ9Y+LJ5ept4SoNJGqw1x+C5UF5ne3WGU/yodqr3/XRofcozWNfDo
         1BLw==
X-Forwarded-Encrypted: i=1; AJvYcCX85ECVcbofFTJ1y1Zj/iB/len3zpr2qw8QKm4X4XQQ/0gMMypwY03Ea7Y5VBotOY8wSA5IKy7LwOM4xaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0KKJd90HxV2QiTKyXaO0xRh9LtDoNRb2XD71QXvWyZls5VAA
	P9nsYQUpp9h/CrLTdVl3jfSAYpIS+C8BQ64udiay6rcs1kf3fkcYr9CPeZZlFqzAV/8=
X-Gm-Gg: ASbGncsrwlaB0SOjmXQ0x3ZAH/zk+EPCAKugPkh3igdefgfoIqoB+eNEqUzU5bJmACf
	thTKoiLKfhompL64ERHTJuPHy3Rzm/jhvkaVxJhuevnP4ZjNd9C4XwLBPjHV0hWq/OduEJt5lzs
	L8XxMuZ6x5HLOkvo0oRzH1fukAFhRRF5nafaPLWnwRprVpjWxeq1RxB2B38CVVwQoh+Kw6I6ABl
	Hswwda4X0hRNP47auOPFyRNCV91q6aQbji52uyDh6uYj/30kNO0MiHUEXs6IVdVKPaKZmn2cI92
	GlIFsO5696HNhfI1ieEZX5BoOZDf7p2OPUulRNTd+8veoJhTBVcWmFoMX9IRij593R5kpYki7LW
	ksYqYDYGf8Gh0L+E8lDoFr/qOoO8=
X-Google-Smtp-Source: AGHT+IGnVsf/6q/p/kjXrZ4NR1QJFU5WcxbxDZ7CIVKi0DNyDRrMvQHCxxpY3Fq/1N74yfc8Rfor8Q==
X-Received: by 2002:a05:620a:1918:b0:7e6:211b:217a with SMTP id af79cd13be357-7e66f353391mr1052893385a.43.1753977534616;
        Thu, 31 Jul 2025 08:58:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f72950csm99528985a.65.2025.07.31.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:58:54 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:58:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Marc Zyngier <maz@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: drivers/irqchip/irq-riscv-imsic-platform.c:317
 imsic_irqdomain_init() warn: variable dereferenced before check 'imsic' (see
 line 311)
Message-ID: <4aee1b4f-b176-46c4-841d-6bf6c91c6799@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   260f6f4fda93c8485c8037865c941b42b9cba5d2
commit: 59422904dd9855f94d00dc66598bef1bd2663894 irqchip/riscv-imsic: Convert to msi_create_parent_irq_domain() helper
config: riscv-randconfig-r073-20250731 (https://download.01.org/0day-ci/archive/20250731/202507311953.NFVZkr0a-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507311953.NFVZkr0a-lkp@intel.com/

smatch warnings:
drivers/irqchip/irq-riscv-imsic-platform.c:317 imsic_irqdomain_init() warn: variable dereferenced before check 'imsic' (see line 311)

vim +/imsic +317 drivers/irqchip/irq-riscv-imsic-platform.c

027e125acdbad7 Anup Patel   2024-03-07  308  int imsic_irqdomain_init(void)
027e125acdbad7 Anup Patel   2024-03-07  309  {
59422904dd9855 Marc Zyngier 2025-06-26  310  	struct irq_domain_info info = {
59422904dd9855 Marc Zyngier 2025-06-26 @311  		.fwnode		= imsic->fwnode,
                                                                          ^^^^^^^^^^^^^^
Dereference

59422904dd9855 Marc Zyngier 2025-06-26  312  		.ops		= &imsic_base_domain_ops,
59422904dd9855 Marc Zyngier 2025-06-26  313  		.host_data	= imsic,
59422904dd9855 Marc Zyngier 2025-06-26  314  	};
027e125acdbad7 Anup Patel   2024-03-07  315  	struct imsic_global_config *global;
027e125acdbad7 Anup Patel   2024-03-07  316  
027e125acdbad7 Anup Patel   2024-03-07 @317  	if (!imsic || !imsic->fwnode) {
                                                    ^^^^^^
Checked too late.

027e125acdbad7 Anup Patel   2024-03-07  318  		pr_err("early driver not probed\n");
027e125acdbad7 Anup Patel   2024-03-07  319  		return -ENODEV;
027e125acdbad7 Anup Patel   2024-03-07  320  	}
027e125acdbad7 Anup Patel   2024-03-07  321  
027e125acdbad7 Anup Patel   2024-03-07  322  	if (imsic->base_domain) {
027e125acdbad7 Anup Patel   2024-03-07  323  		pr_err("%pfwP: irq domain already created\n", imsic->fwnode);
027e125acdbad7 Anup Patel   2024-03-07  324  		return -ENODEV;
027e125acdbad7 Anup Patel   2024-03-07  325  	}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


