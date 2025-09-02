Return-Path: <linux-kernel+bounces-797262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6978CB40E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28143563CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6173345758;
	Tue,  2 Sep 2025 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLDJtlli"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAECF33A017
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842552; cv=none; b=bTsbYqcrl6XSl2BusrCDLMQDxUMRR7sUTw7fGEkFCxGqd6RcHwBq9wRVy6Jph7CjWEsL1lxWEJAWKfDlpyJMbkA3k1Kwx0CSTemzMijSdDhwkIxmO3BNlyhpb899pi8YgmbFwGuIQl6I0gJakspeTq1i3ue8UQuwZ4wcAUu1wZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842552; c=relaxed/simple;
	bh=QFBqrW6F5Vyt21S63UOIvlqqJvNpT5+U0B+Qaf7WKIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L06XIRnCK6wvgQjsmqgp8b0W70SirX5aWizvhuOlX4lREMkmQryaoQ7MI+2DmQfyCWPWxqMUQxdPKSGWjW8oQkvlGmOyPiKZGUr67mhhc8W3NXO2ZQzSBH7/NSt1pvH8cWdmTcXGK8g6yoOlOGrn2DR1SfNAnoRlXFE8tq0PNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLDJtlli; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-248e01cd834so13567905ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756842550; x=1757447350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZrJzjNN0QlDLj0vfcPh9SEUHqyDDGkZ1h573MQls1s=;
        b=mLDJtlliqjQqBBiEcYfLEm8xhX8+8LEapUhtZGo8XWS+5iRLksG2GxLGmMjd2k2DX1
         WvuXatmvjAD75oxcrpynJ7DPJ4m2UvK4zY0Gsdnsc/Eo04A+D/szmWjpapw2dqv+sBW6
         CE+6vY0HXdhU//WUZqlz/I0Plqf23f1KGt/vC3APtzMPDEmYkvdkoVkUoEBeq27AdM0W
         89kYJQyd7FKdw2BZThBB95+zlTpHvQ911MtNO5oqGqMA/ljBMh86Ai5nMKKIp9kT67bb
         UGf9g317RgrT/3pf5Y4iUB5jChaVQ6Z6Gm7RQoPt/0xqrK5nvceI83s92OvwteIWQQR4
         vvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756842550; x=1757447350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZrJzjNN0QlDLj0vfcPh9SEUHqyDDGkZ1h573MQls1s=;
        b=vqjX1OKsuBseuSrPDID34sDTT4YSBrG//PBt00uaGsk7osDhwR0QXcSxVGgzIwUmVC
         oIV1OIvI3oGGqwD36b/LD6aadMP8WgTBEuf8jU1/XQUHh5+gWPi+72acAhadwrCuq/XL
         /HnfU6Bms8sT/9fmmW5fMrii806b7omVk6+RjfTGQlun2UPzIhd2iTRhfUnHs5o0MVwy
         s1CR+gnJwjP9CsFcYOqItXq9NJgxmJWZZVm2nxHJQcDDBGCmNczeNrEXNDXVKguJmvax
         cRpvpLrwDjVxLZdGvoIJw1bFSMk2jqJxtM9ED/hNAWN6zb3O1SHGV/LmKlT4bOXIRYAR
         XQQw==
X-Forwarded-Encrypted: i=1; AJvYcCVi4prTbk2JxWpw0ft0635tXj19tAwC0OcwLyiVaycfhlk8Sk9KdG3vK9fzsCqFZfklBFMOS1Fup+XEIUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wQMF50Neu5uthnLpm6ae2mzOCvXTuOzt/LrCTBp1TNoon2UW
	O/2mDNvIfJ2JLkJEgQDugodvbm684jKIfZ5E674gwstCBy9ZVJ/E0TRhmqXt19yUo2ceSwiU3hH
	1ndaLWIQoMiNFDvcAfDu++40rWYlI7Ew=
