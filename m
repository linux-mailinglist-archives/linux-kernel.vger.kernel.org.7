Return-Path: <linux-kernel+bounces-804400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB0B47600
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55BC7ACC67
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9282F1FE2;
	Sat,  6 Sep 2025 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JZmDjtiS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69A2F1FE3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757181358; cv=none; b=phxnIb6IY4N1dz5zUTKHqoHC72arx+VwRQuvNMM2VqGNBRpIu9/dyfzQmCAmVww7gAZe581D3B0X0jyRw1TW+35QWFGPw6AuPRnDp+oJEqlp4iB6lrCBGifE6iXhHG7Ul9oH7bXG/tsLWeQVi6nOSLrLP9RR5A8EhK5vzAboIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757181358; c=relaxed/simple;
	bh=kJL5kXNlaR1R4FyAkmV0DrZGhhWPyTOb6hC6cJu4ED0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifh+laYggLcGnAgUTvvNjw+Sf1AsoDabIxxIjo7k17PyENNd9BdW9vkYe5PWtQW4VP9OjrSjHgm8+Tje8I21LeTgxVYaK0lwCSy6TMtca51wNaveX3kz0vOT+r5bh+1Pq4J+kw9DQvHnT8k2JvSGvMK0a4GjSkrNOcEDZV/5buw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JZmDjtiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBB5C4CEE7;
	Sat,  6 Sep 2025 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757181358;
	bh=kJL5kXNlaR1R4FyAkmV0DrZGhhWPyTOb6hC6cJu4ED0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZmDjtiS1zeT7Vg/5BKNg9eBqpadHAfb2PnBpKFdegu4gB4x7I6wUvh2sMr6PPb0K
	 JcyqNItVLfbSI+8AY9dyq0zM6VdDuiXrJAP9l5jxzyhgaD+zF4ouzM2CX+A9rVOJ7e
	 66duMAu3gUkJdl0rqQ+9rUTivunfJciY9+aGT1Cw=
Date: Sat, 6 Sep 2025 19:55:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH v2] driver core: auxiliary bus: Optimize logic of
 auxiliary_match_id()
Message-ID: <2025090630-desecrate-ensnare-ce9b@gregkh>
References: <20250903-fix_auxbus-v2-1-3eae8374fd65@oss.qualcomm.com>
 <DCJ52UB7OIXR.3MS54RJKMI4OK@kernel.org>
 <2159c5bf-1ce3-4fd7-81e3-f458efca8548@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2159c5bf-1ce3-4fd7-81e3-f458efca8548@icloud.com>

On Thu, Sep 04, 2025 at 07:00:37AM +0800, Zijun Hu wrote:
> On 2025/9/3 19:46, Danilo Krummrich wrote:
> >>  static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
> >>  							    const struct auxiliary_device *auxdev)
> >>  {
> >> -	for (; id->name[0]; id++) {
> >> -		const char *p = strrchr(dev_name(&auxdev->dev), '.');
> >> -		int match_size;
> >> +	const char *auxdev_name = dev_name(&auxdev->dev);
> > I feel like this is a bit too ambitious. Using dev_name() directly for the calls
> > below seems more obvious to me.
> > 
> 
> dev_name(&auxdev->dev) which is a inline function appears 3 times in the
> for loop. may be worthy of a new variable
> 
> 
> > Yes, dev_name() contains a branch, but I'm pretty sure the compiler optimizes
> > them away for subsequent calls anyways.
> 
> >From debugging perspective:
> more difficult to debug if more the compiler optimizes.

You aren't debugging stuff like this :)

Anyway, I've taken this, as it is a nice tiny cleanup, thanks.

greg k-h

