Return-Path: <linux-kernel+bounces-822100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE64B8306B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE53662130B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392692BE7DB;
	Thu, 18 Sep 2025 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxAooJFS"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B592BF3F3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758173972; cv=none; b=h2GinrGHDJP+o7nRDkxcXcFavPceC10fe0z5XAwhxYfTW5+T8DdWpnDqxFOakLwyfvlM/pLIv/IWzQSxiq0nAbKWcUyaBkwZAgsp8AVRB+Lg3SOuJphTQ/6jo8Sdo6hrfvPIySl8Fzk9leAVsUE7txiHO3XZxDiLh6km0sf3HfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758173972; c=relaxed/simple;
	bh=SaZFIVOdd7T13NXyX4efJUKeQRYQgGhTx3tG1HJaIQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a61p6WMYT4L0bSGNuyjUuYSkfDMIHh9XujgMnR4PN9TT9UqEmYxQ8Seyi3J3ApLtvkw63PI9WWBlAyMMh3XJKTZsKtXrP6uwZh5WYHJCZ7AOC3s/ixCDFW6Dadl8EpmPqmDanCvsIT69fOBIGcnVfcyxnnMhHoTtajuftQvx3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxAooJFS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso431024a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758173970; x=1758778770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XoyqBQApAmmnvu4zkoApx4U/8ormdVXAKsPBgbJPU3k=;
        b=HxAooJFSifNaIZ7NuxlJxEjtHTqWCE+dKl+xuMb30iNwdM3eJbozKquQEWSKDB96EY
         qmffl0NL/w+cIB5hGyQrGxNoOwp2daQXjoEleHZ9DXi5DU8uvykBLdJ1/pjwdbrAl0Lb
         Cy0d7zNgBMI/JizBVFnM3XfUfi9fWlU+XT98+0+ET6cIGuBiE2XMINPcllvbmIUJgEfA
         ndejEnkn3NHDDysou4ov85ufesFJJTgj7NM927idZAGSebuk4KLxdPs4payENDiah5Sg
         flnjxrDOQDLqngm5oA26jSOuo5Z0RuPywbU6SraqWOdr5GDXXmTIIAPBkX+EKxY9CSof
         /eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758173970; x=1758778770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoyqBQApAmmnvu4zkoApx4U/8ormdVXAKsPBgbJPU3k=;
        b=eFSEaioo4FAywnOfcaz3FecxhpMJdAkBBsQUyZ76GZHqoPN3mVvOP2BMIO6MRFpuzR
         Mw5sjZl/l2wg4qBRv/0C1qeWMwUaXvckFXCw/AvnvXkYp/CyOURfbxGEieCPY2iRHnRy
         3SsyTdSP3V1mPAc0B+opvIE+VjQyxa5UF7exYdXQlH0CRST7oA4qPQxD/jO82epjucDd
         GFJ9VcAU4CcgmIqcMXp/vWNtL2vIDxt6gGl4GSrjd3bu9lajjIPKMaZLpj3GjidTYabJ
         HEPPTSUfqm94eqCo0Rx8RNP+jWiXu0GufW1kv9tVyEySr9xCbtqX4ABFjxa5TGcM1SZa
         LnMQ==
X-Gm-Message-State: AOJu0YwuVYq0N68pOvyYvbv0RtLQtvaufaQLmy46Zht7NfYs9WJrqIAW
	o1MA3WrqWSTcdE8xhSit4VqKqwAOd3ZOebLa0lsYYcJpTeOF83C2SUOe
X-Gm-Gg: ASbGncsN4shr0I4JNsHGaroMyCMXux8zkTyhLVkJaKXeA6MvQhrrLFt+BA+78HCfsdl
	2mx/IubL0WuxEFkYqaDgiqC2oz/agy3j2Z2POZ3Mq/1CnMG5IRpiJCxVeM+eeqQ2RjQbF3abg1F
	/awDBgYSxPK5HlKQX1n8T91MhvBH4mh7iRXJcqI3cQadyU+Ix6cJlmTn0+Z18GumyrsUQUIHTZ/
	b9sUCevB2YMEmjT8Bs3jFvksJBNr4Vl6rCn/h7OvuecnUekbMAkp8juoaL753Ba6wk4qbuTUEqz
	gNPotG5Xl6bomHBNVhbBRgx4egDkJUa6xSWByq3tYwPUK7+iUFy0OnFm+jsUSbrgQ2e0ug7el/b
	339ugqN9cdcdB3zvVluxYr6NcitWSurDENEoGqs3Pyw==
X-Google-Smtp-Source: AGHT+IGxd0JzuVVJrw68h5tXFHmcZpcwVF2x8DkVRvbM3jhAsZwEYZxEhWmJuR/xbYRB7Jc2BkkC4w==
X-Received: by 2002:a17:90b:3b49:b0:32b:8b8d:c2c6 with SMTP id 98e67ed59e1d1-32ee3f008ddmr5384286a91.14.1758173970420;
        Wed, 17 Sep 2025 22:39:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:194b:8358:5c91:3d3d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3db38sm1130199b3a.73.2025.09.17.22.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:39:29 -0700 (PDT)
Date: Wed, 17 Sep 2025 22:39:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Frank Li <Frank.Li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 1/6] Input: imx6ul_tsc - fix typo in register name
Message-ID: <z2kbkmqnvux2ys2mdghfbdwts5je4zkmmk3ctjaisno3kafqoh@xynqe4exjqzm>
References: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
 <20250917080534.1772202-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917080534.1772202-2-dario.binacchi@amarulasolutions.com>

On Wed, Sep 17, 2025 at 10:05:06AM +0200, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Replace 'SETING' with 'SETTING'.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 

Applied, thank you.

-- 
Dmitry

