Return-Path: <linux-kernel+bounces-850371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12552BD2A45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A18384F0696
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967F304BB3;
	Mon, 13 Oct 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edJ2DNSy"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74B303A19
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352657; cv=none; b=sGSFH7CIZ8Vi86k9YGRBm6+w13tPvKsKoJzLvxyRPvb+BCuHYLry/u1LP1JTb4PDsFQAomHPI9lpccT0bNd9nkzLNHR/N7t+3FbVMyQ2lHBkKpEsuOt2MN/SbprOv1pPpvVN38DCiGzxlE3TNBMIgv0t9tgEHzZpkiWMCcVjJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352657; c=relaxed/simple;
	bh=wNP5THpXLBBCsooeBbFGaCM7Hjs85FFamh1ekejynLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLsVTx6rlWHXBWxF5tO/4hFKi4GsVJAVgm2aXh8nx3SWqrhmxF9LfNk/vTIAkBzrN4PZfI4VBxX+d0bdOQOWgpxQZ0Ruz8So1xZVhduHu+gNyuMzgEm+mtuSPqn2uRp08rykqUPd3fL150NS1EraHHR8KYhXOU/+G2oRlj0dSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edJ2DNSy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so8485534a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760352648; x=1760957448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywHY3N/RI9LLiDCgfHoL3E6H1b5BrPsw9rGztJzIzfc=;
        b=edJ2DNSya4n3LkBzMaSlhQLuNmQdeuRa6EsBik6tCyiqMkpkIO9+QC0uSwxcS6TT5l
         NhTmBm1t+TmFdBtG9jlk4ojBAPzpMewBQHXFOY4AJnJBMajkku1lsbiARphZIMiRBghv
         Kdi6NRC2mYNCG/VKsyavb0a9rNpc5VsKj0BS9KcDA5Ug9//zv8r6GHR4wnIT8GjSGjPL
         aGeAXx3gP74r3Zw/uV23sb9YYPQAT5LqbMbtPmvdZJhIefaWS9m4MG8lpvJL1BNOPoqa
         aZE7CY7ztdEc8FSBIFkePH1xuNO5tJ+aPt9LvsXpZ9YPwJRSuTOh+7c0XfSxY5cKcj29
         dGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352648; x=1760957448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywHY3N/RI9LLiDCgfHoL3E6H1b5BrPsw9rGztJzIzfc=;
        b=P5iuG4Nt7vdWEjKZp30WdN2xcKN4Zjabd6+AvU+P2QcEQ/XhLFIKKd5N05DHiZIP9w
         TPe8dp92nqVZXJa1825lE8YF4Kvmn+JswBMLysr+qgPPyQfwgmtH6+KRTh1HYhj5XW5U
         aXFlqC2Im386ekwVDTrDyxoZPLBUaUsMNA5AJH/Xa0KsRlT+PP4nx2kz5b4h/5DTccky
         nRoSUZAeXh0yEGJya0r1OctJv16XSlHd0KeNe2QXUI0TTvdBr2IbsWne2ZJdsm1nlK0D
         MzAW6MUGORjmeHVY+CWMsIXcbR5kSc1WaQZJm70cDVzqH14ripU4c+6Xcz4+K1lDNz4B
         IYqw==
X-Forwarded-Encrypted: i=1; AJvYcCWf5ezkxBpw9+D7V49c1qTeFMI9SSytPPU5M7zTT8ZvXMq0F1nU/bhEeMNXd5afC3WP4iu+1xRVvMmt/vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGe8naLeHDgNpu/d/v9POe5slrHytU6UXWpOaU5by1XCr2aNK
	mmSSSxVUXdhM9dNLO9QvU96UOIMqgN6n4T5wkGb/W/sO2W3vjKvHkCEx
X-Gm-Gg: ASbGncvkOLBQfl67MDhFG9gKyiiqdgHSqTx4ZfPaEdu0m+21bG/ns69rPXUsVc8GoSj
	6/0ZPXEjbuKtfunabvqFm17l3pD2TshysRqwqOhvtg0x/+svyZIDCT74RhX1hPby52I3p4dUd0F
	wUSwyJsDIvKr0SnHJq1rm3XLQJ/EVJzN5Rh2o8Q/NRgmKlOeJeqkDIsDlDZ1HKsusqRvvis69Ap
	apIzlHdOxgmE5MNTS4kwcRPIYlU0l6kz91P1DSqYXAQHr8K2kTPg3mlMiT9eQtQ/v/RFO751Puy
	OKvCAkG0momncZL46v+vLcwd9MlD7dNh6Wys9MgaXUTyyMXwWVy4llJysgO63y2JoD7ACBt5OBj
	bRXgxGKM9+fw96z8NRsoNdlOVHUI+yJz0xeJcI863PDZnvKrclRlBHmyk4URpmItz
X-Google-Smtp-Source: AGHT+IEr2IkhLy3Hq74fdNOtudRrfh+iuu7rWrRfFvpPJo3KF6R4emQcUvwa9LHRg8/IJ9TOsz5Fig==
X-Received: by 2002:a05:6402:144b:b0:63a:38e:1dd5 with SMTP id 4fb4d7f45d1cf-63a038e4b6fmr12861262a12.7.1760352647388;
        Mon, 13 Oct 2025 03:50:47 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63b616d12fesm8024557a12.24.2025.10.13.03.50.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Oct 2025 03:50:47 -0700 (PDT)
Date: Mon, 13 Oct 2025 12:50:43 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Petko Manolov <petkan@nucleusys.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: rtl8150: Fix frame padding
Message-ID: <20251013125043.0ae574e7.michal.pecio@gmail.com>
In-Reply-To: <aOzNH0OQZYJYS1IT@horms.kernel.org>
References: <20251012220042.4ca776b1.michal.pecio@gmail.com>
	<aOzNH0OQZYJYS1IT@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 10:57:51 +0100, Simon Horman wrote:
> Hi Michal,
> 
> I think this should also increment a dropped counter.
> As this driver already uses dev->netdev->stats [*]
> I think that would be:
> 
> 		dev->netdev->stats.tx_dropped++;
>
> [*] I specifically mention this, for the record because,
>     new users are discouraged. But this driver is an existing user
>     so I think we are ok.

Thanks, makes sense, will do.

I will only drop "dev->" because it's superfluous - we already have
'netdev' here, which was used to obtain 'dev' in the first place.

