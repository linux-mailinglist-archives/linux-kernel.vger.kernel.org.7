Return-Path: <linux-kernel+bounces-866665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B560C0063B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3BE5345374
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E3303A1C;
	Thu, 23 Oct 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAJQy8pi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047A2FF14C;
	Thu, 23 Oct 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213864; cv=none; b=Vx8UHb4so1+YeEi/CS+BuX6alL6OKSKGprRNzIou9jXjbZ7Gte3/G2Rbltd/aGg5TB5sILm0FgQe+xs4VDR5Oq6/UnAQnc8JZsaoA3uzMnpNvrYRfmdGRhjD6XMXfeB5W3rzqrSvd6WBv162taVZrCP/dw21+Yf2nv1gfNnbJ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213864; c=relaxed/simple;
	bh=g1g9CqLDEPG+tNDHLhYli1UWazxwq8RwqO2EHlgnEP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QErGvhKqgInbmbL5NhrsI5Cb8v1mdHPl8Yva6YlWHrC8eO6u7Zhtg2ex20HahQ5GpYntlT87MhmTdGHIiK5lyeQJr+wX9qf7a2S4/enjnHDVO3VEItnZK1ApUPn35P4x9Bt+sroDD6SKp7pRMtVK7INf/7MmQV7r9GhlTQwDjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAJQy8pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02760C4CEF7;
	Thu, 23 Oct 2025 10:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761213862;
	bh=g1g9CqLDEPG+tNDHLhYli1UWazxwq8RwqO2EHlgnEP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAJQy8piz5EMAX9mLXXT2yiubKofH98iwWba7yUpEKJKMSUin5+Rg3SONpZ32LgCy
	 a2/QmEAR+xe56aa0lvm3at2YBPDZqfyFtTs491k5fsRDz9KlpUl5SuH/eFtVdBMkiv
	 OBG7RRvDRdJ6tW2Pk1ZldCaSOKlUxkig+e/UBnnY=
Date: Thu, 23 Oct 2025 12:04:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Robert Nelson <robertcnelson@beagleboard.org>,
	Dhruva Gole <d-gole@ti.com>, Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fw-download: Fix find firmware req
Message-ID: <2025102332-result-palace-789f@gregkh>
References: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>

On Wed, Oct 22, 2025 at 12:57:57PM +0530, Ayush Singh wrote:
> According to the Greybus Spec published here [0], the Greybus firmware
> download find firmware request should have both tag and format as
> request arguments. However, currently, the linux kernel seems to have
> defined this request incorrectly since format is missing.

Odd, I don't remember that at all, but it was changed here:
	https://github.com/projectara/greybus-spec/commit/773b9e0d6cc84a3c7a9f79ea353a552bd66d9de3

maybe we never actually implemented it?

> 
> The patch adds format to request and am using it as the file extension of
> the firmware.
> 
> [0]: https://github.com/projectara/greybus-spec/blob/ac47bc32dce1256489a82ff1f463fb979e9684ee/source/device_class/firmware.rst?plain=1#L152
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
> According to the Greybus Spec published here [0], the Greybus firmware
> download find firmware request should have both tag and format as
> request arguments. However, currently, the linux kernel seems to have
> defined this request incorrectly since format is missing.
> 
> The patch adds format to request and am using it as the file extension of
> the firmware.
> 
> I came across the bug while working on greybus-for-zephyr [1], to get it
> ready for upstreaming as zephyr module.
> 
> Open Questions
> ***************
> 
> 1. Handle empty format
> 
> Not sure what to do in case format is just NULL. Should the request
> fail? There is no reason to not support firmware without extension. So
> personally, I don't think it should be treated as error.
> 
> [0]: https://github.com/projectara/greybus-spec/blob/ac47bc32dce1256489a82ff1f463fb979e9684ee/source/device_class/firmware.rst?plain=1#L152
> [1]: https://github.com/Ayush1325/greybus-for-zephyr

As this is a AP-specific thing, it's whatever you want to do I think.
You can handle NULL there, or anything else, it's up to the firmware and
userspace to coordinate this, right?

