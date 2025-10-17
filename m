Return-Path: <linux-kernel+bounces-857590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139E3BE7364
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C47B6E24DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8E02BDC3B;
	Fri, 17 Oct 2025 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="ocYX8q5I"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD08269AE9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690049; cv=none; b=DeyWVVGKZgGW7bFl2Y1wZtpD1gDNqcnJDyKHx6QeHVaGU2CklM/DzKRU4Z/gsZJfPGWBYIek3T0ufx3At+X2BHc8F4Y6ELhe+9wKbgFdHBJRAQszMXKjrG2nLHV7bY6RISVUNdRCU9ArUBF57xzZDJ4eA9M/WVtCx+lOM4TPkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690049; c=relaxed/simple;
	bh=woYj9v9ooEWXa0LLD/VbzG5zJhBfXoUHrY99G2gqJ70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8yObp+BB1Vd1pl6iviXoXwerTlCiWydVveVdtoTFNxfS+c7V8IFjM4ok6CLSi+g4K899JwOXs7VKN8qO5j1kqPvkyX1gPvw44aVUmIcdvHdXQgZdQKNX+qIc1ewc6vvZyuu5jAQU28h5xnspgqSbZTfw+2y9Hl1Dt8sPox3A1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=ocYX8q5I; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6354a4b4871so1492405d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1760690044; x=1761294844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bl+kFF5L574qoQ7YLQNLHtgI5y9GagMbykB0zURc8Y=;
        b=ocYX8q5ILL+ifmszHMjPX7rfjpSsnaHa3PMJG0Xg+DSMGf16qaoUCYyfSHqZDGVJlP
         uyOMWLli4PZo+aCWJ0bTwoTGsTsNQXTU42BpPpJRxp9zb8wTKuFj8RyqYZ5Fo42O7+PF
         Z9vn7vZDIzCRQqCvAm3C4BtEHKWG2TMopx0fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760690044; x=1761294844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bl+kFF5L574qoQ7YLQNLHtgI5y9GagMbykB0zURc8Y=;
        b=cHGsEtJ8HYZrWUf5Zp7gyybm8nrs1qIdMCOzuZ4KqUBk6LSHeVs1Ek6cWD5hfPiomY
         l/pCQPkvMV3l0cviU6sBQx3SQMFymCixb0UtVB/ueyP3FxI3+uttL5/xw0B1BpK3X+r2
         W0gVs1lCWryy4xlNXeXfgqw0/Ly4PEBz9Eo2mKYOXX75HLqSVxYuWS7Gh70BdMbMCPe0
         VONHVOME3W4ORjqn64xtQ2E72KU0+F78D94QI8rdg5y8kKKh39IlSiykEiAtZxzNxVNH
         6isy4y/6MLjTipDrtRFwM+Eo3cnoEjnHrPiMPQpyfKREVAsC4J1fTPCz9SXH3MjJA/KN
         gs2g==
X-Forwarded-Encrypted: i=1; AJvYcCU3Hv5nKvGOdl7MEyRJz982eqynKpe7IPljYgFjNUXCE0gAl7SCZf7qOLv074v9cdYzS3RQVLb32i9bUJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVOj0W4ojTwwterUDAdmDHcK/v1fCFoVcmciI3JHHC13PICV4
	F9I090IRarhR5kqapMq5p7uxBcUORfs3Xm3FS/3PN1EFi29PAFgRHV+ZjLtCpfxdpqH6+yZ/kjc
	5h0zhzKsM09LuThcJRssArz93JsSWFFqlKM4LKTxitA==
X-Gm-Gg: ASbGncsavRD4Diro9PBDKrFwGzlojgc4Wzv+CV1sl5UjujfAi1icbgV1HdtKVqhVEvT
	qcIiL+/UAjfd3opy1YCjnyJManbXiavfjtn0QeouQ3bF6k1Sr7k22QGSykfwu1FKN7HMoWCAImx
	Hlo9c2O8TZ+7OpN2EYiAz55cumrAc4gkU96jacp/Qs00wV4DJk6GMfCPBVaaEYRSj/DMT+rvFSu
	KI+F2q1rQaJCcr2DikH2A6Kx/HrSZkeAR5df8uo4JiK2hcyfskaJMUKMqPVnMwE5SvJe9s4TxI/
	DWZkJJdH7K8hVgwYiuM=
