Return-Path: <linux-kernel+bounces-720214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3AAFB8A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A390B1AA1FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1299B2222BA;
	Mon,  7 Jul 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj7ak25D"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5331FC109
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905887; cv=none; b=Tl4LeP59QwF5r1H3dGFeydS8Nnwl27GEipONbjjAkYX2rdSm67Osnw/jYmHqfKZc3YU7Xkpr09zNNxpx0VeWwmG67gxutwb2m0U4gQw9DsmQaGGB8rlGjr/py6XttD1IijiRX1aLs1gAPMLcH/xA6IKi5S8dmvIJ3sEV/0p+d6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905887; c=relaxed/simple;
	bh=CTGTIMfddBoIpV0RuG6mIYxA9hlfuIrcvXHD4cWlliI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeIpEvUyFLqDbDubUxJFXdoOntAQBpE90YDz4pO0FzbLQoYqStDU/7Mdozsig4KOQOGbrU2CZO0pjPiETB0ew8ZrNV2EMYaRpfCdqWeMgEE3/nmGqu53W6xgxh5F5V/O8l1B8+aE2EhAbGCJObQrNIfVZPm1AnnhB80JnXtloBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj7ak25D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b27c1481bso2016850b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751905885; x=1752510685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T65upEdCDY7gEQSF7YmZBvbMiIUrTEJa2opQbxpVZOA=;
        b=lj7ak25D0jZo2SY+rBcnxTSAgCteEba4CgP+ay8IifFSvMQLwHe0/C6NM6f00wYfPg
         a+I5gwXAR/pwj6librJzO1Lqfh/gkzeFdl58BqHB9peVkC6lCDuPn59/YuQD1Kc66J1K
         VfEpZNZbPLeGzNuhzDjLx4tZtOarl08yfFcbLKl/cvMxGAZ+74y+KgRHFYHNjSXfRXk3
         8tAzqDCVptOXdjtpkizD/TTwhSIjXYQeQ/Myuplnc8KWOqjHr8OiOaMOrA+9kUZmai2q
         U5a0Huok3YtpOTS43vkm+/UDQf5VBDdF4BVhuuHHDAm1JCaWxW4fAuTDNibSAvos34ax
         4tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905885; x=1752510685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T65upEdCDY7gEQSF7YmZBvbMiIUrTEJa2opQbxpVZOA=;
        b=w0gPwKWZiD4BWybEUWlHYukaYvxodhI/lPYHfAtFH5ixVvIV3Tt8hmzCf4pU4Qx0j8
         XGm6yT6TM0mk9MyrqNQcHqYjEf6KdrP5iV3TbV4AdDUpaHzpXyZxVdWHqccng/ZNGSf9
         uVS9R91iTMYkIXmVHFoInvyMNvwVelw8TQbqRNqtwaZcTvUv+GsALoXln33mOfMZUIoQ
         tjc7Z2LxM9zJqX/kYWmD4VMvadb12K4A+fiVaaUEmjMBtBhff+JgosOqDLWsWd6+rbj+
         EVm9wLUeNCvvXyTyGqc4kQE8oqRJQOP95N8m6+frvxuha8o7fw301noTyes18FOHq12u
         31fw==
X-Forwarded-Encrypted: i=1; AJvYcCUVai0jQheeDhY3IbYKYNtxAedMJbFLdIqzCpyAvi/OYx7g1Gmj/lJ+qj2QFfv1GAcDb4unVz9+yyThwxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxUPgmRBGS0Emo2BYiNjH/g9oF0CrGyZtsLRbx1ldxkohVOoSu
	X+XKP5CF8KDtqcRk4SQrvqp+XCjBzwX+K6LDDkt9158Btqcvx+WbxfPe
X-Gm-Gg: ASbGnctu4+FbKizco/EZ7lB0nj/8lgPUnZQRL+g4H76H5QDx1i5mXL16R0uF+44yWlj
	tWPWBKwFNLibYCVD46j7PsnjjUt4NRrNlL3g5TXnKg7KlBWtydWyTPOPZW/f+M7L/bRnQv3h6gL
	gZe2dmPlfLjq4Ja1hCtrfYaAps2M+KUKFjtd2eTXQtYVjuSc9cCd6F0VVpDGqUt/qOfpgdwpruG
	8zFFGPVhKwlk8dKrcnF6pYVZw4f6TcYO+B2hTyHUiRfpA7JnMzGAMlRG/UeyL6IOamKUJVrfIW0
	EKzryI+4YrVVmZ07Phm1Rs7fwMXOI1J39hGksMbrC6t81PWP5GtzffN/5GcONQ==
X-Google-Smtp-Source: AGHT+IE9LUw0GOAkRdv3EbKLvPJ2vN2Wm1zWt6kB2645lDr4uxnf9kEor2mDWupUMMQ9E1c4bRBisg==
X-Received: by 2002:a05:6a00:2409:b0:749:112:c172 with SMTP id d2e1a72fcca58-74cf6fd8194mr11055113b3a.16.1751905885276;
        Mon, 07 Jul 2025 09:31:25 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f765sm9231493b3a.75.2025.07.07.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:31:24 -0700 (PDT)
Date: Mon, 7 Jul 2025 12:31:22 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ben Horgan <ben.horgan@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org, james.morse@arm.com
Subject: Re: [PATCH 2/2] bitfield: Ensure the return value of
 type##_replace_bits() is checked
Message-ID: <aGv2WoAtxnEgqV4y@yury>
References: <20250703135729.1807517-1-ben.horgan@arm.com>
 <20250703135729.1807517-3-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703135729.1807517-3-ben.horgan@arm.com>

Hi Ben,

On Thu, Jul 03, 2025 at 02:57:29PM +0100, Ben Horgan wrote:
> As type##_replace_bits() has no side effects it is only useful if its
> return value is checked. Add __must_check to enforce this usage. To have
> the bits replaced in-place typep##_replace_bits() can be used instead.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>  include/linux/bitfield.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 6d9a53db54b6..39333b80d22b 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -195,8 +195,8 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
>  		__field_overflow();					\
>  	return to((v & field_mask(field)) * field_multiplier(field));	\
>  }									\
> -static __always_inline __##type type##_replace_bits(__##type old,	\
> -					base val, base field)		\
> +static __always_inline __##type __must_check type##_replace_bits(__##type old,	\
> +							base val, base field)	\
>  {									\
>  	return (old & ~to(field)) | type##_encode_bits(val, field);	\
>  }									\

So, would it make sense to mark _encode_bits() and _get_bits() as
__must_check as well? At least from the point of unification, it
would.

How would we move this - with my bitmap-for next or with arm branch?

Thanks,
Yury

