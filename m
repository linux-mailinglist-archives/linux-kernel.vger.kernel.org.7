Return-Path: <linux-kernel+bounces-895226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A2AC4D48F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 827DE4F6C17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89969351FDD;
	Tue, 11 Nov 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MHSpOML9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W0vEfFl1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECF351FDE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858433; cv=none; b=LQaFMmX2pnUGbi5o9cT5o7zdX5cpR1Kwy7g4cz45fW0rxKC0yGU+2z7m9zy35hn1Pv0QRUDcmelMiGQqhNDM/DlBsYSAo5E/K7hXncIXDRvg7IEKVkvWrhiarDuIwgBSJ08HvEFT5lZLpFB6MhS05+5Hw9vuV2nk+rO+3AOd/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858433; c=relaxed/simple;
	bh=YfYQWQmJBuTLR4ZkEPAzI8IYEKysiu/TWlhvxpn+hwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieU6oOsJp0yUfIuUivfPwyjRXfASbnxnGAUK2lZmJKyppd37NCdmiHdjkoV+DKaLOeY7YpVDnzFAncvw7n64QJLYxdHYQl4vnrt7wmyub0MnyajMAkyu4hyWK74jxjcdYdvwj7Lz4xBk+n8/m6gALiJG0lhChymtXr89aIt2tPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MHSpOML9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W0vEfFl1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB5MtPq1479934
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JOY8DznZJ+a8l9NqM6488uYE
	YeU/Gs9AxiuVXqByErA=; b=MHSpOML9B/6i/Vq7kz/qZnPmBsx2nHjRO9HEkYFl
	exCGKYKrwBpQ8i7HHiaKgi9/wAD9RAUiFmWYJC7Y6SEiZHwnltNfulH5l//WlGjR
	tijcIyaSKILq+pemr+9H2igZGn5kQA+dzKJAQFO78uTRc8BFje8bKdZzOU5zNVHj
	4n8Us25PEmIl08iVLpV4saYiOtRMtDK5inT3PlV9NoApv6ikd079LHCuOCWNYp17
	NQpLsuKkGK0XzoWwDar/BbKqm15/A86fD65o23muFPg32ZArn74cJCFtDi5cBy+A
	6ax5D6pis2PPLR05TTnRJiMhwuCpfOgUaGuIPjEOH8/KFw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxxu8x4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:53:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e88c912928so114189561cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762858430; x=1763463230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOY8DznZJ+a8l9NqM6488uYEYeU/Gs9AxiuVXqByErA=;
        b=W0vEfFl18rPA3l/+jxMc/y0VcjH3RFMRP5jzgXbtb+wJkNUAvreHHbAzzbeK0kK+WQ
         luDR/0MyYD4nAbgb7gZlF9Ik6Hza8LvS/TIIB4wHvvkCF8I08Hr0tPxTfAa0vITX/mVW
         h+d4yvYfxU11N2r43uQpF2I1eMeSBSjBa8oppKx0bdp3XgYLrkJ/8xtHdJlK9cfsamlf
         scSIlqjhUssuNCLnFLQM4PS/XC2alLxQSW3mCYKFwvleautCI+qKatgu8JSVm8vJ5yPs
         A26goKhDn4tfe/igC81NBJr0IVfwuRozCeOgnDdyBcQs2UVe+9lnO5MFKcH9BpOcx+RR
         xcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858430; x=1763463230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOY8DznZJ+a8l9NqM6488uYEYeU/Gs9AxiuVXqByErA=;
        b=GWtg9w8VbOFSXsyuryQAGRlROQD5vUGXEnOvEexAcm5kGnvjDkJxTFK0PlsGbXfNrD
         g8ZMoajcz/F7PiC98X3U3qhCRHTmGl1Unp9THIZ6062v5rbhY7U0bkPBDBVK9Pe0ZOaV
         fMPQPBDGGljxTKGH1PxJHOiK1VvNuRbruItxNYPSL16l+ze+HCP1rlBaN6XBTsQsfwZU
         GIvGNGlR/hocekfh/r2lcFY4bhjeGjDiODONvaZO1pZFDHW84G4+6ZHvA+raxlHv8VTB
         TUOEXDIlKrlNN5e6a0IDhg+pv4h4P1HHhC32+M9weaHNZVqFPBs8N+2r64596wRgsNTF
         SOMg==
