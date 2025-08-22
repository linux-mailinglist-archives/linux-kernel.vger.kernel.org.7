Return-Path: <linux-kernel+bounces-782390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A44B31FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030A41C87CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6049E2472AD;
	Fri, 22 Aug 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7jHDy08"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA2223702
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877880; cv=none; b=shcWwtO5R0gKopMN3xjqxN1Pfqj6B3/VicUI5wztvblrHeJTDb04ra5RFsGOYaMn/mOoxTIStoGyAIxrghiyTepnpeVibWbtQ6ooo6hcscyV5iBrBvgzGZ//HQewE+1Q9r8QhBUhNFkG9mUNI2WtlPVh3bOSI9YMitkdHLB6izU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877880; c=relaxed/simple;
	bh=X4F2MhZwl8vDoLP4la59CQespvjwyzGte81DfvYqiQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmMLhYD/vv291dW+GOSOQAZBUMHHCSRcmM3mq9hFOvGWnLGOwx4NPinqntmqr6OgqWsNllpHWPJ+EK3YT7+mus9E392Dop0xd6xBWvcBC8opYgtFepfSeGtA4DpWORIHiUYYqWXLdyqPtrWVbUKYd9cteHi5CvvomAlhsi4IN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7jHDy08; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BvzPxkykRVHqIEzV8JDMXRhoyfWSdFzz+8/KZrTRO4=;
	b=c7jHDy0813OoLOaiFOJHLC4qOvxZZysdul1F96syv3HZ9IfDvouUey3hbkRZB68YqleqLr
	WjDWhUjZw6pP4+nT3XaUmN8MKy6V5ycS2UtIYAULj4+66ddU3Wb64ZJwKglg4v7pTxXiYo
	qm5HhyGrDV/a9wsso8YKtj9OjJTkhkQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-v5IXj_RGNa26lxPNJL9Svw-1; Fri, 22 Aug 2025 11:51:16 -0400
X-MC-Unique: v5IXj_RGNa26lxPNJL9Svw-1
X-Mimecast-MFC-AGG-ID: v5IXj_RGNa26lxPNJL9Svw_1755877875
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41b779aso1338809f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755877875; x=1756482675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BvzPxkykRVHqIEzV8JDMXRhoyfWSdFzz+8/KZrTRO4=;
        b=bACjL8r3/CY5AExwb/uAeZrbLa09JbVRnYvxDMmYfIiRkkrAc+bcjbWRREAHKNTPKm
         c3CHsD8U7X9cB8a86zaNubzhtEgqIzuZxTPVI2lVORfQv5DzcZ548CPQXxqIpbSVzJv7
         XFvGhLtTbbSzEeyB1XFMg1voDT3hhSihLouijwFrf1OY0dBn0G7Fxr9Yix65F9OHBTIV
         KWtD3lFdkxZgFQLIiNcv1HepTV+w+Rt92woXJ7PYbghMjKF7cMJP2PqzLLI/G+alSnk1
         /rhyHJatJC2zXil8aMazTUcCS7pZMLEnNkWux7mWqkxh1/ZWprHrZWg+fiL38gjKu2ks
         Opdw==
X-Forwarded-Encrypted: i=1; AJvYcCXOhn5lbWIfuPEYIL9yGV6shBT4K0Lr9ACtgPp+qYwhqRMTJ50etc15mTtFxwcVIFXBpCn7r6329sG8Bg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJiQiI5pz9C0IjciDZ2qIV55iOG4n6nWfOBx2Z2npgkBvRA4b
	aLMMSASuorB0X3O6dWS+RKdhBkv2ooTp54ZatIX2D+GmwQ2a05thv4unghRR5c0c7v/npVpK39D
	pPf8/rLP6Wze/kdT+nQMTC4L2WXbMMUIazU7BYmQ0XG5+hLw20mcxl/nBe9vHpeeSqA==
