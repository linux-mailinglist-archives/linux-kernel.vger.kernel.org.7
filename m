Return-Path: <linux-kernel+bounces-723496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4A4AFE7A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A9E3B88EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049502918DE;
	Wed,  9 Jul 2025 11:26:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453A1F55F8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060371; cv=none; b=sIKwW7u77S5ysIOzR+mQveLcAD6OxQa9XYLE0vzeQ7yjK2vuQxVMkAXibvZf+DdXRQ5YXlN622wjuhRWEC4PJM9QsOWs4Oi23vOVPw/2QNGo/6tp2P47806XD1KHd2WRCOIjzLVeUasPmij6J/DpbMBI6QS2BRXz+QjzurMrqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060371; c=relaxed/simple;
	bh=pV+HwuiF3NeTaTwpLi9PCSJINa2B+2bVeD1YLFOn+Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8G8LQY5N/EpM99F8hyaDZtOzO/bHmZa6AYXhZ0Fgm36So1Di+0iMII6Aq4m5yRZQguU1sRza25HrVdo9lN6Jf7qWAHUAoTDGpmNe3tsoBfRdKxw2j+sw4Z+OR1fTQ0zjf1L66IRdT2bEaBy7biLnCc3K0JtPMxfIcUPu3AETOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uZSw5-0007Dx-Mg; Wed, 09 Jul 2025 13:26:01 +0200
Message-ID: <862beb2e-f8a8-468a-a2ed-c8151eabb342@pengutronix.de>
Date: Wed, 9 Jul 2025 13:25:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: address D-cache aliasing
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
 <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Gao, Hi Jan,

On 7/9/25 5:46 AM, Gao Xiang wrote:
> Flush the D-cache before unlocking folios for compressed inodes, as
> they are dirtied during decompression.
> 
> Avoid calling flush_dcache_folio() on every CPU write, since it's more
> like playing whack-a-mole without real benefit.
> 
> It has no impact on x86 and arm64/risc-v: on x86, flush_dcache_folio()
> is a no-op, and on arm64/risc-v, PG_dcache_clean (PG_arch_1) is clear
> for new page cache folios.  However, certain ARM boards are affected,
> as reported.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Closes: https://lore.kernel.org/r/c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de
> Closes: https://lore.kernel.org/r/38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi Jan and Stefan,
> 
> if possible, please help test this patch on your arm devices,
> many thanks!  I will submit this later but if it's urgent you
> could also apply this locally in advance.
> 

Thank you for the fix and great work, it solved the issue I was seeing 
locally!

