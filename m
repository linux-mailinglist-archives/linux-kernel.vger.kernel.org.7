Return-Path: <linux-kernel+bounces-862299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A595BBF4EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1035534F5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D827B331;
	Tue, 21 Oct 2025 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7ecpmPO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91091277037
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031303; cv=none; b=HSm0Kx5zZ7+xVwYfuT4rXxGlXMpdqSi0xO6akoV6yf2Kkkx2B+owBeYi2fOkR7LZZT92qWOKz0aESvmbyMCQjMzBeWACP0ctwuwUNyuqS/3kEfDP90+v/tLMUHkOSFIaHU5D7CGJG6XSWpZfXvAnLBWJkiPiV2O33U0ScTESGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031303; c=relaxed/simple;
	bh=AY4vlSigkAu3MeDU9Ovs29Ds/Xigd7mN+cX5NsRteBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQX98qmwJNJaXqXNTuBZVeraw7QaP9dYY4TUZvmqbJpKYkJO2g640Nr/2eevA1AnAcg9JHaHVytZ96SUwmhteCpo8E99Q2sJGAqZ+a6UsCDPNjPde8GTUbdSCPVExSzYB0EV1ht2AS1hXr227pmCIcfildJZ9d2sRPKDuqOvvok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7ecpmPO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761031300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfnRqiKEelMSphBHduFrZUqhUrnjzFO9LXcBFI/UlsA=;
	b=P7ecpmPOU94cZbRy1GbqHLI3C0VsYXa6mSI6UwID0xD1NawxAtPGNl+tWwmvfTNiVmz85g
	s7hxFKIHWZjNbZJZYKjwqxN0StR2FbnIT+XnfifORLCcDyqON65/UTP+oSofuV+l8LN0Ii
	47jOnwvnt790GkafCs6cQnzVNmCcWvA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-LhnZsomHMqiovtUgmbrruQ-1; Tue, 21 Oct 2025 03:21:39 -0400
X-MC-Unique: LhnZsomHMqiovtUgmbrruQ-1
X-Mimecast-MFC-AGG-ID: LhnZsomHMqiovtUgmbrruQ_1761031298
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso3286512f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761031298; x=1761636098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfnRqiKEelMSphBHduFrZUqhUrnjzFO9LXcBFI/UlsA=;
        b=B1Y2wG2DjJdqE79sWJk3e8lgkvv+O253TM2DqPCGQGx621H2rIGDnzdxievsd27FnL
         LUFxWGyrbIdKvJRYVe23rr7W5opjY7vBM6ZH2kwD6LuIqoKQm82J/H9hB+lcFIB10KX3
         yzHwZN76YrQrs28QKBf0SgRuNqwDsHXyWaXzEGqL1oPbxUNAgknHKrJJF0MLc9+MpQzY
         k7dgSOHHKYv1ALzNXQXhlptVoVbGROQc7E7joyBEyHLDUEem3iMtwZVxZ8Ucsnj3FRag
         99LbznjdzOfBomdxa58KSdVeLLGPYz69dpcN0hqCqig1mcKDh0ybtktXRHcEHLhQuCmr
         1eiw==
X-Forwarded-Encrypted: i=1; AJvYcCXdU1wNdRx+LetaKpTRq35ez5keltmxqk7NBb1pAKd7tifdAYxk0CUWn+TrlFMRXFEG5Pou06TFgPQwTkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfhTurMRMNmCC1TIHJ5PE9tcGvXw0LPXCmCflGyp5Yx2/Szkww
	dUvu5Zr3TJcGIJHol5c/51n8xmGmm9B37uGdXFCwOrXc2mM4YIkBj2Hvd9ZjRhUTyJ43FFFbQJR
	kcIYaQRLRwYwLvqiLvesAp8/EayjO/COj+tjXEihbt/mjwmRO/M3kyTprVIjeGRaFfg==
X-Gm-Gg: ASbGncs9SsfSzlGR2fXEwQSY4oejZSTP6n8gQG4+LLpElGY3naGcysPfBbS3pyrwRSc
	A/Ro8icNZGS70+ZH55Co8qliE8pnBzDdzKbyFrlg+qX+89D6xE4iSQCriAQi6756HnI4pVzd2Dg
	HaI8s74i9IOqkNBiagxHQWAsrkpzQbXkOZKOQSpQxXDCjrgVMSaqNBUw0UCNYi4e32RLQDNk/vX
	WVDlDkTfYgdZW2cLGdezZt/DUAS/jwzJ6oV5XS+DWgmY7n3+N8WV96rZ6lU2kp3edsOi+pC1cAl
	qxD5/udLUDg2psoFnYVmKVi6HHTgVnqwq3ZxLq+/m1q4JVaUivHrQXL1l0FhWSTf/t1n52Vhj7P
	nLb+90ElqsDYMFreHMH2BPeQxmeyDAxCvg3J3V4C52eFwlcg=
X-Received: by 2002:a5d:5f95:0:b0:3f4:5bda:2710 with SMTP id ffacd0b85a97d-426fb6a7461mr12855828f8f.9.1761031297981;
        Tue, 21 Oct 2025 00:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDxfoSFLan3voMA9n/iCNlQKxAGKdDWFt5/7nuSlMdSyP4+uV6cZzpLp5Db0jFPI6pELrtOg==
X-Received: by 2002:a5d:5f95:0:b0:3f4:5bda:2710 with SMTP id ffacd0b85a97d-426fb6a7461mr12855798f8f.9.1761031297518;
        Tue, 21 Oct 2025 00:21:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm187420125e9.1.2025.10.21.00.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:21:36 -0700 (PDT)
Message-ID: <6e62af59-b282-41c7-9275-fec3c5d479fb@redhat.com>
Date: Tue, 21 Oct 2025 09:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: enetc: add ptp timer binding support
 for i.MX94
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, Frank.Li@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 richardcochran@gmail.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251016102020.3218579-1-wei.fang@nxp.com>
 <20251016102020.3218579-6-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251016102020.3218579-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 12:20 PM, Wei Fang wrote:
> +static int imx94_ierb_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +	struct device_node *np = pdev->dev.of_node;
> +	int err;
> +
> +	for_each_child_of_node_scoped(np, child) {
> +		for_each_child_of_node_scoped(child, gchild) {
> +			if (of_device_is_compatible(gchild, "pci1131,e101")) {
> +				err = imx94_enetc_update_tid(priv, gchild);
> +				if (err)
> +					return err;

Minor nit: the indentation level above is quite high; you could reduce
it a bit replacing:

			if (of_device_is_compatible(gchild, "pci1131,e101")) {

with:

			if (!of_device_is_compatible(gchild, "pci1131,e101"))
				continue;

There is a similar occurrence in the previous patch.

/P


