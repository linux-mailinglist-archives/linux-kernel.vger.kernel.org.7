Return-Path: <linux-kernel+bounces-836928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F0ABAAE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BC4189F582
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442D1CAA79;
	Tue, 30 Sep 2025 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irqNKXva"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A1E54654
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196615; cv=none; b=rNyGWAhYsJ7EnhpNKx+Xv/7F08cBm/zFrsBi7tgLwPKrJzmZJ2NmT9EwAgMLaFwCOa0rkoT2zBx+zJLPZVKB9wRsWnbbV+3LlNtMN7Nc2U8nrAQLYxo7V3C/7dqj2axjUEpOqCZ7YahbTQtBxEwXKCAgTAzYbXccE4Iy8lnSaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196615; c=relaxed/simple;
	bh=DTorAp3zyPLmIPg+KmaGy4kzgcVrqDM4JSHj0aXUxrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eb0soavxavxaTfWGX8xceOhwHav99kv75R0UVHALFCYHmoygHlo5XboJ9Kn4WhRdOS8fZ/myNbCU1uZoKRuqxdPYuF/FU4uWFj0rZwYP2urR2TzkKZeFzE/nbHyQPQ+oyININzFsOgoia+AV3AOUE2HJBmEiFQlyDx9LAgGagNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irqNKXva; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759196612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMEfbiGrDUhBhSnctUT3sllOQEghRoOXSbFlwGjhCao=;
	b=irqNKXvaLUteUJlOUnjevpvCZ83XnEySD6hXsHFJF05eX+Y+8DZ89z4mBn2MGFuwvlgZZ4
	46dp9TBTG8OADTrcARndyLmVUtg8ieQY1DtzIrCtydlmNPDdqPN74xjd4it8U/gyaiiNab
	3gqoVI+ud+f7XB/BbU0QU24eq0N4WcU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-6yKPL4oGNL2H5feaJWiEwA-1; Mon, 29 Sep 2025 21:43:30 -0400
X-MC-Unique: 6yKPL4oGNL2H5feaJWiEwA-1
X-Mimecast-MFC-AGG-ID: 6yKPL4oGNL2H5feaJWiEwA_1759196610
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269939bfccbso63224145ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759196609; x=1759801409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMEfbiGrDUhBhSnctUT3sllOQEghRoOXSbFlwGjhCao=;
        b=FYlAX4KtxtrZRmNRtA7DyHJqlIIZgTJI0Rzwj4QJy0g9r0u5ruDgJv9tTeJsAttdm/
         jZ8+RNPc741eMp4oQjX18nG63OU+mqkgfoYTZmgnz00HaHImH8tmrgpe+w4SmDpcCSTH
         6bXTblui3Nj0Vrg3bGwHxE2y+0ekn77Afv3tKCQqxkTf8GkObPWL4b/X8DLP84g/hRrN
         M/+rO0lOyQ+nsHKBv63PKoK4S14npxxxkaJd55kbRkX81xWCceLMr65RiKUqnPhQWeE2
         xsE/7jfH8zXoso/M3zLz4hW4E4mndrWKecnbrX0ZSzEEcwmjZkkr4kGlFecDmvsRyqPX
         jaSg==
X-Gm-Message-State: AOJu0Yyj11Lam9encij2pHbnMKyq4Prw6txF5cL3hmJ+EbSHsGtasMDW
	Z1KjDACS5OSCy+AQGoB2vwp3yWhJFXGCQTmLyrBTfXluFjTy3lMqFMEIu9IV0wlMYiAF65MVy43
	Lfm2g4ygo1v1MG8oYV/uNj3ybEdZm/SGr6eRcsr3YS6YHWkpOtAIXk0MdiiGzL6qgA7PeTlnKpV
	qHVkNpfhkQUh96nemLCN4t4Rt6LdRSl5H8cTte1KSV
X-Gm-Gg: ASbGncvYBO1b7wooxFwy2HDfJOqWK9WKpu2/rMik2XexOx23QdOi6vwWLGqdfJBXm3v
	0BpyE3u1dlr8p24InsTBtZgYbIF+P395N0c3zl4HyLudcYUM9gi4xxUZIjtOL/g4aglzUXphpVT
	iK2Co+KCw4tMc21tIf5wXZqYodLwQ=
X-Received: by 2002:a17:903:298f:b0:269:91b2:e9d6 with SMTP id d9443c01a7336-27ed4a6f290mr216964615ad.46.1759196609522;
        Mon, 29 Sep 2025 18:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPM+GtYaRTIXJ4vt33qnyXVsqCytqqyPV8h7dSemgq93KIAQGTRiUmAJPqTCHtdVMgE/LBfRWC7QmieyZdXJA=
X-Received: by 2002:a17:903:298f:b0:269:91b2:e9d6 with SMTP id
 d9443c01a7336-27ed4a6f290mr216964325ad.46.1759196609159; Mon, 29 Sep 2025
 18:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929133602.32462-1-piliu@redhat.com> <aNqZs0zFVtI1ISIA@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aNqZs0zFVtI1ISIA@jlelli-thinkpadt14gen4.remote.csb>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 30 Sep 2025 09:43:18 +0800
X-Gm-Features: AS18NWDmtheXVwVo_lxp0ccxJ084SA0otnXuuzWyfCQF92IMHKqgjbDqCDlNQDw
Message-ID: <CAF+s44SeEdDJGjGdonfSNhv45ydR-CZKWsWyuEa4JUue1jz8QQ@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Juri,

On Mon, Sep 29, 2025 at 10:37=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com>=
 wrote:
>
> Hello!
>
> On 29/09/25 21:36, Pingfan Liu wrote:
> > When testing kexec-reboot on a 144 cpus machine with
> > isolcpus=3Dmanaged_irq,domain,1-71,73-143 in kernel command line, I
> > encounter the following bug:
> >
> > [   97.114759] psci: CPU142 killed (polled 0 ms)
> > [   97.333236] Failed to offline CPU143 - error=3D-16
> > [   97.333246] ------------[ cut here ]------------
> > [   97.342682] kernel BUG at kernel/cpu.c:1569!
> > [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> > [   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_p=
ort cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresigh=
t_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor us=
bnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel cor=
esight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetl=
ink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme n=
vme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_m=
sghandler dm_mirror dm_region_hash dm_log dm_mod
> > [   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not ta=
inted 6.12.0-41.el10.aarch64 #1
>
> Could you please confirm this is still reproducible with plain upstream
> (e5f0a698b34e ("Linux 6.17") as of today)? I just wonder if we might be
> missing some of the recent fixes around SCHED_DEADLINE.
>

I can reproduce this bug with (9087e52ce85e Linux 6.17-rc7). I thought
that the last fix for SCHED_DEADLINE should be (a3a70caf79067
sched/deadline: Fix dl_server behaviour), which is included by -rc7
tag.

Is it good enough or should I have a test against  (e5f0a698b34e ("Linux 6.=
17")

Thanks,

Pingfan


