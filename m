Return-Path: <linux-kernel+bounces-809748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DE4B5118E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED24A7ABA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01676310644;
	Wed, 10 Sep 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbXj/oYa"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2230F81F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493442; cv=none; b=VEhfBf9Um6a87yxMzw/ie3LeWlqMsHc/81odkb4OCVpxWup7EVxSRjAka9DP6ibzd5bWsbibzP5bSbpdpMrs/3ga7tKmuDeYzOwrdu/TxoIQc6+PUVZiqbmXjhHKafWkgcvHjJ9kbvaOus0+9oeESJjQ/HR0n2h7gqYhpTqSl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493442; c=relaxed/simple;
	bh=LhMaFFyNz3QPdZE1rUgzQv4XXgepJOyQfEYh3oaTmqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC/QSY3xdzMrrb7Xoiq9Jhs+s1mIzeX9lXNRcmXy+5ukugZTdv3En9vu4P++cptwgPFilunxHSFmspY6zLbSuSlByKufQnxzV1cQGM5A2Z6usZQsOw3e6RhKePmKDB9Cy4mLzELQSCFqx3Pzwa1fVGd8y7sGKsOBNFu+tt4wuDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbXj/oYa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-629f06935e6so655806a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493438; x=1758098238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmt8NRxXiTXIxxt7so4xgdOFQzQhtk1IBnRJvL5Y6wM=;
        b=NbXj/oYai8y+ayrkuu+6HnnfIBVSesuaRH8NqFwLfPkzv0IIj59ewVawQop8REZF/q
         qcc/3tQ0ID/wKyEvVWonLLuyLw1jWk6DPCCDp7teGM+B/a9XTGS1BFo+aEDBwHwafRP4
         ehoUFxuj2TQweuoIXMRkfI3MTlKBfukPr/Vmqlot97amIqMwTxmrEbEyZP149/eSexAD
         XbDiLHcK6DuyNPDevW8Kab7CuCsaOKjlPddi25Zgdno7/jccIjUibS6M83DirJpRzb93
         eMRixmggfSr7wA/IX9/X9oyhAZRl+8PQjH9dqC0JZQv458LmcCGM9UGUZW6nqEkr0iJE
         9f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493438; x=1758098238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fmt8NRxXiTXIxxt7so4xgdOFQzQhtk1IBnRJvL5Y6wM=;
        b=aEe200FB59Z6PX5YXbUK5+8fILixPSUphl60304eYb3vAOV6x35GipsVm/WYBqOxKO
         V1oH3ERgBeUrxgzEXjyjg125UqJGQhxxahQhpWW2gev5q9FVwVsj2oITOmd/zajz2Flo
         gTGeJSGruVH13XrU0JJm8rxM0sNmYhvo2TXW8ZABmgY0dM2UC8+kx6g/RxMeNTS48FZz
         os8QVODdfYwMSdBT19FJhwRp9XplXx85kiKOB1tIu7E622k3KBMj/ajZs8cVN9B3dhSU
         4traFYpNcnjKECUBxDeThrlrb8wvbGXhrcGB9kEeOaUXgRtYOAy7JyH1cIzNWXF1J+KY
         YVZw==
X-Forwarded-Encrypted: i=1; AJvYcCUSpnlQV5sgq5AHDWfnvC2jcYqedKJTqo4bUVCl8/3ZZ+5i3v/KSgV43IULbj9rJ0gwAoiWjRR0kZB/m18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeItaKqxnql9b2orL7TEb9sDakfnsMETtcgFFis9rP8HbtsZsg
	iszKBSkg+AqCtILyOyyBxdEc8Kn6GhukOGpvgnMsicrKrCDZcxeGritQ
X-Gm-Gg: ASbGnctwmG+mK+dcsL+Em6GKdXISUe4inzYlQblCU3W+svpfsWQI00VUHAGezBrO0zs
	d6HQu1lGsvEaFx9qYEHlcQ5W/mIswDqVKJccOCFY7BklWqA4oY2q9qPJ5m18dcNjCvoNHLRBSDB
	YF9ukc8Q8rfJBuy69mFzd6CdxCHsiWtm4DzPr7x5PuXq8XUlJwpiws1Z9LFpOTq7VdxMXg5h4nK
	V0+fBdz2sQ258h/qrtZZHqdlIHQ7BKFlnaGvqWupCeQyBamlh1BEpaOW+ZT3gnHSFywv+YDUZj7
	xnWs5ONhK4clHT175t5YUebetp+qkDXwP8qOtoLjKMpHtHRwwF6VPShUfZcaWzllctuhKOzudwo
	0eWbQZOK7b4FMuaAOOALTyrMlcA==
X-Google-Smtp-Source: AGHT+IFidFPKBI8cS+d+4gYHVAlOYg3Lgm1sKTkF6r8WI6UG693yE4O5MLuodha7xFNpnvYnc+AT1w==
X-Received: by 2002:a05:6402:4486:b0:627:e2d8:459 with SMTP id 4fb4d7f45d1cf-627e2d80936mr4573364a12.6.1757493437828;
        Wed, 10 Sep 2025 01:37:17 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:6669:35e7:fc93:9b1c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe99ffcbsm2844962a12.3.2025.09.10.01.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:37:17 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:37:14 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v16 10/10] net: dsa: tag_mtk: add comments about
 Airoha usage of this TAG
Message-ID: <20250910083714.gfrhsco3e2q7adxt@skbuf>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250910082017.hjlq3664xvg5qjub@skbuf>
 <68c1376d.050a0220.2085dc.675b@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c1376d.050a0220.2085dc.675b@mx.google.com>

On Wed, Sep 10, 2025 at 10:31:35AM +0200, Christian Marangi wrote:
> > I think it would be good to present the AN8855 tag using a different
> > string, so that libpcap knows it shouldn't decode these bits. The code
> > can be reused for now.
> >
> 
> Do you think I can implement 2 tagger in the same driver or do I need to
> make a library of this driver? Just asking what is the correct way to
> generalize it.

Look at the uses of the module_dsa_tag_drivers() macro.

