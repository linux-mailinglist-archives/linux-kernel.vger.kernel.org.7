Return-Path: <linux-kernel+bounces-830840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C98CEB9AAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4537AC52E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E830FF10;
	Wed, 24 Sep 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrVbhAZj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83C8C11
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728033; cv=none; b=EJVahsk1xwRsWTVTBOLeE69R+XKKzxniYb3m3r/DgKn5uJ8vheROdebXMar0q0+DjenyrQa3RIaEaRbO3U9PBa/u10+UYBS6ezeTWUSjMQ2AhbwFwizjNitkOIsSBVYtqaYIbLBKoEYJBwCrFxvt9cZWufM5jlncQ9OCNxta/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728033; c=relaxed/simple;
	bh=wRch98PTr07OsPbOEWFR6ZR70W6lFXly25dnPdzBGHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn8pbvA9z3iu6JC3/VeNR39PARtAoXeWjEgU23g2lALwO1wY/+VSNI3IjRvW1GQYcku8InbP/K1iK0kVOQ5hjehEPL8xYaGFpFmoB5vPibrpwvksML61FfAoDq8vuzkXXMm/G3oC7pCThYQnnie186dggxvscJdFGIzcM/2I9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrVbhAZj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758728030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ic7zvcyBVtaZcEmsf3hW05wAfmOMNZ5JL2VpkYQoXsc=;
	b=FrVbhAZjnj+3afecM9iyrE8dm4m7eM3bO9kNMWMYSajELoQ3LWp+5t/KXwf0DRetEtgIYJ
	9tvyr63oCjkhBxIpB7FEQtNngbjeciwlUJtVZXsW0/6ERUDfM5c3Mh7rIcDIR9VY98+h3q
	XauT2v1//eTopNsr1NuRTAn9tnroQxk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-S01iI5OnPhaUToRvpcGc6w-1; Wed, 24 Sep 2025 11:33:48 -0400
X-MC-Unique: S01iI5OnPhaUToRvpcGc6w-1
X-Mimecast-MFC-AGG-ID: S01iI5OnPhaUToRvpcGc6w_1758728028
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-81ea2cb6f13so4961685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758728028; x=1759332828;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic7zvcyBVtaZcEmsf3hW05wAfmOMNZ5JL2VpkYQoXsc=;
        b=Dt6iyK/gDKGDmOxlwPpDRjY5JXC/mUvkQm4/UZbchQbSRp8ZkVskYmork/aAbaAhMG
         U9p6Tly0mjChB0v0aUdaSpxIGmEZebnaP8YiixBuB+lu7YRTXfKhxmdglD0HBoDdatf/
         6tjzHySU571KZ5X0Og4EV9EAa0Q/XmQKjcUreKbagEYIjcVQCk57M90TKMkpMoO/sv6T
         TOuOUvflNtzD3sbqNrCABGYzN4+ilWab1bQD4a6W6MQYD0xnjRhhWuriuRJVvfFFXNtt
         RcolfrwxAY1fsRg+zPlvuC1R/oaXzyKCVea7EV3qP9YZWHMN1W7M76do0ciVVoDLxYVS
         lCEw==
X-Forwarded-Encrypted: i=1; AJvYcCWmFrP50hTqUFy+2m5L1Px2vjdmRhYfoSbvbq4auJ8Sq0JHIymA5MOAS0z5/cT0XR6EJ2J/8QcPn77hQL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkMDFOSgHRtWaLVano8iDGO458rt9PijCfkjSnCF4KjFKyOWV
	MUV5lO3VtrCGlUYylldh+aifXIKeqivgQyNnu0M6VEAgbTJpFDg/2Qa0mOOAeAatojHrSuMZ3qF
	ExwNii4wbXGL3PZx3tdBhdGaCihk8COgqnPSim0zmtKv9QnEPhPFFgdqAzZrJ/8mUwA==
X-Gm-Gg: ASbGnctf956zkNAHjphFJIjOvAco4pms+fkEIMjwz8zG936rT1fOhkDpORYesz57mfb
	u6IKiKcbjuM9F5gakbA4gEcWskYQcb1X4Kob/Kajl63+QPqQL2KGxU0fF9MTwXGCo04QpipcELq
	cGKpZ7udntPx8vIlChYHYW4QFNwENZ/LLwaJvYoNp3njTgOYyy9HlzzrH87J/6dtc3X+R4Ksfvx
	NTGY4UIyTk51aJaO8bSyVS3VIYTbPmBrUAu5368VLcvW9AGrqOUtHy6++ytPSDNZvUaETR5zypJ
	YNWUEu/+2f7Hbm/jiq9Uqh9P/c9TnPqqE5YGNDfHdH9zYH/YzrZq/Gbgj+RHxP5A3szr4g==
X-Received: by 2002:a05:620a:1a89:b0:828:1529:d028 with SMTP id af79cd13be357-85ae7cd4ac1mr7326885a.61.1758728028087;
        Wed, 24 Sep 2025 08:33:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7m0/cbnvCoTKElfyKlC9Akk8QQ848roxwkCAlIQudXokrBobnZdaunrFKeYAlTGXQPxdHhg==
X-Received: by 2002:a05:620a:1a89:b0:828:1529:d028 with SMTP id af79cd13be357-85ae7cd4ac1mr7322385a.61.1758728027583;
        Wed, 24 Sep 2025 08:33:47 -0700 (PDT)
Received: from redhat.com ([2600:382:8504:5608:ca95:838:d4f0:316f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363198b0fbsm1167921585a.50.2025.09.24.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:33:46 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:33:44 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] clk: Support spread spectrum and use it in
 clk-scmi
Message-ID: <aNQPWO6pfA_3mmxf@redhat.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <PAXPR04MB8459265997E9822F17AD2BC0881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459265997E9822F17AD2BC0881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Wed, Sep 24, 2025 at 02:44:21PM +0000, Peng Fan wrote:
> Hi Stephen,
> 
> > Subject: [PATCH v4 0/5] clk: Support spread spectrum and use it in clk-
> > scmi
> 
> Since clk-scmi.c for spread spectrum support needs some big changes,
> we may need to change scmi framework to make OEM extension
> in an elegant way. This will needs some time.
> 
> To patch 1-4, do you think is it ok to be in linux tree without patch 5?
> If yes, I will post V5 soon with your comments in patch 2 addressed.
> Otherwise I have to carry patch 1-4 in future clk-scmi patches.

This adds a new API, and there wouldn't be any users of it at this
point. Personally, I think it should probably wait and be merged as
one series. Unless there's another vendor that's ready to use this.

Brian


