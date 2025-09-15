Return-Path: <linux-kernel+bounces-817864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3320B587AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1123F1B258B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB52A2D5C76;
	Mon, 15 Sep 2025 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWf5L8e2"
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A732D47E8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976085; cv=none; b=bR4bECTuGqG0rFftrtPzjCiQ3MsCdIE173sEVfzfh2nmD66Dai9glmdqENhrHdTkmge8+/1Af/BzwqqpeQAKitCMFAppYI35TlgFtXZMvKw5JcRqS5UJuxFxacWpG/wktLPHEe0ofXoYP3QLBepVrnUk9mftrOq8Gd4oWCF0Lhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976085; c=relaxed/simple;
	bh=/FpEkskje8VzgmQKrHZ28YlaYp7XOkF/46P2Reawgcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHvoH+RDP0BPL7owOoeqxuleWnubzj57FKsJ8qiv3+phJ94GCPdSZpDD+edyTr3My1ZoP8mdV/nLpDvU5nkJk+pNmeLFRssvwSijh+/4A+UTicR8WBi1F+WZLDculTr4iA8z4BjdgyegaYnfoYXyzeIoIt/PrdZYZMlMMttVTSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWf5L8e2; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-71d603a269cso32030407b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976081; x=1758580881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SASXu10pDfkgCCS289Wyjl4zMwympeKKk54Tf2B/jKk=;
        b=EWf5L8e2qgageF5LTvh0wsfFaMfjUNE3SvV0nn49XC3jIC72dvy04mtZhteuXRF+JT
         o7hphU8y2g+bkF4zlzxbkFBPU8cFv0g1YypsdZFguUqpoMcdS2olor7F1xJA1qWtTvoM
         py53QY6YAa7b2Q5p9szr1XWMKLD0TMBkkkAVXa+KWkvwLc8X/bKEkDwYxUgWbXv4jTSA
         XKWWF7wu2svzvfrgziljPomoWqr5axWeZP4mSRh9tIjJyHI8hdkraNx3s2YbKmr/ALPc
         MNpyuOZbNBz8s72uwoqsVxL7GVQWc+WQSajs8AyDgLi4Cmo4Xwj06es7X5FsQaaTWqqQ
         daPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976081; x=1758580881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SASXu10pDfkgCCS289Wyjl4zMwympeKKk54Tf2B/jKk=;
        b=OFBEVXhSuze9q1dPJE97FBhDQ+/ddB/QK+Ym1RfPQsH3rGFgJ4b5fsANBy1XLgDN7o
         RdrxWJpEtEw4tquI9B4lKQm9YtHgdbdRAr+MG8aL9aa0y5VDvMiX063LmjSjY+6nlgls
         wzS+fNwNBbVmYjX7SZg9gUHGL2SfqmwihUu7qCQRIUVlprZOGFwt+GzNO4tQgX+dDq1E
         azZdTe+42aTlSQZIVkwV80UGzhrmLUSdqGnKXnT7t9SO5tLOyWtJSLXRro4C3shdpzig
         C00DipPxi8xnCRckpbXlX6PWLxMGSitcUgpKByaCk9+0acv0p/R1AELfLawlARnUf3PY
         8zjw==
X-Forwarded-Encrypted: i=1; AJvYcCUHctripVi+osiPcBEzYJEwcrsO1ucEIVHCCjJj3g28ueZey2JexpZprUg2nA/2+1fqkR8n2q12N6X5IVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDt7X0lyOo6q0nAZdQSMFAmhqIyXqRdinDoodRN30JjuSFwnkh
	qoOKVVc305yKPi/lNdJIKjretfhJVNj2wpLLiJ7uTlnMRXR+vglU8Ez3
X-Gm-Gg: ASbGncsI9AKOK3tbQ3PO4jkQo2WOAHy2rtClKyTLXpGMA93PNBzlKLrMrzEKM2Lvqon
	TFFbmxv9saWJi6mW6GTIrHHTKxGUFQX9fd/SkYvsoySiIYm7LI2uG/i30b0dJ09yji8RxDiGxpm
	px069/p3itI3jc8/9T81omSMvPelz//z/fzKesT/n5C4H6Dmfkt7WVXfc4lYKw6msJJIJulDFVx
	BQALe12Cr6cKPji8uZ1gnVZHvjwLiktlufQVw0acpBON8xwEmetPT1BxR/Zabk+VmmaZtTSvC3i
	k+l7YkkvHnUbYvd4k6wJom44WdzuKginub0FOnLaZL9TvcMI24KqNLlORZIktryRrbtQ5G44n/d
	PwK2WfYLiltq0eOAQR2aqq67jg8kS2vfnnQ07KoTT5jcgsv9SjQTG19qkAoKkfg==
