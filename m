Return-Path: <linux-kernel+bounces-840166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F4DBB3B99
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58173BC7C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138BC30F959;
	Thu,  2 Oct 2025 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsWFaxKs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7625BEF1;
	Thu,  2 Oct 2025 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403949; cv=none; b=sUb29amLy5bf1akF6AlUzZwU6FXtwUw0e/wJixd4RfilCaXDDkMHg4KhTrBM4kfm3DVdHxSumTtFWamRtNh2cf4+Ov+UG/OPi90vati9b2+VCZ+WpC/7Nm16m+tTtB+FS4tl6N6eA0ekh4WaC2AxcPX9Lms5ynWmsdGoH20oFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403949; c=relaxed/simple;
	bh=JLPcxN3JtTl6gmq6LR2qB4Za7xEDYPFiEZZwgoMPYB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWfNQBoJs7dI7Iebn7Mu3vO4PV+YeJEQml6CNvXBx0/I3lg3/dCIYEa2arOnGny+yDrmbM4Hi5T0WK5+RcQHPaqcAu6LbSDUDnJ2+jtDAydCWeYRQIZbVXYtVdA8kd1GSLgh6vZYkFlpIPtURiPS/F1zpRIyUEDBOdXEWeR9P3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsWFaxKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF92EC4CEF4;
	Thu,  2 Oct 2025 11:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759403946;
	bh=JLPcxN3JtTl6gmq6LR2qB4Za7xEDYPFiEZZwgoMPYB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsWFaxKslgnbEkrAgyxUeZZQpwYcra18Rm8vC6uvNUPX43Dw6Ov5IxntaySi1DtdC
	 eC8AmxXNXZnGq/1KXEDMN9IXcIb8dlgQswiiSciEq+9pGKEvQGofhJ7hH2mlBkBYgT
	 yFVA9B9C3UYs355Bb8mFazKmx9WDiRvCEPQvGMgPghFhwttEt+K7R/J0ZOQCPOePkg
	 JElK6D3StBS1Ztxj4qoijZTl+Z0g4yiGVy4ENVpTo5tNZJP4FwkfyJfynOznMgSzR7
	 X2Akkfhmc9jwdPeilvOS5tmH9lya5hrXNIbMP/yOFPHi9tniz8R8Rx34Vx9OW97OYg
	 HHDdi4FOp6PQw==
Date: Thu, 2 Oct 2025 19:19:02 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC] usb: typec: thunderbolt: Fix Thunderbolt adapter
 type bitfield values
Message-ID: <aN5fpicXs-JwKvQo@tzungbi-laptop>
References: <20250926-topic-tbt_header_bit_fix-v1-1-122238af5c82@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-topic-tbt_header_bit_fix-v1-1-122238af5c82@oss.qualcomm.com>

On Fri, Sep 26, 2025 at 02:32:57PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The value has been amended with the release of the USB Type-C
> Specification v2.1, reportedly as an erratum.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> I bundled a change to the CrOS EC driver based on the assumption that
> it worked around the faulty definition. I see the Intel PMC mux driver
> also checks for this bit, but it seems like that driver assumes that
> the value is in-spec (i.e. it may be buggy as of right now).
> 
> Adding the respective maintainers to make sure everyone can see this.

I have no context to review the patch.  However, the prefix of patch title
should be "platform/chrome: cros_ec_typec:".


Hi CHROMEOS EC USB TYPE-C maintainers,

Does the patch make sense to you?

