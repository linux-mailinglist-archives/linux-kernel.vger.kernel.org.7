Return-Path: <linux-kernel+bounces-891109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F67EC41DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA1A0351CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60953009EE;
	Fri,  7 Nov 2025 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y37ErSiH"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303772D94B9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555583; cv=none; b=uu0A8vNpAl3JP8RPhym0oTqomYIt4cU3AqWsSy24L9zsOalurKOT/KBFNolwoisguM3hfELMw58gEJ0W7be7DKAiPagRlN5J10vysEqJzHrQ8Dmx/M6ouFuoIGJV9ILXlJna40Gfd8WyZ0rGriqva/l6Gcg/gxtLs29wCIS1BnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555583; c=relaxed/simple;
	bh=Iw0djrGj0E1EeAmzCQwmf4P9quCFdn1G1qnajo2IswA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=gcWpB3pcD7iwhJP4hqX7IEcei8FxPCUldqPVaHtTXJrn8En2+GCJ4jBdGIUXHD2bkkXUTXxDnO4F8BeJnY02HspfE4Zcw9LUSLvu0xb7cfuUh5U1fkN20+DA2WxWCv3wdRdFtO90RICjTIEfKq7ZBpOvuTWBd9LwIzRlOrYCiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y37ErSiH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e89de04d62so10130301cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762555580; x=1763160380; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLmOflXkVRsPG430Y/bM1DxcagZMiyutQotB6mJKGqY=;
        b=Y37ErSiH4Isan3caNYKDLIEIsV77MBpWe/YiN+tvF/g0CpXXvUE3DSr4FHkaDjvm37
         HU25KiqHTNV60ZiCsYzOMvS1HJruZknV8Pwwfro4xSXUV/nWQg8uSd7UfWvLjYOq58bF
         yQUClq9RlHRYpObM41GxH9NnxWe+wMg2j77RDBWG1zExYLuh+dPNWC9Lj3U2AOqK+DMx
         KVknOFKG3FceXGCpSQEYE0ux3POONuMPreTSV2q+q1D29sc5EBuoOMRJfAzVGR0mWKvL
         LpYT1KBfsIpV3HbpzGgZAtVseewMON6p3Kog9y+tFzi5/hzsn1B+/O5Noe/OqS6ngot1
         tshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555580; x=1763160380;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLmOflXkVRsPG430Y/bM1DxcagZMiyutQotB6mJKGqY=;
        b=UOBDGzj38bY4n3xF754VPqztaHyqGRchMwsCJVO+5qvMMHM99MQ+2/+cfOwQjxAdW0
         ZKQ0WnPkcLZMJJph3QHLa5sIkQmhZM4m3C3KahB7StgXvP9KYu04ZQvq9gEZQ0hD4hdX
         I+NPwpoC/7eKzKvO7dcfEh1bQ0662WZCVCW5dZUGbgKTNtp7F9FAtYA2lvhqf+oXJJlf
         wi4yPXvlsesAYkEO10dA/Li0maMyjEtHZ8eE7Z0OknzBYfWLvpmOV4t7zGqJLJ8Xw4OQ
         +Y5h+RZeslCgNcEY05uTaAStnXPDPGvIO9FkD+65Z/s5m1DqID+F/XfYwIDFtdJT8b/2
         F3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUMcrwyGrPm9w00NalXy33oS7Bvd9rDckYRiXGnD0P49tN/zuuIujhsSxzdKcrDCzf99nY5tQHl8aC/Hps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Hsml0sLxKzmDj60oxvNLMO9keQVsAQLNii3TgVPFe+hP8r4D
	sZ8QdQ3LpPw9gO+8EYXgb33JPdKXo0fncVnNB6ieUWz70PNQGvduhmbW7WsUzR7tEw==
