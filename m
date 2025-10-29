Return-Path: <linux-kernel+bounces-875067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB5C181E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DA34010E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7C02ED870;
	Wed, 29 Oct 2025 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2CN8BPn"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FE2ED858
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707037; cv=none; b=ailHknDCGrXgDkqMqGymrijDVVUMHT3czOgsa008ibrpWdCxvVhtBZC90UAVev0J2Jy/qKsRjO4aA0+RB0WMaiRmvm7bg41qX0omAL3KhaXJLRwoqq/0vTYdgfpzyzyIAucg+eRS5M4oYRbRHJFXiWF5wijirABJ+jHHfzk9Wm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707037; c=relaxed/simple;
	bh=/Qk8PMHP4+FapWuHqJbINkiDONl0t8szjkv4nlvTxXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYH3sq41KugOLFNm/a1LCSnFBY58ly8M/0BY35dBzdNrkJ9SOjQOKWiUyKp51/kL1uy2tOuIPdO7zaI1U0hTHASO9dg90CZQSjB0JwlR761HFEgxZQAq+8NTscB7YXj7cZ/6o94NqRo4I3L9r/EZQFkt/SGf5oEyI7Z2Nd3latg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2CN8BPn; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4eb9fa69fb8so55465841cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761707034; x=1762311834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5IcEnHZoC7+7r2CTBEYXEkgFoGQnDrtNgYAFEBdR6Q=;
        b=k2CN8BPnZA5PIAhjCeAcHZI+JZM5bK5bv85xzYnF55BjdvTapbyFuVhnfr/vcUnd/X
         ZgUFH32QVt066a0thd8NpUgAAZMN1risuCUEJ5VsdbEDMp8TKIofZo4PPSH9QfixHd91
         BONbg8y1nPIpKmLY14sTes38+T4LAcT3RmRfT8hDDNGpk4j/MWGN/pzfEVp/Q5vHK/gP
         dNR32vCq+ZtyRG9uftR89Z8MMAQsPohK/iH0pQMTjvVSRmubff+f5+lVrQ/fHXQ6UQ8o
         OGuNwmxplbDUj4kapyK1G3FthOyyB+OySriAwUCT84r/fTOUXyAjcz+387TdqBQhid87
         qMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761707034; x=1762311834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5IcEnHZoC7+7r2CTBEYXEkgFoGQnDrtNgYAFEBdR6Q=;
        b=XVDW8Gjj0W3KPKQ7tjTCbQm2JUA7XRo8GSkBJd25m6GoIbqM0wM0/YwQsm4sMCwqAv
         CoXd9gdCC8SgogQe8mKuZbQBmRdV4fla7N5DRVxkmkaItTvZydP7ZkIcHK5EtC2gsjB8
         VLN/ybTKC8t3fDX03s5EFu6EleVzjeIMpY9/E9sVMAon9xhtQ6Uso9KxETnAmMFOh6oI
         6bGmRqKOkUUCYnrimMorkP9CGOU1f4vDskTEAMX80mA6T0tWaow0nT7GBqEpLFTlxmcf
         rvEJnupmfa4Pi2jjCf4D/9SmQ8LnCduF2t1j+KbWMaED55bYkBI5JBE3Tm4KpGaOWja/
         ge8w==
X-Forwarded-Encrypted: i=1; AJvYcCWQTgsvMAiRFI+j3jBfBAgN6IohX3shfSgMAv0BSwW5tbMObIoaeKzGQGZ/a7US4u6QD9KazEyzwq1ACfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGOKG4zI8JdiwB6PrC0l945FQhndVeNB2lVXSQZLCuwrr8MQo
	H5DpMKw8S+b64GQOUQax3mzp0A3559QEm1IXRLNQUEkjbjDF3M+aGRFa
