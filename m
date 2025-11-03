Return-Path: <linux-kernel+bounces-883428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75741C2D738
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8793A9F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D38431AF1B;
	Mon,  3 Nov 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvSfT8sc"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059D262FC0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190171; cv=none; b=sFuVWS3aAX2ml++NTJ5JQgRTO35e7uu/c6eRFoFcbTWAA2AGIonv8LV356//NP1oKyijNgV9go9ix0TTypKJvkETRficYrN9tKKL/XMxqsxrpN0/QbWoXfPNdrtph3wPlDffkHo2I1XQxGXvitf4wabL7ZuyDXhxXVKmxfptey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190171; c=relaxed/simple;
	bh=CZhRW1OtncLOKi77Ip0eUDc07arJUEfivIBjA8Kpxqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLeMMykdjfafxB8+yWLpIlG27YMOHl0FrDXSNOsH0BZqvdVCf0jhDOu2DDR95Pz4I4L4BT8gs7RPAhOoz3BoZc++DLcgQoNGARijwCB/iFpb3seoeNVjOIWc4rhmvsOHJ29DitbhttGW4+dVE50zZK/vtXaWqWa9TQR60oOa8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvSfT8sc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso4029797a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762190169; x=1762794969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5w8/5aXJBu3c8RZQSRI5iG88GN8IHwSdkSWP29JLkM=;
        b=KvSfT8scs9b41mXpQIPh5Q+7QLeyoD8tuoGq/VnMHmWNjHjWpkvOKcyfR+purc0ZeQ
         /N9M2hKeGDVwsvaN+8MdP4gpOY/CzleTz/jzTlKd7dO42bmbdUx8JDNg/ZvIQDYX2Qqa
         TmSisOTxDnjCyQ9Qal4OsPCBUSP06AC8PkPbK/ZeFpy5PT9M7ICCUvCR1rFGjMU7mS09
         SzRJY6VaoMCT+PkG9xM6ao+yFWBDHqjVoFp3YBJzMt9bw88/CKnA2AE9H+KBpufoT+pB
         vVL3Dls7zS6gnnMl0TlQE6boM8XM33dOK5x1IVq30Au/eZSKJt/VrFnaS/0B6t9N2Owi
         ZP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190169; x=1762794969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5w8/5aXJBu3c8RZQSRI5iG88GN8IHwSdkSWP29JLkM=;
        b=wqkGYdbjkbjac3gx+x8yVHdSGKPRdAcBNR7d6hW98gdW53kFIRlNcl+8ldhLS+isUa
         Xt1m8RbKFQ+5GgrapyvpWMgeGBq7CeBRtJbbqIn/XoR2J5I5I4k/L4CA86ajPllAm4B+
         /NImtqCpP3nxR2TeG8Sms8x9HYaCdaiQla9H51lc4g2OkyyvfiS0Sx32SjjWI/IWKcFD
         2YB9neGqWNmH+NdeE3/Yh74zGHrfIz1yNuWxHempbduB5JJohiYReeCUbvZeG6U7iu8M
         FtlGi8tGBYN3GhT2UjsRUaQo+vK/frMeikySLgPrL7KIAQgQWpKkI4FkGQW+47EaVByX
         K/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCX/9syCSZoQMrM1QiyzgYPPkDM+7sei57IpHSlEPt51mM8L88iFvwco+bgsOJ8xpDZ9nHq44gzSTt0TwhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2wIYhaD3lmY+JrU+pA6zUsPdXr7ymT35To04zMl0zW/m/iJJ
	ugxg7I0ozh5yQXf69j1BQwCGZxCK+ynGC612i4P4aj3IA1QL8Lg5ssU=
X-Gm-Gg: ASbGncvJdf34x/mLlFodv5Am+HQa0PhW9YWWcmDOzSPMKzW4AAMyIYqdxEogNNH/wOB
	8aD1886XnmISX28PaUY9evsD2oGkjnGXeB2ltun0qNiJrCAUzFo5rE1wyREgeYi8r+4cYhj89FR
	n4amyTh5zJpVmFOybrs5DBM7Be/MO1H1MpF20IVIXKX6B8XiVkVmKWA6Mrxwuo5wok4zWN0GZuZ
	WAdMAqLxN2aEDlCTgAVuB2kUsAUReBcgHKzzfyIYFbgSFOmgfN8IGsP0w0bolqSnr7KY8da4UIb
	KdLyeK2uJC0Q8Dy67dtMu1nxDlsSNso5IzaNPxr1OkiQ4UXq8glplXTv8IgpfOBXvEQ2ruyxC1D
	n2M68ATVwuYvLt6CXYAdVlgA6F+my5TFCuW0spujbbWedh6zkeztTMi82EX2xe5SX1a5KCvkFph
	Irx3l1YR7uX7rz5VNJevcFH9YNwROfv8ZmitaEEUDSFdBePmJBZyehMmxta5iCh9PdLWFa/RAyF
	oETdSneNoQgW8JE8FFPFVWx0E52B+Rl0QOB/U7eoWqiSPsoPIUU0sNL
X-Google-Smtp-Source: AGHT+IHY7TcOt9oDyCDH7yJ86R5xdknkCp9ed+4VPxM95DjgwFbWMaQFjAeRQk1RbwJdO4XHu24eew==
X-Received: by 2002:a17:90b:3d91:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-340d578f668mr9318338a91.6.1762190168784;
        Mon, 03 Nov 2025 09:16:08 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c7a21a3sm1584495a91.17.2025.11.03.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:16:08 -0800 (PST)
Date: Mon, 3 Nov 2025 09:16:07 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: Remove unused declaration
 net_devmem_bind_tx_release()
Message-ID: <aQjjV38DLcaLw4tj@mini-arch>
References: <20251103072046.1670574-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103072046.1670574-1-yuehaibing@huawei.com>

On 11/03, Yue Haibing wrote:
> Commit bd61848900bf ("net: devmem: Implement TX path") declared this
> but never implemented it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Looks good, net_devmem_bind_tx_release was never used/implemented.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

