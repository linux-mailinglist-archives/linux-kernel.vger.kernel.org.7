Return-Path: <linux-kernel+bounces-784107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682F0B336C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F231B7A4E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3DC285CAD;
	Mon, 25 Aug 2025 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F592vUhF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646691F19A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104777; cv=none; b=gf8+KD8yQjMkE6876d6lfLnXhoKLR33jptlwWZVmjXwyQ72jjiPJI4CUDajoeneNyNp3qpb9zobvXG/H7Hpun2LeMEuQFFDaSlaA1l2kltp8jXZ1TEOErAMKKx9RQ9VpPROrnU3Cr/PpgoOUHaZ3kT6fSRNLJgxCm4dKzGUJveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104777; c=relaxed/simple;
	bh=Pw4R0JRwOlo69W0fOMxFrongozeKctpnEVzcC+YMLEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JN2ZNTWSpwW8uuMOjNQWwEMgUZavslQYRCaB0Wrx62MgVf1I187ffXI4LY/2FfEsPhJ6VCgz8Ikwt87vw6EaL7/ByKPNQXiWvWZaUEQUnDZLHYyGyUmMWVklOFVvC6r3lvYzH30YJc85Gu9EaS7EzcN2EKSuzG/RNRsEEpKNp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F592vUhF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756104775; x=1787640775;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Pw4R0JRwOlo69W0fOMxFrongozeKctpnEVzcC+YMLEE=;
  b=F592vUhFwlY5EG1tN/I4UW8wCo1ikRA6cGbC6uKBRKpp0ruk9gkaGZ2b
   NDP9LKlc672jPaih8XGv38wPOVEueiXH7aKU1DbRc89Zc+1zklnfN9F1D
   YcnPFdZ/jfrf+qUzlPa85OzUFZrHEH+vPRJAkflzXkTYkGnjmre43J9pH
   3Vlzz0b3iu1iP59pSPUap5U2gmQls5LO5yUAum9ibfWnttStnUgsV+TjP
   P+Fi1UgHG/NLPEPiF6oHjsNuiYomTZKuYmFN/Ny8Ol/o7+yWbwZbXJnlj
   ylw6q1vNbY5h4pcrriBQeRYuFlggiTkXxCtib1niuTUDaR88VCdxNKxRU
   A==;
X-CSE-ConnectionGUID: Mx8jAqs8Q/uNt92dgMISpw==
X-CSE-MsgGUID: Capog+e7RwSp5DelgGdu1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69682419"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="69682419"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 23:52:55 -0700
X-CSE-ConnectionGUID: F/CmuwEbRs2WnANUvpaGiQ==
X-CSE-MsgGUID: KM07or7OT3yxCBhxmAkgpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169147423"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.15])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 23:52:51 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH v2 0/6] DRM IDR to Xarray conversions
In-Reply-To: <aKiEUlldVf2YazK9@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250821145429.305526-1-sidhartha.kumar@oracle.com>
 <f69669c873dbb99c239e9f2ddf154e983baa61e3@intel.com>
 <e80a3fd9-56ca-40c5-8ac8-237ce14cc79f@oracle.com>
 <aKiEUlldVf2YazK9@casper.infradead.org>
Date: Mon, 25 Aug 2025 09:52:48 +0300
Message-ID: <586cd833db27544321eb9521720803e148519557@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 22 Aug 2025, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Aug 22, 2025 at 10:36:24AM -0400, Sidhartha Kumar wrote:
>> On 8/22/25 8:33 AM, Jani Nikula wrote:
>> > It would be great if the commit messages mentioned whether the
>> > identifiers are expected to remain the same in the conversion.
>> 
>> By identifiers do you mean if the name of the previous idr variable is the
>> same as the XArray variable that is introduced? Sure I can add that in a v3.
>
> I think Jani means that the actual numbers assigned should remain the
> saame after the conversion.

Yes. Do they?

BR,
Jani.


-- 
Jani Nikula, Intel

