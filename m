Return-Path: <linux-kernel+bounces-845708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8CBBC5E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C6674FB966
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E1261B70;
	Wed,  8 Oct 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLTTVFa/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664F823DD
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938851; cv=none; b=TYOPQM5rGY4AcOQstAtDr+y09rBQtRpggBA+qNYVJ050ohy94edGxQ+H33C2H5ACYLM7tUido+Kf1wYxNHZ933CKkg8rbMZtkCoIbRTRPn9+bTeQ8H4YMTrYtUSbRFWMhRCgzMfqKAp/9bLaRpwZ1QWcUPfMkQPBlcsgESXCLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938851; c=relaxed/simple;
	bh=/hBAReddkKTlT3R1udJPa6EC5igPUqt82w++zbOE1l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrsrZsxm7O0AjWcMq6ALYYODvBhHkIZ5kxKKcBvOoObQLzs6JQKs96ET+Rp4YfOiyIV+KoMQW5YC4LU2XPm/aijWk+WLSXv6QH8ijXhxgffkRai99an5FS8NT0SjncDoBW8gUJZupjcdLa10MBmyxY1BUxZgWOe5BXqqRjJeTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLTTVFa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C68BC4CEE7;
	Wed,  8 Oct 2025 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759938851;
	bh=/hBAReddkKTlT3R1udJPa6EC5igPUqt82w++zbOE1l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLTTVFa/fGPIlAVxzkCiUgwDcw/eiHuKgR+uD506FpnYSgSu6s7ydg4RADWw7AyuN
	 SP8GPLgh8dCdZup1yV0jhCY2IhoIdkluyofEyreXh5yjJ8YqFc8/HLD1yVLXLtYXEP
	 2g5W783DWpA4SX++NINCNz25IkrEOvZ2QXrIbUE7A5EQdBHCQdTBMW21dczrfhnnS7
	 DVy1n1MJycpahRLNh9deDjoCGYRKUaHhlNSJitbWckSn6iUPgZzL7YIDd/IZTZH04d
	 vNGLOgbFEUCQdaVk8L9icRH2qZqQDi22SiaeOEarS1jje2yDZbuNpoPJiIQokej4k7
	 FKFKnynLRbu7w==
Date: Wed, 8 Oct 2025 16:54:07 +0100
From: Lee Jones <lee@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: qnap-mcu: Add proper error handling for command
 errors
Message-ID: <20251008155407.GZ8757@google.com>
References: <20250923160853.1925674-1-heiko@sntech.de>
 <20250923160853.1925674-5-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923160853.1925674-5-heiko@sntech.de>

On Tue, 23 Sep 2025, Heiko Stuebner wrote:

> Further investigation revealed that the MCU in QNAP devices may return
> two error states. One "@8" for a checksum error in the submitted command
> and one "@9" for any generic (and sadly unspecified) error.
> 
> These error codes with 2 data character can of course also be shorter
> then the expected reply length for the submitted command, so we'll
> need to check the received data for error codes and exit the receive
> portion early in that case.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mfd/qnap-mcu.c | 44 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)

I can't help but think that there is a bunch of avoidable duplication in
here.

> diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
> index cd836bdd44a8..fb78609a8433 100644
> --- a/drivers/mfd/qnap-mcu.c
> +++ b/drivers/mfd/qnap-mcu.c
> @@ -19,6 +19,7 @@
>  /* The longest command found so far is 5 bytes long */
>  #define QNAP_MCU_MAX_CMD_SIZE		5
>  #define QNAP_MCU_MAX_DATA_SIZE		36
> +#define QNAP_MCU_ERROR_SIZE		2
>  #define QNAP_MCU_CHECKSUM_SIZE		1
>  
>  #define QNAP_MCU_RX_BUFFER_SIZE		\
> @@ -103,6 +104,24 @@ static int qnap_mcu_write(struct qnap_mcu *mcu, const u8 *data, u8 data_size)
>  	return serdev_device_write(mcu->serdev, tx, length, HZ);
>  }
>  
> +static bool qnap_mcu_reply_is_generic_error(unsigned char *buf, size_t size)
> +{
> +	return (size == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE &&

I'd place this check into a separate, concisely named function, then
call it at the start of qnap_mcu_reply_is_generic_error() and
qnap_mcu_reply_is_checksum_error().  Perhaps something like:

static bool qnap_mcu_is_error_msg(size) {
	return (size == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE);
}

Then at the start of both functions have:

	if (!qnap_mcu_is_error_msg(size))
		return false;

	if (buf[0] == '@' && buf[1] == '9')(
		return true;

	return false;

> +		buf[0] == '@' && buf[1] == '9');
> +}
> +
> +static bool qnap_mcu_reply_is_checksum_error(unsigned char *buf, size_t size)
> +{
> +	return (size == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE &&
> +		buf[0] == '@' && buf[1] == '8');
> +}
> +
> +static bool qnap_mcu_reply_is_any_error(unsigned char *buf, size_t size)
> +{

Then this should simply call each of the functions above:

	if (qnap_mcu_reply_is_generic_error(buf, size)) {
		dev_err(&mcu->serdev->dev, "Controller received invalid Checksum\n");
		return true;
	}

	if (qnap_mcu_reply_is_checksum_error(buf, size)) {
		dev_err(&mcu->serdev->dev, "Controller received invalid Checksum\n");
		return true;
	}

	return false;

Note: all of this is just hand-written psudo-code that was knocked-up in
about 2-mins.  None of it has even vaguely been checked or tested.

> +	return (size == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE &&
> +		buf[0] == '@' && (buf[1] == '8' || buf[1] == '9'));
> +}
> +
>  static size_t qnap_mcu_receive_buf(struct serdev_device *serdev, const u8 *buf, size_t size)
>  {
>  	struct device *dev = &serdev->dev;
> @@ -136,6 +155,19 @@ static size_t qnap_mcu_receive_buf(struct serdev_device *serdev, const u8 *buf,
>  		}
>  	}
>  
> +	/*
> +	 * We received everything the uart had to offer for now.
> +	 * Check for a possible error reply in the received data.
> +	 */
> +	if (reply->received == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE &&

If qnap_mcu_verify_checksum() needs this, it too should be inserted into
the function itself.

> +	    qnap_mcu_verify_checksum(reply->data, reply->received) &&
> +	    qnap_mcu_reply_is_any_error(reply->data, reply->received)) {
> +		/* The reply was an error code, we're done */
> +		reply->length = 0;
> +
> +		complete(&reply->done);
> +	}
> +
>  	/*
>  	 * The only way to get out of the above loop and end up here
>  	 * is through consuming all of the supplied data, so here we
> @@ -182,10 +214,20 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
>  	}
>  
>  	if (!qnap_mcu_verify_checksum(rx, reply->received)) {
> -		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
> +		dev_err(&mcu->serdev->dev, "Invalid Checksum received from controller\n");

As you can see above, I moved the messages into the checking functions too.

> +		return -EPROTO;
> +	}
> +
> +	if (qnap_mcu_reply_is_checksum_error(rx, reply->received)) {
> +		dev_err(&mcu->serdev->dev, "Controller received invalid Checksum\n");
>  		return -EPROTO;
>  	}
>  
> +	if (qnap_mcu_reply_is_generic_error(rx, reply->received)) {
> +		dev_err(&mcu->serdev->dev, "Generic error received from controller\n");
> +		return -EIO;
> +	}
> +
>  	memcpy(reply_data, rx, reply_data_size);
>  
>  	return 0;
> -- 
> 2.47.2
> 

-- 
Lee Jones [李琼斯]

