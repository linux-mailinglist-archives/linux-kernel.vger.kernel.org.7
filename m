Return-Path: <linux-kernel+bounces-817194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5BB57F18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C2B3ABC76
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C967A314A8E;
	Mon, 15 Sep 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbLQnzu+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCDD1EC01B;
	Mon, 15 Sep 2025 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946844; cv=none; b=UjFmqsqsqZMJvckyM5MqfYaalk3raF1naTFrHZ+cmmJUqfvvVzvZCsiGwduEwX3MZVRysovNhSIkfej6N9znt2d2l2yzdVU2kPxk5Emm8Kawc5rUu0eEr/JUEUmKf5roAc+UDa2RDb1OrmIh6HiXNN1jPXCOZ11xjSXR8SbFUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946844; c=relaxed/simple;
	bh=fsfvV3a6AcqE3++NGqxPdPfX1FVKL1EvX/8V2gTUsnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NwUD0E5CB6wmvB7/ScG9wlfQR/u72OPzNYteWOhxHEJWRziK5aPfGuT6vGa7R8hKeitcd67eGG66RL16nw6dnyMo83ptMiZCipzF3npf0wz+FJZlPHN35sAd+DpOYF+m90vt3RonpQbee/Dw2RMPfZpuU+cbf5CqDReOhi58uvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbLQnzu+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757946842; x=1789482842;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fsfvV3a6AcqE3++NGqxPdPfX1FVKL1EvX/8V2gTUsnE=;
  b=fbLQnzu+Nh4QIH/88++dbueVDU8C5GWJZWhh+PSOTPa0XIAK+E1BO9mV
   dELc4MrVJMo7+UgP6/57s81yz7rro1840hmUEqyrzgJx48sFmGlMd5LXK
   rPR8Il9rVBCfxugSYP4iwB5f/rl/wkPnQYw0RqIiYHsGSYWkiLSDBjy3Y
   R1izrG/YOcgy122vDdV6aTARPSsE8XO56UQ6acAu1FLwD2p79MYKuDu6s
   FF89cHtNQyA8XOiNvhRUfzAVyb7yTOJ5fj0yaWfPS1RRg4TAaWG3dmSwv
   K/oBxr2Z0YD1dcYoafTfLCHoxZi+QIIUYkIqE8LNaeDLcdEq9VetPG8iS
   w==;
X-CSE-ConnectionGUID: N6Zr11YhR+20pe7x98f/Bw==
X-CSE-MsgGUID: R3LoWVP/REq3Y/aR6soyvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60136643"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60136643"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:33:43 -0700
X-CSE-ConnectionGUID: 2702LH7DStWgLxyqwlB0Dw==
X-CSE-MsgGUID: uTaPSgapQp2Z1nYQ2jnpIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="173964314"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.17])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:33:40 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <s5gyu27qlfg7frb4v3ssqms6inqammtakwchgl635r3ahooj5n@vhw5tnyti7nd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250910153334.0b3e1440@foz.lan>
 <28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
 <20250912130420.6c14dbbd@foz.lan>
 <f3d142be-3980-4d4e-9d66-c03276694bf9@gmail.com>
 <6hhhn5go2yb7ecdrqtuti23i6pfgckqbdk5nhuhn2ijrhmvvmw@awswbm3tvmwp>
 <aa2aa8d2-f7f1-4f04-a9b0-f08160f9ea81@gmail.com>
 <20250915125805.25b48d09@foz.lan>
 <803501857ad28fc9635c84b7db08250dc4b9a451@intel.com>
 <s5gyu27qlfg7frb4v3ssqms6inqammtakwchgl635r3ahooj5n@vhw5tnyti7nd>
Date: Mon, 15 Sep 2025 17:33:37 +0300
Message-ID: <750e7225a88b7eb81c8f084477ebad66734c4dd7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 15 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> On Mon, Sep 15, 2025 at 03:54:26PM +0300, Jani Nikula wrote:
>> On Mon, 15 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>> > IMHO, long term solution is to change SPHINXDIRS into something
>> > like:
>> >
>> > 	make O=doc_build SPHINXTITLE="Media docs" SPHINXDIRS="admin-guide/media userspace-api/media driver-api/media/"
>> >
>> > would create something similar to this(*):
>> >
>> > 	doc_build/sphindirs/
>> > 		|
>> > 		+--> index.rst
>> > 		+--> admin-guide -> {srcdir}/Documentation/admin-guide/media/
>> > 		+--> usespace-api -> {srcdir}/Documentation/admin-guide/media/
>> > 		\--> driver-api -> {srcdir}/Documentation/admin-guide/media/
>> 
>> So you're basically suggesting the documentation build should support
>> cherry-picking parts of the documentation with categories different from
>> what the upstream documentation has? 
>
> No. I'm saying that, if we want to have a single build process
> for multiple sphinxdirs, that sounds to be the better way to do it
> to override sphinx-build limitation of having single source directory.
>
> The advantages is that:
>     - brings more performance, as a single build would be enough;
>     - cross-references between them will be properly solved.
>
> The disadvantages are:
>     - it would very likely need to create copies (or hard symlinks)
>       at the build dir, which may reduce performance;
>     - yet-another-hack;
>     - increased build complexity.
>
> I'm not convinced myself about doing it or not. I didn't like when
> I had to do that after the media book was split on 3 books. If one thinks
> that having for loops to build targets is a problem, we need a separate
> discussion about how to avoid it. Also, this is outside of the scope of
> this series.

I honestly don't even understand what you're saying above, and how it
contradicts with what I said about cherry-picking the documentation to
build.

>
> -
>
> Another alternative to achieve such goal of not needing a loop at Sphinx
> to handle multiple books in parallel would be to submit a patch for 
> Sphinx to get rid of the current limitation of having a single book
> with everything on a single directory. Sphinx has already hacks for it
> with "latex_documents", "man_pages", "texinfo_documents" conf.py variables
> that are specific for non-html builders.
>
> Still, when such variables are used, a post-sphinx-build logic with a
> per-output-file loop is needed.
>
>> I.e. even if we figured out how to
>> do intersphinx books, you'd want to grab parts from them and turn them
>> into something else?
>
> Either doing it or not, intersphinx is intestesting. 
>
>> Ugh.
>> 
>> 
>> BR,
>> Jani.
>> 
>> 
>> -- 
>> Jani Nikula, Intel

-- 
Jani Nikula, Intel