X-Forwarded-Encrypted: i=1; AJvYcCVZsIxKP483LGQchuvTaTDje1ppX7FiSHxkb41E4jSzU/u1gzF3FeH6Ax8EVKdYiRzzQm5cSLGpO/uFE8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRHn893SOPFbqzPx5MSF1xZ47k1/UoKHgVB17WNJs6hoVsehF
	S36/IpasS9Rg++RnHIFEx4HenHiAr/hGIJ0z75nURVlihq8HwO39DeRp9AR23QlA/ICsERLAPKi
	k1CidncwOzuPD0m/fIQjsoTc5WzsrIqcOln6F/HyA3M/p8E5Vbf6W5jlk1hHKSDWTuCI=
X-Gm-Gg: ASbGncthiWcNkvC89H4HVriLkv8tSs2YyLww2L9jTZLNlaAhUbESxryh4qc7nnBKECs
	7P4Cg4KQKLKCsQqi2+TXSaa4Pcl/bRvpEV5AnRpxBunj/NQ2gQmirDfNHdsGbGyQeorR8i7NVG0
	dn/jEkuDooI8A6C0/LQUY8Bo5Wn/dL3MFkoBrbO+QyOhxaeWNGtNMy45axTKoAKURCovlPRVksA
	LBwQicPebb2LdK9cuToyM1uv1kfcPaAcaCk3N5xvsX6xOH6nz1bvR4pfa6fvcF9GtDg3FKignRv
	gzIAimU7onvhnHJuDZc5ZjiskCNZSL8UwVUGSFv298AXzhVa0WD3vH/5XB6zC2tr0qoDb29Fgtd
	J9ZJJ+npqe7Ji5O+fi2dIZyH3W3MMmJ7ecRztbQPMeITU9dt1Bkdn/ddG9UcWvqLFUtzAYgpRaE
	lX8VbJehJeUmYd
X-Received: by 2002:a05:622a:1b8c:b0:4ed:423d:48ef with SMTP id d75a77b69052e-4eda4f9afffmr135268931cf.40.1762858429806;
        Tue, 11 Nov 2025 02:53:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvvKBaA3vCc7M1zJEqozbkT2VVEJ9ltvHYd0jpad02KRmovR5j8eDCwsovOwsBAEB48mkNpg==
X-Received: by 2002:a05:622a:1b8c:b0:4ed:423d:48ef with SMTP id d75a77b69052e-4eda4f9afffmr135268791cf.40.1762858429296;
        Tue, 11 Nov 2025 02:53:49 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a594e2fsm4794339e87.99.2025.11.11.02.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:53:48 -0800 (PST)
Date: Tue, 11 Nov 2025 12:53:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] net: mhi : Add support to enable ethernet
 interface
Message-ID: <z3xztoy533f5gqqhctburexwbzazbq5reu754n27tb453utnwk@bbosumjjcuf2>
References: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
 <20251106-vdev_next-20251106_eth-v5-1-bbc0f7ff3a68@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-vdev_next-20251106_eth-v5-1-bbc0f7ff3a68@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4NSBTYWx0ZWRfX/+bi6nrQU2Lr
 rVWVq2oN40XEnWeNuq+4nYegXLivbBYE8xOe/g5S0Wyhh7ARzqWg4AAwIaORi1gdTNeOibUDF5f
 XxeA1wbFA8SErs/9Y2a/17WV2MHyztmUJQ04HGCrxNjxTTNpE94YIl+2gZwhVmad3aHn6imkqvV
 HVNeTFFCcCmxPJrYVKssMu8hHFYWrG7uZNRzrNKcX3BiygZJU7M5z2e0ZehLKbqLd9mcIqhFakB
 z1oa7ZHKDxvn9D5wYDqU9W92cPSyQWs4tx7Y07N+wVkIWqJqKARtCz6XyACgbp9BfR/3GtZpmyf
 fyDzkw7ltKlm2pgOz+jUZgopEKSl7zhPKf2wbGZPKvLWgrnJt46SW7JrBZkj0MEOcwgAtGWpwvr
 pYmbe8207G1fN4IKkuiq4Iz2SbIpRA==
