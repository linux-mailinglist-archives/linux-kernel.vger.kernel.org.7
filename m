Return-Path: <linux-kernel+bounces-831133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE5B9BA44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39E2167356
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE625949A;
	Wed, 24 Sep 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HL2TqXP3"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9018B0A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741277; cv=none; b=QYrsLirjpehbYh+5eMyPoGF17/5ib3yiKob+DIfScgy8JEXfbMmlx8MmnCFouOainhtmEY3EPsndxU8l12QuBe4JKN87CI8Gl+8BzJtsyjPB6eQXCwQu0cyCgZFhSFyX6NiYLJjM+BBsPmoYPMW81hp/nOdaDEaSH5fTCplb9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741277; c=relaxed/simple;
	bh=1i7/RHmotOfevMdnHSpyVe8IyzvqAodrUYzFMgYuCcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnxr41f3+dMagwpAdAub3GP+mjHPpH3CwJN7cipFoBA0KQauDVOKBCZxiafKZiUEszzyw3wkpQLYYiJX+NJJM/LABJ3+QkIJzGnrS91rYgiEuvZIiCfhBxqpQPIrcsW9xkP6pxR92Druf3EFTlYh6SzSl5TRQcx7DqF9hJtWISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HL2TqXP3; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8ca2e53c0d3so12459739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758741274; x=1759346074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Nd+DKJZTe3XmkBYj9enRckjCcI4kpUCuGO+uMkJQh4=;
        b=HL2TqXP3PxVUYrV5bVIPrxnsEE+YVn1sfuVnH0AS+EQlCaKDgd5RX8J+c8KntsyyZK
         2iN942iqnmSjG2wrTOQMyljC239CQ/9ddI1SNPqga4RHM8y6OcnZyfSlUNaA2K8+ul8t
         6qLb2/6MxgQpwofGuKarFixVYlaj2xVmlUy/9y+bRNK4iRSUqeuWrO4pTnuHmgf/KT/2
         4DvwAubo5LmxiyUfhKffmdmLC2/xTb5aJH1nIK+uMp2VJ/wIRbf2oPR+lUQNOJL0seul
         RS/XTjPh70C/oVTfsuUuAGc90lGctUtioIOE+ZoLF8tj8Es13OLGNXIDEfhGBuc4MKbo
         trFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758741274; x=1759346074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Nd+DKJZTe3XmkBYj9enRckjCcI4kpUCuGO+uMkJQh4=;
        b=KvwhyUZUp6fSnXgiRvJphU+Kd6yC0OlZ/7+uXPpORJaE3Y7NUla2e6Ls9WQtL8DnQx
         6uCNiTzEbO3EciYfP3m3bBn9eKR6PQSOfpUV7ScUHwGX7Gb6HplqwOMeSRyZFvzKjBBW
         a2MUvZo4tGwXF0GpvPBnnJrG2nLbsfBRTWnQdlvyREzpCjOsw51vuVHldF3YFHdQc0lv
         IOBRzza/J8eoH05J2aiYljKSEZPRotJDbYqY39OybAUNRhQa9xWTHQ7vAm3nigVDC5e0
         r31CqZdYUzpubjQC+baFyBU9oqc9w+C69FiVhHfIorKKSVC8X29RYMN8KO62z86fG+Ao
         06Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVRZ/jJis2a4sJa5M0Re+VKfU/awsM98iwipLV69IGtnww0b+vDBOk1jD0nOSMbcnR79V+RCheyhB8nYe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAObmtrdDd3NHm53pXFU/99zEtOeaRnRFS14etMsC5bZ6x/wRq
	jCm9esp3f10XUkiQTsXYd8J1UAqAugvxfmhjoGUH/HU8b9Vt5sE7QoM0ss+aNvmW/jc=
X-Gm-Gg: ASbGnct4ZtX3ip/l/kwnJCwXPBOi1xZJwxd70lRP/G7xOQGi5gKY2/WnNH/cHopbPvC
	JC5AAjHvjNeew9fHQjhQzk8c5fZ8ShAPUy8jcTaOTMJJ5VB2BBCB72FtSZY8bIStDr2GO5bcQwZ
	g+LbYs9yqCXZvcyN7yR4LNYRCxP3ESgn+sOFk7Y7jyYLfn90PEBt1jteBG/u4GguOZPwx4QSKKV
	CPYFyx77RsOoBb6yEToAlg+KhtsoDotP177mpX++qJHDvIeT3AfwnxUsH0ONdUyx/uGjddzo1BL
	GWPsnYd+ZAhykrwWCjS6BH9IFn0nGVGaKddLdQo33SWDR9fctWNMILUJc4CHbaXvrcism0hOXlK
	Q1MBSshqpkiCvfSs34wMzfH36
X-Google-Smtp-Source: AGHT+IE8j5KYhi3s3Fl3nePo4cG2h6YA9lTgwUwfMOBBlO+umYeSjsVMSefHFKLReHBV2ObV3vdJcQ==
X-Received: by 2002:a05:6602:1d4e:b0:8a6:e722:a9e8 with SMTP id ca18e2360f4ac-901540c745amr111897939f.6.1758741274424;
        Wed, 24 Sep 2025 12:14:34 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f3405sm671174739f.1.2025.09.24.12.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:14:33 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:14:32 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zihongyao@outlook.com, zhangyin2018@iscas.ac.cn, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v1 0/2] riscv: hwprobe: add Zicbop support
Message-ID: <20250924-b6258c49a33a07d027bdc04b@orel>
References: <20250911121219.20243-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911121219.20243-1-zihong.plct@isrc.iscas.ac.cn>

On Thu, Sep 11, 2025 at 08:12:07PM +0800, Yao Zihong wrote:
> Add UAPI and kernel plumbing to expose the Zicbop extension presence
> and its block size through sys_hwprobe(). The interface mirrors
> Zicbom/Zicboz.

Yes, the changes to add Zicbop support should closely resemble those
of Zicbom/Zicboz. So I suggest you grep / git-blame, etc. one or both of
those extensions in order to read how they were done.

With a quick look at this series I can see several changes are missing,
such as

 - an update to the documentation, Documentation/arch/riscv/hwprobe.rst
 - a bump to RISCV_HWPROBE_MAX_KEY (as the comment below the change
   this patch makes says to do)
 - test(s) added to tools/testing/selftests/riscv/hwprobe/cbo.c

Thanks,
drew

> This allows userspace to safely discover and optimize
> for Zicbop when available.
> 
> Yao Zihong (2):
>   uapi: riscv: hwprobe: add Zicbop extension bit and block-size key
>   riscv: hwprobe: report Zicbop presence and block size
> 
>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>  arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> -- 
> 2.47.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

