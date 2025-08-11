Return-Path: <linux-kernel+bounces-762657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA143B2096A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC88620492
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32A2D3A71;
	Mon, 11 Aug 2025 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqAID5uv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F88171D2;
	Mon, 11 Aug 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916949; cv=none; b=b46n5LWHvEcrQTelvD7Gx0yzy8boE2mws7njE2uLv1nCC6SFcoN7Fu744+jGiPU+sUP99rCVkDlGNX0U1OL9GfvTMgJuaHyeuFm9UHSq3qpMNEYh1da4p+ZIY9gCXZj00AHvhz/jZGKF6dJc3oLXo3F2GBDAHr2D+9Ubl/Zdtvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916949; c=relaxed/simple;
	bh=vpcEseEXE2yqxqZWt5zpew9cdQiW2aUBzk2IZ1IhAr0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DEFkDMNFPVfFCFual22AGYsZHWy2PGsuHW81fhV4pB0EvTrGz55Bl81WVMIyzsAtIdmuOT/9IANs0nDXo4jnbofLbJ6S8raXOFbaTw/a75bXiN2icmjAmDhMmMRmo5I83grF+DmC7kn0gOWbUezpIgzjDXgGjcpN8WI33MvZCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqAID5uv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754916948; x=1786452948;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=vpcEseEXE2yqxqZWt5zpew9cdQiW2aUBzk2IZ1IhAr0=;
  b=eqAID5uvvdoL/U9dS6TGWAZn0Z5K65iHg2PPnPM5Ak5hskcKE85/PR/S
   34ejgOMKXBdQOJZy04qf0Fmu+BHvY/hN/tbhHdzqFUsHAJjsAVPgqOK4T
   vuANvGEkXMdP/g7Tj8GAf+gk6gKX4swS3hGnpAhpqqd9R0RXshl2CgG/U
   mBXVUip7n+kPbarEJ3z/GfJarzxCGsQmY+z1M1E4PPb00RTsN2d8eWw4J
   qaCB6BHjemW6lRleu4kemo9mJ2flKhYZBiXsRGDA/EA9iF2MxTRCt+K6z
   6ZotGEWTPGAQe/1VYHw2LBpFOvKUqWXL8RymoMyexu7SzzlDQ0/JI/CWx
   w==;
X-CSE-ConnectionGUID: bpB66zOlTXiBBq7hLiOSCA==
X-CSE-MsgGUID: nobaLv0EQ5qwXna3DcwVxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="44751542"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="44751542"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:55:47 -0700
X-CSE-ConnectionGUID: 201yuLgPS6SLwXHp+3DIiA==
X-CSE-MsgGUID: 3yvM22qVQF2ivYkOluMJwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196750352"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:55:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com, hansg@kernel.org, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250729031631.1644740-1-nichen@iscas.ac.cn>
References: <20250729031631.1644740-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] platform/x86: wmi-capdata01: Remove unneeded semicolon
Message-Id: <175491694061.9765.14025813555640370825.b4-ty@linux.intel.com>
Date: Mon, 11 Aug 2025 15:55:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 29 Jul 2025 11:16:31 +0800, Chen Ni wrote:

> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: wmi-capdata01: Remove unneeded semicolon
      commit: 3bffbe0497f9e3c7d80f22d9d0f60c984d42ab6d

--
 i.


