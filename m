Return-Path: <linux-kernel+bounces-795940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FBAB3F9AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6EC3AC905
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD25B2EA46B;
	Tue,  2 Sep 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJXOdan2"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13E2E8B7A;
	Tue,  2 Sep 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804059; cv=none; b=QsjVNLoaEG1KBfP7JK7irxJf+gwzA2wBFKiHc0LPpnm5f8vrd3yW4ViX6bI5oZOm4L4RCHYfPY2YJa5PfdY4z75gt604KBzZleJDT5P03Aq/P8TvWv92QaQt0DcVrykh3wNYt0SAs2dLte8njnIRmtYoEf4wnmpxMrFieojG7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804059; c=relaxed/simple;
	bh=e00OUdT1mnCF6eVI0EFyPvJzgm4igqdrftik66PJbew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fivyX/CZzzGgIORJ4RVPzEXdRxXl9w58lOu0XMJK/CEkTWGnqePlu+gjPMtIKGLqXCDPa4QwXWjwUD3WeTFc9JMitfXNPk6Z1tDyPBdjuQmc1MTyIqePVz3qBFO3r7um01AbcPWmlXNhF04lRx7oEFo9gWHbTs1RG6DibrislEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJXOdan2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336d2b0ea8dso15912721fa.3;
        Tue, 02 Sep 2025 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756804055; x=1757408855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e00OUdT1mnCF6eVI0EFyPvJzgm4igqdrftik66PJbew=;
        b=nJXOdan2zSVgw+RnPfS+UEJuOLnbWtWKOtVCVZaERO8J4z2UOawQv/H2aFRmDyBIa7
         2gQ5lKn/3cmAncqyBKmhRhklS62/w2Jiihiko3hkU2Wcwi+VxUEm2JxZb0FhGSdm6ZzF
         ihE2UnQvRvZtlC5+D9bYnlH2OcbguxqKFGx3NyimCsHZ/u8qE9sTPq1T8xxmYEBUeccB
         zh8yIpPd/vntYNbLcT4syN4cgmdC2RVDVsef+K4HnjYv+i3VZOvAhd63cISvIN2zBixZ
         CMaogBADR+sSwLOkK50nGIdIJ+crMxv9B2oPJchAaN6zgq1Nw74kaKtAzqhQcL/1AKMv
         MrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804055; x=1757408855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e00OUdT1mnCF6eVI0EFyPvJzgm4igqdrftik66PJbew=;
        b=OKJu7TYc/qDnGiPRv8VxCLZZnY5/FlMvwQedMFDrtUyNU5wzCGbMO1iDwVIqWuQzD6
         EZDrHlqHbTFwR2T0xrc6a5iKe89o+HmNJiEtQ413Jy3ujsZiDGtMx+TE8WsT/Nk2GmZ4
         hsBaiZ9BkUHVIlvgso5DdkKCL8fGSAAUtef2vBTYGjLXqSobwzdAC9+6i5Hm4AvMFfc4
         HsRFw9BRXaDlTSSDN1QchbH2llwVKQLWwoZ85Q8hPqO7pe+9gP1K+fBoU0nEjFTr6lcK
         rx2K/eEa4dBPjpp4FsjmOvS+s+1c3QQaSaDXHTJ2ndTuQjyHAq7ndRZ845Vjmnk2t3eJ
         e1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUg80DoaubqnzuevdyQnH9s0n97vd/Bx/2uCtPzpgIiQsEfNQC8wHTnB02VhkikP0q3TzTF2sigMVnN@vger.kernel.org, AJvYcCUyBMxTRKNSXym3vuZmBf6gKlKGH+aeUcZHC2SrFkuwP0j9aWBLYH/V/UaHyEDOFF32YiTn08olTqaVANw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywcn5PPwJsEVyRM+F8NH+6+2laax16g9jBNHXh5Z5ynIVaHpae
	osmPcuko4XwT/XT5lSsbOd0aBtEvY1JavjZSBIfiP25AzTcSboh3ihIL
