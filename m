Return-Path: <linux-kernel+bounces-735962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DC8B095F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B5EA439CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9322AE45;
	Thu, 17 Jul 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blDt1vi7"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC42248B4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785345; cv=none; b=R8+ILR5xbOKrs3NM2c9lJZhrEUzimbCFYPul0Wzee3Qq7mQetbNvyGdUOZk0NAVZKQDSVQT2pXK+99ZRw4WiriDNfqMzWud32cTCSgM6sp5RZCn+qNBNqya7Ogu70+xq074uq5pJXjNqdkipyHUaKCPX0qlxJ4xKAkxcl2Ye72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785345; c=relaxed/simple;
	bh=2xMBdTlhXfzMM0SdrIB74fjlsR0n6oCNNxlHrhduyss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMnLyS5BvHNiMinCMEtFcf1OfFrqRulTqLUZKZCn1wtBFetC7oisPgjm5Oi8qsNOJhke3zGLHa8rd2CUEOJkHidktA+3Y8ZxDM7hmLBapj9aedI0bE5KIiuoBAOYIrUpHAcfCuaMTv7u1ZKDlOPaiSPFKNBYXz1AdhXYHiODfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blDt1vi7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso889479f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752785342; x=1753390142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xMBdTlhXfzMM0SdrIB74fjlsR0n6oCNNxlHrhduyss=;
        b=blDt1vi7ufzPErqWMRCc1dQ6qsO9k92JpifIIFfaMS+Nsjd/yX2bTZxqK1egdLq1t5
         TJiS2bV9JO8PeSU1OSc10Me1Vxy/PpPR76Jbm5niUvsI5rhp2skP7S+rIlwwJODg7DMe
         0R7gJUuOWIn+BGxaviKWXAQQNC6Cap6i22jWY3XpUcrdjidlV6BfzGTVW4S3c1U5iUbJ
         Avbay1jJeRN32GRKN/DOzue2iezxQmGcGCI3k65ndXJ6o1uMoqExeCYS5dGILz6P1Aj+
         klE0XxGCkIOX7gJOuKCvKa9Fr4u5SEZ6bQyOLc9PtJtOMwzvlYwoiMC9C2XskPxvs4uZ
         bwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752785342; x=1753390142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xMBdTlhXfzMM0SdrIB74fjlsR0n6oCNNxlHrhduyss=;
        b=YG3p4fBDV9UnkS+iEuZAEYb73t2CwRXbz77Tbi7zCp5gK2aXtwlR8F5NMPrjnKapmo
         33VmUZo+22GRlQ970QMhlmezCila98MUe4alQbdfQTaRFnxR4v8uh3PpJQKfn1pobEg4
         XRWStHIwxI7kDuwRN8TRJmwG99mXWY/DnnBBbT4W/+bYTsN4koCgnOlIgk3MUzObxnda
         E6n1OZXwbKWuHPpJUAzE9d9FcZUO7f3KhFrpLzb3YSJbzJN6RTCwVtDlTdYRQQg6oYRl
         5qFe32AXO4MjoBslb+k3jpTDLnusVQzIjcsX9dHEiH4rGqkA689vuijjT2/0NeFah3zq
         dF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4GKzpdtBC82Y0GmInkcUHJm3BuJMl8GHD/vnsl3SlzYT78sQM4o3rRoZcUBNeGQeQcCi2DuAS9I64fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAWq+LmDrQxGteFXkFJfjqbqoxYBTiS78XmXKTOAUO4DcboJp
	UDvJx/6rO2U+SHk/QF8wbNNWIOhgJr9pYKUUx06G49uFAhIRpQ1vNpeUC9g9eB6er2qcaFwItWi
	q/aXZQ+w176FXjJfOSA3GPUeZC/46wF3Du1C1cGM8
X-Gm-Gg: ASbGnctSNHQWX9e3zdKCpphHOaj6WZIsvTlX0HjSZsiwMMt0A6z2EhJZwhFdaz1lnTE
	1ubugnwY1HM9z2tTStz0id3Li5fWiRskWBuxPY1h25pPcrgXPkp+0t6DRAY7etujOMKoa2OVxZx
	W9MQ9aW7bJ39xkv54gGUG8+DB1pVKebNdcCg1Y5fws8+26bhqM6BEJKlCdwTwvV51c4/xw50JDI
	irayINeFBDJO+pd0BX9W7HFmcIcFrBrA3NQ
X-Google-Smtp-Source: AGHT+IG05BHxfCcSFaBlSf3yYZ+2a8vJjQ7ych6EnDYjMasg/ewCwiiTU4UhqmEkjJjUqI3LOQONogEsmtcleMrfCqI=
X-Received: by 2002:a05:6000:1a8f:b0:3a3:7ba5:93a5 with SMTP id
 ffacd0b85a97d-3b613e779dcmr3366098f8f.26.1752785342299; Thu, 17 Jul 2025
 13:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717200805.3710473-1-bleung@chromium.org>
In-Reply-To: <20250717200805.3710473-1-bleung@chromium.org>
From: Jameson Thies <jthies@google.com>
Date: Thu, 17 Jul 2025 13:48:50 -0700
X-Gm-Features: Ac12FXxMH9xqu2BEZjRqYUrYnuH76YqERP6GzpUcLTWbpebRwCeOsLFOmwCxaos
Message-ID: <CAMFSARe3a+gtsMJzBjpn+1S6jQ3LStWprT599gSN8QxULVmjLA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: psy: Set current max to 100mA for BC
 1.2 and Default
To: Benson Leung <bleung@chromium.org>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	hansg@kernel.org, sebastian.reichel@collabora.com, 
	dmitry.baryshkov@oss.qualcomm.com, madhu.m@intel.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 1:08=E2=80=AFPM Benson Leung <bleung@chromium.org> =
wrote:
>
> ucsi_psy_get_current_max would return 0mA as the maximum current if
> UCSI detected a BC or a Default USB Power sporce.
>
> The comment in this function is true that we can't tell the difference
> between DCP/CDP or SDP chargers, but we can guarantee that at least 1-uni=
t
> of USB 1.1/2.0 power is available, which is 100mA, which is a better
> fallback value than 0, which causes some userspaces, including the Chrome=
OS
> power manager, to regard this as a power source that is not providing
> any power.
>
> In reality, 100mA is guaranteed from all sources in these classes.
>
> Signed-off-by: Benson Leung <bleung@chromium.org>

Reviewed-by: Jameson Thies <jthies@google.com>