> ---
>  drivers/staging/greybus/fw-download.c     | 31 ++++++++++++++++++++++++-------
>  include/linux/greybus/greybus_protocols.h |  2 ++
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
> index 9a09bd3af79ba0dcf7efa683f4e86246bcd473a5..06f1be8f3121e29551ea8416d5ee2666339b2fe3 100644
> --- a/drivers/staging/greybus/fw-download.c
> +++ b/drivers/staging/greybus/fw-download.c
> @@ -159,7 +159,7 @@ static int exceeds_release_timeout(struct fw_request *fw_req)
>  
>  /* This returns path of the firmware blob on the disk */
>  static struct fw_request *find_firmware(struct fw_download *fw_download,
> -					const char *tag)
> +					const char *tag, const char *format)
>  {
>  	struct gb_interface *intf = fw_download->connection->bundle->intf;
>  	struct fw_request *fw_req;
> @@ -178,10 +178,17 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
>  	}
>  	fw_req->firmware_id = ret;
>  
> -	snprintf(fw_req->name, sizeof(fw_req->name),
> -		 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.tftf",
> -		 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> -		 intf->vendor_id, intf->product_id, tag);
> +	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) == 0) {
> +		snprintf(fw_req->name, sizeof(fw_req->name),
> +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s",
> +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> +			 intf->vendor_id, intf->product_id, tag);
> +	} else {
> +		snprintf(fw_req->name, sizeof(fw_req->name),
> +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
> +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> +			 intf->vendor_id, intf->product_id, tag, format);
> +	}
>  
>  	dev_info(fw_download->parent, "Requested firmware package '%s'\n",
>  		 fw_req->name);
> @@ -225,7 +232,7 @@ static int fw_download_find_firmware(struct gb_operation *op)
>  	struct gb_fw_download_find_firmware_request *request;
>  	struct gb_fw_download_find_firmware_response *response;
>  	struct fw_request *fw_req;
> -	const char *tag;
> +	const char *tag, *format;
>  
>  	if (op->request->payload_size != sizeof(*request)) {
>  		dev_err(fw_download->parent,
> @@ -245,7 +252,17 @@ static int fw_download_find_firmware(struct gb_operation *op)
>  		return -EINVAL;
>  	}
>  
> -	fw_req = find_firmware(fw_download, tag);
> +	format = (const char *)request->format;
> +
> +	/* firmware_format must be null-terminated */
> +	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) ==
> +	    GB_FIRMWARE_FORMAT_MAX_SIZE) {
> +		dev_err(fw_download->parent,
> +			"firmware-format is not null-terminated\n");
> +		return -EINVAL;
> +	}
> +
> +	fw_req = find_firmware(fw_download, tag, format);
>  	if (IS_ERR(fw_req))
>  		return PTR_ERR(fw_req);
>  
> diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
> index 820134b0105c2caf8cea3ff0985c92d48d3a2d4c..48d91154847dbc7d3c01081eadc69f96dbe41a9f 100644
> --- a/include/linux/greybus/greybus_protocols.h
> +++ b/include/linux/greybus/greybus_protocols.h
> @@ -214,10 +214,12 @@ struct gb_apb_request_cport_flags {
>  #define GB_FW_DOWNLOAD_TYPE_RELEASE_FIRMWARE	0x03
>  
>  #define GB_FIRMWARE_TAG_MAX_SIZE		10
> +#define GB_FIRMWARE_FORMAT_MAX_SIZE		10
>  
>  /* firmware download find firmware request/response */
>  struct gb_fw_download_find_firmware_request {
>  	__u8			firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE];
> +	__u8			format[GB_FIRMWARE_FORMAT_MAX_SIZE];

Build issues asside (see the 0-day bot report), I am loath to change a
user api like this at the moment, without some sort of guarantee that
this isn't going to break anything.

But, these days, I think your implementation might be one of the few
"real" greybus users that is still alive.  The old phones that used the
protocol are no longer being sold from what I can tell, and the "greybus
over IP" stuff didn't actually get used anywhere outside of cool demos
that I know of.

So we might be ok?  Or, can you live without any such "format" need?
Have you handled downloading firmware already without this?

thanks,

greg k-h

