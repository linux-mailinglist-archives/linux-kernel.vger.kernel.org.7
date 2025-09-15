Return-Path: <linux-kernel+bounces-816632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80534B5768B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FF2188D8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359F2FC86A;
	Mon, 15 Sep 2025 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpxKzI9C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08C1F5F6;
	Mon, 15 Sep 2025 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932519; cv=none; b=ISvkpklw6eSvSDqsJ5NDkgJHXv9hfkHYiCKJ1bVBr2hb3o//TvAk9st+ZhOcV3dfSS4+fuPJr8Wsyu4dKwAt4+G29bvuD5KsyHrR8HMrTEEDuyuM6n80bztopVMqm5o4hlqbeDUJ/2pEin7o7NrXyMLL3OQXr+nXesJ667LZzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932519; c=relaxed/simple;
	bh=/MPjI/zUoIcYG27E6oC5iuD/D6wLU15O8vIYfKQFP1o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p8IemmCNZA8mZW1s+vvWqb1byW5tJMPZZ+1XrsV7VAmn8Pn3T4i3js2rE4w00hvBh1J8QU2nQYv/7Tv3HHuWk1p+e7NAxtknGr+/ig+GmMOWzQGfESkRgZclX8sdKYFOLU7LhmYaqmB+RIjAJAwc8OYjeZKrK3OzhQNsvslqSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpxKzI9C; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757932518; x=1789468518;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/MPjI/zUoIcYG27E6oC5iuD/D6wLU15O8vIYfKQFP1o=;
  b=dpxKzI9CBxS9rSM2rqPWji6VWOCtzxPu77ClovNdtCHc2tmhQIbF7RTl
   BJQmY/+IzoApEu3YXAYU5JOH/TTMyAYEUDmPAcwdV0ZzYseBxyaKy9Az/
   wgC/c07Iz29nQJQ4W/B8HVrH9K3zgLck5UWL8CEsvPmRlPWfsjoy5u6Wm
   xwToWUdIiN2OhMzRZxpPgJFQDuK59ZnwJiZ+ySY3nyhxG6POUJMrCsmRP
   ctot9pRakDPxn/fqsKNQFRFzyVBI5PhiBCIB6+3bvdPKg/LrqJzFqtYqG
   CjaAgXvJZkgsSrq+YxsqBhfkS1OpdKjkPM4mkuk5KSffeY3iYjDzoSEpA
   A==;
X-CSE-ConnectionGUID: NsGXjZv/QOqHtGU7zJzMzg==
X-CSE-MsgGUID: 089pDJHBS6aYuPlczc5hzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="63815056"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="63815056"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 03:35:15 -0700
X-CSE-ConnectionGUID: c1BiExxOToWDc8KwEh0PRw==
X-CSE-MsgGUID: Cv/TE8bwQaGDMDPGTwgGxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="205366000"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 03:35:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 15 Sep 2025 13:35:07 +0300 (EEST)
To: Akiyoshi Kurita <weibu@redadmin.org>
cc: platform-driver-x86@vger.kernel.org, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, derekjohn.clark@gmail.com, 
    W_Armin@gmx.de, linux-doc@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, corbet@lwn.net
Subject: Re: [PATCH] docs: wmi: lenovo-wmi-gamezone: fix typo in frequency
In-Reply-To: <20250913173754.951858-1-weibu@redadmin.org>
Message-ID: <c8b5c80d-beb0-796b-dc31-7daf4cadcc37@linux.intel.com>
References: <20250913173754.951858-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 14 Sep 2025, Akiyoshi Kurita wrote:

> Fix a spelling mistake in lenovo-wmi-gamezone.rst
> ("freqency" -> "frequency").
> 
> No functional change.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  Documentation/wmi/devices/lenovo-wmi-gamezone.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> index 997263e51a7d..167548929ac2 100644
> --- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> +++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> @@ -153,7 +153,7 @@ data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
>      [WmiDataId(1), read, Description("P-State ID.")] uint32 PStateID;
>      [WmiDataId(2), read, Description("CLOCK ID.")] uint32 ClockID;
>      [WmiDataId(3), read, Description("Default value.")] uint32 defaultvalue;
> -    [WmiDataId(4), read, Description("OC Offset freqency.")] uint32 OCOffsetFreq;
> +    [WmiDataId(4), read, Description("OC Offset frequency")] uint32 OCOffsetFreq;
>      [WmiDataId(5), read, Description("OC Min offset value.")] uint32 OCMinOffset;
>      [WmiDataId(6), read, Description("OC Max offset value.")] uint32 OCMaxOffset;
>      [WmiDataId(7), read, Description("OC Offset Scale.")] uint32 OCOffsetScale;

Hi,

There's a pre-existing patch to this [1] which I'm not very likely to 
apply anyway as the typo is in the original interface and this section is 
not exactly documentation for normal users.

[1] https://patchwork.kernel.org/project/platform-driver-x86/patch/20250817170644.5855-1-rakuram.e96@gmail.com/

-- 
 i.


