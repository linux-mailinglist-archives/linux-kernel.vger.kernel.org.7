Return-Path: <linux-kernel+bounces-805020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169ECB4830E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1993BFDB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40021B196;
	Mon,  8 Sep 2025 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH1nX3ru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FB1946AA;
	Mon,  8 Sep 2025 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757303831; cv=none; b=EmW34kE5jhnGAUu6PE3QfVWcrRS5+m03lNIyVn3oDTWfAkojunTKxHGObabSBRersthAoCJcGlVfAQDu8ivKHwp1l/yg8rfuJT43QSrHBvvB7pJowPpa2bwiiwRQoUteEMeLJJ3kHvya/kt2zZu8/bYuQO1DMmTRu9Ck77azsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757303831; c=relaxed/simple;
	bh=i9+jxlXHHwr6XtwkjqS08DAQOKAY8CAV8kZO53PWBkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecnD8gunniERvhK535TexBfuLK9I65VLqEMV850KRfyygO/u4EJjBtue7co8zlTEeP4BGSJvQO3Q3vAhOPa9omyjQdmzL+OFtjLNg/Jm01vHeJAfU1lCWaX2jBcXZGrHGFhsFDXZ6k1cbvyQsrfbZwiz7/VrUTf+v1aRPChuHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH1nX3ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA9C4CEF8;
	Mon,  8 Sep 2025 03:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757303830;
	bh=i9+jxlXHHwr6XtwkjqS08DAQOKAY8CAV8kZO53PWBkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pH1nX3ruaOph6o/MCPrO6clRVFmJTfJAQAcPTdeQEThyJnLC+jBC8m1rPOxLsopf4
	 cpaY0moZvwzI9GdF8otwVERG7vKsl5Euvncf2wBwabeFdC5Zy2qvGWhaOxl38zHrSR
	 fZ9WVMxpTNtOSL+3XMXTJP5rZiXudmU3/Q+qkpdOpLZ40X/z+5Bjyox859/BxJfOx9
	 NPBiBabcDcESdJ1LsLlJ5WzRL9WBfl7PG6KX7LeLJmUE+XZJVMDjuuQj1QHbK8uWcb
	 bBoerC5K5Bh4JDrk0CPXGli0s9u1ZVIDqln38ZAU07DPc8XssNTdoAY0tRIEs0qKhY
	 dtIR37jCBdrBA==
Date: Mon, 8 Sep 2025 03:57:06 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] platform/chrome: cros_ec_typec: Set
 no_mode_control flag
Message-ID: <aL5UErs3iHMnYGZm@google.com>
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-3-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905142206.4105351-3-akuchynski@chromium.org>

On Fri, Sep 05, 2025 at 02:22:03PM +0000, Andrei Kuchynski wrote:
> This flag specifies that the Embedded Controller (EC) must receive explicit
> approval from the Application Processor (AP) before initiating Type-C
> alternate modes or USB4 mode.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