X-Gm-Gg: ASbGncsDrHmc0D6kNmXwtlKy+pu+TqgElFTGUr2wBjjN1KnN/OBfKnzHBiy24hil1Bo
	ZuYdcxHK55wdjRo37nErjclirO+WSiGtluThkz/ih/pAE/LgUro4Dh8Bu5rKv38wAtF+Xd0dtFK
	KMBZsf+ZT1fP1FsZArcFsChef9AiLn0paNpPXYzP6AAMt5C19JKJ0nm57lMnnbS4qGGR+S0yvvr
	5Lkd+J0hkvqz15uwB2Ie0ZyXniMxMPeZIYpxatHfuW8D5DZG/QrC9lPM/vNtk+ZAtV4DFRq8W5r
	0DqR7qRQ7W2C5U7LO3FdB+RRoQYAEOKku/adIIUfZx/fmDoNFJdnjV4VgYg1IxN5kThESCx/2jh
	sCr3pQeQ0wtAdNDTUW2Q08mivrDTTEd14q/l+ehxdbFqCcj3C40FMFuD/GKPf5Gl9y69gUv1TfY
	g=
X-Google-Smtp-Source: AGHT+IGn2yY7zgfs78ubfoXvJ06VhUkyVxJ/ldXNh2L/51YFEepFFBNff1jL42/SFQQHpekm3bsxHw==
X-Received: by 2002:a05:622a:1105:b0:4eb:7807:1816 with SMTP id d75a77b69052e-4ed15b5ab08mr18021921cf.35.1761707034388;
        Tue, 28 Oct 2025 20:03:54 -0700 (PDT)
Received: from sam-fedora ([142.182.130.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254a6461sm1001074485a.30.2025.10.28.20.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 20:03:53 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:03:50 -0400
From: Samuel Kayode <samkay014@gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	Samuel Kayode <samkay014@gmail.com>,
	Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Sean Nyekjaer <sean@geanix.com>,
	Lee Jones <lee@kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: next-20251027: s390: pf1550-onkey.c:154:12: error:
 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
Message-ID: <aQGEFr9aXB69_Eei@sam-fedora>
References: <CA+G9fYsL+w_XaOPaBaN5xMr6Ssrq_hh2_g8AgNxNmu0jCpjwxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsL+w_XaOPaBaN5xMr6Ssrq_hh2_g8AgNxNmu0jCpjwxg@mail.gmail.com>

Hi,

fix is at
https://lore.kernel.org/r/20251028-pf1550-v1-1-c50fae56b9b1@gmail.com

Thanks for reporting
Sam

On Mon, Oct 27, 2025 at 02:26:37PM +0530, Naresh Kamboju wrote:
> The following S390 allyesconfig build regressions noticed on the
> Linux next-20251027 tag with gcc-14.
> 
> * S390, build
>   - gcc-14-allyesconfig
> 
> First seen on next-20251027
> Good: next-20251024
> Bad: next-20251027
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> Build regression: next-20251027: pf1550-onkey.c:154:12: error:
> 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build error
> drivers/input/misc/pf1550-onkey.c:154:12: error: 'pf1550_onkey_resume'
> defined but not used [-Werror=unused-function]
>   154 | static int pf1550_onkey_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~
> drivers/input/misc/pf1550-onkey.c:133:12: error:
> 'pf1550_onkey_suspend' defined but not used [-Werror=unused-function]
>   133 | static int pf1550_onkey_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [/builds/linux/scripts/Makefile.build:287:
> drivers/input/misc/pf1550-onkey.o] Error 1
> 
> 
> ## Source
> * Kernel version: 6.18.0-rc2-next-20251027
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20251027
> * Git commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
> * Architectures: S390
> * Toolchains: gcc-14
> * Kconfigs: allyesconfig
> 
> ## Build
> * Test log:  https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/build.log
> * Test details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20251027/log-parser-build-kernel/gcc-compiler-_drivers_input_misc_pf-onkey_c_error_pf_onkey_resume_defined_but_not_used/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/config
> 
> --
> Linaro LKFT

