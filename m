Return-Path: <linux-kernel+bounces-725517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F373B00025
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198301C8768C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8345D2E5413;
	Thu, 10 Jul 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAeM1OCz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB52D63E7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145702; cv=none; b=AXs6PGXZFnQmyitc2wrd2ZxV0Vw2L2JHmTjISEHcN88AQZMJcsdlABoh1y59WAarT9GAf9uIptwkjUGt1hyY4R0XXv4XtUGsDqTb2lOJ3bzf4q2B5mtXtVssTjReTKnXbhep+sk2oWp/RoKbZwTAwYiDszK0HSd6P1mGCs/ky70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145702; c=relaxed/simple;
	bh=hLv7KtHeR2IJpjEA2gsXEz32Asf3LWXa9l8I718Q4NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GijvmvU3XH0lXUzACrYKr6xu5zP2UUl4WUGYOPPRTMOq63X8gAmFbiEb/XXVGlcDxMYPEO0TEubLJbR81Dcz+kkswxV1MyQ2rINgQAOwbMpQ40q4yXfDh4smDUdQFUw+Kc2ylznGUo9uI6VM9XKFL2Eq97FNHabX2SxozbQkIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAeM1OCz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752145700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2iF5MdVcoXLNB41BPYMA3hHITImWanFeZV1om8p29w=;
	b=ZAeM1OCzgA+iru73wOHKgT2dj05rq1gchktP8BKrVB7u5x2Mfo+VBc2KF9cKgUR5W3/J7J
	kXg076PUXV1ApspVbSjD8MQ2v6OkJ+NkkK3LUxhVMPL9xaANpQKN4mhMKrzUE/DIXEVXr9
	sJnwI1OKS3Kgyfko43mXE0RkXTu4c/8=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-HXjmRSaNNMGshL0v3FEslw-1; Thu, 10 Jul 2025 07:08:16 -0400
X-MC-Unique: HXjmRSaNNMGshL0v3FEslw-1
X-Mimecast-MFC-AGG-ID: HXjmRSaNNMGshL0v3FEslw_1752145696
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5346b8a0402so296251e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752145696; x=1752750496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2iF5MdVcoXLNB41BPYMA3hHITImWanFeZV1om8p29w=;
        b=qkM9AeIz8XCQ564WJDfdi2xvwzR3Dn625AxZrYmE0y36E/IllMecEj0qGdLW+ZZds0
         PiWv7i1p3s9p+emUjcOgHoaQ7O9kt3uHuis93CpkVVEdGVjQi5iFJZxFwKKYrZNd0ufL
         yVkOvRdur3b8ipvLFt6JnbReC5LAu4VrG6uYltp8MQb7sSebbECbcAePzOYE7hP2MRmZ
         ycw3yJ9TizNwayhz+ixpOktJGFi+QmrEnC+0nc5NZ/173vtDExbK/6ha2VfbrhQSS/Ve
         Y/3XOZkrJwfbE4wSW9xROqApG7cPfLFbL5/tHo0aE9ELkfJ61wRYy23bxAVrQAkDXSG6
         j3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn1x5VdDBCblh9o+lUJm7GbrDJh+bUBH4wGfskalfplN0M1kSVCVRj3A5rdpco04cSf2BC8qHxr1MhNjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygiuRfb6Ov3OOzPG9bQzKOkJ2ko/yPUN62UEqWHIz5k/VKcr4x
	EKjPCRUxYwTydMZBzNJ8Zaut6ChwtzR+URdWdptwMWZLcKhbZzxkiHe2vRQ+aGca0Ex92fOm0t3
	Ctc0SIlc6A0WXr3njIGQXDne2q9jhiuCn27vz56RrwKafF0Ls2ozqgggrZ/Tmj1+qP6KX1v8yMr
	4e36hyQMNbF061yzGMPhERh6s8DcyOKG658cW7Icjh
X-Gm-Gg: ASbGnctRFSS9DzE3oc+wW3N/RJpwZM4t9NdFZdHf5kxZwGCWuX3tOcbQJx4ckQQnd1W
	lpx6+tTNm4VWJ+4u8Gr97xp8OVidIus/2vSgoQ7ExikVvZhiNCqU4TOnOB6lGbvE3OxQQorxMYK
	AzNzz5
X-Received: by 2002:a05:6122:62b1:b0:520:6773:e5ea with SMTP id 71dfb90a1353d-535e6cad302mr816375e0c.7.1752145695398;
        Thu, 10 Jul 2025 04:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG748xi5tENRlmgUwDPKCpmuUZ5DFZugXu5QWkB94zDKhR5MrrRw1zsQESq2LYQJHkYSg59QTKK/bT7AOAWiHA=
X-Received: by 2002:a05:6122:62b1:b0:520:6773:e5ea with SMTP id
 71dfb90a1353d-535e6cad302mr816305e0c.7.1752145694749; Thu, 10 Jul 2025
 04:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710060754.637098-1-ebiggers@kernel.org> <20250710060754.637098-6-ebiggers@kernel.org>
