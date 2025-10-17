Return-Path: <linux-kernel+bounces-857703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECDCBE7C43
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83A26E17CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CE82D8364;
	Fri, 17 Oct 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SMePEHTv"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BB22D7DE4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692799; cv=none; b=U7WOPXUnkMvpDUJaLtLnc4QrZm5BWMrD3ZM2/J25DE6putJa8oeuCym7E3uJ7I6GyzBTwyicVPqRKpopiqtjWVceeX1Hp9b0g3Ym+yaaEpqGzODOHoeaqUXeFCGuOoQqLZuk/MuJSDjT7Gw4FUeUbQiI0J8iVGCQZ2Anlq+V670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692799; c=relaxed/simple;
	bh=FqcMRwFrInYrZOE7KriUyn4LQ40X/JXpvDnENpAmkUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDdDCia1NMYMV141hLJ8YPi453v+ZDrJ8a9qGxM+rS9wWwt0dagUHMQbyxR4bL1SaRWgen5camBJXjxvmjyd5kE4BAK4neTNnDkfI197EUCKZ5ggcEpt8XVcbysH/3SpcYw2T6FrIDysfl7fAdPhhA3FlMKC+BO9iQ+HEY3K8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SMePEHTv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4256866958bso1066133f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760692795; x=1761297595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPMqXFh/dNNEvS2vqa7Ou7b74ZgoKM83pdwBrATLUys=;
        b=SMePEHTvunCKbWEKwaNaiqkP5tXix5PM4/iO1BTIYtjDSQbTtdIsrAaBCHEV0byjLa
         SiwBOvU720wVoiGzcs8gtL8S1+IiNM2lOijv5ASLNqj0JDfAIh3u/hLnRTHjuCra4zLD
         a8YjxHQ2by4h+7Pm1XQkuuMUFnguYVBXVAIK+xLouXaehNwU4H070WQ2BFKHW6E61hKM
         dlx/pYN5EJPSf5hlnvDWfeNv+1D55nA2wnms3WvGXSNgeVwuvPBChb3HEVqiacGK+u8t
         U/1XkqfUFcHTaDrDdo9g2dqMkY8nEbZA8DUYQ9957d+T33DlB4KQonwxVXvJXZl/dwYH
         gK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760692795; x=1761297595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPMqXFh/dNNEvS2vqa7Ou7b74ZgoKM83pdwBrATLUys=;
        b=XaUdLq0G0YnzNJDeg4RFYt8t0FpyxkVU7HW4bNWpGVlZsaFQbp2zKsM/sB9gIRD/yX
         TBDDTtRnKgxiir3lovNgFtAejRBcBnoISozlQHlmPWJANwTplO82gJmnOv3XCBbBbgqm
         Oizo3FAImbaPOpSLsEbN3arQL/At3r9tCHbV4OzB2NV7ILNWFGq6jM8EQfDBgnbPS5L6
         WiiLIoiNn4a6Sal0m4CqjhYsynLXoiawwkljFsueNbvcfqUcznsdQLgCIKgyxzlpZkg8
         W+b567FKJ7DT8djDmkjJ15O7kUhamzcgSPyuzXRJn26YiQoP92iIUyWvmXkqKW2tLUkI
         AFgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV23X9EiXFXA+HHP5mtSGe3tcH+HL3TD8B0vl6MTIeIjoBMkCKiMlwsfl615Dt48yaoyplIJ19dq5MhTnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzATklvPcFU9UuyZJscgjnAVj1QZhdz/PgtNqqf6G9sIc9qamYC
	9anyF40FYkholDocoo0cFWJzdHS5XiG85BQ2vtt/LqlayBYonVT7zysSoYIlXK71CVc=
X-Gm-Gg: ASbGncttJLrCuSrLXGSVn/Db+Qdpg8L9F5CQpMsPJjvfkb02B0QJ9kcYGRPTKf0DZ9S
	hD/WTUNjh1i0j1QM7SM1ZVKdYySO2PAhRwUFeDPqyqAthBRNtiwH46yiuCIaorURuopObZu8vqI
	2w6EEwFUSL+MrwmqDqTKuVBtNTVGp3tGZ0kALzocnEsoWsldwP/tVXV4ofn4jlk/9ATXqxkABoz
	2e80j7Kog880Qbft+2DEFDuF/98c0eVmQ2hvMqMx7NnYnNFPd2/4GEJ67OQWAmY6t0vJJmxigVs
	mE79VOj+NRmXVlzZPSlQi2PpJdx+ZS0xSVNCLOX8miQlTYrivpbg//kK6vxKhmBWd37xFRjYRmj
	gmXgC6NKmCHanVZo6hFVAYYbNX2GVAABuw+btSXmfifBPZ5mqvV4Pm8R7t0lZFdmuL9gh2JjV40
	5PeyTGSdFrfxsAKg==
X-Google-Smtp-Source: AGHT+IHdkNU1vaYBqPsplsa4EJzoy/8Ut9krm5VAfFBmljD+VWsSOkiW4JEtZfw1U4XSgBeWnDsD2Q==
X-Received: by 2002:a05:6000:258a:b0:3e9:9f7f:6c36 with SMTP id ffacd0b85a97d-42704ddc6a4mr2107502f8f.54.1760692795387;
        Fri, 17 Oct 2025 02:19:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c29sm73120275e9.12.2025.10.17.02.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:19:54 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:19:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: kernel test robot <lkp@intel.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v6 3/5] printk: nbcon: Allow KDB to acquire the NBCON
 context
Message-ID: <aPIKOOBfOH1cg01F@pathway.suse.cz>
References: <20251016-nbcon-kgdboc-v6-3-866aac60a80e@suse.com>
 <202510170949.NTx9lt0p-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510170949.NTx9lt0p-lkp@intel.com>

On Fri 2025-10-17 09:25:53, kernel test robot wrote:
> Hi Marcos,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 3a8660878839faadb4f1a6dd72c3179c1df56787]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/printk-nbcon-Export-console_is_usable/20251016-225503
> base:   3a8660878839faadb4f1a6dd72c3179c1df56787
> patch link:    https://lore.kernel.org/r/20251016-nbcon-kgdboc-v6-3-866aac60a80e%40suse.com
> patch subject: [PATCH v6 3/5] printk: nbcon: Allow KDB to acquire the NBCON context
> config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20251017/202510170949.NTx9lt0p-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510170949.NTx9lt0p-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510170949.NTx9lt0p-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/kallsyms.c:19:
>    include/linux/kdb.h: In function 'kdb_printf_on_this_cpu':
> >> include/linux/kdb.h:229:63: error: expected ';' before '}' token
>      229 | static inline bool kdb_printf_on_this_cpu(void) { return false };

Great catch! This should be:

	static inline bool kdb_printf_on_this_cpu(void) { return false; }

No need for v7. I could fix it when commtting the change.

BTW: It is interesting that the robot was so quick this time but
     it did not catch it in the earlier versions of the patchset.
     Maybe the robot had a summer vacation as well ;-)

     I am just joking. I know that any resources are limited and
     could not test everything. It is great to have the robot around.

Best Regards,
Petr