X-Gm-Gg: ASbGnctMxNf0uyA/1HZx9N0b5VQa2V3Op4lsSmsfyLGBHIZ1ioNnTNACFLUwlCkh5re
	k7+KNriAuyUq8W3mdhxvO9xWSNv/Aoc0/OEJnF1YIINa6Ff4HsvSpMaQ67nkdu7qkeI/2qmh0Du
	IBOvTuam/afivf+UiHdsGwN7W5sfbz6OwRtXs3Ohjqo0MiQqQeDcf4CWe0Y3UMxaCFqUJEsnRtM
	bBx4lFkRCAfqMTFBPJ/HS/9ZbsNcavI5lQ5EhVQ1D/HE9C0vUL4g6CdBy7uHmbEsQhadE2RsEk7
	bAP+uf/i5T8Od7/RJ6nnawsTiD3vXDvkW4vNUP+gUDl7eGzzTCO8215EU6yeOYc6iepUoud67Ou
	8rY2MCGdiGCI=
X-Received: by 2002:a05:6000:4210:b0:3c4:39cc:36f with SMTP id ffacd0b85a97d-3c5dbf688dfmr2862477f8f.15.1755877875261;
        Fri, 22 Aug 2025 08:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhYN11+67rMBgz16ClnCnqW00MFOHXeorVtm9b6qqSJQjhx17u8yhR+uioZgE7EVgCclCrTQ==
X-Received: by 2002:a05:6000:4210:b0:3c4:39cc:36f with SMTP id ffacd0b85a97d-3c5dbf688dfmr2862428f8f.15.1755877874506;
        Fri, 22 Aug 2025 08:51:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1aa3sm15223353f8f.32.2025.08.22.08.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:51:14 -0700 (PDT)
Message-ID: <4feda9bd-0aba-4136-a1ca-07e713c991b7@redhat.com>
Date: Fri, 22 Aug 2025 17:51:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, ecree.xilinx@gmail.com,
 dsahern@kernel.org, ncardwell@google.com, kuniyu@google.com,
 shuah@kernel.org, sdf@fomichev.me, aleksander.lobakin@intel.com,
 florian.fainelli@broadcom.com, willemdebruijn.kernel@gmail.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250821073047.2091-1-richardbgobert@gmail.com>
 <20250821073047.2091-4-richardbgobert@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250821073047.2091-4-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 9:30 AM, Richard Gobert wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 68dc47d7e700..9941c39b5970 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3772,10 +3772,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	 * IPv4 header has the potential to be fragmented.
>  	 */
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
> -		struct iphdr *iph = skb->encapsulation ?
> -				    inner_ip_hdr(skb) : ip_hdr(skb);
> -
> -		if (!(iph->frag_off & htons(IP_DF)))
> +		if (!(ip_hdr(skb)->frag_off & htons(IP_DF)) ||
> +		    (skb->encapsulation &&
> +		     !(inner_ip_hdr(skb)->frag_off & htons(IP_DF))))
>  			features &= ~NETIF_F_TSO_MANGLEID;

FWIW, I think the above is the problematic part causing GSO PARTIAL issues.

By default UDP tunnels do not set the DF bit, and most/all devices
implementing GSO_PARTIAL clear TSO for encapsulated packet when MANGLEID
is not available.

I think the following should workaround the problem (assuming my email
client did not corrupt the diff), but I also fear this change will cause
very visible regressions in existing setups.

Note that the current status is incorrect - GSO partial devices are
mangling the outer IP ID for encapsulated packets even when the outer
header IP DF is not set.

/P
---
diff --git a/tools/testing/selftests/drivers/net/hw/tso.py
b/tools/testing/selftests/drivers/net/hw/tso.py
index 3370827409aa..b0c71a0d8028 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -214,8 +214,8 @@ def main() -> None:
             # name,       v4/v6  ethtool_feature
tun:(type,    partial, args)
             ("",            "4", "tx-tcp-segmentation",           None),
             ("",            "6", "tx-tcp6-segmentation",          None),
-            ("vxlan",        "", "tx-udp_tnl-segmentation",
("vxlan",  True,  "id 100 dstport 4789 noudpcsum")),
-            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",
("vxlan",  False, "id 100 dstport 4789 udpcsum")),
+            ("vxlan",        "", "tx-udp_tnl-segmentation",
("vxlan",  True,  "id 100 dstport 4789 noudpcsum df set")),
+            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",
("vxlan",  False, "id 100 dstport 4789 udpcsum df set")),
             ("gre",         "4", "tx-gre-segmentation",
("gre",    False,  "")),
             ("gre",         "6", "tx-gre-segmentation",
("ip6gre", False,  "")),
         )


