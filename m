Return-Path: <linux-kernel+bounces-788466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6177B384FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3DC3A749E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8318FDBD;
	Wed, 27 Aug 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UZ3fJ4vY"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491F1E502
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305059; cv=none; b=bWj49E60yWqosrAne8mfQ7Y2+buqef9ltRBB3pjfRpgIdRNty7XPJQZsCCloHQ5vLwYIhVHc3BhFimuaQ+4mWuy6XeAeJOWkPpL871t8MKZhv6eHds2Jx+9Ld0ONfhfJTIUhDtyLkkVunJyyO88vd6isxcOtk/IOO0ycIn6DWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305059; c=relaxed/simple;
	bh=ekYO+g2DeAY7OpkpV3uLfFZhqmRFp4OHZb6J73pGdnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pelZGzaqBfuzxgOGFlTnc7yBOARUwWGo8z7a/nWF4zY/Qt8QcqWJPPc+E6O3jyHBo7tI/ev4MR+QdlBodQGT5gaVFJEHtgtweyov8W72rwnIhR5oW1T4jTirpdM+AyoEFrFIqaytYVQ8slOOyVBn0GIu6U01SriUA75N1pmmlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UZ3fJ4vY; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3f0fcd81068so52695ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756305054; x=1756909854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvhGwzAhrDpzRW76hw6st02Qx9plIVjdiLTJdLVN7ms=;
        b=UZ3fJ4vYtL89Hy7qitdjpODoWXsN16zgEzzSM78vC+alWIiNPT0puOC2EMx4UmOqGM
         aL6Odtu8Wr4amqGPBS/dYxOMd9JtmeULimUcyslAzGa9fn7o2YO7GiVabcP1mIdvvP1O
         7m++ePfxI8f70GF+PrVRXsaZ4LQF8uO2EyLUBhmlYQ5yE6AJc9E3AGdVA+KJaylD+auX
         vWl4/2mjJpUDmKIym0cvuVxEoaKsHG9QTHGaaJ1PxgNYZhryXna6w5OOz30cgS68TIRT
         ckMOfoesp6/0MSl8Yk+IUpRFIEW8jGZa9xd/no987ccuAw0FPsMTPSSj1Oa/wFSY0bYt
         dtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305054; x=1756909854;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvhGwzAhrDpzRW76hw6st02Qx9plIVjdiLTJdLVN7ms=;
        b=q7QmLrRLnnDMPTvUml0NZ/ak1POqTHqLNOlf6oVVAeYBoz4V4ClSVfRw37MIKgERzd
         r8Hi/XztONAQjLfbqS1VMm+sI19IwU2mYRzlEUVm07Ooj5jdMWjzZTUwjtiYrE06z21H
         rSUuW0PS9KaFy9utKvciFyvX5alx0iQx654VTWs8KeKJ0yJYMlvVBboVLaQIXfkifpnz
         PglE3gCzaas3z3acKI1Nh20BsPii84DDlIz/e7jG9GbETR/Da2oNltPVssbH9JDrhr8z
         4knDO1bRAoIMBssteiDMKkYXp9zk8jip42csybmk1LCZVpmEnKZfZrO+89RMUp4HfsDD
         ip+w==
X-Forwarded-Encrypted: i=1; AJvYcCU8tzJXXOxf/NGnQ44fLSOXnQNcDg8V4Ya0lEgBD+9oLtdRC1ZBmSW3hwygb2ULP881iykZA6LhmW89ULg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygtMyKif8z6C7rO7xMezBE4rIkk0mHNGHkMx60nJBPdlf5LJNh
	axRHr7fRPjqYJ0LFG5bipb2oSzMYDnKmlsTAROjgnSEN1vk5YA31ALz/S74ZYXUooaYjQ6t/3Nn
	8Ps9K
X-Gm-Gg: ASbGncu5mYlxfpIOEbCm1dvPS3qZAySLirPxoagn4AJraDPlk9CRS+uDzGp7qv4N81e
	U3oFY56plWi+H5WUl9NOL4hVm/9RbbfMUhVHARHutHGwm9bBC8qOi1Sa/tXgrFulKkK6FJ6SC62
	41kiLI2Pcr86fgMuPaAfnDj04UMIM6G9X3q805/zKV+b3Fd9o6f2zNjTcf+kept5E2rsqP+3ZOm
	H18rZDumwRLj8eEliVJvwtyfbdkQzu0bd/En+CQYAS/j8WlZCB5S1u52axt04BrFrd4pzsopqH5
	J94uBu3rFjT5kBYWqu+1cOSWuOf08F1cvrgrmQUUVPYRlluFiaDVAtM63d+MiC7WTZlEJdz+nq8
	dpr1ncShJmn9VolQcWNMFUN65iszY/JwHxieRsGZ8
X-Google-Smtp-Source: AGHT+IFnFm3nE5momCbmzhmqVeWBi4QobS9Cc/xr+4yGN08493B+GGco3c+Pt/f1l2wDN+e4gkkJEQ==
X-Received: by 2002:a05:6e02:2142:b0:3e5:5357:6dd4 with SMTP id e9e14a558f8ab-3e92231673fmr272052845ab.20.1756305054391;
        Wed, 27 Aug 2025 07:30:54 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3eaa5f05661sm78097235ab.52.2025.08.27.07.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 07:30:53 -0700 (PDT)
Message-ID: <fcfd5324-9918-4613-94b0-c27fb8398375@kernel.dk>
Date: Wed, 27 Aug 2025 08:30:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/kbuf: fix infinite loop in
 io_kbuf_inc_commit()
To: Qingyue Zhang <chunzhennn@qq.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 Suoxing Zhang <aftern00n@qq.com>
References: <20250827114339.367080-1-chunzhennn@qq.com>
 <tencent_000C02641F6250C856D0C26228DE29A3D30A@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <tencent_000C02641F6250C856D0C26228DE29A3D30A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 5:44 AM, Qingyue Zhang wrote:
> In io_kbuf_inc_commit(), buf points to a user-mapped memory region,
> which means buf->len might be changed between importing and committing.
> Add a check to avoid infinite loop when sum of buf->len is less than
> len.
> 
> Co-developed-by: Suoxing Zhang <aftern00n@qq.com>
> Signed-off-by: Suoxing Zhang <aftern00n@qq.com>
> Signed-off-by: Qingyue Zhang <chunzhennn@qq.com>
> ---
>  io_uring/kbuf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index 81a13338dfab..80ffe6755598 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -34,11 +34,12 @@ struct io_provide_buf {
>  
>  static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
>  {
> +	struct io_uring_buf *buf, *buf_start;
> +
> +	buf_start = buf = io_ring_head_to_buf(bl->buf_ring, bl->head, bl->mask);
>  	while (len) {
> -		struct io_uring_buf *buf;
>  		u32 this_len;
>  
> -		buf = io_ring_head_to_buf(bl->buf_ring, bl->head, bl->mask);
>  		this_len = min_t(u32, len, buf->len);
>  		buf->len -= this_len;
>  		if (buf->len) {
> @@ -47,6 +48,10 @@ static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
>  		}
>  		bl->head++;
>  		len -= this_len;
> +
> +		buf = io_ring_head_to_buf(bl->buf_ring, bl->head, bl->mask);
> +		if (unlikely(buf == buf_start))
> +			break;
>  	}
>  	return true;
>  }

Maybe I'm dense, but I don't follow this one. 'len' is passed in, and
the only thing that should cause things to loop more than it should
would be if we do:

len -= this_len;

and this_len > len;

Yes, buf->len is user mapped, perhaps we just need to do:

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index f2d2cc319faa..569f4d957051 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -36,15 +36,18 @@ static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
 {
 	while (len) {
 		struct io_uring_buf *buf;
-		u32 this_len;
+		u32 buf_len, this_len;
 
 		buf = io_ring_head_to_buf(bl->buf_ring, bl->head, bl->mask);
-		this_len = min_t(int, len, buf->len);
-		buf->len -= this_len;
-		if (buf->len) {
+		buf_len = READ_ONCE(buf->len);
+		this_len = min_t(int, len, buf_len);
+		buf_len -= this_len;
+		if (buf_len) {
 			buf->addr += this_len;
+			buf->len = buf_len;
 			return false;
 		}
+		buf->len = 0;
 		bl->head++;
 		len -= this_len;
 	}

so that we operate on a local variable, and just set buf->len
appropriate for each buffer.

?

-- 
Jens Axboe