X-Gm-Gg: ASbGncsNzlE+JxBYgI3B0jt1M/u0k1tbGVe0app0vKFaS1dvkMWG3c/AuUGxS4KdD1J
	/0GmfECCW39cTYPfUsHrT3hSf9PrC/vjTHjHrbWPzP8uJZSquzBXL5UxnnlWgGTQbvOpERrMo91
	cNRhqAl5FcWoJ2X41OQG73FlQbqtJZb71RIML2gy6gAmI5TEvwSGMgEp0DQsh5JB9w8FAiXhReo
	gjkX/8=
X-Google-Smtp-Source: AGHT+IEa8QiJX4CsIEDJGOCx3sa8QxonCxav59S9DASAsFKU1PmGfJN7YsFXMKeyP0zuoGIuzyqRUSPWkFGszkaE0GI=
X-Received: by 2002:a17:903:1ae3:b0:24b:677:6d4e with SMTP id
 d9443c01a7336-24b06776f6dmr32179615ad.8.1756842549788; Tue, 02 Sep 2025
 12:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902175034.2056708-1-lizhi.hou@amd.com>
In-Reply-To: <20250902175034.2056708-1-lizhi.hou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 15:48:58 -0400
X-Gm-Features: Ac12FXy7_LGcF9wjnRdLbh4CcmYwE-83ZCDxIcHHLx-jZ-Bho7zK6Cmki_LnFqw
Message-ID: <CADnq5_MvdU0v7uF8hvA=kkopGAEA=M4DDw8wAGSQMnihfSnKRw@mail.gmail.com>
Subject: Re: [PATCH V3] accel/amdxdna: Add ioctl DRM_IOCTL_AMDXDNA_GET_ARRAY
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: ogabbay@kernel.org, quic_jhugo@quicinc.com, 
	jacek.lawrynowicz@linux.intel.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com, 
	mario.limonciello@amd.com, maciej.falkowski@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:09=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote:
>
> Add interface for applications to get information array. The application
> provides a buffer pointer along with information type, maximum number of
> entries and maximum size of each entry. The buffer may also contain match
> conditions based on the information type. After the ioctl completes, the
> actual number of entries and entry size are returned.
>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Link: https://lore.kernel.org/r/20250827203031.1512508-1-lizhi.hou@amd.co=
m

Do you have a link to the proposed userspace which uses this new IOCTL?

Alex