X-Proofpoint-GUID: oejP6CKut48LB_fKjwu0RnccTJwOcuBD
X-Proofpoint-ORIG-GUID: oejP6CKut48LB_fKjwu0RnccTJwOcuBD
X-Authority-Analysis: v=2.4 cv=TfObdBQh c=1 sm=1 tr=0 ts=691315be cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tsOYRPuReCfgA1KZPE0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110085

On Thu, Nov 06, 2025 at 06:58:08PM +0530, Vivek Pernamitta wrote:
> From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> 
> Currently, we only have support for the NET driver. This update allows a
> new client to be configured as an Ethernet type over MHI by setting
> "mhi_device_info.ethernet_if = true". A new interface for Ethernet will
> be created with eth%d.

Please describe the reasons for the patch. Also please don't use words
like "This patch" or "This update". Use imperative language instead.

> 
> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> ---
>  drivers/net/mhi_net.c | 84 +++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 71 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index ae169929a9d8e449b5a427993abf68e8d032fae2..aeb2d67aeb238e520dbd2a83b35602a7e5144fa2 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c
> @@ -11,6 +11,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
>  #include <linux/u64_stats_sync.h>
> +#include <linux/etherdevice.h>

Keep it sorted.

>  
>  #define MHI_NET_MIN_MTU		ETH_MIN_MTU
>  #define MHI_NET_MAX_MTU		0xffff
> @@ -38,10 +39,12 @@ struct mhi_net_dev {
>  	u32 rx_queue_sz;
>  	int msg_enable;
>  	unsigned int mru;
> +	bool ethernet_if;
>  };
>  
>  struct mhi_device_info {
>  	const char *netname;
> +	bool ethernet_if;
>  };
>  
>  static int mhi_ndo_open(struct net_device *ndev)
> @@ -119,11 +122,37 @@ static void mhi_ndo_get_stats64(struct net_device *ndev,
>  	} while (u64_stats_fetch_retry(&mhi_netdev->stats.tx_syncp, start));
>  }
>  
> +static int mhi_mac_address(struct net_device *dev, void *p)
> +{
> +	int ret;
> +
> +	if (dev->type == ARPHRD_ETHER) {
> +		ret = eth_mac_addr(dev, p);
> +	return ret;

Why do you need an interim variable?

> +	}
> +
> +	return 0;
> +}
> +
> +static int mhi_validate_address(struct net_device *dev)
> +{
> +	int ret;
> +
> +	if (dev->type == ARPHRD_ETHER) {
> +		ret = eth_validate_addr(dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops mhi_netdev_ops = {
>  	.ndo_open               = mhi_ndo_open,
>  	.ndo_stop               = mhi_ndo_stop,
>  	.ndo_start_xmit         = mhi_ndo_xmit,
>  	.ndo_get_stats64	= mhi_ndo_get_stats64,
> +	.ndo_set_mac_address    = mhi_mac_address,
> +	.ndo_validate_addr      = mhi_validate_address,
>  };
>  
>  static void mhi_net_setup(struct net_device *ndev)
> @@ -140,6 +169,14 @@ static void mhi_net_setup(struct net_device *ndev)
>  	ndev->tx_queue_len = 1000;
>  }
>  
> +static void mhi_ethernet_setup(struct net_device *ndev)
> +{
> +	ndev->netdev_ops = &mhi_netdev_ops;
> +	ether_setup(ndev);
> +	ndev->min_mtu = ETH_MIN_MTU;
> +	ndev->max_mtu = ETH_MAX_MTU;
> +}
> +
>  static struct sk_buff *mhi_net_skb_agg(struct mhi_net_dev *mhi_netdev,
>  				       struct sk_buff *skb)
>  {
> @@ -209,16 +246,22 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
>  			mhi_netdev->skbagg_head = NULL;
>  		}
>  
> -		switch (skb->data[0] & 0xf0) {
> -		case 0x40:
> -			skb->protocol = htons(ETH_P_IP);
> -			break;
> -		case 0x60:
> -			skb->protocol = htons(ETH_P_IPV6);
> -			break;
> -		default:
> -			skb->protocol = htons(ETH_P_MAP);
> -			break;
> +		if (mhi_netdev->ethernet_if) {
> +			skb_copy_to_linear_data(skb, skb->data,
> +						mhi_res->bytes_xferd);
> +			skb->protocol = eth_type_trans(skb, mhi_netdev->ndev);
> +		} else {
> +			switch (skb->data[0] & 0xf0) {
> +			case 0x40:
> +				skb->protocol = htons(ETH_P_IP);
> +				break;
> +			case 0x60:
> +				skb->protocol = htons(ETH_P_IPV6);
> +				break;
> +			default:
> +				skb->protocol = htons(ETH_P_MAP);
> +				break;
> +			}
>  		}
>  
>  		u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
> @@ -301,11 +344,17 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>  		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
>  }
>  
> -static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
> +static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev, bool eth_dev)
>  {
>  	struct mhi_net_dev *mhi_netdev;
>  	int err;
>  
> +	if (eth_dev) {
> +		eth_hw_addr_random(ndev);
> +		if (!is_valid_ether_addr(ndev->dev_addr))

Can this actually happen? Can eth_hw_addr_random() generate invalid
address?

> +			return -EADDRNOTAVAIL;
> +	}
> +
>  	mhi_netdev = netdev_priv(ndev);
>  
>  	dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
> @@ -313,6 +362,7 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
>  	mhi_netdev->mdev = mhi_dev;
>  	mhi_netdev->skbagg_head = NULL;
>  	mhi_netdev->mru = mhi_dev->mhi_cntrl->mru;
> +	mhi_netdev->ethernet_if = eth_dev;
>  
>  	INIT_DELAYED_WORK(&mhi_netdev->rx_refill, mhi_net_rx_refill_work);
>  	u64_stats_init(&mhi_netdev->stats.rx_syncp);
> @@ -356,13 +406,14 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>  	int err;
>  
>  	ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
> -			    NET_NAME_PREDICTABLE, mhi_net_setup);
> +			    NET_NAME_PREDICTABLE, info->ethernet_if ?
> +			    mhi_ethernet_setup : mhi_net_setup);
>  	if (!ndev)
>  		return -ENOMEM;
>  
>  	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
>  
> -	err = mhi_net_newlink(mhi_dev, ndev);
> +	err = mhi_net_newlink(mhi_dev, ndev, info->ethernet_if);
>  	if (err) {
>  		free_netdev(ndev);
>  		return err;
> @@ -380,10 +431,17 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
>  
>  static const struct mhi_device_info mhi_hwip0 = {
>  	.netname = "mhi_hwip%d",
> +	.ethernet_if = false,
>  };
>  
>  static const struct mhi_device_info mhi_swip0 = {
>  	.netname = "mhi_swip%d",
> +	.ethernet_if = false,
> +};
> +
> +static const struct mhi_device_info mhi_eth0 = {

Unused

> +	.netname = "eth%d",
> +	.ethernet_if = true,
>  };
>  
>  static const struct mhi_device_id mhi_net_id_table[] = {
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

