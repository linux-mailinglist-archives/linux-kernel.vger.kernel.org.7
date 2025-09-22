Return-Path: <linux-kernel+bounces-827788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45BB92ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25A6175187
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701A2F3608;
	Mon, 22 Sep 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJdJ2Qz/"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133EE2F0C5F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569916; cv=none; b=WZvxYif4bNFddoFr8nxW7PgBcLJnh8Cn1Q0xSQXpRyr7HRwz76gQswQi+XXcNAacaZbSYhHt+gQAvWnky9QJhu8ANQHfRUL6qw76XBdSgGpr5XblwJ6q1wmIKbLyATIFNVJXs0G2hKzp5nVlpiKVeiw7mtDXdgzRgtsb3YEthiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569916; c=relaxed/simple;
	bh=wPfLFlEhQ10lVPBK0QkKuPYsFDMT88ye1SoyoPyiZFs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IXEinob47KQhMqTLoChO2fu8r3X3XA4ZgXs8FKBORNdoNGJPvCtQjfKCCG9oQ9M8HmMm0yrzPxV7WOU1Pzrj+XQvVsi3jpv6hz1U3jM2l8jd/ZA5grdL8w8sMtf5iSYKnCsTI4oY57aONyCEHbIrkJZIVrz3jVo1BTCwQblKKsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJdJ2Qz/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b60144fc74so61221421cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758569914; x=1759174714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6i3MlHtjGFbHj5X67wDWuS9zmOt/GF2t9nIF1CeTPP4=;
        b=VJdJ2Qz/oJWvFW1pHmRtpfx3YQSmb+DeQaOOFLhE5oOIqMlAElbKMEcsppK8NhFtRL
         1C/5VEIHu0iXWbSuWmLRaAdIoVD9GO2Ws8nfFQ1uvu8IknC5KvidmqbSjIQEbqVfTVSB
         2QUxfmLG5NoAeomnRN/df11WpcGAAQ+ftgoCDsHJ0zDfvTRxJO2tgTBHCHc6QeLKqy44
         MGmbDVYH8Opd7XpHCWMIuA8V9+Qd+s7ygiwT2JudSgmIDyXao5c3htn8kUGAkj+B6CKb
         8C5+jjjk2Lh0vR37PpCkCpA8DCHVL3fMXulhatSIt82S5kAF5kVT421/i/MCoHam2p4W
         LV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569914; x=1759174714;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6i3MlHtjGFbHj5X67wDWuS9zmOt/GF2t9nIF1CeTPP4=;
        b=RcLZUZGrzTh8/bq6NKMO+B4AZ0u/L0Z9sP9ximbfw3WWupDlYEY5gQma/c6PPZ84qF
         Y9jEAa/thURHcx8PAstx8st2SnvT2kXoOTm0jpn0V2nZ9uf7xAIiR25sJ0UCPoeT3vUG
         Q6ZuHOdKPI642tfAnLODu3SetnWrCzj40tqLtSkeMEYTYpHX4QDMSy5EZlebDqO/JC4P
         7LX+e1LqnCBC9xvQo9nlLJUIULdbEKM28q5MNHs2answkJptzPG6Sza0dHazkSy9TUHU
         BJBDJylbfrEtdRFcwMT4AkWcqQ28pp4r4uZYfGwWXYJdS0RrQKIE12yRDPvxt7j//zDn
         YUAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZzVqaxuHRyVfgnjrIe7YXuMmc6EhGUygNSVEiQbXBSUq7vPOmuhth4fX9S/51VIZ994iC1CxKA/6n/3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjvJUqayI401B/ZIAlLeIGLolEQSRpBrO2qraQaYW6E538nxlZ
	ShOveHLaEfQVh+d3qQLi1uDlZZXtaNjG1EbdVkjJ+B2NsKEXW0aI/C7S
X-Gm-Gg: ASbGncsSO2HJ6Gm3HskVxGKCe8CvQhGI0HNf3sTZONde6C9Puoz3+CCde2HZjsLsCVA
	ZXbrtfP7Pe+POxVSJw5lN2J1mTIPg+UG0TPwLo0Eb19wfetcTCHnJX7/9aZerE0CdUze51kJo14
	bovVOnS+txcowCXJBLAj2jmY2BIVjKudsy1LbqxCpkX7aTZMCrsKMp2C5hHggWDgKux225fH6XU
	t7CQJR3EBUKg8nhc2pFajnMhrRRy28EnuHQtH+led8JtWHWPtwP9uK0I3Yu3rN/I92hFtJrj2Ll
	qSTHM6LPEq1ZRmZ9cEnMEoROcvgwZ5qkR8kGGGzefOrY68lnGKRfCSJ/sTjGkYCqzimWcrZ+mEA
	XrziUJEvEye44QmQOHQQB8SdK/W3beD76soYcAHHUjJHEI9jmBNxbHooJP9RAt8HZku0waYKgqC
	gEqXKd
X-Google-Smtp-Source: AGHT+IGkHzNu6t/SPPqhpgqdaAin/hhAR5YuJRs8iLlNADeM14QiI5l3rfJ5t1agknOPG+GAcsQ09g==
X-Received: by 2002:a05:622a:1e0c:b0:4b5:e21c:80ba with SMTP id d75a77b69052e-4c072b441e3mr145527431cf.69.1758569913776;
        Mon, 22 Sep 2025 12:38:33 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8494af03273sm256045285a.70.2025.09.22.12.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:38:33 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:38:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.36de540ae86f@gmail.com>
In-Reply-To: <20250922084103.4764-4-richardbgobert@gmail.com>
References: <20250922084103.4764-1-richardbgobert@gmail.com>
 <20250922084103.4764-4-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v7 3/5] net: gso: restore ids of outer ip headers
 correctly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> be mangled. Outer IDs can always be mangled.
> 
> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> both inner and outer IDs to be mangled.
> 
> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc

Accidentally wrote feedback in v6 instead of v7.
Both question and point still apply.

