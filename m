Return-Path: <linux-kernel+bounces-814367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012F2B552F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7871D6361C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1DD314A92;
	Fri, 12 Sep 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVK6ClYu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C7427B356;
	Fri, 12 Sep 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690064; cv=none; b=Olcj99INof+fp4YklIsbnRcpRjNYeei5Z6uQUfKsTTJ+aihbrJpLdOYy6e4rj+w2Jg4nRCIT5s+X8wnRtRzgnmxMhBMCrBFm0LxwCjw93bVslmRvG18cmsGLGRHFMtkefJTatnDPKNgB7qNXWMuVMdzvbZurAcLjim5kzHeFrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690064; c=relaxed/simple;
	bh=a9qe+LHbirqabfrM9Gs5eq5bRTpFJpYES9tyi0moB+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cI9HmMFLlSS75gR822OmBPJ+rJoIYjdn6zDfTPTi+tF5NBNcB57vGBa5KHCmx7AuIgTHwCN+7LcWWjdZqzmUaj3ec7Tfz08lJb7H04dSKxrV2wMAZrWL4hqt3gP/62YKiXXpHYpDShbXSrf5nRKZ99ABkrDA21NEXuZwrR5X8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVK6ClYu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757690062; x=1789226062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a9qe+LHbirqabfrM9Gs5eq5bRTpFJpYES9tyi0moB+g=;
  b=mVK6ClYuzTpp6lbJY5Xf7VW0oNWPVn+jgBfpAINl+Q96h/heX5GB/KpI
   46+RCffiD25C+iLH93pF4s+AoztAPaxTxKhk7JrFg/8eyyl7+RoA5fhdJ
   K7wlr9xPsfmEmk0QWSsCOzd46EUdeSKy9Hic4yifrbQcxoQPupOvYjanx
   qmiD8eKqURCbQCR34ZQryvnZHAE2RVjtijATXY2T8GZiUImVSdlBA8kSJ
   mCoviKdOAwxSZqdP/G7EnzgNrYiM4taXaOKwdk6u7TsepXYMH36/GshW2
   zoCUZApCj8U9A5gS07e+Fh5h5oNtuST1aXArn4te6acoY/wC7dvDvDMIa
   g==;
X-CSE-ConnectionGUID: AlgLhk+JT7Sz0VmIWtl/bg==
X-CSE-MsgGUID: uPgCF1kES7i8v6h+J7FcEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="70719826"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="70719826"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:14:22 -0700
X-CSE-ConnectionGUID: 0sOzI8UDR8ijMYgneqEsiw==
X-CSE-MsgGUID: OxMbseyeQzeTAjrjbM7eEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="204980852"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:14:21 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Colin Ian King <colin.i.king@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/xe/guc: Fix spelling mistake "sheduling" -> "scheduling"
Date: Fri, 12 Sep 2025 08:14:05 -0700
Message-ID: <175769001571.553956.3595518895596464821.b4-ty@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912074330.1275279-1-colin.i.king@gmail.com>
References: <20250912074330.1275279-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 08:43:30 +0100, Colin Ian King wrote:
> There is a spelling mistake in a xe_gt_err error message. Fix it.
> 
> 

Merged to drm-xe-next, thanks!

[1/1] drm/xe/guc: Fix spelling mistake "sheduling" -> "scheduling"
      commit: 9e0b0fd5311ef68638abcd05306233b367c6b407

--
Lucas De Marchi

