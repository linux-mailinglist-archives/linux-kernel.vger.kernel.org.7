Return-Path: <linux-kernel+bounces-817403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E298B581C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFD03A8E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB83261B76;
	Mon, 15 Sep 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5zYmGPZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9AA1D618A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952855; cv=none; b=EUcOKGvTcDFi/YY6EB6+dU8OQEdE+Ai/pQW7v/u9EHBFDXPBfu9mfh1fp8hsPZyZWy5pNBA69lFQQSB1ikF0EoFNxcf3tvc3IKMsfgPAtLfDHPtAWfOTg17CmWidJ8wxxV5v3n4Bfv0VNYYVEwQnes7Jv6Iv3qak/CvrAJnHmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952855; c=relaxed/simple;
	bh=fIl4EQm8X53vLKnGyqeYKDusxTRNzKa1zEs/PJI+TCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpTHGIH7JgOSUw1X7FE/NXv/0nY8AkrhZKk9XkycMW2trQmjJfzCAFEDrBbk+f2EI3ljYSzc40Kq8uoIMWuFB9EFZjUowWbfUbhN6tuRVnjlRsHt0DoBrwr6YvneOfoFt6PYxzCm1F444ksFhA44BUvPi5TMnUq591q4eBIX+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5zYmGPZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757952854; x=1789488854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fIl4EQm8X53vLKnGyqeYKDusxTRNzKa1zEs/PJI+TCg=;
  b=a5zYmGPZEZGPog97y2jrXUVYdXcWPpBI7NaTaxpsZ3tryHNTlzln6FH+
   QYP1YyuH/oCLZYGIDYTQyk+qOaExH+6+dgstU5INR3q18rGH2NxXzNu2q
   53StaGkpFFE08AwMYNZDdG990xRbw00SD0l2CmaNjltuy96bTJjQ5gmbT
   6vDc8iXbkbf5zuh+fnbKiDTn52n3yqtstlNRc1UsKrxLrEMnMlPlYL6i8
   G94rU2bLLAA9G2m1SMpsFuzAFAbxaoDENmHbjKCWF6DWfHbjG6fLBUM72
   CW9vrhQjlUnT0IN52GucUwVY0bkwHclvtUuytloa4Id2opnGy+xGprhAX
   w==;
X-CSE-ConnectionGUID: SxcasgXZQZKtIZ6ZvE61Cg==
X-CSE-MsgGUID: zyFMgDMrRSSjcW9SwSR2KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59258694"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="59258694"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:14:13 -0700
X-CSE-ConnectionGUID: jOgNHchGSa6ClAris+8UYA==
X-CSE-MsgGUID: vEDc43SbTIii3zhOeiOmZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="178984435"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:14:13 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Fushuai Wang <wangfushuai@baidu.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe: Use ERR_CAST instead of ERR_PTR(PTR_ERR(...))
Date: Mon, 15 Sep 2025 09:13:54 -0700
Message-ID: <175795281719.1169271.2201520306552068189.b4-ty@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250914101630.17719-1-wangfushuai@baidu.com>
References: <20250914101630.17719-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 18:16:30 +0800, Fushuai Wang wrote:
> Use ERR_CAST inline function instead of ERR_PTR(PTR_ERR(...)).
> 
> 

Merged to drm-xe-next, thanks!

[1/1] drm/xe: Use ERR_CAST instead of ERR_PTR(PTR_ERR(...))
      commit: 84afb84bcc28b08e6d8a4e36865959d770e2643d

--
Lucas De Marchi


