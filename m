Return-Path: <linux-kernel+bounces-897044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69220C51DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 111BE4FD710
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1826E30AD13;
	Wed, 12 Nov 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bAOysrJk"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9FE56A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945578; cv=none; b=hwfWVQhsCr7fn92PqHB2wDxwhLgqBduw8HcvObbjsXKWPHlTpyjQn4n+8vWWiz8qqwqpPRvZRRqGYvjyiSnSpo67qzU2XEDNtW2wGxSTNV2uKNOSo6BiP1OgtJlrpbFpp0Qq3M6Ls1ZsO5K02w1pnYDHoFlaVrXTllLYLxHT8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945578; c=relaxed/simple;
	bh=tDH5RdXScHosnp3tBgCu6Wo6hK9wWBwFctAls40eQ2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhQ8X9EyrwQ0WUkmRKatCmB3OuNFaL4TkoLzUuc9JbeeQPJG1PMStLqTLILph4eEVfTERsGFI3b4iEIClMC1GVzjgU0/9QzPxRdvR6PweWMQsxFyBeGbRsz4jopDfDn/7mhjBw4uz9mAFwycx4/IMCJaKEhlcpPwiUsszEbvHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bAOysrJk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3c2db014easo128534266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762945575; x=1763550375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RscwFBq3OyRCWl61Ef104IM+J+P4bfAkKVg6cbBGEEk=;
        b=bAOysrJkB12ud+FOcHW9n3eccs3QzMRt38Mlj7BmSBqmGOsAmSAx1c2w5CIiN3rA4Q
         fJAV0ZxyyBGxk0Z7yMw2utxVzfpdTfqqDlnZtqigk+h/HkNBqHD5AJQD+5T4n14y5aca
         IIkMwhKwP8FpA4eBz20Fd6IfCSsxK2oVaNKFMpYD7uj394yDrRP8I4Gd0a6VOPb2TMkB
         YcGjWdUDMC3bvoh72g8BJK+aNeoya8gsFG+R+264q4GdwBDSQyBLW+KxxEvnzUXzc22k
         QoHL8c1zjKTr5uCLH8XJw89HnG25QRlv83PR9g7Wg1427W3kegingLDHjoMh9CfZnDNT
         Bh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762945575; x=1763550375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RscwFBq3OyRCWl61Ef104IM+J+P4bfAkKVg6cbBGEEk=;
        b=ESzOiYKTSbco06zM9ThVTyIPUoZc56tqC+WepgvsHO3+DvxCc0XPxNeSxZb5dgAH4+
         RYUUC7MlYYK7YWdl71UFT+jGa1wTvp1/CHdVY2V+kT+A2+/D0KkjV7KmgqdWL4LmtF7+
         5BYfQ0CKIkluXYzHO4GYGYKaHOiQtlKWu2spRVGjdrZDapxtHQ9CTgVfFm0TwX3CvcfG
         AhvChE5Y+HpKpG9ujt0KR637/pf13sQu55hDLMYRgxwipRgsoUOB38AUVrczCjRC2+xX
         8H2VxSHl1Pz+o97S3ugmrgdquQ+hg4sZNaaYb6W0yY9xHyHJB3f6idcvpGVOPYqYZI+o
         XlSg==
X-Forwarded-Encrypted: i=1; AJvYcCWyHgvvV2MRkb0jsxxBwrxquUmF26JhOQkiOrbwiVEqyPmlzo429+f9lM6VQHMN2PORphVdM+WKaNHj1Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+ei+TSUQ65MrCDv7aLmmUh66LEcFNtpYOUE34eGl247rHgo4
	TglvVqgZUwdXoc9fxXiRYHIqBGFQzUEn7h4HBCUQm9glXW2lN4MhYNSY2Pgr3QhLIKs=
X-Gm-Gg: ASbGncub/XijNRiKCTIzMPDvXtdHiYnJ9Dx2P0MwdMyLZ2MOS4CJnU+Sapo9rPEsFAa
	s/lpLVLFMlguOr0elT/YOwz6PrrrsjfSzif9q0eTgDmqXpIuxAeMUP0ZGORDw8mgAkucnJAf0tQ
	hBWhObyT7YbL1QPRWAC2Ttqyl7CqJGJUHeCFUrfpzVbwtEzAeI/DLaqeQ9qgyYPZ30SJDiVI8Ow
	V7YlLNlGMMZehsoCkm6ruIF4nmNLFFWMSd8L/JfVyhXWjvvW//j3duVDzVZQixar0WASnKwEANP
	BPard20ocBzT36Z4IJpAvaemm3ZEWp1GI5eG2/7fhFVlUzXQO4NSW7a3G5XSpcpJ+ne9BqrB8oI
	yfR/TH6arIbfYSTSxL7qZYZn8+9zqI2GJFIroM8cmsiQzcZdXz/Nq/JU6gKFtOhAqNGJs4JTWcD
	mSl3sfR6enX38l7SrxZRv3PXA+LFHfBH8=
X-Google-Smtp-Source: AGHT+IE61k0FNld65Na0gwrWMjkcd6KnQX2WlVWRh2ThOyOuZMLyUreP+xoQ3sjP15lbD78y9IaeSg==
X-Received: by 2002:a17:907:6092:b0:b72:70e7:5b62 with SMTP id a640c23a62f3a-b733197ecdcmr239036666b.23.1762945574535;
        Wed, 12 Nov 2025 03:06:14 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd741sm1528348266b.57.2025.11.12.03.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:06:14 -0800 (PST)
Message-ID: <c042de5b-4167-4015-989c-ef0d34b85c83@blackwall.org>
Date: Wed, 12 Nov 2025 13:06:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: Remove unused declarations eth_vni_hash()
 and fdb_head_index()
To: Yue Haibing <yuehaibing@huawei.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112092055.3546703-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251112092055.3546703-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2025 11:20, Yue Haibing wrote:
> Commit 1f763fa808e9 ("vxlan: Convert FDB table to rhashtable") removed the
> implementations but leave declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>   drivers/net/vxlan/vxlan_private.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
> index 99fe772ad679..b1eec2216360 100644
> --- a/drivers/net/vxlan/vxlan_private.h
> +++ b/drivers/net/vxlan/vxlan_private.h
> @@ -188,8 +188,6 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
>   		       const unsigned char *addr, union vxlan_addr ip,
>   		       __be16 port, __be32 src_vni, __be32 vni,
>   		       u32 ifindex, bool swdev_notify);
> -u32 eth_vni_hash(const unsigned char *addr, __be32 vni);
> -u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni);
>   int vxlan_fdb_update(struct vxlan_dev *vxlan,
>   		     const u8 *mac, union vxlan_addr *ip,
>   		     __u16 state, __u16 flags,

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