X-Google-Smtp-Source: AGHT+IEGO/n0Ph1gF0reYBEXt2kNN5Wn+ClOhDx4OaZ1D41zS2iYqjR07SsZXpqfchDfJUFTpcINKj03eBiP4wBj0LQ=
X-Received: by 2002:a05:690e:144c:b0:638:7df:7009 with SMTP id
 956f58d0204a3-63e161401b6mr2633871d50.28.1760690043447; Fri, 17 Oct 2025
 01:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007065020.495008-1-pavitrakumarm@vayavyalabs.com>
 <20251007065020.495008-3-pavitrakumarm@vayavyalabs.com> <d2ac59ca-5c44-44c0-af9a-cdfda9d4ed1c@ti.com>
In-Reply-To: <d2ac59ca-5c44-44c0-af9a-cdfda9d4ed1c@ti.com>
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Date: Fri, 17 Oct 2025 14:03:52 +0530
X-Gm-Features: AS18NWAKfuobTwBv4OlMcYMmPAFoTwpjR5LrGIGyodO8LZp2XWOim5dW8mG43Dc
Message-ID: <CALxtO0nhk3LeACSisxbLbK1-+A-rV=9-GdF4LL73LhOkAWMc0A@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] Add SPAcc ahash support
To: T Pratham <t-pratham@ti.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, herbert@gondor.apana.org.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Ruud.Derwig@synopsys.com, 
	manjunath.hadli@vayavyalabs.com, adityak@vayavyalabs.com, 
	Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pratham,
   Thanks for the review. My comments are embedded below.

Warm regards,
PK

