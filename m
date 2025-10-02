Return-Path: <linux-kernel+bounces-840178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F304BB3C10
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED52019C8255
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26702D836D;
	Thu,  2 Oct 2025 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYZgQ48f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10642253F05;
	Thu,  2 Oct 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404749; cv=none; b=bwrbd2fsM99W6uCbrUIDnMBLB7IM/tzd1Mb+tejEXqY+yS7ZBjbSusqx4Tj03jbssAe4SYZWqe7Qfzt7w5CNyE7sK+RX0UTXqf3EMobuajEv5+wGxJ9JCIXLI6P7osVbpzLtaDM2sqm1qP7l3u3L+a20zlJJwBbkFyKe8iDD6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404749; c=relaxed/simple;
	bh=8QI03bAskpC9PpVYF72IFBOR8W41EVSRT2KB8TPgtEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPHJcD63F/1RZ1PNtRrKv0fNA0OA9UJU9SzDStCrVVLvDJJ8AF+PoTKa8saqhOvypM+olXZojvWY2+/cjdLmccNOBkaLm/Gi3oFW3QQJlApKgZoGexbfXc3ywWkhluMLnHBxjb6SKpVjMi5YeWfqk9MATMFpD0cG1Eooj3lRwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYZgQ48f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FAFC4CEF4;
	Thu,  2 Oct 2025 11:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759404748;
	bh=8QI03bAskpC9PpVYF72IFBOR8W41EVSRT2KB8TPgtEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYZgQ48fA/o3rIsmFazJTJnLBCBIqDa4D87m0URs0CmVNDVP+Bh3qExsSr1SadelV
	 fC3VwLR+z/GGeKDeTAQJHs6Snm3Kq4xyR1yYzYTuFSYm1b8aiGrtGuKr6TfFgB2Vi7
	 Wtux6ICwgAGriIYW7HDRDOJdlFB5hoSoDWns2XUizFCzyoQFYG89s3ZisiY6B+dDi+
	 xR9A3ja3XxG0aXlQLfM5mL/Pcy6Hxqy0qWCFrMQeeBlsFQqRaix6bDanpeIHv+OXYv
	 wqxbsKsySyRmTjCwoHwcRcYP4St0Zgqyv7svP3RF5abK7khYY+w3Qn03u1BlalJIPp
	 69RdaZIbZtrbw==
Date: Thu, 2 Oct 2025 19:32:24 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, bleung@chromium.org,
	abhishekpandit@chromium.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform/chrome: cros_usbpd_notify: defer probe when
 parent EC driver isn't ready
Message-ID: <aN5iyOsHILi40AIp@tzungbi-laptop>
References: <20250926202234.3064386-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926202234.3064386-1-jthies@google.com>

On Fri, Sep 26, 2025 at 08:22:34PM +0000, Jameson Thies wrote:
> @@ -15,6 +16,7 @@
>  #define DRV_NAME "cros-usbpd-notify"
>  #define DRV_NAME_PLAT_ACPI "cros-usbpd-notify-acpi"
>  #define ACPI_DRV_NAME "GOOG0003"
> +#define CREC_DRV_NAME "GOOG0004"

What does CREC stand for?

> @@ -114,8 +117,18 @@ static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
>  		/*
>  		 * We continue even for older devices which don't have the
>  		 * correct device heirarchy, namely, GOOG0003 is a child
> -		 * of GOOG0004.
> +		 * of GOOG0004. If GOOG0003 is a child of GOOG0004 and we
> +		 * can't get a pointer to the Chrome EC device, defer the
> +		 * probe function.
>  		 */
> +		parent_fwnode = fwnode_call_ptr_op(dev->fwnode, get_parent);

Does it make more sense to use fwnode_get_parent()?

