Return-Path: <linux-kernel+bounces-749201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1067B14B63
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B76546188
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941672877EF;
	Tue, 29 Jul 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn4eAzuD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17362877D7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781791; cv=none; b=CTNCdIGZIlbFERZUAajgH971oosyeL6qyc3efkP0FOnjJAO8SQxB2a4PGyVMLTQ8CrIjG+u7OszSg9Te6R/YgOT7XERmhw429bjZjtobskvmiR7N6l5okkAmrzFHcCbANbyu8TK4oyiXR05XaB/6yoUQtJnOnHz0wnNVpryfWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781791; c=relaxed/simple;
	bh=SumI6ifV9bN2IONcOom9DaFBJ6Czq1E74gswRu0Vkzo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=TYBBJCi6mS7y72DwT99XR1qPPpbx29ZN+/VwGmC7SFD1bNhS9q5WGHLUZX7F2t+Th5pkQS6HNL5jCJyh8+OuxWTCryvPtRqrtDRlGT1jhMzxfzjwoqiY0m+d/rD9NVCe94l66iEntbtW8WJv8BwAqD1dsj+J4Kt4hIgBbdXR9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qn4eAzuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E562C4CEF5;
	Tue, 29 Jul 2025 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753781790;
	bh=SumI6ifV9bN2IONcOom9DaFBJ6Czq1E74gswRu0Vkzo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qn4eAzuD4R5VU5yT3lxneDPxt8QXKfSOPIHpxkfif9iB7NTVrHktXmGpHWhSOgcC5
	 kTIJLNuGecgysA6kDxiE80qOWDJ6xRE4YXjWD0kdk7zdudAq6VPpM3PiBnHuN0VOY1
	 EMpFjq+OFkv9wmGHaEN5wbJ6jYGs/B5EAIpCLJp83Kqvt4sIvUG6y+s2r8BwtFmTzJ
	 QO3vsPgo8PXz+/Ju5qyN9H8taghBK9vCKhTOedWktEAeWHtwxPzHg4hzySxZ7opRNe
	 c52uTZffIhIpxUFPCLDuD12iYGEijO49/Zu8zvL0qxWSZzje7iWyPlNWVBWSKeVWQM
	 mvS1a4nCW1Mug==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 11:36:27 +0200
Message-Id: <DBOFRAMQXK27.2EFPC1T807C2F@kernel.org>
Subject: Re: [PATCH] auxiliary: Automatically generate id
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Leon Romanovsky"
 <leon@kernel.org>, "Ira Weiny" <ira.weiny@intel.com>,
 <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Dave Ertman" <david.m.ertman@intel.com>
To: "Sean Anderson" <sean.anderson@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250728211022.9165-1-sean.anderson@linux.dev>
In-Reply-To: <20250728211022.9165-1-sean.anderson@linux.dev>

On Mon Jul 28, 2025 at 11:10 PM CEST, Sean Anderson wrote:
> As it turns out, ids are not allowed to have semantic meaning. Their
> only purpose is to prevent sysfs collisions. To simplify things, just
> generate a unique id for each auxiliary device. Remove all references to
> filling in the id member of the device.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
>  drivers/base/auxiliary.c      | 32 +++++++++++++++++++++++---------
>  include/linux/auxiliary_bus.h | 26 ++++++++------------------
>  2 files changed, 31 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index dba7c8e13a53..f66067df03ad 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -264,6 +264,8 @@ static const struct bus_type auxiliary_bus_type =3D {
>  	.pm =3D &auxiliary_dev_pm_ops,
>  };
> =20
> +static DEFINE_IDA(auxiliary_id);

I think this is the correct thing to do, even though the per device IDA dri=
vers
typically went for so far produces IDs that are easier to handle when debug=
ging
things.

> +
>  /**
>   * auxiliary_device_init - check auxiliary_device and initialize
>   * @auxdev: auxiliary device struct
> @@ -331,20 +333,37 @@ int __auxiliary_device_add(struct auxiliary_device =
*auxdev, const char *modname)
>  		return -EINVAL;
>  	}
> =20
> +	ret =3D ida_alloc(&auxiliary_id, GFP_KERNEL);
> +	if (ret < 0) {
> +		dev_err(dev, "auxiliary device id_alloc fauiled: %d\n", ret);
> +		return ret;
> +	}
> +	auxdev->id =3D ret;

This overwrites the ID number set by various drivers that (still) use the
auxiliary_device_init() and auxiliary_device_add() pair.

While I agree with the general intent, I think it's a very bad idea to just
perform this change silently leaving drivers with their IDA instances not
knowing that the set ID numbers do not have an effect anymore.

I think this should be multiple steps:

  (1) Remove the id parameter and force an internal ID only for
      auxiliary_device_create().

  (2) Convert applicable drivers (and the Rust abstraction) to use
      auxiliary_device_create() rather than auxiliary_device_init() and
      auxiliary_device_add().

  (3) Treewide change to force an internal ID for all auxiliary devices
      considering this change in all affected drivers.

> +
>  	ret =3D dev_set_name(dev, "%s.%s.%d", modname, auxdev->name, auxdev->id=
);
>  	if (ret) {
>  		dev_err(dev, "auxiliary device dev_set_name failed: %d\n", ret);
> +		ida_free(&auxiliary_id, auxdev->id);
>  		return ret;
>  	}
> =20
>  	ret =3D device_add(dev);
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "adding auxiliary device failed!: %d\n", ret);
> +		ida_free(&auxiliary_id, auxdev->id);
> +	}
> =20
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(__auxiliary_device_add);
> =20
> +void auxiliary_device_delete(struct auxiliary_device *auxdev)
> +{
> +	ida_free(&auxiliary_id, auxdev->id);

Hm...I wonder if we should call this from the device's release callback ins=
tead.

The above ensures that we never have duplicate IDs in sysfs, but we can sti=
ll
end up with two auxiliary devices that have the same ID.

If we want the ID to be *always* unique, we need to introduce our own auxil=
iary
device release callback, such that we have a hook for the
auxiliary_device_init() and auxiliary_device_add() pair. Since so far drive=
rs
are controlling the underlying device's release callback.

> +	device_del(&auxdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_delete);

