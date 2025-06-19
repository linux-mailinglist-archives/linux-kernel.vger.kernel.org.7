Return-Path: <linux-kernel+bounces-693203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C612CADFC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 06:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F316189E5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 04:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C202523AE95;
	Thu, 19 Jun 2025 04:03:54 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28C2397B0;
	Thu, 19 Jun 2025 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305834; cv=none; b=N7fOLm64l7fB9W4DJpfuGxeHuCTvRmHJ602SXFZpCK563FxK9ZXz0Hm1xrAer7s8EF7es6gkYvOCfGa/+1S1USxfwtK8jCahk8CkVXK7HfqY7L9eAATlROHStDVh1+w9+k+A3pBt908tOdZj8Ev55yH0Wg3xNKJCsEaMfeVu0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305834; c=relaxed/simple;
	bh=2KqMlmnXfHZYWVpveY4kKwsTNSn+4JDMucn3XUOzvO0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PRx0xLc6KfeFaH4YGzaetaM5NTxElxp148YXuoni6OJaw3VS8G8HrbERKJXIbHl2WKCHnAmGYBavNj0urRF8dvbQNcSTPBp5kSFmBp16PuL108s25KlyB7pYtCub+Tx5mm81K9X+bhJMP689PM8mH02atgm8vJqEuPBtn7ltLb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bN6Nv18mcz1d2Kk;
	Thu, 19 Jun 2025 12:01:35 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AAE2180237;
	Thu, 19 Jun 2025 12:03:47 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 12:03:46 +0800
Subject: Re: [PATCH] crypto: hisilicon - Use fine grained DMA mapping
 direction
To: Zenghui Yu <yuzenghui@huawei.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<qianweili@huawei.com>, <wangzhou1@hisilicon.com>, <shenyang39@huawei.com>,
	<wanghaibin.wang@huawei.com>
References: <20250618100026.1586-1-yuzenghui@huawei.com>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <f9624bb5-641e-a461-177d-80978fa92ec2@huawei.com>
Date: Thu, 19 Jun 2025 12:03:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250618100026.1586-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500015.china.huawei.com (7.185.36.143)

