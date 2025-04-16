Return-Path: <linux-kernel+bounces-603372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE5A886BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8188C58524A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FAE279780;
	Mon, 14 Apr 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN5hyvkX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5D275851
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642806; cv=none; b=VXgHVQcG/yXJCof7q8lvP6f/bVzKTvuKxxbkEVuZ7wMBLVPHfxXZegx+Caq7pnsob+Kkp3s7cWpJ12oPr9mGjC+1C1+lJtbvo6hKyDPumOM4irsJdY+75ghdKF6+l2Kn0r6CgCXxegQmDYyrR2gPV8fHDA5lW3KdR7l9POSSH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642806; c=relaxed/simple;
	bh=6gOi6aUYpN/ZLhjYVXNgxwvj3feVqoIsGRlgnhgulLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsMuo43srm8GjFFRp0gGixkqG5qXvdaNz3ZXFCR+2o0azRgzIqBDdspYWGcawHQumifX6zh+hLa38wPgd2cZaeYIpQkLR6MHlIyiX3KIKtIAEVI1a+hYWhE2UacElo1PliaGXFSzuCDvjlVBrQ39e+irDIjSo/aiEWz4teAt1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YN5hyvkX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744642803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiBcwGEvq2PhJfASxrOHAGOy8gVOP2qSKhUxi65Uo4U=;
	b=YN5hyvkXeeIYtkLt/ulcZkTPOjS+s+PGo+aS8pBDU2RRMY9HcC9Om+y6D6AwYRH6I/bXqI
	HyhWl2NdcK1RiL1gwnrQ6UqohhkLFFgHlOzbEEvB1J3481qmGnuJya4Ng8YsNmAt9NiTA3
	kcCCAUwQjxtl7vHpj28D9mhVxKeGrEg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-C2CloqmON3yFly-RFNN6hA-1; Mon, 14 Apr 2025 11:00:02 -0400
X-MC-Unique: C2CloqmON3yFly-RFNN6hA-1
X-Mimecast-MFC-AGG-ID: C2CloqmON3yFly-RFNN6hA_1744642801
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso28320405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 08:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642801; x=1745247601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiBcwGEvq2PhJfASxrOHAGOy8gVOP2qSKhUxi65Uo4U=;
        b=Kn2YkQmENBte5ck7KTewO7SS4zhxVmc26UD6zy1gv7x+9N1s7TY57lOwuUhnp6WGqt
         6Ttmif4bA3y9cvgrRIYDo9kCLOjmxQfMpSNyZrr8w1GCSKn32U9wwV5v/mBOpPilYAQx
         Fx0J0zXxxMnCn0dbJCkUQYhGl1iVDcOI7lnWMvvy5zMvaibTKxbD824oBlguSamp5v1X
         28gI/MKNnPLvp1nzppASAZg/ofEkciqmbCumadNvLnQUrV4rHfUZhgWhCh2NWaAwa2o3
         LCE+QDzMusRGSkZ6ceFy4xqcnKK5zX5qhV3vcZ/VuKajGa2tPgywqWve0zep9jhM78ZM
         LEww==
X-Forwarded-Encrypted: i=1; AJvYcCVB2oPF+UXYVQ3ktYsQhx56dlHwLfJqTZPL9RPQqDAXn0uEt97lMM2W/fYuAxa4t8Jnqaq7Emeb6ClkkeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyenPOAQtML6dCrRjhzd520u+2zaG5IRVpLhKnt/W4kl713w7u+
	9ZR3pS+kZqrT/ShGVQRKSyFNAMxTmmkFEpwJkwSxWAGplv4qUzPFXTgMMz72nvA1CatDgf7eYLJ
	/Cl0C4nP6LYI0JMzRuNA7/IQcvqfXs0NfRwoJZai/KyQWJOb1whYwpAEahs/I/4xK++ao0/SQrZ
	w4s8y6YAFN5wxiNZXj+Ld/rDQqKEBunCcbcrZY
