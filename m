Return-Path: <linux-kernel+bounces-760607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B241DB1EDBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C084B3BEF2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A01DC98C;
	Fri,  8 Aug 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="UlNdNllt"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D71D7999
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673637; cv=none; b=Iv88/NtXdSRKGaf+Qr8sXyGV7FE0ECS+S57Po+hgv/S1QKm1TwdLgZN1e00SK6FeoPS9OpEFrfUKPwwFHvmq4JgzgtTdYZtkiwXQlqsMEodf9qUCFLllWC4er2dJGJpfjM2bpOruiWaVCEYeOPwF6Bji7+3wJUTcOMNAneiYI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673637; c=relaxed/simple;
	bh=L7wOxLP5SQDKAk63h8Hs7uu+flv14cbBA7KAL5dj+Qg=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=ZVQIsEf8H8REdljsnKrqwl+R8q49RW2nh7xdtfCT1OcbmDV0ohbYZEHsIBGW0nrH7YKQ/zAceRLcTDJGMQ2LmTANADncszqx6Z7k7c6bbEzxqpHT3vEoonPlpTwrLOXm9/igrr3jefCJ6MceYvFkaZaFkWkUvC9HAhiNPj+UkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=UlNdNllt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4233978326so1418365a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1754673635; x=1755278435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+sIPT2LQsT7fRQnm3CcVOzVxzJQUY6AZ7bd9JG+2fg=;
        b=UlNdNllt1+s0b+3YDdO1oaAgrXVdrithhUza4gEZrmfgmJPw/kyVh+AUdOLHwJYmRD
         Bgn5VoKu5qH7KexAviUALfz9UJfEmXeCIgFMUxxpNmEeWafjDQsgvR6XGodINtMr3Ihf
         aWezxyECKvVAXvka+Xia6lJY0/+YYRIZpdctT4BmZmuAAmrN8NYiPdryw3aJKh6EyyNq
         nzGeBHaheYAGYbf3UZ1E6ZoZfp1OskkMRPsW2YccJc/rlimmEflqHpk3TxXdWx+uaxjv
         6wuqXvWwkB9AzfxBWWuc/ykFTJ3RP+jgiLtMaR4+aU/92lTIbCjhrIT/MNrXay5BMjJH
         Iq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754673635; x=1755278435;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+sIPT2LQsT7fRQnm3CcVOzVxzJQUY6AZ7bd9JG+2fg=;
        b=RIGe1+NYradDtOGj6ZOAWesVN/Tg4RGMPOqTdkt32bA/+KDjH6Rzm4pPlIY1e2frIp
         mxpViNpc3/4P1MmfzeDz1daBVWWVDRxWJRE8Le659CMi9RW68kxzhCz9PuMVerSxThrh
         HT18maGfNQ/pdidLO3j8MERwz7U6aDTswZZEfADIZtZLoX/qT1vZPyx2oX/i7bAApnHQ
         A4aHZFRGP6nVDPv3HuTZwJ3KC896q0C8BpoT91Cfe9pUyP4u04oFGvA19gaCeUctnD1U
         d7NMxMXCVPqeh7UZ5QuNF/oIRcqisDLp+xea4p+TIMAEcbFg8hBzxoUiel+EGskDvM+c
         3NDw==
X-Forwarded-Encrypted: i=1; AJvYcCUaD8/Nptd4VxYyVjYP2QCIIm9ysFM9bY1l80SmJhWCmkqv6G+u7RNWDP5XPTqKHPrH6F3nnDfRt3q5PQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRvkVbJ6APTWHoQu/ZqKhlenX0EcKX1devhgrkmc2CMXC8l3t8
	9yOAiLrc68pfB6T1YyLzxBYkyOggOx6vXei573uRofMnr1ZozyxGhW6hZuDceYTqnmc=
