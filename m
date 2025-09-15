Return-Path: <linux-kernel+bounces-816988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DEAB57BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E044B207C53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00B30BF5C;
	Mon, 15 Sep 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXJOZUGX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8C3090EC;
	Mon, 15 Sep 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940874; cv=none; b=R3+wrsp2iqjVwso+L5KChJgK+yorTr6zvlNjSrIKsOr14gvP5TGA0z0BQC/StA+sOZG0Vui6wstyfxzBqv+weiOqsbaUFjh7qNXts21Xd8mcZOLpbiAUgP5qbOgV3WtmFIypQNyBC7bTgDPpt7GkStDpyM4HGGg2xZwlLUG/zEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940874; c=relaxed/simple;
	bh=QMrqRulBz9o7yVmKVfC3sH8o1Nw5qoOwG55e6D1j5gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ACZ+x3FjSQzfRaEDvuJbstCiz63VK3iTSiYp3CDZKrzhl0gWsuk84X0fatLolkayP2VUiHbJB2ewpyz+OCwE76HRuG8GepWMbb30KWJ+YuvhbmZNu/phiM087vDji+bHvfagERlrdYR3pay7oJ6OtDym2Wj58jjeQ+9HX+Xzo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXJOZUGX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757940872; x=1789476872;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QMrqRulBz9o7yVmKVfC3sH8o1Nw5qoOwG55e6D1j5gI=;
  b=IXJOZUGXcBUk9vDOUX+bgMuCwnTuBiYwT3WMlATwoUR6mUm6n3dp9cGM
   oL+ubYRlIntkp0CYyre3lSJjfPGS/i2IKVhnSlIoMF+dGftRnyMNjyitn
   3QwPQdXR7bFHGL8ek4Y/a7Dbn/H7JontZxK8f+z5plu7y1J123yxD6AKh
   o0HqHB3RzJei81DcMbNBUNw7iznHpntTXPsgTj8+WaDOnP4/akq6lT03A
   glw+x28+pYo9/omK6EsrrvjG80JsUBQPEjntA3LrNhEVh1wtfcXFPfdqB
   qRzLTEUISMI/X2no72AxtLszML5YdhS70fZTSwRDARqVpg1lPcnihgZ8x
   w==;
X-CSE-ConnectionGUID: xL2C2I86SdS4tQeNOyBBTA==
X-CSE-MsgGUID: /6LbdwKdTSW3yze8lnRk1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60127978"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60127978"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 05:54:32 -0700
X-CSE-ConnectionGUID: Cq0mxcsTRom5XHlR7qTzPQ==
X-CSE-MsgGUID: vj9nl9wiTz+1QAQgZ2BTxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="175024850"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 05:54:29 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <20250915125805.25b48d09@foz.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250910153334.0b3e1440@foz.lan>
 <28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
 <20250912130420.6c14dbbd@foz.lan>
 <f3d142be-3980-4d4e-9d66-c03276694bf9@gmail.com>
 <6hhhn5go2yb7ecdrqtuti23i6pfgckqbdk5nhuhn2ijrhmvvmw@awswbm3tvmwp>
 <aa2aa8d2-f7f1-4f04-a9b0-f08160f9ea81@gmail.com>
 <20250915125805.25b48d09@foz.lan>
Date: Mon, 15 Sep 2025 15:54:26 +0300
Message-ID: <803501857ad28fc9635c84b7db08250dc4b9a451@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 15 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> IMHO, long term solution is to change SPHINXDIRS into something
> like:
>
> 	make O=doc_build SPHINXTITLE="Media docs" SPHINXDIRS="admin-guide/media userspace-api/media driver-api/media/"
>
> would create something similar to this(*):
>
> 	doc_build/sphindirs/
> 		|
> 		+--> index.rst
> 		+--> admin-guide -> {srcdir}/Documentation/admin-guide/media/
> 		+--> usespace-api -> {srcdir}/Documentation/admin-guide/media/
> 		\--> driver-api -> {srcdir}/Documentation/admin-guide/media/

So you're basically suggesting the documentation build should support
cherry-picking parts of the documentation with categories different from
what the upstream documentation has? I.e. even if we figured out how to
do intersphinx books, you'd want to grab parts from them and turn them
into something else?

Ugh.


BR,
Jani.


-- 
Jani Nikula, Intel

