Return-Path: <linux-kernel+bounces-775468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E3B2BF82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A14A68477F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AC3322DC7;
	Tue, 19 Aug 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIi90rfj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59C322A32
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601026; cv=none; b=rqFNMzTkG9AIdnzakNZ6J2ySmD0klbWGSwXfVSZe8gAdulUBgSgEYceIVWWvJbBAksf5hO+wUNiIrAqb+mJCxBFF0Hq6AK5LMJbvZJK+mbsV0DO0IZf3h68dTERkoToRQ0X209iCVeak+ALHe4eO+GGt4+Esg8Y9mWCwLfxwbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601026; c=relaxed/simple;
	bh=rZL+wNNkkSaYWCQ+s/sEu/+VRbLDXmLW0HZ3ko4ckms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LH+KZD/8BQgPZ0tiqN+Pm26zvNpx4d8+nG1KAruaPqpasI1iRvgU2VCr6fJZhDBMCjlE4CR5kW/gyi1OnFOZgkWt2mZ9bqNzoDg717eUsvR3N2jrc5MYqOZyzQTIPFbBOPTTqAKJgcm+YvWB75RXizrKVUCef0zho7YQemqreWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIi90rfj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755601024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZqMtC8zn+vOgLMpZN5F6L+enwy/jFamAIbV1Hg+0OE=;
	b=PIi90rfjCbFIkz7tOWjDjQWi1LStTCJWO+emV4nxDolUk7Z8SAmsmgdyol410C+B+XFcy+
	HOVer0xAhS+pDmYy9HmBbezusUt+GLznH+7QOiKZRh6xR1Zgo9JDIKUQ6nwmYbgj7AmVyY
	rqOrqaS6CzZTl9EuYCTUUr4E57cFXdQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-YX0_TusgMEGR4PGmKO5Olg-1; Tue, 19 Aug 2025 06:57:02 -0400
X-MC-Unique: YX0_TusgMEGR4PGmKO5Olg-1
X-Mimecast-MFC-AGG-ID: YX0_TusgMEGR4PGmKO5Olg_1755601022
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e86f8f27e1so1628403785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601022; x=1756205822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZqMtC8zn+vOgLMpZN5F6L+enwy/jFamAIbV1Hg+0OE=;
        b=vEQcLu3Nnj3EghfBQQNVtzMN4PNryI2HUPvZv4gKqHVyQp0zWTtOzEbDfzEuweoAJg
         CBdZ0cGXyDSG4HkwWXU+DuWTFce+Z6WPYhPFah0W2eONyC8puu0vcRlZRHBpcWwR1xx1
         8w9igwRCVNMh5y7qbhOVKaNuC8hmc8OUHmr8XtxK30lcGakqm5XtqbT0HHEuVAo1BQuj
         poe/3O2Et8MNZ0WmtSxBQ3FN3vQkDd4dVH/Mn+ROrY+agbJvaTCdQ+j0yRt4yoZFNB54
         op2AhoKEuavn7d9g4D4ysYzUlpGUr33o31ulDzBM9xz35I7bBuXef5fNNutlZEhSN0vb
         qmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlOg/RtY8tP9b3CpNv5gtuWnPEFWzga9gfF/8G7sB5TUQGMbwU0NL9AQ9tVEsUhNfCXgfVKo7kKtQYySA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtg/qNp+ISxzvXXuPlqrTbtfPm+sgFzx3KoOuBXhuhxP1IMKz
	pmV/anG1cYuaeR4ovOZS/5bNOipXP0LvrmJ1uO3bOijqQX58/k5XwT7KafH9AF/koldM98/DZ3I
	MPbpqcGChF9s4Yk4LyYT4/0Uf6qCPhNElnC3yp0J5jXOiZwiciDgS3p/jNspy/0TOUg==
X-Gm-Gg: ASbGncsL7+B2MH4PzE1XL54EGXa86LhydBN7/jFj7vPWL01BsL9imkWXXHj6CugV0NJ
	KYu3bfsvfrvy0UAYJ5He87ZS7zko6hCbfGw5sbBZN+m7Vd0wiqQCB0BwBPSlU6D5oo7uI2tSbme
	GI4p0wiVcyxmq4L8zc5tPjQeOXjiyw29Quqn0Yjz5Xloe+QvFjt7fe2jMzLq5Bq8TkbqZKQUaof
	9ga/doOHLjmcMOy2cV+PZFZiDe2RIhwHBQBXcYvjfhIbQsTkrRlcONb7ySf+ZUJTceLUentb/l8
	U4rGiRj8425pvup/oupSIm8bkWqtSkho+K25F9FqVhJDLB5gBjJWpiPwuu605eVg9zgJFMHDpnZ
	1wceXjwvS/2A=
