Return-Path: <linux-kernel+bounces-771553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29AB288B7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9861D05AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C232D3747;
	Fri, 15 Aug 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="kFzDibt/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B7277C8F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300390; cv=none; b=RbZYElW5iOns5N5QBSJv7irmAW2Mnl+tGKx2+wEDpZ48pkjF4keTdK5j0iyfiMwEUpYgPDbXXfZH5yK8S2hLlfLEwN7Jlx6PeBtE1xuEiK/COpSP+73f+NZ+u88OblruJOZ/gw+RH2JTBsJaI+2+pVvQ8etpMg0MHKpEcqWSDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300390; c=relaxed/simple;
	bh=Chu5jY4XwBGOtUKref48cfAFeJ2FGjTr+yJjhVQVaEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbSqEmD0IBroAZTKjsEOgRSeh8UkBUzDoWH6upiG3KxTh4PYvvnaoKfqsv1t5souqC/h0KM9kRbkfh88NrS9euRHzN3TJjxpPIl4NjGNLQnKQr1IGATykiORNjGX6v8sH1DCr05U74k04I8IJxQGN693EHAEbSZkWmqwb3r+5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=kFzDibt/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso15953595e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755300387; x=1755905187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XodyE2rBD9AQIrlVLOswdFyZomcRJ3PmmM1np+C7GNM=;
        b=kFzDibt/HLMNUgo6QkVoTdtColdVYNpx/FsWFkFcqJBtyOcHjiKjxEIAU95PdFdOQ7
         JkAiA7Ra+ErTaRxtoRO8DY8wkOx16P7q58ozasvGXof3Di27tNYrfHAjMp3vVPpBcEZt
         8hTB7Uck6YOpoQ0r9pjEwyBN+wLXP0lL5xXXBFfxR4EyQ2NU5uQ5PUVtOBWstAK1dklA
         G3N3AXbTW2BXxNiFX9XXhBSQiWrJNh8mbEP+3MVVUVl+5yQySWzHmUi7DwVlgk11DPqz
         s7/5uU8D2jHgIsD/2cj9lKLfAhqxfd/IzfsGmBKr/VRhf28tjZWuHT1Ldx/rqw5aiCR0
         FP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755300387; x=1755905187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XodyE2rBD9AQIrlVLOswdFyZomcRJ3PmmM1np+C7GNM=;
        b=fyee609WZofgS2p3AOJttC8M2rj+ATArpuZXspNiHdY9YOPhafjmDQgsrE6EKhFc4T
         1FepVEu6ybiPNv1Q1kAaFhwF/Mjc8yelV9sa82mchZhEkoANY8CKAEAoeZBXWGUoLgCB
         YoFY8eXIPajsC8ywYA0B5DgRmmdpDSKYjNFuxNnINbgMwgLeODGw1lNtN1DrqASLUrWE
         tAIOU/Fv3w90OLR2vVrCWtPpW+2asLVpajnGxLdM6YhJeR/uZpRPjvuIhgvIhc3X7Rk/
         efG2umWvaQ35GvEWQbMGBISkCqZkVVd0X2cEt11xwrwrLKeYCOLdT9cdL8jCy/cApC3A
         N2+w==
X-Forwarded-Encrypted: i=1; AJvYcCX7jB2AEJlSYDniV8QnTnr5cxPKKKtEZEHq0LrGWC24GGndhNgGjEHboGYPB73IPCzpu9cZmcPmzeUfJRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxT5irsikFptXyqnsG7V5bJdaXkMYSo0FkqsAHLQ+vzmFSIUP
	l0mrNIadjWWdqOuTNZkGOwUHiKRM5GHVzen0sGjtekv6c1ACYdqvc6F4k9dCDHsefMw=
X-Gm-Gg: ASbGncsurqERh1BYwXYEpXLtm/CrdHy/9jueeyS7fceSLoWGM0+7ssdili2AJDsOoUC
	/ax1e9cGPW5xarI70gn6+j0S5RtPxw/RoT9aLxs9bPHXBn6WdMdmYZwg1YKddqqXl4mv06dwjxN
	11+e2Lc0nIr2fzninIeyR7CH4pIah/kNZ4DrPLBSoZXrudSnW1xgEv5PuZY76V9dyd8aEOebiPP
	hwmjsLtAjx5pBBlEg0hSXIwWLdrlXdNWTzBKVjKYuaPtZABrNhMECYdrbIwG2C9bnjPGpgN795I
	vycDWy0gNFD1R02xDOh1mDV368vDrVBFlZUhMPv4dgcZMGCGa1TCBI+wC/oDr3WRhdaKuALo4ZD
	RoZ2pDX494WiQlKD2fgR5G1MrbKC+jRHYxXcBwHnFt7yane+Y9Jtzy4/HMmdjB2RoFPAgAjhU9d
	Y=
X-Google-Smtp-Source: AGHT+IEUw3zyjHs7A3o84CjZmCBIXrtGPiI7xpmvJa8soDqcv+k+oPCPqsIgrIQJa5kxdLcLHyUc1Q==
X-Received: by 2002:a05:600c:4fd3:b0:456:1bca:7faf with SMTP id 5b1f17b1804b1-45a21847306mr39146655e9.16.1755300386881;
        Fri, 15 Aug 2025 16:26:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a23e97ca9sm29377105e9.2.2025.08.15.16.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 16:26:26 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:26:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Rob Landley <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Message-ID: <20250815162620.17b2fc4b@hermes.local>
In-Reply-To: <20250815194806.1202589-4-contact@artur-rojek.eu>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
	<20250815194806.1202589-4-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 21:48:06 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> +	struct {
> +		int packets;
> +		int bytes;
> +		int dropped;
> +		int crc_errors;
> +	} stats = {};

You don't want signed integer here.
Probably u32 or u64.

