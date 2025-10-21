Return-Path: <linux-kernel+bounces-863824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC5FBF9316
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A996A4ED2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D0C2BE053;
	Tue, 21 Oct 2025 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft4MRMs1"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66928506A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088581; cv=none; b=enjesgDmL7fXCGdnTq8bQ08EAa3W4H/Q7fbP1iUV+NKnn94gC+UuD+0w7mr8odpjCBqd6WbXpPmTXWh/gthw+1za6LCuvVBxAQRHLILFgafkXOs3LyCPbVg+dA4PTw72AsbioEd7/TLJCaBIXj6z4qvAFaHClwyHAiZ2fVfgNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088581; c=relaxed/simple;
	bh=MkrCXOKD8Uo8t+/oSxngnI6HGdowLk7sk5mgxdJXK2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=prcUWh9PfS/+m5nYXIIfaJqIPJSNvEu3B4twwsIQ6L7rtpi7PFEJtu25dYn0rhfz3pnzB8Iw+O+PIDZtz0SAcWAs/oCTYVkeJRdVAuopkep15CcHBMVgbye2MvM0BqeOv6qnIUBmD+LizKR4zmfLoEUNJAtLlzGz+Bv0Zw2jPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft4MRMs1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36a6a39752bso62018811fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761088577; x=1761693377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3iS90oGUh2sChEA1Qdr/sH9FOKItDj8EpmJAd2/xNI=;
        b=Ft4MRMs1CRt/VtZB7365S+5OjFQ3X19yt34APhWDzMNH0J+8X8dGyOJrZCXu15+h5y
         wcaCWKC8CrSSC2MSDmLpn1GBZSskH6QUCsjNeuLA76d3jxSXj/nRYrD08XKERpeh69tt
         2A+fheMaFzkS1BqQDBGpSXi2U8yRSzh0dioUm6N1mpPj6oMpC6U8ltBMMsFA1Jx2PUYU
         qoo1B7vEs/T/13Whpkgxi04mDs0C75Mu+qczMN5zZyeospktm5lCGxjyBeI67mKS2hQo
         3hKgGPv6pAX+bJht5qptzFz4DSqz3UnpP2WTsseirQEiSn/jVL7krnWWZ07XYtD5KmhS
         cfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761088577; x=1761693377;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3iS90oGUh2sChEA1Qdr/sH9FOKItDj8EpmJAd2/xNI=;
        b=Y9kXVCtwPcaqOvjZC50d1P4lt4Z+olZ2vvPc8oOV79OBvuxP2ahh58lwZNy756zy+U
         nPpF8U3THwkXYoXUP1W9rZ5ZHhV/WabF1pbQnPviMEhgX+YqH1W2I8hf7ATu2S88FxVi
         ON2dmfrFuLVd93t+WvgYeETnKrGgdPnG4BFnkvEaMJSDjYeUONpezK63IitdaXquQEzL
         ZaMTqWtwp5ikqM78d3I9rnI78x449KngULBpR4Npw7ymOV7viRhH54g6wuY/q4VmLYS4
         9PauQDM/7IKpuaBqGAy0ei5tHBfhNpVBzSpC3zrwC/U3A8QBWo0U1/ZZYdX9+YeYpGqJ
         nUVw==
X-Forwarded-Encrypted: i=1; AJvYcCUEWCqk4HbJts3B1tGAGZiQ0k8U8Zt3j+vm0Mp73e4E6DX47NdVC5ewXbgumbdWU/Ykb6jBUhlOvPT79N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZ+pwiZnubMBqiuX+Mj1aSSMNK/wzcSLg8gnq+jdtWCFJOHxt
	DMLE0Y3St66kj6UYoRzi1nYp+doBd7eHFG6QbtGOBWJwQNyXNKLwtseA