X-Gm-Gg: ASbGncubY7P6VkpQcP+Vg59FYK3BBPLcPf8+Rxk+G+bVRvo7H5xzy+wbF5AjjrstBIL
	Q/13syEMrxHgRWsQzlJ2tTa0RoKi11+j/SH89PFd1n9piNDEFEPA3WP/kmmexrWtxbDf7nA==
X-Received: by 2002:a05:600c:3c84:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43f2ea651bcmr156859825e9.7.1744642800753;
        Mon, 14 Apr 2025 08:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBw02L0rMKAm8Z+1nOktn69htJsdj/Jz1OK8Cyd/Ml4PZuhztd9KZNvdjVRlhSdTo1NUKpE0xXzvNiaYGSRZU=
X-Received: by 2002:a05:600c:3c84:b0:439:91c7:895a with SMTP id
 5b1f17b1804b1-43f2ea651bcmr156859495e9.7.1744642800128; Mon, 14 Apr 2025
 08:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414145653.239081-1-sgarzare@redhat.com> <20250414145653.239081-4-sgarzare@redhat.com>
In-Reply-To: <20250414145653.239081-4-sgarzare@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 14 Apr 2025 16:59:47 +0200
X-Gm-Features: ATxdqUGzkoR7R29rCyZrs6HYZjyVNgh9a1johmj3oUpZ98_9R4aglRHe8KpEBvQ
Message-ID: <CAGxU2F5SJ9nQfAV-D1WKjsUow_01xjGBRXP4d+q4T=5Bw=yaOg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
To: Jens Wiklander <jens.wiklander@linaro.org>, Sumit Garg <sumit.garg@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Peter Huewe <peterhuewe@gmx.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Naveen N Rao <naveen@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Apr 2025 at 16:57, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> This driver does not support interrupts, and receiving the response is
> synchronous with sending the command.
>
> So we can set TPM_CHIP_FLAG_SYNC to support synchronous send() and
> return responses in the same buffer used for commands. This way we
> don't need the 4KB internal buffer used to cache the response before
> .send() and .recv(). Also we don't need to implement recv() op.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
> - set TPM_CHIP_FLAG_SYNC and support it in the new send()
> - removed Jens' T-b

@Jens @Sumit can you test/review this patch again since from v1 we
changed the core a bit adding TPM_CHIP_FLAG_SYNC instead of
send_recv() op?

Thanks,
Stefano