X-Received: by 2002:a05:620a:4156:b0:7e6:2191:583b with SMTP id af79cd13be357-7e9f4b33d75mr176156985a.20.1755601022021;
        Tue, 19 Aug 2025 03:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs1FF9E2cq5W/gic4mgv+BEBYHZo17fYvd2cx2owI/XCkestf7MYq5z33hQe3gd/Ce09YdDg==
X-Received: by 2002:a05:620a:4156:b0:7e6:2191:583b with SMTP id af79cd13be357-7e9f4b33d75mr176154985a.20.1755601021556;
        Tue, 19 Aug 2025 03:57:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba92fa157sm69122986d6.47.2025.08.19.03.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 03:57:01 -0700 (PDT)
Message-ID: <98b7d1b2-843c-40c6-8918-1af431aedc5f@redhat.com>
Date: Tue, 19 Aug 2025 12:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests: net: add test for dst hint
 mechanism with directed broadcast addresses
To: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814140309.3742-1-oscmaes92@gmail.com>
 <20250814140309.3742-3-oscmaes92@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250814140309.3742-3-oscmaes92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 4:03 PM, Oscar Maes wrote:
>  tools/testing/selftests/net/route_hint.sh | 58 +++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100755 tools/testing/selftests/net/route_hint.sh

You must additionally update the net selftest Makefile to include the
new test.

> 
> diff --git a/tools/testing/selftests/net/route_hint.sh b/tools/testing/selftests/net/route_hint.sh
> new file mode 100755
> index 000000000000..fab08d8b742d
> --- /dev/null
> +++ b/tools/testing/selftests/net/route_hint.sh
> @@ -0,0 +1,58 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test ensures directed broadcast routes use dst hint mechanism
> +
> +CLIENT_NS=$(mktemp -u client-XXXXXXXX)
> +CLIENT_IP4="192.168.0.1"
> +
> +SERVER_NS=$(mktemp -u server-XXXXXXXX)
> +SERVER_IP4="192.168.0.2"

> +
> +BROADCAST_ADDRESS="192.168.0.255"
> +
> +setup() {
> +	ip netns add "${CLIENT_NS}"
> +	ip netns add "${SERVER_NS}"

You can/should use setup_ns() from lib.sh to avoid some duplicate code

> +
> +	ip -net "${SERVER_NS}" link add link1 type veth peer name link0 netns "${CLIENT_NS}"
> +
> +	ip -net "${CLIENT_NS}" link set link0 up
> +	ip -net "${CLIENT_NS}" addr add "${CLIENT_IP4}/24" dev link0
> +
> +	ip -net "${SERVER_NS}" link set link1 up
> +	ip -net "${SERVER_NS}" addr add "${SERVER_IP4}/24" dev link1
> +
> +	ip netns exec "${CLIENT_NS}" ethtool -K link0 tcp-segmentation-offload off
> +	ip netns exec "${SERVER_NS}" sh -c "echo 500000000 > /sys/class/net/link1/gro_flush_timeout"
> +	ip netns exec "${SERVER_NS}" sh -c "echo 1 > /sys/class/net/link1/napi_defer_hard_irqs"
> +	ip netns exec "${SERVER_NS}" ethtool -K link1 generic-receive-offload on
> +}
> +
> +cleanup() {
> +	ip -net "${SERVER_NS}" link del link1
> +	ip netns del "${CLIENT_NS}"
> +	ip netns del "${SERVER_NS}"
> +}
> +
> +directed_bcast_hint_test()
> +{
> +	echo "Testing for directed broadcast route hint"
> +
> +	orig_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -k in_brd -s0 -i1 -c1 | tr -d ' |')

Likely using the '--json' argument and 'jq' will make the parsing more
clear.

> +	ip netns exec "${CLIENT_NS}" mausezahn link0 -a own -b bcast -A "${CLIENT_IP4}" \
> +		-B "${BROADCAST_ADDRESS}" -c1 -t tcp "sp=1-100,dp=1234,s=1,a=0" -p 5 -q

You should check for mausezahn presence and ev. error out with error
code 4 (ksft_skip)

> +	sleep 1
> +	new_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -k in_brd -s0 -i1 -c1 | tr -d ' |')
> +
> +	res=$(echo "${new_in_brd} - ${orig_in_brd}" | bc)
> +
> +	[ "${res}" -lt 100 ]

It would be helpful additionally printing the test result:  '[ ok ]' /
'[fail] expected ... found ...'

/P


