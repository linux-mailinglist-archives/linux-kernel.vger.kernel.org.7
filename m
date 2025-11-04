Return-Path: <linux-kernel+bounces-884752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3414CC3102F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B21218C13B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579292EC576;
	Tue,  4 Nov 2025 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV7J1MhR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481C86329
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259626; cv=none; b=b0q87/REkybZ1SFVUncqqhvGYcuSMrgMoEgTD5dEqzagV5Hnq/ScWnqKgkaIAe3nbsKsIbsEIuD9GY1IgR/XHRbTjeLmCI7qtHBqNB7t3v8J8lCiyRoTKIyIHB8+nulHV8dUPywg/Dk1SLahboNH4+zi89j98ubACE8gtAlQ8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259626; c=relaxed/simple;
	bh=PVG/u/rBRJtGXc7icffonY7sSvjL0w8UC+NsDC4RqhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=ScRArWuRfmGBN4rfAWiJ15zotbl8SoFqfNoAsG82AgFKzlOHQZZkFUcFnNBMMr/dB/BmNLmiFuv6ZuoSX91wH6ZbL0UvT5MgDnFldSGbfLHDp8rsL8L3FZVu1RkaRrbfmPkSBT+v7+bpk0jcnNazsxyCvhrl23c13sAHpw39WC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV7J1MhR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295548467c7so29596815ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762259623; x=1762864423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRHHdJQM2gcBeM06136CQSgxSJ3eclLtWip34bcWYH4=;
        b=gV7J1MhRmn62F5zM9AFF5163CxrhGjqCIvlisytWIbGoMhUdo8L0WHCJCAEjTHNKJR
         wdtLGJdQJLDRGL4uTiaZsH5OIkBE04KlizY5y8mb81o5v5J/HJb1GgvCyhspkzhXO0Ko
         HLlYZBNyOWNyC8EKfQQhdsvolw1Vq6AePzTCIT34DnRkVR9ZQT090KCtGTTceC19x8M1
         amUhZ7PwnGdaQtpe5AO6A+XqSKZY09RGwRPrfQB4fuMc6wXkh1jlmywVMwwE3ZWTtBaf
         oZ/8Lz0QDKwWIhkzPvrv7njY08lt+GNV2k2xHxqeAgt0aqS4c6qOqR/hx/mHhYfeztu3
         dsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259623; x=1762864423;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iRHHdJQM2gcBeM06136CQSgxSJ3eclLtWip34bcWYH4=;
        b=Yi8COBro7i8njw6Tz+TZGNmEUTg6e60V6xpjBxxvgiPyIksEb68CGCaDQNyw9wX7kC
         CAQeFLI90jjSbGuW9hf8yvTN1VNdsuh4bkAwZacZEHk8KRTdq+Rwk6+yj+9JBZGxLv5R
         j4jkLDJSn3GqyYfJ9vL51P2vel1v3fZdWhdR8KVe5xRc0EMOfor5K4kg6pdsWtHSMNvT
         bjfIg6uHiFCD2i/zKs8VMgiqNbCU97ybqYsTr8/tMlSVfhkN4pTl1Z9JWPa0ml3HRNkW
         j+OdJBlRA1Mg7jYxbLgs6eqj8/NV+XRogxo3JbqdetvFUQK3DwxX34bmUP1Z5bGd96Su
         xSpw==
X-Forwarded-Encrypted: i=1; AJvYcCVT+0vFgj9ubYAU8qBwJs2EMxqoCgHwxmSHiSrME7akCDYScRRugukiDb3piGO5USjvInqXZQflZNO4wjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY74QQ++eckD2fboxyc+612mPobP/Ie4+ZGGylNXr5pl6A4vjM
	fuQPK69kQLUwpul/zraseUamb6hbygZkndAqJWHSbDnvBXltUqV9JU+a
X-Gm-Gg: ASbGncv7Wi/5ZNGOXJ2BsTNaZiH7dyWVzXnd3lgl9NGC8O7LTPUjZMcDGQUBniKnjQS
	M8ufFCZY9TCyq+J4fe71/aX0nVXfFt2JLxkpje+jCv5qG3Pz1fgGILvP6qs2UICzwVaA76PcQU7
	zajPCr5hdf4BsA8ERVTnp2g4TyAqeYJgmSkjTC4l9nLFoFUt32yWF9sWMfjY+j2zp4RQbXEuNK1
	3uqDDqQtSpYGEUAqtuK4TZQ2Fnijw12duf4ZgkBVhZlYm7Aj8WTkQensgl9SHOPJGOSATN2itZB
	7Gv9BbHmBdH8/Cu3eK5a8GJTuMeRVEtEQOzLah2JvHxK+yYK5/9V9aPb/4jhCvKomJ/sUN62HPI
	eh2EboiRn51Z1IP0un7688GrBad3UJMd8Kn4OfEcMmG4XYs7FCh5NF5KUWRWV9AoTMUW23PEz59
	DrLwAyBMJLLYz09KoOHfnaDUTEZD+r4SR4fypRn0v+/tWVBsm5rPU+EQ==
X-Google-Smtp-Source: AGHT+IFcDWr3KBlNMXeLNPkyZZOa63IpUuqeGF/O+KRb8PWkuF5qhGuak3PkMEe642XnoKQJ5ppqRw==
X-Received: by 2002:a17:902:da8b:b0:295:2cb6:f498 with SMTP id d9443c01a7336-2952cb6f55emr159576605ad.7.1762259623021;
        Tue, 04 Nov 2025 04:33:43 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.200.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d181sm26106575ad.85.2025.11.04.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:33:40 -0800 (PST)
Message-ID: <a162ddcbd8c73adf43c7c64179db06ce60b087d6.camel@gmail.com>
Subject: Re: [PATCH 3/4] xfs: use IOCB_DONTCACHE when falling back to
 buffered writes
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>, 
	Christian Brauner
	 <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, "Martin K. Petersen"
 <martin.petersen@oracle.com>,  linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-raid@vger.kernel.org,  linux-block@vger.kernel.org
Date: Tue, 04 Nov 2025 18:03:35 +0530
In-Reply-To: <20251029071537.1127397-4-hch@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
	 <20251029071537.1127397-4-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-10-29 at 08:15 +0100, Christoph Hellwig wrote:
> Doing sub-block direct writes to COW inodes is not supported by XFS,
> because new blocks need to be allocated as a whole.  Such writes
Okay, since allocation of new blocks involves whole lot of metatdata updates/transactions etc and
that would consume a lot of time and in this large window the user buffer(for direct I/O) can be re-
used/freed which would cause corruptions?
Just thinking out loud: What if we supported sub-block direct IO in XFS and indeed allocated new
blocks+ update the metadata structures and then directly write the user data to the newly allocated
blocks instead of using the page cache? Assuming the application doesn't modify the user data buffer
- can we (at least theoritically) do such kind of sub-block DIO?
--NR
> fall back to buffered I/O, and really should be using the
> IOCB_DONTCACHE that didn't exist when the code was added to mimic
Just curious: How was it mimiced? 
> direct I/O semantics as closely as possible.  Also clear the
> IOCB_DIRECT flags so that later code can't get confused by it being
> set for something that at this point is not a direct I/O operation
> any more.
This makes sense to me.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5703b6681b1d..e09ae86e118e 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1119,6 +1119,9 @@ xfs_file_write_iter(
>  		ret = xfs_file_dio_write(iocb, from);
>  		if (ret != -ENOTBLK)
>  			return ret;
> +
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		iocb->ki_flags |= IOCB_DONTCACHE;
>  	}
>  
>  	if (xfs_is_zoned_inode(ip))