> v1:
> - added Jens' T-b
> ---
>  drivers/char/tpm/tpm_ftpm_tee.h |  4 ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 64 ++++++++++-----------------------
>  2 files changed, 19 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
> index e39903b7ea07..8d5c3f0d2879 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.h
> +++ b/drivers/char/tpm/tpm_ftpm_tee.h
> @@ -22,16 +22,12 @@
>   * struct ftpm_tee_private - fTPM's private data
>   * @chip:     struct tpm_chip instance registered with tpm framework.
>   * @session:  fTPM TA session identifier.
> - * @resp_len: cached response buffer length.
> - * @resp_buf: cached response buffer.
>   * @ctx:      TEE context handler.
>   * @shm:      Memory pool shared with fTPM TA in TEE.
>   */
>  struct ftpm_tee_private {
>         struct tpm_chip *chip;
>         u32 session;
> -       size_t resp_len;
> -       u8 resp_buf[MAX_RESPONSE_SIZE];
>         struct tee_context *ctx;
>         struct tee_shm *shm;
>  };
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 637cc8b6599e..b9adc040ca6d 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -31,46 +31,18 @@ static const uuid_t ftpm_ta_uuid =
>                   0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
>
>  /**
> - * ftpm_tee_tpm_op_recv() - retrieve fTPM response.
> - * @chip:      the tpm_chip description as specified in driver/char/tpm/tpm.h.
> - * @buf:       the buffer to store data.
> - * @count:     the number of bytes to read.
> - *
> - * Return:
> - *     In case of success the number of bytes received.
> - *     On failure, -errno.
> - */
> -static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> -{
> -       struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> -       size_t len;
> -
> -       len = pvt_data->resp_len;
> -       if (count < len) {
> -               dev_err(&chip->dev,
> -                       "%s: Invalid size in recv: count=%zd, resp_len=%zd\n",
> -                       __func__, count, len);
> -               return -EIO;
> -       }
> -
> -       memcpy(buf, pvt_data->resp_buf, len);
> -       pvt_data->resp_len = 0;
> -
> -       return len;
> -}
> -
> -/**
> - * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory.
> + * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory
> + * and retrieve the response.
>   * @chip:      the tpm_chip description as specified in driver/char/tpm/tpm.h
> - * @buf:       the buffer to send.
> - * @len:       the number of bytes to send.
> + * @buf:       the buffer to send and to store the response.
> + * @cmd_len:   the number of bytes to send.
>   * @buf_size:  the size of the buffer.
>   *
>   * Return:
> - *     In case of success, returns 0.
> + *     In case of success, returns the number of bytes received.
>   *     On failure, -errno
>   */
> -static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
> +static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
>                                 size_t buf_size)
>  {
>         struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> @@ -82,16 +54,15 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
>         struct tee_param command_params[4];
>         struct tee_shm *shm = pvt_data->shm;
>
> -       if (len > MAX_COMMAND_SIZE) {
> +       if (cmd_len > MAX_COMMAND_SIZE) {
>                 dev_err(&chip->dev,
>                         "%s: len=%zd exceeds MAX_COMMAND_SIZE supported by fTPM TA\n",
> -                       __func__, len);
> +                       __func__, cmd_len);
>                 return -EIO;
>         }
>
>         memset(&transceive_args, 0, sizeof(transceive_args));
>         memset(command_params, 0, sizeof(command_params));
> -       pvt_data->resp_len = 0;
>
>         /* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
>         transceive_args = (struct tee_ioctl_invoke_arg) {
> @@ -105,7 +76,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
>                 .attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
>                 .u.memref = {
>                         .shm = shm,
> -                       .size = len,
> +                       .size = cmd_len,
>                         .shm_offs = 0,
>                 },
>         };
> @@ -117,7 +88,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
>                 return PTR_ERR(temp_buf);
>         }
>         memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
> -       memcpy(temp_buf, buf, len);
> +       memcpy(temp_buf, buf, cmd_len);
>
>         command_params[1] = (struct tee_param) {
>                 .attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> @@ -158,17 +129,20 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
>                         __func__, resp_len);
>                 return -EIO;
>         }
> +       if (resp_len > buf_size) {
> +               dev_err(&chip->dev,
> +                       "%s: resp_len=%zd exceeds buf_size=%zd\n",
> +                       __func__, resp_len, buf_size);
> +               return -EIO;
> +       }
>
> -       /* sanity checks look good, cache the response */
> -       memcpy(pvt_data->resp_buf, temp_buf, resp_len);
> -       pvt_data->resp_len = resp_len;
> +       memcpy(buf, temp_buf, resp_len);
>
> -       return 0;
> +       return resp_len;
>  }
>
>  static const struct tpm_class_ops ftpm_tee_tpm_ops = {
>         .flags = TPM_OPS_AUTO_STARTUP,
> -       .recv = ftpm_tee_tpm_op_recv,
>         .send = ftpm_tee_tpm_op_send,
>  };
>
> @@ -253,7 +227,7 @@ static int ftpm_tee_probe(struct device *dev)
>         }
>
>         pvt_data->chip = chip;
> -       pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
> +       pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
>
>         /* Create a character device for the fTPM */
>         rc = tpm_chip_register(pvt_data->chip);
> --
> 2.49.0
>


