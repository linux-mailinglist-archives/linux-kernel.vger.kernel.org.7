Return-Path: <linux-kernel+bounces-845275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A2EBC43CB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE56F19E144A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3432EB853;
	Wed,  8 Oct 2025 10:03:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31521F936;
	Wed,  8 Oct 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917836; cv=none; b=jNNvlzfRvFBEeGBzUfTxdt3t73ez9zqlclgvWUtrDTN4/s/ABPGwi2zppccKLIOnIvF9IcnfLVFJo6agGd4ur4DOzXd+/z1T6Vk77lbgbA0/23AFcqS95jq8V19ijFa33afnmR7ZmRyD8p6sOlydjZ4ZvIGjwi6wCGz+DuEfwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917836; c=relaxed/simple;
	bh=aQJ/0+iGWKDwwnMAakhsdbAuMELNmoe4VBITImDOsvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyO5J5QktXtaRTlpybz/IECO+I84Z3qpIVwO8Kusg/Sqel7JTCeo9o4GKG8BS9fnXm0tPOo5gQteSSDdAP7Ivf2wToUjEKuGPTbcVnDUOOkgOEkTUWcrQDbPN0CsbDlGAl7aOSjC9tkb8y7hf4Z34iGtiPjDjy8luEnBTZ0UDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF09822EE;
	Wed,  8 Oct 2025 03:03:44 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA9413F738;
	Wed,  8 Oct 2025 03:03:51 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:03:43 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: cristian.marussi@arm.com, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com
Subject: Re: [PATCH v3] firmware: arm_scmi: Fix premature
 SCMI_XFER_FLAG_IS_RAW clearing in raw mode
Message-ID: <aOY2_x2Xd_74U8f_@pluto>
References: <aOVGGaY9NmKqUwPG@pluto>
 <20251008091057.1969260-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008091057.1969260-1-a.shimko.dev@gmail.com>

On Wed, Oct 08, 2025 at 12:10:57PM +0300, Artem Shimko wrote:
> The SCMI_XFER_FLAG_IS_RAW flag was being cleared prematurely in
> scmi_xfer_raw_put() before transfer completion was properly acknowledged
> by the raw message handlers.
> 
> Move the SCMI_XFER_FLAG_IS_RAW and SCMI_XFER_FLAG_CHAN_SET flag clearing
> from scmi_xfer_raw_put() to __scmi_xfer_put() to ensure flags remain set
> throughout the entire raw message processing pipeline until the transfer
> returns to the free pool.
> 
> Fixes: 3095a3e25d8f ("firmware: arm_scmi: Add xfer helpers to provide raw access")
> Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Perfect, LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

