Return-Path: <linux-kernel+bounces-868166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6206C048DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3162F4E4329
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56825FA10;
	Fri, 24 Oct 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aocwFo2i"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5321A459
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288595; cv=none; b=Z9bNFZ6sA2eZv0pK7kkuKn6CrrPf123t78ni5WXLiXOz864PfhDfVBLK4475lxy9jFgRv/rnsNNkPA2+iUohHaVOzf8EgcHFz5e3SarWkufV3UHwCDnwfKAy2kEhcfX0YGSF3dTqe89jJgm+BCu2TaNcuAHN/FF2+ZjXTmrQq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288595; c=relaxed/simple;
	bh=9vBPEojZFqE9ty/6D3pThFauraHYwTpalTAAyZmWy+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=HbSqhugovm6vG21GUlcOE8wKL0NJSV58UrI8A+RcIDkW13jXzes0c7txgKB1q97hj/59VSf+I2ngDXsIUS/6LCxBI2VKDiG8GctiqCumIfuLVwnObZMx5OnxEre22o/WVk4Syfrps9X3UTmQULAFnD0YSPUaaXCBmeM637nRBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aocwFo2i; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a226a0798cso1412830b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761288592; x=1761893392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=km/6k02PixTAqdwRObjjj37gw0zTjmxCVFm4PbnN0vM=;
        b=aocwFo2iwyQXzunpY3YY/LglR7A2L0TtoJ5iM61FQIOag2L6AdCQc0vK79Rc9lqR4c
         rc9TdIJoaE8Vb9eRz7VVuDlOx8h+WUus/hn7Q0iIKZzhdeiFdeg3p/AQRH18J7O+7HrU
         IrhYkve2wN6hzVC010WA3LshH62aimVsHhK/e1Wt/y//BlR6v9yEmbK9AV0UuuFlSrCN
         1KAFXQ+IRhdodxZZ4uyGiMeaK7Kr9mYwU5iYEgIlb5tmFC1RjBSZbWvbFi8sSuvfPuzP
         +kqGwVHOWHK1pmLFivSqy0fRx7lOFkqAucRfh5RPMsDQ+SS4QWv7AsFedDdXMrOBaTqv
         eMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288592; x=1761893392;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=km/6k02PixTAqdwRObjjj37gw0zTjmxCVFm4PbnN0vM=;
        b=FdFHo03CDoH21cLqtP4ejSZGEGBPPzDIsTW1W9K/52dE9o/V4YP2Uz4s/SEQ6f06Nv
         dxMljYn9KllBitferft8CkykpWL4RCbxrAeUQCEop3kwcHcTMwAvxgeBGycivl6chr2o
         9etkyKzHqPpd+HNBKtjtZAv+6B7kPqd076/LEbTKnQgXnjuXHk/YnNH6P+2xElBdr0Q5
         A3/yQV38Lj5/BYl6b7ALs88NTQqoprDx2UHtAKETpYu3HB4Q8fj57wUvKbfVurUcgYUT
         uzOxbptDpt6URCurMoazg1DhRk7eLaoyWJNeTFqIAblUXXW5DvAqRfG2bDO4Ls9JTfrc
         5aCg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Gl/seSLjMJRtPo7Vmnc8kelckif8Rj9pYPcT0+jVr36sQsvzjZfuJ+oXUDU1j7XerbS32gEymcaxeJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlgnXsBTeEfrVzpHsQfNQuEjXZOPeaIBle3oE5D0c6fZg0SYx
	pp6uhwAHuFI+AhxkgRIfiM04HBTwW/8+aarDc6YAqA5utWsVXEWKy8wL
X-Gm-Gg: ASbGncuEjzymqvFcGseypAcCsZYfwpNM84pSEegv829L/K1KTJW40Ulc/A/8ujCmpfW
	U6ADNMKtD77dtaYn6ba86Z87HVBXrIoYZrF9p+DdaHBXcU6k5ahA/Wt0+zSzmnwBvTXpcEb0472
	9K7JsyMEB4ajADtoDqNqzarJMtxzlMGx9gEzuis+rtoXd8wWmpczkOMH451VYn+QKOeAYbwTj93
	7NXulcuhLMBEHiA9pAn7hgMo3/rDvfGpkmUEL9Rf48FIXQGQ3lS5KN2+6g7p2YF42/aPhSFCQaw
	OLNvXyx6/N1KQyG+KSZC6ioneR3CwrCoF0tDVJrcJYvw93ThOslbnzu4DQC4ppPe6NqJMPixKgN
	5HmooqSkINlr2EcpugpnXUcJBooeq05cl2FFkl7G2YiRNuaaadTwTgjvzZy0nLdf+wmlsDOfOtf
	BRXkRJ/fxJq6ycLmlV80T7h9mbVtMPceU9X7wtdRIO4PA7CNEAcF4A
X-Google-Smtp-Source: AGHT+IHBw2wC0BoP2X02OWCazdHGMebKdJsDNmkJBbtCK1oS/G49+mr3awzE1GU+XQHCYvJEsXB+uA==
X-Received: by 2002:a05:6a00:4fce:b0:7a2:7d3b:4356 with SMTP id d2e1a72fcca58-7a27d3b4449mr4993313b3a.32.1761288591770;
        Thu, 23 Oct 2025 23:49:51 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.202.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb3789sm4779374b3a.60.2025.10.23.23.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:49:51 -0700 (PDT)
Message-ID: <47bc0211bd8cc5474fbb3edb5446e0e306ccb026.camel@gmail.com>
Subject: Re: [PATCH] xfs: use kmalloc_array() instead of kmalloc() for map
 allocation
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>, Carlos Maiolino
	 <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Date: Fri, 24 Oct 2025 12:19:46 +0530
In-Reply-To: <20251018194528.1871298-1-kriish.sharma2006@gmail.com>
References: <20251018194528.1871298-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sat, 2025-10-18 at 19:45 +0000, Kriish Sharma wrote:
> Using kmalloc_array() better reflects the intent to allocate an array of
> map entries, and improves consistency with similar allocations across the
> kernel.
> 
> No functional change intended.
> 
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  fs/xfs/xfs_qm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index 23ba84ec919a..34ec61e455ff 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -1218,7 +1218,7 @@ xfs_qm_reset_dqcounts_buf(
>  	if (qip->i_nblocks == 0)
>  		return 0;
>  
> -	map = kmalloc(XFS_DQITER_MAP_SIZE * sizeof(*map),
> +	map = kmalloc_array(XFS_DQITER_MAP_SIZE, sizeof(*map),
>  			GFP_KERNEL | __GFP_NOFAIL);
I think kmalloc_array is more useful when the size of memory to be allocated is dynamic with
kmalloc_array doing some additional checks on the size that is being passed. In this case, both
XFS_QUITER_MAP_SIZE  and sizeof(*map) are constant i.e, we are allocating constant size memory, so
maybe this isn't quite necessary?

Definition of kmalloc_array()

static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
{
	if (size != 0 && n > SIZE_MAX / size)
		return NULL;
	return kmalloc(n * size, flags);
}


--NR
>  
>  	lblkno = 0;


