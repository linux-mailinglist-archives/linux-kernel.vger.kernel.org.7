Return-Path: <linux-kernel+bounces-871634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977DC0DE49
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 803904F7298
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373EE25F97C;
	Mon, 27 Oct 2025 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP2G+gny"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231152472BA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570205; cv=none; b=Q0kHlsS+hAmQycysEigfa850fV+Nzc2j5K400IqK7x6IqpqYT2lrJ+KYdJTPYJBGOO7LXGf0bnxslUdsZgbIW/2dPBVbr7sQankUv11/Up70unntGqhs2VzlFHukSbGxa+km0FDLU7tycumEP+v6GSdp0re67g29H5deH/Yham0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570205; c=relaxed/simple;
	bh=f3k/z3I0y5Ok43lqfeNHh7kQLWGPGLB7Q+pEbC0I+SQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LOxbqGfzZX81V9KeIaTzXKDGuYplY+umzo4QsvavsyW3Y630TfBD/4HBIpaW4XaK45+DQYM2kktqqNY5SvySVRZzKRmmY5UJch7eLcUcz+LACj4fMn9Yx/tIj0hCG7hNMhPM6UqVBw3Q0FDDRuRkESFSKYLGgRog6Slk55nwLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP2G+gny; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3001244f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761570200; x=1762175000; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N31s0m6iPpe/D8ht+rzuSz/UgKSh2B3HnxendLz+41M=;
        b=AP2G+gnyoMx/xh0SQDVkdJ+Yf++GzuAignKEoFQxXBU2IUkRMgzoa3/5oolOslS+5Z
         NkYVJLjcbR+VNJQiDWrPO56SRsp9R9JgAaAxJnwKBaT8AoF9WWTv9IKv92aH6Th77LI+
         V9uxjEdLgqO5fM+2h8b/MzqBKEtAOYxY7AD47ReLP9EiFo3bTKBcqeAl7ARPsZEw+s9Z
         BNMfKzpKa+9laGMxjHJgoO51oonCNwQy4hyN5T58cBZMXU1ouBuszADyydLHdTqxt4gE
         eIQR2mwi+m9RiuKSOGhhrPiCm8VhY74E1TN/F/Nv6SFBJ+DOtgc4uVulb2bn051QBSen
         mRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570200; x=1762175000;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N31s0m6iPpe/D8ht+rzuSz/UgKSh2B3HnxendLz+41M=;
        b=vw4PPuc2OpvS7wKGYUMA+9U6ky+TFLWowSpIASpvnzg8KYZMMEf9e5Awn2PIDacpo1
         ghEEaC3PMEBCbV2l56xyQoyT6lOdru5UQnm5plactFvhWc0m0jrdijPJsVYM18Igsg5h
         3sY3Eoim2SqddG26TGTyUSjBzN2InOXUG0RCdCX8jzQNGT1yxN9gmHAzhtuceMKK8KT2
         B16f4hXRue7zO/UcIdmipFVeBeczmXW5WgequFkMNyyXPt9gwP8CVje8Zb3iArcg1C2i
         0tdtruGzYwkmiCKDURwI2NsDVZV65wN1TqZ4RWpEfcRmGUJa2wctVCxklEPF8Fbk9rc0
         m9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXaSWsAdb5nEikZBa5iuCbEINEYKwxmNK+e4Vz8D7E3zGeztjYz3MpQFE071LHsZWttxmpZy/cubCeBU5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZ0vJbD+P2u9NVWzt6A3zFO+w66Yue/z5pzPvaEH8V67Bbcs6
	wGHv1hQ4hGfThKIYTBcJd2v34Y9jLJfRPED7LN05I/k0aIHOz57sQq+M
X-Gm-Gg: ASbGncs1/M29DrvrN/6IG2mnXl3d8rlUzeYeomJj/iqeYoalpr7tQzOGpR5wApk4RfT
	3FPufedboC9T9QPtVR2lvu2FPExfFFXgRdjz06F7x199/8odxk79kgE3fUMV0U+1gETkfwUotiN
	dLkmOJekJS5Q+4T+lL12BZGieUtpFwJnaPt3apA2YJ+t29+C0YYRBFwSvhfaIGvd0Oar5ALyrWT
	jfiUJ3bihlJ4GxcO03+e74yd/5jTaOxdEXAH6F56kh0gP0TsOIBaY3VJSUST+xB1arRWUV7SWsE
	19N8B1LsPAOlqAThAEOcOFmYJ95hTVy+QoQASEu1bKWCSfruMdyw2V9/5T5mxzuvwhtHfBlQIKz
	OF1ZbNN+gMjltoj4gjf5kTeKAwyoW/KHQgvSZlQVF58cWvwLL63tsmokIvBVNzCyzipyIJ7EQXL
	qelu+JQnbq
