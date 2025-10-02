Return-Path: <linux-kernel+bounces-840487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D65BB4880
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A95C19E2051
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCD25A642;
	Thu,  2 Oct 2025 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3KwLwoY"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA942580F2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422399; cv=none; b=VzaxtxOx4a04wMxMBFgG5en7HMKALsu9LJiuteVAImShCRpTX+QWungNSQVrYP8HUVkJV3etC0/JBX8JdAg9nPnEC2IRFy0ejQRdcQjJLLyk25d4rL7CK8V23LpNCgWLKZMf7orMt6VjiIFXj6km6/eO9OH8VYOPQEljapKooxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422399; c=relaxed/simple;
	bh=RDxFvlg72f/lSXbDrZ3EoR5QbnP7TNw4xC6FjhYPZbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6sEF+qPG9+J03yMT7TjvUB6nQg3GCNNbGF2PYyEEwGuXA5LcANnWiksygAfTHdIvhutnl/yu59DTmv2LO02KnHykFpwhmGhLT1pW2EUdkwGpihAoMa5PgFDdP6XlHZAP/yhnYmRn393WeFW7wKjkBsYgNWbhu+NJai4LV6oV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3KwLwoY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so1601134a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422397; x=1760027197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEl7XEhzoZTfrEG35GV29SFkrgNgycUaXOG7zaQQy0M=;
        b=Q3KwLwoY+gLJjwYP0bvMzKE5VlRX5L7vKxnf7F+JF6n0BlztIw30ZtaLV2oTSg3Hpa
         mD8b+7or7ef0J49xSVa0bS8Ik/1Kd+ceiyJc1MtS4gjCDc5n2reSeqznv6iT79NnGxoP
         t92dGwAxK0g7n0ke7/zkUcEp3Qpfbyz3PZ0SeNLt+ivbR4S9FbOfodTYRrzcnlSzgQhh
         yiEAgA99EkQfxAhBcCDHt8GG5FbxkbJBtE1lH10b1odflVvwUoWowi8ns2s2SY1rLtui
         GSFoMR/cFRCi6az1myfMxMZczs9Vgdo+epBVEMZrQn1NkhSTrqUzPfZhXOmxHYoroCuR
         hLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422397; x=1760027197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEl7XEhzoZTfrEG35GV29SFkrgNgycUaXOG7zaQQy0M=;
        b=Ni0UTuBmrxAqF2Y75gDdeg9E0edwcSuHorXnQutxkDFm25NsllhbQiN+8JYncgUldx
         dhpyVBpA8UIE7XZJerTi9Wc7NuyILrWQfBuVG/U6ALF7K7weM3Vc+MNhG6OT2gvHGLpJ
         3Pcox4iJrtfcw0Yic6PnZ+lZjV+Fu38XOvoTOeOMSpkkBNm4nNTosT8VoTMol10HZ9Jw
         lXYu5CcfC09HwjjU67oeeJR0YLQdmPYzYrdxuCfZbdLEbaYA7iwRFX6YgRvHil099Sl/
         /BY5HpQp2/vSUF+ddUp8MHXmZgXa2hyZb0BU6R/Fj6zRYswh8U0kfnFhetueZNJnb9ur
         dLkA==
X-Forwarded-Encrypted: i=1; AJvYcCVM+4khpSQE+HUp3qWDq81QfvfB0uaOF7aFqDwqNKTfWhZJUzNQ2Ub0hsQmR7cwKZtDL8otOtkPd5s2bAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4VE4QytxT1AjaVmvfayuKqzMrCZ71XBogtwL/SdVFdDBb+5h
	eRgq3HOV4xFFpGY/Hedw9B2WakWrt5ywINZ+5uaz96qH3d8AXxm/Eso4Iu+Sg+sUyi+20vfdsAP
	bsq1Uuek1lGpDpmCbvaiMcOioOHrMFnc=
X-Gm-Gg: ASbGncuSn5yiGpSEdAQHvygGU35YRXzLdy/SBN3/0ttYJWyMx6/aaj32FRYc7N4Kx5o
	O6MLrBS50lRfBUVgNdSW+vx0wBoZyJSOVRl+knp8YUrMronFIOkT/1thivaz+aaOYuuUVdR9ShA
	4tnzgK5gsGQIjodOT0Rwfaiz13Q2CVsoLriL2ZCNt6Pq0o2xCf3awhZSXjA6ohUGCwstbf7I/Ta
	taHE5q6VatwwtUKaP6K5eVc+qPP9ck=
X-Google-Smtp-Source: AGHT+IGHD2+2E8K4vJLrKLdazZjBTXnk9FPpgrQ9I3hiACihPhpo2kv/hmAK0UembqrM3UH/3wW323YnXfoDzzpoJwY=
X-Received: by 2002:a17:90b:4f86:b0:327:e018:204a with SMTP id
 98e67ed59e1d1-339c267cdafmr12153a91.0.1759422396742; Thu, 02 Oct 2025
 09:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820133209.389065-1-mbloch@nvidia.com> <20250820133209.389065-4-mbloch@nvidia.com>
