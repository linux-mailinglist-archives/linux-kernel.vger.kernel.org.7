Return-Path: <linux-kernel+bounces-810257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD979B517E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995F73A982C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E531CA4A;
	Wed, 10 Sep 2025 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkE09hBa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66C268C40;
	Wed, 10 Sep 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510881; cv=none; b=ZM9gzkcprqsEhPX9cpRNP7ovmwZmNQ/Ho5LQz8Sh2JM3tMUSCG0GtmLNwTKAAZtdzwdy3BQtII8OAH1/YDzAyRxBQO1Hfv+8evVZI7k/GvylLrsmGYq14RAOrfPsjeg+b3HWuEUGoJRqbRYK0wGVthWkbffsjq0QgKLMmn1qw2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510881; c=relaxed/simple;
	bh=AMAxmj3loZl2FQgd7utRY9kdM0ALCMLDy95MjK1oQHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOssQV1CWHzyg6gnjPkX+UYQO8iQaTdcimU0s1w9MMLr/qyd9rsRdiSbV1mB4hT9vWv65jp3BLPz50fNu1v32lilUMBf/FSRWJrmvhDQ13KI6FLYMoB+DsXb9WgBNEQcaTPJO3uf64yMJsOGLaMwew5ytWmc+N8nZIeXlfwmtFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkE09hBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32453C4CEF0;
	Wed, 10 Sep 2025 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757510880;
	bh=AMAxmj3loZl2FQgd7utRY9kdM0ALCMLDy95MjK1oQHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkE09hBajWcCu7qFfGdKk7Z0/2HuMuOUs4zJWDMNTGkaqbArWuYoPz1sqebhckftt
	 qPfjERY02x1PsgF9475HKsXgDncD9qgFgCp4L68FYF8E0Q8+wg92ryMk4czii0qrP4
	 /vX3m8FegJDiBzMFezt4m921Ua/91f6dVaNyqDGU=
Date: Wed, 10 Sep 2025 15:27:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] usb: typec: Expose alternate mode priority via
 sysfs
Message-ID: <2025091028-darkish-washcloth-3d02@gregkh>
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-6-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905142206.4105351-6-akuchynski@chromium.org>

On Fri, Sep 05, 2025 at 02:22:06PM +0000, Andrei Kuchynski wrote:
> This patch introduces a priority sysfs attribute to the USB Type-C
> alternate mode port interface. This new attribute allows user-space to
> configure the numeric priority of alternate modes managing their preferred
> order of operation.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-typec | 11 +++++++
>  drivers/usb/typec/class.c                   | 32 ++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 38e101c17a00..dab3e4e727b6 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -162,6 +162,17 @@ Description:	Lists the supported USB Modes. The default USB mode that is used
>  		- usb3 (USB 3.2)
>  		- usb4 (USB4)
>  
> +		What:		/sys/class/typec/<port>/<alt-mode>/priority
> +Date:		July 2025
> +Contact:	Andrei Kuchynski <akuchynski@chromium.org>
> +Description:
> +		Displays and allows setting the priority for a specific alt-mode.
> +		When read, it shows the current integer priority value. Lower numerical
> +		values indicate higher priority (0 is the highest priority).
> +		If the new value is already in use by another mode, the priority of the
> +		conflicting mode and any subsequent modes will be incremented until they
> +		are all unique.

What is the units here?  0 is highest, what is the lowest?  What is the
range here?  I can't determine this from the text, sorry.

> +
>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>  
>  What:		/sys/class/typec/<port>-partner/accessory_mode
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 9f86605ce125..aaab2e1e98b4 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -19,6 +19,7 @@
>  #include "bus.h"
>  #include "class.h"
>  #include "pd.h"
> +#include "mode_selection.h"
>  
>  static DEFINE_IDA(typec_index_ida);
>  
> @@ -445,11 +446,34 @@ svid_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(svid);
>  
> +static ssize_t priority_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t size)
> +{
> +	unsigned int val;
> +	int err = kstrtouint(buf, 10, &val);
> +
> +	if (!err) {
> +		typec_mode_set_priority(to_typec_altmode(dev), val);
> +		return size;
> +	}
> +
> +	return err;
> +}
> +
> +static ssize_t priority_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%u\n", to_typec_altmode(dev)->priority);

For new sysfs files, please use sysfs_emit(), otherwise someone will
come along with a janitorial patch to fix it up after it lands in the
tree :)

thanks,

greg k-h