> ---
>  drivers/accel/amdxdna/aie2_pci.c        | 116 ++++++++++++++++++------
>  drivers/accel/amdxdna/amdxdna_pci_drv.c |  30 ++++++
>  drivers/accel/amdxdna/amdxdna_pci_drv.h |   1 +
>  include/uapi/drm/amdxdna_accel.h        | 111 +++++++++++++++++++++++
>  4 files changed, 232 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie=
2_pci.c
> index 7a3449541107..87c425e3d2b9 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -785,11 +785,12 @@ static int aie2_get_clock_metadata(struct amdxdna_c=
lient *client,
>
>  static int aie2_hwctx_status_cb(struct amdxdna_hwctx *hwctx, void *arg)
>  {
> -       struct amdxdna_drm_query_hwctx *tmp __free(kfree) =3D NULL;
> -       struct amdxdna_drm_get_info *get_info_args =3D arg;
> -       struct amdxdna_drm_query_hwctx __user *buf;
> +       struct amdxdna_drm_hwctx_entry *tmp __free(kfree) =3D NULL;
> +       struct amdxdna_drm_get_array *array_args =3D arg;
> +       struct amdxdna_drm_hwctx_entry __user *buf;
> +       u32 size;
>
> -       if (get_info_args->buffer_size < sizeof(*tmp))
> +       if (!array_args->num_element)
>                 return -EINVAL;
>
>         tmp =3D kzalloc(sizeof(*tmp), GFP_KERNEL);
> @@ -802,14 +803,23 @@ static int aie2_hwctx_status_cb(struct amdxdna_hwct=
x *hwctx, void *arg)
>         tmp->num_col =3D hwctx->num_col;
>         tmp->command_submissions =3D hwctx->priv->seq;
>         tmp->command_completions =3D hwctx->priv->completed;
> -
> -       buf =3D u64_to_user_ptr(get_info_args->buffer);
> -
> -       if (copy_to_user(buf, tmp, sizeof(*tmp)))
> +       tmp->pasid =3D hwctx->client->pasid;
> +       tmp->priority =3D hwctx->qos.priority;
> +       tmp->gops =3D hwctx->qos.gops;
> +       tmp->fps =3D hwctx->qos.fps;
> +       tmp->dma_bandwidth =3D hwctx->qos.dma_bandwidth;
> +       tmp->latency =3D hwctx->qos.latency;
> +       tmp->frame_exec_time =3D hwctx->qos.frame_exec_time;
> +       tmp->state =3D AMDXDNA_HWCTX_STATE_ACTIVE;
> +
> +       buf =3D u64_to_user_ptr(array_args->buffer);
> +       size =3D min(sizeof(*tmp), array_args->element_size);
> +
> +       if (copy_to_user(buf, tmp, size))
>                 return -EFAULT;
>
> -       get_info_args->buffer +=3D sizeof(*tmp);
> -       get_info_args->buffer_size -=3D sizeof(*tmp);
> +       array_args->buffer +=3D size;
> +       array_args->num_element--;
>
>         return 0;
>  }
> @@ -817,23 +827,24 @@ static int aie2_hwctx_status_cb(struct amdxdna_hwct=
x *hwctx, void *arg)
>  static int aie2_get_hwctx_status(struct amdxdna_client *client,
>                                  struct amdxdna_drm_get_info *args)
>  {
> +       struct amdxdna_drm_get_array array_args;
>         struct amdxdna_dev *xdna =3D client->xdna;
> -       struct amdxdna_drm_get_info info_args;
>         struct amdxdna_client *tmp_client;
>         int ret;
>
>         drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>
> -       info_args.buffer =3D args->buffer;
> -       info_args.buffer_size =3D args->buffer_size;
> -
> +       array_args.element_size =3D sizeof(struct amdxdna_drm_query_hwctx=
);
> +       array_args.buffer =3D args->buffer;
> +       array_args.num_element =3D args->buffer_size / array_args.element=
_size;
>         list_for_each_entry(tmp_client, &xdna->client_list, node) {
> -               ret =3D amdxdna_hwctx_walk(tmp_client, &info_args, aie2_h=
wctx_status_cb);
> +               ret =3D amdxdna_hwctx_walk(tmp_client, &array_args,
> +                                        aie2_hwctx_status_cb);
>                 if (ret)
>                         break;
>         }
>
> -       args->buffer_size =3D (u32)(info_args.buffer - args->buffer);
> +       args->buffer_size -=3D (u32)(array_args.buffer - args->buffer);
>         return ret;
>  }
>
> @@ -877,6 +888,58 @@ static int aie2_get_info(struct amdxdna_client *clie=
nt, struct amdxdna_drm_get_i
>         return ret;
>  }
>
> +static int aie2_query_ctx_status_array(struct amdxdna_client *client,
> +                                      struct amdxdna_drm_get_array *args=
)
> +{
> +       struct amdxdna_drm_get_array array_args;
> +       struct amdxdna_dev *xdna =3D client->xdna;
> +       struct amdxdna_client *tmp_client;
> +       int ret;
> +
> +       drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +       array_args.element_size =3D min(args->element_size,
> +                                     sizeof(struct amdxdna_drm_hwctx_ent=
ry));
> +       array_args.buffer =3D args->buffer;
> +       array_args.num_element =3D args->num_element * args->element_size=
 /
> +                               array_args.element_size;
> +       list_for_each_entry(tmp_client, &xdna->client_list, node) {
> +               ret =3D amdxdna_hwctx_walk(tmp_client, &array_args,
> +                                        aie2_hwctx_status_cb);
> +               if (ret)
> +                       break;
> +       }
> +
> +       args->element_size =3D array_args.element_size;
> +       args->num_element =3D (u32)((array_args.buffer - args->buffer) /
> +                                 args->element_size);
> +
> +       return ret;
> +}
> +
> +static int aie2_get_array(struct amdxdna_client *client,
> +                         struct amdxdna_drm_get_array *args)
> +{
> +       struct amdxdna_dev *xdna =3D client->xdna;
> +       int ret, idx;
> +
> +       if (!drm_dev_enter(&xdna->ddev, &idx))
> +               return -ENODEV;
> +
> +       switch (args->param) {
> +       case DRM_AMDXDNA_HW_CONTEXT_ALL:
> +               ret =3D aie2_query_ctx_status_array(client, args);
> +               break;
> +       default:
> +               XDNA_ERR(xdna, "Not supported request parameter %u", args=
->param);
> +               ret =3D -EOPNOTSUPP;
> +       }
> +       XDNA_DBG(xdna, "Got param %d", args->param);
> +
> +       drm_dev_exit(idx);
> +       return ret;
> +}
> +
>  static int aie2_set_power_mode(struct amdxdna_client *client,
>                                struct amdxdna_drm_set_state *args)
>  {
> @@ -926,15 +989,16 @@ static int aie2_set_state(struct amdxdna_client *cl=
ient,
>  }
>
>  const struct amdxdna_dev_ops aie2_ops =3D {
> -       .init           =3D aie2_init,
> -       .fini           =3D aie2_fini,
> -       .resume         =3D aie2_hw_resume,
> -       .suspend        =3D aie2_hw_suspend,
> -       .get_aie_info   =3D aie2_get_info,
> -       .set_aie_state  =3D aie2_set_state,
> -       .hwctx_init     =3D aie2_hwctx_init,
> -       .hwctx_fini     =3D aie2_hwctx_fini,
> -       .hwctx_config   =3D aie2_hwctx_config,
> -       .cmd_submit     =3D aie2_cmd_submit,
> +       .init =3D aie2_init,
> +       .fini =3D aie2_fini,
> +       .resume =3D aie2_hw_resume,
> +       .suspend =3D aie2_hw_suspend,
> +       .get_aie_info =3D aie2_get_info,
> +       .set_aie_state =3D aie2_set_state,
> +       .hwctx_init =3D aie2_hwctx_init,
> +       .hwctx_fini =3D aie2_hwctx_fini,
> +       .hwctx_config =3D aie2_hwctx_config,
> +       .cmd_submit =3D aie2_cmd_submit,
>         .hmm_invalidate =3D aie2_hmm_invalidate,
> +       .get_array =3D aie2_get_array,
>  };
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index 8ef5e4f27f5e..0a1fd55e745e 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -26,6 +26,13 @@ MODULE_FIRMWARE("amdnpu/17f0_10/npu.sbin");
>  MODULE_FIRMWARE("amdnpu/17f0_11/npu.sbin");
>  MODULE_FIRMWARE("amdnpu/17f0_20/npu.sbin");
>
> +/*
> + * 0.0: Initial version
> + * 0.1: Support getting all hardware contexts by DRM_IOCTL_AMDXDNA_GET_A=
RRAY
> + */
> +#define AMDXDNA_DRIVER_MAJOR           0
> +#define AMDXDNA_DRIVER_MINOR           1
> +
>  /*
>   * Bind the driver base on (vendor_id, device_id) pair and later use the
>   * (device_id, rev_id) pair as a key to select the devices. The devices =
with
> @@ -164,6 +171,26 @@ static int amdxdna_drm_get_info_ioctl(struct drm_dev=
ice *dev, void *data, struct
>         return ret;
>  }
>
> +static int amdxdna_drm_get_array_ioctl(struct drm_device *dev, void *dat=
a,
> +                                      struct drm_file *filp)
> +{
> +       struct amdxdna_client *client =3D filp->driver_priv;
> +       struct amdxdna_dev *xdna =3D to_xdna_dev(dev);
> +       struct amdxdna_drm_get_array *args =3D data;
> +       int ret;
> +
> +       if (!xdna->dev_info->ops->get_array)
> +               return -EOPNOTSUPP;
> +
> +       if (args->pad || !args->num_element || !args->element_size)
> +               return -EINVAL;
> +
> +       mutex_lock(&xdna->dev_lock);
> +       ret =3D xdna->dev_info->ops->get_array(client, args);
> +       mutex_unlock(&xdna->dev_lock);
> +       return ret;
> +}
> +
>  static int amdxdna_drm_set_state_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
>  {
>         struct amdxdna_client *client =3D filp->driver_priv;
> @@ -195,6 +222,7 @@ static const struct drm_ioctl_desc amdxdna_drm_ioctls=
[] =3D {
>         DRM_IOCTL_DEF_DRV(AMDXDNA_EXEC_CMD, amdxdna_drm_submit_cmd_ioctl,=
 0),
>         /* AIE hardware */
>         DRM_IOCTL_DEF_DRV(AMDXDNA_GET_INFO, amdxdna_drm_get_info_ioctl, 0=
),
> +       DRM_IOCTL_DEF_DRV(AMDXDNA_GET_ARRAY, amdxdna_drm_get_array_ioctl,=
 0),
>         DRM_IOCTL_DEF_DRV(AMDXDNA_SET_STATE, amdxdna_drm_set_state_ioctl,=
 DRM_ROOT_ONLY),
>  };
>
> @@ -218,6 +246,8 @@ const struct drm_driver amdxdna_drm_drv =3D {
>         .fops =3D &amdxdna_fops,
>         .name =3D "amdxdna_accel_driver",
>         .desc =3D "AMD XDNA DRM implementation",
> +       .major =3D AMDXDNA_DRIVER_MAJOR,
> +       .minor =3D AMDXDNA_DRIVER_MINOR,
>         .open =3D amdxdna_drm_open,
>         .postclose =3D amdxdna_drm_close,
>         .ioctls =3D amdxdna_drm_ioctls,
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdx=
dna/amdxdna_pci_drv.h
> index b6b3b424d1d5..72d6696d49da 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -58,6 +58,7 @@ struct amdxdna_dev_ops {
>         int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct amdxdna_sch=
ed_job *job, u64 *seq);
>         int (*get_aie_info)(struct amdxdna_client *client, struct amdxdna=
_drm_get_info *args);
>         int (*set_aie_state)(struct amdxdna_client *client, struct amdxdn=
a_drm_set_state *args);
> +       int (*get_array)(struct amdxdna_client *client, struct amdxdna_dr=
m_get_array *args);
>  };
>
>  /*
> diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_=
accel.h
> index ce523e9ccc52..a1fb9785db77 100644
> --- a/include/uapi/drm/amdxdna_accel.h
> +++ b/include/uapi/drm/amdxdna_accel.h
> @@ -34,6 +34,7 @@ enum amdxdna_drm_ioctl_id {
>         DRM_AMDXDNA_EXEC_CMD,
>         DRM_AMDXDNA_GET_INFO,
>         DRM_AMDXDNA_SET_STATE,
> +       DRM_AMDXDNA_GET_ARRAY =3D 10,
>  };
>
>  /**
> @@ -455,6 +456,112 @@ struct amdxdna_drm_get_info {
>         __u64 buffer; /* in/out */
>  };
>
> +#define AMDXDNA_HWCTX_STATE_IDLE       0
> +#define AMDXDNA_HWCTX_STATE_ACTIVE     1
> +
> +/**
> + * struct amdxdna_drm_hwctx_entry - The hardware context array entry
> + */
> +struct amdxdna_drm_hwctx_entry {
> +       /** @context_id: Context ID. */
> +       __u32 context_id;
> +       /** @start_col: Start AIE array column assigned to context. */
> +       __u32 start_col;
> +       /** @num_col: Number of AIE array columns assigned to context. */
> +       __u32 num_col;
> +       /** @hwctx_id: The real hardware context id. */
> +       __u32 hwctx_id;
> +       /** @pid: ID of process which created this context. */
> +       __s64 pid;
> +       /** @command_submissions: Number of commands submitted. */
> +       __u64 command_submissions;
> +       /** @command_completions: Number of commands completed. */
> +       __u64 command_completions;
> +       /** @migrations: Number of times been migrated. */
> +       __u64 migrations;
> +       /** @preemptions: Number of times been preempted. */
> +       __u64 preemptions;
> +       /** @errors: Number of errors happened. */
> +       __u64 errors;
> +       /** @priority: Context priority. */
> +       __u64 priority;
> +       /** @heap_usage: Usage of device heap buffer. */
> +       __u64 heap_usage;
> +       /** @suspensions: Number of times been suspended. */
> +       __u64 suspensions;
> +       /**
> +        * @state: Context state.
> +        * %AMDXDNA_HWCTX_STATE_IDLE
> +        * %AMDXDNA_HWCTX_STATE_ACTIVE
> +        */
> +       __u32 state;
> +       /** @pasid: PASID been bound. */
> +       __u32 pasid;
> +       /** @gops: Giga operations per second. */
> +       __u32 gops;
> +       /** @fps: Frames per second. */
> +       __u32 fps;
> +       /** @dma_bandwidth: DMA bandwidth. */
> +       __u32 dma_bandwidth;
> +       /** @latency: Frame response latency. */
> +       __u32 latency;
> +       /** @frame_exec_time: Frame execution time. */
> +       __u32 frame_exec_time;
> +       /** @txn_op_idx: Index of last control code executed. */
> +       __u32 txn_op_idx;
> +       /** @ctx_pc: Program counter. */
> +       __u32 ctx_pc;
> +       /** @fatal_error_type: Fatal error type if context crashes. */
> +       __u32 fatal_error_type;
> +       /** @fatal_error_exception_type: Firmware exception type. */
> +       __u32 fatal_error_exception_type;
> +       /** @fatal_error_exception_pc: Firmware exception program counter=
. */
> +       __u32 fatal_error_exception_pc;
> +       /** @fatal_error_app_module: Exception module name. */
> +       __u32 fatal_error_app_module;
> +       /** @pad: Structure pad. */
> +       __u32 pad;
> +};
> +
> +#define DRM_AMDXDNA_HW_CONTEXT_ALL     0
> +
> +/**
> + * struct amdxdna_drm_get_array - Get information array.
> + */
> +struct amdxdna_drm_get_array {
> +       /**
> +        * @param:
> +        *
> +        * Supported params:
> +        *
> +        * %DRM_AMDXDNA_HW_CONTEXT_ALL:
> +        * Returns all created hardware contexts.
> +        */
> +       __u32 param;
> +       /**
> +        * @element_size:
> +        *
> +        * Specifies maximum element size and returns the actual element =
size.
> +        */
> +       __u32 element_size;
> +       /**
> +        * @num_element:
> +        *
> +        * Specifies maximum number of elements and returns the actual nu=
mber
> +        * of elements.
> +        */
> +       __u32 num_element; /* in/out */
> +       /** @pad: MBZ */
> +       __u32 pad;
> +       /**
> +        * @buffer:
> +        *
> +        * Specifies the match conditions and returns the matched informa=
tion
> +        * array.
> +        */
> +       __u64 buffer;
> +};
> +
>  enum amdxdna_drm_set_param {
>         DRM_AMDXDNA_SET_POWER_MODE,
>         DRM_AMDXDNA_WRITE_AIE_MEM,
> @@ -519,6 +626,10 @@ struct amdxdna_drm_set_power_mode {
>         DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDXDNA_SET_STATE, \
>                  struct amdxdna_drm_set_state)
>
> +#define DRM_IOCTL_AMDXDNA_GET_ARRAY \
> +       DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDXDNA_GET_ARRAY, \
> +                struct amdxdna_drm_get_array)
> +
>  #if defined(__cplusplus)
>  } /* extern c end */
>  #endif
> --
> 2.34.1
>

