Return-Path: <linux-kernel+bounces-724875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB0AFF7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E749D5A2828
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153D283680;
	Thu, 10 Jul 2025 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z06xMXiP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3420458A;
	Thu, 10 Jul 2025 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120400; cv=none; b=ZhEaIWemFX/uGFkuKISSqbTx1ec5SRKNIJuPEzv7o4pI8MnXTAlv+baWOIugKASzsNUQ1hZtOe7CPgwbfq9xM7WIPyQ4IrVu6O9wdBIzgiA1GL6JC4iEeINQa3S3LNxm+yELlcY9iKgYyoMEQZ+nSIyrgi0UEYPi9T7kyWi2aUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120400; c=relaxed/simple;
	bh=L4KNzQ/jTQT+ToNu6S5D9d2wnT5UUWfZbYwv35F07z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux5LDTMMfSH5Ln99sh7MKkeGKnssm/g5jlUmnqTldMc5rEIc7xiyxdj6Lv+7WQhg9f2BCZUQ+9+Z3ag3Xt1ugSWU5Pl6gXjNHolMtP5yxpchfagMnPPA3ejFjndevUexE3B9HB+TraiLFIjL1sbJC2lm1DQaKqo8rIMTT/j6Qb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z06xMXiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE70C4CEE3;
	Thu, 10 Jul 2025 04:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752120399;
	bh=L4KNzQ/jTQT+ToNu6S5D9d2wnT5UUWfZbYwv35F07z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z06xMXiPUEH/RrjsCrUy2bRVVPC2U4stPb9XzLxomiwAgOAO9x8uVEal0rB0yujjW
	 eAexI0uyYC58kOLnyuMKzeYlFYDf5HeP4yRPTVAX0ts5nOH5yVAYcKYwgxPZwclqPE
	 7KWtqH/jkYhw1lOttA9/DfzFCRACBG8P7YBVkDGEWqy4qRHWkf6z6UZPjvYSTK3+4k
	 YTj/2et2KO00kALaZqrtwa1pkUW9sRIQOHERxRbSmG0vqIPHAzhONaeoQ2yGfGFeky
	 d1NFd6VuJ0lFFtVH8bRJ3AT7lIELxF0jTp6il3l77N4xC/IgV2FXf9Yn2EdzqpTMzh
	 4Hj43zqWACbtw==
Date: Thu, 10 Jul 2025 04:06:35 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Radu Vele <raduvele@google.com>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] platform/chrome: cros_ec_typec: Add lock per-port
Message-ID: <aG88SyVAdO0txGMi@google.com>
References: <20250709132232.2475172-1-raduvele@google.com>
 <20250709132232.2475172-2-raduvele@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709132232.2475172-2-raduvele@google.com>

On Wed, Jul 09, 2025 at 01:22:32PM +0000, Radu Vele wrote:
> @@ -8,6 +8,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_usbpd_notify.h>

Please consider to include linux/cleanup.h and use guard() to simplify the
patch.

> @@ -54,8 +55,11 @@ static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode m
>  		.mode_to_enter = CROS_EC_ALTMODE_USB4
>  	};
>  
> -	return cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
> +	mutex_lock(&port->lock);
> +	int ret = cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
>  			  &req, sizeof(req), NULL, 0);
> +	mutex_unlock(&port->lock);
> +	return ret;

E.g.:
        guard(mutex)(&port->lock);
        return cros_ec_cmd(...);

>  static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_role, u8 swap_type)
> @@ -70,6 +74,8 @@ static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_r
>  	if (!data->pd_ctrl_ver)
>  		return -EOPNOTSUPP;
>  
> +	mutex_lock(&port->lock);

It can drop all the following diff hunks in the function if using:
        guard(mutex)(&port->lock);

> @@ -1232,6 +1248,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  		return -EINVAL;
>  	}
>  
> +	mutex_lock(&typec->ports[port_num]->lock);

It can drop all the following diff hunks in the function if using:
        guard(mutex)(&typec->ports[port_num]->lock);

