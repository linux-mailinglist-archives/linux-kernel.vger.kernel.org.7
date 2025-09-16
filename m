Return-Path: <linux-kernel+bounces-818509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34860B592B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49E8D7B386C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5002BE048;
	Tue, 16 Sep 2025 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMBLXtcq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73529A300;
	Tue, 16 Sep 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016093; cv=none; b=VvZP6vjf+iGpWI+ejRUIX0BcrloKvRMGitlAh+Wf8L21aTY2hSsTuK/RCxSbXQQoThd13AinpB5GthkGrI75kVRSAFKycEknfnYPy7cPmWEXwBkTXlnOkLnWBW6PBTWQJupmwWLkLXwPn4kClbRwJUb5c4xrDuTVp3MJP2yLdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016093; c=relaxed/simple;
	bh=B8Cx0qO06RvS/2GHQQmLFNYAHtCYbkUfAK0mE1aVggU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eozz96udPGs74TL16s3R985TGM2cV+DW9zoeWSFs6VDkJNC0oBYrS7QYRds1faLjvdBZrGdp/IqcswAJ+Gzj2OE42saJJinS5mHYHpozYVmENJrS45ViXmNMB5YvKszVB5WHy5nHUu0zASw+bcTzZR21+f+uFv5S0mPAK63ZC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMBLXtcq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758016091; x=1789552091;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=B8Cx0qO06RvS/2GHQQmLFNYAHtCYbkUfAK0mE1aVggU=;
  b=WMBLXtcqiqXypMktjNuYQ1wJI2NIzpUk62u3Wf4K60NbTEhA2vZ1mmSW
   WLCltr9E8B4iNcbMRRtKJZYS1ffShL2zDbhG8icUPL2SR2g2ZTuQwbNKK
   bgvfMEu4d3Ue1D5odvqVe53M65BqWaLqNL7jH7odT36eTdBK8PRCzRozA
   BClk0pmyUIUFp17CP6702C0yVgQrGhAQAVrUJsaB+/RdedzeEAO0fV6uq
   lppCaTDWRTLWcPYceMsMmt8JxDrSfQT9MMHy/habrbEDNI+HrRZdBCyax
   7a0FG7TM4ObyznWw1nnZOR63Tzb2NKu2aPkiPOmjHaY5f96bWBYfe3JXf
   A==;
X-CSE-ConnectionGUID: 6fFt5eTIRxuNfKYuGEob0w==
X-CSE-MsgGUID: IgCYqN5YTwa3PSOy+ujDDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="64110247"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="64110247"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 02:48:10 -0700
X-CSE-ConnectionGUID: 1KO2ZkczRLSS1bDKFitSHw==
X-CSE-MsgGUID: NApNvrmOT0egzadqPqdR6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="174009514"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 02:48:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: jdelvare@suse.com, linux@roeck-us.net, Hans de Goede <hansg@kernel.org>, 
 Yen-Chi Huang <jesse.huang@portwell.com.tw>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jay.chen@canonical.com
In-Reply-To: <0d73c577-1941-44b4-917e-3aed6f1f664a@portwell.com.tw>
References: <0d73c577-1941-44b4-917e-3aed6f1f664a@portwell.com.tw>
Subject: Re: [PATCH v5] platform/x86: portwell-ec: Add hwmon support for
 voltage and temperature
Message-Id: <175801608254.8108.14924373299044862303.b4-ty@linux.intel.com>
Date: Tue, 16 Sep 2025 12:48:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 10 Sep 2025 11:58:13 +0800, Yen-Chi Huang wrote:

> Integrates voltage and temperature monitoring into the driver via the hwmon
> subsystem, enabling standardized reporting via tools like lm-sensors.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: portwell-ec: Add hwmon support for voltage and temperature
      commit: 8236b4667aca63afcd29620a48a084f6a0eed162

--
 i.