X-Gm-Gg: ASbGncsAuvUogTP815KloCOJUCYOBAUotNO63LJ8rr+RiVFXYVVPXH5WQ7eTOnxng+u
	MpRoJn38a0hWla1WozZV2BdsjESqoOu7uJqFKIb21tDFnqZqmlOXKBZ71ioHo7Us1aMjdxNO7PZ
	/HkOSd5rdfHAQPhUXnkCfNr0jvX08WFvKJTai26DoG2ovEYw0+NeaixCdm9AJPTFuHOlUViMXAj
	GhMHG7XdwqbSTFJWE4uK8u9UkDWUIgTEMX76dUmSgeEffFsuzkCe84cRSaRt4k0gJzigS3xzso2
	H+cAFSQWdF+0xn+ef4aZ4cfJX+AbzFRs0LssuxvOjX0+52KgPjiaaYwm1YPeoiKdRRfT29AOsIw
	hFhri0GV4eOf+y9VPDWz6vXyj8WQ7raL++Vaz6ZlMREZo3jinvXhbG48R+yfSxfFKvGIz3GGUbS
	dUJgGXRPSe449TOTH8TBsGyQCTVxPSCHQrXFAd9I5U40e12jwkVNCinOVO
X-Google-Smtp-Source: AGHT+IHrQn8HXQkHpkHyR17I/vgJvQDZ3PvcxfyB/9NyJzEb8+tk8bEQSW8kbFzruHMF1M4pLru8Dw==
X-Received: by 2002:a05:622a:1455:b0:4eb:a2ab:4175 with SMTP id d75a77b69052e-4eda4fa3eebmr10623901cf.39.1762555579930;
        Fri, 07 Nov 2025 14:46:19 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda56132c0sm3554831cf.7.2025.11.07.14.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:46:19 -0800 (PST)
Date: Fri, 07 Nov 2025 17:46:18 -0500
Message-ID: <e92df5b09f0907f78bb07467b38d2330@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251107_1632/pstg-lib:20251107_1737/pstg-pwork:20251107_1632
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc: eparis@redhat.com, fw@strlen.de, pablo@netfilter.org, kadlec@netfilter.org, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v5 1/2] audit: add audit_log_packet_ip4 and  audit_log_packet_ip6 helper functions
References: <acd8109245882afd78cdf2805a2344c20fef1a08.1762434837.git.rrobaina@redhat.com>
In-Reply-To: <acd8109245882afd78cdf2805a2344c20fef1a08.1762434837.git.rrobaina@redhat.com>

On Nov  6, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Netfilter code (net/netfilter/nft_log.c and net/netfilter/xt_AUDIT.c)
> have to be kept in sync. Both source files had duplicated versions of
> audit_ip4() and audit_ip6() functions, which can result in lack of
> consistency and/or duplicated work.
> 
> This patch adds two helper functions in audit.c that can be called by
> netfilter code commonly, aiming to improve maintainability and
> consistency.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> Acked-by: Florian Westphal <fw@strlen.de>
> ---
>  include/linux/audit.h    | 12 +++++++++++
>  kernel/audit.c           | 39 ++++++++++++++++++++++++++++++++++++
>  net/netfilter/nft_log.c  | 43 ++++------------------------------------
>  net/netfilter/xt_AUDIT.c | 43 ++++------------------------------------
>  4 files changed, 59 insertions(+), 78 deletions(-)

...

> diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
> index e35588137995..f53fb4222134 100644
> --- a/net/netfilter/nft_log.c
> +++ b/net/netfilter/nft_log.c
> @@ -26,41 +26,6 @@ struct nft_log {
>  	char			*prefix;
>  };
>  
> -static bool audit_ip4(struct audit_buffer *ab, struct sk_buff *skb)
> -{
> -	struct iphdr _iph;
> -	const struct iphdr *ih;
> -
> -	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_iph), &_iph);
> -	if (!ih)
> -		return false;
> -
> -	audit_log_format(ab, " saddr=%pI4 daddr=%pI4 proto=%hhu",
> -			 &ih->saddr, &ih->daddr, ih->protocol);
> -
> -	return true;
> -}
> -
> -static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
> -{
> -	struct ipv6hdr _ip6h;
> -	const struct ipv6hdr *ih;
> -	u8 nexthdr;
> -	__be16 frag_off;
> -
> -	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_ip6h), &_ip6h);
> -	if (!ih)
> -		return false;
> -
> -	nexthdr = ih->nexthdr;
> -	ipv6_skip_exthdr(skb, skb_network_offset(skb) + sizeof(_ip6h), &nexthdr, &frag_off);
> -
> -	audit_log_format(ab, " saddr=%pI6c daddr=%pI6c proto=%hhu",
> -			 &ih->saddr, &ih->daddr, nexthdr);
> -
> -	return true;
> -}
> -
>  static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
>  {
>  	struct sk_buff *skb = pkt->skb;
> @@ -80,18 +45,18 @@ static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
>  	case NFPROTO_BRIDGE:
>  		switch (eth_hdr(skb)->h_proto) {
>  		case htons(ETH_P_IP):
> -			fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
> +			fam = audit_log_packet_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
>  			break;
>  		case htons(ETH_P_IPV6):
> -			fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
> +			fam = audit_log_packet_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
>  			break;
>  		}
>  		break;
>  	case NFPROTO_IPV4:
> -		fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
> +		fam = audit_log_packet_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
>  		break;
>  	case NFPROTO_IPV6:
> -		fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
> +		fam = audit_log_packet_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
>  		break;
>  	}