X-Gm-Gg: ASbGncvW5kJHQ1NxjNNNLSYhp/4OlfsvGit+iDmTMHduuHnfKOz/FTF/sXcd2an5eKB
	z9clsfmm2KSXqigOxvBREeCKKVKt6nfflITFDAin/Hp2MpnYGVumCIAdnemCaWDehDGa+O3SGsk
	qbJbUN7hMzQrQPZigiP/R9eXYP2HNBkxMMJTg1PV2fIX3u8Z9QtKXRb701TOE7kVGBX7CN2n42O
	E+qLAGe2YDltOIuNpmj9NT7+U5ubJ0dxHJk6EhP2jit/v6cokhaXMYBFaBYZxrJid0+VofcORbv
	5z4NwLn/gcep0MNv/t5mxenB2x+iGJ7GcfAU3NYMoQE4Q3CnvuuUTjrPaCI1dssLtjWKJoUBl0c
	zYIHzaKUHVoV9k7H2w6qwhMMubcvNQ7dJA7tHSiGfb8IifyZF/WdgvrYiE3YDLhRhsTgV1Xbk+3
	gCYLqxgUJ04acvE3ExulaohdfeifE=
X-Google-Smtp-Source: AGHT+IFXQQCdVjndGUlAQt55SyUCqt01O1JPB+Zj0At2Wm92ggmQB/7qIpSekj8luvKqPDpYm3P0Fw==
X-Received: by 2002:a2e:a813:0:b0:372:8f0d:b0bc with SMTP id 38308e7fff4ca-37797833eabmr54004851fa.9.1761088576811;
        Tue, 21 Oct 2025 16:16:16 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a9664a97sm32800741fa.50.2025.10.21.16.16.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Oct 2025 16:16:16 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:16:10 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: yazen.ghannam@amd.com
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux@roeck-us.net, mario.limonciello@amd.com,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251022011610.60d0ba6e.michal.pecio@gmail.com>
In-Reply-To: <20250107222847.3300430-7-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> Currently, the total AMD node count is determined by searching and
> counting CPU/node devices using PCI IDs.
> 
> However, AMD node information is already available through topology
> CPUID/MSRs. The recent topology rework has made this info easier to
> access.
> 
> Replace the node counting code with a simple product of topology info.
> 
> Every node/northbridge is expected to have a 'misc' device. Clear
> everything out if a 'misc' device isn't found on a node.

Hi,

I have a weird/buggy AM3 machine (Asus M4A88TD-M EVO, Phenom 965) where
the kernel believes there are two packages and this assumption fails.

[    0.072051] CPU topo: Max. logical packages:   2
[    0.072052] CPU topo: Max. logical dies:       2
[    0.072052] CPU topo: Max. dies per package:   1
[    0.072057] CPU topo: Max. threads per core:   1
[    0.072058] CPU topo: Num. cores per package:     4
[    0.072059] CPU topo: Num. threads per package:   4

It's currently on v6.12 series and working OK, but I remember trying
v6.15 at one point and finding that EDAC and GART IOMMU were broken
because the NB driver failed to initialize. This fixed it:

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -496,8 +496,8 @@ void __init topology_init_possible_cpus(void)
        total_cpus = allowed;
        set_nr_cpu_ids(allowed);
 
-       cnta = domain_weight(TOPO_PKG_DOMAIN);
-       cntb = domain_weight(TOPO_DIE_DOMAIN);
+       cnta = 1;
+       cntb = 1;
        __max_logical_packages = cnta;
        __max_dies_per_package = 1U << (get_count_order(cntb) - get_count_order(cnta));

It was a few weeks ago and the machine is currently back on v6.12,
but I'm almost sure I tracked it down to this exact code:

> +	amd_northbridges.num = amd_num_nodes();
> [...]
> +		/*
> +		 * Each Northbridge must have a 'misc' device.
> +		 * If not, then uninitialize everything.
> +		 */
> +		if (!node_to_amd_nb(i)->misc) {
> +			amd_northbridges.num = 0;
> +			kfree(nb);
> +			return -ENODEV;
> +		}

Thanks,
Michal

