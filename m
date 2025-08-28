Return-Path: <linux-kernel+bounces-789893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2205EB39C40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23607B51C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7E230F547;
	Thu, 28 Aug 2025 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hogB8IQ9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407A30F80C;
	Thu, 28 Aug 2025 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382873; cv=none; b=fWH1T6jmm8sHRMB866j5yGTQR3TZZkr841X8oykHVeFusE8DgvwMwM+3i91Bc4qF+pp2OHzOwlQB+u1yToQ1C2Mh892rxVahnE4OphqyFYO3kaHtBzq66UWv8OO7pvyo7AJ2DXWwlsAJN+EmdD9QQkwbhLsNfEBG3cV44Nobxl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382873; c=relaxed/simple;
	bh=dVfK9+pMJ7EkUjaPtokfWa6qmAD6rbranthEQn1A51A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yx7rLEa7nGN8HiWUNq5ZbkkWziBxurwmOVXPHOuFgwiTpZm7aImSFvDaHwiBxn26IYd1CZpQJMcN2t2OAPeIlA1vcQphbwe1JmFJdR9fGG/Wb+5rGGu+F6DGkWrqdj01wmpmdGdQFQ3O1N5eBDLde1EYfmwt/0j4Jnv3sZYp3M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hogB8IQ9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756382872; x=1787918872;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=dVfK9+pMJ7EkUjaPtokfWa6qmAD6rbranthEQn1A51A=;
  b=hogB8IQ9mOTIf8dmRNj3M7PuT9JoXzIAAb6fdYdrlfjNLlanZkOPzdli
   7UCM9H0siVPmzufYSUxvJHx7pE4jHcdPaFcmUWBknljNxWk/W9a1qbORD
   AFn5HVp3/53vqj6n8gTssvjk8SAngk8QYVDL0hbfev5Qs3Tmpcus/fEvx
   7qze05YDpJDR7UWYI8dv5j5w96XpS9O/3yk/waon0lUfsy5FJudCKMLr2
   1/Cas3DPEA83b7AmDI4qWQ/dZY4PhSzUrchWkjSe1BY7/RDCsIfixWMj9
   yGlEluUBL36nZhP9sc57G1Cgq1jchaYOWX60V6RQX5yBaItze0whHuv5g
   w==;
X-CSE-ConnectionGUID: +r9C46BaSdedoJUtepMgyg==
X-CSE-MsgGUID: GaQ+2l5uQEyHVM+gfaLhEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61283484"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61283484"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:07:51 -0700
X-CSE-ConnectionGUID: 7zHYIWnnQ5CI6nH6R8GV8g==
X-CSE-MsgGUID: Xzp8X8qARfumW8SFmSQbbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207245368"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:07:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, Xichao Zhao <zhao.xichao@vivo.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250820085101.395377-1-zhao.xichao@vivo.com>
References: <20250820085101.395377-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] platform/x86: x86-android-tablets: Remove the use of
 dev_err_probe()
Message-Id: <175638286338.13908.15760673728124708968.b4-ty@linux.intel.com>
Date: Thu, 28 Aug 2025 15:07:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 20 Aug 2025 16:51:01 +0800, Xichao Zhao wrote:

> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: x86-android-tablets: Remove the use of dev_err_probe()
      commit: faec01b1a4998f3747f55e394409bdcb541af319

--
 i.


