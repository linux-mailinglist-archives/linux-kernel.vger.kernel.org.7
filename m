Return-Path: <linux-kernel+bounces-740560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D6B0D5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A2B16A73E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB272DC348;
	Tue, 22 Jul 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xRhYhWVS"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4728C034
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175993; cv=none; b=K6IogksqIHZ516CSGn9kt9JJndZtx0o7GCf2ls31pR4DQEoqaG3JjWk8sR4T61v5XOhNhFUQ/7Vn3MhzHWvClHzXcvKTCk9pHAeXrrhzcIxn0IPAEx1kgjs4blXKJ0C6XwwPN0rg73NfcJorsl9gofUiV9kTyVrlSrkZtRKV4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175993; c=relaxed/simple;
	bh=Nc5LsYBLDXrRSjWDibQSsMSXJGDOtTLIeSfPdkJxZWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6ihW7poTLCqfOuRARedANuUOAvcoNGT/7UbUSngm7WiFxR0B78o6ybSjfOlzWpwH+3QgkEDHAMlnAo4M1YxWlcZGF8kd8EttqwMJ0ZM4hipxF7Y7LoKcYq/2hPN09nuCoDLItam1blJwfBALGHoNujsn7TvbdnMep4Jezk2LV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xRhYhWVS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so879934166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1753175990; x=1753780790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CkWrUi8y/EeZjQzOxkKkRJZhHj+VflbRA1dCfIf7WA=;
        b=xRhYhWVS8QeZaBQINDkLcin1O8O6Ccql0ujdbSE6TdX/PAzWOkP3NviIeEhit3nmJ8
         ByehyUmgABAcwdJ1RY1JrFRsVtg4Fi9XO4z2CGB/7SASHcV3uGaQ6uFX6XVtfJXIT8V1
         VSkY/MbcNMv29/kx0ut1fE4Uc31uYxsrqwpPuG2tSUrnVeyEUqDdyCo5wKPd2h1IvHOv
         QosXQSR8ruuxzOUz+HWOgUsSwlXtd3Kqp3b/VIsp+NEtrmUBJv5l279qOmAkS8sPrB7s
         NpxvxXVbc8l8LB+m53jGdOlpiRAoHMYGsZflXU+eeGIIRLOuYwbXzyqhQ6qoxzxWoxRG
         h5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175990; x=1753780790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CkWrUi8y/EeZjQzOxkKkRJZhHj+VflbRA1dCfIf7WA=;
        b=ZLSeanrYjmz5lgz+6wzS7lSF5IIIPFDijvGd9AYGImB91+ogoFh8rw9cn2kTPNrkhG
         7IvUJKTN0COuh4+6FR3rKbtAVFZiIt/FuQfPzgnn4gbML5o7m2rDokX9oc3z8lWYJ8VV
         /mL4A0dnv5Nw70fYpiYhG3EgV8ECPFxG6tyEJ0Y3Soo1By+sW6e86kpNV/n2ifRHuQtH
         KcHKPaNOlaA4mnTpZjOLAynM83FnjGtuipXxpOGi8YGsV9c8TgYvDXpz4elJoh96LXLj
         SrgCde78Hb4+yXbZN0JtHQ8noGlniaK/LdXVLTpV+Nq2/iZgbNFjCz+oubpEkav80wcb
         y9zg==
X-Forwarded-Encrypted: i=1; AJvYcCU5TG/60NoP/2VgeO3zjBr92A6E0YAicIeQ8PGui3TzhgxlEep+XhNkAW4Fc30RCymhEVNs8hIPRqVl0Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwoU+cc8lybo1hH7UGLNGIj3Jcqyr4cJqT3JL73Su6K/8rw+l
	NttW3iv6DTLDCNiWDbXbg08KpV5nShlFf1dkOYma/FtEfQCXHkLuwKTN4/xuSQuaHq0=
X-Gm-Gg: ASbGncsgl9cqUw/uRHqfxIND0r/tAFXjOatvc/zFqsm6Iv0Shj6gvMTKTedYo3QeiQh
	kQZY2ZZPPLWt2Gk8IY3HNz492yRzxJyLZgVbcZzchayaw+vN+KWQgJDIOvlPv5w99zig6Zqjrj9
	PKVQq/cYGxQEPakegrPYjP5mTUHrRspvYbkbb4MxOC01Oy1zkFSr6IpAkDWVtiPmh9wbgM0HrHY
	0r5BX3zqHDIOQzCDpJfcusvwvl1/Xce1NgIf0x6wLzU/EMmSkFWRCuyQf6fRCikLMbMcBEw35Wu
	nrtLRvvM/QNUVSS6/ZtopkmOiOk26uYgrft5UNPbmu0WJeQt2TJ4uqJJ5iI8OwtoKXiU+9FhKzf
	ZMivcoTGY5rFpg9D8hWLp2pGC5gAHMqLPlm62Kp0jQLAOPMgAF4GYuQ==
X-Google-Smtp-Source: AGHT+IE/B2CTrIdQjnB1vPNgmhIwDU5QOPxOiUS6LHTb8kkqvCAeLFSRTFWBar5inQPkIGesfWAM1A==
X-Received: by 2002:a17:907:6095:b0:ae3:bb0a:1cc6 with SMTP id a640c23a62f3a-aec6a4e0c16mr1346682966b.16.1753175989485;
        Tue, 22 Jul 2025 02:19:49 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aecd96537d7sm729370066b.18.2025.07.22.02.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:19:49 -0700 (PDT)
Message-ID: <97be4c1a-f097-4780-b5e6-71c0530f3f49@blackwall.org>
Date: Tue, 22 Jul 2025 12:19:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: remove redundant conversion of vni in
 vxlan_nl2conf
To: Wang Liang <wangliang74@huawei.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, petrm@nvidia.com,
 menglong8.dong@gmail.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722093049.1527505-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250722093049.1527505-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 12:30, Wang Liang wrote:
> The IFLA_VXLAN_ID data has been converted to local variable vni in
> vxlan_nl2conf(), there is no need to do it again when set conf->vni.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 97792de896b7..77dbfe9a6b13 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -4036,7 +4036,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_ID], "Cannot change VNI");
>  			return -EOPNOTSUPP;
>  		}
> -		conf->vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
> +		conf->vni = vni;
>  	}
>  
>  	if (data[IFLA_VXLAN_GROUP]) {

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


