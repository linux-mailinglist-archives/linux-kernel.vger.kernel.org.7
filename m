Return-Path: <linux-kernel+bounces-836411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8ABA99BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AAD27A6BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755B309DAB;
	Mon, 29 Sep 2025 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNx9+o6P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1230301491
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156667; cv=none; b=T7Mr/a8Hbwtsx+vRDvH5jtfZj+XVTQR4iOHOjo98toUsZmC7HAU/XszZ3uu2NyP4bZEp2YwTkYJ7ITfp/JkyhbTXIAc8ikScDy8f977Mpa+IKR2U2ncn7i+bAwHAj2fXjsRObS3bayXK/iookGjgJoovQkTLcYtXZ3qqbhRAQig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156667; c=relaxed/simple;
	bh=esddbS6upJ6O0yCIyMDKBeGfmR7VvX9IsxbC+mFPlOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw+tCN3hFM8v73/DIKvrbFDFxVImOB3QIAGkWoVpqaS/3igvq3Lh7qr88KI4ai7w2scMuj8UtrOcHJFw7YRQmTo62HHkUp6yFo/u4zTKeGZzDqeX9kT8J9NZ5xyvBklcy5CcUn/ncYrUWXsLrybolCiOAEzkgdXDIGE11+grZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNx9+o6P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759156664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yBBecpTEoV5pJ5fiapVVnG5ykZgxbl+2yoDVI8DqymE=;
	b=eNx9+o6PYtYzalHeDuu+hjza0+xn8b+kT1ijRufIhRAoK/FSsG0i/9/7KBgp2gzojx/6NV
	aSvs/C8CGXAbgJH+QLipd/SDKWJ4CbGuiPW770BTLgqEbijvdnoF3Na38C/wHNYyOQdj4D
	juJBqCAxXtIulXYTHFlcKABcfy8xbuw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-kgQQPkY_Nuu5HR6Hx1nG8w-1; Mon, 29 Sep 2025 10:37:43 -0400
X-MC-Unique: kgQQPkY_Nuu5HR6Hx1nG8w-1
X-Mimecast-MFC-AGG-ID: kgQQPkY_Nuu5HR6Hx1nG8w_1759156662
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e39567579so23569285e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759156662; x=1759761462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBBecpTEoV5pJ5fiapVVnG5ykZgxbl+2yoDVI8DqymE=;
        b=V0Z56UY4b8Jw2+cPkHhCcv8DAJA8ODHLoHFWJUYTC4QkjKjMjfxIv/Hetb+O4bU/Aj
         UszAZukhTkyqVtG7JoUfAoBiEed6QyFJpawPv4z8kR94aDSwtNbtRg5yS55Ytr/3d49b
         AwP3xf/q+kMPXKwafOz14TV8WjEkL2lZwxLVbxuXMW7JR6SZV8BBIWkHv1tv1yNcOvvS
         UOIyPSXur3JmGRpyR+jONtMj0r2Szr5RojX6jE/tf7ySx9D4H/Geh6VtLoujV72jGOM3
         k4rvBDBzNATkQIoUEAW/3MI9b19YG7xgw68MacQFPZEvLFDDM4m/GXHUNkk9fRyFXioa
         E01A==
X-Gm-Message-State: AOJu0Yz5JybJdQvZ0ajUlsxXxEQYxVYWAfmH4rupAesrNsBW4lClDrAD
	0Lma5e8ETqeommbkrDn+FN1JmrtUOgSBQnJqi7NIheHjmjQtsEl/YDdNukpq3Y2Y6GoNXyWJBdj
	p5AfRwcRNoW0wiWxaAzg+nEp4zgQISKMmwN36QMxHw5hYogFu3hoJV7Rc/WAdvHEVvw==
X-Gm-Gg: ASbGncsAkM2k8+egsTSfo5MOAISiOq3ui9zp9ECCFLrm9Nh1svlQsoaSJ6vIi0kYaA/
	jLsaVjyc+n4ESzvXifbtXhwIN9ZvdqfFqAGfwrOes+oKkDmGl+7npCl/l9VfHLTB3rHY92BDeMQ
	Ih3hSWR62VyfXfFpgLcy3k8CTilOvYE0apf5o46oI1KlCcxRzjMzwlwPP/apqCPAnEpjIpv8WkG
	atEVCUwkcroza16BfR4uUcU5Fc5xnSVXz7MF/0nwGE1qdh5cXbeXj/Q2sfxTVD0gxYZHozdjtyj
	Gn5yjK5CFogmBesWWdfxBOHdIfO7QR2TyHCerIsVMe7a4wiOa7NIORlWgtdB6fFZ62bNlcyLiow
	HmLMyj9riDTY8JHbEtGsDuKT9jRU=
X-Received: by 2002:a05:600c:4f89:b0:46e:3d17:b614 with SMTP id 5b1f17b1804b1-46e3d17bafemr116648395e9.6.1759156661946;
        Mon, 29 Sep 2025 07:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxsBCRQ5/5TnAbzje9PMr2H5rsiwZrUy9O5woBTVT6c4bsiOX5IklNeauu8DEiOQv83zAOiA==
X-Received: by 2002:a05:600c:4f89:b0:46e:3d17:b614 with SMTP id 5b1f17b1804b1-46e3d17bafemr116648185e9.6.1759156661526;
        Mon, 29 Sep 2025 07:37:41 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-92-21-193-245.as13285.net. [92.21.193.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab62233sm231205825e9.21.2025.09.29.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:37:41 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:37:39 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
Message-ID: <aNqZs0zFVtI1ISIA@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929133602.32462-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929133602.32462-1-piliu@redhat.com>

Hello!

On 29/09/25 21:36, Pingfan Liu wrote:
> When testing kexec-reboot on a 144 cpus machine with
> isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> encounter the following bug:
> 
> [   97.114759] psci: CPU142 killed (polled 0 ms)
> [   97.333236] Failed to offline CPU143 - error=-16
> [   97.333246] ------------[ cut here ]------------
> [   97.342682] kernel BUG at kernel/cpu.c:1569!
> [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> [   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_port cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresight_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor usbnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel coresight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetlink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme nvme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod
> [   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not tainted 6.12.0-41.el10.aarch64 #1

Could you please confirm this is still reproducible with plain upstream
(e5f0a698b34e ("Linux 6.17") as of today)? I just wonder if we might be
missing some of the recent fixes around SCHED_DEADLINE.

Thanks,
Juri