> Thanks,
> Gao Xiang
>   fs/erofs/data.c         | 16 +++++++++++-----
>   fs/erofs/decompressor.c | 12 ++++--------
>   fs/erofs/fileio.c       |  4 ++--
>   fs/erofs/internal.h     |  2 +-
>   fs/erofs/zdata.c        |  6 +++---
>   5 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 221e0ff1ed0d..16e4a6bd9b97 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -214,9 +214,11 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   
>   /*
>    * bit 30: I/O error occurred on this folio
> + * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
>    * bit 0 - 29: remaining parts to complete this folio
>    */
> -#define EROFS_ONLINEFOLIO_EIO			(1 << 30)
> +#define EROFS_ONLINEFOLIO_EIO		30
> +#define EROFS_ONLINEFOLIO_DIRTY		29
>   
>   void erofs_onlinefolio_init(struct folio *folio)
>   {
> @@ -233,19 +235,23 @@ void erofs_onlinefolio_split(struct folio *folio)
>   	atomic_inc((atomic_t *)&folio->private);
>   }
>   
> -void erofs_onlinefolio_end(struct folio *folio, int err)
> +void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   {
>   	int orig, v;
>   
>   	do {
>   		orig = atomic_read((atomic_t *)&folio->private);
> -		v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
> +		DBG_BUGON(orig <= 0);
> +		v = dirty << EROFS_ONLINEFOLIO_DIRTY;
> +		v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>   	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>   
> -	if (v & ~EROFS_ONLINEFOLIO_EIO)
> +	if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
>   		return;
>   	folio->private = 0;
> -	folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
> +	if (v & BIT(EROFS_ONLINEFOLIO_DIRTY))
> +		flush_dcache_folio(folio);
> +	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
>   }
>   
>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index bf62e2836b60..358061d7b660 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -301,13 +301,11 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   		cur = min(cur, rq->outputsize);
>   		if (cur && rq->out[0]) {
>   			kin = kmap_local_page(rq->in[nrpages_in - 1]);
> -			if (rq->out[0] == rq->in[nrpages_in - 1]) {
> +			if (rq->out[0] == rq->in[nrpages_in - 1])
>   				memmove(kin + rq->pageofs_out, kin + pi, cur);
> -				flush_dcache_page(rq->out[0]);
> -			} else {
> +			else
>   				memcpy_to_page(rq->out[0], rq->pageofs_out,
>   					       kin + pi, cur);
> -			}
>   			kunmap_local(kin);
>   		}
>   		rq->outputsize -= cur;
> @@ -325,14 +323,12 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
>   			DBG_BUGON(no >= nrpages_out);
>   			cnt = min(insz - pi, PAGE_SIZE - po);
> -			if (rq->out[no] == rq->in[ni]) {
> +			if (rq->out[no] == rq->in[ni])
>   				memmove(kin + po,
>   					kin + rq->pageofs_in + pi, cnt);
> -				flush_dcache_page(rq->out[no]);
> -			} else if (rq->out[no]) {
> +			else if (rq->out[no])
>   				memcpy_to_page(rq->out[no], po,
>   					       kin + rq->pageofs_in + pi, cnt);
> -			}
>   			pi += cnt;
>   		} while (pi < insz);
>   		kunmap_local(kin);
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index fe2cd2982b4b..91781718199e 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -38,7 +38,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   	} else {
>   		bio_for_each_folio_all(fi, &rq->bio) {
>   			DBG_BUGON(folio_test_uptodate(fi.folio));
> -			erofs_onlinefolio_end(fi.folio, ret);
> +			erofs_onlinefolio_end(fi.folio, ret, false);
>   		}
>   	}
>   	bio_uninit(&rq->bio);
> @@ -154,7 +154,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   		}
>   		cur += len;
>   	}
> -	erofs_onlinefolio_end(folio, err);
> +	erofs_onlinefolio_end(folio, err, false);
>   	return err;
>   }
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index a32c03a80c70..0d19bde8c094 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -390,7 +390,7 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
>   void erofs_onlinefolio_init(struct folio *folio);
>   void erofs_onlinefolio_split(struct folio *folio);
> -void erofs_onlinefolio_end(struct folio *folio, int err);
> +void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty);
>   struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
>   int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>   		  struct kstat *stat, u32 request_mask,
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index d80e3bf4fa79..6f8402ed5b28 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1090,7 +1090,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
>   			tight = (bs == PAGE_SIZE);
>   		}
>   	} while ((end = cur) > 0);
> -	erofs_onlinefolio_end(folio, err);
> +	erofs_onlinefolio_end(folio, err, false);
>   	return err;
>   }
>   
> @@ -1195,7 +1195,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_backend *be, int err)
>   			cur += len;
>   		}
>   		kunmap_local(dst);
> -		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
> +		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err, true);
>   		list_del(p);
>   		kfree(bvi);
>   	}
> @@ -1353,7 +1353,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
>   
>   		DBG_BUGON(z_erofs_page_is_invalidated(page));
>   		if (!z_erofs_is_shortlived_page(page)) {
> -			erofs_onlinefolio_end(page_folio(page), err);
> +			erofs_onlinefolio_end(page_folio(page), err, true);
>   			continue;
>   		}
>   		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {

Tested-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>

Best regards,
Stefan

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |


