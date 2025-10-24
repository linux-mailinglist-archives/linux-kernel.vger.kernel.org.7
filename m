Return-Path: <linux-kernel+bounces-868165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D4EC048D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99EBA3511B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339F263F4A;
	Fri, 24 Oct 2025 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eh6tsion"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96A20D51C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288535; cv=none; b=ZiSSXxw1JNxpT2WqvRtv5J8SHaEUR9WtyfX806D762M/63vaezViD/b+3HPq9ap9ocwjrbORTyKH5+zIgUUMxKTQ3SXcLLJ/SgDiH1l3dW/dK9klkcJ8JVIGHPnNd+DqF6ktbTcnI+DTBPyWrmdGcW6Hf9Bxkq+x/4hHO45TT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288535; c=relaxed/simple;
	bh=HI9l/2GIrQPo+OXf5z20Y7MBqsrplan07TM4+RZsXTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCpZsC5oA1AB87O4ZnGSIdXHgET+SIcTWjIVFFLHCQNciG6NSaMKdca6woM+aWpA6oZW9jqjqS25Imlv/X5834Q/0aurmCMTBLFmk0MVywf5/HEUGK3b/uPPnYjoeJ9ZVQxYnLnd5csqK8AWTDqdFdfXfWI+H2jSAdcJL1tiTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eh6tsion; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eb76ed8ae7so20698211cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761288533; x=1761893333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/38FhIYGOVCZ7MM1NZOLC3UOgmd5FAvjDkVzze7LWGc=;
        b=Eh6tsiong86Pm3n+EucuBXRRd7JXX6lUAjTRLoHn8tr2CdmBvM89uoliUIx/45MizU
         pBSGEyrd+pjZ1rG/Jdufp6iCiXM8+ZG6t0oIGKVbkdFBYLOlp1yjqlNVsfTeaKt9LyPj
         UB9WXtEYdNlomk5mhaC3iFL+DcZTf3FUbikO1J+wXVBEu+JKIAAzAxukhnRzG7W2g4fR
         j7hKvA869SbvcoDsAjc1bdH4QCepcJw8K21a8Try+z+BDlqvVvIpXCXR7nc+KdfOAeKJ
         5B8D/TovOa+2GNwuEpJJtjRT2i5+C6ACGAl6KXTJjciyVKCaIzhtdzqR/72kwOT/2n5+
         +sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288533; x=1761893333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/38FhIYGOVCZ7MM1NZOLC3UOgmd5FAvjDkVzze7LWGc=;
        b=DrSz0kJNo7oauFfBlOrrZt7caRvMNJbdX3RNIyhof2TtCc2pO8pk94Q4pHR4XHo6w+
         oJLzGiZ+y7FuIk5YdTntexGVrEVlonbG6IMt2gWoYQQGKL2Egi7seCJeHVMCoZwp6XZU
         JlEknjW61ixde1TJV8D9AvanDakG2t5iTDSThfpSOTUv28Im8ACxt1gE91Y/ho1nE63j
         s+K4JH18q71HP86lCmHw3xhq4lsuYThSXn3FoIJfLv13y56oZe5OpbYdFNrJRF/uHZpz
         kfVF9ewDWa2K20ND9yNh8FJRXZTyixJ0i8X1ra14y1H6t7W2JiicQS6fYpCUt4zGvw6h
         h4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUmEokRLj6Y50V8Rknem0B+tA92pKkSorPkvscUIvuLkJu81dpn7OtW4Fcbnbnlo4GlOioRLmnSc0X0iiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8vdpQhkVRGoB3s62ldHI/GNgD754eWqoTSKlt8FVl9YMnM1Tq
	L9xBcIBQhqK0tAfYI0TpbNVgJrabs7bJGZtbZ/QeBkr3b6o+KQNzfxTLS1fI0ovn8wBplA8LVxA
	v8ZcSmhep2ZvRgLgorh+OLnnvioUJzTvHzOsvlXOv
X-Gm-Gg: ASbGncvB1UyISMKOfjFdMi7NkT5cUr0G0I+2zD0pGi13iYeTLexD9i/IFIeycUssy8s
	D9QW9pc1XiaUuvBisW/tjGw8CZQr0egPpXqd9iIt6AEXK7h4qbvD7omjYQcf6+RCIi2gqHZOSfk
	4M6u6quLpPKyUz+9RwGfCFDdzW+Zb7sivGF6cLLRoq0nnj0gWzJ7gQ2QjpUL3XypwmiTKo4d2Kl
	cI5X4Sv8G1K7raV18B3Q11sYLMpB5vEuD5+oFCyDti4eejfp2+IUO7YNCFaO484Ej1Qfx4=