On Fri, Oct 10, 2025 at 12:23=E2=80=AFPM T Pratham <t-pratham@ti.com> wrote=
:
>
> Hi,
> On 07/10/25 12:20, Pavitrakumar Managutte wrote:
> > Add ahash support to SPAcc driver.
>
> >
> > diff --git a/drivers/crypto/dwc-spacc/spacc_ahash.c b/drivers/crypto/dw=
c-spacc/spacc_ahash.c
> > new file mode 100644
> > index 000000000000..99a609f89eaf
> > --- /dev/null
> > +++ b/drivers/crypto/dwc-spacc/spacc_ahash.c
> > @@ -0,0 +1,980 @@
> > +// SPDX-License-Identifier: GPL-2.0
> [...]> +
> > +static int spacc_hash_init_dma(struct device *dev, struct ahash_reques=
t *req)
> > +{
> > +     int rc =3D -1;
> > +     struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
> > +     struct spacc_crypto_ctx *tctx =3D crypto_ahash_ctx(tfm);
> > +     struct spacc_crypto_reqctx *ctx =3D ahash_request_ctx(req);
> > +
> > +     gfp_t mflags =3D GFP_ATOMIC;
> > +
> > +     if (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP)
> > +             mflags =3D GFP_KERNEL;
>
> GFP_ATOMIC should preferably only be used in contexts which cannot sleep =
(inside interrupt handlers, spinlocks, etc.). Otherwise prefer GFP_KERNEL.
PK: Ack, will fix that.

>
> > +
> > +     ctx->digest_buf =3D dma_pool_alloc(spacc_hash_pool, mflags,
> > +                                      &ctx->digest_dma);
> > +
> > +     if (!ctx->digest_buf)
> > +             return -ENOMEM;
> > +
> > +     rc =3D pdu_ddt_init(dev, &ctx->dst, 1 | 0x80000000);
> > +     if (rc < 0) {
> > +             dev_err(dev, "ERR: PDU DDT init error\n");
> > +             rc =3D -EIO;
> > +             goto err_free_digest;
> > +     }
> > +
> > +     pdu_ddt_add(dev, &ctx->dst, ctx->digest_dma, SPACC_MAX_DIGEST_SIZ=
E);
> > +
> > +     if (ctx->total_nents > 0 && ctx->single_shot) {
> > +             /* single shot */
> > +             spacc_ctx_clone_handle(req);
> > +
> > +             if (req->nbytes) {
> > +                     rc =3D spacc_sg_to_ddt(dev, req->src, req->nbytes=
,
> > +                                          &ctx->src, DMA_TO_DEVICE);
> > +             } else {
> > +                     memset(tctx->tmp_buffer, '\0', PPP_BUF_SIZE);
> > +                     sg_set_buf(&tctx->tmp_sgl[0], tctx->tmp_buffer,
> > +                                PPP_BUF_SIZE);
> > +                     rc =3D spacc_sg_to_ddt(dev, &tctx->tmp_sgl[0],
> > +                                          tctx->tmp_sgl[0].length,
> > +                                          &ctx->src, DMA_TO_DEVICE);
> > +             }
> > +     } else if (ctx->total_nents =3D=3D 0 && req->nbytes =3D=3D 0) {
> > +             spacc_ctx_clone_handle(req);
> > +
> > +             /* zero length case */
> > +             memset(tctx->tmp_buffer, '\0', PPP_BUF_SIZE);
> > +             sg_set_buf(&tctx->tmp_sgl[0], tctx->tmp_buffer, PPP_BUF_S=
IZE);
> > +             rc =3D spacc_sg_to_ddt(dev, &tctx->tmp_sgl[0],
> > +                                  tctx->tmp_sgl[0].length,
> > +                                  &ctx->src, DMA_TO_DEVICE);
> > +     }
> > +
> > +     if (rc < 0)
> > +             goto err_free_dst;
> > +
> > +     ctx->src_nents =3D rc;
> > +
> > +     return rc;
> > +
> > +err_free_dst:
> > +     pdu_ddt_free(&ctx->dst);
> > +err_free_digest:
> > +     dma_pool_free(spacc_hash_pool, ctx->digest_buf, ctx->digest_dma);
> > +
> > +     return rc;
> > +}
> > +
> [...]> +
> > +static int do_shash(struct device *dev, unsigned char *name,
> > +                 unsigned char *result, const u8 *data1,
> > +                 unsigned int data1_len, const u8 *data2,
> > +                 unsigned int data2_len, const u8 *key,
> > +                 unsigned int key_len)
> > +{
> > +     int rc =3D 0;
> > +     unsigned int size;
> > +     struct sdesc *sdesc;
> > +     struct crypto_shash *hash;
> > +
> > +     hash =3D crypto_alloc_shash(name, 0, 0);
> > +     if (IS_ERR(hash)) {
> > +             rc =3D PTR_ERR(hash);
> > +             dev_err(dev, "ERR: Crypto %s allocation error %d\n", name=
, rc);
> > +             return rc;
> > +     }
> > +
> > +     size =3D sizeof(struct shash_desc) + crypto_shash_descsize(hash);
> > +     sdesc =3D kmalloc(size, GFP_KERNEL);
> > +     if (!sdesc) {
> > +             rc =3D -ENOMEM;
> > +             goto do_shash_err;
> > +     }
> > +     sdesc->shash.tfm =3D hash;
> > +
> > +     if (key_len > 0) {
> > +             rc =3D crypto_shash_setkey(hash, key, key_len);
> > +             if (rc) {
> > +                     dev_err(dev, "ERR: Could not setkey %s shash\n", =
name);
> > +                     goto do_shash_err;
> > +             }
> > +     }
> > +
> > +     rc =3D crypto_shash_init(&sdesc->shash);
> > +     if (rc) {
> > +             dev_err(dev, "ERR: Could not init %s shash\n", name);
> > +             goto do_shash_err;
> > +     }
> > +
> > +     rc =3D crypto_shash_update(&sdesc->shash, data1, data1_len);
> > +     if (rc) {
> > +             dev_err(dev, "ERR: Could not update1\n");
> > +             goto do_shash_err;
> > +     }
> > +
> > +     if (data2 && data2_len) {
> > +             rc =3D crypto_shash_update(&sdesc->shash, data2, data2_le=
n);
> > +             if (rc) {
> > +                     dev_err(dev, "ERR: Could not update2\n");
> > +                     goto do_shash_err;
> > +             }
> > +     }
> > +
> > +     rc =3D crypto_shash_final(&sdesc->shash, result);
> > +     if (rc)
> > +             dev_err(dev, "ERR: Could not generate %s hash\n", name);
> > +
> > +do_shash_err:
> > +     crypto_free_shash(hash);
> > +     kfree(sdesc);
> > +
> > +     return rc;
> > +}
> > +
> > +static int spacc_hash_setkey(struct crypto_ahash *tfm, const u8 *key,
> > +                          unsigned int keylen)
> > +{
> > +     int rc =3D 0;
> > +     int ret =3D 0;
> > +     unsigned int block_size;
> > +     unsigned int digest_size;
> > +     char hash_alg[CRYPTO_MAX_ALG_NAME];
> > +     const struct spacc_alg *salg =3D spacc_tfm_ahash(&tfm->base);
> > +     struct spacc_crypto_ctx *tctx =3D crypto_ahash_ctx(tfm);
> > +     struct spacc_priv *priv =3D dev_get_drvdata(tctx->dev);
> > +
> > +     block_size =3D crypto_tfm_alg_blocksize(&tfm->base);
> > +     digest_size =3D crypto_ahash_digestsize(tfm);
> > +
> > +     /*
> > +      * We will not use the hardware in case of HMACs
> If you are always going to do HMAC in software fallback, maybe don't regi=
ster them in your driver? Why go through the unnecessary overhead when the =
users can directly use the software implementation.
> Although, it looks like you are only computing the hashed keys for HMAC h=
ere in software, If that is the case, clarify the comments that you are onl=
y not doing key pre-processing for HMAC in hardware.
PK: Yes, we will update the comment detailing the usage. Yes, we do
HMAC operations on hardware.

>
> Also, all invocations of do_shash function are only below, and all are pa=
ssing (NULL, 0) for (key, keylen). You can just not set the key in the soft=
ware invocation for simple hashing. Same with (data2, data2_len). It is nev=
er used. You can change the function signature and remove these arguments (=
along with, obviously, removing their usage in the function do_shash).
PK: Ack, will update the function signature and the conditions as per
your suggestion.

>
> > +      * This was meant for hashes but it works for cmac/xcbc since we
> > +      * only intend to support 128-bit keys...
> > +      */
> > +     if (keylen > block_size && salg->mode->id !=3D CRYPTO_MODE_MAC_CM=
AC) {
> > +             dev_dbg(salg->dev, "Exceeds keylen: %u\n", keylen);
> > +             dev_dbg(salg->dev, "Req. keylen hashing %s\n",
> > +                     salg->calg->cra_name);
> > +
> > +             memset(hash_alg, 0x00, CRYPTO_MAX_ALG_NAME);
> > +             switch (salg->mode->id) {
> > +             case CRYPTO_MODE_HMAC_SHA224:
> > +                     rc =3D do_shash(salg->dev, "sha224", tctx->ipad, =
key,
> > +                                   keylen, NULL, 0, NULL, 0);
> > +                     break;
> > +
> > +             case CRYPTO_MODE_HMAC_SHA256:
> > +                     rc =3D do_shash(salg->dev, "sha256", tctx->ipad, =
key,
> > +                                   keylen, NULL, 0, NULL, 0);
> > +                     break;
> > +
> > +             case CRYPTO_MODE_HMAC_SHA384:
> > +                     rc =3D do_shash(salg->dev, "sha384", tctx->ipad, =
key,
> > +                                   keylen, NULL, 0, NULL, 0);
> > +                     break;
> > +
> > +             case CRYPTO_MODE_HMAC_SHA512:
> > +                     rc =3D do_shash(salg->dev, "sha512", tctx->ipad, =
key,
> > +                                   keylen, NULL, 0, NULL, 0);
> > +                     break;
> > +
> > +             case CRYPTO_MODE_HMAC_MD5:
> > +                     rc =3D do_shash(salg->dev, "md5", tctx->ipad, key=
,
> > +                                   keylen, NULL, 0, NULL, 0);
> > +                     break;
> > +
> > +             case CRYPTO_MODE_HMAC_SHA1:
> > +                     rc =3D do_shash(salg->dev, "sha1", tctx->ipad, ke=
y,
> > +                                   keylen, NULL, 0, NULL, 0);
> > +                     break;
> > +             case CRYPTO_MODE_HMAC_SM3:
> > +                     rc =3D do_shash(salg->dev, "sm3", tctx->ipad, key=
,
> > +                                   keylen, NULL, 0, NULL, 0);
> > +                     break;
> > +
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (rc < 0) {
> > +                     dev_err(salg->dev, "ERR: %d computing shash for %=
s\n",
> > +                             rc, hash_alg);
> > +                     return -EIO;
> > +             }
> > +
> > +             keylen =3D digest_size;
> > +             dev_dbg(salg->dev, "updated keylen: %u\n", keylen);
> > +
> > +             tctx->ctx_valid =3D false;
> > +
> > +             rc =3D crypto_ahash_setkey(tctx->fb.hash,
> > +                             tctx->ipad, keylen);
> > +             if (rc < 0)
> > +                     return rc;
> > +     } else {
> > +             memcpy(tctx->ipad, key, keylen);
> > +             tctx->ctx_valid =3D false;
> > +
> > +             rc =3D crypto_ahash_setkey(tctx->fb.hash, key, keylen);
> > +             if (rc < 0)
> > +                     return rc;
> > +     }
> > +
> > +     /* close handle since key size may have changed */
> > +     if (tctx->handle >=3D 0) {
> > +             spacc_close(&priv->spacc, tctx->handle);
> > +             put_device(tctx->dev);
> > +             tctx->handle =3D -1;
> > +             tctx->dev =3D NULL;
> > +     }
> > +
> > +     /* reset priv */
> > +     priv =3D NULL;
> > +     priv =3D dev_get_drvdata(salg->dev);
> > +     tctx->dev =3D get_device(salg->dev);
> > +     ret =3D spacc_is_mode_keysize_supported(&priv->spacc, salg->mode-=
>id,
> > +                                           keylen, 1);
> > +     if (ret) {
> > +             /* Grab the spacc context if no one is waiting */
> > +             tctx->handle =3D spacc_open(&priv->spacc,
> > +                                       CRYPTO_MODE_NULL,
> > +                                       salg->mode->id, -1,
> > +                                       0, spacc_digest_cb, tfm);
> > +             if (tctx->handle < 0) {
> > +                     dev_err(salg->dev, "ERR: Failed to open SPAcc con=
text\n");
> > +                     put_device(salg->dev);
> > +                     return -EIO;
> > +             }
> > +
> > +     } else {
> > +             dev_err(salg->dev, "Keylen: %d not enabled for algo: %d",
> > +                     keylen, salg->mode->id);
> > +     }
> > +
> > +     rc =3D spacc_set_operation(&priv->spacc, tctx->handle, OP_ENCRYPT=
,
> > +                              ICV_HASH, IP_ICV_OFFSET, 0, 0, 0);
> > +     if (rc < 0) {
> > +             spacc_close(&priv->spacc, tctx->handle);
> > +             tctx->handle =3D -1;
> > +             put_device(tctx->dev);
> > +             return -EIO;
> > +     }
> > +
> > +     if (salg->mode->id =3D=3D CRYPTO_MODE_MAC_XCBC ||
> > +         salg->mode->id =3D=3D CRYPTO_MODE_MAC_SM4_XCBC) {
> > +             rc =3D spacc_compute_xcbc_key(&priv->spacc, salg->mode->i=
d,
> > +                                         tctx->handle, tctx->ipad,
> > +                                         keylen, tctx->ipad);
> > +             if (rc < 0) {
> > +                     dev_err(tctx->dev,
> > +                             "Failed to compute XCBC key: %d\n", rc);
> > +                     return -EIO;
> > +             }
> > +             rc =3D spacc_write_context(&priv->spacc, tctx->handle,
> > +                                      SPACC_HASH_OPERATION, tctx->ipad=
,
> > +                                      32 + keylen, NULL, 0);
> > +     } else {
> > +             rc =3D spacc_write_context(&priv->spacc, tctx->handle,
> > +                                      SPACC_HASH_OPERATION, tctx->ipad=
,
> > +                                      keylen, NULL, 0);
> > +     }
> > +
> > +     memset(tctx->ipad, 0, sizeof(tctx->ipad));
> > +     if (rc < 0) {
> > +             dev_err(tctx->dev, "ERR: Failed to write SPAcc context\n"=
);
> > +             /* Non-fatal, we continue with the software fallback */
> > +             return 0;
> > +     }
> > +
> > +     tctx->ctx_valid =3D true;
> > +
> > +     return 0;
> > +}
> > +
> [...]> diff --git a/drivers/crypto/dwc-spacc/spacc_core.c b/drivers/crypt=
o/dwc-spacc/spacc_core.c
> > new file mode 100644
> > index 000000000000..ca9fc032d7c6
> > --- /dev/null
> > +++ b/drivers/crypto/dwc-spacc/spacc_core.c
> > @@ -0,0 +1,1292 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> > +
> > +int spacc_sg_to_ddt(struct device *dev, struct scatterlist *sg,
> > +                 int nbytes, struct pdu_ddt *ddt, int dma_direction)
> > +{
> > +     int i;
> > +     int nents;
> > +     int rc =3D 0;
> > +     int orig_nents;
> > +     struct scatterlist *sgl;
> > +     struct scatterlist *sg_entry;
> > +
> > +     orig_nents =3D sg_nents(sg);
> > +     if (orig_nents > 1) {
> > +             sgl =3D sg_last(sg, orig_nents);
> > +             if (sgl->length =3D=3D 0)
> > +                     orig_nents--;
> > +     }
> > +
> > +     nents =3D dma_map_sg(dev, sg, orig_nents, dma_direction);
> > +     if (nents <=3D 0)
> > +             return -ENOMEM;
> > +
> > +     /* require ATOMIC operations */
> Why? spacc_sg_to_ddt() is only being called from spacc_hash_init_dma(), w=
hich in turn is only being called from your crypto_engine's do_one_request =
callback function. This is not in interrupt context. Crypto engine uses wor=
kqueues to schedule these. You don't *NEED* GFP_ATOMIC allocations here.
PK: Ack, will fix that

>   > +   rc =3D pdu_ddt_init(dev, ddt, nents | 0x80000000);
> > +     if (rc < 0) {
> > +             dma_unmap_sg(dev, sg, nents, dma_direction);
> dma_unmap_sg() should be called with the same number of nents as dma_map_=
sg() was called, not the mapped nents returned by it.
PK: Ack, will fix that.

>
> > +             return -EIO;
> > +     }
> > +
> > +     for_each_sg(sg, sg_entry, nents, i) {
> > +             pdu_ddt_add(dev, ddt, sg_dma_address(sg_entry),
> > +                         sg_dma_len(sg_entry));
> > +     }
> > +
> > +     dma_sync_sg_for_device(dev, sg, nents, dma_direction);
> > +
> > +     return nents;
>
> This return value is set in your ctx->src_nents. You'll also need to corr=
ect the dma_unmap_sg() in your cleanup functions.
PK: Yes, this is handled wherever spacc_sg_to_ddt is getting called.

>
> > +}
> > +
>
> > diff --git a/drivers/crypto/dwc-spacc/spacc_device.c b/drivers/crypto/d=
wc-spacc/spacc_device.c
> > new file mode 100644
> > index 000000000000..b8b47915f4ca
> > --- /dev/null
> > +++ b/drivers/crypto/dwc-spacc/spacc_device.c
> > @@ -0,0 +1,283 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/completion.h>
> > +#include <linux/workqueue.h>
> > +#include <crypto/engine.h>
> > +#include "spacc_device.h"
> > +
> > +static void spacc_cmd_process(struct spacc_device *spacc, int x)
> > +{
> > +     struct spacc_priv *priv =3D container_of(spacc, struct spacc_priv=
, spacc);
> > +
> > +     if (!work_pending(&priv->pop_jobs))
> > +             queue_work(priv->spacc_wq, &priv->pop_jobs);
> > +}
> > +
> > +static void spacc_stat_process(struct spacc_device *spacc)
> > +{
> > +     struct spacc_priv *priv =3D container_of(spacc, struct spacc_priv=
, spacc);
> > +
> > +     if (!work_pending(&priv->pop_jobs))
> > +             queue_work(priv->spacc_wq, &priv->pop_jobs);
> > +}
> > +
> > +static int spacc_init_device(struct platform_device *pdev)
> > +{
> > +     void __iomem *baseaddr;
> > +     struct pdu_info   info;
> > +     struct spacc_priv *priv;
> > +     int err =3D 0;
> > +     int ret =3D 0;
> > +     int oldmode;
> > +     int irq_num;
> > +     int irq_ret;
> > +     const u64 oldtimer =3D SPACC_OLD_TIMER;
> > +
> > +     /* initialize DDT DMA pools based on this device's resources */
> > +     if (pdu_mem_init(&pdev->dev)) {
> > +             dev_err(&pdev->dev, "Could not initialize DMA pools\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv) {
> > +             err =3D -ENOMEM;
> > +             goto free_ddt_mem_pool;
> > +     }
> > +
> > +     /* default to little-endian */
> > +     priv->spacc.config.big_endian    =3D false;
> > +     priv->spacc.config.little_endian =3D true;
> > +
> > +     priv->spacc.config.oldtimer =3D oldtimer;
> > +
> > +     /* Set the SPAcc internal counter value from kernel config */
> > +     priv->spacc.config.timer =3D (u64)CONFIG_CRYPTO_DEV_SPACC_INTERNA=
L_COUNTER;
> > +     dev_dbg(&pdev->dev, "SPAcc internal counter set to: %llu\n",
> > +             priv->spacc.config.timer);
> > +
> > +     baseaddr =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(baseaddr)) {
> > +             dev_err(&pdev->dev, "Unable to map iomem\n");
> > +             err =3D PTR_ERR(baseaddr);
> > +             goto free_ddt_mem_pool;
> > +     }
> > +
> > +     pdu_get_version(baseaddr, &info);
> > +
> > +     ret =3D spacc_init(baseaddr, &priv->spacc, &info);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "Failed to initialize SPAcc device\n"=
);
> > +             err =3D ret;
> > +             goto free_ddt_mem_pool;
> > +     }
> > +
> > +     /* Set the priority from kernel config */
> > +     priv->spacc.config.priority =3D CONFIG_CRYPTO_DEV_SPACC_PRIORITY;
> > +     dev_dbg(&pdev->dev, "VSPACC priority set from config: %u\n",
> > +             priv->spacc.config.priority);
> > +
> > +     /* Set the priority for this virtual SPAcc instance */
> > +     spacc_set_priority(&priv->spacc, priv->spacc.config.priority);
> > +
> > +     /* Initialize crypto engine */
> > +     priv->engine =3D crypto_engine_alloc_init(&pdev->dev, true);
> > +     if (!priv->engine) {
> > +             dev_err(&pdev->dev, "Could not allocate crypto engine\n")=
;
> > +             err =3D -ENOMEM;
> > +             goto free_spacc_ctx;
> > +     }
> > +
> > +     err =3D crypto_engine_start(priv->engine);
> > +     if (err) {
> > +             dev_err(&pdev->dev, "Could not start crypto engine\n");
> > +             goto free_engine;
> > +     }
> > +
> > +     priv->spacc_wq =3D alloc_workqueue("spacc_workqueue", WQ_UNBOUND,=
 0);
> > +     if (!priv->spacc_wq) {
> > +             err =3D -ENOMEM;
> > +             goto stop_engine;
> > +     }
> > +
> > +     INIT_WORK(&priv->pop_jobs, spacc_pop_jobs);
> > +     spacc_irq_glbl_disable(&priv->spacc);
> > +
> > +     priv->spacc.dptr =3D &pdev->dev;
> > +     platform_set_drvdata(pdev, priv);
> > +
> > +     irq_num =3D platform_get_irq(pdev, 0);
> > +     if (irq_num < 0) {
> > +             err =3D irq_num;
> > +             goto free_spacc_workq;
> > +     }
> > +
> > +     /* determine configured maximum message length */
> > +     priv->max_msg_len =3D priv->spacc.config.max_msg_size;
> > +
> > +     irq_ret =3D devm_request_irq(&pdev->dev, irq_num, spacc_irq_handl=
er,
> > +                          IRQF_SHARED, dev_name(&pdev->dev),
> > +                          &pdev->dev);
> > +     if (irq_ret) {
> > +             dev_err(&pdev->dev, "Failed to request IRQ : %d\n", irq_r=
et);
> > +             err =3D irq_ret;
> > +             goto free_spacc_workq;
> > +     }
> > +
> > +     priv->spacc.irq_cb_stat =3D spacc_stat_process;
> > +     priv->spacc.irq_cb_cmdx =3D spacc_cmd_process;
> > +     oldmode                 =3D priv->spacc.op_mode;
> > +     priv->spacc.op_mode     =3D SPACC_OP_MODE_IRQ;
> > +
> > +     /* Enable STAT and CMD interrupts */
> > +     spacc_irq_stat_enable(&priv->spacc, 1);
> > +     spacc_irq_cmdx_enable(&priv->spacc, 0, 1);
> > +     spacc_irq_stat_wd_disable(&priv->spacc);
> > +     spacc_irq_glbl_enable(&priv->spacc);
> > +
> > +#if IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_AUTODETECT)
> > +
> > +     err =3D spacc_autodetect(&priv->spacc);
> > +     if (err < 0) {
> > +             spacc_irq_glbl_disable(&priv->spacc);
> > +             goto free_spacc_workq;
> > +     }
> > +#else
> > +     err =3D spacc_static_config(&priv->spacc);
> > +     if (err < 0) {
> > +             spacc_irq_glbl_disable(&priv->spacc);
> > +             goto free_spacc_workq;
> > +     }
> > +#endif
> > +
> > +     priv->spacc.op_mode =3D oldmode;
> > +     if (priv->spacc.op_mode =3D=3D SPACC_OP_MODE_IRQ) {
> > +             priv->spacc.irq_cb_stat =3D spacc_stat_process;
> > +             priv->spacc.irq_cb_cmdx =3D spacc_cmd_process;
> > +
> > +             /* Enable STAT and CMD interrupts */
> > +             spacc_irq_stat_enable(&priv->spacc, 1);
> > +             spacc_irq_cmdx_enable(&priv->spacc, 0, 1);
> > +             spacc_irq_glbl_enable(&priv->spacc);
> > +     } else {
> > +             priv->spacc.irq_cb_stat =3D spacc_stat_process;
> > +             priv->spacc.irq_cb_stat_wd =3D spacc_stat_process;
> > +
> > +             spacc_irq_stat_enable(&priv->spacc,
> > +                                   priv->spacc.config.ideal_stat_level=
);
> > +
> > +             /* Enable STAT and WD interrupts */
> > +             spacc_irq_cmdx_disable(&priv->spacc, 0);
> > +             spacc_irq_stat_wd_enable(&priv->spacc);
> > +             spacc_irq_glbl_enable(&priv->spacc);
> > +
> > +             /* enable the wd by setting the wd_timer =3D 100000 */
> > +             spacc_set_wd_count(&priv->spacc,
> > +                                priv->spacc.config.wd_timer =3D
> > +                                             priv->spacc.config.timer)=
;
> > +     }
> > +
> > +     /* unlock normal */
> > +     if (priv->spacc.config.is_secure_port) {
> > +             u32 t;
> > +
> > +             t =3D readl(baseaddr + SPACC_REG_SECURE_CTRL);
> > +             t &=3D ~(1UL << 31);
> > +             writel(t, baseaddr + SPACC_REG_SECURE_CTRL);
> > +     }
> > +
> > +     /* unlock device by default */
> > +     writel(0, baseaddr + SPACC_REG_SECURE_CTRL);
> > +
> > +     return err;
> > +
> > +free_spacc_workq:
> > +     flush_workqueue(priv->spacc_wq);
> > +     destroy_workqueue(priv->spacc_wq);
>
> destroy_workqueue() calls __flush_workqueue() (through drain_workqueue())=
. Just use destroy_workqueue().
PK: Ack, will fix that.

>
> > +
> > +stop_engine:
> > +     crypto_engine_stop(priv->engine);
> > +
> > +free_engine:
> > +     crypto_engine_exit(priv->engine);
>
> crypto_engine_exit() calls crypto_engine_stop(). Just call crypto_engine_=
exit()
PK: Ack, will fix that

>
> > +
> > +free_spacc_ctx:
> > +     spacc_fini(&priv->spacc);
> > +
> > +free_ddt_mem_pool:
> > +     pdu_mem_deinit(&pdev->dev);
> > +
> > +     return err;
> > +}
> > +
> > +static void spacc_unregister_algs(void)
> > +{
> > +#if IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_HASH)
> > +     spacc_unregister_hash_algs();
> > +#endif
> > +}
> > +
> > +static int spacc_crypto_probe(struct platform_device *pdev)
> > +{
> > +     int rc =3D 0;
> > +
> > +     rc =3D spacc_init_device(pdev);
> > +     if (rc < 0)
> > +             goto err;
> > +
> > +#if IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_HASH)
> > +     rc =3D spacc_probe_hashes(pdev);
> > +     if (rc < 0)
> > +             goto err;
> > +#endif
> > +
> > +     return 0;
> > +err:
> > +     spacc_unregister_algs();
> > +
> > +     return rc;
> > +}
> > +
> > +static void spacc_crypto_remove(struct platform_device *pdev)
> > +{
> > +     struct spacc_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +     if (priv->engine) {
> > +             crypto_engine_stop(priv->engine);
> > +             crypto_engine_exit(priv->engine);
>
> Again, same.
PK: Ack, will fix that.

>
> > +     }
> > +
> > +     if (priv->spacc_wq) {
> > +             flush_workqueue(priv->spacc_wq);
> > +             destroy_workqueue(priv->spacc_wq);
>
> Again, same.
PK: Ack, will fix that

>
> > +     }
> > +
> > +     spacc_unregister_algs();
> > +     spacc_remove(pdev);
> > +}
> > +
> > +static const struct of_device_id snps_spacc_id[] =3D {
> > +     {.compatible =3D "snps,nsimosci-hs-spacc" },
> > +     { /* sentinel */        }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, snps_spacc_id);
> > +
> > +static struct platform_driver spacc_driver =3D {
> > +     .probe  =3D spacc_crypto_probe,
> > +     .remove =3D spacc_crypto_remove,
> > +     .driver =3D {
> > +             .name  =3D "spacc",
> > +             .of_match_table =3D snps_spacc_id,
> > +     },
> > +};
> > +
> > +module_platform_driver(spacc_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Synopsys, Inc.");
> > +MODULE_DESCRIPTION("SPAcc Crypto Accelerator Driver");
>
> --
> Regards
> T Pratham <t-pratham@ti.com>

