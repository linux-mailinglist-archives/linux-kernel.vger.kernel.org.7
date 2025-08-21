Return-Path: <linux-kernel+bounces-779489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED91B2F4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED1194E3A48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199822DEA75;
	Thu, 21 Aug 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhqVaSW/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2761DDA15
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770318; cv=none; b=V64+eC1t8J1gBrrSCl+MgBSkH03163s1/mv5MWOQhlg5slPreO6lHUB2TA4lJVGq+7w8+M2Byl6Bv7a2rc0HFeEUFcWTQ2gzu0joqOuVRF9FdT7iUiw8V6IK/qHueFaKFiIVstmVmyN5Yd8L9KymAfPFumqnk/+PjdLJhUbuyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770318; c=relaxed/simple;
	bh=XB3EZ8j7YkKt/8KMmdNXzNovgfdsgt6+zgy/CZv3JJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXrf4tyA0eJA8RQvcMiwRB9CIdCSS+98EER6DF7Lxxj/roS+H5hI7K/8g/0l7TlUceK+N+3eFZaR9hvQjoADALc/tvoajyRJsx/owyazsbokpac8N0+oRSB5/Vk0/TUBDu29GWAOFqZ7Vvouy0zbxp8cdYNkdGbs+pdn+m+8xYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhqVaSW/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755770315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwZfHOwRnxWIL8uIiY6ltxdcRFnpGdMGmzHCK8fkbdw=;
	b=BhqVaSW/4qRL6vbDDdd52OmuIWERTvmxOHs6NllTgzz/FTvfCg7BilyMuibc6VIIW8ZF+g
	SJmRM0yATNVhnZsH6NDpt5EQF09f/ywwi4/2Avp9XcMu8kORbAt6sKH+LZO1bawANh8iOR
	vfbCpmDrZQMK6wGpIECSXOzop+bU9G0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-takXvxZxPj-u_7rjyNUE0Q-1; Thu, 21 Aug 2025 05:58:34 -0400
X-MC-Unique: takXvxZxPj-u_7rjyNUE0Q-1
X-Mimecast-MFC-AGG-ID: takXvxZxPj-u_7rjyNUE0Q_1755770314
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8706202deso216369085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770314; x=1756375114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwZfHOwRnxWIL8uIiY6ltxdcRFnpGdMGmzHCK8fkbdw=;
        b=Asm3eaIx5ZY7ztUzKbzMq2osbadUG6Q2EMpm8T2zxvD8E+B8lWURsaXdet6yBp78rX
         994PPaDRBxkgjOA0zS+g63V9onG4K5FAXnxDHUgPE7YzdTIZwNEvMGke07hylBREkFAJ
         Xx9avjCsfMn0rzso7Zbi16Pg0wzawSmrEiwq14QkHiPO19hESf6It7JBBiTVFJ0foCkr
         zVFDVhsDhCB8z5g7if09Vl98K3o+fy0GXJ/fk7/JbcH7KP9S77uhm8R2AyoDmH1B02RT
         hVx1/z6pbjkLvkoMiqHF+R9NOrjNK+xSEfmKO2r5Z/UKSecmimQCsZ2A1O9q/IW29kr/
         XThA==
X-Forwarded-Encrypted: i=1; AJvYcCXQJD069H5KNsjp4uKUJ+6QIQt2lIq9Ph2FS2dPO/3LVDpPYkk9tle97+z2qTVfshYVQfjyaveKp9xl/zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC33xKnIo2ezTdZQwVF9ZoyRV0mvE3QqYFlnv8lWKD+V79KFZn
	hqc/uzLZUyoSZHLfv/9db5+VLeBYuAYSxgQGIKKycWAypu1HR4yjYKgnlCbo9R7H2IW1J9qbmDz
	8NLJ5UcHk1gNjlSaNCW4C9OAUg3sJDUpGTHSdmU0tKUszSWu7xrWfdJiHXZdDX2XloQ==
X-Gm-Gg: ASbGncvRdyOJpVk1XRcweH8jnDg9Nxaow/QRbg43rdpd3ZrpUcybuemWmyrzCZYgB1L
	cVF+Q2ETcA/zec+E+kP3oVTX0wu3nzJCmWeowP74MS7w9odXqRA1LTNum8EWm2a5Ax8yOaA8BRG
	LoD8Aeitd/6PChUvFTCs0ViZEM0js55P1oAty8r+4bpvLHz3TvkfGfpZ4Xwf8j66lOo+A6sa/Te
	FrWlOVCXj3E6xZLFW/yVFiDrhQlribxJ0XLczW1nMrx+/UFsnRttbShIZ0OGptZkoWV/vg6b+vJ
	ZdxB6I78PM5CLhFGYJ2XUoopRR0U/o9IxQkhNSG9bMSwfHoLiaDtDnkRZ2a9vkUheKrtnq8CFxQ
	ZxEID5qx0+Dk=
X-Received: by 2002:a05:620a:2684:b0:7e3:4415:bd06 with SMTP id af79cd13be357-7ea08eae1f3mr155247385a.61.1755770314131;
        Thu, 21 Aug 2025 02:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWc3ciqbgQEFg8G0ehzLsjXTh4Kzl5qlzMMp7q4LmklUAyDFZ0ouhZeqV9qbIQReLv+L30Q==
X-Received: by 2002:a05:620a:2684:b0:7e3:4415:bd06 with SMTP id af79cd13be357-7ea08eae1f3mr155245385a.61.1755770313729;
        Thu, 21 Aug 2025 02:58:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c42e5sm1091142985a.65.2025.08.21.02.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:58:33 -0700 (PDT)
Message-ID: <03c92599-00e3-4481-a97d-1acd901d0ac0@redhat.com>
Date: Thu, 21 Aug 2025 11:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] amd-xgbe: Add PPS periodic output support
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20250818115801.2518912-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818115801.2518912-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:58 PM, Raju Rangoju wrote:
> @@ -122,6 +148,8 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
>  	info->adjtime = xgbe_adjtime;
>  	info->gettimex64 = xgbe_gettimex;
>  	info->settime64 = xgbe_settime;
> +	info->n_per_out = pdata->hw_feat.pps_out_num;
> +	info->n_ext_ts = pdata->hw_feat.aux_snap_num;

Both pps_out_num and aux_snap_num are read from 3 bits out of a
register, and I don't see any check to prevent such values exceeding the
limit hardcoded below (4). Why don't you need some additional sanity check?

Thanks,

Paolo


