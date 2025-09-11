Return-Path: <linux-kernel+bounces-812758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E7B53C52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7970C3BA40D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24B266B6F;
	Thu, 11 Sep 2025 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ukp69uTM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC8262FC2;
	Thu, 11 Sep 2025 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619248; cv=none; b=n6jgtJqlVGQtREr+tGHk+WjbFlwrXcf0xlcNqalk4NOkdb1BT+MMVmGvTQCKJdYgsYapm/aTPAFEIaqXL9pab5E+8sDBSE+Z4CnEsmshThOmAXO8AxDMRO5MLDgsXzrgvCs6EOcnZgEq4V2ec5P61R7NRQPCrDFZO2EQKn5V1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619248; c=relaxed/simple;
	bh=3NyElaORLL200umf0/Wos1L2DClK2fYg7pEpRVfXakM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MnfMJH7rxCyD6pJoay+nClQaJTHxzH5PVRAE1aEb0f86/7/1cWYMdor5Ms/m/tB/xJZ2FyL68ImfR8IJCdzSCNipSKQmhCQ0nujqSAwF4zmFe+qbU3zn1kQnNZu2CEhleUnU6B7uUM0vSX8Y4QFHWWPdQxoRxtuEJLpJhjF7GsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ukp69uTM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757619247; x=1789155247;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3NyElaORLL200umf0/Wos1L2DClK2fYg7pEpRVfXakM=;
  b=Ukp69uTMS8PrVZ/TRq7quiOf/kMS0wlzxMWY093ZUJ0TCm16XMc8ZIXh
   AhcLr1YHkHereazMwSXrHHgK0FSkSsCpYG8ZBD8ghJplbWFJP9LZQVvTB
   taWtKLyQtk7e/tSubGzc1fqKf/2Vc04opGoqWtY5defbCFsgOsuhmd1fG
   6wD5clP+L/IXuDZ4mY26pkMFfVyYJHVRIzrBnyccHjcRxlFVStCADzJpb
   28cRA78RuxvWR4rN3cKQ31EBSfJT1X+WzuoQ9FbC9mG0apXluUgeWV7W8
   4UUXPXJOHCYue3TfEtDK6gjz8I58aPiUxmrIzrjMJsEG7rttAWbDIqP0D
   A==;
X-CSE-ConnectionGUID: SCzbjSP3TYqwtjnxr1qAYw==
X-CSE-MsgGUID: NvjzoskoRlOpe5CQK0RPag==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59907476"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59907476"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:34:06 -0700
X-CSE-ConnectionGUID: qXZHMRNJQQ+0YMAox/yq/g==
X-CSE-MsgGUID: suNI1DCDRaK90NvwqeYIjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="178961993"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.177])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:34:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <87zfb1p0r3.fsf@trenco.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
 <e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
 <20250910145926.453f5441@foz.lan>
 <45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
 <fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
 <87zfb1p0r3.fsf@trenco.lwn.net>
Date: Thu, 11 Sep 2025 22:33:58 +0300
Message-ID: <a1333c717bb5bcea7f7c616cbf8604fa259c3158@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 11 Sep 2025, Jonathan Corbet <corbet@lwn.net> wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>
>> On Thu, Sep 11, 2025 at 01:23:55PM +0300, Jani Nikula wrote:
>>> > 1. SPHINXDIRS. It needs a lot of magic to work, both before running
>>> >    sphinx-build and after (inside conf.py);
>>> 
>>> Makes you wonder if that's the right solution to the original
>>> problem. It was added as a kind of hack, and it stuck.
>>
>> The problem is, IMHO, due to the lack of flexibility of sphinx-build:
>> It should have a way on it to do partial documentation builds.
>
> A couple of times I have looked into using intersphinx, making each book
> into an actually separate book.  The thing I always run into is that
> doing a complete docs build, with working references, would require
> building everything twice.  This is probably worth another attempt one
> of these years...

I think the main factor in that should be whether it makes sense from
overall documentation standpoint, not the technical details.

Having several books might make sense. It might even be helpful in
organizing the documentation by audiences. But having the granularity of
SPHINXDIRS with that would be overkill. And there needs to be a book to
bring them together, and link to the other books, acting as the landing
page.

I believe it should be possible to generate the intersphinx inventory
without generating the full html or pdf documentation. So I don't think
it's actually two complete docs builds. It might speed things up to have
a number of independent documentation builds.

As to the working references, IIUC partial builds with SPHINXDIRS
doesn't get that part right if there are references outside of the
designated dirs, leading to warnings.


BR,
Jani.






-- 
Jani Nikula, Intel