On 2025/6/18 18:00, Zenghui Yu wrote:
> The following splat was triggered when booting the kernel built with
> arm64's defconfig + CRYPTO_SELFTESTS + DMA_API_DEBUG.
> 
>  ------------[ cut here ]------------
>  DMA-API: hisi_sec2 0000:75:00.0: cacheline tracking EEXIST, overlapping mappings aren't supported
>  WARNING: CPU: 24 PID: 1273 at kernel/dma/debug.c:596 add_dma_entry+0x248/0x308
> 
>  Call trace:
>   add_dma_entry+0x248/0x308 (P)
>   debug_dma_map_sg+0x208/0x3e4
>   __dma_map_sg_attrs+0xbc/0x118
>   dma_map_sg_attrs+0x10/0x24
>   hisi_acc_sg_buf_map_to_hw_sgl+0x80/0x218 [hisi_qm]
>   sec_cipher_map+0xc4/0x338 [hisi_sec2]
>   sec_aead_sgl_map+0x18/0x24 [hisi_sec2]
>   sec_process+0xb8/0x36c [hisi_sec2]
>   sec_aead_crypto+0xe4/0x264 [hisi_sec2]
>   sec_aead_encrypt+0x14/0x20 [hisi_sec2]
>   crypto_aead_encrypt+0x24/0x38
>   test_aead_vec_cfg+0x480/0x7e4
>   test_aead_vec+0x84/0x1b8
>   alg_test_aead+0xc0/0x498
>   alg_test.part.0+0x518/0x524
>   alg_test+0x20/0x64
>   cryptomgr_test+0x24/0x44
>   kthread+0x130/0x1fc
>   ret_from_fork+0x10/0x20
>  ---[ end trace 0000000000000000 ]---
>  DMA-API: Mapped at:
>   debug_dma_map_sg+0x234/0x3e4
>   __dma_map_sg_attrs+0xbc/0x118
>   dma_map_sg_attrs+0x10/0x24
>   hisi_acc_sg_buf_map_to_hw_sgl+0x80/0x218 [hisi_qm]
>   sec_cipher_map+0xc4/0x338 [hisi_sec2]
> 
> This occurs in selftests where the input and the output scatterlist point
> to the same underlying memory (e.g., when tested with INPLACE_TWO_SGLISTS
> mode).
> 
> The problem is that the hisi_sec2 driver maps these two different
> scatterlists using the DMA_BIDIRECTIONAL flag which leads to overlapped
> write mappings which are not supported by the DMA layer.
> 
> Fix it by using the fine grained and correct DMA mapping directions. While
> at it, switch the DMA directions used by the hisi_zip driver too.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> The hisi_zip part has not been tested due to a lack of HW. I'd appreciate
> it if someone could help to test it.
> 
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 21 +++++++++++++--------
>  drivers/crypto/hisilicon/sgl.c             | 15 ++++++++-------
>  drivers/crypto/hisilicon/zip/zip_crypto.c  | 13 +++++++------
>  include/linux/hisi_acc_qm.h                |  4 ++--
>  4 files changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
> index 8ea5305bc320..7d04e770a8c2 100644
> --- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
> +++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
> @@ -965,6 +965,7 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
>  	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
>  	struct sec_alg_res *res = &qp_ctx->res[req->req_id];
>  	struct device *dev = ctx->dev;
> +	enum dma_data_direction src_direction;
>  	int ret;
>  
>  	if (req->use_pbuf) {
> @@ -990,10 +991,11 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
>  		a_req->out_mac_dma = res->out_mac_dma;
>  	}
>  
> +	src_direction = dst == src ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
>  	req->in = hisi_acc_sg_buf_map_to_hw_sgl(dev, src,
>  						qp_ctx->c_in_pool,
>  						req->req_id,
> -						&req->in_dma);
> +						&req->in_dma, src_direction);
>  	if (IS_ERR(req->in)) {
>  		dev_err(dev, "fail to dma map input sgl buffers!\n");
>  		return PTR_ERR(req->in);
> @@ -1003,7 +1005,7 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
>  		ret = sec_aead_mac_init(a_req);
>  		if (unlikely(ret)) {
>  			dev_err(dev, "fail to init mac data for ICV!\n");
> -			hisi_acc_sg_buf_unmap(dev, src, req->in);
> +			hisi_acc_sg_buf_unmap(dev, src, req->in, src_direction);
>  			return ret;
>  		}
>  	}
> @@ -1015,11 +1017,12 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
>  		c_req->c_out = hisi_acc_sg_buf_map_to_hw_sgl(dev, dst,
>  							     qp_ctx->c_out_pool,
>  							     req->req_id,
> -							     &c_req->c_out_dma);
> +							     &c_req->c_out_dma,
> +							     DMA_FROM_DEVICE);
>  
>  		if (IS_ERR(c_req->c_out)) {
>  			dev_err(dev, "fail to dma map output sgl buffers!\n");
> -			hisi_acc_sg_buf_unmap(dev, src, req->in);
> +			hisi_acc_sg_buf_unmap(dev, src, req->in, src_direction);
>  			return PTR_ERR(c_req->c_out);
>  		}
>  	}
> @@ -1036,10 +1039,12 @@ static void sec_cipher_unmap(struct sec_ctx *ctx, struct sec_req *req,
>  	if (req->use_pbuf) {
>  		sec_cipher_pbuf_unmap(ctx, req, dst);
>  	} else {
> -		if (dst != src)
> -			hisi_acc_sg_buf_unmap(dev, src, req->in);
> -
> -		hisi_acc_sg_buf_unmap(dev, dst, c_req->c_out);
> +		if (dst != src) {
> +			hisi_acc_sg_buf_unmap(dev, dst, c_req->c_out, DMA_FROM_DEVICE);
> +			hisi_acc_sg_buf_unmap(dev, src, req->in, DMA_TO_DEVICE);
> +		} else {
> +			hisi_acc_sg_buf_unmap(dev, src, req->in, DMA_BIDIRECTIONAL);
> +		}
>  	}
>  }
>  
> diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
> index c974f95cd126..7a9ef2a9972a 100644
> --- a/drivers/crypto/hisilicon/sgl.c
> +++ b/drivers/crypto/hisilicon/sgl.c
> @@ -210,15 +210,15 @@ static void clear_hw_sgl_sge(struct hisi_acc_hw_sgl *hw_sgl)
>   * @pool: Pool which hw sgl memory will be allocated in.
>   * @index: Index of hisi_acc_hw_sgl in pool.
>   * @hw_sgl_dma: The dma address of allocated hw sgl.
> + * @dir: DMA direction.
>   *
>   * This function builds hw sgl according input sgl, user can use hw_sgl_dma
>   * as src/dst in its BD. Only support single hw sgl currently.
>   */
>  struct hisi_acc_hw_sgl *
> -hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
> -			      struct scatterlist *sgl,
> -			      struct hisi_acc_sgl_pool *pool,
> -			      u32 index, dma_addr_t *hw_sgl_dma)
> +hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev, struct scatterlist *sgl,
> +			      struct hisi_acc_sgl_pool *pool, u32 index,
> +			      dma_addr_t *hw_sgl_dma, enum dma_data_direction dir)
>  {
>  	struct hisi_acc_hw_sgl *curr_hw_sgl;
>  	unsigned int i, sg_n_mapped;
> @@ -232,7 +232,7 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
>  
>  	sg_n = sg_nents(sgl);
>  
> -	sg_n_mapped = dma_map_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
> +	sg_n_mapped = dma_map_sg(dev, sgl, sg_n, dir);
>  	if (!sg_n_mapped) {
>  		dev_err(dev, "DMA mapping for SG error!\n");
>  		return ERR_PTR(-EINVAL);
> @@ -276,16 +276,17 @@ EXPORT_SYMBOL_GPL(hisi_acc_sg_buf_map_to_hw_sgl);
>   * @dev: The device which hw sgl belongs to.
>   * @sgl: Related scatterlist.
>   * @hw_sgl: Virtual address of hw sgl.
> + * @dir: DMA direction.
>   *
>   * This function unmaps allocated hw sgl.
>   */
>  void hisi_acc_sg_buf_unmap(struct device *dev, struct scatterlist *sgl,
> -			   struct hisi_acc_hw_sgl *hw_sgl)
> +			   struct hisi_acc_hw_sgl *hw_sgl, enum dma_data_direction dir)
>  {
>  	if (!dev || !sgl || !hw_sgl)
>  		return;
>  
> -	dma_unmap_sg(dev, sgl, sg_nents(sgl), DMA_BIDIRECTIONAL);
> +	dma_unmap_sg(dev, sgl, sg_nents(sgl), dir);
>  	clear_hw_sgl_sge(hw_sgl);
>  	hw_sgl->entry_sum_in_chain = 0;
>  	hw_sgl->entry_sum_in_sgl = 0;
> diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
> index 7327f8f29b01..b97513981a3b 100644
> --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
> +++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
> @@ -224,7 +224,8 @@ static int hisi_zip_do_work(struct hisi_zip_qp_ctx *qp_ctx,
>  		return -EINVAL;
>  
>  	req->hw_src = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->src, pool,
> -						    req->req_id << 1, &req->dma_src);
> +						    req->req_id << 1, &req->dma_src,
> +						    DMA_TO_DEVICE);
>  	if (IS_ERR(req->hw_src)) {
>  		dev_err(dev, "failed to map the src buffer to hw sgl (%ld)!\n",
>  			PTR_ERR(req->hw_src));
> @@ -233,7 +234,7 @@ static int hisi_zip_do_work(struct hisi_zip_qp_ctx *qp_ctx,
>  
>  	req->hw_dst = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->dst, pool,
>  						    (req->req_id << 1) + 1,
> -						    &req->dma_dst);
> +						    &req->dma_dst, DMA_FROM_DEVICE);
>  	if (IS_ERR(req->hw_dst)) {
>  		ret = PTR_ERR(req->hw_dst);
>  		dev_err(dev, "failed to map the dst buffer to hw slg (%d)!\n",
> @@ -258,9 +259,9 @@ static int hisi_zip_do_work(struct hisi_zip_qp_ctx *qp_ctx,
>  	return -EINPROGRESS;
>  
>  err_unmap_output:
> -	hisi_acc_sg_buf_unmap(dev, a_req->dst, req->hw_dst);
> +	hisi_acc_sg_buf_unmap(dev, a_req->dst, req->hw_dst, DMA_FROM_DEVICE);
>  err_unmap_input:
> -	hisi_acc_sg_buf_unmap(dev, a_req->src, req->hw_src);
> +	hisi_acc_sg_buf_unmap(dev, a_req->src, req->hw_src, DMA_TO_DEVICE);
>  	return ret;
>  }
>  
> @@ -303,8 +304,8 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
>  		err = -EIO;
>  	}
>  
> -	hisi_acc_sg_buf_unmap(dev, acomp_req->src, req->hw_src);
> -	hisi_acc_sg_buf_unmap(dev, acomp_req->dst, req->hw_dst);
> +	hisi_acc_sg_buf_unmap(dev, acomp_req->dst, req->hw_dst, DMA_FROM_DEVICE);
> +	hisi_acc_sg_buf_unmap(dev, acomp_req->src, req->hw_src, DMA_TO_DEVICE);
>  
>  	acomp_req->dlen = ops->get_dstlen(sqe);
>  
> diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
> index 99fcf65d575f..0c4c84b8c3be 100644
> --- a/include/linux/hisi_acc_qm.h
> +++ b/include/linux/hisi_acc_qm.h
> @@ -556,9 +556,9 @@ int hisi_qm_mb(struct hisi_qm *qm, u8 cmd, dma_addr_t dma_addr, u16 queue,
>  struct hisi_acc_sgl_pool;
>  struct hisi_acc_hw_sgl *hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
>  	struct scatterlist *sgl, struct hisi_acc_sgl_pool *pool,
> -	u32 index, dma_addr_t *hw_sgl_dma);
> +	u32 index, dma_addr_t *hw_sgl_dma, enum dma_data_direction dir);
>  void hisi_acc_sg_buf_unmap(struct device *dev, struct scatterlist *sgl,
> -			   struct hisi_acc_hw_sgl *hw_sgl);
> +			   struct hisi_acc_hw_sgl *hw_sgl, enum dma_data_direction dir);
>  struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
>  						   u32 count, u32 sge_nr);
>  void hisi_acc_free_sgl_pool(struct device *dev,
>
Reviewed-by: Longfang Liu <liulongfang@huawei.com>

Thanks.
Longfang.

