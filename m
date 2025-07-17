Return-Path: <linux-kernel+bounces-735958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E383B095DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740AF5A1B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131A66EB79;
	Thu, 17 Jul 2025 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPHNVA8Q"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097D21ABAE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784953; cv=none; b=iRkGIxJqKXOm/hoWM/O75EKDi9//vz2oMczDM9sB+We3CDkTy2ZC9ezdxzGe/24udN7aVIkE9RT7s64DxgaFVr3k45sklp/OQ9IqlIkSK8Q5IENeMBnnOq1P18HbirvoDZTMRdo5iNXnMGUskwQMnIZO9aCkx6mfriR2wsQuBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784953; c=relaxed/simple;
	bh=8xHzhnsmrVig04m/9BR79i+zd/rgH6E5Tv7KQ7VUC58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upN93fGD8EiHg626ihf4+BBHw4In2BBppgzX7g2OvcYX+QWgg3crZWejbgL+WCru9f9T7IvENDUiSiAfC9VW4NRXK+MHlyWoQ5efIHt3ji8JM6lIR0BSam+ke3CSgPCOwnfpcfioLU/B0h7TIr+rK71nkRCyxBvBzrdo+FsR8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kPHNVA8Q; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-73e810dc01aso228309a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752784950; x=1753389750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldlF+I8llOCn2cLMQIQOjBCb32s1ACkmxJthAbMjiMA=;
        b=kPHNVA8Q/9DpEidmdv4hFghUrx2DlaOCsSdW8t44YV7rJuMF0sRTFFdhqArogqsi7L
         +wtAVNv8zHjsb584dAlMshWOOyDHUNXAlD0UEJqWUX839/a6r4M0/GI3bfgcqiDvW6nC
         okskx1VQwUbbI+eqMrFEKtMtq/6q+/CSa5yJD5IVyADGhI0tqCP/9CN/wmiCyCEX82el
         vIb99TMwXG8ERTDdv8m7jPz5aQaA2QVnNikGoYQ38Lo6AeafwiQYRajBQQktM3OLOaYu
         VykKVaLIsO0r7/+11Thm0mvoYS9JMW3uaFl69s2hKF4sHIchd8JxNJbu32VCHyEmQOUW
         lR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784950; x=1753389750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldlF+I8llOCn2cLMQIQOjBCb32s1ACkmxJthAbMjiMA=;
        b=lOrF1UMP7ykFBhgC4aeTArx+ecqAmJ53yO9yTdc6ezH7xq8Pxz8lgXodCf2L8TeIIX
         OaRaAde7QjKcGpftOYoBrwqUQAvdtNjqw2wffkff0sAlxYMWJHfr9NEAQMaD71KIdtGh
         M0iAivgkZAvsaYnIkK/majB49BixExJYfUq/ZDv/VnecnJvQHGUCIlhMCWgw+gDyxqf4
         pvfUlf2RQxHCS9FxRjdLCA3FMinmv6RFteH9sQl24DwA7NV7x6JRxpfVx/ZX8Qz7x07e
         QcqG3h83u1oxYjn5RJy8BIXHE87I5NZK5oOS9kLl+IIy86PG4omt4LS0SdHyzvs2ydcU
         OCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz9HEbO4W3A6pCoMkcwF0J/HKCbdxmvOIxp15tf75GrdngwWybACDByxYIrHJFY/4teg/LioLl2ISCBoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmU2PxuJnX6ESwlq42Jx+CFT0Ihxpnw5hhTuV67w+WXC/bmuC6
	zTlPG08wlR+l+gylfEP3xu8pd7tA/0o4NhvvwYxlgnCpubquDsfjKZY9EBj59MMvAMk=
X-Gm-Gg: ASbGncsEaCOg/ObDdRRCtBom7kZxK/CZbNiegcGkyAzVKpYqw3SPZ2Zk0k7RiL69gxt
	JzOshbYcOlcUV89pm3D1a2WySenp9A6Vw5+vCkD5cyNi4CyoTM5uEz1Mbla7LzP6kmUkebWfunS
	xoP4nYbf4KyEQiXkM5Pb3IldaJNtTtkisJ/bzXg7HsWYtuNRU3rKUTTCjkHjcBKUWtEFAsrtIWR
	jDVUPtcJGnYDS2xjHwMEwE4b+JF8wvyEx9XMLVynb502ywq1ZYzA5IhhMwIu2m44efDwLMhPZcj
	BkAJwYAQ74MNigEqDEWKzCEuHfYTwFoer2WQwBiXwPbR77Wz41Esih5tn7lFGm6+CFOwAqCnUOX
	iGWmOeG0q5noV7i8l7SHhZNrokxZm
X-Google-Smtp-Source: AGHT+IFCBhJw9A2YtCVV2dc5ZzvZ/NZVoz0GXNj/2FwobeWK3umYY1q1bgyL7GEUlu9mi9lxJdGgIQ==
X-Received: by 2002:a05:6871:9d02:b0:2c8:5db8:f23a with SMTP id 586e51a60fabf-2ffb23fcf91mr5822397fac.20.1752784950529;
        Thu, 17 Jul 2025 13:42:30 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3010220aea0sm17912fac.20.2025.07.17.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:42:29 -0700 (PDT)
Date: Thu, 17 Jul 2025 23:42:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFSD: Change ret code of xdr_stream_decode_opaque_fixed
Message-ID: <0e4116bf-1cfb-4286-be91-0337892e2031@suswa.mountain>
References: <20250717194838.69200-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717194838.69200-1-sergeybashirov@gmail.com>

On Thu, Jul 17, 2025 at 10:48:30PM +0300, Sergey Bashirov wrote:
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 67f6632f723b4..dd80163e0140c 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1863,7 +1863,7 @@ static inline int decode_opaque_fixed(struct xdr_stream *xdr,
>  				      void *buf, size_t len)
>  {
>  	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
> -	if (unlikely(ret < 0))
> +	if (unlikely(ret))
>  		return -EIO;

We could propagate the error code (-EBADMSG) instead of return -EIO?

regards,
dan carpenter

>  	return 0;
>  }


