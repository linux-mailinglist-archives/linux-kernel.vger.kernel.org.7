Return-Path: <linux-kernel+bounces-730512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90CB045B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC7C1A66892
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9180D262FC3;
	Mon, 14 Jul 2025 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqnAw7ON"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C325DCE9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511345; cv=none; b=Cr2dmLXvge6NMdkAD2XbSwFVbcRFaCLmhGafNwzDWitgWTEVFrKOzgX1sSXLwsHEVUJXue5xjV/5k+8a+FIRi717hXqyL6PLhErYDfkSfkVDsKZ8AFHqe51/GSUGbg2T1daSFpQpH7htXGVhnc1gcAfMK1O5/wc4QGFbTMCnygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511345; c=relaxed/simple;
	bh=CBiOWgTbH6mBxN5Ueovjxh8H9DeHQsuCNdyto7bQGqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ge81kIIq+IsfkuGrLMrX/BalwYu1gfKAoSJoNISJPaFftvMIo2lAvWGPKvs43qPh0fm9U6TpKWX4PUdNI7HYKA7L8V+fErPKtX87Ok2UNc7bPSoBx2DSMjv2MoU+2uyLTp9hAykS7pmbDTFC4YTylK3hzseEJHoDLL9RyssPMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqnAw7ON; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313a001d781so3558263a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511343; x=1753116143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBiOWgTbH6mBxN5Ueovjxh8H9DeHQsuCNdyto7bQGqs=;
        b=RqnAw7ON8BvQm9W4FOcyb2dvCXYsYTpGkdtsE9tcr+95kQtefvTCjuw7Z43mfmZDtU
         2xK98hj1Xtby1Y8FkR/8mPse/D5JTzYKxBb+/rA+ZPB1HAs4rJdyU30LrM3QwAM4oqWV
         x5GjLG2ZaiGk4eTiDpA6PbbOSfsdnN+RXgWD7jRiGATC5OjvOa/mYp9CPItQskh278cz
         OmVgaAuWEEHfcJ26Oun0fsZoSCUCE8YEnj6foj8E+U9VMaqZgAvu7B4p3C0Vv3D+WAZK
         QsK7USkPzba1cXzqB/yKzhOJrab6hSJzevpCOQmWGCwOgQmrwku8PBChH6rdTbXCAh+i
         vC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511343; x=1753116143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBiOWgTbH6mBxN5Ueovjxh8H9DeHQsuCNdyto7bQGqs=;
        b=YGzC8mdOotUvX41kuzMkwkl8uAXyYv1OkcHxhPYLzZEF1pC88+qqX7dbRethnEDTxT
         qeXR57UL4YGsQ9z9M91K1bPPhBV39UNMODq1Z//Z42CSBXFTVtuEc5+Nl/yrwiHNLNs3
         0S7ZEOsg1ZpgSz4RG7GNUIIwcd0I7fE3oj85ruqDFnz5Ai3nEqXNsJAVir/QliqYdvJ6
         eloHe0ueKAFYYBLwQVBa31Ocxj+Hjoau/zL70J4zjgSfQoajj0pZtV9Tup00FOxdR3Eh
         yDu5dWzAmkD/TJpOiGnA75MCoys0i71kuhVSzpzmYN8REvb07gapcs3fAvioo4VX1fVB
         5DXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSMtAQPkb2loPybEVWjzVrG+RK8TcCvBaqE+QUSr92hbx+bmMfYkWCos1m3gQJlbzcWK4nwpco7G10tZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj2dTURVX65JQDEgx347kY0Sx8dRARzIi6+c6sfx7ZD6RGJXe2
	J4Pm6hwpI1VmaZQKuCt6IcGkC1V/GLrbEIm3WIVFH6xLd42DcU8UiX3VGt7ylKSlT4um3Q9i3AW
	yh+PZTqft43yfSIyIdjwBNnSrf/cxOaOpMofH2FAi
X-Gm-Gg: ASbGnctcJfHvVlZkvQ9KfwsNxBRPcHH3GtmoYtL0isE1qwDEI7biDEM8HgR/Qxzq5zj
	MF2D0e07BD4ygF5ySAAclt4ra0jzAACC+yAPyCrW/QE4WKtMnHReQEFj/BhD4obbsWQ7imIRPhp
	cqxKowwrH67qdCA4cK0w+jOLNy6C4tyZm2fKcwBQWRK2+ysbbAkNNVrW9a7/koiKxdWmIQsSEx4
	K1Iy3jW65YUdB3vp4uDIbFhHoh6fqEYI0pnJA==
X-Google-Smtp-Source: AGHT+IHetMliiiiDydhmaCxsBQrgccYD+etGrXdLocRuZAremfRO01jz/DZULhdQUdpZs9OByqjF6ydOGiy58cu/VYs=
X-Received: by 2002:a17:90b:3b90:b0:311:b0ec:1360 with SMTP id
 98e67ed59e1d1-31c4ccf4bc1mr19820630a91.29.1752511342873; Mon, 14 Jul 2025
 09:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714081949.3109947-1-yuehaibing@huawei.com>
In-Reply-To: <20250714081949.3109947-1-yuehaibing@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Jul 2025 09:42:11 -0700
X-Gm-Features: Ac12FXy6QarP7_7bnDBMPeBZuzZfs7pD0MO4S9tO1DtMXZCd9Z_2kaicajsPMoc
Message-ID: <CAAVpQUAPbj6=HoGtpJhO4SEnzBXis38DWpFOtz55iHpuYV4Tgw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: mcast: Avoid a duplicate pointer check
 in mld_del_delrec()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus.Elfring@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 1:00=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> Avoid duplicate non-null pointer check for pmc in mld_del_delrec().
> No functional changes.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

