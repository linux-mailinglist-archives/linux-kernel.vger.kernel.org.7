Return-Path: <linux-kernel+bounces-845813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2ABC62DB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5BF19E0AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7AD2BE7C0;
	Wed,  8 Oct 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="MLV+20+w"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8C257437
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759945841; cv=none; b=rq8D4SnP+XkuZryH3Lo0MjL21C5PAeV9cY5xjHd2kxKdiby0mITz/BEpt7Z4JfWx0EB82VsLoxWcibAt//AXLd8BND7jDvuJLo+T0vZqHEyFqi83J2f3NvqXjcGOXncydWnyg0WpajTOhWW2uKQDHmhvMfIni313Q+81cSiweQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759945841; c=relaxed/simple;
	bh=ta1HA85w2K/o1HGvXWAM9+/IhcjZhzmQno4Y2Uxu/Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXcPwaevlDkpBuPeDNCxHOA99OTXIL3vVWD9aH2g6USzRugAzNFqRADsiaHOYJ8vRkURKoL+hJB6dKeawVusyapp5wNC9vOFNJGUIhc+Fpt/zkwn407pH/L0a6RU8Zy97KfAMgS2rwsCizw+NeqEXs3vmwvwLZFaH1VD8rZCYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=MLV+20+w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso758825e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1759945837; x=1760550637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta1HA85w2K/o1HGvXWAM9+/IhcjZhzmQno4Y2Uxu/Gg=;
        b=MLV+20+wQK6sMjDxdW53fsuiTfNUT9xKAJXaNocb3mho8jxnMxEKGspuOxu0K/GkmJ
         d6se/RXBq3Ailv8trIIqCRBaTE7SpBLJXyehf2BJ0fwfu+7NT6LRwAFl4T4ysc/tV5Cl
         4Fc2AAICKmmg93K87zbsfWeDQQ6nG1BjFzod3mo26Hby76K+lRQfFoFBSkONPjHWjq//
         qnhqEXHEFMV3lafCMpmCm21KXtplkCM6hQDrjlDifAyq5YLffaHGrXIYoNAVHlg8fizj
         wpQKRqI7cJYW+jtkNbRlqbrhhXLwZF1EYaLYuJ8dKtupO88OT/6vCElk8hxRaQ2rxpDR
         SkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759945837; x=1760550637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta1HA85w2K/o1HGvXWAM9+/IhcjZhzmQno4Y2Uxu/Gg=;
        b=N/SLJeKVPy2fusCNJJ8H57141RK4+9ithZGyFMJvlzIaQi1o88o1DB0ip0nsnjzZEm
         kthpHd/sIpZ7RKR9rFtuudFjnCV5kWMZ1d8s39XGC+IQIdM7pv5rNoCqVK7S7pjGwkqr
         K/mi7hahkajSiEE00U7nVQ+vW68HCpvBpZG8pRV9iWMuPwNv5bFoF62HfYMWyBWz7Cg/
         S/ceZ2zETo5mxzOjyX0al8+ho8mJ8iTr0L+RAlLvef/KpWYOIY2sRYOcKnefzgDLRs0L
         zQTmZiaw8TaCBuHGwyswyhjl2FDLB/vBxHSSicPlbAW6pzDrLFW/UnJDvE+iCd+5b1U6
         DEXA==
X-Forwarded-Encrypted: i=1; AJvYcCWcnd0Hj+LaxP8lrJj9WwFe1ifihfPBoivm8pM9cuRlkO79bcGN878+GyAWLww8ceSW3MOia/1tglVcMuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywad9A2C+M08fEE2o8C6vT+fT98U+jKR88FBsYtRkKbgKmL8Hr+
	GtPvoT3FbfJ1DTMLneCfBhqh7liMOXARfaa5ue+cLpGfnP5cxe/XgR/3uoSFKrxpkrQ=
X-Gm-Gg: ASbGncsed65lg5wd+qsMXUD9r72T+38LUfMdx/D3HwaTHDOfRVLXSsg5zkGYElqZC8h
	R60y/mq6nQN0cQIIwtRlcnekfo4cSq8hCVnW/TUVFxdr5DJI0wlSXoEoA8rme5Qj6B28Sjejoy2
	u9bt0oHJBi8laglKVbg871y8H7sWVWDjR0XUetCFL7EyjNqKcGi6F/uoVoAldFhJBA95p4rF46F
	kKwbKYEBAaqlW62NSezvRbA3vBVUFuYEgeobORazsXHbQru506SHwLKwwU8+KvLxYm+gP0j0wwn
	0++ENtIJ4SrUtBPlpMPgoPuWfRaFT40p5jUuyFMkJhbx70flZt6x+eOpbZqeeWiiuJ7yHEEnKbW
	pKnP285MM90gVyFAh586COGWYVT9LmoB89el1RL8eflDp9yHi+EvWGk4ZpssnBPIwPQ==
X-Google-Smtp-Source: AGHT+IESXSVxrF30Y1nc15WrKsGt0IGzfLOtD1UjZNMDB6QG0IIRSF7dJN0kGxrQHbIW3QPqLup/3g==
X-Received: by 2002:a05:600c:1d18:b0:45f:2869:c3b2 with SMTP id 5b1f17b1804b1-46fa9b1834dmr31842995e9.33.1759945837418;
        Wed, 08 Oct 2025 10:50:37 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:34ff:86e3:b660:6d50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9703sm31304812f8f.30.2025.10.08.10.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:50:37 -0700 (PDT)
From: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
To: conor@kernel.org
Cc: asmirnou@pinefeat.co.uk,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	hverkuil@xs4all.nl,
	jacopo.mondi@ideasonboard.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Wed,  8 Oct 2025 18:50:36 +0100
Message-Id: <20251008175036.8314-1-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007-obscure-thrower-1afcdb23c4b8@spud>
References: <20251007-obscure-thrower-1afcdb23c4b8@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 7 Oct 2025 21:47:29 +0100, Conor Dooley wrote:

> I acked v5, any reason for not applying it?
> https://lore.kernel.org/all/20251007-geologic-epidemic-2f667f232cf6@spud/#t

Yes, the dt-bindings patch can be applied.
The v6 series does not change anything in the dt-bindings patch - only
another patch in the series was updated, so v6 was sent.

Apologies - I wasn't aware that an acked patch could be omitted from
the new revision.