In-Reply-To: <20250710060754.637098-6-ebiggers@kernel.org>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 10 Jul 2025 14:08:04 +0300
X-Gm-Features: Ac12FXxQDl3-eJSLjWpXqvFXfUA71G8ntcV5BboxZYjfuEKf_nyCYrk2ELPh9Bg
Message-ID: <CAO8a2Sie5K_jB-UvhAvRpDEQP-ZJ+rXn9gmkAEXthE65Jrtbbg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] fscrypt: Remove gfp_t argument from fscrypt_encrypt_block_inplace()
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Yuwen Chen <ywen.chen@foxmail.com>, linux-mtd@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Jul 10, 2025 at 9:14=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> This argument is no longer used, so remove it.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/ceph/crypto.c        | 3 +--
>  fs/crypto/crypto.c      | 3 +--
>  fs/ubifs/crypto.c       | 2 +-
>  include/linux/fscrypt.h | 5 ++---
>  4 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 3b3c4d8d401ec..6d04d528ed038 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -521,12 +521,11 @@ int ceph_fscrypt_encrypt_block_inplace(const struct=
 inode *inode,
>  {
>         struct ceph_client *cl =3D ceph_inode_to_client(inode);
>
>         doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
>               ceph_vinop(inode), len, offs, lblk_num);
> -       return fscrypt_encrypt_block_inplace(inode, page, len, offs, lblk=
_num,
> -                                            gfp_flags);
> +       return fscrypt_encrypt_block_inplace(inode, page, len, offs, lblk=
_num);
>  }
>
>  /**
>   * ceph_fscrypt_decrypt_pages - decrypt an array of pages
>   * @inode: pointer to inode associated with these pages
> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> index bab0aacd4da36..b6ccab524fdef 100644
> --- a/fs/crypto/crypto.c
> +++ b/fs/crypto/crypto.c
> @@ -215,11 +215,10 @@ EXPORT_SYMBOL(fscrypt_encrypt_pagecache_blocks);
>   * @len:       Size of block to encrypt.  This must be a multiple of
>   *             FSCRYPT_CONTENTS_ALIGNMENT.
>   * @offs:      Byte offset within @page at which the block to encrypt be=
gins
>   * @lblk_num:  Filesystem logical block number of the block, i.e. the 0-=
based
>   *             number of the block within the file
> - * @gfp_flags: Memory allocation flags
>   *
>   * Encrypt a possibly-compressed filesystem block that is located in an
>   * arbitrary page, not necessarily in the original pagecache page.  The =
@inode
>   * and @lblk_num must be specified, as they can't be determined from @pa=
ge.
>   *
> @@ -227,11 +226,11 @@ EXPORT_SYMBOL(fscrypt_encrypt_pagecache_blocks);
>   *
>   * Return: 0 on success; -errno on failure
>   */
>  int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page=
 *page,
>                                   unsigned int len, unsigned int offs,
> -                                 u64 lblk_num, gfp_t gfp_flags)
> +                                 u64 lblk_num)
>  {
>         if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units=
))
>                 return -EOPNOTSUPP;
>         return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_ENCRYPT,
>                                        lblk_num, page, page, len, offs);
> diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
> index 921f9033d0d2d..fb5ac358077b1 100644
> --- a/fs/ubifs/crypto.c
> +++ b/fs/ubifs/crypto.c
> @@ -49,11 +49,11 @@ int ubifs_encrypt(const struct inode *inode, struct u=
bifs_data_node *dn,
>         /* pad to full block cipher length */
>         if (pad_len !=3D in_len)
>                 memset(p + in_len, 0, pad_len - in_len);
>
>         err =3D fscrypt_encrypt_block_inplace(inode, virt_to_page(p), pad=
_len,
> -                                           offset_in_page(p), block, GFP=
_NOFS);
> +                                           offset_in_page(p), block);
>         if (err) {
>                 ubifs_err(c, "fscrypt_encrypt_block_inplace() failed: %d"=
, err);
>                 return err;
>         }
>         *out_len =3D pad_len;
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 56fad33043d53..8d0e3ad89b940 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -312,11 +312,11 @@ void fscrypt_enqueue_decrypt_work(struct work_struc=
t *);
>
>  struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
>                 size_t len, size_t offs, gfp_t gfp_flags);
>  int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page=
 *page,
>                                   unsigned int len, unsigned int offs,
> -                                 u64 lblk_num, gfp_t gfp_flags);
> +                                 u64 lblk_num);
>
>  int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
>                                      size_t offs);
>  int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page=
 *page,
>                                   unsigned int len, unsigned int offs,
> @@ -485,12 +485,11 @@ static inline struct page *fscrypt_encrypt_pagecach=
e_blocks(struct folio *folio,
>  }
>
>  static inline int fscrypt_encrypt_block_inplace(const struct inode *inod=
e,
>                                                 struct page *page,
>                                                 unsigned int len,
> -                                               unsigned int offs, u64 lb=
lk_num,
> -                                               gfp_t gfp_flags)
> +                                               unsigned int offs, u64 lb=
lk_num)
>  {
>         return -EOPNOTSUPP;
>  }
>
>  static inline int fscrypt_decrypt_pagecache_blocks(struct folio *folio,
> --
> 2.50.1
>
>


