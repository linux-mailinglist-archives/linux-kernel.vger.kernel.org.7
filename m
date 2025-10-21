Return-Path: <linux-kernel+bounces-862582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B1FBF5AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B7A84E1EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1A2F12D6;
	Tue, 21 Oct 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFv18/o5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119372E9ED7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040992; cv=none; b=gL8SmYk4KZZYarbOg678te4byanFF0YD1SkI9+xB/wexIg+8revKFyvEJZT3BJWJzx43OgmNy/a91mpCB7v60Ch5JBSH7d/E85G/6tQTqg+Gcter2WqIYasC3n+Xa6m6SHjra/ZmC/UzlM74ZE9Zx2N5IZBF+kPTSZAbRrJvdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040992; c=relaxed/simple;
	bh=4X3PCzTUi+t6U3Xb46bofkEjcpM45wzgycTZWdrLVKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1y8KYHTt00mpFEroj62aHsc0f2/oz8XgASAmnq2I1R3w8Y4anCXiLPKHB9sbcT/ASDik2InrZBQc0r+Fo/iEWS5S2PkjCLVWjvlcmkzbPchausFkSmUcdSBiAgSMcvm2mEJXmKPAZ2Ma+tBlY4WoSGVHz830XLwCEoLFBCX6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFv18/o5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761040989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dh9VBIDeD1YW+winnmo1WNn0Q66KIhY7uXc+kNmNSe8=;
	b=NFv18/o54iIhUXwZA+21ro+45jVbGnasrz/tYrbrWpJYMpiw21uXDYj8sm1lZV3G1xMpkx
	ETvhl82eTEYoMk9OrL5VsT41c5rA9BoEsOutk/AKJqjLbhQqh1BsmrTBDCw5JjPsZqIl+a
	aIVLp06kA5YfEQkyIRhoLHDuSkbj9Eg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-3XmqxMjfNu-pdtL9XYNEaw-1; Tue, 21 Oct 2025 06:03:03 -0400
X-MC-Unique: 3XmqxMjfNu-pdtL9XYNEaw-1
X-Mimecast-MFC-AGG-ID: 3XmqxMjfNu-pdtL9XYNEaw_1761040982
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471005f28d2so20847375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761040982; x=1761645782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dh9VBIDeD1YW+winnmo1WNn0Q66KIhY7uXc+kNmNSe8=;
        b=ORRZreI/rocKv6Fi2lk9wsJ4tSTsUd2o2Iz0Vtjm8tb8ld0bFoZnpHHmAJaFWCgHAa
         k/B47rgmpuay+ZQGBAEVXyD3DRlFZ0rAnJdJojAPJJMvFJaP/02AedfnvrZHzw7vclaT
         zUV18Us3+bmLW3put29tS3J4X/ruQ3VhkNCaLUywABF4uGpcph2f5luvjecvfOsRnNkl
         jNVSNT5XkWzmE9bxcTwxf/EWiXUYA5lXaOk821Rkp2lFuwAlEznL1LnAA08f0ozxpSSR
         iZDrDMbk4C5QPhJKOJS9Yz7zXhsY/7dQguMpSLxWE45WK+BVEn1kJtoW5HRCddfRaHn7
         vJjA==
X-Gm-Message-State: AOJu0YzwMJVG2yF6mNE9Q6DVQqWyUFSy7DwxfSeuorLjzxcjsG1QBrUF
	3MXHM3z/A+Qt+meFrkIKJucu/uig7wGjXa5bZUPibDFVu9U6xiDgIwCS4unWWobTfCmwbxBkTkI
	wtJJQ8Nu1J0kgNJaxaqAQXD3Gxsyzd6UH5so6R1J3tMsn3LQo5psqnVYh3WgLFpoS2Q==
X-Gm-Gg: ASbGncsdj4otSmYUNUft6EF2sRKrxW+yoNpiURXMZ7ORJiKVkP49bCRcm+0dMCRYCPo
	/LgSOcvsh+nCLMeTe2cy4jRFLgD89C8WP6NpIOtxd3WdJsGHHwMP1ghxBvrhrWfIV0A09H/hxHN
	v09dk7IW3mFXN8z1aOvBVrUrPhvYArlpCtT3Mq/x15qbzjGvPTtHDj6hdwlLDYERHyUreDJgIjQ
	LAA+76fSoiMeuwyuDTe81lbzDjRx6jhS5KrQYI/ERkfuU1uHrfDz0ODCr1+wjNt20U5ffZITs+m
	IMSSd2UGVDt0R2cj/R8gckimf2ByAZCkjWl5sWgVtcZrr60LhRJgBep80BXAw5EwNAfUdeT4dPL
	NbPkRCcY9JT6LuSYfATR8WMu9ie9ARu1tTi7yIQACp+ioW8c=
X-Received: by 2002:a05:600c:4e89:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-471178a236cmr113651105e9.10.1761040982385;
        Tue, 21 Oct 2025 03:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz0MIaxzEx8MqXNj7QakxLNajYTx+Vzevf5zqj7jjSvfZ+GyZLrKl3dgVva61Mp2iFS2TUNA==
X-Received: by 2002:a05:600c:4e89:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-471178a236cmr113650685e9.10.1761040981961;
        Tue, 21 Oct 2025 03:03:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471553f8a3asm218799785e9.16.2025.10.21.03.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:03:01 -0700 (PDT)
Message-ID: <465d5a38-abee-40b4-9026-aefaf47a943c@redhat.com>
Date: Tue, 21 Oct 2025 12:02:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 3/6] hinic3: Add NIC configuration ops
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Markus.Elfring@web.de, pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>
References: <cover.1760685059.git.zhuyikai1@h-partners.com>
 <b5b92e0bdc2bd399c56ee356a7b6593f3ddf69c2.1760685059.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b5b92e0bdc2bd399c56ee356a7b6593f3ddf69c2.1760685059.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 10:30 AM, Fan Gong wrote:
> @@ -368,12 +407,16 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
>  	netdev = nic_dev->netdev;
>  	unregister_netdev(netdev);
>  
> +	cancel_delayed_work_sync(&nic_dev->periodic_work);

periodic_work unconditionally reschedule itself, I think you shoudl use
disable_delayed_work_sync() here.

> +	destroy_workqueue(nic_dev->workq);
> +
>  	hinic3_update_nic_feature(nic_dev, 0);
>  	hinic3_set_nic_feature_to_hw(nic_dev);
>  	hinic3_sw_uninit(netdev);
>  
>  	hinic3_free_nic_io(nic_dev);
>  
> +	kfree(nic_dev->vlan_bitmap);
>  	free_netdev(netdev);
>  }

[...]> @@ -406,6 +418,8 @@ static void hinic3_vport_down(struct
net_device *netdev)
>  	netif_carrier_off(netdev);
>  	netif_tx_disable(netdev);
>  
> +	cancel_delayed_work_sync(&nic_dev->moderation_task);

Same here.

/P


