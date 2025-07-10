Return-Path: <linux-kernel+bounces-725516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E8EB00029
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDA5B412AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F92459E0;
	Thu, 10 Jul 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8LuZIP/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A013A3F7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145699; cv=none; b=a1/brLHTgPBJ567UQPyTTuLIOAIatNmj1yi8oCpTi017qT9mFa9jsEuLPIZ4cehDS+ISkILSNvBCz0JzHPSofH+jNQRwB/wc4gJf5Q7QYBPAx3mjjv0saLqzUYF7TpuUG8oqtQWDV/7b+mOO+O4A1VaHBOm6FgqSmfAMkSQ+G8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145699; c=relaxed/simple;
	bh=scW7lpt9t3K9ITJWzum5EA9tDSAFygNR1A3VRJqSD3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAyuSfyiQteSQ8XVRCPt8tF+qGQt9wPjd+DbTcxG4pg33f9Wo+EzyN6sSRtOLwdfYF8VkB1VsXE+pLwS3NETTP+pgZUX9gY8tN26TcaWzcOA+6UtKwJPrssXNHpF+RQ4sQ2uH1S8ki2QILX7E9OG7Cj/WyHhpjPvaCv6acG7ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8LuZIP/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752145691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRr959tgklYlTSJNtT9cIXr3gOx1P9lsAQr8MZhrUds=;
	b=F8LuZIP/fidB5eL3xLWriE4mN2v8FpV1ZtJPvAybz4lqs/66wyJbp5SuTUFCmJMS9RV9by
	5AqBAleKo5NzCmhHfwdnBS387uvc1mD3cGbPE60H2Adpc9BioYc279fnW0ysCRH7LSPmNk
	FsYdMHh1Inu5GjRSptWsHjcj+7vlD1Y=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-nk7mjqOaMPe8GHvuCsRfXw-1; Thu, 10 Jul 2025 07:08:05 -0400
X-MC-Unique: nk7mjqOaMPe8GHvuCsRfXw-1
X-Mimecast-MFC-AGG-ID: nk7mjqOaMPe8GHvuCsRfXw_1752145681
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-53157659c58so2479301e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752145681; x=1752750481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRr959tgklYlTSJNtT9cIXr3gOx1P9lsAQr8MZhrUds=;
        b=R6Q9pwTWzt29QxCMn5Q/Db60dNlUK2Y0eAAVwad0IYYiZvI3hieAmfhxAcCFRbEEfg
         MkydIa+ula0/rZnn96zAWLAL2n+45BslcAqf7LCcyS0rXCxINTzFEN/iZEKAPJKb5Jzj
         HG7NVfubtHzQZ5BOhrxh6Go/g5jQJ/0FpOhBe4JK7+kPuXhmlstrZtZ/Ap9kE0CqOROo
         Vl8XaHaR9LYZeO4zwa9qjxdDXsMCq9ye90pVxgukfvvKv8oomQ75MGChbwiP1vV0vr0c
         SBm7zbvNCMobn8fd8pw2M0W5/NXJIlEmp/2c1MliaWd59JbyWDp3LFiqA3QXDzGftk3x
         j6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnyfWI3IZ5eV2ehvA3Of1hGImKcTFMhU/p1l0Br/aXFv5YnoLJTYpcd5DDMba9ayigV21MTggWzrRnLhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5y6veyooDtX6IOWJJgldlorw1GW4xSaIWDsvrCiGRXJRl09cB
	6mhElDKgI8HmmKKeEywgFj3K0EHlA4teIDaegtdHcycpFoIHnMiekicz1cOTlLL+ekMASCaUNoe
	sLI+2roZPO/HBr0iq4lssGsejdnJnZqwaud7HHTC7oYGQxF8tv4gd6Iw3JkZr3h4L6P7QtIQz7w
	wNRvsWIv/IOQ27SDe5+RTT7AxpRcqwhZLlazPlhxEN
