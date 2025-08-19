Return-Path: <linux-kernel+bounces-775865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F51B2C5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0D816A34C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5EB340D97;
	Tue, 19 Aug 2025 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3bSKufj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565CB3375CF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610620; cv=none; b=jNVKozty4nGo988XNubfmSEuoqhj8n04Lbsq8NS7yTl7sDBVfA4XwDRCH9hJDjBpGoiKIyefWybaZIM5wvi8BxkLMl8HJr0TDmbtVtau8nJQyZ8jL78Ka2calu8m7vHq2xxYJUcFAqG/c3KY8qlHNv3mrzkakr/ermhlx+PCJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610620; c=relaxed/simple;
	bh=ses7cvDAgeLlulpRb7LhAvFTG6yY721+EVGzVkEhouY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyZlk8Nu0cchENyc362obW4XVl6cvGZBlJMzfWNpai5EVFaG1M3jLUjoZWDUyuAxDO00jyuVW7KKJ1bNPzg+3m4mXWcbBVZa/qEWKU8QoFO9iY9gc8fbs0/9tRl62tTN4YnSFPu2iUH3zPsjpA5i1/2PYUVnhwkNehAEs4RLH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3bSKufj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755610617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ug3+QB1kigmLvHdV+5tcNTutNLJ6/dvktxgLZPmeoKI=;
	b=c3bSKufjSRc1cMnsFl56PP7QYLyAcDxMBWbIzGk8QY2gpfg6FJUy7RNYsu8KUpn4g/de5W
	VFliPg739lOMhOx+rtw3zzdmcpgkCcQK8PxVcCPKBelRI6czzlHfP1AeqSEzK5PjocYSav
	mVFvTamLlCV14n+yOjFX/RAzUHfRrHw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-QZcw92qfMISn1CD6xDdx6g-1; Tue, 19 Aug 2025 09:36:55 -0400
X-MC-Unique: QZcw92qfMISn1CD6xDdx6g-1
X-Mimecast-MFC-AGG-ID: QZcw92qfMISn1CD6xDdx6g_1755610615
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109ab1e1dso273959801cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610615; x=1756215415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ug3+QB1kigmLvHdV+5tcNTutNLJ6/dvktxgLZPmeoKI=;
        b=Pp9p432ypqIsc+KEVOATSpXEk/KwHlt/lBFHZOEUX3GeQrRrDY6hGJRtQ3b4pDiJ+f
         ykwd0/wwc1MVGHaJ2av8DxXJWiV3dPmr3z9lyElQJv1qQNZU+Fibs4Txlf4Vxxo2kd3c
         r0SV2ft9qZfeDWnoWbc130Y0D7c9C+ahSq+l0Gox/VaKla5wKlGIjtqnMju8Tjm/YOlC
         8G4ZS/gudn49DTnaxoMhIJ0eqqATnAGIExvQmQKUyX6uPqJ2yGWphB0z103hebCJ4/3h
         +c8bhhsuKLUohty0kejMJ36Hbz0xn8eahlFbbnZFt+7gCMct5zzZPqJMBRIkyqTle+N5
         3DaA==
X-Forwarded-Encrypted: i=1; AJvYcCW9k60Qm4i10BB/+5duRiLzYcBKFKsbKrC1RBob5SYirsgvP83uLlRyzJH+ScTdgNTNYrDzTjra4Ty9wM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yDF1bXMA4gfqGpuhixOYyitwesFmBq+v2usR3XVC/aUN0VH5
	qQvG/RWE4RKYrhRuvgG4g2rAsCKPIM1zrq1cmKJ13ItoLDp74xlVJEmb7HuLKLFNct81orC3sxd
	YhiQ8JRIisZAqKDo5rCp8ihGEA1N0E/jcOx5Va6gDxWHppUTcJuRdaMVqwWj7gFRRZQ==
X-Gm-Gg: ASbGncsC2nytTxO+EUbQDbMsBeksrnr0/WQTq7sSjR1DJIUrJy3QfHNEYthD60p1V2o
	TUNauY6/RU8okrJ1yb4k7wLQTUi7W37brNFUFnDsktP2+PIXLtYBtj0EyHxjN+8NUjHRbrCFk/E
	fbfzy/h7uAXS/c8G1YLiwVya+xdnrXTf0cOaxo52FWZAy2a6Q7L3eUfgw7UCopIsH33TsQMxqmE
	wUcM0bBgGINGPkRApmwAFiGnbVEA20wFZF3FXyUKXAQX8o35ZId31OvaWL7WiJHKFoPbelV7DJk
	0UvokNgRYGaMcWN038HvhF7ObIR9G4VZicFJYzcerYDifY7tv8d/53pAAxR0c1IJaslR207t/JN
	DdJ8AQUsyEYE=
X-Received: by 2002:a05:622a:4116:b0:4b0:75ed:bbf9 with SMTP id d75a77b69052e-4b286e18a44mr29730591cf.33.1755610614740;
        Tue, 19 Aug 2025 06:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcuikD+z1aBhWawTZB4Y8+HlULz2fYWJ/MqafPQ1f5iBf4eDR77H0oczmovLBnl4sHDv/v/Q==
X-Received: by 2002:a05:622a:4116:b0:4b0:75ed:bbf9 with SMTP id d75a77b69052e-4b286e18a44mr29730101cf.33.1755610614332;
        Tue, 19 Aug 2025 06:36:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de50e05sm66687671cf.53.2025.08.19.06.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:36:53 -0700 (PDT)
Message-ID: <37c9e5fe-e4c4-45f5-aae9-e949cfdc8902@redhat.com>
Date: Tue, 19 Aug 2025 15:36:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 6/8] hinic3: Mailbox framework
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Fu Guiming <fuguiming@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
 Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1755176101.git.zhuyikai1@h-partners.com>
 <0b7c811da62813e757ac5261c336a9b7980c53a6.1755176101.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0b7c811da62813e757ac5261c336a9b7980c53a6.1755176101.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 3:02 AM, Fan Gong wrote:
> +int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
> +{
> +	struct hinic3_mbox *mbox;
> +	int err;
> +
> +	mbox = kzalloc(sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +
> +	err = hinic3_mbox_pre_init(hwdev, mbox);
> +	if (err)
> +		return err;

Given that all the other error paths resort to the usual goto statement,
this error handling is confusing (even there are no leak as
hinic3_mbox_pre_init() frees 'mbox' on error). Please use 'goto
err_kfree' here...

> +
> +	err = init_mgmt_msg_channel(mbox);
> +	if (err)
> +		goto err_destroy_workqueue;
> +
> +	err = hinic3_init_func_mbox_msg_channel(hwdev);
> +	if (err)
> +		goto err_uninit_mgmt_msg_ch;
> +
> +	err = alloc_mbox_wb_status(mbox);
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to alloc mbox write back status\n");
> +		goto err_uninit_func_mbox_msg_ch;
> +	}
> +
> +	prepare_send_mbox(mbox);
> +
> +	return 0;
> +
> +err_uninit_func_mbox_msg_ch:
> +	hinic3_uninit_func_mbox_msg_channel(hwdev);
> +
> +err_uninit_mgmt_msg_ch:
> +	uninit_mgmt_msg_channel(mbox);
> +
> +err_destroy_workqueue:
> +	destroy_workqueue(mbox->workq);

err_kfree:
> +	kfree(mbox);
> +
> +	return err;
> +}

And you can remove the kfree call from hinic3_mbox_pre_init().

/P