In-Reply-To: <20250820133209.389065-4-mbloch@nvidia.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:31:34 -0400
X-Gm-Features: AS18NWBMrAtI4XnmoNczD-HkkKE2yx9dtJFB--xC8gtNJ5qupFEyGmU7-QLGrbA
Message-ID: <CALC8CXdAXnYSQqskwc=0V9oRiRh92L32zyKDBLPPAUX65Sawsw@mail.gmail.com>
Subject: Re: [PATCH V2 net 3/8] net/mlx5e: Preserve tc-bw during parent changes
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, przemyslaw.kitszel@intel.com, 
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Bloch.
Finally a normal name on this list.

(the rest is "Massive Dong Wang", and similar)

On Wed, Aug 20, 2025 at 10:03=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wro=
te:
>
> From: Carolina Jubran <cjubran@nvidia.com>
>
> When changing parent of a node/leaf with tc-bw configured, the code
> saves and restores tc-bw values. However, it was reading the converted
> hardware bw_share values (where 0 becomes 1) instead of the original
> user values, causing incorrect tc-bw calculations after parent change.
>
> Store original tc-bw values in the node structure and use them directly
> for save/restore operations.
>
> Fixes: cf7e73770d1b ("net/mlx5: Manage TC arbiter nodes and implement ful=
l support for tc-bw")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/=
net/ethernet/mellanox/mlx5/core/esw/qos.c
> index cd58d3934596..4ed5968f1638 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> @@ -102,6 +102,8 @@ struct mlx5_esw_sched_node {
>         u8 level;
>         /* Valid only when this node represents a traffic class. */
>         u8 tc;
> +       /* Valid only for a TC arbiter node or vport TC arbiter. */
> +       u32 tc_bw[DEVLINK_RATE_TCS_MAX];
>  };
>
>  static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *no=
de)
> @@ -609,10 +611,7 @@ static void
>  esw_qos_tc_arbiter_get_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_=
node,
>                                  u32 *tc_bw)
>  {
> -       struct mlx5_esw_sched_node *vports_tc_node;
> -
> -       list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, e=
ntry)
> -               tc_bw[vports_tc_node->tc] =3D vports_tc_node->bw_share;
> +       memcpy(tc_bw, tc_arbiter_node->tc_bw, sizeof(tc_arbiter_node->tc_=
bw));
>  }
>
>  static void
> @@ -629,6 +628,7 @@ esw_qos_set_tc_arbiter_bw_shares(struct mlx5_esw_sche=
d_node *tc_arbiter_node,
>                 u8 tc =3D vports_tc_node->tc;
>                 u32 bw_share;
>
> +               tc_arbiter_node->tc_bw[tc] =3D tc_bw[tc];
>                 bw_share =3D tc_bw[tc] * fw_max_bw_share;
>                 bw_share =3D esw_qos_calc_bw_share(bw_share, divider,
>                                                  fw_max_bw_share);
> @@ -1060,6 +1060,7 @@ static void esw_qos_vport_disable(struct mlx5_vport=
 *vport, struct netlink_ext_a
>                 esw_qos_vport_tc_disable(vport, extack);
>
>         vport_node->bw_share =3D 0;
> +       memset(vport_node->tc_bw, 0, sizeof(vport_node->tc_bw));
>         list_del_init(&vport_node->entry);
>         esw_qos_normalize_min_rate(vport_node->esw, vport_node->parent, e=
xtack);
>
> @@ -1231,8 +1232,9 @@ static int esw_qos_vport_update(struct mlx5_vport *=
vport,
>                                 struct mlx5_esw_sched_node *parent,
>                                 struct netlink_ext_ack *extack)
>  {
> -       struct mlx5_esw_sched_node *curr_parent =3D vport->qos.sched_node=
->parent;
> -       enum sched_node_type curr_type =3D vport->qos.sched_node->type;
> +       struct mlx5_esw_sched_node *vport_node =3D vport->qos.sched_node;
> +       struct mlx5_esw_sched_node *curr_parent =3D vport_node->parent;
> +       enum sched_node_type curr_type =3D vport_node->type;
>         u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] =3D {0};
>         int err;
>
> @@ -1244,10 +1246,8 @@ static int esw_qos_vport_update(struct mlx5_vport =
*vport,
>         if (err)
>                 return err;
>
> -       if (curr_type =3D=3D SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type=
 =3D=3D type) {
> -               esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node,
> -                                                curr_tc_bw);
> -       }
> +       if (curr_type =3D=3D SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type=
 =3D=3D type)
> +               esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
>
>         esw_qos_vport_disable(vport, extack);
>
> @@ -1258,8 +1258,8 @@ static int esw_qos_vport_update(struct mlx5_vport *=
vport,
>         }
>
>         if (curr_type =3D=3D SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type=
 =3D=3D type) {
> -               esw_qos_set_tc_arbiter_bw_shares(vport->qos.sched_node,
> -                                                curr_tc_bw, extack);
> +               esw_qos_set_tc_arbiter_bw_shares(vport_node, curr_tc_bw,
> +                                                extack);
>         }
>
>         return err;
> --
> 2.34.1
>
>