X-Gm-Gg: ASbGncsLHnwqnWXlMuyjW1/NiwoSrR4R4Oqw9TRSdWMW7qu+u0qGiecIEc0JtONX/ix
	ziO8GZ9CAfGlOAi54C1KmhYQDAeUUrtjENhNkLIdSdmoxATNyqfLZJfJDhF2Xu4aM5+8mdhMns3
	4+NvRT
X-Received: by 2002:a05:6122:788:b0:531:1314:618d with SMTP id 71dfb90a1353d-535e3dc3141mr2472009e0c.0.1752145681121;
        Thu, 10 Jul 2025 04:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrFIvf+c9gCePlhiHZ18anazjvea9C/s5gsteYaCXiPys9MekY2/pYF44bBTHRs6JXyKOEgCbgxmRUYU9jd9A=
X-Received: by 2002:a05:6122:788:b0:531:1314:618d with SMTP id
 71dfb90a1353d-535e3dc3141mr2471772e0c.0.1752145679323; Thu, 10 Jul 2025
 04:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710060754.637098-1-ebiggers@kernel.org> <20250710060754.637098-7-ebiggers@kernel.org>
In-Reply-To: <20250710060754.637098-7-ebiggers@kernel.org>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 10 Jul 2025 14:07:47 +0300
X-Gm-Features: Ac12FXxqiJxLMMlU9cjfbI_3W3ee5EBVwZqxnp4Ks340mDQ4Yybgshbv8UUr1rw
Message-ID: <CAO8a2Sivm00NRM9Z-Fwp=FzcmkAP8m1uQR24-avT-tUug4VgmQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ceph: Remove gfp_t argument from ceph_fscrypt_encrypt_*()
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Yuwen Chen <ywen.chen@foxmail.com>, linux-mtd@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Jul 10, 2025 at 9:15=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> This argument is no longer used, so remove it.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/ceph/crypto.c | 10 ++++------
>  fs/ceph/crypto.h | 10 ++++------
>  fs/ceph/file.c   |  3 +--
>  fs/ceph/inode.c  |  3 +--
>  4 files changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 6d04d528ed038..91e62db0c2050 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -514,12 +514,11 @@ int ceph_fscrypt_decrypt_block_inplace(const struct=
 inode *inode,
>         return fscrypt_decrypt_block_inplace(inode, page, len, offs, lblk=
_num);
>  }
>
>  int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
>                                   struct page *page, unsigned int len,
> -                                 unsigned int offs, u64 lblk_num,
> -                                 gfp_t gfp_flags)
> +                                 unsigned int offs, u64 lblk_num)
>  {
>         struct ceph_client *cl =3D ceph_inode_to_client(inode);
>
>         doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
>               ceph_vinop(inode), len, offs, lblk_num);
> @@ -639,21 +638,20 @@ int ceph_fscrypt_decrypt_extents(struct inode *inod=
e, struct page **page,
>   * ceph_fscrypt_encrypt_pages - encrypt an array of pages
>   * @inode: pointer to inode associated with these pages
>   * @page: pointer to page array
>   * @off: offset into the file that the data starts
>   * @len: max length to encrypt
> - * @gfp: gfp flags to use for allocation
>   *
> - * Decrypt an array of cleartext pages and return the amount of
> + * Encrypt an array of cleartext pages and return the amount of
>   * data encrypted. Any data in the page prior to the start of the
>   * first complete block in the read is ignored. Any incomplete
>   * crypto blocks at the end of the array are ignored.
>   *
>   * Returns the length of the encrypted data or a negative errno.
>   */
>  int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page, =
u64 off,
> -                               int len, gfp_t gfp)
> +                               int len)
>  {
>         int i, num_blocks;
>         u64 baseblk =3D off >> CEPH_FSCRYPT_BLOCK_SHIFT;
>         int ret =3D 0;
>
> @@ -670,11 +668,11 @@ int ceph_fscrypt_encrypt_pages(struct inode *inode,=
 struct page **page, u64 off,
>                 unsigned int pgoffs =3D offset_in_page(blkoff);
>                 int fret;
>
>                 fret =3D ceph_fscrypt_encrypt_block_inplace(inode, page[p=
gidx],
>                                 CEPH_FSCRYPT_BLOCK_SIZE, pgoffs,
> -                               baseblk + i, gfp);
> +                               baseblk + i);
>                 if (fret < 0) {
>                         if (ret =3D=3D 0)
>                                 ret =3D fret;
>                         break;
>                 }
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index d0768239a1c9c..6db28464ff803 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -153,19 +153,18 @@ static inline void ceph_fscrypt_adjust_off_and_len(=
struct inode *inode,
>  int ceph_fscrypt_decrypt_block_inplace(const struct inode *inode,
>                                   struct page *page, unsigned int len,
>                                   unsigned int offs, u64 lblk_num);
>  int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
>                                   struct page *page, unsigned int len,
> -                                 unsigned int offs, u64 lblk_num,
> -                                 gfp_t gfp_flags);
> +                                 unsigned int offs, u64 lblk_num);
>  int ceph_fscrypt_decrypt_pages(struct inode *inode, struct page **page,
>                                u64 off, int len);
>  int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page=
,
>                                  u64 off, struct ceph_sparse_extent *map,
>                                  u32 ext_cnt);
>  int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page, =
u64 off,
> -                              int len, gfp_t gfp);
> +                              int len);
>
>  static inline struct page *ceph_fscrypt_pagecache_page(struct page *page=
)
>  {
>         return fscrypt_is_bounce_page(page) ? fscrypt_pagecache_page(page=
) : page;
>  }
> @@ -244,12 +243,11 @@ static inline int ceph_fscrypt_decrypt_block_inplac=
e(const struct inode *inode,
>         return 0;
>  }
>
>  static inline int ceph_fscrypt_encrypt_block_inplace(const struct inode =
*inode,
>                                           struct page *page, unsigned int=
 len,
> -                                         unsigned int offs, u64 lblk_num=
,
> -                                         gfp_t gfp_flags)
> +                                         unsigned int offs, u64 lblk_num=
)
>  {
>         return 0;
>  }
>
>  static inline int ceph_fscrypt_decrypt_pages(struct inode *inode,
> @@ -267,11 +265,11 @@ static inline int ceph_fscrypt_decrypt_extents(stru=
ct inode *inode,
>         return 0;
>  }
>
>  static inline int ceph_fscrypt_encrypt_pages(struct inode *inode,
>                                              struct page **page, u64 off,
> -                                            int len, gfp_t gfp)
> +                                            int len)
>  {
>         return 0;
>  }
>
>  static inline struct page *ceph_fscrypt_pagecache_page(struct page *page=
)
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index a7254cab44cc2..9b79da6d1aee7 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1990,12 +1990,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_it=
er *from, loff_t pos,
>                         break;
>                 }
>
>                 if (IS_ENCRYPTED(inode)) {
>                         ret =3D ceph_fscrypt_encrypt_pages(inode, pages,
> -                                                        write_pos, write=
_len,
> -                                                        GFP_KERNEL);
> +                                                        write_pos, write=
_len);
>                         if (ret < 0) {
>                                 doutc(cl, "encryption failed with %d\n", =
ret);
>                                 ceph_release_page_vector(pages, num_pages=
);
>                                 break;
>                         }
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 06cd2963e41ee..fc543075b827a 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2434,12 +2434,11 @@ static int fill_fscrypt_truncate(struct inode *in=
ode,
>                 memset(iov.iov_base + boff, 0, PAGE_SIZE - boff);
>
>                 /* encrypt the last block */
>                 ret =3D ceph_fscrypt_encrypt_block_inplace(inode, page,
>                                                     CEPH_FSCRYPT_BLOCK_SI=
ZE,
> -                                                   0, block,
> -                                                   GFP_KERNEL);
> +                                                   0, block);
>                 if (ret)
>                         goto out;
>         }
>
>         /* Insert the header */
> --
> 2.50.1
>
>


