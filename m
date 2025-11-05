Return-Path: <linux-kernel+bounces-887272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD4C37BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D331B3A4585
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4DB347FE7;
	Wed,  5 Nov 2025 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDA/2sjw"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96EF29A300
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374715; cv=none; b=eOnoXRcuJFvwYytBgt4Nj0Q+bvdPWev8dNjgChJEBzfAJ8ULoLNUkKsrtBrKGJj/F65Kc8dFEOl2BQ1/GkdhZuGtpUjx8Yromog6LsBjwKX0+UgvvqMhK60iTbHRtij1s42UqGFj2dsrJM307/qMAkML57mQ6IskbzA1BAio6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374715; c=relaxed/simple;
	bh=rX0i1XLBoCEYsD51u3EujN1NPLVkqf6eDzfc2Q1QSrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqc3oVnNUikheHbTC2SkaE7aw5jBVkLmA1ixhpQ5yKU8nlkIo7/XIIeb1A4UOtrgJgwMHwHf44vHvi1cXE3GUCphnE0/VhLk+bvV0y24TxAo0cp/E9meYG7w//0yae6sLRxcO1XNxFQEI5RPQAOI2mOtVTan8n4AXFjv6q/nXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDA/2sjw; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87dfd3cfafbso3247416d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762374713; x=1762979513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1J40dDi5Xqhpi8W0eJUyo7WqkdJ10bkSYB2k3R6lBI=;
        b=TDA/2sjwCfcBFtaBhaHRkUwkRkSt0gelgppBRiFIFxrmA3vq2mY102Mb7f4WOIWcY2
         3dgCPknxci+Lg/chVz5nnZAQ/YBdVncob8kih00/HNu9zRkdsD7uqNxp0tiWSG+MNpyj
         f74sPCwb3ZVHIP1omCIN2aNH9InJa7b6xdzKumyjg1VMHuVklQBfdt7OBqeAEP1F1fcG
         hTUJJQ+RShERRfpA1/U3SEYVymuMySKQBmxX9elazyGdkCj0gS0z2edqFzh1LYkOjxjg
         oG15iNnASS8VhjHaDgdHZjB4Qm45JaRGVy0bDAOezwK8dCQKToqOAFHj6Sug6EYuonc/
         H01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374713; x=1762979513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1J40dDi5Xqhpi8W0eJUyo7WqkdJ10bkSYB2k3R6lBI=;
        b=cvz6zC3o+oOmQ+8zGBFIoUPOm7kLwAHPFo/hkc3e4yfNgPPaOWU0vRFDy78gYaLwSD
         uH7v2zQjKznm+8FKBPZ9vPVlaXTzsICT8Yo4tEJSJzk5AuUiO8zaSgtmZWy4w49j5cHV
         VS+R1hDnJe0FQXeUT8yU/ZCYaoRw/ht7hrR3JV9szVs+eIhWyR5nn4muIfjxPy6ZsNTv
         OUyuULPA9Ncs1jXFOSU97sW81LwaTknTQAQN543GUW4p/mDVu6BzqL1MxIQLLYHih3pV
         pbaFYwTnOhyH9FyKvg0o/qZst/B/FpB6sR0/gTItVEuhfZO+pEsgZdemz7vqmKEdD4bH
         zeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9sDDJPjYcAMaTRKLrmDwc3+MYJciP0XK7xlPgtoAknT7jyFfdWBifnuTjGdabXGitf4Ld/OWDS832NZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3kD5pUO6gv40J/jrFfKyXH+vK8JW0oArII2+gV1efgd/6IWk
	CQxckgmPwq0CXCtXnzPJSItffkAvms7QQiLkFVksLHGEZROYBOmFPv+6
X-Gm-Gg: ASbGncvqvG83Et62Tuom0AIt+vdsbyJVFHETKf2CSTzcwtMVOtKQsDEvnHHpeMYYbx9
	VibYOfUO8a9yb9TE/iRXdP/qBfApZIEg+JLA8KLa3PLervIHz9/qOfctbGs77oySsYajMPpAWOf
	CNVq9rXBE99wSo5qy6kAs8s7Ka06phvrX4VRIv9VIzDlXLLwTAgfkK//A+lSb5WIpaRkmjcRI9r
	kiq/gDRF3RsEwATU+44jpOpXTuO41fX1d57j9vw71zmLeJNAcbW+ONGsl9wY59SxzosiC7dlgkk
	K+FES7CjNowvZbL/oxaZZWVsiD2QKlTe5IPSeRUBKZ86lEiX88GITgGVpnHG8nNOgXXdTBftxP8
	KyJlquwGw7jYCNVa0EkoeSzOx9+R7tprnSdle7izyvA/yiROq/BEtznwFUVYJ6o+k2uO5HnFT5k
	NaQ/POqkEpZksXafqMftDFnoyrj+2R7/wd
X-Google-Smtp-Source: AGHT+IGUlpcoRBIn88EG1QpBnJacxK5tJG77YxNu8Wkcq4QV3a6BQBAmriofH6cpZIRJt2HRzJPNFA==
X-Received: by 2002:a05:6214:501c:b0:880:527f:b10f with SMTP id 6a1803df08f44-880710db7femr57256996d6.25.1762374712616;
        Wed, 05 Nov 2025 12:31:52 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:27ac:3515:8298:b471? ([2620:10d:c091:500::4:37fe])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8808290ca3csm4231126d6.25.2025.11.05.12.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 12:31:52 -0800 (PST)
Message-ID: <5d816624-dbfb-4851-a834-94d52677863d@gmail.com>
Date: Wed, 5 Nov 2025 15:31:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] net/mlx5e: Add PSP stats support for
 Rx/Tx flows
To: Cosmin Ratiu <cratiu@nvidia.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>,
 "leon@kernel.org" <leon@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "horms@kernel.org" <horms@kernel.org>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 Boris Pismenny <borisp@nvidia.com>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
 <20251028000018.3869664-5-daniel.zahka@gmail.com>
 <0025ef2f3eb0787d6ee29111f936a86f865320cd.camel@nvidia.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <0025ef2f3eb0787d6ee29111f936a86f865320cd.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/25 12:11 PM, Cosmin Ratiu wrote:
>> +static void
>> +mlx5e_psp_get_stats(struct psp_dev *psd, struct psp_dev_stats
>> *stats)
>> +{
>> +	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
>> +	struct mlx5e_psp_stats nstats;
>> +
>> +	mlx5e_accel_psp_fs_get_stats_fill(priv, &nstats);
> I don't see the point of the intermediate struct mlx5e_psp_stats, this
> function could query counters directly into stats.

Just because mlx5_fc_query() populates packet and byte counts, but 
psp_dev_stats required stats only have byte counts for two of the 
categories.

I'll address the rest of you comments on the respin. Thanks for taking a 
look.