We can probably take this a step further by moving the case statements
into the audit functions too.  I think this will make some of the other
changes a bit cleaner and should reduce the amount of audit code in the
NFT code.

If we don't want to do that, it might be worthwhile to take the
NFPROTO_BRIDGE protocol family reset shown below in audit_log_nft_skb()
and use that in the nft_log_eval_audit() function so we aren't
duplicating calls into the audit code.

[WARNING: completely untested code, but you should get the basic idea]

diff --git a/kernel/audit.c b/kernel/audit.c
index 26a332ffb1b8..72ba3f51f859 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2538,6 +2538,59 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
        audit_log_end(ab);
 }
 
+int audit_log_nft_skb(struct audit_buffer *ab,
+                     struct sk_buff *skb, u8 nfproto)
+{
+       /* find the IP protocol in the case of NFPROTO_BRIDGE */
+       if (nfproto == NFPROTO_BRIDGE) {
+               switch (eth_hdr(skb)->h_proto) {
+               case htons(ETH_P_IP):
+                       nfproto = NFPROTO_IPV4;
+               case htons(ETH_P_IPV6):
+                       nfproto = NFPROTO_IPV6;
+               default:
+                       goto unknown_proto;
+               }
+       }
+
+       switch (nfproto) {
+       case NFPROTO_IPV4: {
+               struct iphdr iph;
+               const struct iphdr *ih;
+
+               ih = skb_header_pointer(skb, skb_network_offset(skb),
+                                       sizeof(_iph), &_iph);
+               if (!ih)
+                       return -ENOMEM;
+
+               audit_log_format(ab, " saddr=%pI4 daddr=%pI4 proto=%hhu",
+                                &ih->saddr, &ih->daddr, ih->protocol);
+               break;
+       }
+       case NFPROTO_IPV6: {
+               struct ipv6hdr iph;
+               const struct ipv6hdr *ih;
+
+               ih = skb_header_pointer(skb, skb_network_offset(skb),
+                                       sizeof(_iph), &_iph);
+               if (!ih)
+                       return -ENOMEM;
+
+               audit_log_format(ab, " saddr=%pI6 daddr=%pI6 proto=%hhu",
+                                &ih->saddr, &ih->daddr, ih->protocol);
+               break;
+       }
+       default:
+               goto unknown_proto;
+       }
+
+       return 0;
+
+unknown_proto:
+       audit_log_format(ab, " saddr=? daddr=? proto=?");
+       return -EPFNOSUPPORT;
+}
+
 /**
  * audit_set_loginuid - set current task's loginuid
  * @loginuid: loginuid value
diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
index e35588137995..6f444e2ad70a 100644
--- a/net/netfilter/nft_log.c
+++ b/net/netfilter/nft_log.c
@@ -75,28 +75,7 @@ static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
                return;
 
        audit_log_format(ab, "mark=%#x", skb->mark);
-
-       switch (nft_pf(pkt)) {
-       case NFPROTO_BRIDGE:
-               switch (eth_hdr(skb)->h_proto) {
-               case htons(ETH_P_IP):
-                       fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
-                       break;
-               case htons(ETH_P_IPV6):
-                       fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
-                       break;
-               }
-               break;
-       case NFPROTO_IPV4:
-               fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
-               break;
-       case NFPROTO_IPV6:
-               fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
-               break;
-       }
-
-       if (fam == -1)
-               audit_log_format(ab, " saddr=? daddr=? proto=-1");
+       audit_log_nft_skb(ab, skb, nft_pf(pkt));
 
        audit_log_end(ab);
 }

--
paul-moore.com

