Return-Path: <linux-kernel+bounces-854050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9197EBDD6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE5DD50180D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3826E153;
	Wed, 15 Oct 2025 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR/r7LPX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C322C3768;
	Wed, 15 Oct 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517103; cv=none; b=buFh59Ht4aqJDSQ7Yau6J9AFJHcYD9XgNi6YZvw8u/MOY2F8CfZFV3XzBwV9gTM6zhG7X0ONzCQO/Bk3IDJIFSHlE8Y45cwHD62YjRiHpcB6EkAn131/0Xk6L5/HX/A0ql5t+PNfeA/QPsCfeK4dbiMLXbYkGgsJm1OAvMdG6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517103; c=relaxed/simple;
	bh=vGOeCv4g5wJUr2d69Swblev+/O+d9MiV6r9slTYVX2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YGYy1/yNEAvPRFeofirdxD5yS3MA7JFY3VA0VFhK8oKYcE7l0TTfB+HjXYZrR3JjsEK6+mAdan02sCON3YojXqhONbGSWa9pdFFWQMgzdS6KYp6BOdM2DZHZYPy2PbL833SQtaF6GWY1CcOdAldbZijQrK13ekTQ5xERtbLqnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AR/r7LPX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760517101; x=1792053101;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=vGOeCv4g5wJUr2d69Swblev+/O+d9MiV6r9slTYVX2w=;
  b=AR/r7LPXTiAeWyJl/6uVjSy6Tq4FGfwADo5xxNyTprlO9jvxS2zEj2Q1
   0S4y6nZ4VHA4Ib5fCGIsV/b3FVQfpNWoH4i7W+yOXuc56r86LEpt2yXU/
   HgCNz6pWt/+rwlfsnopr6iUXqDYHWcZlS9jTn2d26xBVNryk4uJ3tw6P1
   SkGiU5H/k+vAUsEMjabaRuyHotDm0Fs8XU1qvZYxX2SB4K2WAh5q1db1k
   ARSHeFqRjWiFzBd9MTFbTvK4bZYkLZ53D2xxucveyvEdeLLcblIdPArgv
   XCW6UAGhof7aSOpvG3Q48aKpMEwvTVswym1CcSe8MAuZAOXPX9H+7iRnx
   g==;
X-CSE-ConnectionGUID: lLrtS4a3RXutGHAcFWCL0A==
X-CSE-MsgGUID: nlUNKqYKStqkb4EKDQSkLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62578145"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62578145"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:31:41 -0700
X-CSE-ConnectionGUID: ihZ5pECcSn6P1sqshJt/Lw==
X-CSE-MsgGUID: 1PNjbuSHRBy4S3Pz6P7UUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="186123046"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:31:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kernel@vger.kernel.org, Denis Benato <benato.denis96@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>, 
 Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hansg@kernel.org>
In-Reply-To: <20251003184949.1083030-1-benato.denis96@gmail.com>
References: <20251003184949.1083030-1-benato.denis96@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Denis Benato as maintainer for asus
 notebooks
Message-Id: <176051709353.2196.14158204802807967075.b4-ty@linux.intel.com>
Date: Wed, 15 Oct 2025 11:31:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 03 Oct 2025 20:49:49 +0200, Denis Benato wrote:

> Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
> DRIVERS" as suggested by Hans de Goede and Armin Wolf.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] MAINTAINERS: add Denis Benato as maintainer for asus notebooks
      commit: f4f868baf292550acbfc35839213de9da0d9e8ab

--
 i.