X-Google-Smtp-Source: AGHT+IFKVDiqyeLRRwAZpNsUiXjihQklNAwRtRpOrO3aDhyURhUxOWyVrNC2ovqPRD+l0SvqAcUU4Q==
X-Received: by 2002:a05:690c:680c:b0:721:64ec:bc64 with SMTP id 00721157ae682-730650e0742mr139176837b3.35.1757976080933;
        Mon, 15 Sep 2025 15:41:20 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f791a35bcsm34972157b3.39.2025.09.15.15.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 15:41:20 -0700 (PDT)
Message-ID: <be567dd9-fe5d-499d-960d-c7b45f242343@gmail.com>
Date: Mon, 15 Sep 2025 18:41:19 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Trigger host query on v6 addr valid
To: Ido Schimmel <idosch@nvidia.com>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
 <aMW2lvRboW_oPyyP@shredder>
Content-Language: en-US
From: "Huang, Joseph" <joseph.huang.at.garmin@gmail.com>
In-Reply-To: <aMW2lvRboW_oPyyP@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/2025 2:23 PM, Ido Schimmel wrote:
 > On Fri, Sep 12, 2025 at 06:39:30PM -0400, Joseph Huang wrote:
 >> Trigger the bridge to (re)start sending out Queries to the Host once
 >> IPv6 address becomes valid.
 >>
 >> In current implementation, once the bridge (interface) is brought up,
 >> the bridge will start trying to send v4 and v6 Queries to the Host
 >> immediately. However, at that time most likely the IPv6 address of
 >> the bridge interface is not valid yet, and thus the send (actually
 >> the alloc) operation will fail. So the first v6 Startup Query is
 >> always missed.
 >>
 >> This caused a ripple effect on the timing of Querier Election. In
 >> current implementation, :: always wins the election. In order for
 >> the "real" election to take place, the bridge would have to first
 >> select itself (this happens when a v6 Query is successfully sent
 >> to the Host), and then do the real address comparison when the next
 >> Query is received. In worst cast scenario, the bridge would have to
 >> wait for [Startup Query Interval] seconds (for the second Query to
 >> be sent to the Host) plus [Query Interval] seconds (for the real
 >> Querier to send the next Query) before it can recognize the real
 >> Querier.
 >>
 >> This patch adds a new notification NETDEV_NEWADDR when IPv6 address
 >> becomes valid. When the bridge receives the notification, it will
 >> restart the Startup Queries (much like how the bridge handles port
 >> NETDEV_CHANGE events today).
 >>
 >> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
 >> ---
 >>   include/linux/netdevice.h |  1 +
 >>   net/bridge/br.c           |  5 +++++
 >>   net/bridge/br_multicast.c | 16 ++++++++++++++++
 >>   net/bridge/br_private.h   |  1 +
 >>   net/core/dev.c            | 10 +++++-----
 >>   net/ipv6/addrconf.c       |  3 +++
 >>   6 files changed, 31 insertions(+), 5 deletions(-)
 >
 > A few comments:
 >
 > 1. The confidentiality footer needs to be removed.
 >
 > 2. Patches targeted at net need to have a Fixes tag. If you cannot
 > identify a commit before which this worked correctly (i.e., it's not a
 > regression), then target the patch at net-next instead.
 >
 > 3. The commit message needs to describe the user visible changes. My
 > understanding is as follows: When the bridge is brought administratively
 > up it will try to send a General Query which requires an IPv6 link-local
 > address to be configured on the bridge device. Because of DAD, such an
 > address might not exist right away, which means that the first General
 > Query will be sent after "mcast_startup_query_interval" seconds.
 >
 > During this time the bridge will be unaware of multicast listeners that
 > joined before the creation of the bridge. Therefore, the bridge will
 > either unnecessarily flood multicast traffic to all the bridge ports or
 > just to those marked as router ports.
 >
 > The patch aims to reduce this time period and send a General Query as
 > soon as the bridge is assigned an IPv6 link-local address.
 >
 > 4. Use imperative mood:
 > 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 >
 > 5. There is already a notification chain that notifies about addition /
 > deletion of IPv6 addresses. See register_inet6addr_notifier().
 >

It seems that inet6addr_notifier_call_chain() can be called when the 
address is still tentative, which means br_ip6_multicast_alloc_query() 
is still going to fail (br_ip6_multicast_alloc_query() calls 
ipv6_dev_get_saddr(), which calls __ipv6_dev_get_saddr(), which does not 
consider tentative source addresses).

What the bridge needs really is a notification after DAD is completed, 
but I couldn't find such notification. Or did you mean reusing the same 
notification inet6addr_notifier_call_chain() but with a new event after 
DAD is completed?

Thanks,
Joseph