X-Gm-Gg: ASbGnctjs27+tycYwkBR8VSDCuGFlc+AS2ol6He9PJKm4jiq+zY761gdpG4bpPadt4v
	YbIWSDojiZ3J9MLEXgbW0q8ogr7fEZ0eUH92n/hwoKzvWTyqxbM99+UkM7EBnoB34C1xsEUzdHA
	73ixTyMfGS377mOpLOIgnxvBAVrOwL9fZRvEKuUXrf0gTly29IF7cjHKX9Hki5qSQXdZEbLZOLt
	EqZbafDv0a25kkRFfkRkHrGzCKdj3t7C6xRPDXKlqDZ/EqaqMqluIL6SCyMm5/cnwAkyJn7idj5
	vC6OSvs2Km6zqx9MDTer1PG/yeFG2FDIT57Xkh3Q5LLofvppXREgAzJ6+J1R1jQzihpFT6TdzDm
	M6Zy6jNMlmGXavkydSt6gt/OORQ==
X-Google-Smtp-Source: AGHT+IHOby8czN77FochlczWuhjS0Bun0416YcI1s2pCN6G+dIQPuN7NDLXCjgwz8vlnPi5aoE3BkQ==
X-Received: by 2002:a17:902:ce91:b0:23f:f96d:7579 with SMTP id d9443c01a7336-242c2206d64mr54001795ad.37.1754673634618;
        Fri, 08 Aug 2025 10:20:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::5:6f48])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1ef48fbsm214671475ad.36.2025.08.08.10.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 10:20:34 -0700 (PDT)
Date: Fri, 08 Aug 2025 10:20:34 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Aug 2025 10:20:29 PDT (-0700)
Subject:     Re: linux-next: manual merge of the mailbox tree with the risc-v tree
In-Reply-To: <20250808114332.63ec1528@canb.auug.org.au>
CC: jassisinghbrar@gmail.com, Paul Walmsley <paul@pwsan.com>,
  apatel@ventanamicro.com, justin.chen@broadcom.com, linux-kernel@vger.kernel.org,
  linux-next@vger.kernel.org, rpathak@ventanamicro.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-2E4BF257-2676-4F2C-ADAF-8758E88AF34B@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 07 Aug 2025 18:43:32 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the mailbox tree got conflicts in:
>
>   drivers/mailbox/Kconfig
>   drivers/mailbox/Makefile
>
> between commit:
>
>   81db83e750ca ("mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver")
>
> from the risc-v tree and commit:
>
>   52436007b862 ("mailbox: Add support for bcm74110")
>
> from the mailbox tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, I think these are all pretty trivial so I was just going to 
point them out to Linus.  That said, I did pick up the RISC-V mailbox 
stuff super late so sorry about that -- Anup had asked me to pick it up 
a month ago, I just forgot.

>
> -- 
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/mailbox/Kconfig
> index aa2c868256d7,02432d4a5ccd..000000000000
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@@ -350,15 -359,14 +359,25 @@@ config CIX_MBO
>             is unidirectional. Say Y here if you want to use the CIX Mailbox
>             support.
>   
>  +config RISCV_SBI_MPXY_MBOX
>  +	tristate "RISC-V SBI Message Proxy (MPXY) Mailbox"
>  +	depends on RISCV_SBI
>  +	default RISCV
>  +	help
>  +	  Mailbox driver implementation for RISC-V SBI Message Proxy (MPXY)
>  +	  extension. This mailbox driver is used to send messages to the
>  +	  remote processor through the SBI implementation (M-mode firmware
>  +	  or HS-mode hypervisor). Say Y here if you want to have this support.
>  +	  If unsure say N.
>  +
> + config BCM74110_MAILBOX
> + 	tristate "Brcmstb BCM74110 Mailbox"
> + 	depends on ARCH_BRCMSTB || COMPILE_TEST
> + 	default ARCH_BRCMSTB
> + 	help
> + 	  Broadcom STB mailbox driver present starting with brcmstb bcm74110
> + 	  SoCs. The mailbox is a communication channel between the host
> + 	  processor and coprocessor that handles various power management task
> + 	  and more.
> + 
>   endif
> diff --cc drivers/mailbox/Makefile
> index 6659499a50db,98a68f838486..000000000000
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@@ -75,4 -77,4 +77,6 @@@ obj-$(CONFIG_THEAD_TH1520_MBOX)	+= mail
>   
>   obj-$(CONFIG_CIX_MBOX)	+= cix-mailbox.o
>   
>  +obj-$(CONFIG_RISCV_SBI_MPXY_MBOX)	+= riscv-sbi-mpxy-mbox.o
> ++
> + obj-$(CONFIG_BCM74110_MAILBOX)	+= bcm74110-mailbox.o

