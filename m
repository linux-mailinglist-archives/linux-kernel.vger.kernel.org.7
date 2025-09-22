Return-Path: <linux-kernel+bounces-826831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865A4B8F730
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7C23ABA70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78642ED164;
	Mon, 22 Sep 2025 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TykEoA+T"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58F27A93D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528979; cv=none; b=lacot9jZtranZPpW4dpEerSd+OVKcIICb/PdJLnXeSDMbnLuyswZeLhDoK+32TdKipddmGYcB6fh5uD67TtuV0bGIfnWMkyOKdw96MagJuKCMEAGOayKKu4GwKfjMFYwrutOflwvK4KBXPbCiQsE9AdV8ETRI7EPr8eb47I8pHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528979; c=relaxed/simple;
	bh=UMJWZiC7sBj6mxojXhTJC+tuD8oKXX6T1jbAHxgYnJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIp6rAHc2eGkJCHXrSySZ/XXX/tAVzETxrxaFBVLVV4JTN9eHmGui8BBengTMKckyw1KKqa97TNgtJOQEMDMQL0T5sTQHRYiIR9v4UK8CS83DvTDdCCI6iUx8JxD/v7zRWNd9N85TvmRQP1Yr6SoMC/tSP0Yn8eT1jXJ5JB1PT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TykEoA+T; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so1018212e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758528975; x=1759133775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5VEvi4x8chbxAda+lSO8rMAf/beZcw/I4cFoExnq3E=;
        b=TykEoA+T2QQDbvhjRHvga/ygUfeJuvwoaRYSR0tBITiSAPBRZCQnO2j8b79UDqd8qR
         6ithQFSgVi544ea4Tace/Ryxtk9Li2oEzQQbPV/ASNj/k7+CwxzYMzPWmWefzU8vOC+5
         YhAdSYPjXlQHSiBHMOAb2h67mO0C5j5ayJBJ99NZdm/xY97XnAW2gLGfgmRUyzCL1qFw
         5RUTihSJUdrxkGmeeuaXKH+AM5VgffaDuQ1Td9yX/ktGPjznBCLC9Qb2IiF3mDJzKvfY
         0/bsXE5Eff+NoKDfpmPEMvXzCMQe03OrAz4TGbkJnaRFE8EHnUQoc/en8ywH8PmC7+6R
         C/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758528975; x=1759133775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5VEvi4x8chbxAda+lSO8rMAf/beZcw/I4cFoExnq3E=;
        b=OanxUFwCh3vsyqF3plz7aJB4dQHfA5DoSWQCWUQrRhPOiKzIb1qrr1XL/IlK8SFOso
         htQh4K1KnBh0pmx4bzr1jbWI4rxq8T9kAsXoa9XkRhf7qp0U8GQML21hXOPg6GdZ/9IJ
         Ax6boKCG1INGVUKji4oQIeQ+vnMwefUkmpWY8AeOS50h/izZyqLKQw30vXVey/6U25wt
         pBeJh1c04DD1twCC3R7MPwvnfgJaV3CWyUGJ1v4iGGCIYuzcjpP+2/S2W5V+tVsq/jH7
         wepB7E3gq3vYfumKzpC2/q0YDazjB0CAX643TpxcFjCtgvKytQKfAX7GyTYcNu0nQTjk
         ifNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuzpYvUJeAbYBZPbixOEM4quJrlJtoVvlOZERuoM3D0IJOjPtmy4mMaeAWC5PaYsU1QjVOksblkuJQDFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBe5j6qa2lvB/OTEaoJTY5Tu267gOblfAvo/mMwrxfPLlBhha
	I0HFKaexcqxUDry8/5L+erruH/ojQrvFiS+rPSNAXbQCtf29ZiR8ggsM6ahX5Q==
X-Gm-Gg: ASbGnctHY5R9Uhd7C4S3xZwOsN+uyL+MAMfAJw9nBF7wWMfZIa6fkrgQLg0v7bdFtox
	96v71FApwW8/j8Zgh2zDYa+pleoulET5WiglWxoHy+Za6kkZPxaPqwbPMHphlq8FzzCxbLLfjDb
	P4JGH7V3S1xjvsEeGsPaSTYAw/gd/aXGWBUhI/i8n4I53Kwwmx36q03pD8ZU/3upN+JWTXGIita
	noJiPF+JRhgb8pqfh01vogLSkCho3iKzNZiPG5hw8Cv65Q+hg7npRrubm1sqcF4aIF2yEF3i3/G
	zqcE7Ehbhokl+s1BfIgWBsJ52pkcuIKAMTknzSpYNx7EkM8Mh+UZnHZ6AIw/pl2lGCPHejDsV4O
	4My96tEmgr2+MB1KrnEL+hVsMkJwsoDyRxTY=
X-Google-Smtp-Source: AGHT+IEBnciOJYeoELu8rLKOpYmJe14ZWR4sLAktR1bK9CrTwUMc1Hawjx43GGZQU5SZBI4fWanYFg==
X-Received: by 2002:a05:6512:4041:b0:55f:4fac:3f2b with SMTP id 2adb3069b0e04-579dfccb059mr3293297e87.5.1758528975194;
        Mon, 22 Sep 2025 01:16:15 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e37d09511sm868935e87.88.2025.09.22.01.16.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 Sep 2025 01:16:14 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:16:10 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] usb: xhci: Queue URB_ZERO_PACKET as one TD
Message-ID: <20250922101610.0102e1a1.michal.pecio@gmail.com>
In-Reply-To: <e29fa12b-55e4-4ab1-b623-11feb447bdf7@linux.intel.com>
References: <20250908130128.7ed81912.michal.pecio@gmail.com>
	<6ca18b05-80d4-4988-bb08-3cad003e10f4@linux.intel.com>
	<20250909193859.73127f85.michal.pecio@gmail.com>
	<e29fa12b-55e4-4ab1-b623-11feb447bdf7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 01:57:39 +0300, Mathias Nyman wrote:
> On 9.9.2025 20.38, Michal Pecio wrote:
> > But this is not what this patch is about - the trick is to use an
> > *unchained* TRB, which is a separate TD from HW's perspective, and
> > to count it as part of the same TD from the driver's perspective.  
> 
> Ok, I see.
> The whole TD without completion flag does worry me a bit.
> 
> We need to make sure stop/stald mid TD cases work, and  urb length is
> set correctly.

I came up with a potential problem case for clearing IOC:

1. all data of the first TD are sent out sucessfully
2. no completion is generated because no IOC
3. ring stops before advancing to the zero-length TD
4. we only get FSE (Stopped - Length Invalid)

See xHCI 4.6.9:
     Table 4-2: Stop Endpoint Command TRB Handling
       2nd row: Stopped on TD boundary

Current event handler doesn't expect this to happen and actual length
will be reported incorrectly. This would be easy to fix.

But there is also the 0.96 spec where FSE was optional (xHCI G.2), so
on some HCs (like NEC uPD720200) we won't get any event whatsoever and
the almost fully completed URB will seem to have transferred no data.

(This assumes that any HC would stop in this manner rather than advance
to the zero-length TD atomically after previous TD completion and stop
normally in the zero-length TD. So not sure if it's a real problem and
the condition seems hard to trigger for testing purposes.)


Control URBs have the same problem - FSE isn't handled very well and
old HCs would seem to need IOC on the data stage to ensure correct
actual length of cancelled URBs, if anyone cares.

Regards,
Michal