X-Google-Smtp-Source: AGHT+IHz9+Kk5P5ITHsdBuOTCRFJzAnsm7mtNFupn2U2Xh9LEoGYGLXVzAAhuxrjf4nzlJMYd+ek8HpIpfphSsXi2zc=
X-Received: by 2002:a05:622a:1812:b0:4e8:9402:a809 with SMTP id
 d75a77b69052e-4e89d263d69mr327730481cf.31.1761288532540; Thu, 23 Oct 2025
 23:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024044849.1098222-1-hkelam@marvell.com>
In-Reply-To: <20251024044849.1098222-1-hkelam@marvell.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Oct 2025 23:48:41 -0700
X-Gm-Features: AS18NWCsCWO67Hn4gcPy4NieUathy_Bq1iDFs0NmxaeR0ICyoCyRSU7NsuJa4Yg
Message-ID: <CANn89iKVpihmWn8u3AT-zEX0aDU6tD+c9KhjNriTRNxTcofuzg@mail.gmail.com>
Subject: Re: [RFC net-next] net: loopback: Extend netdev features with new
 loopback modes
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:49=E2=80=AFPM Hariprasad Kelam <hkelam@marvell.co=
m> wrote:
>
> This patch enhances loopback support by exposing new loopback modes
> (e.g., MAC, SERDES) to userspace. These new modes are added extension
> to the existing netdev features.
>
> This allows users to select the loopback at specific layer.
>
> Below are new modes added:
>
> MAC near end loopback
>
> MAC far end loopback
>
> SERDES loopback
>
> Depending on the feedback will submit ethtool changes.
>
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  Documentation/networking/netdev-features.rst  | 15 +++
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 93 ++++++++++++++++++-
>  include/linux/netdev_features.h               |  9 +-
>  net/ethtool/common.c                          |  3 +
>  4 files changed, 116 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/netdev-features.rst b/Documentation=
/networking/netdev-features.rst
> index 02bd7536fc0c..dcad5e875f32 100644
> --- a/Documentation/networking/netdev-features.rst
> +++ b/Documentation/networking/netdev-features.rst
> @@ -193,3 +193,18 @@ frames in hardware.
>
>  This should be set for devices which support netmem TX. See
>  Documentation/networking/netmem.rst
> +
> +* mac-nearend-loopback
> +
> +This requests that the NIC enables MAC nearend loopback i.e egress traff=
ic is
> +routed back to ingress traffic.
> +
> +* mac-farend-loopback
> +
> +This requests that the NIC enables MAC farend loopback i.e ingress traff=
ic is
> +routed back to egress traffic.
> +
> +
> +* serdes-loopback
> +
> +This request that the NIC enables SERDES near end digital loopback.
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index e808995703cf..14be6a9206c8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1316,6 +1316,84 @@ static int otx2_cgx_config_loopback(struct otx2_ni=
c *pf, bool enable)
>         return err;
>  }
>
> +static int otx2_cgx_mac_nearend_loopback(struct otx2_nic *pf, bool enabl=
e)
> +{
> +       struct msg_req *msg;
> +       int err;
> +
> +       if (enable && !bitmap_empty(pf->flow_cfg->dmacflt_bmap,
> +                                   pf->flow_cfg->dmacflt_max_flows))
> +               netdev_warn(pf->netdev,
> +                           "CGX/RPM nearend loopback might not work as D=
MAC filters are active\n");
> +
> +       mutex_lock(&pf->mbox.lock);
> +       if (enable)
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_enable(&pf->mbox);
> +       else
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_disable(&pf->mbox)=
;
> +
> +       if (!msg) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -ENOMEM;
> +       }
> +
> +       err =3D otx2_sync_mbox_msg(&pf->mbox);
> +       mutex_unlock(&pf->mbox.lock);
> +       return err;
> +}
> +
> +static int otx2_cgx_mac_farend_loopback(struct otx2_nic *pf, bool enable=
)
> +{
> +       struct msg_req *msg;
> +       int err;
> +
> +       if (enable && !bitmap_empty(pf->flow_cfg->dmacflt_bmap,
> +                                   pf->flow_cfg->dmacflt_max_flows))
> +               netdev_warn(pf->netdev,
> +                           "CGX/RPM farend loopback might not work as DM=
AC filters are active\n");
> +
> +       mutex_lock(&pf->mbox.lock);
> +       if (enable)
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_enable(&pf->mbox);
> +       else
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_disable(&pf->mbox)=
;
> +
> +       if (!msg) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -ENOMEM;
> +       }
> +
> +       err =3D otx2_sync_mbox_msg(&pf->mbox);
> +       mutex_unlock(&pf->mbox.lock);
> +       return err;
> +}
> +
> +static int otx2_cgx_serdes_loopback(struct otx2_nic *pf, bool enable)
> +{
> +       struct msg_req *msg;
> +       int err;
> +
> +       if (enable && !bitmap_empty(pf->flow_cfg->dmacflt_bmap,
> +                                   pf->flow_cfg->dmacflt_max_flows))
> +               netdev_warn(pf->netdev,
> +                           "CGX/RPM serdes loopback might not work as DM=
AC filters are active\n");
> +
> +       mutex_lock(&pf->mbox.lock);
> +       if (enable)
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_enable(&pf->mbox);
> +       else
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_disable(&pf->mbox)=
;
> +
> +       if (!msg) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -ENOMEM;
> +       }
> +
> +       err =3D otx2_sync_mbox_msg(&pf->mbox);
> +       mutex_unlock(&pf->mbox.lock);
> +       return err;
> +}
> +
>  int otx2_set_real_num_queues(struct net_device *netdev,
>                              int tx_queues, int rx_queues)
>  {
> @@ -2363,6 +2441,18 @@ static int otx2_set_features(struct net_device *ne=
tdev,
>                 return cn10k_ipsec_ethtool_init(netdev,
>                                                 features & NETIF_F_HW_ESP=
);
>
> +       if ((changed & NETIF_F_MAC_LBK_NE) && netif_running(netdev))
> +               return otx2_cgx_mac_nearend_loopback(pf,
> +                                                    features & NETIF_F_M=
AC_LBK_NE);
> +
> +       if ((changed & NETIF_F_MAC_LBK_FE) && netif_running(netdev))
> +               return otx2_cgx_mac_farend_loopback(pf,
> +                                                   features & NETIF_F_MA=
C_LBK_FE);
> +
> +       if ((changed & NETIF_F_SERDES_LBK) && netif_running(netdev))
> +               return otx2_cgx_serdes_loopback(pf,
> +                                               features & NETIF_F_SERDES=
_LBK);
> +
>         return otx2_handle_ntuple_tc_features(netdev, features);
>  }
>
> @@ -3249,7 +3339,8 @@ static int otx2_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>         if (pf->flags & OTX2_FLAG_TC_FLOWER_SUPPORT)
>                 netdev->hw_features |=3D NETIF_F_HW_TC;
>
> -       netdev->hw_features |=3D NETIF_F_LOOPBACK | NETIF_F_RXALL;
> +       netdev->hw_features |=3D NETIF_F_LOOPBACK | NETIF_F_RXALL |
> +                              NETIF_F_MAC_LBK_NE | NETIF_F_MAC_LBK_FE | =
NETIF_F_SERDES_LBK;
>
>         netif_set_tso_max_segs(netdev, OTX2_MAX_GSO_SEGS);
>         netdev->watchdog_timeo =3D OTX2_TX_TIMEOUT;
> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_featu=
res.h
> index 93e4da7046a1..124f83223361 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -14,7 +14,7 @@ typedef u64 netdev_features_t;
>  enum {
>         NETIF_F_SG_BIT,                 /* Scatter/gather IO. */
>         NETIF_F_IP_CSUM_BIT,            /* Can checksum TCP/UDP over IPv4=
. */
> -       __UNUSED_NETIF_F_1,
> +       NETIF_F_MAC_LBK_NE_BIT,         /* MAC near end loopback */
>         NETIF_F_HW_CSUM_BIT,            /* Can checksum all the packets. =
*/
>         NETIF_F_IPV6_CSUM_BIT,          /* Can checksum TCP/UDP over IPV6=
 */
>         NETIF_F_HIGHDMA_BIT,            /* Can DMA to high memory. */
> @@ -24,8 +24,8 @@ enum {
>         NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAG=
s */
>         NETIF_F_VLAN_CHALLENGED_BIT,    /* Device cannot handle VLAN pack=
ets */
>         NETIF_F_GSO_BIT,                /* Enable software GSO. */
> -       __UNUSED_NETIF_F_12,
> -       __UNUSED_NETIF_F_13,
> +       NETIF_F_MAC_LBK_FE_BIT,         /* MAC far end loopback */
> +       NETIF_F_SERDES_LBK_BIT,         /* SERDES loopback */
>         NETIF_F_GRO_BIT,                /* Generic receive offload */
>         NETIF_F_LRO_BIT,                /* large receive offload */
>
> @@ -165,6 +165,9 @@ enum {
>  #define NETIF_F_HW_HSR_TAG_RM  __NETIF_F(HW_HSR_TAG_RM)
>  #define NETIF_F_HW_HSR_FWD     __NETIF_F(HW_HSR_FWD)
>  #define NETIF_F_HW_HSR_DUP     __NETIF_F(HW_HSR_DUP)
> +#define NETIF_F_MAC_LBK_NE     __NETIF_F(MAC_LBK_NE)
> +#define NETIF_F_MAC_LBK_FE     __NETIF_F(MAC_LBK_FE)
> +#define NETIF_F_SERDES_LBK     __NETIF_F(SERDES_LBK)
>

I do not think we want to burn three generic bits in netdev_features_t
for something which seems device specific.

You have not shown any change for taking care of these features in net/core=
.

