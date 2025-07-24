Return-Path: <linux-kernel+bounces-743886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A33CB1052F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409147BC3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E2E277CBA;
	Thu, 24 Jul 2025 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWhEQWWT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DF274FEA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347015; cv=none; b=GWQBZSDjKEfV34hPfjy9luPT4qmOY9Rk0DuizAgHyuNqf9cYAnd6jja4gxw/f7+1r0j3uvXdn0vdVBZiDf0CsUXxJLm26xiSvIzyMpIQyBRFOpC0Kc4DBAQVQJiRqI9NawkrLciq0rS3YPSCHJ3SSwy5giJAGvZpBur3dzzHOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347015; c=relaxed/simple;
	bh=N1heBisScPzwwpeBakWl3fC2NJleG26Iq9i2cBbg2mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAHH43jXiXxxH+e6vYDALv6N27k6X+LxVc+U7pn44MAXMH3KIwk3iZom8TAICnVB8Bd6s371thpkTr2+9oqffttd0WkaeEbMWtwKFhnPI5wBB6n5/aqwqi25P8cSiuUHheAYQB8Nsr2W2V9M0BjvdYc8mCNUfNGMLh/lknciXqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWhEQWWT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753347014; x=1784883014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N1heBisScPzwwpeBakWl3fC2NJleG26Iq9i2cBbg2mE=;
  b=GWhEQWWTa4ZDmhWNJHZ4i9b0YJMnGyVODMwNgFAtZIaud5zUKE5XisNK
   qisrOiUCfFv48ryxoe+AGHMTJzQMbeNTRK4fLsJV3Wbf9oq6pgWgZD/G7
   PWW+ujvI/96g5+fibYFo+wDiEs6wfi2VwAN9cgJ683xiRKrWBy0/zKmyP
   boTMAZWxcAsQdXbek4PowtqOC5MvvtFtRnMhy7QzR8bbnIOgcJ9RpjqdS
   8AkdzEHfY1UsK5ZpEmyIPyJ3ROsp+SkHJSPOWpDT1Hhmugcz/GDRzOZ3+
   wF8QarHbgpInvaECnT6xK4D4fSD7y+oD/VdFk1QSq4t9Rpk6SNnxw0eFV
   Q==;
X-CSE-ConnectionGUID: qojOrUtrQzy5o380OOD/nw==
X-CSE-MsgGUID: hprZBspeQwKGS4Q7KGqV1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67082565"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="67082565"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 01:50:14 -0700
X-CSE-ConnectionGUID: 5bqA0Lq6TZqsSOOc/k9Otg==
X-CSE-MsgGUID: v7LXT/36SAmy91vsLc5Z8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="191012243"
Received: from geumanao-mobl3.amr.corp.intel.com (HELO [10.245.86.244]) ([10.245.86.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 01:50:12 -0700
Message-ID: <73d6e78c-a360-40d7-9123-e00d47ee2a7a@linux.intel.com>
Date: Thu, 24 Jul 2025 10:50:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [git pull] drm fixes for 6.16-rc8/final (resend in txt for sure)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9twUCJj4X-2jf0VG5+A2YN9Gk8hjOAhJ2hxq4SdgZfvtMA@mail.gmail.com>
 <CAHk-=wgLQ+EPeV+JzrvkPWt2jeteqwsRkf-X61jjfV8pefgXeg@mail.gmail.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <CAHk-=wgLQ+EPeV+JzrvkPWt2jeteqwsRkf-X61jjfV8pefgXeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/24/2025 3:59 AM, Linus Torvalds wrote:
> On Wed, 23 Jul 2025 at 17:40, Dave Airlie <airlied@gmail.com> wrote:
>>
>> (this time for sure, plain text).
> 
> I knew you could do it! Third time's the charm!
> 
> I hope I don't need to worry about the branch contents as much as I
> apparently need to worry about your email sending capabilities?
> 
>             Linus

Linux is one of the greatest software projects of all time and that's because of the people who build it.

Linus, please don't set this example. Such behavior propagates down and makes the community miserable.

Regards,
Jacek