X-Gm-Gg: ASbGnct16LpJerS0Oe2SE8Yn1qX+6YOmgSQH9/4q4rSCMKvP+ZAKHUFA/rk55FFraRR
	W73zbK5IVgV7dL9WTmwAGwS1R6zKwg56+NA6m1/wI4H6+mcfW2ghAS0Y5V7pr6EECH81+uo8phg
	gphp+Os9TO+0B96N/1U5k63xxAePQL8OcE0QYBpiaBRWKXSgiL9zQ8SpEzmezyROLmOBMvi4PPN
	CHy0JYTD08uZxC7GMEaDSNACDdX4ZMsohVwm31o6HGExNKnwcVnb+5Ulh5Bdyt92NyU7bhpVgq6
	61m7vs1ZCyUAEXYYVgUDSRnJ64QSDd19ZBwNq7VslNyroGICAi1IG6AbD0sD2MQJeyCA2XaJ9lU
	B8PquNeRilhIp045NUEl02wBVRIM5Acnr76I=
X-Google-Smtp-Source: AGHT+IHD58ilwmPkhIhYFUWS4Wih4aWkYtPscZqFvQLCpLtyUtPO/FiEvUW/jiZcpPFZj0WebPje1g==
X-Received: by 2002:a05:651c:50e:b0:336:8267:c1fa with SMTP id 38308e7fff4ca-336ca9b696emr26732971fa.19.1756804055195;
        Tue, 02 Sep 2025 02:07:35 -0700 (PDT)
Received: from foxbook (bey208.neoplus.adsl.tpnet.pl. [83.28.36.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827a020dsm530210e87.118.2025.09.02.02.07.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Sep 2025 02:07:34 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:07:30 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: "David Wang" <00107082@163.com>
Cc: "Mathias Nyman" <mathias.nyman@linux.intel.com>,
 WeitaoWang-oc@zhaoxin.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, surenb@google.com, kent.overstreet@linux.dev
Subject: Re: [PATCH] usb: xhci: Fix xhci_free_virt_devices_depth_first()
Message-ID: <20250902110730.723a48a0.michal.pecio@gmail.com>
In-Reply-To: <20250902104630.6a9f088a.michal.pecio@gmail.com>
References: <20250829181354.4450-1-00107082@163.com>
	<20250830114828.3dd8ed56.michal.pecio@gmail.com>
	<5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
	<f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
	<20250902093017.13d6c666.michal.pecio@gmail.com>
	<446082a4.7dbe.199098cd654.Coremail.00107082@163.com>
	<20250902104630.6a9f088a.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Sep 2025 10:46:30 +0200, Micha=C5=82 Pecio wrote:
> On Tue, 2 Sep 2025 16:30:48 +0800 (CST), David Wang wrote:
> > About the change from "<" to "<=3D", I did not observe any difference o=
n my system. Is it because my system does not use up all slots? =20
>=20
> This too, you would need to fiddle with devices (or connect enough
> of them) to reach Slot ID 255 (probably the highest on most systems),
> depending on the xHCI controller and its ID allocation policy.

This made me wonder what those policies are. I'm too lazy for thorough
testing, but I plugged and unplugged the same device a few times.

Most HCs kept assigning ID 1, so they likely always pick the lowest.

My AMD chipset, two ASMedia USB 3.1 controllers and a Fresco FL1100
kept assigning sequentially increasing IDs, so I suppose I could pump
it up near the top, connect two high speed hubs and trigger this bug.

> But also as explained, this bug doesn't make things go boom just yet.
>=20
> Except if combined with your bug in an obscure edge case:
>=20
> 1. A high speed hub has slot ID HCS_MAX_SLOTS-1 and some TT children.
> 2. Another high speed hub has slot ID HCS_MAX_SLOTS.
> 3. We start with freeing the second hub.
> 4. The loop is entered and leaves vdev pointing at the first hub.
> 5. The first hub is freed instead of the second one.
> 6. Then its children are freed and UAF its tt_info.

