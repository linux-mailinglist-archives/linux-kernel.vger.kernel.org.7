Return-Path: <linux-kernel+bounces-847023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8659BC9ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7F9B4F654E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B12EC098;
	Thu,  9 Oct 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAH4+PGM"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670C2E8DF0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022192; cv=none; b=Pn86fh0q7TdB/3kE2d0UGPw2ev/S7Ftfokh8uusHtvmvhHEtuUSpftCydu+GDfeZBTiXfbc+n2XD2e4tC2vMhOMtyz2q4OgEmvGWe9PicY3gZVTnR01ELGQjr0ckD7GdLh9Nuyizmx8bmrXjzPZCkolcLEicmGkn+xB/6wGT2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022192; c=relaxed/simple;
	bh=4BYiBUJA2xuVMrn0owdsZSPlnr1Hd4TIlmp7Db9dIiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EF0LfZbERhgJV5kgliZd91eYg+J83PWRBzvaYnJ2s6okxuHA17eF3M0WIKyvieurzwo+PSkBpjHsECnqYyWIL7nuQbDjdBu3Y+6MNZZVKrOZ2NMMpSP1bJatyPnRjYOqCMAcQO6OPxLB9Km/gumCnrC9MUa4Bb+Bzrs1VugTIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAH4+PGM; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-43f88d33872so534342b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760022190; x=1760626990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BYiBUJA2xuVMrn0owdsZSPlnr1Hd4TIlmp7Db9dIiY=;
        b=gAH4+PGMXGHwPF8DW+4WJFvtMtAZG+jIB4M4B2XGl5BjLtPtNJm9J6E7kqk7CbVhI7
         NbOvmYiq04evywZOkG2aJNvG69+01NVlkljxMSQ6QDK6eprrv8GQEqRB2uHTLZOgWVl6
         Z2lrNLiu7EBsn/KpWGD/BciGooYBrCG6CyqoK1d/p5n6jE4XtdnmU6Nt6J/vwezMCtHT
         dpVrBhJQH2jBERwXM7gjkOpfVSbiChLwn3sjqG05MWrpAPYSQURC96fgZLeTDLNjtqg6
         tA/TcRU90cxB7ppBMA3xvtSxsov2mB00YfpBPCig1JVHtgqFba/WCK2sN9tY6LEyvrjI
         UlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760022190; x=1760626990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BYiBUJA2xuVMrn0owdsZSPlnr1Hd4TIlmp7Db9dIiY=;
        b=AkH6rWhMkzhZKHyhgJZULdzvgfezWGnqSXk9U6J412z5sZO3CD8jSOZPTWKIcWVxol
         0OmOgk+URiGeIlGJ+oZs/Wi8dOonBgwZj+jEEY8tM0t4u7PCnL7Lw7l7bYUiPJadWJGn
         Lc7NbBPd42eQkhc1TFfCZF+hmm0KHzn9eFCC9zMLsHTR5pm/bR7oMwh7NO0Lsc//xnQg
         17lKY3ovSsatRMEKtwOnhV1WA5zX2vV3glf5Y3Kt70k855AYTQvBs+QkU2mTiK3qGWSp
         gKpN8XAs0hpw+Vx52NFJoQGK4215SLHnVMAuLs27yMhm2lOh5z2OAZCb0guV7U7HcJ8/
         abrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrCxHQWmdvP3Uaej7nH8Z5TORSwYm6KOdLO/ldYMxqsSFD+9CheOIcBXEGOQH3TxxYay1DXDERltO1xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ujAY/3SCWHsSmbvgvOeyGwqXyDSGHRIKBYFmkKOg1YUtsUpc
	pCU04LE8MQBQMjHk28l2Flf4G4wBvS5bbOdCd9a3LrendAqtnbpFD/EKjTRs8pzQNHLu7bFl8rY
	UmEGoZMB2T8s45rpctznhU/QPCa1KG+8=
X-Gm-Gg: ASbGncvIZQC5r4tN/iMa1vsKP36/1wzXcikSuM0xMoVMZ7bU/XOyFkUFHDclqJLp8bT
	N59FrbrkO62M/HCFMkEvxjcS6jkQVxsuZVJ4mJRvaATu/zwZ1pIEx17F7YpJqJmhV2FRCmDfU1m
	T6mFjHa8gdL2uDsWG2q1mnNbfjB+V9gGXqYyJxjMrbTcWG0ykABFfteYuLtO14Cy9uQaZjQ+HDJ
	tKVAKuQucInL34zddsXYYjep1GW0KFwpy2sDoCodg==
X-Google-Smtp-Source: AGHT+IFE+53ZwFZzygjApNRRk5IEXCWznQkiRJ3RFYsMZB+Snff4Qd2QBaS8PE2SAmylXqZYXSTkseD3wSbRcGsymC8=
X-Received: by 2002:a05:6808:1a08:b0:43f:57cb:7fa0 with SMTP id
 5614622812f47-4417b3e74dbmr3269515b6e.46.1760022189283; Thu, 09 Oct 2025
 08:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008205207.1781-1-briansune@gmail.com> <aOd9yUj9H4L4fbtc@opensource.cirrus.com>
In-Reply-To: <aOd9yUj9H4L4fbtc@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 23:02:57 +0800
X-Gm-Features: AS18NWDmwyXy1cfw3926lFmS_Pq4UdpsOBDp743TG8q62eoh-RX9vdnszMNCTZc
Message-ID: <CAN7C2SBd8tDXG8OkjRt0sDw1OmtrLgtuStEfr=f=JHZMRvjq9w@mail.gmail.com>
Subject: Re: [PATCH v6] ASoC: wm8978: add missing BCLK divider setup
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:18=E5=AF=AB=E9=81=
=93=EF=BC=9A

> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Thanks,
> Charles

Any documentations are required?
i.e. .rst file or similar?

Brian

