Return-Path: <linux-kernel+bounces-724873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F9AFF7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7221C25ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DD6281538;
	Thu, 10 Jul 2025 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbOA29bm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2B1FF7D7;
	Thu, 10 Jul 2025 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120371; cv=none; b=kyORaNoQYC6b6iHVbFpCXuN08KMxLbkyzLyDtn/kSUHuuFThUgOEEqM/VkVeKP+6ocOORAoQIUNqD9gJ0SMiUQumw/7yh48sDde0ju4AFGXhpAIQi3r9AjPzSToisxD3MLslXWUvvUXTYKLddVrDXwq5JTLAiqd7Mf8X/vb/cNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120371; c=relaxed/simple;
	bh=GEhee/W5etJB8teEXCNTcbCNe+k0RHsoo/kkwHxnJEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m341eEH/5UVFkmY1t4IuFsnmjVu0CTWz91ombSiWaT97OmEifdOifdTlIeu5O3z8m9oCcdko+hQxfnAyyeREadPssqxHYQw54g3ftJ84Of5MScyut37sGEbV2LZrZHRMDkgOEyVFUv1tgzm9pDLl3EXfqaXIrIyUCvtyO0MKNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbOA29bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AF0C4CEE3;
	Thu, 10 Jul 2025 04:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752120370;
	bh=GEhee/W5etJB8teEXCNTcbCNe+k0RHsoo/kkwHxnJEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbOA29bmp+1DN2LQHs6d8TP1Lf6mDcMFMuSe5mysTbN3DjgqW6/vW3hv1Lm91XVcr
	 xO8uzXwjq+O/IhAzGnZF82YWTMW3DHcY/rWCf6lDvWIbOTRvKGtTJBGfPSOKVGTVxH
	 /vzaKh8tqmX9W1QyFV0nuHcoPLHtsa7VaIH/WOK3C50SNXYURX6aPL0xBqOakWzT4X
	 d5CtD8OEO0uJ2iXOPU81qlItsevu4ad/ts3OgSGyrr+QPAXu/ZIksH67sKJRFCjAr1
	 J+VX4QP2Wq6jyqEra/tZ22AblNsxIa2ekS4RuNL7462+BlBHZMZbgPvD4I4uzz+xn+
	 MShIQAqPspjtw==
Date: Thu, 10 Jul 2025 04:06:07 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Radu Vele <raduvele@google.com>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] platform/chrome: cros_ec_typec: Add role swap ops
Message-ID: <aG88L7QXa5IU7zPE@google.com>
References: <20250709132232.2475172-1-raduvele@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709132232.2475172-1-raduvele@google.com>

On Wed, Jul 09, 2025 at 01:22:31PM +0000, Radu Vele wrote:
> +static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_role, u8 swap_type)
> +{
> [...]
> +	switch (swap_type) {
> +	case USB_PD_CTRL_SWAP_DATA:
> +		role = (resp.role & PD_CTRL_RESP_ROLE_DATA) ? TYPEC_HOST :
> +						TYPEC_DEVICE;
> +		break;
> +	case USB_PD_CTRL_SWAP_POWER:
> +		role = (resp.role & PD_CTRL_RESP_ROLE_POWER) ? TYPEC_SOURCE :
> +						TYPEC_SINK;
> +		break;
> +	default:
> +		dev_warn(data->dev, "Unsupported role swap type %d", swap_type);

Append a newline at the end of message?

> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (role == target_role)
> +		return 0;
> +
> +	req.swap = swap_type;
> +	ret = cros_ec_cmd(data->ec, data->pd_ctrl_ver, EC_CMD_USB_PD_CONTROL,
> +				&req, sizeof(req), &resp, sizeof(resp));
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (swap_type) {
> +	case USB_PD_CTRL_SWAP_DATA:
> +		typec_set_data_role(tc_port, resp.role & PD_CTRL_RESP_ROLE_DATA ?
> +									TYPEC_HOST :
> +									TYPEC_DEVICE);

To improve the readability a bit, how about re-use `role` variable here:

        role = resp.role & ... ? ... : ...;

Also I'm wondering doesn't it need to assert
(resp.role & ... ? ... : ...) == target_role here?  Otherwise, could it just
use `target_role` as the parameter for typec_set_data_role()?


> +		break;
> +	case USB_PD_CTRL_SWAP_POWER:
> +		typec_set_pwr_role(tc_port, resp.role & PD_CTRL_RESP_ROLE_POWER ?
> +									TYPEC_SOURCE :
> +									TYPEC_SINK);

Similar here.

> +		break;
> +	}

It already checks in previous code block.  Not sure if some checkers would
find the swtich-case block doesn't have a default clause.  How about still
add a default case, and have a comment to remind that should never execute?

>  static const struct typec_operations cros_typec_usb_mode_ops = {
> -	.enter_usb_mode = cros_typec_enter_usb_mode
> +	.enter_usb_mode = cros_typec_enter_usb_mode,
> +	.dr_set = cros_typec_dr_swap,
> +	.pr_set = cros_typec_pr_swap

Leave a comma "," at the end of line?

