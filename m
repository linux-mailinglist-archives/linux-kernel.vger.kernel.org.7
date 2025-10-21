Return-Path: <linux-kernel+bounces-862117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B0BF4769
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC62F18C553B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAEA20ADD6;
	Tue, 21 Oct 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7Dn7VWD"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3FC1A3166
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016295; cv=none; b=R1CwCMHLPOqLoagTYHGqJtmRowZ2DJ2VUmOPXQUD/afrb0BybMk6oZGEVAgDStYenXrbAexXliCi7OK6yWpD6BkBr6weCOUTPynuEMjmraGKgKu557uWFEvuGthkueOvkpMEJ3NmZCukRcUAviD5Tmf8AN5axYU97OujT4uTGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016295; c=relaxed/simple;
	bh=GiwpcrMR/TWL6tAbqQHX/odqPY5+0sz0jLyT8mHTXC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiIKE2+lq6BT7rSD1vOtOcYVH7MtDIXrWPNtd3IT370Hd3ZYCLBc83PfjhsbZ8NrGfkyq0rTXWhDs4CaXXJzXo3QOd0Cz65fU/4BzjFIRF9y1F62TccN90Dr+198lnQKBO4ktEJXtTNq95i71TLishVp6GGBVDW4GSl199183nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7Dn7VWD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-28a5b8b12a1so51309075ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761016293; x=1761621093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zzIYo6bijCpxcJWIZhtdJb/qti87IejtmfdbwcbHR4=;
        b=Z7Dn7VWDuuo4leCGlP6Tnn9hZlh8w88kUr6KdilBEFxcBSYOD+mcoVLbjfFYL/BU3A
         uUUBSm38Q9OmqAuyjMJngIW604p0xvwZ1eYw4p7+WWEmtQ/S8ROY/LVEH5kreXTVdd8j
         8WlGex+frZZDSoTmQXGOF2Fs6XY4qLuTWg4uK9KknR5Vavhcty9J3YMuWuvh/NP48kHF
         1bh9WjFdVIhDqZu3bursSUYf4ZkrvXTMjccL/LqMmtxPcOAQ7/4hClri/cmKkzGEYRCB
         HxPhnQ9SwsJMJHUgn9Bz0OcxOR6sYDWyt0f4KwU3kzMiNeE8RhEC6SkCKeUz5pEeMjsc
         Mmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761016293; x=1761621093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zzIYo6bijCpxcJWIZhtdJb/qti87IejtmfdbwcbHR4=;
        b=FnOxRlDUzJGj8QpJcPX9912tICIwsZaeXyH/6wocU1K3AWNd72kGK15RnRwT9cFGWd
         ebudaQ4YfPHHYhFH3W+xeld1t+ryPpQrU4vq/87JdQck9iD/IiNR7O7j8Avquh/uBXlD
         sNzKWSL35H+LeU7W87HH2tfZEPwB9vLGuYAk9maKFWeqYiZvZ8RsRaPH8ons/hINBIx5
         cwDad5/6Jl6hKnEn8OiYdbifo9xwz5wdT6gGRrVuPPAqZGmkFR5TF+0yFPWz4F5kyAan
         6GbjpJyqktD1/VKXeiQoizF1w/vF6ESrZNn3w9/iZz4PBEpfnDSkjo2P+BZGCIxTINOn
         PnUA==
X-Forwarded-Encrypted: i=1; AJvYcCUgkTJ9LVFijlFSYje0N7NceS54+DueHNJ6d6YDsMKe3tlqyLr60cU3Aq+rSGIAQ9PnUsDZZ6IuttVHwWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLRh8nfFXQXRmBLvOcFvsNIPHlAqHoVuyu6PAGWwlZzzIB/CA
	Wx7JBPi8zNQtt4gM+/3TPPMvCYQtCd3kPtmWsSBAmr04kf+ttkBZSlJP
X-Gm-Gg: ASbGncvY/1RiPz/T5qFbbvS0DX/ArekMLXr0FxpL549LTGCVkUPP9Tg/BY8bIERLp75
	YOw4Pi3Jl76OhX7lP1c1qTUAMGBDIUbMVq1QYKjZkCH9IiZasYTpcu5sx2OsL+PiPO37XG0KP1L
	KZmcvf6PNQd1v3IME4ceH1+4r8XCRAw1ZFoYNBbGy/LmdkqYJ4B8we+FzBb+Mcgmmk9vVV8CeU4
	0QvpDhXx6RYtcOltdYynR7/vDW5pZRymWuV2tnHGIR/kt/7C7/aUo2eiIxoW/b8X/nuXKpL0Ul4
	wBugRU+ECT7h1kdygVM7QuUBmzOvjahooeTEDkEyMJtV8mlbQ1qA3+DnaRHwVB1lPS6rlbpUTIT
	uAdDLuXi+XCt6dLsWH9pktZtcg4UsU0Xmmotpl9Mx/4CJkoj/Okbxg1E64dX4mvmhynlXa5JxZc
	lhK0K/kyz8e4u9kg==
X-Google-Smtp-Source: AGHT+IEoy+E4PgcisDYxaWGi0W8ZQNNYC69FKnsLNNDw9J1mSnMjPF70iln4Fvt45A3k6aqHS0uRTw==
X-Received: by 2002:a17:902:ce12:b0:252:a80c:3cc5 with SMTP id d9443c01a7336-290ca4f9174mr168922825ad.22.1761016293038;
        Mon, 20 Oct 2025 20:11:33 -0700 (PDT)
Received: from phytium-Ubuntu ([218.76.62.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm95037755ad.52.2025.10.20.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:11:32 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:11:27 +0000
From: Zuoqian <zuoqian113@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: macb: enable IPv6 support for TSO
Message-ID: <aPb53y1MSNdDXr2d@phytium-Ubuntu>
References: <20251020095509.2204-1-zuoqian113@gmail.com>
 <657cf1e4-a27a-4d9d-9931-494ce26ef325@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657cf1e4-a27a-4d9d-9931-494ce26ef325@lunn.ch>

On Mon, Oct 20, 2025 at 09:01:13PM +0200, Andrew Lunn wrote:
> On Mon, Oct 20, 2025 at 09:55:08AM +0000, zuoqian wrote:
> > New Cadence GEM hardware support TSO for both ipv4 and IPv6 protocols,
> 
> What about the 'Old' Cadence GEM hardware? I'm assuming you mean
> something by New here. So it would be good to make a comment something
> like that IPv4 and IPv6 TSO was added at the same time. So if IPv4 TSO
> is supported, IPv6 TSO should also be supported, so there is no danger
> of regressions with older GEM hardware.
>
Thank you for your suggestion. 
The Cadence GEM hardware I'm using supports both IPv4 and IPv6 TSO.
However, I'm uncertain whether the driver's initial support only for
IPv4 TSO implies that older hardware versions exist which solely support
IPv4 TSO.
> > Signed-off-by: zuoqian <zuoqian113@gmail.com>
> 
> This means you are agreeing to:
> 
> https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
> 
> However, we say "using a known identity", since this is a legal
> statement. I don't think zuoqian qualifies. Please you a full name
> here.
> 
>     Andrew
> 
> ---
> pw-bot: cr
Regarding the identity verification, "zuoqian" is indeed my legal full
name.

Regards,
Zuoqian

