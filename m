Return-Path: <linux-kernel+bounces-766633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE72AB24946
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383DB1BC10F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D172FE59D;
	Wed, 13 Aug 2025 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ffRGwOX0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B062EA46D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087229; cv=none; b=oSHmsDx3OlklFn+bXmpllmsYLJ4mIE58ouoyA6X4zRwbvsNpaViFHDhIl7RRWQyxecx6SKVb4wpqdy7lb/jvWjykYgnAo2zcYlfXf16ZFQPxSohEZZxm/kxOSsSILz0Pk0jkR12+S7dMIfrTYVFAADys38uYbs5m+As2y+yA4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087229; c=relaxed/simple;
	bh=YRMUZMdrCI81xQhP38eNlaRhIFU7sGuS/mHAU4lyajc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdD7eMk0yvKFbjcapmnrQ7CmGIWfOTHlUmetAcW76LJC2N275fFWSFxb59aSnrO5XkSJkgbHnJ5WSD493cX6+z/Mh9u7dvb5KplYcZgZhSWZ9i07zLSGVVaNeKL7uoITXzAC29NAol08Nqsn4X7J10jZe0qPDNwqM3WM4/cLQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ffRGwOX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE0CC4CEEB;
	Wed, 13 Aug 2025 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755087228;
	bh=YRMUZMdrCI81xQhP38eNlaRhIFU7sGuS/mHAU4lyajc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffRGwOX0TD4yG5vj6NulVxBtbSeY6X+Bvb+sEgzMZG22pu8ZRpzLgnZ/d6j+08wXM
	 H4lhClcV1AUW6Nk+Szf+irIaKOVkTWkR8z5Q3mTku2AeGFYPiiGAyyWuHtB0kHfWGq
	 UMhdavpW86dCHzkCdvh1/ifFSRZ6gJLHlGrg8bc0=
Date: Wed, 13 Aug 2025 14:13:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Nilawar, Badal" <badal.nilawar@intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
	"Gupta, Anshuman" <anshuman.gupta@intel.com>
Subject: Re: [PATCH 2/9] mei: late_bind: add late binding component driver
Message-ID: <2025081346-shrank-wish-e85d@gregkh>
References: <20250710150831.3018674-11-rodrigo.vivi@intel.com>
 <20250710150831.3018674-13-rodrigo.vivi@intel.com>
 <2025071611-decode-hastiness-df63@gregkh>
 <CY5PR11MB63666310C54B48FB3624D9E0ED56A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2025071603-guide-definite-70e3@gregkh>
 <CY5PR11MB636646E936C800D689BFBEEBED56A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2025071619-sterile-skiing-e64b@gregkh>
 <CY5PR11MB6366AF03A73910CED71C7E37ED5BA@CY5PR11MB6366.namprd11.prod.outlook.com>
 <7aa74159-a9a8-4ca7-9635-a806c57bf7f4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa74159-a9a8-4ca7-9635-a806c57bf7f4@intel.com>

On Wed, Aug 13, 2025 at 03:21:09PM +0530, Nilawar, Badal wrote:
> Hi Greg,

<snip>

For some reason this was in html format :(

Also, please follow the rules that Intel kernel developers must follow,
which means not using me as your first-line of review.  Please work with
your internal developers on this first, before resubmitting.

thanks,

greg k-h