X-Google-Smtp-Source: AGHT+IFy4lHfZKYAUxpChiM/+pJgD0sz9c2mg6bmQSCoUd2BbEXzPK96ZbwUpKX3z8ifK+plNRNF8Q==
X-Received: by 2002:a05:6000:22c7:b0:426:ff8f:a0a3 with SMTP id ffacd0b85a97d-4299072c0femr9120280f8f.34.1761570200163;
        Mon, 27 Oct 2025 06:03:20 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df3c7sm14013153f8f.40.2025.10.27.06.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:03:19 -0700 (PDT)
Message-ID: <ff1af8b4d43ce31cbf94623e36b721b057ca4077.camel@gmail.com>
Subject: Re: [PATCH] iio: imu: adis: fix all kernel-doc warnings in header
 file
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, 	linux-iio@vger.kernel.org
Date: Mon, 27 Oct 2025 13:03:54 +0000
In-Reply-To: <20251026024759.433956-1-rdunlap@infradead.org>
References: <20251026024759.433956-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-25 at 19:47 -0700, Randy Dunlap wrote:
> Correct and add to adis.h to resolve all kernel-doc warnings:
>=20
> - add a missing struct member description
> - change one non-kernel-doc comment to use /* instead of /**
> - correct function parameter @value to @val (7 locations)
> - add function return value comments (13 locations)
>=20
> Warning: include/linux/iio/imu/adis.h:97 struct member 'has_fifo'
> =C2=A0not described in 'adis_data'
> Warning: include/linux/iio/imu/adis.h:139 Incorrect use of kernel-doc
> =C2=A0format: * The state_lock is meant to be used during operations that
> =C2=A0require
> Warning: include/linux/iio/imu/adis.h:158 struct member '"__adis_"'
> =C2=A0not described in 'adis'
> Warning: include/linux/iio/imu/adis.h:264 function parameter 'val'
> =C2=A0not described in 'adis_write_reg'
> Warning: include/linux/iio/imu/adis.h:371 No description found for
> =C2=A0return value of 'adis_update_bits_base'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---

Thanks!

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org
> ---
> =C2=A0include/linux/iio/imu/adis.h |=C2=A0=C2=A0 45 +++++++++++++++++++++=
+++++-------
> =C2=A01 file changed, 36 insertions(+), 9 deletions(-)
>=20
> --- linux-next-20251024.orig/include/linux/iio/imu/adis.h
> +++ linux-next-20251024/include/linux/iio/imu/adis.h
> @@ -57,6 +57,7 @@ struct adis_timeout {
> =C2=A0 * @enable_irq: Hook for ADIS devices that have a special IRQ enabl=
e/disable
> =C2=A0 * @unmasked_drdy: True for devices that cannot mask/unmask the dat=
a ready
> pin
> =C2=A0 * @has_paging: True if ADIS device has paged registers
> + * @has_fifo: True if ADIS device has a hardware FIFO
> =C2=A0 * @burst_reg_cmd:	Register command that triggers burst
> =C2=A0 * @burst_len:		Burst size in the SPI RX buffer. If @burst_max_len =
is
> defined,
> =C2=A0 *			this should be the minimum size supported by the
> device.
> @@ -136,7 +137,7 @@ struct adis {
> =C2=A0	const struct adis_data	*data;
> =C2=A0	unsigned int		burst_extra_len;
> =C2=A0	const struct adis_ops	*ops;
> -	/**
> +	/*
> =C2=A0	 * The state_lock is meant to be used during operations that requi=
re
> =C2=A0	 * a sequence of SPI R/W in order to protect the SPI transfer
> =C2=A0	 * information (fields 'xfer', 'msg' & 'current_page') between
> @@ -166,7 +167,7 @@ int __adis_reset(struct adis *adis);
> =C2=A0 * adis_reset() - Reset the device
> =C2=A0 * @adis: The adis device
> =C2=A0 *
> - * Returns 0 on success, a negative error code otherwise
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int adis_reset(struct adis *adis)
> =C2=A0{
> @@ -183,7 +184,9 @@ int __adis_read_reg(struct adis *adis, u
> =C2=A0 * __adis_write_reg_8() - Write single byte to a register (unlocked=
)
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the register to be written
> - * @value: The value to write
> + * @val: The value to write
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int __adis_write_reg_8(struct adis *adis, unsigned in=
t reg,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 u8 val)
> @@ -195,7 +198,9 @@ static inline int __adis_write_reg_8(str
> =C2=A0 * __adis_write_reg_16() - Write 2 bytes to a pair of registers (un=
locked)
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the lower of the two registers
> - * @value: Value to be written
> + * @val: Value to be written
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int __adis_write_reg_16(struct adis *adis, unsigned i=
nt reg,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 val)
> @@ -207,7 +212,9 @@ static inline int __adis_write_reg_16(st
> =C2=A0 * __adis_write_reg_32() - write 4 bytes to four registers (unlocke=
d)
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the lower of the four register
> - * @value: Value to be written
> + * @val: Value to be written
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int __adis_write_reg_32(struct adis *adis, unsigned i=
nt reg,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 val)
> @@ -220,6 +227,8 @@ static inline int __adis_write_reg_32(st
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the lower of the two registers
> =C2=A0 * @val: The value read back from the device
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int __adis_read_reg_16(struct adis *adis, unsigned in=
t reg,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 u16 *val)
> @@ -239,6 +248,8 @@ static inline int __adis_read_reg_16(str
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the lower of the two registers
> =C2=A0 * @val: The value read back from the device
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int __adis_read_reg_32(struct adis *adis, unsigned in=
t reg,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 u32 *val)
> @@ -257,8 +268,10 @@ static inline int __adis_read_reg_32(str
> =C2=A0 * adis_write_reg() - write N bytes to register
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the lower of the two registers
> - * @value: The value to write to device (up to 4 bytes)
> + * @val: The value to write to device (up to 4 bytes)
> =C2=A0 * @size: The size of the @value (in bytes)
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int adis_write_reg(struct adis *adis, unsigned int re=
g,
> =C2=A0				 unsigned int val, unsigned int size)
> @@ -273,6 +286,8 @@ static inline int adis_write_reg(struct
> =C2=A0 * @reg: The address of the lower of the two registers
> =C2=A0 * @val: The value read back from the device
> =C2=A0 * @size: The size of the @val buffer
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static int adis_read_reg(struct adis *adis, unsigned int reg,
> =C2=A0			 unsigned int *val, unsigned int size)
> @@ -285,7 +300,9 @@ static int adis_read_reg(struct adis *ad
> =C2=A0 * adis_write_reg_8() - Write single byte to a register
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the register to be written
> - * @value: The value to write
> + * @val: The value to write
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int adis_write_reg_8(struct adis *adis, unsigned int =
reg,
> =C2=A0				=C2=A0=C2=A0 u8 val)
> @@ -297,7 +314,9 @@ static inline int adis_write_reg_8(struc
> =C2=A0 * adis_write_reg_16() - Write 2 bytes to a pair of registers
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the lower of the two registers
> - * @value: Value to be written
> + * @val: Value to be written
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int adis_write_reg_16(struct adis *adis, unsigned int=
 reg,
> =C2=A0				=C2=A0=C2=A0=C2=A0 u16 val)
> @@ -309,7 +328,9 @@ static inline int adis_write_reg_16(stru
> =C2=A0 * adis_write_reg_32() - write 4 bytes to four registers
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the lower of the four register
> - * @value: Value to be written
> + * @val: Value to be written
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int adis_write_reg_32(struct adis *adis, unsigned int=
 reg,
> =C2=A0				=C2=A0=C2=A0=C2=A0 u32 val)
> @@ -322,6 +343,8 @@ static inline int adis_write_reg_32(stru
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the lower of the two registers
> =C2=A0 * @val: The value read back from the device
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int adis_read_reg_16(struct adis *adis, unsigned int =
reg,
> =C2=A0				=C2=A0=C2=A0 u16 *val)
> @@ -341,6 +364,8 @@ static inline int adis_read_reg_16(struc
> =C2=A0 * @adis: The adis device
> =C2=A0 * @reg: The address of the lower of the two registers
> =C2=A0 * @val: The value read back from the device
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int adis_read_reg_32(struct adis *adis, unsigned int =
reg,
> =C2=A0				=C2=A0=C2=A0 u32 *val)
> @@ -366,6 +391,8 @@ int __adis_update_bits_base(struct adis
> =C2=A0 * @size: Size of the register to update
> =C2=A0 *
> =C2=A0 * Updates the desired bits of @reg in accordance with @mask and @v=
al.
> + *
> + * Returns: %0 on success, a negative error code otherwise
> =C2=A0 */
> =C2=A0static inline int adis_update_bits_base(struct adis *adis, unsigned=
 int reg,
> =C2=A0					const u32 mask, const u32 val, u8
> size)

