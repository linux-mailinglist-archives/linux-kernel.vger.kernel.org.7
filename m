Return-Path: <linux-kernel+bounces-775837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78716B2C595
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39934246453
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAACB303CB0;
	Tue, 19 Aug 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQAdYmvL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8E2EB869
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609734; cv=none; b=MT9jQhUNIe1xm/Uqt3ZNKE1vA2NbgpcERhbN3SRV5NvDkwLkqNbtY60MRyuX9MHvcDqFDLeX4mGg82TtHJh0SOONJyy+22nG4L1YRqK7am4b1tdiF341qPK2XZAO/BcjAphkTmZKIHSnimkKtGPQOdyFTNhsXwqj5SFmdpLeYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609734; c=relaxed/simple;
	bh=YGquTGErfZMK4Z8mlgqCJLtgMJkYfu1aCh6sBFItdVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtwAD8twd22DAHZxbJTKWFEO7TWk24OKaBlTbBTg8EYPWMch0oXj+tiPzIEMH+5YE9+fUrXIv1Bh/24x9l72d9gbwmGInUJXFN13yhaiUBLt8bi9Zcm4fNIkVeFl8StNFV55iZ6IsOs28QwkH7D7aKwoKR/vDK6eIKGO+AtIMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQAdYmvL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755609731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nywEW2vKiMccWYiE9n53wSFHnhrNtVEYY4SxrJi2fuI=;
	b=eQAdYmvL95Lqd5ITzVEqumkwp0DR4dRxAg3Yzn8hLICAfKbVuVNuKQk26YkfhOZSOtjrKs
	qm4xjW/VgbqoS0sYYVksl0h0PPVLI8tmZCybelMMzGfQasPen/RfkZ4s9JKhv0X5Ic5RH0
	W5bnKkO6zotVxtRfKCGuzkk1yYTc3nI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-wrG0BP2nOTSRsyf5E1xVYg-1; Tue, 19 Aug 2025 09:22:08 -0400
X-MC-Unique: wrG0BP2nOTSRsyf5E1xVYg-1
X-Mimecast-MFC-AGG-ID: wrG0BP2nOTSRsyf5E1xVYg_1755609727
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8702f4cf9so1431277785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609727; x=1756214527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nywEW2vKiMccWYiE9n53wSFHnhrNtVEYY4SxrJi2fuI=;
        b=fe7NDZ1veRYgsIDyzUpBO8+VcVIQr252Er3E997QC/NADflMHrUf+P9bgKY7AogqNR
         uPynN+4eQ6n9xnctaLps5RYOnnGIDwB0OiO8exm/sX/qeMnESrVjPuezVvJ+Soivazqc
         sTCQqGG/vQCgYxybk8aEjmSb3IiGLvkLr6XFHWvtoyLCBIMAS4VBXxx/OcfHYlmZVakc
         TiPgx15SslYCsAxZrrTisi8bljYi8X7L9d8Ub32/xfl9/L6kDOQDvSWaZTeZHNnogCB3
         YGRxXSMcishvcH3wf4MNo+2U6l+NdJFiIhZ2ix29LOQ3K440bt8zuCaj1y3tNhCvRZR5
         LD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5NiBbNqRMcvPzq3k8sDo3jJpQ/qqueT8brfdIZtR8czqxAn2nfi/yFzyBKOnGmZQ6/Xyds0k1bg3LEew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHun62Vk20qy8k2J3V8Y2uKJ8cJ1ZNbyhcd8N9ddB0k4AYpQ7H
	YIWTlsOTHRx8Y8EXN//h+KtcLFcbaA2oWc+EFoS6i5cfOY6EKySO5hsyFTfWO0BgRkfCCThQRFO
	e5ECYpGT5FikUfx81cSJ3E7Wydw5M5nZ4CREwNoRpeh2pdHidkCIDjxmndVP6KmyPWA==
X-Gm-Gg: ASbGncu5P6ytG9G0n180q4wMt0SBvb3EDjrzLvRjG1jANUUYfFuanILAXpKd5cB8390
	WK9PfRvMTyCxqjyO4uvba1TuZruuazdmvPrxh1ZWU6+e+1G6WK6wPCd8a889yyKEX1mdxy2ER0j
	XSVfRbdcG7SbPwQ3J+xtzdOni0N0a4SEwXOoxY3yC+WCMfOI7lxjuxmgisjFocjoFzz+Ag7HLpD
	+8HxNy5fmRcEDGn2ZPe57l3S6y8CDUX6/Vxr7SgQJZkiRCltC/ea94oX4vqdM/r1fFuXSGDGewQ
	pAOdXi8ExE13BMhWY2lxi3Ako9+BAUpAMhQpOUV3BGZkZXqytXwuxzh3NbrY+520XOl9ELjrkr5
	urwerz9SST+Q=
X-Received: by 2002:a05:620a:a48c:b0:7e9:f81f:cea5 with SMTP id af79cd13be357-7e9f81fd1d2mr96852185a.83.1755609727392;
        Tue, 19 Aug 2025 06:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6F35u3T+eC+dnHWwSRfGoWO9IfLlxyoh2o8GvCu/FrVeuc4uL/zQUhn/LcS2bYYks3YKIOA==
X-Received: by 2002:a05:620a:a48c:b0:7e9:f81f:cea5 with SMTP id af79cd13be357-7e9f81fd1d2mr96848185a.83.1755609726732;
        Tue, 19 Aug 2025 06:22:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de50b31sm67890121cf.51.2025.08.19.06.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:22:06 -0700 (PDT)
Message-ID: <715111b5-6cd1-45c0-b398-b5d8bec7f24f@redhat.com>
Date: Tue, 19 Aug 2025 15:22:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 1/8] hinic3: Async Event Queue interfaces
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
 <4a3fbb9455305898257760e2a13cc072b475489b.1755176101.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4a3fbb9455305898257760e2a13cc072b475489b.1755176101.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 3:01 AM, Fan Gong wrote:
> +static void remove_eq(struct hinic3_eq *eq)
> +{
> +	hinic3_set_msix_state(eq->hwdev, eq->msix_entry_idx,
> +			      HINIC3_MSIX_DISABLE);
> +	free_irq(eq->irq_id, eq);
> +	/* Indirect access should set q_id first */
> +	hinic3_hwif_write_reg(eq->hwdev->hwif,
> +			      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
> +			      eq->q_id);
> +
> +	cancel_work_sync(&eq->aeq_work);

The above should be 'disable_work_sync()' to avoid the work being
re-scheduled by the flushed handler and later UaF.

/P


